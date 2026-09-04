local ADDON_NAME, addonTable = ...
local L = addonTable.L
local MARGIN_X = addonTable.MARGIN_X

-- ==========================================
-- VISTA: CANALES DE CHAT
-- ==========================================
-- En qué canales actúa el filtro. Se guarda por evento en
-- WoWTranslatorDB.settings.channels y lo lee Modules/ChatFilter.lua.

local function ChannelGroups()
    return {
        {
            header = L["CH_CAT_GENERAL"],
            events = {
                { name = L["CH_SAY"],     ev = "CHAT_MSG_SAY" },
                { name = L["CH_YELL"],    ev = "CHAT_MSG_YELL" },
                { name = L["CH_EMOTE"],   ev = "CHAT_MSG_EMOTE" },
                { name = L["CH_CHANNEL"], ev = "CHAT_MSG_CHANNEL" },
            },
        },
        {
            header = L["CH_CAT_WHISPERS"],
            events = {
                { name = L["CH_WHISPER"],                  ev = "CHAT_MSG_WHISPER" },
                { name = L["CH_WHISPER_INFORM"],           ev = "CHAT_MSG_WHISPER_INFORM" },
                { name = L["CH_BN_WHISPER"],               ev = "CHAT_MSG_BN_WHISPER" },
                { name = L["CH_BN_WHISPER_INFORM"],        ev = "CHAT_MSG_BN_WHISPER_INFORM" },
                { name = L["CH_BN_INLINE_WHISPER"],        ev = "CHAT_MSG_BN_INLINE_WHISPER" },
                { name = L["CH_BN_INLINE_WHISPER_INFORM"], ev = "CHAT_MSG_BN_INLINE_WHISPER_INFORM" },
            },
        },
        {
            header = L["CH_CAT_GUILD"],
            events = {
                { name = L["CH_GUILD"],   ev = "CHAT_MSG_GUILD" },
                { name = L["CH_OFFICER"], ev = "CHAT_MSG_OFFICER" },
            },
        },
        {
            header = L["CH_CAT_GROUP"],
            events = {
                { name = L["CH_PARTY"],           ev = "CHAT_MSG_PARTY" },
                { name = L["CH_PARTY_LEADER"],    ev = "CHAT_MSG_PARTY_LEADER" },
                { name = L["CH_INSTANCE"],        ev = "CHAT_MSG_INSTANCE_CHAT" },
                { name = L["CH_INSTANCE_LEADER"], ev = "CHAT_MSG_INSTANCE_CHAT_LEADER" },
            },
        },
        {
            header = L["CH_CAT_RAID"],
            events = {
                { name = L["CH_RAID"],         ev = "CHAT_MSG_RAID" },
                { name = L["CH_RAID_LEADER"],  ev = "CHAT_MSG_RAID_LEADER" },
                { name = L["CH_RAID_WARNING"], ev = "CHAT_MSG_RAID_WARNING" },
            },
        },
        {
            header = L["CH_CAT_PVP"],
            events = {
                { name = L["CH_BATTLEGROUND"],        ev = "CHAT_MSG_BATTLEGROUND" },
                { name = L["CH_BATTLEGROUND_LEADER"], ev = "CHAT_MSG_BATTLEGROUND_LEADER" },
            },
        },
    }
end

function addonTable.CreateChannelsUI(parentCategory)
    local panel = addonTable.CreateOptionsPanel("WoWTranslatorChannelsPanel", L["OPT_CHANNELS"])
    local y = addonTable.PanelHeading(panel, L["OPT_CHANNELS"])

    local created = 0
    for _, group in ipairs(ChannelGroups()) do
        local header = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
        header:SetPoint("TOPLEFT", MARGIN_X, y)
        header:SetText("|cffe0c0f5" .. group.header .. "|r")
        y = y - 20

        local lastRow = 0
        for i, info in ipairs(group.events) do
            created = created + 1
            local cb = CreateFrame("CheckButton", "WT_CH_CB_" .. created, panel,
                "InterfaceOptionsCheckButtonTemplate")
            local col = (i - 1) % 3
            lastRow = math.floor((i - 1) / 3)
            cb:SetPoint("TOPLEFT", MARGIN_X + 8 + (col * 180), y - (lastRow * 24))

            local label = _G[cb:GetName() .. "Text"]
            label:SetText(info.name)
            label:SetFontObject("GameFontHighlightSmall")

            -- nil cuenta como activo: un canal nuevo se traduce por defecto.
            cb:SetChecked(WoWTranslatorDB.settings.channels[info.ev] ~= false)
            cb:SetScript("OnClick", function(self)
                WoWTranslatorDB.settings.channels[info.ev] = self:GetChecked()
            end)
            addonTable.AddTooltip(cb, L["TT_CH_GENERIC"])
        end
        y = y - (lastRow * 24) - 32
    end

    Settings.RegisterCanvasLayoutSubcategory(parentCategory, panel, panel.name)
end
