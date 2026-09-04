local ADDON_NAME, addonTable = ...
local L = addonTable.L
local AddTooltip = addonTable.AddTooltip

-- ==========================================
-- SUBCATEGORÍA: PALABRAS IGNORADAS
-- ==========================================
-- Lista negra del jugador. La comprueba Core/Dictionary.lua al construir, así
-- que una palabra ignorada ni siquiera entra en el diccionario: el motor de
-- chat no paga nada por ella.

local ROW_HEIGHT = 26

function addonTable.CreateIgnoreListUI(parentCategory)
    local panel = addonTable.CreateOptionsPanel("WoWTranslatorIgnorePanel", L["IGN_TITLE"])
    local y = addonTable.PanelHeading(panel, L["IGN_TITLE"])

    local desc = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    desc:SetPoint("TOPLEFT", 16, y)
    desc:SetWidth(560)
    desc:SetJustifyH("LEFT")
    desc:SetText(L["IGN_DESC"])

    -- Alta
    local input = CreateFrame("EditBox", "WT_IgnoreInput", panel, "InputBoxTemplate")
    input:SetSize(300, 22)
    input:SetPoint("TOPLEFT", 22, y - 40)
    input:SetAutoFocus(false)
    AddTooltip(input, L["IGN_INPUT_TT"])

    local addBtn = CreateFrame("Button", "WT_IgnoreAddBtn", panel, "UIPanelButtonTemplate")
    addBtn:SetSize(100, 22)
    addBtn:SetPoint("LEFT", input, "RIGHT", 10, 0)
    addBtn:SetText(L["IGN_ADD"])

    -- Listado
    local scrollFrame = CreateFrame("ScrollFrame", "WT_IgnoreScrollFrame", panel, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", 16, y - 76)
    scrollFrame:SetPoint("BOTTOMRIGHT", -40, 16)

    local scrollChild = CreateFrame("Frame", "WT_IgnoreScrollChild", scrollFrame)
    scrollChild:SetSize(540, 1)
    scrollFrame:SetScrollChild(scrollChild)

    local empty = scrollChild:CreateFontString(nil, "ARTWORK", "GameFontDisableSmall")
    empty:SetPoint("TOPLEFT", 6, -6)
    empty:SetText(L["IGN_EMPTY"])

    local rows = {}
    local Refresh

    local function CreateRow(index)
        local row = CreateFrame("Frame", nil, scrollChild)
        row:SetSize(500, 24)
        row:SetPoint("TOPLEFT", 6, -((index - 1) * ROW_HEIGHT))

        -- Campo bloqueado: sin ratón ni teclado no hay forma de escribir en él.
        -- NO se usa :Disable() — una EditBox deshabilitada pinta el texto con el
        -- color atenuado y no repinta tras SetText, así que sobre el fondo
        -- oscuro del panel la palabra se volvía invisible.
        row.label = CreateFrame("EditBox", nil, row, "InputBoxTemplate")
        row.label:SetSize(420, 22)
        row.label:SetPoint("LEFT", 8, 0)
        row.label:SetAutoFocus(false)
        row.label:EnableMouse(false)
        row.label:EnableKeyboard(false)
        row.label:SetTextColor(1, 1, 1)

        row.del = CreateFrame("Button", nil, row, "UIPanelButtonTemplate")
        row.del:SetSize(24, 22)
        row.del:SetPoint("LEFT", row.label, "RIGHT", 10, 0)
        row.del:SetText(addonTable.COLOR.red .. "X|r")
        AddTooltip(row.del, L["IGN_REMOVE_TT"])

        return row
    end

    local function Remove(word)
        WoWTranslatorDB.ignored[word] = nil
        addonTable.RebuildMasterDict()
        Refresh()
    end

    local function Add(raw)
        local word = raw and raw:gsub("^%s*(.-)%s*$", "%1"):lower()
        if not word or word == "" then return end
        WoWTranslatorDB.ignored[word] = true
        addonTable.RebuildMasterDict()
        Refresh()
    end

    Refresh = function()
        local words = {}
        for word in pairs(WoWTranslatorDB.ignored) do words[#words + 1] = word end
        table.sort(words)
        empty:SetShown(#words == 0)

        for i, word in ipairs(words) do
            local row = rows[i]
            if not row then
                row = CreateRow(i)
                rows[i] = row
            end
            row.label:SetText(word)
            row.label:SetCursorPosition(0) -- una palabra larga debe verse desde el principio
            row.del:SetScript("OnClick", function() Remove(word) end)
            row:Show()
        end

        for i = #words + 1, #rows do rows[i]:Hide() end
        scrollChild:SetHeight(math.max(1, #words * ROW_HEIGHT))
    end

    local function Submit()
        Add(input:GetText())
        input:SetText("")
        input:ClearFocus()
    end

    addBtn:SetScript("OnClick", Submit)
    input:SetScript("OnEnterPressed", Submit)
    input:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)

    -- En OnShow por si la lista cambió desde fuera, y una vez ahora para no
    -- depender de que OnShow llegue a dispararse.
    panel:SetScript("OnShow", Refresh)
    Refresh()

    Settings.RegisterCanvasLayoutSubcategory(parentCategory, panel, panel.name)
end
