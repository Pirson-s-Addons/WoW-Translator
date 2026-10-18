local ADDON_NAME, addonTable = ...
addonTable = addonTable or WoWTranslatorNS -- clientes < 3.0 no pasan argumentos

-- ==========================================
-- PLANTILLAS: FRASE COMPLETA
-- ==========================================
-- Reconoce los mensajes de fórmula del chat ("LFM ICC 25 HC need 2 heal",
-- "WTS [objeto] 500g", "lf enchanter") y escribe la frase entera en el idioma
-- destino, en la voz del que escribe. Si no entiende casi todo el mensaje no
-- dice nada: es mejor anotar palabra a palabra que inventarse una frase.
-- Diseño y catálogo: _project/docs/WoWTranslator/plantillas.md.

local ipairs, pairs, tonumber, type = ipairs, pairs, tonumber, type
local string_find, string_gmatch, string_gsub, string_lower, string_match, string_upper =
    string.find, string.gmatch, string.gsub, string.lower, string.match, string.upper
local table_concat, table_sort = table.concat, table.sort

-- Cuánto del mensaje tiene que entender para atreverse con la frase.
local MIN_COVERAGE = 0.8

local INST_DICTS = { "ClassicDict", "TBCDict", "WotLKDict", "CataDict", "MoPDict", "WoDDict",
    "LegionDict", "BfADict", "ShadowlandsDict", "DragonflightDict", "TheWarWithinDict",
    "MidnightDict", "ForeverDict" }
local PVP_KEYS = { "bg", "rbg", "ab", "av", "wsg", "2s", "3s", "5s" }
local CITY_KEYS = { "org", "orgri", "sw", "storm", "tb", "uc" }
local CLASS_KEYS = { "warrior", "warr", "paladin", "pala", "hunter", "hunt", "deathknight", "dk",
    "rogue", "mage", "priest", "druid", "dudu", "shaman", "monk", "warlock", "lock",
    "demonhunter", "dh", "evoker", "evo" }
local NOT_SPECS = { ms = true, os = true }
local SIZES = { [5] = true, [10] = true, [20] = true, [25] = true, [40] = true }

-- ------------------------------------------
-- ÍNDICE DE NOMBRES (instancias, ciudades, clases)
-- ------------------------------------------
-- Frases de varias palabras indexadas por la primera, la más larga primero.
-- Se rehace cuando Core/Dictionary.lua sube dictVersion, como Core/Outgoing.lua.
local Names, namesVersion = {}, nil

