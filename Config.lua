local ADDON_NAME, addonTable = ...
local L = addonTable.L

function addonTable.CreateConfigUI()
    local panel = CreateFrame("Frame", "WoWTranslatorPanel", UIParent)
    panel.name = "WoW Translator"
    
    local title = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", 16, -16)
    title:SetText(L["UI_TITLE"])

    -- 1. ACTIVAR / DESACTIVAR GLOBAL
    local mainCB = CreateFrame("CheckButton", "WT_MainEnableCB", panel, "InterfaceOptionsCheckButtonTemplate")
    mainCB:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -10)
    _G[mainCB:GetName() .. "Text"]:SetText(L["UI_ENABLE_TEXT"])
    mainCB:SetChecked(WoWTranslatorDB.enabled)
    mainCB:SetScript("OnClick", function(self) WoWTranslatorDB.enabled = self:GetChecked() end)

    -- 2. SECCIÓN DE COLOR
    local colorLabel = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    colorLabel:SetPoint("TOPLEFT", mainCB, "BOTTOMLEFT", 0, -15)
    colorLabel:SetText(L["UI_COLOR_LABEL"])

    local colorBtn = CreateFrame("Button", "WT_ColorBtn", panel, "UIPanelButtonTemplate")
    colorBtn:SetPoint("TOPLEFT", colorLabel, "BOTTOMLEFT", 0, -5)
    colorBtn:SetSize(120, 22)
    colorBtn:SetText(L["UI_COLOR_BTN"])

    local colorPreview = colorBtn:CreateTexture(nil, "OVERLAY")
    colorPreview:SetPoint("LEFT", colorBtn, "RIGHT", 10, 0)
    colorPreview:SetSize(18, 18)
    
    local function UpdateColorPreview()
        local hex = WoWTranslatorDB.chatColor or "00ff00"
        local r = tonumber(hex:sub(1,2), 16) / 255
        local g = tonumber(hex:sub(3,4), 16) / 255
        local b = tonumber(hex:sub(5,6), 16) / 255
        colorPreview:SetColorTexture(r, g, b)
    end

    colorBtn:SetScript("OnClick", function()
        local hex = WoWTranslatorDB.chatColor or "00ff00"
        ColorPickerFrame:SetupColorPickerAndShow({
            swatchFunc = function()
                local r, g, b = ColorPickerFrame:GetColorRGB()
                WoWTranslatorDB.chatColor = string.format("%02x%02x%02x", r*255, g*255, b*255)
                UpdateColorPreview()
            end,
            hasOpacity = false,
            r = tonumber(hex:sub(1,2), 16) / 255, 
            g = tonumber(hex:sub(3,4), 16) / 255, 
            b = tonumber(hex:sub(5,6), 16) / 255
        })
    end)
    UpdateColorPreview()

    -- 3. SECCIÓN DE FILTROS (Checkboxes)
    local filterHeader = panel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    filterHeader:SetPoint("TOPLEFT", colorBtn, "BOTTOMLEFT", 0, -25)
    filterHeader:SetText(L["CAT_HEADER"])

    local checkboxes = {
        { text = L["CAT_MAZZ"], key = "showMazz" },
        { text = L["CAT_SOCIAL"], key = "showSocial" },
        { text = L["CAT_CLASSES"], key = "showClases" },
        { text = L["CAT_ROLES"], key = "showRoles" },
        { text = L["CAT_STATS"], key = "showStats" },
        { text = L["CAT_PROF"], key = "showProfesiones" },
        { text = L["CAT_COMBAT"], key = "showCombate" },
        { text = L["CAT_TRADE"], key = "showComercio" },
        { text = L["CAT_GROUPS"], key = "showGrupos" },
        { text = L["CAT_GUILD"], key = "showHermandad" },
        { text = L["CAT_ZONES"], key = "showZones" },
        { text = L["CAT_SETS"], key = "showSets" },
    }

    for i, info in ipairs(checkboxes) do
        local cb = CreateFrame("CheckButton", "WT_CB_"..info.key, panel, "InterfaceOptionsCheckButtonTemplate")
        if i == 1 then
            cb:SetPoint("TOPLEFT", filterHeader, "BOTTOMLEFT", 0, -5)
        elseif i % 2 == 1 then
            cb:SetPoint("TOPLEFT", _G["WT_CB_"..checkboxes[i-2].key], "BOTTOMLEFT", 0, -2)
        else
            cb:SetPoint("LEFT", _G["WT_CB_"..checkboxes[i-1].key], "RIGHT", 180, 0)
        end
        
        _G[cb:GetName() .. "Text"]:SetText(info.text)
        cb:SetChecked(WoWTranslatorDB.settings[info.key])
        cb:SetScript("OnClick", function(self) 
            WoWTranslatorDB.settings[info.key] = self:GetChecked()
            addonTable.RebuildMasterDict() 
        end)
    end

    -- 4. IDIOMA DE DESTINO
    local langLabel = panel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    langLabel:SetPoint("TOPLEFT", _G["WT_CB_showHermandad"], "BOTTOMLEFT", 0, -25)
    langLabel:SetText(L["UI_LANG_LABEL"])

    local dropdown = CreateFrame("Frame", "WT_LangDrop", panel, "UIDropDownMenuTemplate")
    dropdown:SetPoint("TOPLEFT", langLabel, "BOTTOMLEFT", -15, -5)
    
    local langNames = {
        esES="Español (ES)", esMX="Español (AL)", enUS="English", deDE="Deutsch",
        frFR="Français", itIT="Italiano", ptBR="Português", ruRU="Русский",
        koKR="한국어", zhCN="简体中文", zhTW="繁體中文"
    }

    local function OnClick(self)
        WoWTranslatorDB.targetLocale = self.value
        UIDropDownMenu_SetSelectedValue(dropdown, self.value)
        UIDropDownMenu_SetText(dropdown, langNames[self.value])
    end

    UIDropDownMenu_Initialize(dropdown, function(self, level)
        for val, name in pairs(langNames) do
            local info = UIDropDownMenu_CreateInfo()
            info.text = name
            info.value = val
            info.func = OnClick
            info.checked = (WoWTranslatorDB.targetLocale == val)
            UIDropDownMenu_AddButton(info)
        end
    end)
    
    UIDropDownMenu_SetSelectedValue(dropdown, WoWTranslatorDB.targetLocale)
    UIDropDownMenu_SetText(dropdown, langNames[WoWTranslatorDB.targetLocale] or "Español (ES)")

    -- Registro final
    local config_category = Settings.RegisterCanvasLayoutCategory(panel, panel.name)
    Settings.RegisterAddOnCategory(config_category)
    addonTable.categoryID = config_category:GetID()
end