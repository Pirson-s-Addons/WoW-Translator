local ADDON_NAME, addonTable = ...
local L = addonTable.L

local function AddTooltip(frame, text)
    if not text then return end
    frame:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(text, nil, nil, nil, nil, true)
        GameTooltip:Show()
    end)
    frame:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
    end)
end

function addonTable.CreateConfigUI()
    local panel = CreateFrame("Frame", "WoWTranslatorPanel", UIParent)
    panel.name = "WoW Translator"

    local title = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", 16, -16)
    title:SetText(L["UI_TITLE"])

    -- Logo Branding (Minimalist)
    local logo = panel:CreateTexture(nil, "ARTWORK")
    logo:SetSize(90, 90)
    logo:SetPoint("TOPRIGHT", -20, -10)
    logo:SetTexture("Interface\\Addons\\WoWTranslator\\img\\logo_wt")

    local version = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    version:SetPoint("TOP", logo, "BOTTOM", 0, -2)
    version:SetText("v" .. (C_AddOns.GetAddOnMetadata(ADDON_NAME, "Version") or "1.00"))

    -- 1. SECCIÓN: CONFIGURACIÓN GENERAL
    local genHeader = panel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    genHeader:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -20)
    genHeader:SetText("|cffd597ff" .. L["GEN_HEADER"] .. "|r")

    -- Checkbutton principal
    local mainCB = CreateFrame("CheckButton", "WT_MainEnableCB", panel, "InterfaceOptionsCheckButtonTemplate")
    mainCB:SetPoint("TOPLEFT", genHeader, "BOTTOMLEFT", 0, -10)
    _G[mainCB:GetName() .. "Text"]:SetText(L["UI_ENABLE_TEXT"])
    mainCB:SetChecked(WoWTranslatorDB.enabled)
    mainCB:SetScript("OnClick", function(self) WoWTranslatorDB.enabled = self:GetChecked() end)
    AddTooltip(mainCB, L["TT_ENABLE"])


    -- Color de la traducción
    local colorBtn = CreateFrame("Button", "WT_ColorBtn", panel, "UIPanelButtonTemplate")
    colorBtn:SetPoint("LEFT", mainCB, "RIGHT", 220, 0)
    colorBtn:SetSize(120, 22)
    colorBtn:SetText(L["UI_COLOR_BTN"])
    AddTooltip(colorBtn, L["TT_COLOR"])

    local colorPreview = colorBtn:CreateTexture(nil, "OVERLAY")
    colorPreview:SetPoint("LEFT", colorBtn, "RIGHT", 10, 0)
    colorPreview:SetSize(18, 18)

    local function UpdateColorPreview()
        local hex = WoWTranslatorDB.chatColor or "00ff00"
        local r = tonumber(hex:sub(1, 2), 16) / 255
        local g = tonumber(hex:sub(3, 4), 16) / 255
        local b = tonumber(hex:sub(5, 6), 16) / 255
        colorPreview:SetColorTexture(r, g, b)
    end

    colorBtn:SetScript("OnClick", function()
        local hex = WoWTranslatorDB.chatColor or "00ff00"
        ColorPickerFrame:SetupColorPickerAndShow({
            swatchFunc = function()
                local r, g, b = ColorPickerFrame:GetColorRGB()
                WoWTranslatorDB.chatColor = string.format("%02x%02x%02x", r * 255, g * 255, b * 255)
                UpdateColorPreview()
            end,
            hasOpacity = false,
            r = tonumber(hex:sub(1, 2), 16) / 255,
            g = tonumber(hex:sub(3, 4), 16) / 255,
            b = tonumber(hex:sub(5, 6), 16) / 255
        })
    end)
    UpdateColorPreview()

    -- Separador sutil
    local line1 = panel:CreateTexture(nil, "ARTWORK")
    line1:SetSize(580, 1)
    line1:SetPoint("TOPLEFT", mainCB, "BOTTOMLEFT", 0, -15)
    line1:SetColorTexture(1, 1, 1, 0.1)

    -- 2. SECCIÓN: CATEGORÍAS (CUADRÍCULA)
    local filterHeader = panel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    filterHeader:SetPoint("TOPLEFT", line1, "BOTTOMLEFT", 0, -15)
    filterHeader:SetText("|cffd597ff" .. L["CAT_HEADER"] .. "|r")

    local checkboxes = {
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
    }

    local lastCB
    for i, info in ipairs(checkboxes) do
        local cb = CreateFrame("CheckButton", "WT_CB_" .. info.key, panel, "InterfaceOptionsCheckButtonTemplate")
        if i == 1 then
            cb:SetPoint("TOPLEFT", filterHeader, "BOTTOMLEFT", 0, -5)
        elseif (i - 1) % 3 == 0 then
            cb:SetPoint("TOPLEFT", _G["WT_CB_" .. checkboxes[i - 3].key], "BOTTOMLEFT", 0, -2)
        else
            cb:SetPoint("LEFT", _G["WT_CB_" .. checkboxes[i - 1].key], "RIGHT", 160, 0)
        end

        _G[cb:GetName() .. "Text"]:SetText(info.text)
        _G[cb:GetName() .. "Text"]:SetFontObject("GameFontHighlightSmall")
        cb:SetChecked(WoWTranslatorDB.settings[info.key])
        cb:SetScript("OnClick", function(self)
            WoWTranslatorDB.settings[info.key] = self:GetChecked()
            addonTable.RebuildMasterDict()
        end)
        AddTooltip(cb, info.tt)
        lastCB = cb
    end

    -- Separador sutil
    local line2 = panel:CreateTexture(nil, "ARTWORK")
    line2:SetSize(580, 1)
    line2:SetPoint("TOPLEFT", _G["WT_CB_showSets"], "BOTTOMLEFT", 0, -15)
    line2:SetColorTexture(1, 1, 1, 0.1)

    -- 3. SECCIÓN: CANALES DE CHAT
    local channelHeader = panel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    channelHeader:SetPoint("TOPLEFT", line2, "BOTTOMLEFT", 0, -15)
    channelHeader:SetText("|cffd597ff" .. L["CH_HEADER"] .. "|r")

    local channelSettings = {
        { text = L["CH_SAY"],     events = { "CHAT_MSG_SAY", "CHAT_MSG_YELL" },                                                                      tt = L["TT_CH_SAY"] },
        { text = L["CH_PARTY"],   events = { "CHAT_MSG_PARTY", "CHAT_MSG_PARTY_LEADER", "CHAT_MSG_INSTANCE_CHAT", "CHAT_MSG_INSTANCE_CHAT_LEADER" }, tt = L["TT_CH_PARTY"] },
        { text = L["CH_RAID"],    events = { "CHAT_MSG_RAID", "CHAT_MSG_RAID_LEADER", "CHAT_MSG_RAID_WARNING" },                                     tt = L["TT_CH_RAID"] },
        { text = L["CH_GUILD"],   events = { "CHAT_MSG_GUILD", "CHAT_MSG_OFFICER" },                                                                 tt = L["TT_CH_GUILD"] },
        { text = L["CH_WHISPER"], events = { "CHAT_MSG_WHISPER", "CHAT_MSG_WHISPER_INFORM", "CHAT_MSG_BN_WHISPER" },                                 tt = L["TT_CH_WHISPER"] },
        { text = L["CH_CHANNEL"], events = { "CHAT_MSG_CHANNEL" },                                                                                   tt = L["TT_CH_CHANNEL"] },
        { text = L["CH_EMOTE"],   events = { "CHAT_MSG_EMOTE" },                                                                                     tt = L["TT_CH_EMOTE"] },
    }

    for i, info in ipairs(channelSettings) do
        local cb = CreateFrame("CheckButton", "WT_CH_CB_" .. i, panel, "InterfaceOptionsCheckButtonTemplate")
        if i == 1 then
            cb:SetPoint("TOPLEFT", channelHeader, "BOTTOMLEFT", 0, -5)
        elseif (i - 1) % 3 == 0 then
            cb:SetPoint("TOPLEFT", _G["WT_CH_CB_" .. (i - 3)], "BOTTOMLEFT", 0, -2)
        else
            cb:SetPoint("LEFT", _G["WT_CH_CB_" .. (i - 1)], "RIGHT", 160, 0)
        end

        _G[cb:GetName() .. "Text"]:SetText(info.text)
        _G[cb:GetName() .. "Text"]:SetFontObject("GameFontHighlightSmall")

        local isEnabled = true
        for _, ev in ipairs(info.events) do
            if WoWTranslatorDB.settings.channels[ev] == false then
                isEnabled = false
                break
            end
        end
        cb:SetChecked(isEnabled)

        cb:SetScript("OnClick", function(self)
            local val = self:GetChecked()
            for _, ev in ipairs(info.events) do
                WoWTranslatorDB.settings.channels[ev] = val
            end
        end)
        AddTooltip(cb, info.tt)
    end

    -- Separador sutil
    local line3 = panel:CreateTexture(nil, "ARTWORK")
    line3:SetSize(580, 1)
    line3:SetPoint("TOPLEFT", _G["WT_CH_CB_7"], "BOTTOMLEFT", 0, -15)
    line3:SetColorTexture(1, 1, 1, 0.1)

    -- 4. IDIOMA DE DESTINO (Al final)
    local langLabel = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    langLabel:SetPoint("TOPLEFT", line3, "BOTTOMLEFT", 0, -15)
    langLabel:SetText("|cffd597ff" .. L["UI_LANG_LABEL"] .. "|r")

    local dropdown = CreateFrame("Frame", "WT_LangDrop", panel, "UIDropDownMenuTemplate")
    dropdown:SetPoint("TOPLEFT", langLabel, "BOTTOMLEFT", -15, -5)
    AddTooltip(dropdown, L["TT_LANG"])

    local langNames = {
        esES = "Español (ES)",
        esMX = "Español (AL)",
        enUS = "English",
        deDE = "Deutsch",
        frFR = "Français",
        itIT = "Italiano",
        ptBR = "Português",
        ruRU = "Русский",
        koKR = "한국어",
        zhCN = "简体中文",
        zhTW = "繁體中文"
    }

    UIDropDownMenu_Initialize(dropdown, function(self, level)
        for val, name in pairs(langNames) do
            local info = UIDropDownMenu_CreateInfo()
            info.text = name
            info.value = val
            info.func = function(s)
                WoWTranslatorDB.targetLocale = s.value
                UIDropDownMenu_SetSelectedValue(dropdown, s.value)
                UIDropDownMenu_SetText(dropdown, langNames[s.value])
            end
            info.checked = (WoWTranslatorDB.targetLocale == val)
            UIDropDownMenu_AddButton(info)
        end
    end)

    UIDropDownMenu_SetSelectedValue(dropdown, WoWTranslatorDB.targetLocale)
    UIDropDownMenu_SetText(dropdown, langNames[WoWTranslatorDB.targetLocale] or "Español (ES)")

    -- Registro Final
    local config_category = Settings.RegisterCanvasLayoutCategory(panel, panel.name)
    Settings.RegisterAddOnCategory(config_category)
    addonTable.categoryID = config_category:GetID()
end
