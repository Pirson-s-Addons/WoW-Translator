local ADDON_NAME, addonTable = ...
local L = addonTable.L

-- ==========================================
-- VISTAS: CATEGORÍAS Y EXPANSIONES
-- ==========================================
-- Qué se traduce. Son dos vistas porque son dos decisiones distintas: qué tipo
-- de jerga, y de qué expansiones se quieren los nombres de instancia.

function addonTable.CreateCategoriesUI(parentCategory)
    local panel = addonTable.CreateOptionsPanel("WoWTranslatorCategoriesPanel", L["OPT_CATEGORIES"])
    local y = addonTable.PanelHeading(panel, L["OPT_CATEGORIES"])

    y = addonTable.SectionHeader(panel, y, L["CAT_HEADER"])
    addonTable.SettingsCheckboxGrid(panel, {
        { text = L["CAT_MAZZ"],    key = "showMazz",        tt = L["TT_CAT_MAZZ"] },
        { text = L["CAT_SOCIAL"],  key = "showSocial",      tt = L["TT_CAT_SOCIAL"] },
        { text = L["CAT_CLASSES"], key = "showClases",      tt = L["TT_CAT_CLASSES"] },
        { text = L["CAT_ROLES"],   key = "showRoles",       tt = L["TT_CAT_ROLES"] },
        { text = L["CAT_STATS"],   key = "showStats",       tt = L["TT_CAT_STATS"] },
        { text = L["CAT_PROF"],    key = "showProfesiones", tt = L["TT_CAT_PROF"] },
        { text = L["CAT_COMBAT"],  key = "showCombate",     tt = L["TT_CAT_COMBAT"] },
        { text = L["CAT_TRADE"],   key = "showComercio",    tt = L["TT_CAT_TRADE"] },
        { text = L["CAT_GROUPS"],  key = "showGrupos",      tt = L["TT_CAT_GROUPS"] },
        { text = L["CAT_GUILD"],   key = "showHermandad",   tt = L["TT_CAT_GUILD"] },
        { text = L["CAT_STATUS"],  key = "showEstado",      tt = L["TT_CAT_STATUS"] },
        { text = L["CAT_ZONES"],   key = "showZones",       tt = L["TT_CAT_ZONES"] },
        { text = L["CAT_SETS"],    key = "showSets",        tt = L["TT_CAT_SETS"] },
        { text = L["CAT_RACES"],   key = "showRaces",       tt = L["TT_CAT_RACES"] },
        { text = L["CAT_LFG"],     key = "showLFG",         tt = L["TT_CAT_LFG"] },
    }, y, "WT_CB_")

    Settings.RegisterCanvasLayoutSubcategory(parentCategory, panel, panel.name)
end

function addonTable.CreateExpansionsUI(parentCategory)
    local panel = addonTable.CreateOptionsPanel("WoWTranslatorExpansionsPanel", L["OPT_EXPANSIONS"])
    local y = addonTable.PanelHeading(panel, L["OPT_EXPANSIONS"])

    y = addonTable.SectionHeader(panel, y, L["EXP_HEADER"])
    -- Los nombres de expansión son marcas de Blizzard: no se traducen.
    addonTable.SettingsCheckboxGrid(panel, {
        { text = "Classic",                key = "showInstClassic" },
        { text = "Burning Crusade",        key = "showInstTBC" },
        { text = "Wrath of the Lich King", key = "showInstWotLK" },
        { text = "Cataclysm",              key = "showInstCata" },
        { text = "Mists of Pandaria",      key = "showInstMoP" },
        { text = "Warlords of Draenor",    key = "showInstWoD" },
        { text = "Legion",                 key = "showInstLegion" },
        { text = "Battle for Azeroth",     key = "showInstBfA" },
        { text = "Shadowlands",            key = "showInstShadowlands" },
        { text = "Dragonflight",           key = "showInstDragonflight" },
        { text = "The War Within",         key = "showInstTheWarWithin" },
        { text = "Midnight",               key = "showInstMidnight" },
    }, y, "WT_EXP_CB_")

    Settings.RegisterCanvasLayoutSubcategory(parentCategory, panel, panel.name)
end
