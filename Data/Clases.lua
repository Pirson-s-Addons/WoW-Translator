local ADDON_NAME, addonTable = ...
addonTable.ClasesDict = {
    ["ms"] = { 
        esES = "Rama Principal", esMX = "Rama Principal", enUS = "Main Spec", 
        deDE = "Hauptspezialisierung", frFR = "Spé principale", itIT = "Specializzazione primaria", 
        koKR = "주 특성", ptBR = "Especialização Principal", ruRU = "МС (Мейн спек)", 
        zhCN = "主天赋", zhTW = "主天賦" 
    },
    ["os"] = { 
        esES = "Rama Secundaria", esMX = "Rama Secundaria", enUS = "Off Spec", 
        deDE = "Zweitspezialisierung", frFR = "Spé secondaire", itIT = "Specializzazione secondaria", 
        koKR = "부 특성", ptBR = "Especialização Secundária", ruRU = "ОС (Офф спек)", 
        zhCN = "副天赋", zhTW = "副天賦" 
    },
    ["warlock"] = { 
        esES = "Brujo", enUS = "Warlock", deDE = "Hexenmeister", frFR = "Démoniste", ruRU = "Чернокнижник", 
        itIT = "Stregone", koKR = "흑마법사", ptBR = "Bruxo", zhCN = "术士", zhTW = "術士" 
    },
    ["lock"] = { 
        esES = "Brujo", enUS = "Warlock", deDE = "Hexenmeister", frFR = "Démoniste", ruRU = "Чернокнижник", 
        itIT = "Stregone", koKR = "흑마법사", ptBR = "Bruxo", zhCN = "术士", zhTW = "術士" 
    },
    ["warrior"] = { 
        esES = "Guerrero", enUS = "Warrior", deDE = "Krieger", frFR = "Guerrier", ruRU = "Воин", 
        itIT = "Guerriero", koKR = "전사", ptBR = "Guerreiro", zhCN = "战士", zhTW = "戰士" 
    },
    ["warr"] = { 
        esES = "Guerrero", enUS = "Warrior", deDE = "Krieger", frFR = "Guerrier", ruRU = "Воин", 
        itIT = "Guerriero", koKR = "전사", ptBR = "Guerreiro", zhCN = "战士", zhTW = "戰士" 
    },
    ["paladin"] = { 
        esES = "Paladín", enUS = "Paladin", deDE = "Paladin", frFR = "Paladin", ruRU = "Паладин", 
        itIT = "Paladino", koKR = "성기사", ptBR = "Paladino", zhCN = "圣骑士", zhTW = "聖騎士" 
    },
    ["pala"]  = { 
        esES = "Paladín", enUS = "Paladin", deDE = "Paladin", frFR = "Paladin", ruRU = "Паладин", 
        itIT = "Paladino", koKR = "성기사", ptBR = "Paladino", zhCN = "圣骑士", zhTW = "聖騎士" 
    },
    ["hunter"] = { 
        esES = "Cazador", enUS = "Hunter", deDE = "Jäger", frFR = "Chasseur", ruRU = "Охотник", 
        itIT = "Cacciatore", koKR = "사냥꾼", ptBR = "Caçador", zhCN = "猎人", zhTW = "獵人" 
    },
    ["hunt"] = { 
        esES = "Cazador", enUS = "Hunter", deDE = "Jäger", frFR = "Chasseur", ruRU = "Охотник", 
        itIT = "Cacciatore", koKR = "사냥꾼", ptBR = "Caçador", zhCN = "猎人", zhTW = "獵人" 
    },
    ["deathknight"] = { 
        esES = "Cab. Muerte", enUS = "Death Knight", deDE = "Todesritter", frFR = "Chv. de la mort", 
        ruRU = "Рыцарь смерти", itIT = "Cav. della Morte", koKR = "죽음의 기사", ptBR = "Cav. da Morte", 
        zhCN = "死亡骑士", zhTW = "死亡騎士" 
    },
    ["death knight"] = { 
        esES = "Cab. Muerte", enUS = "Death Knight", deDE = "Todesritter", frFR = "Chv. de la mort", 
        ruRU = "Рыцарь смерти", itIT = "Cav. della Morte", koKR = "죽음의 기사", ptBR = "Cav. da Morte", 
        zhCN = "死亡骑士", zhTW = "死亡騎士" 
    },
    ["dk"] = { 
        esES = "Cab. Muerte", enUS = "Death Knight", deDE = "Todesritter", frFR = "Chv. de la mort", 
        ruRU = "Рыцарь смерти", itIT = "Cav. della Morte", koKR = "죽음의 기사", ptBR = "Cav. da Morte", 
        zhCN = "死亡骑士", zhTW = "死亡騎士" 
    },
    ["mage"] = { 
        esES = "Mago", enUS = "Mage", deDE = "Magier", frFR = "Mage", ruRU = "Маг", itIT = "Mago", 
        koKR = "마법사", ptBR = "Mago", zhCN = "法师", zhTW = "法師" 
    },
    ["priest"] = { 
        esES = "Sacerdote", enUS = "Priest", deDE = "Priester", frFR = "Prêtre", ruRU = "Жрец", 
        itIT = "Sacerdote", koKR = "사제", ptBR = "Sacerdote", zhCN = "牧师", zhTW = "牧師" 
    },
    ["druid"] = { 
        esES = "Druida", enUS = "Druid", deDE = "Druide", frFR = "Druide", ruRU = "Друид", 
        itIT = "Druido", koKR = "드루이드", ptBR = "Druida", zhCN = "德鲁伊", zhTW = "德魯伊" 
    },
    ["shaman"] = { 
        esES = "Chamán", enUS = "Shaman", deDE = "Schamane", frFR = "Chaman", ruRU = "Шаман",
        itIT = "Sciamano", koKR = "주술사", ptBR = "Xamã", zhCN = "萨满祭司", zhTW = "薩滿" 
    },
    ["rogue"] = { 
        esES = "Pícaro", enUS = "Rogue", deDE = "Schurke", frFR = "Voleur", ruRU = "Разбойник", 
        itIT = "Ladro", koKR = "도적", ptBR = "Ladino", zhCN = "盗贼", zhTW = "盜賊" 
    },
    ["monk"] = { 
        esES = "Monje", enUS = "Monk", deDE = "Mönch", frFR = "Moine", ruRU = "Монах", 
        itIT = "Monaco", koKR = "수도사", ptBR = "Monge", zhCN = "武僧", zhTW = "武僧" 
    }
}