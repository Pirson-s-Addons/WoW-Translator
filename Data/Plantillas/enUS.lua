local ADDON_NAME, addonTable = ...
addonTable = addonTable or WoWTranslatorNS -- clientes < 3.0 no pasan argumentos

-- ==========================================
-- PLANTILLAS: FRASES EN INGLÉS (enUS)
-- ==========================================
-- Una tabla por idioma destino, no por idioma del cliente: se cargan todas.
-- {n}, {roles}, {inst}... son huecos con nombre, así cada idioma ordena la
-- frase a su manera. Siempre en la voz del que escribe el mensaje. Es también
-- la reserva de los idiomas que no tienen tabla propia.
addonTable.Plantillas = addonTable.Plantillas or {}
addonTable.Plantillas.enUS = {
    plural = function(n) return n == 1 and "one" or "other" end,
    SEP = ", ", AND = " and ", WHO_SEP = " / ",
    COUNT = "{n} {role}", LEVEL = "level {n}", ALL = "all classes",
    DIFF_normal = "normal", DIFF_heroic = "heroic", DIFF_mythic = "mythic",
    roles = {
        tank = { one = "tank", other = "tanks" },
        healer = { one = "healer", other = "healers" },
        dps = "DPS",
    },
    artisans = {
        enchanter = "an enchanter", jewelcrafter = "a jewelcrafter", blacksmith = "a blacksmith",
        alchemist = "an alchemist", tailor = "a tailor", leatherworker = "a leatherworker",
        engineer = "an engineer", scribe = "a scribe", cook = "a cook",
    },

    REC_ROLES = "Looking for {roles}.",
    REC_ROLES_INST = "Looking for {roles} for {inst}.",
    REC_MORE = "Looking for {n} more.",
    REC_MORE_INST = "Looking for {n} more for {inst}.",
    REC_INST = "Looking for people for {inst}.",
    REC_ALL = "Looking for anyone.",
    REC_ALL_INST = "Looking for anyone for {inst}.",
    LFG = "Looking for a group.",
    LFG_INST = "Looking for a group for {inst}.",
    LFG_WHO = "{who}, looking for a group.",
    LFG_WHO_INST = "{who}, looking for a group for {inst}.",
    QUEST_GROUP = "Looking for a group for {quest}.",
    QUEST_GROUP_ANY = "Looking for a group for a quest.",
    Q_ANY_INST = "Anyone up for {inst}?",
    LF_ITEM = "Looking for {items}.",

    WTS = "Selling {items}.",
    WTS_PRICE = "Selling {items} for {price}.",
    WTB = "Buying {items}.",
    WTB_PRICE = "Buying {items}, paying {price}.",
    WTT = "Trading {items}.",
    WTT_FOR = "Trading {a} for {b}.",
    PC = "How much is {items} worth?",
    WTS_BOOST = "Selling runs in {inst}.",
    WTS_BOOST_PRICE = "Selling runs in {inst} for {price}.",
    WTS_PORT = "Selling portals.",
    WTS_PORT_PLACE = "Selling portals to {place}.",
    WTS_SUMMON = "Selling summons.",

    LF_CRAFTER = "Looking for {artisan}.",
    LF_CRAFTER_ITEM = "Looking for {artisan} for {items}.",
    CRAFTER_LFW = "I'm {artisan}, looking for work.",
    LF_SUMMON = "Looking for a summon.",
    LF_SUMMON_PLACE = "Looking for a summon to {place}.",
    LF_PORT = "Looking for a portal.",
    LF_PORT_PLACE = "Looking for a portal to {place}.",
    LF_WATER = "Looking for a mage to give me water.",
    LF_LOCKPICK = "Looking for a rogue to open a lockbox.",
    LF_LOCKPICK_ITEM = "Looking for a rogue to open {items}.",
    NEED_REZ = "I need a resurrection.",

    GUILD_RECRUIT = "My guild is recruiting {who}.",
    GUILD_RECRUIT_ANY = "My guild is recruiting.",
    GUILD_NAMED = "{guild} is recruiting {who}.",
    GUILD_NAMED_ANY = "{guild} is recruiting.",
    LF_GUILD = "Looking for a guild.",
    LF_GUILD_WHO = "{who}, looking for a guild.",

    S_PRICE = "Price: {price}.",
    S_MYMATS = "I have the materials.",
    S_YOURMATS = "With your materials.",
    S_TIP_GIVE = "I'll tip.",
    S_TIP_TAKE = "Tips welcome.",
    S_FREE = "Free.",
    S_LASTSPOT = "Last spot.",
    S_GO = "We leave right away.",
    S_WHISPER = "Whisper me.",

    F_QUESTS_SHARE = "Does anyone have quests to share?",
    F_ANY_QUEST = "Any quests?",
    F_INV = "Invite me, please.",
    F_GINV = "Can you invite me to the guild?",
    F_READY = "Everyone ready?",
    F_WAIT_MANA = "Wait, I'm getting my mana back.",
    F_NEED_MANA = "I need mana.",
    F_GO_NEXT = "Let's go to the next one.",
    F_ONE_MORE_PULL = "One more pull.",
    F_GROUP_UP = "Want to group up?",
    F_NEED_HELP = "Does anyone need help?",
    F_ANY_REZ = "Can someone resurrect me?",
    F_PULL_IN = "Pulling in {n} s.",
    F_BRB_MIN = "Back in {n} min.",
    F_WAIT = "Wait a moment.",
}
