local ADDON_NAME, addonTable = ...
addonTable.EstadisticasDict = {
    ["ap"] = { 
        esES = "Poder de ataque", esMX = "Poder de ataque", enUS = "Attack Power", deDE = "Angriffskraft", 
        frFR = "Puissance d'attaque", itIT = "Potenza d'attacco", koKR = "전투력", ptBR = "Poder de Ataque", 
        ruRU = "Сила атаки", zhCN = "攻击强度", zhTW = "攻擊強度" 
    },
    ["crit"] = { 
        esES = "Crítico", esMX = "Crítico", enUS = "Critical Strike", deDE = "Kritische Treffechance", 
        frFR = "Coup critique", itIT = "Critico", koKR = "치명타", ptBR = "Crítico", 
        ruRU = "Крит", zhCN = "爆击", zhTW = "爆擊" 
    },
    ["haste"] = { 
        esES = "Celeridad", esMX = "Celeridad", enUS = "Haste", deDE = "Tempo", 
        frFR = "Hâte", itIT = "Celerità", koKR = "가속", ptBR = "Aceleração", 
        ruRU = "Хаста/Скорость", zhCN = "急速", zhTW = "急速" 
    },
    ["hit"] = { 
        esES = "Índice de golpe", esMX = "Índice de golpe", enUS = "Hit rating", deDE = "Trefferwertung", 
        frFR = "Score de toucher", itIT = "Indice di colpo", koKR = "적중", ptBR = "Acerto", 
        ruRU = "Меткость", zhCN = "命中", zhTW = "命中" 
    },
    ["mastery"] = { 
        esES = "Maestría", esMX = "Maestría", enUS = "Mastery", deDE = "Meisterschaft", 
        frFR = "Maîtrise", itIT = "Maestria", koKR = "특화", ptBR = "Maestria", 
        ruRU = "Искусность", zhCN = "精通", zhTW = "精通" 
    },
    ["armor"] = { 
        esES = "Armadura", esMX = "Armadura", enUS = "Armor", deDE = "Rüstung", 
        frFR = "Armure", itIT = "Armatura", koKR = "방어도", ptBR = "Armadura", 
        ruRU = "Броня", zhCN = "护甲", zhTW = "護甲" 
    },
    ["avoidance"] = { 
        esES = "Evasión física", esMX = "Evasión física", enUS = "Avoidance", deDE = "Vermeidung", 
        frFR = "Évitement", itIT = "Evasione", koKR = "광역 회피", ptBR = "Evasão", 
        ruRU = "Избежание", zhCN = "回避", zhTW = "迴避" 
    },
    ["resilience"] = { 
        esES = "Temple", esMX = "Temple", enUS = "Resilience", deDE = "Abhärtung", 
        frFR = "Résilience", itIT = "Resilienza", koKR = "탄력성", ptBR = "Resiliência", 
        ruRU = "Устойчивость", zhCN = "韧性", zhTW = "韌性" 
    },
    ["expertise"] = { 
        esES = "Pericia", esMX = "Pericia", enUS = "Expertise", deDE = "Waffenkunde", 
        frFR = "Expertise", itIT = "Perizia", koKR = "숙련", ptBR = "Aptidão", 
        ruRU = "Мастерство", zhCN = "精准", zhTW = "精準" 
    },
    ["spirit"] = { 
        esES = "Espíritu", esMX = "Espíritu", enUS = "Spirit", deDE = "Willenskraft", 
        frFR = "Esprit", itIT = "Spirito", koKR = "정신력", ptBR = "Espírito", 
        ruRU = "Дух", zhCN = "精神", zhTW = "精神" 
    },
    ["dodge"] = { 
        esES = "Esquiva", esMX = "Esquiva", enUS = "Dodge", deDE = "Ausweichen", 
        frFR = "Esquive", itIT = "Schivata", koKR = "회피", ptBR = "Esquiva", 
        ruRU = "Uклонение", zhCN = "躲闪", zhTW = "躲閃" 
    },
    ["parry"] = { 
        esES = "Parada", esMX = "Parada", enUS = "Parry", deDE = "Parieren", 
        frFR = "Parade", itIT = "Parata", koKR = "무기 막기", ptBR = "Aparo", 
        ruRU = "Парирование", zhCN = "招架", zhTW = "招架" 
    }
}