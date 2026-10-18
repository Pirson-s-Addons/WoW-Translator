local ADDON_NAME, addonTable = ...
addonTable = addonTable or WoWTranslatorNS -- clientes < 3.0 no pasan argumentos

-- ==========================================
-- PLANTILLAS: VOCABULARIO DE ORIGEN (inglés)
-- ==========================================
-- Palabra del chat -> { tipo, valor }. Lo lee Core/Templates.lua para entender
-- el mensaje; las frases de salida van en Data/Plantillas/<idioma>.lua.
-- Las instancias, clases y ciudades no están aquí: salen de los diccionarios
-- de Data/ que ya existen.
local W = {}
local function add(kind, value, ...)
    for i = 1, select("#", ...) do W[select(i, ...)] = { kind, value } end
end

-- Palabras que deciden el tipo de mensaje
add("trig", "lfm", "lfm", "lfmore")
add("trig", "lfg", "lfg", "lfgroup", "lfp")
add("trig", "lf", "lf", "looking", "lfa")
add("trig", "need", "need", "needs", "nd")
add("trig", "wts", "wts", "selling", "sell")
add("trig", "wtb", "wtb", "buying", "buy")
add("trig", "wtt", "wtt")
add("trig", "pc", "pc")
add("trig", "recruit", "recruiting", "recruit", "recruits", "recrutting")
add("trig", "lfw", "lfw")
add("trig", "anyone", "anyone", "any", "anybody", "someone")

-- Roles (el valor es la clave de forma en Data/Plantillas/<idioma>.lua)
add("role", "tank", "tank", "tanks", "tnk", "tnak", "tanker", "tankk")
add("role", "healer", "heal", "heals", "healer", "healers", "heler", "healr", "healz", "healers", "heals", "healar", "hlr")
add("role", "dps", "dps", "dd", "dsp", "rdps", "mdps", "damage", "dpser", "dpss")
add("all", true, "all")

-- Artesanos
add("artisan", "enchanter", "enchanter", "enchanters", "ench", "enchant", "encha", "enchaner", "enchanting")
add("artisan", "jewelcrafter", "jc", "jewelcrafter", "jeweler", "jeweller", "jcer")
add("artisan", "blacksmith", "bs", "blacksmith", "smith")
add("artisan", "alchemist", "alch", "alchemist", "alchy", "alchemy")
add("artisan", "tailor", "tailor", "tailoring")
add("artisan", "leatherworker", "lw", "leatherworker", "leatherworking")
add("artisan", "engineer", "engi", "engineer", "engineering", "eng")
add("artisan", "scribe", "scribe", "insc", "inscriptionist", "inscription")
add("artisan", "cook", "cook", "cooking")

-- Servicios
add("svc", "boost", "boost", "boosts", "boosting", "run", "runs", "carry", "carries")
add("svc", "port", "port", "ports", "portal", "portals", "tp")
add("svc", "summon", "summon", "summons", "sum", "summ", "sumon", "summ's")
add("svc", "water", "water", "food", "table", "mana biscuit")
add("svc", "lockpick", "lockpick", "lockpicking", "lockbox", "lockboxes", "pick", "box", "boxes")
add("svc", "rez", "rez", "res", "ress", "rezz", "resurrect")

-- Datos sueltos
add("diff", "normal", "nm", "normal", "norm")
add("diff", "heroic", "hc", "heroic", "hero", "h")
add("diff", "mythic", "mythic", "myth")
add("guild", true, "guild", "gld", "guilds")
add("quest", true, "quest", "quests", "q")
add("work", true, "work", "job", "jobs")
add("contact", true, "pst", "whisper", "w", "pm", "msg", "wisp", "/w")
add("inv", true, "inv", "invite", "invit")
add("go", true, "go", "asap", "now")
add("more", true, "more", "spot", "spots")
add("last", true, "last")
add("lvl", true, "lvl", "level", "lv", "lev")
add("mats", "mine", "have", "got")
add("mats", "mats", "mats", "materials", "mat")
add("mats", "yours", "your", "ur", "yours")
add("tips", true, "tips", "tip", "tipping")
add("free", true, "free")

