local ADDON_NAME, addonTable = ...
addonTable = addonTable or WoWTranslatorNS -- clientes < 3.0 no pasan argumentos

-- ==========================================
-- JERGA EN CHINO SIMPLIFICADO (origen zhCN)
-- ==========================================
-- Mismo formato que Data/Origen/koKR.lua: término -> clave inglesa de Data/.
-- Pendiente de revisar por hablantes nativos (beta).
addonTable.OrigenZhCN = {
    -- Roles
    ["坦克"] = "tank", ["坦"] = "tank",
    ["治疗"] = "healer", ["奶妈"] = "healer", ["奶"] = "heal",
    ["输出"] = "dps",

    -- Grupos
    ["求组"] = "lfg", ["招人"] = "lfm", ["最后一个"] = "last spot",
    ["英雄"] = "hc", ["普通"] = "nm", ["随机团"] = "lfr",
    ["装等"] = "ilvl", ["等级"] = "lvl", ["成就"] = "achiev", ["经验"] = "exp",
    ["装备"] = "gear", ["要求"] = "req", ["团长"] = "leader", ["灭团"] = "wipe",

    -- Clases
    ["战士"] = "warrior", ["圣骑士"] = "paladin", ["圣骑"] = "pala", ["猎人"] = "hunter",
    ["盗贼"] = "rogue", ["法师"] = "mage", ["牧师"] = "priest", ["德鲁伊"] = "druid",
    ["小德"] = "dudu", ["萨满"] = "shaman", ["术士"] = "warlock",
    ["死亡骑士"] = "deathknight", ["死骑"] = "dk", ["武僧"] = "monk",

    -- Especializaciones
    ["奶骑"] = "hpala", ["防骑"] = "ppala", ["惩戒骑"] = "ret",
    ["防战"] = "prot", ["武器战"] = "arms", ["狂暴战"] = "fury",
    ["戒律"] = "disc", ["神牧"] = "holy", ["暗牧"] = "shadow",
    ["鸟德"] = "balance", ["猫德"] = "feral", ["熊德"] = "guardian", ["奶德"] = "resto",
    ["元素萨"] = "ele", ["增强萨"] = "enh", ["奶萨"] = "resto",

    -- Combate
    ["小怪"] = "trash", ["仇恨"] = "aggro", ["群伤"] = "aoe", ["冷却"] = "cd",
    ["打断"] = "kick", ["眩晕"] = "stun", ["驱散"] = "dispel", ["控制"] = "cc",
    ["嗜血"] = "lust", ["英勇"] = "lust", ["风筝"] = "kite", ["爆发"] = "burst",
    ["集火"] = "focus", ["战场"] = "bg",

    -- Estado y utilidades
    ["复活"] = "res", ["耐久"] = "dur", ["修理"] = "repp", ["拉人"] = "summon",
    ["金团"] = "gdkp",

    -- Comercio
    ["求购"] = "wtb", ["出售"] = "wts", ["交换"] = "wtt", ["拍卖行"] = "ah",

    -- Social
    ["谢谢"] = "ty", ["多谢"] = "thx", ["没事"] = "np", ["挂机"] = "afk",
    ["马上回来"] = "brb", ["稍等"] = "sec", ["公会"] = "guild",

    -- Estadísticas
    ["暴击"] = "crit", ["急速"] = "haste", ["命中"] = "hit", ["精通"] = "mastery",
    ["护甲"] = "armor", ["精神"] = "spirit", ["躲闪"] = "dodge", ["招架"] = "parry",
    ["力量"] = "str", ["敏捷"] = "agi", ["智力"] = "int", ["耐力"] = "stam",

    -- Instancias
    ["熔火之心"] = "mc", ["黑翼之巢"] = "bwl", ["黑翼"] = "bwl",
    ["纳克萨玛斯"] = "naxx", ["纳克"] = "naxx", ["卡拉赞"] = "kara",
    ["黑石深渊"] = "brd", ["黑石塔上层"] = "ubrs", ["黑上"] = "ubrs",
    ["黑石塔下层"] = "lbrs", ["黑下"] = "lbrs", ["通灵学院"] = "scholo",
    ["玛拉顿"] = "mara", ["祖尔法拉克"] = "zf", ["奥达曼"] = "ulda",
    ["剃刀高地"] = "rfd", ["影牙城堡"] = "sfk", ["沉没的神庙"] = "st",
}
