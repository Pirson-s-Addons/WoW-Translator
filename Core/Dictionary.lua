local ADDON_NAME, addonTable = ...

-- ==========================================
-- DICCIONARIO MAESTRO
-- ==========================================
-- Fusiona en unas pocas tablas todo lo que el motor necesita consultar: los
-- diccionarios propios de Data/ y las librerías Babble, según las categorías
-- activadas y la lista negra del jugador.
--
-- Las tablas se vacían y se rellenan SIEMPRE en el mismo sitio (wipe, nunca
-- reasignación) para que el resto de ficheros puedan quedarse una referencia
-- local al cargar y no pagar un índice extra en el bucle caliente del chat.

local MasterDict = {}         -- palabra suelta  -> traducción
local MultiWordPatterns = {}  -- frase           -> traducción
local MultiWordByFirst = {}   -- primera palabra -> { frases, la más larga primero }
local EntryColor = {}         -- clave -> color propio de la fuente (solo Babble)

addonTable.MasterDict = MasterDict
addonTable.MultiWordPatterns = MultiWordPatterns
addonTable.MultiWordByFirst = MultiWordByFirst
addonTable.EntryColor = EntryColor

-- Sube en cada reconstrucción. Core/Outgoing.lua lo compara con el suyo para
-- saber si su índice inverso se quedó obsoleto, sin depender del orden de carga.
addonTable.dictVersion = 0

local BZ, BI, BR -- tablas de consulta de Babble (Zonas, Sets, Razas)

local ipairs, pairs, wipe = ipairs, pairs, wipe
local string_find, string_lower, string_match = string.find, string.lower, string.match
local table_sort = table.sort

-- Babble traduce inglés -> GetLocale(), así que hay que cargarlo después de que
-- las librerías estén disponibles (PLAYER_LOGIN), no al cargar este fichero.
function addonTable.LoadBabbleSources()
    local function lookup(name)
        local lib = LibStub(name, true)
        return lib and lib:GetUnstrictLookupTable()
    end
    BZ = lookup("LibBabble-SubZone-3.0")
    BI = lookup("LibBabble-ItemSet-3.0")
    BR = lookup("LibBabble-Race-3.0")
end

-- Categoría de ajustes -> diccionario de Data/ que activa.
local CATEGORY_DICTS = {
    { key = "showMazz",             dict = "InstanciasCoreDict" },
    { key = "showInstClassic",      dict = "ClassicDict" },
    { key = "showInstTBC",          dict = "TBCDict" },
    { key = "showInstWotLK",        dict = "WotLKDict" },
    { key = "showInstCata",         dict = "CataDict" },
    { key = "showInstMoP",          dict = "MoPDict" },
    { key = "showInstWoD",          dict = "WoDDict" },
    { key = "showInstLegion",       dict = "LegionDict" },
    { key = "showInstBfA",          dict = "BfADict" },
    { key = "showInstShadowlands",  dict = "ShadowlandsDict" },
    { key = "showInstDragonflight", dict = "DragonflightDict" },
    { key = "showInstTheWarWithin", dict = "TheWarWithinDict" },
    { key = "showInstMidnight",     dict = "MidnightDict" },
    { key = "showSocial",           dict = "SocialDict" },
    { key = "showClases",           dict = "ClasesDict" },
    { key = "showCombate",          dict = "CombateDict" },
    { key = "showComercio",         dict = "ComercioDict" },
    { key = "showStats",            dict = "EstadisticasDict" },
    { key = "showGrupos",           dict = "GruposDict" },
    { key = "showHermandad",        dict = "HermandadDict" },
    { key = "showProfesiones",      dict = "ProfesionesDict" },
    { key = "showRoles",            dict = "RolesDict" },
    { key = "showEstado",           dict = "EstadoDict" },
}

function addonTable.RebuildMasterDict()
    wipe(MasterDict)
    wipe(MultiWordPatterns)
    wipe(MultiWordByFirst)
    wipe(EntryColor)

    local settings = WoWTranslatorDB.settings
    local target = WoWTranslatorDB.targetLocale or "esES"
    -- Lista negra del jugador (UI/IgnoreList.lua): se filtra aquí, al construir,
    -- y no en cada mensaje — el motor ni se entera de que esas palabras existen.
    local ignored = WoWTranslatorDB.ignored or {}

    -- 1. DICCIONARIOS PROPIOS (Data/)
    for _, entry in ipairs(CATEGORY_DICTS) do
        local dict = addonTable[entry.dict]
        if dict and settings[entry.key] then
            for term, translations in pairs(dict) do
                local key = string_lower(term)
                if not ignored[key] then
                    local translation = translations[target] or translations["esES"] or term
                    -- Una entrada que se traduce a sí misma no aporta nada y solo
                    -- ensucia el chat con "need(Need)". Pasa sobre todo con el
                    -- inglés como destino, donde el diccionario sigue siendo útil
                    -- para expandir acrónimos ("icc" -> "Icecrown Citadel") pero
                    -- 81 términos ya están escritos en inglés.
                    if string_lower(translation) ~= key then
                        if string_find(term, " ", 1, true) then
                            if not MultiWordPatterns[key] then MultiWordPatterns[key] = translation end
                        else
                            MasterDict[key] = translation
                        end
                    end
                end
            end
        end
    end

    -- 2. FUENTES BABBLE (nombres oficiales de Blizzard ya localizados)
    -- Se fusionan en las mismas tablas en vez de recorrerse aparte en cada
    -- mensaje. Los diccionarios propios ganan si una clave está en ambos lados.
    local babbleSources = {
        { data = BZ, color = "ffffd1", active = settings.showZones },
        { data = BI, color = "a335ee", active = settings.showSets },
        { data = BR, color = "69ccf0", active = settings.showRaces },
    }

    for _, src in ipairs(babbleSources) do
        if src.data and src.active then
            for eng, localized in pairs(src.data) do
                -- localized ~= eng descarta lo que no traduce nada: en un cliente
                -- inglés Babble devuelve el mismo texto y solo ensuciaría el chat
                -- con "Stormwind(Stormwind)".
                if #eng > 3 and localized ~= eng then
                    local key = string_lower(eng)
                    if not ignored[key] then
                        if string_find(eng, " ", 1, true) then
                            if not MultiWordPatterns[key] then
                                MultiWordPatterns[key] = localized
                                EntryColor[key] = src.color
                            end
                        elseif not MasterDict[key] then
                            MasterDict[key] = localized
                            EntryColor[key] = src.color
                        end
                    end
                end
            end
        end
    end

    -- 3. ÍNDICE DE FRASES POR SU PRIMERA PALABRA
    -- Sin esto, traducir un mensaje costaba recorrer las ~5.400 frases enteras.
    -- Ahora solo se prueban las del bucket de cada palabra del mensaje. Dentro
    -- del bucket, las más largas primero: una frase larga debe ganar a la corta
    -- que contiene.
    for phrase in pairs(MultiWordPatterns) do
        local first = string_match(phrase, "[%w']+")
        if first then
            local bucket = MultiWordByFirst[first]
            if not bucket then
                bucket = {}
                MultiWordByFirst[first] = bucket
            end
            bucket[#bucket + 1] = phrase
        end
    end
    for _, bucket in pairs(MultiWordByFirst) do
        table_sort(bucket, function(a, b) return #a > #b end)
    end

    addonTable.dictVersion = addonTable.dictVersion + 1
end
