local ADDON_NAME, addonTable = ...
local L = addonTable.L
local AddTooltip = addonTable.AddTooltip
local MARGIN_X = addonTable.MARGIN_X

-- ==========================================
-- VISTA: GENERAL
-- ==========================================
-- Los cuatro ajustes que un jugador toca de verdad: activar, color, idioma
-- destino y el botón de prueba.

-- código = { nombre en inglés, nombre nativo }
local LANGUAGES = {
    esES = { "Spanish (ES)", "Español (ES)" }, esMX = { "Spanish (AL)", "Español (AL)" },
    enUS = { "English", "English" }, deDE = { "German", "Deutsch" },
    frFR = { "French", "Français" }, itIT = { "Italian", "Italiano" },
    ptBR = { "Portuguese", "Português" }, ruRU = { "Russian", "Русский" },
    koKR = { "Korean", "한국어" }, zhCN = { "Chinese (S)", "简体中文" },
    zhTW = { "Chinese (T)", "繁體中文" }, plPL = { "Polish", "Polski" },
    svSE = { "Swedish", "Svenska" }, noNO = { "Norwegian", "Norsk" },
    trTR = { "Turkish", "Türkçe" }, jaJP = { "Japanese", "日本語" },
    arSA = { "Arabic", "العربية" }, hiIN = { "Hindi", "हिन्दी" },
    thTH = { "Thai", "ไทย" }, viVN = { "Vietnamese", "Tiếng Việt" },
    csCZ = { "Czech", "Čeština" }, nlNL = { "Dutch", "Nederlands" },
    roRO = { "Romanian", "Română" }, huHU = { "Hungarian", "Magyar" },
    elGR = { "Greek", "Ελληνικά" }, ukUA = { "Ukrainian", "Українська" },
    daDK = { "Danish", "Dansk" }, fiFI = { "Finnish", "Suomi" },
    skSK = { "Slovak", "Slovenčina" }, bgBG = { "Bulgarian", "Български" },
    hrHR = { "Croatian", "Hrvatski" }, srRS = { "Serbian", "Српски" },
    slSI = { "Slovenian", "Slovenščina" }, ltLT = { "Lithuanian", "Lietuvių" },
    lvLV = { "Latvian", "Latviešu" }, etEE = { "Estonian", "Eesti" },
    idID = { "Indonesian", "Bahasa Indonesia" }, msMY = { "Malay", "Bahasa Melayu" },
    faIR = { "Persian", "فارسی" }, heIL = { "Hebrew", "עברית" },
    bnBD = { "Bengali", "বাংলা" }, urPK = { "Urdu", "اردو" },
    taIN = { "Tamil", "தமிழ்" }, teIN = { "Telugu", "తెలుగు" },
}

-- Idiomas cuyo nombre nativo NO puede dibujar la fuente de un cliente cualquiera:
-- usan otro alfabeto, o diacríticos fuera de lo que cubre la fuente del juego.
-- Para estos se muestra el nombre en inglés y no un montón de cuadraditos.
local UNRENDERABLE = {
    ruRU = true, ukUA = true, bgBG = true, srRS = true, -- cirílico
    elGR = true,                                        -- griego
    zhCN = true, zhTW = true, koKR = true, jaJP = true, -- CJK
    arSA = true, faIR = true, urPK = true,              -- árabe
    heIL = true,                                        -- hebreo
    hiIN = true, bnBD = true, taIN = true, teIN = true, -- índicos
    thTH = true,                                        -- tailandés
    viVN = true,                                        -- latino, pero con diacríticos que la fuente no cubre
}

-- El idioma del propio cliente siempre en nativo: esa fuente sabe dibujarlo por
-- definición. El resto, nativo si su alfabeto es seguro.
local function LanguageName(code)
    local names = code and LANGUAGES[code]
    if not names then return nil end
    if code == GetLocale() or not UNRENDERABLE[code] then return names[2] end
    return names[1]
end

