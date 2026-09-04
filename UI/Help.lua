local ADDON_NAME, addonTable = ...
local L = addonTable.L
local MARGIN_X = addonTable.MARGIN_X

-- ==========================================
-- VISTA: AYUDA
-- ==========================================
-- Cómo funciona, preguntas frecuentes y dónde reportar errores. Es la única
-- vista que puede crecer sin control, así que va dentro de un ScrollFrame.

local CURSEFORGE_URL = "https://www.curseforge.com/wow/addons/wow-translator"
local TEXT_WIDTH = 520

-- Las preguntas van en el orden en que se las hace alguien que acaba de
-- instalar el addon. La de /wt en reutiliza OUT_HELP, que ya existía.
local function Questions()
    return {
        { q = L["HELP_Q_SCOPE"],   a = L["HELP_A_SCOPE"] },
        { q = L["HELP_Q_TARGET"],  a = L["HELP_A_TARGET"] },
        { q = L["HELP_Q_COMPOSE"], a = L["OUT_HELP"], example = true },
        { q = L["HELP_Q_IGNORE"],  a = L["HELP_A_IGNORE"] },
        { q = L["HELP_Q_NOTHING"], a = L["HELP_A_NOTHING"] },
    }
end

local function Paragraph(parent, y, text, font, indent)
    local fs = parent:CreateFontString(nil, "ARTWORK", font)
    fs:SetPoint("TOPLEFT", MARGIN_X + (indent or 0), y)
    fs:SetWidth(TEXT_WIDTH - (indent or 0))
    fs:SetJustifyH("LEFT")
    fs:SetSpacing(2)
    fs:SetText(text)
    return y - fs:GetStringHeight() - 10
end

function addonTable.CreateHelpUI(parentCategory)
    local panel = addonTable.CreateOptionsPanel("WoWTranslatorHelpPanel", L["OPT_HELP"])
    addonTable.PanelHeading(panel, L["OPT_HELP"])

    local scrollFrame = CreateFrame("ScrollFrame", "WT_HelpScrollFrame", panel, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", 8, -56)
    scrollFrame:SetPoint("BOTTOMRIGHT", -34, 12)

    local content = CreateFrame("Frame", "WT_HelpScrollChild", scrollFrame)
    content:SetSize(TEXT_WIDTH + 40, 1)
    scrollFrame:SetScrollChild(content)

    local y = -4
    y = Paragraph(content, y, L["HELP_INTRO"], "GameFontHighlightSmall")
    y = y - 6

    -- Preguntas frecuentes
    y = addonTable.SectionHeader(content, y, L["HELP_FAQ"])
    local exampleText
    for _, entry in ipairs(Questions()) do
        y = Paragraph(content, y, addonTable.COLOR.gold .. entry.q .. "|r", "GameFontNormalSmall")
        y = y + 4
        y = Paragraph(content, y, entry.a, "GameFontHighlightSmall", 12)

        if entry.example then
            exampleText = content:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
            exampleText:SetPoint("TOPLEFT", MARGIN_X + 12, y + 4)
            exampleText:SetWidth(TEXT_WIDTH - 12)
            exampleText:SetJustifyH("LEFT")
            exampleText:SetSpacing(3)
            y = y - 34
        end
    end

    -- Reportar errores
    y = y - 6
    y = addonTable.SectionHeader(content, y, L["HELP_CONTACT"])
    y = Paragraph(content, y, L["HELP_CONTACT_TEXT"], "GameFontHighlightSmall", 12)
    y = addonTable.UrlBox(content, y, "CurseForge", CURSEFORGE_URL)

    content:SetHeight(math.abs(y) + 20)

    -- El ejemplo sale del diccionario vivo y pasa por el motor real, así que
    -- enseña el idioma destino que el jugador tenga puesto y no puede quedar
    -- desfasado. Solo se calcula al abrir la vista: construir el índice inverso
    -- cuesta ~8 ms y no lo paga quien nunca entre aquí.
    panel:SetScript("OnShow", function()
        if not exampleText then return end

        -- Dos términos que encajan como frase en cualquier idioma ("Necesito
        -- Sanador", "Suche Heiler"). Encadenar más deja de leerse como frase.
        local words = {}
        for _, term in ipairs({ "need", "healer" }) do
            local translated = addonTable.MasterDict[term]
            if translated then words[#words + 1] = translated end
        end

        local input = table.concat(words, " ")
        local output, changed = "", false
        if input ~= "" then output, changed = addonTable.TranslateOutgoing(input) end

        -- Con el inglés como destino no hay nada que invertir: sin ejemplo.
        exampleText:SetText(changed
            and (addonTable.COLOR.gold .. "/wt en " .. input .. "|r\n" ..
                addonTable.COLOR.white .. "      \226\134\146  " .. output .. "|r")
            or "")
    end)

    Settings.RegisterCanvasLayoutSubcategory(parentCategory, panel, panel.name)
end
