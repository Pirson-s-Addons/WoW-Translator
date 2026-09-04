local ADDON_NAME, addonTable = ...
local L = addonTable.L

-- ==========================================
-- ARRANQUE
-- ==========================================
-- Único fichero que sabe en qué orden se monta todo. Carga el último.

local DEFAULT_SETTINGS = {
    showMazz = true,
    showInstClassic = true,
    showInstTBC = true,
    showInstWotLK = true,
    showInstCata = true,
    showInstMoP = true,
    showInstWoD = true,
    showInstLegion = true,
    showInstBfA = true,
    showInstShadowlands = true,
    showInstDragonflight = true,
    showInstTheWarWithin = true,
    showInstMidnight = true,
    showSocial = true,
    showClases = true,
    showCombate = true,
    showComercio = true,
    showStats = true,
    showGrupos = true,
    showHermandad = true,
    showProfesiones = true,
    showRoles = true,
    showEstado = true,
    showZones = true,
    showSets = true,
    showRaces = true,
    showLFG = true,
}

-- Rellena lo que falte sin pisar lo que el jugador ya tenga elegido. Sirve tanto
-- para una instalación limpia como para actualizar desde una versión anterior:
-- un ajuste nuevo aparece activado y los viejos se respetan.
local function PrepareDatabase()
    WoWTranslatorDB = WoWTranslatorDB or {}
    local db = WoWTranslatorDB

    if db.enabled == nil then db.enabled = true end
    db.targetLocale = db.targetLocale or "esES"
    db.chatColor = db.chatColor or "00ff00"
    db.ignored = db.ignored or {}
    db.settings = db.settings or {}
    db.settings.channels = db.settings.channels or {}

    for key, value in pairs(DEFAULT_SETTINGS) do
        if db.settings[key] == nil then db.settings[key] = value end
    end

    for _, event in ipairs(addonTable.ChatEvents) do
        if db.settings.channels[event] == nil then db.settings.channels[event] = true end
    end
end

-- Botón "Valores por defecto" de UI/General.lua. Vacía la base de datos y deja
-- que PrepareDatabase la rellene, para que "por defecto" esté definido en un
-- solo sitio y no pueda desincronizarse de la instalación limpia.
function addonTable.ResetDatabase()
    -- Se conserva la posición del botón de minimapa: no es un ajuste de
    -- traducción y mover el icono de sitio sorprende sin aportar nada.
    local minimap = WoWTranslatorDB and WoWTranslatorDB.minimap
    WoWTranslatorDB = { minimap = minimap }
    PrepareDatabase()
end

local loader = CreateFrame("Frame")
loader:RegisterEvent("PLAYER_LOGIN")
loader:SetScript("OnEvent", function()
    PrepareDatabase()

    addonTable.LoadBabbleSources()
    addonTable.RebuildMasterDict()

    addonTable.CreateConfigUI()
    addonTable.InstallChatFilter()
    addonTable.InstallGroupFinderHook()
    addonTable.CreateMinimapButton()
    addonTable.RegisterSlashCommands()

    addonTable.Print(L["CHAT_LOADED"] or "Loaded.")
end)