-- Ordenar por bytes mandaría "Čeština" detrás de la Z, porque la Č empieza por
-- un byte alto. Solo hace falta plegar la primera letra para que caiga bien.
local SORT_FOLD = {
    ["Á"] = "A", ["À"] = "A", ["Â"] = "A", ["Ä"] = "A", ["Ã"] = "A", ["Å"] = "A",
    ["Ç"] = "C", ["Č"] = "C", ["Ć"] = "C",
    ["É"] = "E", ["È"] = "E", ["Ê"] = "E", ["Ë"] = "E",
    ["Í"] = "I", ["Î"] = "I", ["Ï"] = "I",
    ["Ł"] = "L", ["Ñ"] = "N", ["Ń"] = "N",
    ["Ó"] = "O", ["Ö"] = "O", ["Õ"] = "O", ["Ø"] = "O",
    ["Š"] = "S", ["Ś"] = "S",
    ["Ú"] = "U", ["Ü"] = "U", ["Ű"] = "U",
    ["Ž"] = "Z", ["Ź"] = "Z", ["Ż"] = "Z",
}

local function SortKey(text)
    return (text:gsub("[\194-\244][\128-\191]*", function(char) return SORT_FOLD[char] or char end))
end

-- Arriba del desplegable, separado del resto: el idioma del cliente (y sus
-- variantes, esES/esMX o similares). Es lo que va a elegir casi todo el mundo.
local function SplitLanguages()
    local clientLang = GetLocale():sub(1, 2)
    local preferred, rest = {}, {}

    for code in pairs(LANGUAGES) do
        local list = (code:sub(1, 2) == clientLang) and preferred or rest
        list[#list + 1] = code
    end

    local function byName(a, b) return SortKey(LanguageName(a)) < SortKey(LanguageName(b)) end
    -- Entre las variantes del idioma del cliente manda la exacta: en un cliente
    -- esES, "Español (ES)" va antes que "Español (AL)".
    table.sort(preferred, function(a, b)
        local exact = GetLocale()
        if a == exact or b == exact then return a == exact end
        return byName(a, b)
    end)
    table.sort(rest, byName)

    return preferred, rest
end

local function BuildTranslationSection(panel, y)
    local enable = CreateFrame("CheckButton", "WT_MainEnableCB", panel, "InterfaceOptionsCheckButtonTemplate")
    enable:SetPoint("TOPLEFT", MARGIN_X, y)
    _G[enable:GetName() .. "Text"]:SetText(L["UI_ENABLE_TEXT"])
    enable:SetChecked(WoWTranslatorDB.enabled)
    enable:SetScript("OnClick", function(self) WoWTranslatorDB.enabled = self:GetChecked() end)
    AddTooltip(enable, L["TT_ENABLE"])

    return y - 40
end

local function BuildColorSection(panel, y)
    local button = CreateFrame("Button", "WT_ColorBtn", panel, "UIPanelButtonTemplate")
    button:SetPoint("TOPLEFT", MARGIN_X + 4, y)
    button:SetSize(140, 22)
    button:SetText(L["UI_COLOR_BTN"])
    AddTooltip(button, L["TT_COLOR"])

    local preview = panel:CreateTexture(nil, "OVERLAY")
    preview:SetPoint("LEFT", button, "RIGHT", 12, 0)
    preview:SetSize(20, 20)

    local function CurrentRGB()
        local hex = WoWTranslatorDB.chatColor or "00ff00"
        return tonumber(hex:sub(1, 2), 16) / 255,
            tonumber(hex:sub(3, 4), 16) / 255,
            tonumber(hex:sub(5, 6), 16) / 255
    end

    local function UpdatePreview() preview:SetColorTexture(CurrentRGB()) end

    button:SetScript("OnClick", function()
        local r, g, b = CurrentRGB()
        ColorPickerFrame:SetupColorPickerAndShow({
            swatchFunc = function()
                local nr, ng, nb = ColorPickerFrame:GetColorRGB()
                WoWTranslatorDB.chatColor = string.format("%02x%02x%02x", nr * 255, ng * 255, nb * 255)
                UpdatePreview()
            end,
            hasOpacity = false,
            r = r, g = g, b = b,
        })
    end)
    UpdatePreview()

    return y - 44
end

local function BuildLanguageSection(panel, y)
    local dropdown = CreateFrame("Frame", "WT_LangDrop", panel, "UIDropDownMenuTemplate")
    dropdown:SetPoint("TOPLEFT", MARGIN_X - 12, y)
    UIDropDownMenu_SetWidth(dropdown, 200)
    AddTooltip(dropdown, L["TT_LANG"])

    -- pairs() daría un orden distinto cada vez que se abre el menú.
    local preferred, rest = SplitLanguages()

    UIDropDownMenu_Initialize(dropdown, function(self, level)
        local function AddEntry(code)
            local info = UIDropDownMenu_CreateInfo()
            info.text = LanguageName(code)
            info.value = code
            info.func = function(entry)
                WoWTranslatorDB.targetLocale = entry.value
                UIDropDownMenu_SetSelectedValue(dropdown, entry.value)
                UIDropDownMenu_SetText(dropdown, LanguageName(entry.value))
                addonTable.RebuildMasterDict()
            end
            info.checked = (WoWTranslatorDB.targetLocale == code)
            UIDropDownMenu_AddButton(info, level)
        end

        for _, code in ipairs(preferred) do AddEntry(code) end

        if #preferred > 0 and UIDropDownMenu_AddSeparator then
            UIDropDownMenu_AddSeparator(level)
        end

        for _, code in ipairs(rest) do AddEntry(code) end
    end)

    UIDropDownMenu_SetSelectedValue(dropdown, WoWTranslatorDB.targetLocale)
    UIDropDownMenu_SetText(dropdown, LanguageName(WoWTranslatorDB.targetLocale) or "Spanish (ES)")

    return y - 44
end

-- ------------------------------------------
-- VALORES POR DEFECTO
-- ------------------------------------------
-- Es destructivo y toca 48 casillas repartidas por cinco vistas, así que pide
-- confirmación. Después recarga la interfaz en vez de refrescar cada widget a
-- mano: los paneles se construyen una sola vez al entrar, y repintarlos todos
-- sería mucho andamiaje para dejar alguno desincronizado de todas formas.
StaticPopupDialogs["WOWTRANSLATOR_RESET"] = {
    text = L["RESET_CONFIRM"],
    -- ACCEPT y CANCEL son cadenas del propio juego: ya vienen traducidas y con
    -- el mismo texto que el resto de diálogos del cliente.
    button1 = ACCEPT,
    button2 = CANCEL,
    OnAccept = function()
        addonTable.ResetDatabase()
        ReloadUI()
    end,
    timeout = 0,       -- una acción destructiva no debe cerrarse sola
    whileDead = true,
    hideOnEscape = true,
    showAlert = true,  -- icono de advertencia
}

local function BuildResetSection(panel, y)
    local reset = CreateFrame("Button", "WT_ResetBtn", panel, "UIPanelButtonTemplate")
    reset:SetPoint("TOPLEFT", MARGIN_X + 4, y)
    reset:SetSize(180, 24)
    reset:SetText(L["UI_RESET"])
    reset:SetScript("OnClick", function()
        StaticPopup_Show("WOWTRANSLATOR_RESET")
    end)
    AddTooltip(reset, L["TT_RESET"])

    return y - 34
end

function addonTable.CreateGeneralUI(parentCategory)
    local panel = addonTable.CreateOptionsPanel("WoWTranslatorGeneralPanel", L["OPT_GENERAL"])
    local y = addonTable.PanelHeading(panel, L["OPT_GENERAL"])

    y = addonTable.SectionHeader(panel, y, L["GEN_HEADER"])
    y = BuildTranslationSection(panel, y)

    y = addonTable.SectionHeader(panel, y, L["UI_COLOR_BTN"])
    y = BuildColorSection(panel, y)

    y = addonTable.SectionHeader(panel, y, L["UI_LANG_LABEL"])
    y = BuildLanguageSection(panel, y)

    local test = CreateFrame("Button", "WT_TestBtn", panel, "UIPanelButtonTemplate")
    test:SetPoint("TOPLEFT", MARGIN_X + 4, y - 10)
    test:SetSize(180, 24)
    test:SetText(L["UI_TEST_BTN"])
    test:SetScript("OnClick", function() addonTable.RunTest() end)
    AddTooltip(test, L["TT_TEST_BTN"])
    y = y - 44

    BuildResetSection(panel, y)

    Settings.RegisterCanvasLayoutSubcategory(parentCategory, panel, panel.name)
end
