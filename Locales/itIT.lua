local ADDON_NAME, addonTable = ...

-- ==========================================
-- ITALIANO (itIT)
-- ==========================================
if GetLocale() ~= "itIT" then return end
local L = addonTable.L

L["UI_TITLE"] = "Configurazione WoW Translator"
L["UI_ENABLE_TEXT"] = " Abilita traduzione in tempo reale"
L["UI_COLOR_BTN"] = "Scegli colore"
L["UI_LANG_LABEL"] = "Lingua da tradurre:"
L["UI_TEST_BTN"] = "Testa traduzione"
L["TT_TEST_BTN"] = "Esegue un test di traduzione nella finestra della chat."
L["CHAT_LOADED"] = "Addon caricato."
L["SLASH_ON"] = "Traduzioni: |cff00ff00ATTIVATE|r"
L["SLASH_OFF"] = "Traduzioni: |cffff0000DISATTIVATE|r"
L["SLASH_TEST_ORIGINAL"] = "Originale: "
L["SLASH_TEST_RESULT"] = "Risultato: "
L["SLASH_TEST_ERROR"] = "Traduzioni disattivate"
L["TEST_NO_MATCH"] = "Nessuna corrispondenza trovata."
L["HELP_HEADER"] = "--- Aiuto WoW Translator ---"
L["HELP_CONFIG_MSG"] = "Apre il pannello delle opzioni."
L["HELP_ONOFF_MSG"] = "Attiva o disattiva le traduzioni."
L["HELP_TEST_MSG"] = "Esegue un test di traduzione."
L["CAT_HEADER"] = "Categorie da tradurre:"
L["CAT_MAZZ"] = "Spedizioni e Incursioni"
L["CAT_SOCIAL"] = "Social e Gergo"
L["CAT_CLASSES"] = "Classi"
L["CAT_ROLES"] = "Ruoli"
L["CAT_STATS"] = "Statistiche"
L["CAT_PROF"] = "Professioni"
L["CAT_COMBAT"] = "Combattimento"
L["CAT_TRADE"] = "Commercio"
L["CAT_GROUPS"] = "Gruppi"
L["CAT_GUILD"] = "Gilda"
L["CAT_ZONES"] = "Zone (Mondo)"
L["CAT_SETS"] = "Set di Equipaggiamento"
L["CAT_STATUS"] = "Stato / Stati"
L["GEN_HEADER"] = "Configurazione generale"

-- Canales
L["CH_HEADER"] = "Canali da tradurre:"
L["CH_CAT_GENERAL"] = "Generale"
L["CH_CAT_WHISPERS"] = "Sussurri / BNet"
L["CH_CAT_GUILD"] = "Gilda"
L["CH_CAT_GROUP"] = "Gruppo"
L["CH_CAT_RAID"] = "Incursione"
L["CH_CAT_PVP"] = "JcJ"

L["CH_SAY"] = "Dire"
L["CH_YELL"] = "Urlare"
L["CH_EMOTE"] = "Emote"
L["CH_WHISPER"] = "Sussurro (Ent)"
L["CH_WHISPER_INFORM"] = "Sussurro (Usc)"
L["CH_BN_WHISPER"] = "BNet (Ent)"
L["CH_BN_WHISPER_INFORM"] = "BNet (Usc)"
L["CH_BN_INLINE_WHISPER"] = "BNet Inline (Ent)"
L["CH_BN_INLINE_WHISPER_INFORM"] = "BNet Inline (Usc)"
L["CH_GUILD"] = "Gilda"
L["CH_OFFICER"] = "Ufficiale"
L["CH_CHANNEL"] = "Canali globali"
L["CH_PARTY"] = "Gruppo"
L["CH_PARTY_LEADER"] = "Capogruppo"
L["CH_INSTANCE"] = "Istanza"
L["CH_INSTANCE_LEADER"] = "Capo istanza"
L["CH_RAID"] = "Incursione"
L["CH_RAID_LEADER"] = "Capoincursione"
L["CH_RAID_WARNING"] = "Avviso incursione"
L["CH_BATTLEGROUND"] = "Campo di battaglia"
L["CH_BATTLEGROUND_LEADER"] = "Capo CB"

-- Descripciones emergentes (Tooltips)
L["TT_ENABLE"] = "Abilita o disabilita tutte le traduzioni globalmente."
L["TT_COLOR"] = "Scegli il colore per il testo tradotto nella chat."
L["TT_LANG"] = "Seleziona la lingua VERSO la quale vuoi tradurre."
L["TT_CAT_MAZZ"] = "Abilita la traduzione per la terminologia di spedizioni e incursioni."
L["TT_CAT_SOCIAL"] = "Traduci il gergo comune di Internet e le espressioni sociali."
L["TT_CAT_CLASSES"] = "Traduci i nomi delle classi e le specializzazioni."
L["TT_CAT_ROLES"] = "Traduci i ruoli delle spedizioni (Tank, Sanatore, DPS)."
L["TT_CAT_STATS"] = "Traduci le statistiche degli oggetti e del personaggio."
L["TT_CAT_PROF"] = "Traduci i nomi delle professioni."
L["TT_CAT_COMBAT"] = "Traduci i termini relativi al combattimento."
L["TT_CAT_TRADE"] = "Traduci i termini commerciali ed economici."
L["TT_CAT_GROUPS"] = "Traduci la terminologia per la ricerca di gruppi."
L["TT_CAT_GUILD"] = "Traduci i termini relativi alla gilda."
L["TT_CAT_ZONES"] = "Traduci i nomi delle zone e dei luoghi."
L["TT_CAT_SETS"] = "Traduci i nomi dei set di oggetti."
L["TT_CAT_STATUS"] = "Traduci gli stati (AFK, OOM, ecc.)."


