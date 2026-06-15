local ADDON_NAME, addonTable = ...
addonTable.RolesDict = {
    ["tank"] = {
        esES = "Tanque", esMX = "Tanque", enUS = "Tank", deDE = "Tank", frFR = "Tank", itIT = "Difensore", koKR = "방어", ptBR = "Tanque", ruRU = "Танк", zhCN = "坦克", zhTW = "坦克", plPL = "Tank", svSE = "Tank", noNO = "Tank", trTR = "Tank", jaJP = "タンク", arSA = "دبابة", hiIN = "टैंक", thTH = "แทงค์", viVN = "Tank", csCZ = "Tank",
        nlNL = "Tank", roRO = "Tank", huHU = "Tank", elGR = "Tank", ukUA = "Танк", daDK = "Tank", fiFI = "Tankki", skSK = "Tank", bgBG = "Танк", hrHR = "Tenk", srRS = "Танк", slSI = "Tank", ltLT = "Tankas", lvLV = "Tanks", etEE = "Tank", idID = "Tank", msMY = "Tank", faIR = "تانک", heIL = "טנק", bnBD = "ট্যাঙ্ক", urPK = "ٹینک", taIN = "டேங்க்", teIN = "ట్యాంక్"
    },
    ["tanks"] = {
        esES = "Tanque", esMX = "Tanque", enUS = "Tank", deDE = "Tank", frFR = "Tank", itIT = "Difensore", koKR = "방어", ptBR = "Tanque", ruRU = "Танк", zhCN = "坦克", zhTW = "坦克", plPL = "Tanki", svSE = "Tanks", noNO = "Tanks", trTR = "Tanklar", jaJP = "タンク", arSA = "دبابات", hiIN = "टैंक", thTH = "แทงค์", viVN = "Tank", csCZ = "Tankové",
        nlNL = "Tanks", roRO = "Tanks", huHU = "Tankok", elGR = "Tanks", ukUA = "Танки", daDK = "Tanks", fiFI = "Tankit", skSK = "Tanky", bgBG = "Танкове", hrHR = "Tenkovi", srRS = "Танкови", slSI = "Tanki", ltLT = "Tankai", lvLV = "Tanki", etEE = "Tankid", idID = "Tank", msMY = "Tank", faIR = "تانک‌ها", heIL = "טנקים", bnBD = "ট্যাঙ্ক", urPK = "ٹینک", taIN = "டேங்க்", teIN = "ట్యాంకులు"
    },
    ["heals"] = {
        esES = "Sanador", esMX = "Sanador", enUS = "Healer", deDE = "Heiler", frFR = "Soigneur", itIT = "Guaritore", koKR = "치유", ptBR = "Cura", ruRU = "Хил", zhCN = "治疗", zhTW = "治療", plPL = "Leczenie", svSE = "Helning", noNO = "Heal", trTR = "Şifacı", jaJP = "ヒーラー", arSA = "معالجون", hiIN = "हीलर", thTH = "ฮีล", viVN = "Hồi máu", csCZ = "Léčení",
        nlNL = "Heals", roRO = "Heals", huHU = "Gyógyítás", elGR = "Heals", ukUA = "Хіл", daDK = "Heals", fiFI = "Parannukset", skSK = "Liečenie", bgBG = "Хийл", hrHR = "Heals", srRS = "Лечење", slSI = "Heals", ltLT = "Gydymas", lvLV = "Dziedināšana", etEE = "Heals", idID = "Heal", msMY = "Heal", faIR = "درمان", heIL = "ריפוי", bnBD = "হিল", urPK = "ہیل", taIN = "குணப்படுத்துதல்", teIN = "హీల్స్"
    },
    ["healers"] = {
        esES = "Sanador", esMX = "Sanador", enUS = "Healer", deDE = "Heiler", frFR = "Soigneur", itIT = "Guaritore", koKR = "치유", ptBR = "Cura", ruRU = "Хил", zhCN = "治疗", zhTW = "治療", plPL = "Uzdrowiciele", svSE = "Helare", noNO = "Healere", trTR = "Şifacılar", jaJP = "ヒーラー", arSA = "معالجون", hiIN = "हीलर", thTH = "ฮีล", viVN = "Người hồi máu", csCZ = "Léčitelé",
        nlNL = "Healers", roRO = "Vindecători", huHU = "Gyógyítók", elGR = "Healers", ukUA = "Цілителі", daDK = "Healere", fiFI = "Parantajat", skSK = "Liečitelia", bgBG = "Лечители", hrHR = "Healeri", srRS = "Исцелитељи", slSI = "Zdravilci", ltLT = "Gydytojai", lvLV = "Dziednieki", etEE = "Healerid", idID = "Penyembuh", msMY = "Penyembuh", faIR = "درمانگران", heIL = "מרפאים", bnBD = "হিলার", urPK = "ہیلرز", taIN = "குணப்படுத்துபவர்கள்", teIN = "హీలర్లు"
    },
    ["healer"] = {
        esES = "Sanador", esMX = "Sanador", enUS = "Healer", deDE = "Heiler", frFR = "Soigneur", itIT = "Guaritore", koKR = "치유", ptBR = "Cura", ruRU = "Хил", zhCN = "治疗", zhTW = "治療", plPL = "Uzdrowiciel", svSE = "Helare", noNO = "Healer", trTR = "Şifacı", jaJP = "ヒーラー", arSA = "معالج", hiIN = "हीलर", thTH = "ฮีล", viVN = "Người hồi máu", csCZ = "Léčitel",
        nlNL = "Healer", roRO = "Vindecător", huHU = "Gyógyító", elGR = "Healer", ukUA = "Цілитель", daDK = "Healer", fiFI = "Parantaja", skSK = "Liečiteľ", bgBG = "Лечител", hrHR = "Healer", srRS = "Исцелитељ", slSI = "Zdravilec", ltLT = "Gydytojas", lvLV = "Dziednieks", etEE = "Healer", idID = "Penyembuh", msMY = "Penyembuh", faIR = "درمانگر", heIL = "מרפא", bnBD = "হিলার", urPK = "ہیلر", taIN = "குணப்படுத்துபவர்", teIN = "హీలర్"
    },
    ["heal"] = {
        esES = "Sanador", esMX = "Sanador", enUS = "Healer", deDE = "Heiler", frFR = "Soigneur", itIT = "Guaritore", koKR = "치유", ptBR = "Cura", ruRU = "Хил", zhCN = "治疗", zhTW = "治療", plPL = "Lecz", svSE = "Hela", noNO = "Heal", trTR = "Şifa", jaJP = "ヒール", arSA = "شفاء", hiIN = "हीलर", thTH = "ฮีล", viVN = "Hồi máu", csCZ = "Léčení",
        nlNL = "Heal", roRO = "Vindecare", huHU = "Gyógyítás", elGR = "Heal", ukUA = "Хіл", daDK = "Heal", fiFI = "Parannus", skSK = "Liečenie", bgBG = "Хийл", hrHR = "Heal", srRS = "Лечење", slSI = "Zdravljenje", ltLT = "Gydyti", lvLV = "Dziedināt", etEE = "Ravi", idID = "Heal", msMY = "Heal", faIR = "درمان", heIL = "ריפוי", bnBD = "হিল", urPK = "ہیل", taIN = "குணப்படுத்துதல்", teIN = "హీల్"
    },
    ["dps"] = {
        esES = "Daño", esMX = "Daño", enUS = "DPS", deDE = "DPS", frFR = "DPS", itIT = "Assaltatore", koKR = "공격", ptBR = "Dano", ruRU = "ДД", zhCN = "输出", zhTW = "輸出", plPL = "DPS", svSE = "DPS", noNO = "DPS", trTR = "Hasar", jaJP = "アタッカー", arSA = "ضرر", hiIN = "डीपीएस", thTH = "ดีพีเอส", viVN = "DPS", csCZ = "Poškození za sekundu",
        nlNL = "DPS", roRO = "DPS", huHU = "DPS", elGR = "DPS", ukUA = "ДД", daDK = "DPS", fiFI = "DPS", skSK = "DPS", bgBG = "ДПС", hrHR = "DPS", srRS = "ДПС", slSI = "DPS", ltLT = "DPS", lvLV = "DPS", etEE = "DPS", idID = "DPS", msMY = "DPS", faIR = "دی پی اس", heIL = "נזק לשנייה", bnBD = "ডিপিএস", urPK = "ڈی پی ایس", taIN = "டிபிஎஸ்", teIN = "DPS"
    }
}