-- Relleno: se acepta sin aportar nada
for _, w in ipairs({ "and", "&", "+", "for", "to", "the", "a", "an", "me", "my", "i", "pls", "plz",
    "please", "with", "then", "or", "of", "in", "at", "on", "we", "us", "you", "u", "is", "are",
    "x", "can", "who", "some", "few", "just", "also", "too", "ty", "thx", "-", "|", "!", ":)", "lets",
    "let's", "doing", "do", "group", "grp", "party", "people", "ppl", "player", "players", "fast",
    "quick", "chill", "help", "paying", "pay", "each", "ea", "raid", "team", "core", "roster",
    "our", "new", "active", "friendly", "looking", "join", "fresh", "full", "clear", "inc", "lf1", "from", "o/", "plus", "m+" }) do
    W[w] = W[w] or { "fill", true }
end

addonTable.TplWords = W

-- Frases fijas: el mensaje entero, ya normalizado (minúsculas, sin signos).
-- Patrón de Lua -> clave de frase; una captura numérica entra como {n}.
addonTable.TplFixed = {
    { "^any quests? to share$", "F_QUESTS_SHARE" },
    { "^anyone h[ae][sv]e? quests? to share$", "F_QUESTS_SHARE" },
    { "^quests? to share$", "F_QUESTS_SHARE" },
    { "^share quests?$", "F_QUESTS_SHARE" },
    { "^any quests?$", "F_ANY_QUEST" }, { "^anyone quests?$", "F_ANY_QUEST" }, { "^quests?$", "F_ANY_QUEST" },
    { "^inv pl[sz]$", "F_INV" }, { "^inv me$", "F_INV" }, { "^inv me pl[sz]$", "F_INV" },
    { "^x for inv$", "F_INV" }, { "^%+ for inv$", "F_INV" }, { "^1 for inv$", "F_INV" },
    { "^ginv$", "F_GINV" }, { "^ginv pl[sz]$", "F_GINV" }, { "^guild inv$", "F_GINV" },
    { "^guild inv pl[sz]$", "F_GINV" }, { "^g inv pl[sz]$", "F_GINV" },
    { "^ready$", "F_READY" }, { "^rdy$", "F_READY" }, { "^everyone ready$", "F_READY" },
    { "^all ready$", "F_READY" }, { "^r$", "F_READY" },
    { "^wait for mana$", "F_WAIT_MANA" }, { "^mana pl[sz]$", "F_WAIT_MANA" }, { "^wait mana$", "F_WAIT_MANA" },
    { "^need mana$", "F_NEED_MANA" }, { "^oom$", "F_NEED_MANA" },
    { "^go next$", "F_GO_NEXT" }, { "^next$", "F_GO_NEXT" }, { "^next boss$", "F_GO_NEXT" },
    { "^1 more pull$", "F_ONE_MORE_PULL" }, { "^one more pull$", "F_ONE_MORE_PULL" },
    { "^group up$", "F_GROUP_UP" }, { "^grp up$", "F_GROUP_UP" }, { "^wanna group$", "F_GROUP_UP" },
    { "^want to group$", "F_GROUP_UP" },
    { "^need help$", "F_NEED_HELP" }, { "^anyone need help$", "F_NEED_HELP" },
    { "^any rez$", "F_ANY_REZ" }, { "^any res$", "F_ANY_REZ" }, { "^rez pl[sz]$", "F_ANY_REZ" },
    { "^res pl[sz]$", "F_ANY_REZ" }, { "^need rez$", "F_ANY_REZ" }, { "^need res$", "F_ANY_REZ" },
    { "^pull in (%d+)$", "F_PULL_IN" }, { "^pulling in (%d+)$", "F_PULL_IN" }, { "^pull (%d+)$", "F_PULL_IN" },
    { "^brb (%d+) ?min$", "F_BRB_MIN" }, { "^brb (%d+) ?mins$", "F_BRB_MIN" }, { "^brb (%d+) ?m$", "F_BRB_MIN" },
    { "^wait$", "F_WAIT" }, { "^1 sec$", "F_WAIT" }, { "^sec$", "F_WAIT" }, { "^wait pl[sz]$", "F_WAIT" },
    { "^1 min$", "F_WAIT" },
}
