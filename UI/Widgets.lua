local ADDON_NAME, addonTable = ...
addonTable = addonTable or WoWTranslatorNS -- clientes < 3.0 no pasan argumentos
local L = addonTable.L

-- ==========================================
-- WIDGETS COMPARTIDOS
-- ==========================================
-- Las piezas que repiten todas las vistas del panel de opciones. Cada helper de
-- maquetación recibe la Y actual y devuelve la siguiente, así cada vista se lee
-- como la lista de sus secciones.

addonTable.MARGIN_X = 16

local MARGIN_X = addonTable.MARGIN_X
local HEADER_COLOR = "|cffC47FF3"

function addonTable.AddTooltip(frame, text)
    if not text then return end
    frame:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(text, nil, nil, nil, nil, true)
        GameTooltip:Show()
    end)
    frame:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)
end

-- Panel para registrar como categoría o subcategoría de las opciones del juego.
-- Nace OCULTO a propósito: un frame recién creado ya está visible, y entonces el
-- Show() con el que Settings navega hasta él no dispara OnShow.
function addonTable.CreateOptionsPanel(name, title)
    local panel = CreateFrame("Frame", name, UIParent)
    panel.name = title
    panel:SetWidth(615) -- tamaño estándar: evita que un ScrollFrame quede 0x0
    panel:SetHeight(580)
    panel:Hide()
    return panel
end

local LOGO = "Interface\\AddOns\\WoWTranslator\\img\\logo_wt"

-- Campo del .toc. GetAddOnMetadata se muda a C_AddOns en 11.0; antes es global.
function addonTable.GetMeta(field, fallback)
    local name = addonTable.NAME
    return (C_AddOns and C_AddOns.GetAddOnMetadata and C_AddOns.GetAddOnMetadata(name, field))
        or (GetAddOnMetadata and GetAddOnMetadata(name, field))
        or fallback
end

-- Título de una vista. Devuelve la Y en la que empieza el contenido. Con
-- `withLogo`, el logo de 110x110 y la versión arriba a la derecha (la vista
-- General); la línea se acorta para no cruzarlo.
function addonTable.PanelHeading(panel, text, withLogo)
    local heading = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    heading:SetPoint("TOPLEFT", MARGIN_X, -16)
    heading:SetText(addonTable.COLOR.brand .. text .. "|r")

    local line = panel:CreateTexture(nil, "ARTWORK")
    line:SetWidth(withLogo and 440 or 565)
    line:SetHeight(1)
    line:SetPoint("TOPLEFT", MARGIN_X, -42)
    addonTable.SetSolidColor(line, 1, 1, 1, 0.15)

    if withLogo then
        local logo = panel:CreateTexture(nil, "ARTWORK")
        logo:SetWidth(110)
        logo:SetHeight(110)
        logo:SetPoint("TOPRIGHT", -38, -5)
        logo:SetTexture(LOGO)

        local version = panel:CreateFontString(nil, "ARTWORK", "GameFontDisableSmall")
        version:SetPoint("TOP", logo, "BOTTOM", 0, -2)
        version:SetText("v" .. addonTable.GetMeta("Version", "?"))
    end

    return -62
end

-- Texto con un icono delante, para las etiquetas de las casillas.
function addonTable.IconLabel(texture, text)
    return "|T" .. texture .. ":16:16|t " .. text
end

-- Botones "Todas" / "Ninguna" a la derecha de una cabecera de sección. Cada
-- casilla trae su Apply(valor), que la marca y guarda el ajuste; `after` corre
-- una vez al final (reconstruir el diccionario, no 13 veces).
function addonTable.BulkButtons(parent, y, checkboxes, after)
    local function Make(text, tooltip, value, x)
        local button = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
        button:SetWidth(80)
        button:SetHeight(20)
        button:SetPoint("TOPLEFT", MARGIN_X + x, y + 3)
        button:SetText(text)
        button:SetScript("OnClick", function()
            for _, cb in ipairs(checkboxes) do cb.Apply(value) end
            if after then after() end
        end)
        addonTable.AddTooltip(button, tooltip)
    end
    Make(L["UI_ALL"], L["TT_ALL"], true, 395)
    Make(L["UI_NONE"], L["TT_NONE"], false, 480)
end

function addonTable.SectionHeader(parent, y, text, color)
    local fs = parent:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    fs:SetPoint("TOPLEFT", MARGIN_X, y)
    fs:SetText((color or HEADER_COLOR) .. text .. "|r")
    return y - 26
end

-- Rejilla de 3 columnas de casillas que activan una categoría de
-- WoWTranslatorDB.settings y reconstruyen el diccionario. `onChange` corre
-- después de cada cambio. Devuelve la Y siguiente y las casillas creadas.
function addonTable.SettingsCheckboxGrid(parent, items, y, namePrefix, onChange)
    local checkboxes = {}
    for i, info in ipairs(items) do
        local cb = CreateFrame("CheckButton", namePrefix .. info.key, parent, "InterfaceOptionsCheckButtonTemplate")
        local col, row = (i - 1) % 3, math.floor((i - 1) / 3)
        cb:SetPoint("TOPLEFT", MARGIN_X + (col * 180), y - (row * 26))

        local label = _G[cb:GetName() .. "Text"]
        label:SetText(info.text)
        label:SetFontObject(GameFontHighlightSmall)

        cb.Apply = function(value)
            cb:SetChecked(value)
            WoWTranslatorDB.settings[info.key] = value and true or false
        end
        cb:SetChecked(WoWTranslatorDB.settings[info.key])
        cb:SetScript("OnClick", function(self)
            WoWTranslatorDB.settings[info.key] = self:GetChecked() and true or false
            addonTable.RebuildMasterDict()
            if onChange then onChange() end
        end)
        addonTable.AddTooltip(cb, info.tt)
        checkboxes[i] = cb
    end
    return y - (math.ceil(#items / 3) * 26) - 15, checkboxes
end

-- Caja con una URL. En WoW un addon no puede ni abrir un enlace ni escribir en
-- el portapapeles, así que lo más lejos que se puede llegar es dejar el texto
-- seleccionado para que el jugador pulse Ctrl+C. El botón se llama
-- "Seleccionar" y no "Copiar" justamente porque no copia: prometer lo que
-- no hace acabaría en un reporte de fallo.
function addonTable.UrlBox(parent, y, label, url)
    local caption = parent:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    caption:SetPoint("TOPLEFT", MARGIN_X, y)
    caption:SetText(label)

    local box = CreateFrame("EditBox", nil, parent, "InputBoxTemplate")
    box:SetWidth(326)
    box:SetHeight(20)
    box:SetPoint("TOPLEFT", MARGIN_X + 120, y + 4)
    box:SetAutoFocus(false)
    box:SetTextColor(1, 1, 1)
    box:SetText(url)
    box:SetCursorPosition(0)
    -- Cualquier edición se descarta: la caja está solo para copiar de ella.
    box:SetScript("OnEditFocusGained", function(self) self:HighlightText() end)
    box:SetScript("OnTextChanged", function(self)
        if self:GetText() ~= url then self:SetText(url) end
    end)
    box:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
    box:SetScript("OnEnterPressed", function(self) self:ClearFocus() end)

    local copy = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
    copy:SetWidth(84)
    copy:SetHeight(20)
    copy:SetPoint("LEFT", box, "RIGHT", 10, 0)
    copy:SetText(L["UI_SELECT"])
    copy:SetScript("OnClick", function()
        box:SetFocus()
        box:HighlightText()
    end)
    addonTable.AddTooltip(copy, L["TT_SELECT"])

    return y - 26
end
