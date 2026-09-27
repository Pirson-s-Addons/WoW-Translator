local ADDON_NAME, addonTable = ...
addonTable = addonTable or WoWTranslatorNS -- clientes < 3.0 no pasan argumentos

-- ==========================================
-- MOTOR DE TRADUCCIÓN (mensajes entrantes)
-- ==========================================
-- Anota: deja el término original y le añade la traducción entre paréntesis.
-- Es el camino caliente del addon — corre por cada mensaje de chat y por cada
-- tooltip del Buscador de grupos — así que evita todo lo que pueda evitar.

-- Core/Dictionary.lua vacía y rellena estas tablas sin reasignarlas nunca, así
-- que quedarse la referencia aquí es válido para toda la sesión.
local MasterDict = addonTable.MasterDict
local MultiWordPatterns = addonTable.MultiWordPatterns
local MultiWordByFirst = addonTable.MultiWordByFirst
local EntryColor = addonTable.EntryColor
local NativeByFirst = addonTable.NativeByFirst

local ipairs = ipairs
local string_byte, string_find, string_format, string_gmatch = string.byte, string.find, string.format, string.gmatch
local string_gsub, string_lower, string_match, string_sub = string.gsub, string.lower, string.match, string.sub
local table_concat = table.concat

-- "icc hc" -> "[Ii][Cc][Cc] [Hh][Cc]", para casar sin importar mayúsculas sin
-- tener que minusculizar el texto que se va a devolver.
local function CaseInsensitivePattern(phrase)
    local body = string_gsub(phrase, "%a",
        function(c) return string_format("[%s%s]", string_lower(c), c:upper()) end)
    return "%f[%w]" .. body .. "%f[%W]"
end

-- Byte que no es parte de un carácter no ASCII (o fuera del texto).
local function IsBoundary(text, pos)
    local b = string_byte(text, pos)
    return not b or b < 128
end

-- Jerga en coreano o chino (Data/Origen/). Recorre el texto carácter a carácter
-- y en cada uno prueba los términos que empiezan por él, el más largo primero.
-- Lo ya anotado (|c...|r) y los enlaces (|H...|h...|h) se copian sin mirar: ni
-- se traduce una traducción ni se rompe un enlace de objeto.
local function TranslateNative(text, userColor)
    local out, n, i, len = {}, 0, 1, #text
    local changed = false
    while i <= len do
        local b = string_byte(text, i)
        local stop, piece = i, nil
        if b == 124 then -- "|"
            local nextChar = string_sub(text, i + 1, i + 1)
            local _, e
            if nextChar == "c" then
                _, e = string_find(text, "|r", i + 2, true)
            elseif nextChar == "H" then
                _, e = string_find(text, "|h.-|h", i + 2)
            end
            stop = e or i
        elseif b >= 192 then
            local char = string_match(text, "^[\192-\255][\128-\191]*", i)
            stop = i + #char - 1
            local bucket = NativeByFirst[char]
            if bucket then
                for _, entry in ipairs(bucket) do
                    local last = i + #entry.term - 1
                    if string_sub(text, i, last) == entry.term
                        and (not entry.single or (IsBoundary(text, i - 1) and IsBoundary(text, last + 1))) then
                        piece = entry.term .. "(|cff" .. userColor .. entry.translation .. "|r)"
                        stop = last
                        changed = true
                        break
                    end
                end
            end
        end
        n = n + 1
        out[n] = piece or string_sub(text, i, stop)
        i = stop + 1
    end
    if not changed then return text, false end
    return table_concat(out), true
end

_G.TranslateChat = function(text)
    if not text or not WoWTranslatorDB or not WoWTranslatorDB.enabled then return text, false end

    local changed = false
    local userColor = WoWTranslatorDB.chatColor or "00ff00"
    local textLower = string_lower(text)

    -- 1. FRASES MULTI-PALABRA
    -- Se recorren las palabras del mensaje y solo se prueban las frases cuya
    -- primera palabra aparece en él. gmatch fija la cadena original al empezar,
    -- así que reasignar textLower dentro del bucle no altera la iteración.
    local seen = {}
    for word in string_gmatch(textLower, "[%w']+") do
        local bucket = MultiWordByFirst[word]
        if bucket and not seen[word] then
            seen[word] = true -- una palabra repetida traduciría dos veces la misma frase
            for _, phrase in ipairs(bucket) do
                if string_find(textLower, phrase, 1, true) then
                    local prefix = "(|cff" .. (EntryColor[phrase] or userColor)
                    local replaced
                    text, replaced = string_gsub(text, CaseInsensitivePattern(phrase), function(found)
                        return found .. prefix .. MultiWordPatterns[phrase] .. "|r)"
                    end)
                    if replaced > 0 then
                        changed = true
                        textLower = string_lower(text)
                    end
                end
            end
        end
    end

    -- 2. PALABRAS SUELTAS
    text = string_gsub(text, "([%a%d']+)", function(word)
        local translation = MasterDict[string_lower(word)]
        if not translation then return word end
        changed = true
        return word .. "(|cff" .. (EntryColor[string_lower(word)] or userColor) .. translation .. "|r)"
    end)

    -- 3. JERGA EN OTROS IDIOMAS: solo si hay alguno activado y el mensaje trae
    -- algo que no sea ASCII, para que el chat en inglés no pague nada.
    if addonTable.hasNative and string_find(text, "[\192-\255]") then
        local nativeChanged
        text, nativeChanged = TranslateNative(text, userColor)
        changed = changed or nativeChanged
    end

    return text, changed
end

-- La usa también Core/Outgoing.lua para el sentido contrario.
addonTable.CaseInsensitivePattern = CaseInsensitivePattern
