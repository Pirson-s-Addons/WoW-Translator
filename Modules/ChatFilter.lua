local ADDON_NAME, addonTable = ...
addonTable = addonTable or WoWTranslatorNS -- clientes < 3.0 no pasan argumentos

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
    -- Solo existe en retail: ahí vive buena parte de la jerga de LFG. En
    -- Classic el evento no se dispara nunca y el filtro sobra sin molestar.
    "CHAT_MSG_COMMUNITIES_CHANNEL",
}

local function Filter(self, event, text, author, ...)
    -- 2.4.3 llama al filtro solo con el mensaje, filter(msg), deja el evento en
    -- el global `event` y espera (descartar, mensajeNuevo). Desde 3.1 la firma
    -- es (chatFrame, event, msg, author, ...). Devolver de mas no le molesta.
    if type(self) == "string" then
        self, event, text = nil, _G.event, self
    end

    if not WoWTranslatorDB or not WoWTranslatorDB.enabled then return end

    local channels = WoWTranslatorDB.settings.channels
    if channels and channels[event] == false then return end

    local translated, changed = _G.TranslateChat(text)
    -- Devolver false deja pasar el mensaje; solo se reemplaza si hubo cambio.
    if changed then return false, translated, author, ... end
end

function addonTable.InstallChatFilter()
    -- En retail 12.x y en los Classic modernos la API real es ChatFrameUtil;
    -- ChatFrame_AddMessageEventFilter queda solo como alias en
    -- Blizzard_DeprecatedChatInfo, que Blizzard anuncia que quitara en la
    -- proxima expansion. Misma firma en las dos: (chatFrame, event, ...).
    local addFilter = (ChatFrameUtil and ChatFrameUtil.AddMessageEventFilter) or ChatFrame_AddMessageEventFilter
    for _, event in ipairs(addonTable.ChatEvents) do
        addFilter(event, Filter)
    end
end
