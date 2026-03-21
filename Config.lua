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
    panel.name = "|TInterface\\AddOns\\WoWTranslator\\img\\logo_wt:16:16|t  |cffd597ffWoW Translator|r"
    panel:SetSize(615, 580) -- Tamaño estándar para evitar que el ScrollFrame sea 0x0

    -- 0. CONTENEDOR DE SCROLL
    local scrollFrame = CreateFrame("ScrollFrame", "WT_ConfigScrollFrame", panel, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", 8, -4)
    scrollFrame:SetPoint("BOTTOMRIGHT", -28, 4)

    local scrollChild = CreateFrame("Frame", "WT_ConfigScrollChild", scrollFrame)
    scrollChild:SetSize(580, 1) -- Ancho estándar fijo
    scrollFrame:SetScrollChild(scrollChild)

    local currentY = -16
    local marginX = 16

    -- TÍTULO
    local title = scrollChild:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", marginX, currentY)
    title:SetText(L["UI_TITLE"])

    -- Marca / Logo
    local logo = scrollChild:CreateTexture(nil, "ARTWORK")
    logo:SetSize(90, 90)
    logo:SetPoint("TOPRIGHT", scrollChild, "TOPRIGHT", -10, -5)
    logo:SetTexture("Interface\\Addons\\WoWTranslator\\img\\logo_wt")

    local version = scrollChild:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    version:SetPoint("TOP", logo, "BOTTOM", 0, -2)
    version:SetText("v" .. (C_AddOns.GetAddOnMetadata(ADDON_NAME, "Version") or "1.00"))

    currentY = currentY - 40

    -- 1. SECCIÓN: CONFIGURACIÓN GENERAL
    local genHeader = scrollChild:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    genHeader:SetPoint("TOPLEFT", marginX, currentY)
    genHeader:SetText("|cffC47FF3" .. L["GEN_HEADER"] .. "|r")
    currentY = currentY - 25

    -- Checkbutton principal
    local mainCB = CreateFrame("CheckButton", "WT_MainEnableCB", scrollChild, "InterfaceOptionsCheckButtonTemplate")
    mainCB:SetPoint("TOPLEFT", marginX, currentY)
    _G[mainCB:GetName() .. "Text"]:SetText(L["UI_ENABLE_TEXT"])
    mainCB:SetChecked(WoWTranslatorDB.enabled)
    mainCB:SetScript("OnClick", function(self) WoWTranslatorDB.enabled = self:GetChecked() end)
    AddTooltip(mainCB, L["TT_ENABLE"])

    -- Color de la traducción
    local colorBtn = CreateFrame("Button", "WT_ColorBtn", scrollChild, "UIPanelButtonTemplate")
    colorBtn:SetPoint("LEFT", mainCB, "RIGHT", 200, 0)
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
    currentY = currentY - 35

    -- Separador sutil
    local line1 = scrollChild:CreateTexture(nil, "ARTWORK")
    line1:SetSize(580, 1)
    line1:SetPoint("TOPLEFT", marginX, currentY)
    line1:SetColorTexture(1, 1, 1, 0.1)
    currentY = currentY - 15

    -- 2. SECCIÓN: CATEGORÍAS (CUADRÍCULA)
    local filterHeader = scrollChild:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    filterHeader:SetPoint("TOPLEFT", marginX, currentY)
    filterHeader:SetText("|cffC47FF3" .. L["CAT_HEADER"] .. "|r")
    currentY = currentY - 30

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

    for i, info in ipairs(checkboxes) do
        local cb = CreateFrame("CheckButton", "WT_CB_" .. info.key, scrollChild, "InterfaceOptionsCheckButtonTemplate")
        local col = (i - 1) % 3
        local row = math.floor((i - 1) / 3)
        cb:SetPoint("TOPLEFT", marginX + (col * 180), currentY - (row * 26))

        _G[cb:GetName() .. "Text"]:SetText(info.text)
        _G[cb:GetName() .. "Text"]:SetFontObject("GameFontHighlightSmall")
        cb:SetChecked(WoWTranslatorDB.settings[info.key])
        cb:SetScript("OnClick", function(self)
            WoWTranslatorDB.settings[info.key] = self:GetChecked()
            addonTable.RebuildMasterDict()
        end)
        AddTooltip(cb, info.tt)
    end
    currentY = currentY - (math.ceil(#checkboxes / 3) * 26) - 15

    -- Separador sutil
    local line2 = scrollChild:CreateTexture(nil, "ARTWORK")
    line2:SetSize(580, 1)
    line2:SetPoint("TOPLEFT", marginX, currentY)
    line2:SetColorTexture(1, 1, 1, 0.1)
    currentY = currentY - 15

    -- 3. SECCIÓN: CANALES DE CHAT
    local channelHeader = scrollChild:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    channelHeader:SetPoint("TOPLEFT", marginX, currentY)
    channelHeader:SetText("|cffd597ff" .. L["CH_HEADER"] .. "|r")
    currentY = currentY - 30

    local categories = {
        {
            header = "|cffe0c0f5" .. L["CH_CAT_GENERAL"] .. "|r",
            events = {
                { name = L["CH_SAY"],     ev = "CHAT_MSG_SAY" },
                { name = L["CH_YELL"],    ev = "CHAT_MSG_YELL" },
                { name = L["CH_EMOTE"],   ev = "CHAT_MSG_EMOTE" },
                { name = L["CH_CHANNEL"], ev = "CHAT_MSG_CHANNEL" },
            }
        },
        {
            header = "|cffe0c0f5" .. L["CH_CAT_WHISPERS"] .. "|r",
            events = {
                { name = L["CH_WHISPER"],                  ev = "CHAT_MSG_WHISPER" },
                { name = L["CH_WHISPER_INFORM"],           ev = "CHAT_MSG_WHISPER_INFORM" },
                { name = L["CH_BN_WHISPER"],               ev = "CHAT_MSG_BN_WHISPER" },
                { name = L["CH_BN_WHISPER_INFORM"],        ev = "CHAT_MSG_BN_WHISPER_INFORM" },
                { name = L["CH_BN_INLINE_WHISPER"],        ev = "CHAT_MSG_BN_INLINE_WHISPER" },
                { name = L["CH_BN_INLINE_WHISPER_INFORM"], ev = "CHAT_MSG_BN_INLINE_WHISPER_INFORM" },
            }
        },
        {
            header = "|cffe0c0f5" .. L["CH_CAT_GUILD"] .. "|r",
            events = {
                { name = L["CH_GUILD"],   ev = "CHAT_MSG_GUILD" },
                { name = L["CH_OFFICER"], ev = "CHAT_MSG_OFFICER" },
            }
        },
        {
            header = "|cffe0c0f5" .. L["CH_CAT_GROUP"] .. "|r",
            events = {
                { name = L["CH_PARTY"],           ev = "CHAT_MSG_PARTY" },
                { name = L["CH_PARTY_LEADER"],    ev = "CHAT_MSG_PARTY_LEADER" },
                { name = L["CH_INSTANCE"],        ev = "CHAT_MSG_INSTANCE_CHAT" },
                { name = L["CH_INSTANCE_LEADER"], ev = "CHAT_MSG_INSTANCE_CHAT_LEADER" },
            }
        },
        {
            header = "|cffe0c0f5" .. L["CH_CAT_RAID"] .. "|r",
            events = {
                { name = L["CH_RAID"],         ev = "CHAT_MSG_RAID" },
                { name = L["CH_RAID_LEADER"],  ev = "CHAT_MSG_RAID_LEADER" },
                { name = L["CH_RAID_WARNING"], ev = "CHAT_MSG_RAID_WARNING" },
            }
        },
        {
            header = "|cffe0c0f5" .. L["CH_CAT_PVP"] .. "|r",
            events = {
                { name = L["CH_BATTLEGROUND"],        ev = "CHAT_MSG_BATTLEGROUND" },
                { name = L["CH_BATTLEGROUND_LEADER"], ev = "CHAT_MSG_BATTLEGROUND_LEADER" },
            }
        }
    }

    local chCount = 0
    for _, cat in ipairs(categories) do
        local subHeader = scrollChild:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
        subHeader:SetPoint("TOPLEFT", marginX + 20, currentY)
        subHeader:SetText(cat.header)
        currentY = currentY - 20

        for i, info in ipairs(cat.events) do
            chCount = chCount + 1
            local cb = CreateFrame("CheckButton", "WT_CH_CB_" .. chCount, scrollChild,
                "InterfaceOptionsCheckButtonTemplate")
            local col = (i - 1) % 3
            local row = math.floor((i - 1) / 3)
            cb:SetPoint("TOPLEFT", marginX + (col * 180), currentY - (row * 24))

            _G[cb:GetName() .. "Text"]:SetText(info.name)
            _G[cb:GetName() .. "Text"]:SetFontObject("GameFontHighlightSmall")
            cb:SetChecked(WoWTranslatorDB.settings.channels[info.ev] ~= false)
            cb:SetScript("OnClick", function(self)
                WoWTranslatorDB.settings.channels[info.ev] = self:GetChecked()
            end)
            AddTooltip(cb, L["TT_CH_GENERIC"])

            if i == #cat.events then
                currentY = currentY - (row * 24) - 30
            end
        end
    end

    -- Separador sutil antes del idioma
    local line3 = scrollChild:CreateTexture(nil, "ARTWORK")
    line3:SetSize(580, 1)
    line3:SetPoint("TOPLEFT", marginX, currentY)
    line3:SetColorTexture(1, 1, 1, 0.1)
    currentY = currentY - 15

    -- 4. IDIOMA DE DESTINO
    local langLabel = scrollChild:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    langLabel:SetPoint("TOPLEFT", marginX, currentY)
    langLabel:SetText("|cffC47FF3" .. L["UI_LANG_LABEL"] .. "|r")
    currentY = currentY - 30

    local dropdown = CreateFrame("Frame", "WT_LangDrop", scrollChild, "UIDropDownMenuTemplate")
    dropdown:SetPoint("TOPLEFT", marginX - 15, currentY)
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
        zhTW = "繁體中文",
        plPL = "Polski",
        svSE = "Svenska",
        noNO = "Norsk"
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
                addonTable.RebuildMasterDict()
            end
            info.checked = (WoWTranslatorDB.targetLocale == val)
            UIDropDownMenu_AddButton(info)
        end
    end)

    UIDropDownMenu_SetSelectedValue(dropdown, WoWTranslatorDB.targetLocale)
    UIDropDownMenu_SetText(dropdown, langNames[WoWTranslatorDB.targetLocale] or "Español (ES)")

    -- 5. BOTÓN DE PRUEBA
    local testBtn = CreateFrame("Button", "WT_TestBtn", scrollChild, "UIPanelButtonTemplate")
    testBtn:SetPoint("LEFT", dropdown, "RIGHT", 140, 2)
    testBtn:SetSize(150, 22)
    testBtn:SetText(L["UI_TEST_BTN"])
    testBtn:SetScript("OnClick", function() addonTable.RunTest() end)
    AddTooltip(testBtn, L["TT_TEST_BTN"])

    currentY = currentY - 50
    scrollChild:SetSize(580, math.abs(currentY))

    -- Registro Final
    local config_category = Settings.RegisterCanvasLayoutCategory(panel, panel.name)
    Settings.RegisterAddOnCategory(config_category)
    addonTable.categoryID = config_category:GetID()
end
