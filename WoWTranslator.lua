local ADDON_NAME, addonTable = ...
local L = addonTable.L

-- ==========================================
-- VARIABLES GLOBALES Y TABLAS
-- ==========================================
local BZ, BI, BR
local MasterDict = {}
local MultiWordPatterns = {}
local SortedDictKeys = {}
local categoryID

local ipairs, pairs, string_format, string_gsub, string_find, string_lower = ipairs, pairs, string.format, string.gsub,
    string.find, string.lower
local table_insert, table_sort = table.insert, table.sort

-- Color por defecto de cada fuente Babble cuando no hay coincidencia en un diccionario propio
local EntryColor = {}

function addonTable.RebuildMasterDict()
    MasterDict = {}
    MultiWordPatterns = {}
    SortedDictKeys = {}
    EntryColor = {}

    local map = {
        { key = "showMazz",        dict = addonTable.InstanciasCoreDict },
        { key = "showInstClassic", dict = addonTable.ClassicDict },
        { key = "showInstTBC",     dict = addonTable.TBCDict },
        { key = "showInstWotLK",   dict = addonTable.WotLKDict },
        { key = "showInstCata",    dict = addonTable.CataDict },
        { key = "showInstMoP",     dict = addonTable.MoPDict },
        { key = "showInstWoD",     dict = addonTable.WoDDict },
        { key = "showInstLegion",  dict = addonTable.LegionDict },
        { key = "showInstBfA",     dict = addonTable.BfADict },
        { key = "showInstShadowlands", dict = addonTable.ShadowlandsDict },
        { key = "showInstDragonflight", dict = addonTable.DragonflightDict },
        { key = "showInstTheWarWithin", dict = addonTable.TheWarWithinDict },
        { key = "showInstMidnight", dict = addonTable.MidnightDict },
        { key = "showSocial",      dict = addonTable.SocialDict },
        { key = "showClases",      dict = addonTable.ClasesDict },
        { key = "showCombate",     dict = addonTable.CombateDict },
        { key = "showComercio",    dict = addonTable.ComercioDict },
        { key = "showStats",       dict = addonTable.EstadisticasDict },
        { key = "showGrupos",      dict = addonTable.GruposDict },
        { key = "showHermandad",   dict = addonTable.HermandadDict },
        { key = "showProfesiones", dict = addonTable.ProfesionesDict },
        { key = "showRoles",       dict = addonTable.RolesDict },
        { key = "showEstado",      dict = addonTable.EstadoDict },
    }

    local target = WoWTranslatorDB and WoWTranslatorDB.targetLocale or "esES"

    for _, entry in ipairs(map) do
        if entry.dict and WoWTranslatorDB.settings[entry.key] then
            for k, v in pairs(entry.dict) do
                local lowerK = string_lower(k)
                local translation = v[target] or v["esES"] or k

                if string_find(k, " ") then
                    if not MultiWordPatterns[lowerK] then
                        MultiWordPatterns[lowerK] = translation
                        table_insert(SortedDictKeys, lowerK)
                    end
                else
                    MasterDict[lowerK] = translation
                end
            end
        end
    end

    -- Fuentes Babble (nombres propios de Blizzard ya traducidos al idioma del cliente).
    -- Se fusionan en las mismas tablas que los diccionarios propios en vez de recorrerse
    -- aparte en cada mensaje de chat: evita miles de pairs()+string_lower() por mensaje.
    -- Los diccionarios propios tienen prioridad si una clave coincide en ambos lados.
    local babbleSources = {
        { data = BZ, color = "ffffd1", active = WoWTranslatorDB.settings.showZones },
        { data = BI, color = "a335ee", active = WoWTranslatorDB.settings.showSets },
        { data = BR, color = "69ccf0", active = WoWTranslatorDB.settings.showRaces },
    }

    for _, src in ipairs(babbleSources) do
        if src.data and src.active then
            for eng, loc in pairs(src.data) do
                if #eng > 3 then
                    local lowerK = string_lower(eng)
                    if string_find(eng, " ", 1, true) then
                        if not MultiWordPatterns[lowerK] then
                            MultiWordPatterns[lowerK] = loc
                            EntryColor[lowerK] = src.color
                            table_insert(SortedDictKeys, lowerK)
                        end
                    elseif not MasterDict[lowerK] then
                        MasterDict[lowerK] = loc
                        EntryColor[lowerK] = src.color
                    end
                end
            end
        end
    end

    table_sort(SortedDictKeys, function(a, b) return #a > #b end)
end

-- ==========================================
-- MOTOR DE TRADUCCIÓN
-- ==========================================
_G.TranslateChat = function(text)
    if not text or not WoWTranslatorDB or not WoWTranslatorDB.enabled then return text, false end

    local changed = false
    local userColor = WoWTranslatorDB.chatColor or "00ff00"
    local textLower = string_lower(text)

    -- 1. TRADUCCIÓN DE FRASES MULTI-PALABRAS (diccionarios propios + Babble)
    for _, eng in ipairs(SortedDictKeys) do
        if string_find(textLower, eng, 1, true) then
            local casePattern = string_gsub(eng, "%a",
                function(c) return string_format("[%s%s]", string_lower(c), c:upper()) end)
            local pattern = "%f[%w]" .. casePattern .. "%f[%W]"
            local prefix = "(|cff" .. (EntryColor[eng] or userColor)

            text = string_gsub(text, pattern, function(found)
                changed = true
                return found .. prefix .. MultiWordPatterns[eng] .. "|r)"
            end)
            if changed then textLower = string_lower(text) end
        end
    end

    -- 2. TRADUCCIÓN DE PALABRAS SUELTAS (diccionarios propios + Babble)
    text = string_gsub(text, "([%a%d']+)", function(word)
        local lowerWord = string_lower(word)
        local translation = MasterDict[lowerWord]
        if translation then
            changed = true
            local prefix = "(|cff" .. (EntryColor[lowerWord] or userColor)
            return word .. prefix .. translation .. "|r)"
        end
        return word
    end)

    return text, changed
end

-- ==========================================
-- FILTRO DE CHAT Y REGISTRO
-- ==========================================
local function MyChatFilter(self, event, text, author, ...)
    if not WoWTranslatorDB or not WoWTranslatorDB.enabled then return end

    -- Filtrado de canales
    if WoWTranslatorDB.settings.channels and WoWTranslatorDB.settings.channels[event] == false then
        return
    end

    local translated, wasChanged = _G.TranslateChat(text)
    if wasChanged then return false, translated, author, ... end
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", function(self, event)
    if not WoWTranslatorDB then
        WoWTranslatorDB = {
            enabled = true,
            targetLocale = "esES",
            chatColor = "00ff00",
            settings = {
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
                channels = {}
            }
        }
    end

    if not WoWTranslatorDB.settings then WoWTranslatorDB.settings = {} end
    if not WoWTranslatorDB.settings.channels then WoWTranslatorDB.settings.channels = {} end
    if WoWTranslatorDB.settings.showRaces == nil then WoWTranslatorDB.settings.showRaces = true end

    local defaultEvents = {
        "CHAT_MSG_SAY", "CHAT_MSG_YELL", "CHAT_MSG_WHISPER", "CHAT_MSG_WHISPER_INFORM",
        "CHAT_MSG_BN_WHISPER", "CHAT_MSG_BN_WHISPER_INFORM", "CHAT_MSG_BN_INLINE_WHISPER",
        "CHAT_MSG_BN_INLINE_WHISPER_INFORM", "CHAT_MSG_PARTY", "CHAT_MSG_PARTY_LEADER",
        "CHAT_MSG_RAID", "CHAT_MSG_RAID_LEADER", "CHAT_MSG_RAID_WARNING",
        "CHAT_MSG_INSTANCE_CHAT", "CHAT_MSG_INSTANCE_CHAT_LEADER", "CHAT_MSG_GUILD",
        "CHAT_MSG_OFFICER", "CHAT_MSG_CHANNEL", "CHAT_MSG_EMOTE"
    }
    for _, e in ipairs(defaultEvents) do
        if WoWTranslatorDB.settings.channels[e] == nil then
            WoWTranslatorDB.settings.channels[e] = true
        end
    end

    BZ = LibStub("LibBabble-SubZone-3.0", true) and LibStub("LibBabble-SubZone-3.0"):GetUnstrictLookupTable()
    BI = LibStub("LibBabble-ItemSet-3.0", true) and LibStub("LibBabble-ItemSet-3.0"):GetUnstrictLookupTable()
    BR = LibStub("LibBabble-Race-3.0", true) and LibStub("LibBabble-Race-3.0"):GetUnstrictLookupTable()

    addonTable.RebuildMasterDict()
    addonTable.CreateConfigUI()

    local events = {
        "CHAT_MSG_SAY", "CHAT_MSG_YELL", "CHAT_MSG_WHISPER", "CHAT_MSG_WHISPER_INFORM",
        "CHAT_MSG_BN_WHISPER", "CHAT_MSG_BN_WHISPER_INFORM", "CHAT_MSG_BN_INLINE_WHISPER",
        "CHAT_MSG_BN_INLINE_WHISPER_INFORM", "CHAT_MSG_PARTY", "CHAT_MSG_PARTY_LEADER",
        "CHAT_MSG_RAID", "CHAT_MSG_RAID_LEADER", "CHAT_MSG_RAID_WARNING",
        "CHAT_MSG_INSTANCE_CHAT", "CHAT_MSG_INSTANCE_CHAT_LEADER", "CHAT_MSG_GUILD",
        "CHAT_MSG_OFFICER", "CHAT_MSG_CHANNEL", "CHAT_MSG_EMOTE", "CHAT_MSG_BATTLEGROUND",
        "CHAT_MSG_BATTLEGROUND_LEADER"
    }
    for _, e in ipairs(events) do
        ChatFrame_AddMessageEventFilter(e, MyChatFilter)
    end

    print("|cffffff00[|r|cffd597ffWoW Translator|r|cffffff00]|r " .. (L["CHAT_LOADED"] or "Loaded."))

    -- ==========================================
    -- BOTÓN DEL MINIMAPA
    -- ==========================================

    local LDB = LibStub("LibDataBroker-1.1", true)
    local LDBIcon = LibStub("LibDBIcon-1.0", true)

    if LDB and LDBIcon then
        local dataObject = LDB:NewDataObject("WoWTranslator", {
            type = "launcher",
            icon = "Interface\\Addons\\WoWTranslator\\img\\logo_wt",

            OnClick = function(self, button)
                if Settings and Settings.OpenToCategory then
                    Settings.OpenToCategory(addonTable.categoryID)
                else
                    InterfaceOptionsFrame_OpenToCategory(addonTable.categoryID)
                end
            end,

            OnTooltipShow = function(tooltip)
                tooltip:AddLine(L["QT_MINIMAP_TT"] or "Click: Open Settings")
            end,
        })

        WoWTranslatorDB.minimap = WoWTranslatorDB.minimap or {}

        if not LDBIcon:IsRegistered("WoWTranslator") then
            LDBIcon:Register("WoWTranslator", dataObject, WoWTranslatorDB.minimap)
        end
    end

    -- ==========================================
    -- ==========================================
    -- FUNCIONES COMPARTIDAS
    -- ==========================================
    function addonTable.RunTest()
        local prefix = "|cffffff00[|r|cffd597ffWoW Translator|r|cffffff00]|r "
        local gold = "|cffffff00"
        local white = "|cffffffff"
        local red = "|cffff0000"

        local testMsg = "LFM ICC HC 25m Need Tank and Healer"
        local translated, changed = _G.TranslateChat(testMsg)

        print(prefix .. gold .. L["SLASH_TEST_ORIGINAL"] .. white .. testMsg .. "|r")
        if changed then
            print(prefix .. gold .. L["SLASH_TEST_RESULT"] .. white .. translated .. "|r")
        else
            local errorStr = not WoWTranslatorDB.enabled and L["SLASH_TEST_ERROR"] or L["TEST_NO_MATCH"]
            print(prefix .. red .. errorStr .. "|r")
        end
    end

    -- ==========================================
    -- COMANDOS DE BARRA (SLASH)
    -- ==========================================
    SLASH_WOWTRANSLATOR1 = "/wt"
    SlashCmdList["WOWTRANSLATOR"] = function(msg)
        local command, rest = msg:match("^(%S*)%s*(.-)$")
        command = command:lower()

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
            addonTable.RunTest()
        elseif command == "search" then
            if rest == "" then
                print(prefix .. red .. (L["SEARCH_USAGE"] or "Usage: /wt search <word or phrase>") .. "|r")
            else
                local key = rest:lower()
                local result = MasterDict[key] or MultiWordPatterns[key]
                if result then
                    print(prefix .. white .. rest .. "|r " .. gold .. "->|r " .. white .. result .. "|r")
                else
                    print(prefix .. red ..
                        (L["SEARCH_NOT_FOUND"] or "No translation found for: ") .. white .. rest .. "|r")
                end
            end
        else
            print(prefix .. gold .. L["HELP_HEADER"] .. "|r")
            print(gold .. "/wt config|r - " .. white .. L["HELP_CONFIG_MSG"] .. "|r")
            print(gold .. "/wt on | off|r - " .. white .. L["HELP_ONOFF_MSG"] .. "|r")
            print(gold .. "/wt test|r - " .. white .. L["HELP_TEST_MSG"] .. "|r")
            print(gold .. "/wt search <word>|r - " ..
                white .. (L["HELP_SEARCH_MSG"] or "Look up a translation directly.") .. "|r")
        end
    end
end)