-- Quick Translate UI
-- Minimapa
L["QT_MINIMAP_TT"] =
"|cffd597ffWoW Translator|r\n|cffffffffClick:|r Apri Impostazioni"

-- Buscador de grupos / Palabras ignoradas
L["CAT_LFG"] = "Cerca gruppo"
L["TT_CAT_LFG"] = "Aggiunge al tooltip della ricerca gruppo la traduzione del titolo e del commento del gruppo."
L["LFG_TT_HEADER"] = "Traduzione:"
L["HELP_OUT_MSG"] = "Componi un messaggio in inglese."
L["OUT_USAGE"] = "Uso: /wt en <testo>"
L["IGN_TITLE"] = "Parole ignorate"
L["IGN_DESC"] = "Le parole in questo elenco non vengono mai tradotte. Utile per acronimi brevi che si scontrano con parole comuni."
L["IGN_ADD"] = "Aggiungi"
L["IGN_INPUT_TT"] = "Scrivi una parola o una frase e premi Invio."
L["IGN_EMPTY"] = "Nessuna parola ignorata al momento."
L["IGN_REMOVE_TT"] = "Rimuovi dall'elenco."


L["CAT_RACES"] = "Razze"
L["EXP_HEADER"] = "Spedizioni per espansione:"
L["HELP_SEARCH_MSG"] = "Cerca direttamente una traduzione."
L["SEARCH_NOT_FOUND"] = "Nessuna traduzione trovata per: "
L["SEARCH_USAGE"] = "Uso: /wt search <parola o frase>"
L["TT_CAT_RACES"] = "Traduce i nomi delle razze giocabili."
L["TT_CH_GENERIC"] = "Attiva la traduzione per questo canale di chat."

-- Panel de opciones
L["OPT_GENERAL"] = "Generale"
L["OPT_CATEGORIES"] = "Categorie"
L["OPT_EXPANSIONS"] = "Espansioni"
L["OPT_CHANNELS"] = "Canali di chat"
L["OPT_LINKS"] = "Collegamenti"
L["OPT_COMMANDS"] = "Comandi"
L["OPT_AUTHOR"] = "Autore:"
L["OPT_VERSION"] = "Versione:"
L["OPT_ABOUT_DESC"] = "Traduce al volo termini, acronimi e gergo di World of Warcraft nella chat e nella ricerca gruppo. Scegli cosa tradurre nelle sezioni qui sotto."
L["OUT_HELP"] = "Scrivi la frase nella tua lingua e l'addon la lascia in inglese nella casella della chat, pronta da inviare. Non la invia mai al posto tuo. Copre solo il gergo di WoW, non l'intera lingua."

-- Vista de ayuda
L["OPT_HELP"] = "Aiuto"
L["HELP_INTRO"] = "WoW Translator legge la chat e, ogni volta che riconosce un termine, un acronimo o un modo di dire di World of Warcraft, ne aggiunge il significato accanto, nel colore che scegli. Non riscrive mai il messaggio: il testo originale resta sempre. Funziona anche nella ricerca gruppo, dove aggiunge al tooltip la traduzione del titolo e del commento."
L["HELP_FAQ"] = "Domande frequenti"
L["HELP_Q_SCOPE"] = "Traduce tutta la chat?"
L["HELP_A_SCOPE"] = "No. Conosce solo termini, acronimi e gergo del gioco, non l'intera lingua. Un messaggio in francese resta in francese; quello che viene spiegato è 'LFM', 'ICC', 'wipe' e simili."
L["HELP_Q_TARGET"] = "Cosa significa lingua di destinazione?"
L["HELP_A_TARGET"] = "È la lingua VERSO cui si traduce. L'origine è sempre l'inglese, la lingua in cui sono scritti questi termini. Impostala sulla tua lingua nella sezione Generale."
L["HELP_Q_COMPOSE"] = "A cosa serve /wt en?"
L["HELP_Q_IGNORE"] = "Una parola viene tradotta e non voglio"
L["HELP_A_IGNORE"] = "Aggiungila nella sezione Parole ignorate. Il caso tipico sono gli acronimi brevi che si scontrano con parole comuni. Smette di essere tradotta subito, senza ricaricare."
L["HELP_Q_NOTHING"] = "Non traduce niente, cosa controllo?"
L["HELP_A_NOTHING"] = "Che la traduzione sia attiva nella sezione Generale, che il canale sia spuntato in Canali di chat, e che la categoria del termine sia spuntata in Categorie."
L["HELP_CONTACT"] = "Segnalare un errore"
L["HELP_CONTACT_TEXT"] = "Errori e suggerimenti vanno sulla pagina dell'addon su CurseForge: lascia un commento lì, o manda un messaggio privato all'autore. Copia l'indirizzo qui sotto, WoW non può aprire link."

-- Boton de seleccionar enlaces
L["UI_SELECT"] = "Seleziona"
L["TT_SELECT"] = "Seleziona tutto il collegamento così puoi copiarlo con Ctrl+C. WoW non permette agli addon di scrivere negli appunti, quindi l'ultimo passo tocca a te."

-- Valores por defecto
L["UI_RESET"] = "Valori predefiniti"
L["TT_RESET"] = "Riporta tutte le impostazioni a come erano: categorie, espansioni, canali di chat, colore, lingua di destinazione ed elenco delle parole ignorate."
L["RESET_CONFIRM"] = "Riportare tutte le impostazioni di WoW Translator ai valori predefiniti?\n\nQuesto svuota anche il tuo elenco di parole ignorate. L'interfaccia verrà ricaricata."
