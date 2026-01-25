local ADDON_NAME, addonTable = ...
local L = addonTable.L

-- ==========================================
-- VARIABLES GLOBALES Y TABLAS
-- ==========================================
local BZ, BI
local MasterDict = {}
local SortedDictKeys = {}
local categoryID

function addonTable.RebuildMasterDict()
    MasterDict = {}
    SortedDictKeys = {}
    
    local map = {
        { key = "showMazz", dict = addonTable.MazzRaidDict },
        { key = "showSocial", dict = addonTable.SocialDict },
        { key = "showClases", dict = addonTable.ClasesDict },
        { key = "showCombate", dict = addonTable.CombateDict },
        { key = "showComercio", dict = addonTable.ComercioDict },
        { key = "showStats", dict = addonTable.EstadisticasDict },
        { key = "showGrupos", dict = addonTable.GruposDict },
        { key = "showHermandad", dict = addonTable.HermandadDict },
        { key = "showProfesiones", dict = addonTable.ProfesionesDict },
        { key = "showRoles", dict = addonTable.RolesDict },
    }

    for _, entry in ipairs(map) do
        if entry.dict and WoWTranslatorDB.settings[entry.key] then
            for k, v in pairs(entry.dict) do
                MasterDict[k] = v
                table.insert(SortedDictKeys, k)
            end
        end
    end
    
    table.sort(SortedDictKeys, function(a, b) return #a > #b end)
end

-- ==========================================
-- MOTOR DE TRADUCCIÓN
-- ==========================================
_G.TranslateChat = function(text)
    if not text or not WoWTranslatorDB or not WoWTranslatorDB.enabled then return text, false end
    
    local changed = false
    local target = WoWTranslatorDB.targetLocale or "esES"
    local userColor = WoWTranslatorDB.chatColor or "00ff00"
    
    -- 1. TRADUCCIÓN POR DICCIONARIO DINÁMICO
    for _, eng in ipairs(SortedDictKeys) do
        local casePattern = eng:gsub("%a", function(c) return string.format("[%s%s]", c:lower(), c:upper()) end)
        local pattern = "%f[%w]" .. casePattern .. "%f[%W]"
        
        text = text:gsub(pattern, function(found)
            changed = true
            local translations = MasterDict[eng]
            local translated = translations[target] or translations["esES"] or eng
            return found .. "(|cff" .. userColor .. translated .. "|r)"
        end)
    end

    -- 2. TRADUCCIÓN POR LIBRERÍAS
    local babbleData = { 
        {data = BZ, col = "ffffd1", active = WoWTranslatorDB.settings.showZones}, 
        {data = BI, col = "a335ee", active = WoWTranslatorDB.settings.showSets} 
    }

    for _, b in ipairs(babbleData) do
        if b.data and b.active then
            for eng, loc in pairs(b.data) do
                if #eng > 3 then
                    local pattern = "%f[%a]" .. eng .. "%f[%A]"
                    if text:lower():find(eng:lower(), 1, true) then
                        text = text:gsub(pattern, function(found)
                            changed = true
                            return found .. "(|cff" .. b.col .. loc .. "|r)"
                        end)
                    end
                end
            end
        end
    end

    return text, changed
end

-- ==========================================
-- FILTRO DE CHAT Y REGISTRO
-- ==========================================
local function MyChatFilter(self, event, text, author, ...)
    local translated, wasChanged = _G.TranslateChat(text)
    if wasChanged then return false, translated, author, ... end
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", function(self, event)
    -- Inicializar Base de Datos si no existe
    if not WoWTranslatorDB then
        WoWTranslatorDB = {
            enabled = true,
            targetLocale = "esES",
            chatColor = "00ff00",
            settings = {
                showMazz = true, showSocial = true, showClases = true,
                showCombate = true, showComercio = true, showStats = true,
                showGrupos = true, showHermandad = true, showProfesiones = true,
                showRoles = true, showZones = true, showSets = true
            }
        }
    end
    
    BZ = LibStub("LibBabble-SubZone-3.0", true) and LibStub("LibBabble-SubZone-3.0"):GetUnstrictLookupTable()
    BI = LibStub("LibBabble-ItemSet-3.0", true) and LibStub("LibBabble-ItemSet-3.0"):GetUnstrictLookupTable()

    addonTable.RebuildMasterDict()
    addonTable.CreateConfigUI()
    
    local events = {
        "CHAT_MSG_SAY", "CHAT_MSG_YELL", "CHAT_MSG_WHISPER", "CHAT_MSG_WHISPER_INFORM",
        "CHAT_MSG_BN_WHISPER", "CHAT_MSG_PARTY", "CHAT_MSG_PARTY_LEADER", "CHAT_MSG_RAID",
        "CHAT_MSG_RAID_LEADER", "CHAT_MSG_RAID_WARNING", "CHAT_MSG_INSTANCE_CHAT",
        "CHAT_MSG_INSTANCE_CHAT_LEADER", "CHAT_MSG_GUILD", "CHAT_MSG_OFFICER",
        "CHAT_MSG_CHANNEL", "CHAT_MSG_EMOTE", "CHAT_MSG_BATTLEGROUND", "CHAT_MSG_BATTLEGROUND_LEADER"
    }
    for _, e in ipairs(events) do
        ChatFrame_AddMessageEventFilter(e, MyChatFilter)
    end
    
    print("|cffffff00[|r|cffd597ffWoW Translator|r|cffffff00]|r " .. (L["CHAT_WELCOME"] or "Cargado."))
end)

