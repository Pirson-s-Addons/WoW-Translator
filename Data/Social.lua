local ADDON_NAME, addonTable = ...
addonTable.SocialDict = {
    ["ty"] = { 
        esES = "Gracias", esMX = "Gracias", enUS = "Thank you", deDE = "Danke", 
        frFR = "Merci", itIT = "Grazie", koKR = "감사", ptBR = "Obrigado", 
        ruRU = "Спасибо/спс", zhCN = "谢谢", zhTW = "謝謝" 
    },
    ["thx"] = { 
        esES = "Gracias", esMX = "Gracias", enUS = "Thanks", deDE = "Danke", 
        frFR = "Merci", itIT = "Grazie", koKR = "감사", ptBR = "Valeu", 
        ruRU = "Спасибо/спс", zhCN = "谢谢", zhTW = "謝謝" 
    },
    ["np"] = { 
        esES = "Sin problema", esMX = "No hay problema", enUS = "No problem", 
        deDE = "Kein Problem", frFR = "Pas de souci", itIT = "Nessun problema", 
        koKR = "문제 없음", ptBR = "Sem problemas", ruRU = "Без проблем", 
        zhCN = "没问题", zhTW = "沒問題" 
    },
    ["uw"] = { 
        esES = "De nada", esMX = "De nada", enUS = "You're welcome", 
        deDE = "Gern geschehen", frFR = "De rien", itIT = "Prego", 
        koKR = "천만에요", ptBR = "De nada", ruRU = "Пожалуйста", 
        zhCN = "不客气", zhTW = "不客氣" 
    },
    ["gj"] = { 
        esES = "Buen trabajo", esMX = "Buen trabajo", enUS = "Good job", deDE = "Gute Arbeit", 
        frFR = "Beau travail", itIT = "Bel lavoro", koKR = "잘함", ptBR = "Bom trabajo", 
        ruRU = "Гуд джоб", zhCN = "做得好", zhTW = "做得好" 
    },
    ["nvm"] = { 
        esES = "No importa", esMX = "No importa", enUS = "Never mind", 
        deDE = "Vergiss es", frFR = "Laisse tomber", itIT = "Non importa", 
        koKR = "신경 쓰지 마세요", ptBR = "Esquece", ruRU = "Неважно", 
        zhCN = "算了", zhTW = "算了" 
    },
    ["gz"] = { 
        esES = "Felicidades", esMX = "Felicidades", enUS = "Congratulations", 
        deDE = "Glückwunsch", frFR = "Félicitations", itIT = "Congratulazioni", 
        koKR = "축하", ptBR = "Parabéns", ruRU = "Грац/Поздравляю", 
        zhCN = "恭喜", zhTW = "恭喜" 
    },
    ["omg"] = { 
        esES = "Oh Dios mío", esMX = "Oh Dios mío", enUS = "Oh my God", 
        deDE = "Oh mein Gott", frFR = "Oh mon Dieu", itIT = "Oh mio Dio", 
        koKR = "세상에", ptBR = "Ai meu Deus", ruRU = "О боже", 
        zhCN = "我的天呐", zhTW = "我的天呐" 
    },
    ["lol"] = { 
        esES = "Risa", esMX = "Risa", enUS = "Laughing out loud", 
        deDE = "Lachen", frFR = "Rire", itIT = "Risata", 
        koKR = "ㅋㅋㅋ", ptBR = "Risos", ruRU = "Лол/Смех", 
        zhCN = "哈哈", zhTW = "哈哈" 
    },
    ["ac"] = { 
        esES = "Clase de Armadura", esMX = "Clase de Armadura", enUS = "Armor Class", deDE = "Rüstungsklasse", 
        frFR = "Classe d'armure", itIT = "Classe Armatura", koKR = "방어도 수치", ptBR = "Classe de Armadura", 
        ruRU = "Класс брони", zhCN = "护甲等级", zhTW = "護甲等級" 
    },
    ["ae"] = { 
        esES = "Efecto de Área", esMX = "Efecto de Área", enUS = "Area Effect", deDE = "Flächeneffekt", 
        frFR = "Effet de zone", itIT = "Effetto ad area", koKR = "광역 효과", ptBR = "Efeito de Área", 
        ruRU = "Эффект по области", zhCN = "区域效果", zhTW = "區域效果" 
    },
    ["dd"] = { 
        esES = "Daño Directo", esMX = "Daño Directo", enUS = "Direct Damage", deDE = "Direktschaden", 
        frFR = "Dégâts directs", itIT = "Danno diretto", koKR = "직접 데미지", ptBR = "Dano Direto", 
        ruRU = "Direct Damage (Прямой урон)", zhCN = "直接伤害", zhTW = "直接傷害" 
    },
    ["fh"] = { 
        esES = "Vida Completa", esMX = "Vida Completa", enUS = "Full Health", deDE = "Volle Gesundheit", 
        frFR = "Vie pleine", itIT = "Vita máxima", koKR = "체력 가득", ptBR = "Vida Completa", 
        ruRU = "Full HP (Full HP)", zhCN = "满血", zhTW = "滿血" 
    },
    ["fm"] = { 
        esES = "Maná Completo", esMX = "Maná Completo", enUS = "Full Mana", deDE = "Volles Mana", 
        frFR = "Mana plein", itIT = "Mana al máximo", koKR = "마나 가득", ptBR = "Mana Completo", 
        ruRU = "Full Mana (Мулл мана)", zhCN = "满蓝", zhTW = "滿藍" 
    },
    ["fvf"] = { 
        esES = "Facción contra Facción", esMX = "Facción contra Facción", enUS = "Faction vs Faction", deDE = "Fraktion gegen Fraktion", 
        frFR = "Faction contre Faction", itIT = "Fazione contro Fazione", koKR = "진영 대 진영", ptBR = "Facção contra Facção", 
        ruRU = "Фракция против фракции", zhCN = "阵营对阵营", zhTW = "陣營對陣營" 
    },
    ["hp"] = { 
        esES = "Puntos de Vida", esMX = "Puntos de Vida", enUS = "Hit Points", deDE = "Trefferpunkte", 
        frFR = "Points de vie", itIT = "Punti Vita", koKR = "생명력", ptBR = "Pontos de Vida", 
        ruRU = "ХП (Здоровье)", zhCN = "生命值", zhTW = "生命值" 
    },
    ["ks"] = { 
        esES = "Robo de Muerte", esMX = "Robo de Muerte", enUS = "Kill Steal", deDE = "Killstealing", 
        frFR = "Kill Steal", itIT = "Kill Steal", koKR = "막타 뺏기", ptBR = "Kill Steal", 
        ruRU = "Килстил", zhCN = "抢怪/抢人头", zhTW = "搶怪/搶人頭" 
    },
    ["lom"] = { 
        esES = "Poco Maná", esMX = "Poco Maná", enUS = "Low on Mana", deDE = "Wenig Mana", 
        frFR = "Peu de mana", itIT = "Poco mana", koKR = "마나 낮음", ptBR = "Pouco Mana", 
        ruRU = "Мало маны", zhCN = "法力不足", zhTW = "法力不足" 
    },
    ["oom"] = { 
        esES = "Sin Maná", esMX = "Sin Maná", enUS = "Out of Mana", deDE = "Kein Mana", 
        frFR = "Plus de mana", itIT = "Senza mana", koKR = "마나 오링", ptBR = "Sem Mana", 
        ruRU = "Оом (Без маны)", zhCN = "没蓝了", zhTW = "沒藍了" 
    },
    ["npc"] = { 
        esES = "Personaje No Jugador", esMX = "Personaje No Jugador", enUS = "Non-Player Character", deDE = "Nicht-Spieler-Charakter", 
        frFR = "Personnage non-joueur", itIT = "Personaggio no-giocatore", koKR = "NPC", ptBR = "Personagem Não Jogável", 
        ruRU = "НИП", zhCN = "非玩家角色", zhTW = "非玩家角色" 
    },
    ["pc"] = { 
        esES = "Personaje Jugador", esMX = "Personaje Jugador", enUS = "Player Character", deDE = "Spielercharakter", 
        frFR = "Personnage joueur", itIT = "Personaggio giocatore", koKR = "플레이어 캐릭터", ptBR = "Personagem Jogador", 
        ruRU = "Игрок", zhCN = "玩家角色", zhTW = "玩家角色" 
    },
    ["pst"] = { 
        esES = "Susurra por favor", esMX = "Susurra por favor", enUS = "Please send tell", deDE = "Bitte flüstern", 
        frFR = "Murmurez svp", itIT = "Sussurrare per favore", koKR = "귓속말 부탁", ptBR = "Sussurre por favor", 
        ruRU = "ПМ/Шепни", zhCN = "请私聊", zhTW = "請私聊" 
    },
    ["pve"] = { 
        esES = "Jugador contra Entorno", esMX = "Jugador contra Entorno", enUS = "Player vs Environment", deDE = "Spieler gegen Umgebung", 
        frFR = "Joueur contre Environnement", itIT = "Giocatore contro Ambiente", koKR = "PvE", ptBR = "Jogador contra Ambiente", 
        ruRU = "ПвЕ", zhCN = "副本模式", zhTW = "副本模式" 
    },
    ["pvp"] = { 
        esES = "Jugador contra Jugador", esMX = "Jugador contra Jugador", enUS = "Player vs Player", deDE = "Spieler gegen Spieler", 
        frFR = "Joueur contre Joueur", itIT = "Giocatore contro Giocatore", koKR = "PvP", ptBR = "Jogador contra Jogador", 
        ruRU = "ПвП", zhCN = "玩家对战", zhTW = "玩家對戰" 
    },
    ["mog"] = {
        esES = "Transfiguración", esMX = "Transfiguración", enUS = "Transmog",
        deDE = "Transmog", frFR = "Transmogrification", itIT = "Trasmogrificazione",
        koKR = "형상변환", ptBR = "Transmog", ruRU = "Трансмог",
        zhCN = "幻化", zhTW = "塑形"
    },
    ["dc"] = {
        esES = "Discord", esMX = "Discord", enUS = "Discord",
        deDE = "Discord", frFR = "Discord", itIT = "Discord",
        koKR = "디스코드", ptBR = "Discord", ruRU = "Дискорд",
        zhCN = "Discord", zhTW = "Discord"
    },
    ["ofc"] = {
        esES = "Por supuesto", esMX = "Por supuesto", enUS = "Of course",
        deDE = "Natürlich", frFR = "Bien sûr", itIT = "Certo",
        koKR = "물론", ptBR = "Claro", ruRU = "Конечно",
        zhCN = "当然", zhTW = "當然"
    },
    ["gg"] = {
        esES = "Bien jugado", esMX = "Bien jugado", enUS = "Good game",
        deDE = "Gutes Spiel", frFR = "Bien joué", itIT = "Bella partita",
        koKR = "수고했어요", ptBR = "Bom jogo", ruRU = "Хорошая игра",
        zhCN = "打得好", zhTW = "打得好"
    },
    ["btw"] = {
        esES = "Por cierto", esMX = "Por cierto", enUS = "By the way",
        deDE = "Übrigens", frFR = "Au fait", itIT = "A proposito",
        koKR = "그런데", ptBR = "Aliás", ruRU = "Кстати",
        zhCN = "顺便说一下", zhTW = "順便說一下"
    },
    ["hf"] = {
        esES = "Diviértete", esMX = "Diviértete", enUS = "Have fun",
        deDE = "Viel Spaß", frFR = "Amuse-toi bien", itIT = "Divertiti",
        koKR = "즐겜", ptBR = "Divirta-se", ruRU = "Удачи",
        zhCN = "玩得开心", zhTW = "玩得開心"
    },
    ["idk"] = {
        esES = "No sé", esMX = "No sé", enUS = "I don't know",
        deDE = "Keine Ahnung", frFR = "Je ne sais pas", itIT = "Non lo so",
        koKR = "몰라요", ptBR = "Não sei", ruRU = "Не знаю",
        zhCN = "不知道", zhTW = "不知道"
    },
    ["glhf"] = {
        esES = "Buena suerte y diviértete", esMX = "Buena suerte y diviértete",
        enUS = "Good luck, have fun", deDE = "Viel Glück und Spaß",
        frFR = "Bonne chance, amuse-toi", itIT = "Buona fortuna, divertiti",
        koKR = "행운을 빌어요 즐겜", ptBR = "Boa sorte, divirta-se",
        ruRU = "Удачи и приятной игры", zhCN = "祝你好运，玩得开心",
        zhTW = "祝你好運，玩得開心"
    },
    ["gl"] = {
        esES = "Buena suerte", esMX = "Buena suerte", enUS = "Good luck",
        deDE = "Viel Glück", frFR = "Bonne chance", itIT = "Buona fortuna",
        koKR = "행운을 빌어요", ptBR = "Boa sorte", ruRU = "Удачи",
        zhCN = "好运", zhTW = "好運"
    },
    ["asap"] = {
        esES = "Lo antes posible", esMX = "Lo antes posible", enUS = "As soon as possible",
        deDE = "So schnell wie möglich", frFR = "Dès que possible",
        itIT = "Il prima possibile", koKR = "최대한 빨리",
        ptBR = "O mais rápido possível", ruRU = "Как можно скорее",
        zhCN = "尽快", zhTW = "盡快"
    },
    ["nt"] = {
        esES = "Buen intento", esMX = "Buen intento", enUS = "Nice try",
        deDE = "Guter Versuch", frFR = "Bien tenté",
        itIT = "Bel tentativo", koKR = "아깝다",
        ptBR = "Boa tentativa", ruRU = "Хорошая попытка",
        zhCN = "不错的尝试", zhTW = "不錯的嘗試"
    },
    ["w8"] = {
        esES = "Espera", esMX = "Espera", enUS = "Wait",
        deDE = "Warte", frFR = "Attends",
        itIT = "Aspetta", koKR = "잠깐",
        ptBR = "Espera", ruRU = "Подожди",
        zhCN = "等等", zhTW = "等等"
    },
    ["mb"] = {
        esES = "Mala mía", esMX = "Mala mía", enUS = "My bad",
        deDE = "Mein Fehler", frFR = "Désolé",
        itIT = "Colpa mia", koKR = "내 실수",
        ptBR = "Foi mal", ruRU = "Моя ошибка",
        zhCN = "我的错", zhTW = "我的錯"
    },
    ["u2"] = {
        esES = "Tú también", esMX = "Tú también", enUS = "You too",
        deDE = "Du auch", frFR = "Toi aussi",
        itIT = "Anche a te", koKR = "너도",
        ptBR = "Você também", ruRU = "Тебе тоже",
        zhCN = "你也是", zhTW = "你也是"
    },
    ["bb"] = {
        esES = "Adiós", esMX = "Adiós", enUS = "Bye bye",
        deDE = "Tschüss", frFR = "Salut",
        itIT = "Ciao", koKR = "잘 가",
        ptBR = "Tchau", ruRU = "Пока",
        zhCN = "拜拜", zhTW = "掰掰"
    },
    ["kk"] = {
        esES = "Vale", esMX = "Vale", enUS = "Ok",
        deDE = "Ok", frFR = "Ok",
        itIT = "Ok", koKR = "오케이",
        ptBR = "Ok", ruRU = "Ок",
        zhCN = "好", zhTW = "好"
    },
    ["afk"] = { 
        esES = "Ausente", esMX = "Ausente", enUS = "Away from Keyboard", deDE = "Abwesend", 
        frFR = "Absent", itIT = "Assente", koKR = "자리비움", ptBR = "Ausente", ruRU = "АФК", 
        zhCN = "暂离", zhTW = "暫離"
    },
    ["brb"] = { 
        esES = "Vuelvo enseguida", esMX = "Vuelvo enseguida", enUS = "Be right back", 
        deDE = "Gleich wieder da", frFR = "Reviens de suite", itIT = "Torno subito", 
        koKR = "곧 돌아옴", ptBR = "Volto logo", ruRU = "Скоро буду", zhCN = "马上回来", zhTW = "馬上回來"
    },
    ["omw"] = { 
        esES = "En camino", esMX = "En camino", enUS = "On my way", deDE = "Bin unterwegs", 
        frFR = "En route", itIT = "Sto arrivando", koKR = "가는 중", ptBR = "A caminho", 
        ruRU = "В пути", zhCN = "在路上", zhTW = "在路上" 
    },
    ["inc"] = { 
        esES = "En camino", esMX = "En camino", enUS = "On my way", deDE = "Bin unterwegs", 
        frFR = "En route", itIT = "Sto arrivando", koKR = "가는 중", ptBR = "A caminho", 
        ruRU = "В пути", zhCN = "在路上", zhTW = "在路上" 
    },
}