local function Words(s)
    local list = {}
    for w in string_gmatch(string_gsub(string_lower(s), "[%(%),%.:]", " "), "%S+") do list[#list + 1] = w end
    return list
end

local function AddName(phrase, kind, entry)
    local words = Words(phrase)
    if not words[1] then return end
    local bucket = Names[words[1]]
    if not bucket then bucket = {}; Names[words[1]] = bucket end
    bucket[#bucket + 1] = { words = words, kind = kind, entry = entry }
end

local function BuildNames()
    for k in pairs(Names) do Names[k] = nil end
    for _, name in ipairs(INST_DICTS) do
        for key, entry in pairs(addonTable[name] or {}) do
            AddName(key, "inst", entry)
            if entry.enUS then AddName(entry.enUS, "inst", entry) end
        end
    end
    local combat, core, classes = addonTable.CombateDict or {}, addonTable.InstanciasCoreDict or {}, addonTable.ClasesDict or {}
    for _, key in ipairs(PVP_KEYS) do if combat[key] then AddName(key, "inst", combat[key]) end end
    for _, key in ipairs(CITY_KEYS) do if core[key] then AddName(key, "place", core[key]) end end
    local isClass = {}
    for _, key in ipairs(CLASS_KEYS) do
        isClass[key] = true
        if classes[key] then AddName(key, "class", classes[key]) end
    end
    for key, entry in pairs(classes) do
        if not isClass[key] and not NOT_SPECS[key] then AddName(key, "spec", entry) end
    end
    for _, bucket in pairs(Names) do
        table_sort(bucket, function(a, b) return #a.words > #b.words end)
    end
    namesVersion = addonTable.dictVersion
end

local function MatchName(toks, i)
    local bucket = Names[toks[i]]
    if not bucket then return end
    for _, cand in ipairs(bucket) do
        local ok = true
        for j = 2, #cand.words do
            if toks[i + j - 1] ~= cand.words[j] then ok = false; break end
        end
        if ok then return cand, #cand.words end
    end
end

-- ------------------------------------------
-- TROCEAR EL MENSAJE
-- ------------------------------------------
-- Los enlaces se apartan enteros (con su color) y quedan como "\1N"; el nombre
-- de una hermandad entre <> como "\2". Lo demás, a minúsculas y sin signos.
-- El color puede ser "|cffRRGGBB" o el de calidad de objeto de retail y
-- Forever, "|cnIQ1:".
local function Tokenize(text, links, guild)
    text = string_gsub(text, "(|c[^|]*|H(%a+):.-|h.-|h|r)", function(link, kind)
        links[#links + 1] = { link = link, kind = kind }
        return " \1" .. #links .. " "
    end)
    text = string_gsub(text, "(|H(%a+):.-|h.-|h)", function(link, kind)
        links[#links + 1] = { link = link, kind = kind }
        return " \1" .. #links .. " "
    end)
    text = string_gsub(text, "<([^>]+)>", function(name) guild.name = "<" .. name .. ">"; return " \2 " end)
    text = string_gsub(text, "|c[^|]*", "")
    text = string_gsub(text, "|[rT][^|]*|?t?", " ")
    text = string_gsub(text, "{[^}]*}", " ") -- iconos de banda {rt1}, {skull}
    text = string_lower(text)
    text = string_gsub(text, "/w%f[%A]", " pst ")
    text = string_gsub(text, "[,;!?&()%[%]\"=/]", " ")
    text = string_gsub(text, "(%a)%+(%a)", "%1 %2")
    text = string_gsub(text, "%.+(%s)", "%1")
    text = string_gsub(text, "%.+$", "")
    local toks = {}
    for w in string_gmatch(text, "%S+") do toks[#toks + 1] = w end
    return toks
end

-- ------------------------------------------
-- LEER EL MENSAJE
-- ------------------------------------------
local function Read(text)
    local links, guild = {}, {}
    local toks = Tokenize(text, links, guild)
    if #toks == 0 or #toks > 30 then return end

    local W = addonTable.TplWords
    local m = { trig = {}, svc = {}, roles = {}, who = {}, items = {}, quests = {}, artisans = {},
        pos = {}, mats = {}, guildName = guild.name }
    local known, i = 0, 1
    local lastRole

    local function Role(role, n)
        lastRole = { role = role, n = n }
        m.roles[#m.roles + 1] = lastRole
        m.pos.role = m.pos.role or i
    end

    while i <= #toks do
        local w = toks[i]
        local nextW = toks[i + 1]
        local step, ok = 1, true
        local cand, len = MatchName(toks, i)
        local entry = W[w]
        local num = tonumber(w)

        if cand and (len > 1 or not entry) then
            step = len
            if cand.kind == "inst" then
                m.inst = m.inst or { entry = cand.entry }
            elseif cand.kind == "place" then
                m.place = m.place or cand.entry
            elseif cand.kind == "spec" then
                local after = MatchName(toks, i + 1)
                if after and after.kind == "class" then
                    m.who[#m.who + 1] = { class = after.entry, spec = cand.entry }
                    step = 2
                else
                    m.who[#m.who + 1] = { class = cand.entry }
                end
                m.pos.role = m.pos.role or i
            else
                m.who[#m.who + 1] = { class = cand.entry }
                m.pos.role = m.pos.role or i
            end
        elseif string_match(w, "^\1%d+$") then
            local link = links[tonumber(w:sub(2))]
            if link.kind == "quest" or link.kind == "questie" then
                m.quests[#m.quests + 1] = link.link
            else
                m.items[#m.items + 1] = link.link
            end
        elseif w == "\2" then
            m.guildFlag = true
        elseif string_match(w, "^lf(%d)m$") then
            m.trig.lfm = true; m.pos.trig = m.pos.trig or i
            m.more = tonumber(string_match(w, "^lf(%d)m$"))
        elseif string_match(w, "^%+(%d+)$") then
            m.key = string_match(w, "^%+(%d+)$")
        elseif string_match(w, "^(%d%d)(%a+)$") and SIZES[tonumber(string_match(w, "^(%d%d)"))]
            and not string_match(w, "^%d+[gsck]$") then -- "10g" es oro, no una banda de 10
            -- 25hc, 10m, 25man, 40m
            local size, suffix = string_match(w, "^(%d%d)(%a+)$")
            if suffix == "m" or suffix == "man" or suffix == "ppl" then
                m.size = size
            elseif W[suffix] and W[suffix][1] == "diff" then
                m.size, m.diff = size, W[suffix][2]
            else
                ok = false
            end
        elseif string_match(w, "^%d+[%.,]?%d*[gsck]$") or string_match(w, "^%d+[%.,]?%d*gold$") then
            m.price = w
        elseif string_match(w, "^(%d+)%+$") then
            m.level = string_match(w, "^(%d+)%+$") .. "+"
        elseif string_match(w, "^x(%d)$") or string_match(w, "^(%d)x$") then
            local n = tonumber(string_match(w, "(%d)"))
            if lastRole then lastRole.n = n else ok = false end
        elseif num then
            local nextEntry = nextW and W[nextW]
            local nextName = MatchName(toks, i + 1)
            if nextW == "g" or nextW == "gold" then
                m.price, step = w .. "g", 2
            elseif nextEntry and nextEntry[1] == "role" then
                Role(nextEntry[2], num); step = 2
            elseif nextEntry and nextEntry[1] == "more" then
                m.more = num; step = 2
            elseif nextName and nextName.kind == "class" and num < 10 then
                m.who[#m.who + 1] = { class = nextName.entry, n = num }
                m.pos.role = m.pos.role or i
                step = 2
            elseif toks[i - 1] and W[toks[i - 1]] and W[toks[i - 1]][1] == "lvl" then
                m.level = w
            elseif nextName and nextName.kind == "class" then
                m.level = w
            elseif m.inst and SIZES[num] and not m.size then
                m.size = w
            elseif (m.trig.need or m.trig.lfm) and num < 10 then
                m.more = num
            else
                ok = false
            end
        elseif entry then
            local kind, value = entry[1], entry[2]
            if kind == "trig" then
                m.trig[value] = true
                m.pos[value] = m.pos[value] or i
            elseif kind == "role" then
                Role(value)
            elseif kind == "artisan" then
                m.artisans[#m.artisans + 1] = value
            elseif kind == "svc" then
                m.svc[value] = true
            elseif kind == "diff" then
                m.diff = value
            elseif kind == "mats" then
                m.mats[value] = true
            elseif kind ~= "fill" then
                m[kind] = value
                m.pos[kind] = m.pos[kind] or i
            end
        else
            ok = false
        end

        if ok then known = known + step end
        i = i + step
    end

    if known / #toks < MIN_COVERAGE then return end
    return m
end

-- ------------------------------------------
-- ESCRIBIR LA FRASE
-- ------------------------------------------
local P, EN, target

local function S(key) return P[key] or EN[key] end

local function Fill(key, slots)
    local s = S(key)
    if not s then return end
    return (string_gsub(s, "{(%a+)}", function(k) return slots[k] or "" end))
end

local function Name(entry)
    return entry[target] or (target == "esMX" and entry.esES) or entry.enUS or entry.esES
end

local function Join(list)
    if #list <= 1 then return list[1] or "" end
    return table_concat(list, S("SEP"), 1, #list - 1) .. S("AND") .. list[#list]
end

local function Form(forms, n)
    if type(forms) == "string" then return forms end
    local key = n and P.plural and P.plural(n) or "one"
    return forms[key] or forms.other or forms.one
end

local function RoleText(role, n)
    local forms = (P.roles and P.roles[role]) or EN.roles[role]
    local word = Form(forms, n)
    if not n then return word end
    return Fill("COUNT", { n = n, role = word })
end

local function WhoText(who)
    local name = Name(who.class)
    if who.spec then name = name .. " (" .. Name(who.spec) .. ")" end
    if who.n then return Fill("COUNT", { n = who.n, role = name }) end
    return name
end

local function Roles(m, counted)
    local list = {}
    for _, r in ipairs(m.roles) do list[#list + 1] = RoleText(r.role, counted and r.n) end
    for _, w in ipairs(m.who) do list[#list + 1] = WhoText(w) end
    return list
end

local function InstText(m)
    if not m.inst then return end
    local text = Name(m.inst.entry)
    if m.size then text = text .. " " .. m.size end
    if m.key then
        text = text .. " +" .. m.key
    elseif m.diff then
        text = text .. " (" .. S("DIFF_" .. m.diff) .. ")"
    end
    return text
end

-- "artisansNom": los idiomas con casos (ruso, polaco, checo) usan otra forma
-- cuando el artesano es el que habla ("Энчантер, ищу работу").
local function ArtisanText(m, speaking)
    local list = (speaking and P.artisansNom) or P.artisans or EN.artisans
    return Form(list[m.artisans[1]] or EN.artisans[m.artisans[1]])
end

local function WithPlace(base, m)
    if m.place then return Fill(base .. "_PLACE", { place = Name(m.place) }) end
    if m.inst then return Fill(base .. "_PLACE", { place = Name(m.inst.entry) }) end
    return Fill(base, {})
end

local function Trade(m)
    local t = m.trig
    local items = Join(m.items)
    if t.wts then
        if m.svc.port then return WithPlace("WTS_PORT", m), "price" end
        if m.svc.summon then return Fill("WTS_SUMMON", {}), "price" end
        if m.svc.boost and m.inst then
            return Fill(m.price and "WTS_BOOST_PRICE" or "WTS_BOOST", { inst = InstText(m), price = m.price })
        end
        if m.items[1] then
            return Fill(m.price and "WTS_PRICE" or "WTS", { items = items, price = m.price })
        end
    elseif t.wtb then
        if m.svc.summon then return WithPlace("LF_SUMMON", m), "price" end
        if m.svc.port then return WithPlace("LF_PORT", m), "price" end
        if m.items[1] then
            return Fill(m.price and "WTB_PRICE" or "WTB", { items = items, price = m.price })
        end
    elseif t.wtt then
        if #m.items == 2 then return Fill("WTT_FOR", { a = m.items[1], b = m.items[2] }) end
        if m.items[1] then return Fill("WTT", { items = items }) end
    elseif t.pc and m.items[1] then
        return Fill("PC", { items = items })
    end
end

local function Guild(m)
    local who = Roles(m)
    local slots = { guild = m.guildName, who = m.all and S("ALL") or Join(who) }
    local named = m.guildName and "GUILD_NAMED" or "GUILD_RECRUIT"
    if who[1] or m.all then return Fill(named, slots) end
    return Fill(named .. "_ANY", slots)
end

-- Quién es el que escribe: "Sanador / DPS", "Mago (nivel 30)".
local function Speaker(m)
    local who = Roles(m)
    if not who[1] then return end
    local text = table_concat(who, S("WHO_SEP"))
    if m.level then text = text .. " (" .. Fill("LEVEL", { n = m.level }) .. ")" end
    return text
end

local function LookingForGroup(m)
    local who = Speaker(m)
    local inst = InstText(m)
    if who then
        return Fill(inst and "LFG_WHO_INST" or "LFG_WHO", { who = who, inst = inst })
    end
    return Fill(inst and "LFG_INST" or "LFG", { inst = inst })
end

local function Recruit(m)
    local inst = InstText(m)
    local roles = Roles(m, true)
    if roles[1] then
        return Fill(inst and "REC_ROLES_INST" or "REC_ROLES", { roles = Join(roles), inst = inst })
    end
    if m.all then return Fill(inst and "REC_ALL_INST" or "REC_ALL", { inst = inst }) end
    if m.more then return Fill(inst and "REC_MORE_INST" or "REC_MORE", { n = m.more, inst = inst }) end
    if inst then return Fill("REC_INST", { inst = inst }) end
end

-- El tipo de mensaje, en el orden de prioridad del catálogo.
local function Main(m)
    local t = m.trig
    if t.wts or t.wtb or t.wtt or t.pc then return Trade(m) end

    local asking = t.lf or t.need or t.lfm or t.lfg
    local askPos = m.pos.lf or m.pos.need or m.pos.lfm or m.pos.lfg
    -- "guild LF healer" recluta; "rogue LF guild" busca hermandad.
    if t.recruit or (m.guildFlag and asking) or (m.pos.guild and asking and m.pos.guild < askPos) then
        return Guild(m)
    end
    if m.guild and asking then
        local who = Speaker(m)
        if who then return Fill("LF_GUILD_WHO", { who = who }) end
        return Fill("LF_GUILD", {})
    end
    if t.lfw or (m.artisans[1] and m.work) then
        return Fill("CRAFTER_LFW", { artisan = ArtisanText(m, true) }), "crafter"
    end
    if m.artisans[1] and (asking or t.anyone) then
        if m.items[1] then
            return Fill("LF_CRAFTER_ITEM", { artisan = ArtisanText(m), items = Join(m.items) }), "client"
        end
        return Fill("LF_CRAFTER", { artisan = ArtisanText(m) }), "client"
    end
    if asking or t.anyone then
        if m.svc.summon then return WithPlace("LF_SUMMON", m) end
        if m.svc.port then return WithPlace("LF_PORT", m) end
        if m.svc.water then return Fill("LF_WATER", {}) end
        if m.svc.lockpick then
            if m.items[1] then return Fill("LF_LOCKPICK_ITEM", { items = Join(m.items) }) end
            return Fill("LF_LOCKPICK", {})
        end
        if m.svc.rez then return Fill("NEED_REZ", {}) end
        if m.quests[1] then return Fill("QUEST_GROUP", { quest = Join(m.quests) }) end
        if m.quest and not m.roles[1] then return Fill("QUEST_GROUP_ANY", {}) end
        if m.items[1] and not m.roles[1] and not m.inst then return Fill("LF_ITEM", { items = Join(m.items) }) end
    end

    if t.lfm or t.need then return Recruit(m) end
    if t.lfg then return LookingForGroup(m) end
    if t.lf then
        local hasWho = m.roles[1] or m.who[1]
        if hasWho and m.pos.role < m.pos.lf then return LookingForGroup(m) end
        if hasWho or m.all then return Recruit(m) end
        if m.inst then return LookingForGroup(m) end
        return
    end
    if t.anyone and m.inst then return Fill("Q_ANY_INST", { inst = InstText(m) }) end
    -- "1 tnk WC and Go": un número pegado a un rol solo lo escribe quien busca gente.
    for _, r in ipairs(m.roles) do
        if r.n then return Recruit(m) end
    end
end

-- Coletillas: última plaza, salimos ya, susurradme, materiales, propina.
local function Extras(m, kind)
    local out = {}
    if kind == "price" and m.price then out[#out + 1] = Fill("S_PRICE", { price = m.price }) end
    if kind == "client" or kind == "crafter" then
        if m.mats.mine and m.mats.mats then out[#out + 1] = S("S_MYMATS") end
        if m.mats.yours then out[#out + 1] = S("S_YOURMATS") end
        if m.tips then out[#out + 1] = S(kind == "client" and "S_TIP_GIVE" or "S_TIP_TAKE") end
        if m.free then out[#out + 1] = S("S_FREE") end
    end
    if m.last then out[#out + 1] = S("S_LASTSPOT") end
    if m.go then out[#out + 1] = S("S_GO") end
    if m.contact or m.inv then out[#out + 1] = S("S_WHISPER") end
    return out
end

local function Capitalize(s)
    return (string_gsub(s, "^%l", string_upper))
end

local function Fixed(text)
    local norm = string_lower(text)
    norm = string_gsub(norm, "[^%w%s%+]", "")
    norm = string_gsub(string_gsub(norm, "%s+", " "), "^ ", "")
    norm = string_gsub(norm, " $", "")
    for _, rule in ipairs(addonTable.TplFixed) do
        local n = string_match(norm, rule[1])
        if n then return Fill(rule[2], { n = n }) end
    end
end

-- Frase completa para el mensaje, o nil si no encaja en ninguna plantilla.
function addonTable.TemplateSentence(text)
    local all = addonTable.Plantillas
    target = WoWTranslatorDB.targetLocale or "esES"
    EN = all.enUS
    P = all[target] or (target == "esMX" and all.esES) or EN
    if namesVersion ~= addonTable.dictVersion then BuildNames() end

    if string_find(text, "|H", 1, true) == nil then
        local fixed = Fixed(text)
        if fixed then return fixed end
    end

    local m = Read(text)
    if not m then return end
    local sentence, kind = Main(m)
    if not sentence then return end
    local parts = { Capitalize(sentence) }
    for _, extra in ipairs(Extras(m, kind)) do parts[#parts + 1] = extra end
    return table_concat(parts, P.JOIN or " ") -- chino y japonés no separan frases con espacio
end
