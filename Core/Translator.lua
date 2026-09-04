local ADDON_NAME, addonTable = ...

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

local ipairs = ipairs
local string_find, string_format, string_gmatch = string.find, string.format, string.gmatch
local string_gsub, string_lower = string.gsub, string.lower

-- "icc hc" -> "[Ii][Cc][Cc] [Hh][Cc]", para casar sin importar mayúsculas sin
-- tener que minusculizar el texto que se va a devolver.
local function CaseInsensitivePattern(phrase)
    local body = string_gsub(phrase, "%a",
        function(c) return string_format("[%s%s]", string_lower(c), c:upper()) end)
    return "%f[%w]" .. body .. "%f[%W]"
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

    return text, changed
end

-- La usa también Core/Outgoing.lua para el sentido contrario.
addonTable.CaseInsensitivePattern = CaseInsensitivePattern
