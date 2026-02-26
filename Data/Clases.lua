local ADDON_NAME, addonTable = ...
addonTable.ClasesDict = {

    ["ms"]          = {
        esES = "Rama Principal",
        esMX = "Rama Principal",
        enUS = "Main Spec",
        deDE = "Hauptspezialisierung",
        frFR = "Spé principale",
        itIT = "Specializzazione primaria",
        koKR = "주 특성",
        ptBR = "Especialização Principal",
        ruRU = "МС",
        zhCN = "主天赋",
        zhTW = "主天賦"
    },
    ["os"]          = {
        esES = "Rama Secundaria",
        esMX = "Rama Secundaria",
        enUS = "Off Spec",
        deDE = "Zweitspezialisierung",
        frFR = "Spé secondaire",
        itIT = "Specializzazione secondaria",
        koKR = "부 특성",
        ptBR = "Especialização Secundária",
        ruRU = "ОС",
        zhCN = "副天赋",
        zhTW = "副天賦"
    },

    -- =====================
    -- CLASES
    -- =====================
    ["warrior"]     = {
        esES = "Guerrero",
        esMX = "Guerrero",
        enUS = "Warrior",
        deDE = "Krieger",
        frFR = "Guerrier",
        itIT = "Guerriero",
        koKR = "전사",
        ptBR = "Guerreiro",
        ruRU = "Воин",
        zhCN = "战士",
        zhTW = "戰士"
    },
    ["warr"]        = {
        esES = "Guerrero",
        esMX = "Guerrero",
        enUS = "Warrior",
        deDE = "Krieger",
        frFR = "Guerrier",
        itIT = "Guerriero",
        koKR = "전사",
        ptBR = "Guerreiro",
        ruRU = "Воин",
        zhCN = "战士",
        zhTW = "戰士"
    },

    ["paladin"]     = {
        esES = "Paladín",
        esMX = "Paladín",
        enUS = "Paladin",
        deDE = "Paladin",
        frFR = "Paladin",
        itIT = "Paladino",
        koKR = "성기사",
        ptBR = "Paladino",
        ruRU = "Паладин",
        zhCN = "圣骑士",
        zhTW = "聖騎士"
    },
    ["pala"]        = {
        esES = "Paladín",
        esMX = "Paladín",
        enUS = "Paladin",
        deDE = "Paladin",
        frFR = "Paladin",
        itIT = "Paladino",
        koKR = "성기사",
        ptBR = "Paladino",
        ruRU = "Паладин",
        zhCN = "圣骑士",
        zhTW = "聖騎士"
    },

    ["hunter"]      = {
        esES = "Cazador",
        esMX = "Cazador",
        enUS = "Hunter",
        deDE = "Jäger",
        frFR = "Chasseur",
        itIT = "Cacciatore",
        koKR = "사냥꾼",
        ptBR = "Caçador",
        ruRU = "Охотник",
        zhCN = "猎人",
        zhTW = "獵人"
    },
    ["hunt"]        = {
        esES = "Cazador",
        esMX = "Cazador",
        enUS = "Hunter",
        deDE = "Jäger",
        frFR = "Chasseur",
        itIT = "Cacciatore",
        koKR = "사냥꾼",
        ptBR = "Caçador",
        ruRU = "Охотник",
        zhCN = "猎人",
        zhTW = "獵人"
    },

    ["deathknight"] = {
        esES = "Caballero de la Muerte",
        esMX = "Caballero de la Muerte",
        enUS = "Death Knight",
        deDE = "Todesritter",
        frFR = "Chevalier de la mort",
        itIT = "Cavaliere della Morte",
        koKR = "죽음의 기사",
        ptBR = "Cavaleiro da Morte",
        ruRU = "Рыцарь смерти",
        zhCN = "死亡骑士",
        zhTW = "死亡騎士"
    },
    ["dk"]          = {
        esES = "Caballero de la Muerte",
        esMX = "Caballero de la Muerte",
        enUS = "Death Knight",
        deDE = "Todesritter",
        frFR = "Chevalier de la mort",
        itIT = "Cavaliere della Morte",
        koKR = "죽음의 기사",
        ptBR = "Cavaleiro da Morte",
        ruRU = "Рыцарь смерти",
        zhCN = "死亡骑士",
        zhTW = "死亡騎士"
    },

    ["rogue"]       = {
        esES = "Pícaro",
        esMX = "Pícaro",
        enUS = "Rogue",
        deDE = "Schurke",
        frFR = "Voleur",
        itIT = "Ladro",
        koKR = "도적",
        ptBR = "Ladino",
        ruRU = "Разбойник",
        zhCN = "盗贼",
        zhTW = "盜賊"
    },

    ["mage"]        = {
        esES = "Mago",
        esMX = "Mago",
        enUS = "Mage",
        deDE = "Magier",
        frFR = "Mage",
        itIT = "Mago",
        koKR = "마법사",
        ptBR = "Mago",
        ruRU = "Маг",
        zhCN = "法师",
        zhTW = "法師"
    },

    ["priest"]      = {
        esES = "Sacerdote",
        esMX = "Sacerdote",
        enUS = "Priest",
        deDE = "Priester",
        frFR = "Prêtre",
        itIT = "Sacerdote",
        koKR = "사제",
        ptBR = "Sacerdote",
        ruRU = "Жрец",
        zhCN = "牧师",
        zhTW = "牧師"
    },

    ["druid"]       = {
        esES = "Druida",
        esMX = "Druida",
        enUS = "Druid",
        deDE = "Druide",
        frFR = "Druide",
        itIT = "Druido",
        koKR = "드루이드",
        ptBR = "Druida",
        ruRU = "Друид",
        zhCN = "德鲁伊",
        zhTW = "德魯伊"
    },
    ["dudu"]        = {
        esES = "Druida",
        esMX = "Druida",
        enUS = "Druid",
        deDE = "Druide",
        frFR = "Druide",
        itIT = "Druido",
        koKR = "드루이드",
        ptBR = "Druida",
        ruRU = "Друид",
        zhCN = "德鲁伊",
        zhTW = "德魯伊"
    },

    ["shaman"]      = {
        esES = "Chamán",
        esMX = "Chamán",
        enUS = "Shaman",
        deDE = "Schamane",
        frFR = "Chaman",
        itIT = "Sciamano",
        koKR = "주술사",
        ptBR = "Xamã",
        ruRU = "Шаман",
        zhCN = "萨满祭司",
        zhTW = "薩滿"
    },

    ["monk"]        = {
        esES = "Monje",
        esMX = "Monje",
        enUS = "Monk",
        deDE = "Mönch",
        frFR = "Moine",
        itIT = "Monaco",
        koKR = "수도사",
        ptBR = "Monge",
        ruRU = "Монах",
        zhCN = "武僧",
        zhTW = "武僧"
    },

    ["warlock"]     = {
        esES = "Brujo",
        esMX = "Brujo",
        enUS = "Warlock",
        deDE = "Hexenmeister",
        frFR = "Démoniste",
        itIT = "Stregone",
        koKR = "흑마법사",
        ptBR = "Bruxo",
        ruRU = "Чернокнижник",
        zhCN = "术士",
        zhTW = "術士"
    },
    ["lock"]        = {
        esES = "Brujo",
        esMX = "Brujo",
        enUS = "Warlock",
        deDE = "Hexenmeister",
        frFR = "Démoniste",
        itIT = "Stregone",
        koKR = "흑마법사",
        ptBR = "Bruxo",
        ruRU = "Чернокнижник",
        zhCN = "术士",
        zhTW = "術士"
    },

    -- =====================
    -- ESPECIALIZACIONES POR CLASE
    -- =====================

    -- Guerrero
    ["arms"]        = {
        esES = "Armas",
        esMX = "Armas",
        enUS = "Arms",
        deDE = "Waffen",
        frFR = "Armes",
        itIT = "Armi",
        koKR = "무기",
        ptBR = "Armas",
        ruRU = "Оружие",
        zhCN = "武器",
        zhTW = "武器"
    },
    ["fury"]        = {
        esES = "Furia",
        esMX = "Furia",
        enUS = "Fury",
        deDE = "Furor",
        frFR = "Fureur",
        itIT = "Furia",
        koKR = "분노",
        ptBR = "Fúria",
        ruRU = "Неистовство",
        zhCN = "狂怒",
        zhTW = "狂怒"
    },
    ["prot"]        = {
        esES = "Protección",
        esMX = "Protección",
        enUS = "Protection",
        deDE = "Schutz",
        frFR = "Protection",
        itIT = "Protezione",
        koKR = "방어",
        ptBR = "Proteção",
        ruRU = "Защита",
        zhCN = "防护",
        zhTW = "防護"
    },

    -- Paladín
    ["hpala"]       = {
        esES = "Sagrado",
        esMX = "Sagrado",
        enUS = "Holy",
        deDE = "Heilig",
        frFR = "Sacré",
        itIT = "Sacro",
        koKR = "신성",
        ptBR = "Sagrado",
        ruRU = "Свет",
        zhCN = "神圣",
        zhTW = "神聖"
    },
    ["ppala"]       = {
        esES = "Protección",
        esMX = "Protección",
        enUS = "Protection",
        deDE = "Schutz",
        frFR = "Protection",
        itIT = "Protezione",
        koKR = "보호",
        ptBR = "Proteção",
        ruRU = "Защита",
        zhCN = "防护",
        zhTW = "防護"
    },
    ["ret"]         = {
        esES = "Reprensión",
        esMX = "Reprensión",
        enUS = "Retribution",
        deDE = "Vergeltung",
        frFR = "Vindicte",
        itIT = "Castigo",
        koKR = "징벌",
        ptBR = "Retribuição",
        ruRU = "Воздаяние",
        zhCN = "惩戒",
        zhTW = "懲戒"
    },
    ["retry"]       = {
        esES = "Reprensión",
        esMX = "Reprensión",
        enUS = "Retribution",
        deDE = "Vergeltung",
        frFR = "Vindicte",
        itIT = "Castigo",
        koKR = "징벌",
        ptBR = "Retribuição",
        ruRU = "Воздаяние",
        zhCN = "惩戒",
        zhTW = "懲戒"
    },

    -- Cazador
    ["hunt bm"]     = {
        esES = "Bestias",
        esMX = "Bestias",
        enUS = "Beast Mastery",
        deDE = "Tierherrschaft",
        frFR = "Maîtrise des bêtes",
        itIT = "Affinità Animale",
        koKR = "야수",
        ptBR = "Domínio das Feras",
        ruRU = "Повелитель зверей",
        zhCN = "野兽控制",
        zhTW = "野獸控制"
    },
    ["bm hunt"]     = {
        esES = "Bestias",
        esMX = "Bestias",
        enUS = "Beast Mastery",
        deDE = "Tierherrschaft",
        frFR = "Maîtrise des bêtes",
        itIT = "Affinità Animale",
        koKR = "야수",
        ptBR = "Domínio das Feras",
        ruRU = "Повелитель зверей",
        zhCN = "野兽控制",
        zhTW = "野獸控制"
    },
    ["mm"]          = {
        esES = "Puntería",
        esMX = "Puntería",
        enUS = "Marksmanship",
        deDE = "Treffsicherheit",
        frFR = "Précision",
        itIT = "Precisione di Tiro",
        koKR = "사격",
        ptBR = "Precisão",
        ruRU = "Стрельба",
        zhCN = "射击",
        zhTW = "射擊"
    },
    ["sv"]          = {
        esES = "Supervivencia",
        esMX = "Supervivencia",
        enUS = "Survival",
        deDE = "Überleben",
        frFR = "Survie",
        itIT = "Sopravvivenza",
        koKR = "생존",
        ptBR = "Sobrevivência",
        ruRU = "Выживание",
        zhCN = "生存",
        zhTW = "生存"
    },

    -- Mago
    ["fire"]        = {
        esES = "Fuego",
        esMX = "Fuego",
        enUS = "Fire",
        deDE = "Feuer",
        frFR = "Feu",
        itIT = "Fuoco",
        koKR = "화염",
        ptBR = "Fogo",
        ruRU = "Огонь",
        zhCN = "火焰",
        zhTW = "火焰"
    },
    ["frost"]       = {
        esES = "Escarcha",
        esMX = "Escarcha",
        enUS = "Frost",
        deDE = "Frost",
        frFR = "Givre",
        itIT = "Gelo",
        koKR = "냉기",
        ptBR = "Gelo",
        ruRU = "Лёд",
        zhCN = "冰霜",
        zhTW = "冰霜"
    },
    ["arcane"]      = {
        esES = "Arcano",
        esMX = "Arcano",
        enUS = "Arcane",
        deDE = "Arkan",
        frFR = "Arcanes",
        itIT = "Arcano",
        koKR = "비전",
        ptBR = "Arcano",
        ruRU = "Тайная магия",
        zhCN = "奥术",
        zhTW = "秘法"
    },

    -- Brujo
    ["affli"]       = {
        esES = "Aflicción",
        esMX = "Aflicción",
        enUS = "Affliction",
        deDE = "Gebrechen",
        frFR = "Affliction",
        itIT = "Afflizione",
        koKR = "고통",
        ptBR = "Suplício",
        ruRU = "Колдовство",
        zhCN = "痛苦",
        zhTW = "痛苦"
    },
    ["demo"]        = {
        esES = "Demonología",
        esMX = "Demonología",
        enUS = "Demonology",
        deDE = "Dämonologie",
        frFR = "Démonologie",
        itIT = "Demonologia",
        koKR = "악마",
        ptBR = "Demonologia",
        ruRU = "Демонология",
        zhCN = "恶魔学识",
        zhTW = "惡魔學識"
    },
    ["destro"]      = {
        esES = "Destrucción",
        esMX = "Destrucción",
        enUS = "Destruction",
        deDE = "Zerstörung",
        frFR = "Destruction",
        itIT = "Distruzione",
        koKR = "파괴",
        ptBR = "Destruição",
        ruRU = "Разрушение",
        zhCN = "毁灭",
        zhTW = "毀滅"
    },

    -- Sacerdote
    ["disc"]        = {
        esES = "Disciplina",
        esMX = "Disciplina",
        enUS = "Discipline",
        deDE = "Disziplin",
        frFR = "Discipline",
        itIT = "Disciplina",
        koKR = "수양",
        ptBR = "Disciplina",
        ruRU = "Послушание",
        zhCN = "戒律",
        zhTW = "戒律"
    },
    ["holy"]        = {
        esES = "Sagrado",
        esMX = "Sagrado",
        enUS = "Holy",
        deDE = "Heilig",
        frFR = "Sacré",
        itIT = "Sacro",
        koKR = "신성",
        ptBR = "Sagrado",
        ruRU = "Свет",
        zhCN = "神圣",
        zhTW = "神聖"
    },
    ["shadow"]      = {
        esES = "Sombras",
        esMX = "Sombras",
        enUS = "Shadow",
        deDE = "Schatten",
        frFR = "Ombre",
        itIT = "Ombra",
        koKR = "암흑",
        ptBR = "Sombra",
        ruRU = "Тьма",
        zhCN = "暗影",
        zhTW = "暗影"
    },

    -- Druida
    ["balance"]     = {
        esES = "Equilibrio",
        esMX = "Equilibrio",
        enUS = "Balance",
        deDE = "Gleichgewicht",
        frFR = "Équilibre",
        itIT = "Equilibrio",
        koKR = "조화",
        ptBR = "Equilíbrio",
        ruRU = "Баланс",
        zhCN = "平衡",
        zhTW = "平衡"
    },
    ["feral"]       = {
        esES = "Feral",
        esMX = "Feral",
        enUS = "Feral",
        deDE = "Wilder Kampf",
        frFR = "Farouche",
        itIT = "Ferino",
        koKR = "야성",
        ptBR = "Feral",
        ruRU = "Сила зверя",
        zhCN = "野性",
        zhTW = "野性"
    },
    ["resto"]       = {
        esES = "Restauración",
        esMX = "Restauración",
        enUS = "Restoration",
        deDE = "Wiederherstellung",
        frFR = "Restauration",
        itIT = "Rigenerazione",
        koKR = "복원",
        ptBR = "Restauração",
        ruRU = "Исцеление",
        zhCN = "恢复",
        zhTW = "恢復"
    },
    ["guardian"]    = {
        esES = "Guardián",
        esMX = "Guardián",
        enUS = "Guardian",
        deDE = "Wächter",
        frFR = "Gardien",
        itIT = "Guardiano",
        koKR = "수호",
        ptBR = "Guardião",
        ruRU = "Страж",
        zhCN = "守护",
        zhTW = "守護"
    },

    -- Chamán
    ["ele"]         = {
        esES = "Elemental",
        esMX = "Elemental",
        enUS = "Elemental",
        deDE = "Elementar",
        frFR = "Élémentaire",
        itIT = "Elementale",
        koKR = "정기",
        ptBR = "Elemental",
        ruRU = "Стихии",
        zhCN = "元素",
        zhTW = "元素"
    },
    ["enh"]         = {
        esES = "Mejora",
        esMX = "Mejora",
        enUS = "Enhancement",
        deDE = "Verstärkung",
        frFR = "Amélioration",
        itIT = "Potenziamento",
        koKR = "고양",
        ptBR = "Aperfeiçoamento",
        ruRU = "Совершенствование",
        zhCN = "增强",
        zhTW = "增強"
    },


    -- Picaro
    ["assa"] = {
        esES = "Asesinato",
        esMX = "Asesinato",
        enUS = "Assassination",
        deDE = "Meucheln",
        frFR = "Assassinat",
        itIT = "Assassinio",
        koKR = "암살",
        ptBR = "Assassinato",
        ruRU = "Ликвидация",
        zhCN = "奇袭",
        zhTW = "刺殺"
    },
    ["assass"] = {
        esES = "Asesinato",
        esMX = "Asesinato",
        enUS = "Assassination",
        deDE = "Meucheln",
        frFR = "Assassinat",
        itIT = "Assassinio",
        koKR = "암살",
        ptBR = "Assassinato",
        ruRU = "Ликвидация",
        zhCN = "奇袭",
        zhTW = "刺殺"
    },
    ["outlaw"] = {
        esES = "Combate",
        esMX = "Combate",
        enUS = "Combat",
        deDE = "Kampf",
        frFR = "Combat",
        itIT = "Combattimento",
        koKR = "전투",
        ptBR = "Combate",
        ruRU = "Бой",
        zhCN = "战斗",
        zhTW = "戰鬥"
    },
    ["sub"] = {
        esES = "Sutileza",
        esMX = "Sutileza",
        enUS = "Subtlety",
        deDE = "Täuschung",
        frFR = "Finesse",
        itIT = "Scaltrezza",
        koKR = "잠행",
        ptBR = "Subterfúgio",
        ruRU = "Скрытность",
        zhCN = "敏锐",
        zhTW = "敏銳"
    },

    -- Monje
    ["monk bm"] = {
        esES = "Maestro Cervecero",
        esMX = "Maestro Cervecero",
        enUS = "Brewmaster",
        deDE = "Braumeister",
        frFR = "Maître brasseur",
        itIT = "Mastro Birraio",
        koKR = "양조",
        ptBR = "Mestre Cervejeiro",
        ruRU = "Хмелевар",
        zhCN = "酒仙",
        zhTW = "釀酒"
    },
    ["bm monk"] = {
        esES = "Maestro Cervecero",
        esMX = "Maestro Cervecero",
        enUS = "Brewmaster",
        deDE = "Braumeister",
        frFR = "Maître brasseur",
        itIT = "Mastro Birraio",
        koKR = "양조",
        ptBR = "Mestre Cervejeiro",
        ruRU = "Хмелевар",
        zhCN = "酒仙",
        zhTW = "釀酒"
    },
    ["ww"] = {
        esES = "Viajero del Viento",
        esMX = "Viajero del Viento",
        enUS = "Windwalker",
        deDE = "Windläufer",
        frFR = "Marche-vent",
        itIT = "Impeto",
        koKR = "풍운",
        ptBR = "Andarilho do Vento",
        ruRU = "Танцующий с ветром",
        zhCN = "踏风",
        zhTW = "御風"
    },
    ["mw"] = {
        esES = "Tejedor de Niebla",
        esMX = "Tejedor de Niebla",
        enUS = "Mistweaver",
        deDE = "Nebelwirker",
        frFR = "Tisse-brume",
        itIT = "Plasmaneve",
        koKR = "운무",
        ptBR = "Tecelão da Névoa",
        ruRU = "Ткач туманов",
        zhCN = "织雾",
        zhTW = "織霧"
    },

    -- Caballero de la Muerte
    ["blood"] = {
        esES = "Sangre",
        esMX = "Sangre",
        enUS = "Blood",
        deDE = "Blut",
        frFR = "Sang",
        itIT = "Sangue",
        koKR = "혈기",
        ptBR = "Sangue",
        ruRU = "Кровь",
        zhCN = "鲜血",
        zhTW = "血魄"
    },
    ["unholy"] = {
        esES = "Profano",
        esMX = "Profano",
        enUS = "Unholy",
        deDE = "Unheilig",
        frFR = "Impie",
        itIT = "Empietà",
        koKR = "부정",
        ptBR = "Profano",
        ruRU = "Нечестивость",
        zhCN = "邪恶",
        zhTW = "穢邪"
    },

    -- Cazador de Demonios
    ["demonhunter"] = {
        esES = "Cazador de Demonios",
        esMX = "Cazador de Demonios",
        enUS = "Demon Hunter",
        deDE = "Dämonenjäger",
        frFR = "Chasseur de démons",
        itIT = "Cacciatore di Demoni",
        koKR = "악마사냥꾼",
        ptBR = "Caçador de Demônios",
        ruRU = "Охотник на демонов",
        zhCN = "恶魔猎手",
        zhTW = "惡魔獵人"
    },
    ["dh"] = {
        esES = "Cazador de Demonios",
        esMX = "Cazador de Demonios",
        enUS = "Demon Hunter",
        deDE = "Dämonenjäger",
        frFR = "Chasseur de démons",
        itIT = "Cacciatore di Demoni",
        koKR = "악마사냥꾼",
        ptBR = "Caçador de Demônios",
        ruRU = "Охотник на демонов",
        zhCN = "恶魔猎手",
        zhTW = "惡魔獵人"
    },
    ["havoc"] = {
        esES = "Devastación",
        esMX = "Devastación",
        enUS = "Havoc",
        deDE = "Verwüstung",
        frFR = "Dévastation",
        itIT = "Rovina",
        koKR = "파멸",
        ptBR = "Devastação",
        ruRU = "Истребление",
        zhCN = "浩劫",
        zhTW = "災虐"
    },
    ["vengeance"] = {
        esES = "Venganza",
        esMX = "Venganza",
        enUS = "Vengeance",
        deDE = "Rachsucht",
        frFR = "Vengeance",
        itIT = "Vendetta",
        koKR = "복수",
        ptBR = "Vingança",
        ruRU = "Месть",
        zhCN = "复仇",
        zhTW = "復仇"
    },
}