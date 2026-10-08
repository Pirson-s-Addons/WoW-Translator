local ADDON_NAME, addonTable = ...
addonTable = addonTable or WoWTranslatorNS -- clientes < 3.0 no pasan argumentos
local L = addonTable.L
local IconLabel = addonTable.IconLabel

-- Icono propio de cada expansión (img/exp/, generado con
-- _project/tools/wowtranslator_exp_icons.py) delante de su nombre.
local function ExpLabel(icon, name)
    return IconLabel("Interface\\AddOns\\WoWTranslator\\img\\exp\\" .. icon, name)
end

-- Iconos del juego para las categorías: todos existen desde vanilla, así que
-- se ven igual en 2.4.3, en Forever y en Retail.
local function CatLabel(icon, text)
    return IconLabel("Interface\\Icons\\" .. icon, text)
end

-- ==========================================
-- VISTAS: CATEGORÍAS Y EXPANSIONES
-- ==========================================
-- Qué se traduce. Son dos vistas porque son dos decisiones distintas: qué tipo
-- de jerga, y de qué expansiones se quieren los nombres de instancia.

function addonTable.CreateCategoriesUI(parentCategory)
    local panel = addonTable.CreateOptionsPanel("WoWTranslatorCategoriesPanel", L["OPT_CATEGORIES"])
    local y = addonTable.PanelHeading(panel, L["OPT_CATEGORIES"])

    y = addonTable.SectionHeader(panel, y, L["CAT_HEADER"])
    local _, checkboxes = addonTable.SettingsCheckboxGrid(panel, {
        { text = CatLabel("INV_Misc_Head_Dragon_01", L["CAT_MAZZ"]),         key = "showMazz",        tt = L["TT_CAT_MAZZ"] },
        { text = CatLabel("INV_Misc_Note_01", L["CAT_SOCIAL"]),              key = "showSocial",      tt = L["TT_CAT_SOCIAL"] },
        { text = CatLabel("Ability_DualWield", L["CAT_CLASSES"]),            key = "showClases",      tt = L["TT_CAT_CLASSES"] },
        { text = CatLabel("Ability_Warrior_DefensiveStance", L["CAT_ROLES"]), key = "showRoles",      tt = L["TT_CAT_ROLES"] },
        { text = CatLabel("Spell_Holy_MagicalSentry", L["CAT_STATS"]),       key = "showStats",       tt = L["TT_CAT_STATS"] },
        { text = CatLabel("Trade_Engineering", L["CAT_PROF"]),               key = "showProfesiones", tt = L["TT_CAT_PROF"] },
        { text = CatLabel("INV_Sword_04", L["CAT_COMBAT"]),                  key = "showCombate",     tt = L["TT_CAT_COMBAT"] },
        { text = CatLabel("INV_Misc_Coin_01", L["CAT_TRADE"]),               key = "showComercio",    tt = L["TT_CAT_TRADE"] },
        { text = CatLabel("INV_Misc_GroupNeedMore", L["CAT_GROUPS"]),        key = "showGrupos",      tt = L["TT_CAT_GROUPS"] },
        { text = CatLabel("INV_Shirt_GuildTabard_01", L["CAT_GUILD"]),       key = "showHermandad",   tt = L["TT_CAT_GUILD"] },
        { text = CatLabel("Spell_Nature_Sleep", L["CAT_STATUS"]),            key = "showEstado",      tt = L["TT_CAT_STATUS"] },
        { text = CatLabel("INV_Misc_Map_01", L["CAT_ZONES"]),                key = "showZones",       tt = L["TT_CAT_ZONES"] },
        { text = CatLabel("INV_Chest_Plate03", L["CAT_SETS"]),               key = "showSets",        tt = L["TT_CAT_SETS"] },
        { text = CatLabel("INV_Misc_Head_Human_01", L["CAT_RACES"]),         key = "showRaces",       tt = L["TT_CAT_RACES"] },
    }, y, "WT_CB_")
    addonTable.BulkButtons(panel, y + 26, checkboxes, addonTable.RebuildMasterDict)

    addonTable.RegisterSubcategory(parentCategory, panel)
end

function addonTable.CreateExpansionsUI(parentCategory)
    local panel = addonTable.CreateOptionsPanel("WoWTranslatorExpansionsPanel", L["OPT_EXPANSIONS"])
    local y = addonTable.PanelHeading(panel, L["OPT_EXPANSIONS"])

    y = addonTable.SectionHeader(panel, y, L["EXP_HEADER"])
    -- Los nombres de expansión son marcas de Blizzard: no se traducen.
    local tt = L["TT_EXP"]
    local _, checkboxes = addonTable.SettingsCheckboxGrid(panel, {
        { text = ExpLabel("classic", "Classic"),              key = "showInstClassic",      tt = tt },
        { text = ExpLabel("tbc", "Burning Crusade"),          key = "showInstTBC",          tt = tt },
        { text = ExpLabel("wotlk", "Wrath of the Lich King"), key = "showInstWotLK",        tt = tt },
        { text = ExpLabel("cata", "Cataclysm"),               key = "showInstCata",         tt = tt },
        { text = ExpLabel("mop", "Mists of Pandaria"),        key = "showInstMoP",          tt = tt },
        { text = ExpLabel("wod", "Warlords of Draenor"),      key = "showInstWoD",          tt = tt },
        { text = ExpLabel("legion", "Legion"),                key = "showInstLegion",       tt = tt },
        { text = ExpLabel("bfa", "Battle for Azeroth"),       key = "showInstBfA",          tt = tt },
        { text = ExpLabel("shadowlands", "Shadowlands"),      key = "showInstShadowlands",  tt = tt },
        { text = ExpLabel("dragonflight", "Dragonflight"),    key = "showInstDragonflight", tt = tt },
        { text = ExpLabel("tww", "The War Within"),           key = "showInstTheWarWithin", tt = tt },
        { text = ExpLabel("midnight", "Midnight"),            key = "showInstMidnight",     tt = tt },
        { text = ExpLabel("forever", "Forever"),              key = "showInstForever",      tt = tt },
    }, y, "WT_EXP_CB_")
    addonTable.BulkButtons(panel, y + 26, checkboxes, addonTable.RebuildMasterDict)

    addonTable.RegisterSubcategory(parentCategory, panel)
end
