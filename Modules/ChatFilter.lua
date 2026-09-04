local ADDON_NAME, addonTable = ...

-- ==========================================
-- FILTRO DE CHAT
-- ==========================================

-- Canales que el addon filtra. Esta lista es la única fuente: Core/Init.lua la
-- usa para sembrar los ajustes por defecto y aquí se usa para registrar el
-- filtro, así que no pueden desincronizarse.
addonTable.ChatEvents = {
    "CHAT_MSG_SAY", "CHAT_MSG_YELL", "CHAT_MSG_WHISPER", "CHAT_MSG_WHISPER_INFORM",
    "CHAT_MSG_BN_WHISPER", "CHAT_MSG_BN_WHISPER_INFORM", "CHAT_MSG_BN_INLINE_WHISPER",
    "CHAT_MSG_BN_INLINE_WHISPER_INFORM", "CHAT_MSG_PARTY", "CHAT_MSG_PARTY_LEADER",
    "CHAT_MSG_RAID", "CHAT_MSG_RAID_LEADER", "CHAT_MSG_RAID_WARNING",
    "CHAT_MSG_INSTANCE_CHAT", "CHAT_MSG_INSTANCE_CHAT_LEADER", "CHAT_MSG_GUILD",
    "CHAT_MSG_OFFICER", "CHAT_MSG_CHANNEL", "CHAT_MSG_EMOTE", "CHAT_MSG_BATTLEGROUND",
    "CHAT_MSG_BATTLEGROUND_LEADER",
}

local function Filter(self, event, text, author, ...)
    if not WoWTranslatorDB or not WoWTranslatorDB.enabled then return end

    local channels = WoWTranslatorDB.settings.channels
    if channels and channels[event] == false then return end

    local translated, changed = _G.TranslateChat(text)
    -- Devolver false deja pasar el mensaje; solo se reemplaza si hubo cambio.
    if changed then return false, translated, author, ... end
end

function addonTable.InstallChatFilter()
    for _, event in ipairs(addonTable.ChatEvents) do
        ChatFrame_AddMessageEventFilter(event, Filter)
    end
end
