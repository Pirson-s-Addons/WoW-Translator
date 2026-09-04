local ADDON_NAME, addonTable = ...
local L = addonTable.L

-- ==========================================
-- COMANDOS DE BARRA (/wt)
-- ==========================================

local PREFIX = addonTable.PREFIX
local GOLD, WHITE, RED = addonTable.COLOR.gold, addonTable.COLOR.white, addonTable.COLOR.red

-- Lo usan tanto /wt test como el botón de prueba del panel de opciones.
function addonTable.RunTest()
    local testMsg = "LFM ICC HC 25m Need Tank and Healer"
    local translated, changed = _G.TranslateChat(testMsg)

    print(PREFIX .. GOLD .. L["SLASH_TEST_ORIGINAL"] .. WHITE .. testMsg .. "|r")
    if changed then
        print(PREFIX .. GOLD .. L["SLASH_TEST_RESULT"] .. WHITE .. translated .. "|r")
    else
        local reason = not WoWTranslatorDB.enabled and L["SLASH_TEST_ERROR"] or L["TEST_NO_MATCH"]
        print(PREFIX .. RED .. reason .. "|r")
    end
end

local function Search(term)
    if term == "" then
        print(PREFIX .. RED .. L["SEARCH_USAGE"] .. "|r")
        return
    end
    local key = term:lower()
    local result = addonTable.MasterDict[key] or addonTable.MultiWordPatterns[key]
    if result then
        print(PREFIX .. WHITE .. term .. "|r " .. GOLD .. "->|r " .. WHITE .. result .. "|r")
    else
        print(PREFIX .. RED .. L["SEARCH_NOT_FOUND"] .. WHITE .. term .. "|r")
    end
end

local function Compose(term)
    if term == "" then
        print(PREFIX .. RED .. L["OUT_USAGE"] .. "|r")
        return
    end

    local out, changed = addonTable.TranslateOutgoing(term)
    -- Devolver el texto tal cual, en silencio, parece un fallo del addon. El caso
    -- típico es tener el inglés como idioma destino: entonces el diccionario no
    -- contiene ninguna palabra del idioma del jugador y no hay nada que invertir.
    if not changed then
        print(PREFIX .. RED .. L["SEARCH_NOT_FOUND"] .. WHITE .. term .. "|r")
        return
    end

    print(PREFIX .. WHITE .. term .. "|r " .. GOLD .. "->|r " .. WHITE .. out .. "|r")

    -- Se deja ESCRITO en la caja de chat, no se envía: el jugador revisa y pulsa
    -- Intro. El addon nunca habla por él.
    local edit = ChatEdit_GetActiveWindow and ChatEdit_GetActiveWindow()
    if not edit then
        edit = ChatFrame1EditBox
        if edit and ChatEdit_ActivateChat then ChatEdit_ActivateChat(edit) end
    end
    if edit then edit:SetText(out) end
end

local function ShowHelp()
    print(PREFIX .. GOLD .. L["HELP_HEADER"] .. "|r")
    print(GOLD .. "/wt config|r - " .. WHITE .. L["HELP_CONFIG_MSG"] .. "|r")
    print(GOLD .. "/wt on | off|r - " .. WHITE .. L["HELP_ONOFF_MSG"] .. "|r")
    print(GOLD .. "/wt test|r - " .. WHITE .. L["HELP_TEST_MSG"] .. "|r")
    print(GOLD .. "/wt search <word>|r - " .. WHITE .. L["HELP_SEARCH_MSG"] .. "|r")
    print(GOLD .. "/wt en <text>|r - " .. WHITE .. L["HELP_OUT_MSG"] .. "|r")
end

local function SetEnabled(enabled)
    WoWTranslatorDB.enabled = enabled
    print(PREFIX .. (enabled and L["SLASH_ON"] or L["SLASH_OFF"]))
    -- El panel puede estar abierto: que la casilla no se quede desincronizada.
    if WT_MainEnableCB then WT_MainEnableCB:SetChecked(enabled) end
end

function addonTable.RegisterSlashCommands()
    SLASH_WOWTRANSLATOR1 = "/wt"
    SlashCmdList["WOWTRANSLATOR"] = function(msg)
        local command, rest = msg:match("^(%S*)%s*(.-)$")
        command = command:lower()

        if command == "config" then
            Settings.OpenToCategory(addonTable.categoryID)
        elseif command == "on" then
            SetEnabled(true)
        elseif command == "off" then
            SetEnabled(false)
        elseif command == "test" then
            addonTable.RunTest()
        elseif command == "search" then
            Search(rest)
        elseif command == "en" then
            Compose(rest)
        else
            ShowHelp()
        end
    end
end
