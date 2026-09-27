local ADDON_NAME, addonTable = ...
addonTable = addonTable or WoWTranslatorNS -- clientes < 3.0 no pasan argumentos

-- ==========================================
-- JERGA EN COREANO (origen koKR)
-- ==========================================
-- Término coreano -> clave inglesa de Data/. La traducción sale de esa entrada,
-- así que un término nuevo no pide 20 traducciones: solo su clave. Si no hay
-- clave que le encaje, se crea antes la entrada inglesa en Data/.
-- Pendiente de revisar por hablantes nativos (beta).
addonTable.OrigenKoKR = {
    -- Roles
    ["탱커"] = "tank", ["탱"] = "tank",
    ["힐러"] = "healer", ["힐"] = "heal",
    ["딜러"] = "dps", ["딜"] = "dps",

    -- Grupos
    ["구함"] = "need", ["구해요"] = "need", ["구합니다"] = "need",
    ["모집"] = "lfm", ["한자리"] = "last spot", ["막자리"] = "last spot",
    ["영웅"] = "hc", ["일반"] = "nm", ["공격대 찾기"] = "lfr",
    ["템렙"] = "ilvl", ["레벨"] = "lvl", ["업적"] = "achiev", ["경험치"] = "exp",
    ["장비"] = "gear", ["초대"] = "inv", ["파장"] = "leader", ["전멸"] = "wipe",

    -- Clases
    ["전사"] = "warrior", ["성기사"] = "paladin", ["사냥꾼"] = "hunter", ["냥꾼"] = "hunt",
    ["도적"] = "rogue", ["마법사"] = "mage", ["법사"] = "mage", ["사제"] = "priest",
    ["드루이드"] = "druid", ["드루"] = "druid", ["주술사"] = "shaman", ["술사"] = "shaman",
    ["흑마법사"] = "warlock", ["흑마"] = "warlock", ["죽음의 기사"] = "deathknight",
    ["죽기"] = "dk", ["수도사"] = "monk",

    -- Especializaciones
    -- "보기" (paladín protección) no entra: es también el verbo "ver".
    ["신기"] = "hpala", ["징기"] = "ret",
    ["방전"] = "prot", ["무전"] = "arms", ["분전"] = "fury",
    ["수사"] = "disc", ["신사"] = "holy", ["암사"] = "shadow",
    ["조드"] = "balance", ["야드"] = "feral", ["회드"] = "resto",
    ["정술"] = "ele", ["고술"] = "enh", ["복술"] = "resto",

    -- Combate
    ["쫄"] = "add", ["잡몹"] = "trash", ["어그로"] = "aggro", ["광역"] = "aoe",
    ["쿨"] = "cd", ["짤"] = "kick", ["차단"] = "kick", ["스턴"] = "stun",
    ["버프"] = "buff", ["디버프"] = "debuff", ["해제"] = "dispel",
    ["블러드"] = "lust", ["영웅심"] = "lust", ["전장"] = "bg",

    -- Estado y utilidades
    ["부활"] = "res", ["사망"] = "dead", ["내구도"] = "dur", ["수리"] = "repp",
    ["소환"] = "summon", ["닌자"] = "ninja", ["골팟"] = "gdkp",

    -- Comercio
    ["삽니다"] = "wtb", ["구매"] = "wtb", ["팝니다"] = "wts", ["판매"] = "wts",
    ["교환"] = "wtt", ["경매장"] = "ah",

    -- Social
    ["감사"] = "ty", ["ㄱㅅ"] = "ty", ["수고"] = "gj", ["ㅇㅋ"] = "kk",
    ["잠수"] = "afk", ["잠시만"] = "sec", ["길드"] = "guild",

    -- Estadísticas
    ["치명"] = "crit", ["가속"] = "haste", ["적중"] = "hit", ["특화"] = "mastery",
    ["방어도"] = "armor", ["정신력"] = "spirit", ["회피"] = "dodge", ["무기 막기"] = "parry",
    ["민첩"] = "agi", ["지능"] = "int",

    -- Instancias
    ["화심"] = "mc", ["검둥"] = "bwl", ["낙스"] = "naxx", ["카라잔"] = "kara", ["카라"] = "kara",
    ["검은바위 나락"] = "brd", ["검은바위 첨탑 상층"] = "ubrs", ["검은바위 첨탑 하층"] = "lbrs",
    ["스칼로맨스"] = "scholo", ["마라우돈"] = "mara", ["줄파락"] = "zf", ["울다만"] = "ulda",
    ["가시덩굴 구릉"] = "rfd", ["그림자송곳니 성채"] = "sfk", ["아탈학카르 신전"] = "st",
}