-- ==========================================
-- SLASH COMMANDS
-- ==========================================
SLASH_WOWTRANSLATOR1 = "/wt"
SlashCmdList["WOWTRANSLATOR"] = function(msg)
    local command, rest = msg:match("^(%S*)%s*(.-)$")
    command = command:lower()

    -- Colores definidos para legibilidad
    local prefix = "|cffffff00[|r|cffd597ffWoW Translator|r|cffffff00]|r "
    local gold = "|cffffff00"
    local white = "|cffffffff"
    local red = "|cffff0000"

    if command == "config" then
        if Settings and Settings.OpenToCategory then
            Settings.OpenToCategory(addonTable.categoryID)
        else
            InterfaceOptionsFrame_OpenToCategory(addonTable.categoryID)
        end

    elseif command == "on" then
        WoWTranslatorDB.enabled = true
        print(prefix .. L["SLASH_ON"])
        if WT_MainEnableCB then WT_MainEnableCB:SetChecked(true) end

    elseif command == "off" then
        WoWTranslatorDB.enabled = false
        print(prefix .. L["SLASH_OFF"])
        if WT_MainEnableCB then WT_MainEnableCB:SetChecked(false) end

    elseif command == "test" then
        local testMsg = "LFM ICC HC 25m Need Tank and Healer"
        local translated, changed = _G.TranslateChat(testMsg)
        
        print(prefix .. gold .. L["SLASH_TEST_ORIGINAL"] .. white .. testMsg .. "|r")
        if changed then
            print(prefix .. gold .. L["SLASH_TEST_RESULT"] .. white .. translated .. "|r")
        else
            local errorStr = not WoWTranslatorDB.enabled and L["SLASH_TEST_ERROR"] or "No dictionary matches found."
            print(prefix .. red .. errorStr .. "|r")
        end

    else
        print(prefix .. gold .. L["HELP_HEADER"] .. "|r")
        print(gold .. "/wt config|r - " .. white .. L["HELP_CONFIG_MSG"] .. "|r")
        print(gold .. "/wt on | off|r - " .. white .. L["HELP_ONOFF_MSG"] .. "|r")
        print(gold .. "/wt test|r - " .. white .. L["HELP_TEST_MSG"] .. "|r")
    end
end