local ADDON_NAME, addonTable = ...
local L = addonTable.L

-- ==========================================
-- VISTA PRINCIPAL: ACERCA DE
-- ==========================================
-- La entrada raíz del addon en las opciones no lleva ajustes: presenta el addon
-- y deja los ajustes en las subcategorías, que es donde el jugador los busca.

local MARGIN_X = addonTable.MARGIN_X
local GITHUB_URL = "https://github.com/SrPirson/WoW-Translator"
local CURSEFORGE_URL = "https://www.curseforge.com/wow/addons/wow-translator"

local function Meta(field, fallback)
    return (C_AddOns and C_AddOns.GetAddOnMetadata and C_AddOns.GetAddOnMetadata(ADDON_NAME, field))
        or fallback
end

function addonTable.CreateAboutUI(panelTitle)
    local panel = addonTable.CreateOptionsPanel("WoWTranslatorPanel", panelTitle)

    local logo = panel:CreateTexture(nil, "ARTWORK")
    logo:SetSize(128, 128)
    logo:SetPoint("TOPLEFT", MARGIN_X + 8, -16)
    logo:SetTexture("Interface\\Addons\\WoWTranslator\\img\\logo_wt")

    local name = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalHuge")
    name:SetPoint("TOPLEFT", logo, "TOPRIGHT", 20, -18)
    name:SetText(addonTable.COLOR.brand .. "WoW Translator|r")

    local version = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    version:SetPoint("TOPLEFT", name, "BOTTOMLEFT", 0, -10)
    version:SetText(addonTable.COLOR.gold .. L["OPT_VERSION"] .. "|r " .. Meta("Version", "?"))

    local author = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    author:SetPoint("TOPLEFT", version, "BOTTOMLEFT", 0, -6)
    author:SetText(addonTable.COLOR.gold .. L["OPT_AUTHOR"] .. "|r " .. Meta("Author", "Pirson"))

    local desc = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    desc:SetPoint("TOPLEFT", MARGIN_X, -160)
    desc:SetWidth(560)
    desc:SetJustifyH("LEFT")
    desc:SetText(L["OPT_ABOUT_DESC"])

    local y = -200
    y = addonTable.SectionHeader(panel, y, L["OPT_LINKS"])
    y = addonTable.UrlBox(panel, y, "GitHub", GITHUB_URL)
    y = addonTable.UrlBox(panel, y, "CurseForge", CURSEFORGE_URL)
    y = y - 14

    y = addonTable.SectionHeader(panel, y, L["OPT_COMMANDS"])

    local commands = {
        { cmd = "/wt config",        desc = L["HELP_CONFIG_MSG"] },
        { cmd = "/wt on | off",      desc = L["HELP_ONOFF_MSG"] },
        { cmd = "/wt test",          desc = L["HELP_TEST_MSG"] },
        { cmd = "/wt search <word>", desc = L["HELP_SEARCH_MSG"] },
        { cmd = "/wt en <text>",     desc = L["HELP_OUT_MSG"] },
    }

    for _, entry in ipairs(commands) do
        local cmd = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
        cmd:SetPoint("TOPLEFT", MARGIN_X + 8, y)
        cmd:SetText(addonTable.COLOR.gold .. entry.cmd .. "|r")

        local text = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
        text:SetPoint("TOPLEFT", MARGIN_X + 160, y)
        text:SetWidth(400)
        text:SetJustifyH("LEFT")
        text:SetText(entry.desc)

        y = y - 20
    end

    return panel
end
