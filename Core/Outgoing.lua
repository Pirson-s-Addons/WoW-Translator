local ADDON_NAME, addonTable = ...

-- ==========================================
-- MOTOR INVERSO (redactar en inglés)
-- ==========================================
-- Al revés que Core/Translator.lua: SUSTITUYE el término del idioma destino por
-- su original inglés en vez de anotarlo, porque el resultado va a la caja de
-- chat para que lo envíe el jugador.
--
-- El índice se construye la primera vez que se usa /wt en: son otras ~5.800
-- entradas de memoria y la mayoría de jugadores no redactará nunca en inglés.

local MasterDict = addonTable.MasterDict
local MultiWordPatterns = addonTable.MultiWordPatterns

local ipairs, pairs = ipairs, pairs
local string_find, string_gmatch, string_gsub, string_lower, string_match =
    string.find, string.gmatch, string.gsub, string.lower, string.match
local table_sort = table.sort

-- Aquí el texto de entrada está en el idioma destino, así que viene lleno de
-- acentos. "[%a%d']+" no vale: %a solo casa letras ASCII y partiría "Potrzebuję"
-- en "Potrzebuj" + "", dejando la palabra sin encontrar. Los bytes altos son
-- siempre continuación de un carácter UTF-8, así que entran en la clase.
local WORD = "[%w'\128-\255]+"

local ReverseDict = {}    -- traducción -> término original
local ReverseByFirst = {} -- primera palabra -> { traducciones de varias palabras }
local builtVersion        -- versión del diccionario con la que se construyó

local function Build()
    wipe(ReverseDict)
    wipe(ReverseByFirst)

    -- Ojo: el número de palabras cambia de sentido respecto al motor normal. Un
    -- término de una palabra puede traducirse por varias ("wipe" -> "Muerte
    -- total") y al revés, así que aquí manda la traducción, no el original.
    local function add(translation, source)
        local key = string_lower(translation)
        local current = ReverseDict[key]
        if current then
            -- Varios originales caen en la misma traducción ("tank" y "tanks" ->
            -- "Tanque"). pairs() no tiene orden estable, así que sin un criterio
            -- explícito /wt en devolvería uno u otro según la sesión: gana el
            -- más corto y, a igualdad, el primero alfabéticamente.
            if #current < #source or (#current == #source and current <= source) then return end
            ReverseDict[key] = source -- la clave ya está en su bucket, solo cambia el destino
            return
        end

        ReverseDict[key] = source
        if string_find(key, " ", 1, true) then
            local first = string_match(key, WORD)
            if first then
                local bucket = ReverseByFirst[first]
                if not bucket then
                    bucket = {}
                    ReverseByFirst[first] = bucket
                end
                bucket[#bucket + 1] = key
            end
        end
    end

    for source, translation in pairs(MasterDict) do add(translation, source) end
    for source, translation in pairs(MultiWordPatterns) do add(translation, source) end

    for _, bucket in pairs(ReverseByFirst) do
        table_sort(bucket, function(a, b) return #a > #b end)
    end

    builtVersion = addonTable.dictVersion
end

function addonTable.TranslateOutgoing(text)
    if builtVersion ~= addonTable.dictVersion then Build() end

    local changed = false
    local textLower = string_lower(text)
    local seen = {}

    for word in string_gmatch(textLower, WORD) do
        local bucket = ReverseByFirst[word]
        if bucket and not seen[word] then
            seen[word] = true
            for _, phrase in ipairs(bucket) do
                if string_find(textLower, phrase, 1, true) then
                    local source = ReverseDict[phrase]
                    local replaced
                    text, replaced = string_gsub(text, addonTable.CaseInsensitivePattern(phrase),
                        function() return source end)
                    if replaced > 0 then
                        changed = true
                        textLower = string_lower(text)
                    end
                end
            end
        end
    end

    text = string_gsub(text, "(" .. WORD .. ")", function(word)
        local source = ReverseDict[string_lower(word)]
        if not source then return word end
        changed = true
        return source
    end)

    return text, changed
end
