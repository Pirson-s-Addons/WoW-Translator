local ADDON_NAME, addonTable = ...
addonTable = addonTable or WoWTranslatorNS -- clientes < 3.0 no pasan argumentos

-- ==========================================
-- API PUBLICA (solo lectura)
-- ==========================================
-- Para otros addons (p. ej. Azeroth AI, que explica la jerga del chat): el
-- diccionario de jerga, abreviaturas y nombres de mazmorra de Data/, en
-- cualquiera de sus idiomas. Lee los diccionarios completos, no lo que el
-- jugador tiene activado en las opciones (eso solo afecta a su chat).
--
-- version solo sube si cambia el significado de algo ya existente; anadir
-- funciones o campos no la sube.
--
--   local api = WoWTranslatorAPI
--   if api and api.version == 1 then
--       local text = api.Lookup("lfm")  -- "Buscando más" en un cliente esES
--   end

local string_lower, string_find = string.lower, string.find

-- esMX y enGB no siempre tienen columna propia: caen en esES / enUS
local FALLBACK = { esMX = "esES", enGB = "enUS" }

local function Locale(locale)
    return locale or GetLocale()
end

local function Pick(translations, locale)
    return translations[locale] or translations[FALLBACK[locale] or ""] or translations.enUS
end

-- Busca el termino tal cual y en minusculas: las claves de Data/ estan escritas a mano
local function Find(term)
    local lower = string_lower(term)
    for _, entry in ipairs(addonTable.CATEGORY_DICTS) do
        local dict = addonTable[entry.dict]
        if dict then
            local translations = dict[term] or dict[lower]
            if translations then return translations, entry.dict end
        end
    end
    -- Las claves de Data/ no siempre van en minusculas: ultimo intento, recorriendo
    for _, entry in ipairs(addonTable.CATEGORY_DICTS) do
        local dict = addonTable[entry.dict]
        for key, translations in pairs(dict or {}) do
            if string_lower(key) == lower then return translations, entry.dict end
        end
    end
    return nil
end

WoWTranslatorAPI = {
    version = 1,

    -- Traduccion de un termino de jerga ("lfm", "ty", "icc hc"...) al idioma
    -- pedido (por defecto el del cliente): texto, categoria; nil si no existe.
    -- categoria = nombre del diccionario de Data/ ("SocialDict", "GruposDict"...)
    Lookup = function(term, locale)
        if type(term) ~= "string" or term == "" then return nil end
        local translations, category = Find(term)
        if not translations then return nil end
        return Pick(translations, Locale(locale)), category
    end,

    -- Todas las traducciones de un termino: { esES = ..., enUS = ..., ... } (copia), o nil
    GetTranslations = function(term)
        if type(term) ~= "string" or term == "" then return nil end
        local translations = Find(term)
        if not translations then return nil end
        local out = {}
        for locale, text in pairs(translations) do out[locale] = text end
        return out
    end,

    -- Terminos conocidos para reconocerlos en un texto: { { term, category, multiword }, ... }.
    -- category opcional limita a un diccionario. Es una lista grande: guardarla, no pedirla a cada rato.
    GetTerms = function(category)
        local out = {}
        for _, entry in ipairs(addonTable.CATEGORY_DICTS) do
            if not category or category == entry.dict then
                for term in pairs(addonTable[entry.dict] or {}) do
                    out[#out + 1] = { term = term, category = entry.dict,
                        multiword = string_find(term, " ", 1, true) ~= nil }
                end
            end
        end
        return out
    end,

    -- Nombres de los diccionarios de Data/ (categorias de GetTerms)
    GetCategories = function()
        local out = {}
        for i, entry in ipairs(addonTable.CATEGORY_DICTS) do out[i] = entry.dict end
        return out
    end,
}
