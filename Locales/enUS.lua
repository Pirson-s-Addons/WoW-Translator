local ADDON_NAME, addonTable = ...

-- ==========================================
-- IDIOMA POR DEFECTO (enUS / enGB)
-- ==========================================
-- Este fichero define TODAS las claves. Los demas Locales/<locale>.lua se cargan
-- despues y sobrescriben las que traducen; una clave que falte en uno de ellos
-- se queda con el texto de aqui, sin dar error. El test de cobertura de
-- _project/tests avisa si algun idioma se deja alguna.
--
-- GetLocale() solo puede devolver: enUS, enGB, deDE, esES, esMX, frFR, itIT,
-- koKR, ptBR, ruRU, zhCN y zhTW. Los demas ficheros de esta carpeta existen
-- porque el addon los ofrece como idioma DESTINO de traduccion.

local L = {}
addonTable.L = L

-- INGLÉS PREDETERMINADO (enUS / enGB)
L["UI_TITLE"] = "WoW Translator Configuration"
L["UI_ENABLE_TEXT"] = " Enable Real-time Translation"
L["UI_COLOR_BTN"] = "Choose Color"
L["UI_LANG_LABEL"] = "Language to translate:"
L["UI_TEST_BTN"] = "Test Translation"
L["TT_TEST_BTN"] = "Run a translation test in the chat window."
L["CHAT_LOADED"] = "Addon Loaded."
L["SLASH_ON"] = "Translations: |cff00ff00ENABLED|r"
L["SLASH_OFF"] = "Translations: |cffff0000DISABLED|r"
L["SLASH_TEST_ORIGINAL"] = "Original: "
L["SLASH_TEST_RESULT"] = "Result: "
L["SLASH_TEST_ERROR"] = "Translations disabled"
L["TEST_NO_MATCH"] = "No dictionary matches found."
L["HELP_HEADER"] = "--- WoW Translator Help ---"
L["HELP_CONFIG_MSG"] = "Opens options panel."
L["HELP_ONOFF_MSG"] = "Enable or disable translations."
L["HELP_TEST_MSG"] = "Perform a translation test."
L["HELP_SEARCH_MSG"] = "Look up a translation directly."
L["SEARCH_USAGE"] = "Usage: /wt search <word or phrase>"
L["SEARCH_NOT_FOUND"] = "No translation found for: "
L["CAT_HEADER"] = "Categories to translate:"
L["CAT_MAZZ"] = "Dungeons & Raids"
L["CAT_SOCIAL"] = "Social & Slang"
L["CAT_CLASSES"] = "Classes"
L["CAT_ROLES"] = "Roles"
L["CAT_STATS"] = "Statistics"
L["CAT_PROF"] = "Professions"
L["CAT_COMBAT"] = "Combat"
L["CAT_TRADE"] = "Trade"
L["CAT_GROUPS"] = "Groups"
L["CAT_GUILD"] = "Guild"
L["CAT_ZONES"] = "Zones (World)"
L["CAT_SETS"] = "Item Sets"
L["CAT_RACES"] = "Races"
L["CAT_STATUS"] = "Status / States"
L["GEN_HEADER"] = "General Configuration"
L["EXP_HEADER"] = "Dungeons & Raids by Expansion:"

-- Canales
L["CH_HEADER"] = "Channels to translate:"
L["CH_CAT_GENERAL"] = "General"
L["CH_CAT_WHISPERS"] = "Whispers & Bnet"
L["CH_CAT_GUILD"] = "Guild"
L["CH_CAT_GROUP"] = "Group"
L["CH_CAT_RAID"] = "Raid"
L["CH_CAT_PVP"] = "PvP"

L["CH_SAY"] = "Say"
L["CH_YELL"] = "Yell"
L["CH_EMOTE"] = "Emote"
L["CH_WHISPER"] = "Whisper (In)"
L["CH_WHISPER_INFORM"] = "Whisper (Out)"
L["CH_BN_WHISPER"] = "BNet (In)"
L["CH_BN_WHISPER_INFORM"] = "BNet (Out)"
L["CH_BN_INLINE_WHISPER"] = "BNet Inline (In)"
L["CH_BN_INLINE_WHISPER_INFORM"] = "BNet Inline (Out)"
L["CH_GUILD"] = "Guild"
L["CH_OFFICER"] = "Officer"
L["CH_CHANNEL"] = "Global Channels"
L["CH_PARTY"] = "Party"
L["CH_PARTY_LEADER"] = "Party Leader"
L["CH_INSTANCE"] = "Instance"
L["CH_INSTANCE_LEADER"] = "Instance Leader"
L["CH_RAID"] = "Raid"
L["CH_RAID_LEADER"] = "Raid Leader"
L["CH_RAID_WARNING"] = "Raid Warning"
L["CH_BATTLEGROUND"] = "Battleground"
L["CH_BATTLEGROUND_LEADER"] = "BG Leader"

-- Descripciones emergentes (Tooltips)
L["TT_ENABLE"] = "Enable or disable all translations globally."
L["TT_COLOR"] = "Choose the color for the translated text in chat."
L["TT_LANG"] = "Select which language you want to translate TO."
L["TT_CAT_MAZZ"] = "Enable translation for dungeon and raid terminology."
L["TT_CAT_SOCIAL"] = "Translate common internet slang and social expressions."
L["TT_CAT_CLASSES"] = "Translate class names and specializations."
L["TT_CAT_ROLES"] = "Translate dungeon roles (Tank, Healer, DPS)."
L["TT_CAT_STATS"] = "Translate item and character statistics."
L["TT_CAT_PROF"] = "Translate profession names."
L["TT_CAT_COMBAT"] = "Translate combat-related terms."
L["TT_CAT_TRADE"] = "Translate trading and economy terms."
L["TT_CAT_GROUPS"] = "Translate group-finding terminology."
L["TT_CAT_GUILD"] = "Translate guild-related terms."
L["TT_CAT_ZONES"] = "Translate zone and location names."
L["TT_CAT_SETS"] = "Translate item set names."
L["TT_CAT_RACES"] = "Translate playable race names."
L["TT_CAT_STATUS"] = "Translate statuses and states (AFK, OOM, etc)."

L["TT_CH_GENERIC"] = "Enable translation for this specific chat channel."

-- Minimapa
L["QT_MINIMAP_TT"] =
"|cffd597ffWoW Translator|r\n|cffffffffClick:|r Open Settings"

-- Buscador de grupos / Palabras ignoradas
L["CAT_LFG"] = "Group Finder"
L["TT_CAT_LFG"] = "Add the translation of a group's title and comment to its tooltip in the Group Finder."
L["LFG_TT_HEADER"] = "Translation:"
L["HELP_OUT_MSG"] = "Compose a message in English."
L["OUT_USAGE"] = "Usage: /wt en <text>"
L["IGN_TITLE"] = "Ignored Words"
L["IGN_DESC"] = "Words on this list are never translated. Useful for short acronyms that collide with ordinary words."
L["IGN_ADD"] = "Add"
L["IGN_INPUT_TT"] = "Type a word or phrase and press Enter."
L["IGN_EMPTY"] = "No ignored words yet."
L["IGN_REMOVE_TT"] = "Remove from the list."

-- Panel de opciones
L["OPT_GENERAL"] = "General"
L["OPT_CATEGORIES"] = "Categories"
L["OPT_EXPANSIONS"] = "Expansions"
L["OPT_CHANNELS"] = "Chat Channels"
L["OPT_LINKS"] = "Links"
L["OPT_COMMANDS"] = "Commands"
L["OPT_AUTHOR"] = "Author:"
L["OPT_VERSION"] = "Version:"
L["OPT_ABOUT_DESC"] = "Translates World of Warcraft terms, acronyms and slang on the fly in chat and in the Group Finder. Pick what to translate in the sections below."
L["OUT_HELP"] = "Write the sentence in your language and the addon leaves it in English in the chat box, ready for you to send. It never sends it for you. It only covers WoW jargon, not the whole language."

-- Vista de ayuda
L["OPT_HELP"] = "Help"
L["HELP_INTRO"] = "WoW Translator reads the chat and, whenever it spots a World of Warcraft term, acronym or piece of slang, adds its meaning right next to it in the colour you choose. It never rewrites the message: the original text always stays. It also works in the Group Finder, where it adds the translation of a group's title and comment to its tooltip."
L["HELP_FAQ"] = "Frequently asked questions"
L["HELP_Q_SCOPE"] = "Does it translate the whole chat?"
L["HELP_A_SCOPE"] = "No. It only knows game terms, acronyms and slang, not the language as a whole. A message in French stays in French; what gets explained is 'LFM', 'ICC', 'wipe' and the like."
L["HELP_Q_TARGET"] = "What does the target language mean?"
L["HELP_A_TARGET"] = "It is the language things are translated INTO. The source is always English, which is what these terms are written in. Set it to your own language in the General section."
L["HELP_Q_COMPOSE"] = "What is /wt en for?"
L["HELP_Q_IGNORE"] = "A word gets translated and I do not want it to"
L["HELP_A_IGNORE"] = "Add it in the Ignored Words section. Short acronyms that collide with ordinary words are the usual case. The word stops being translated at once, with no reload."
L["HELP_Q_NOTHING"] = "It is not translating anything, what should I check?"
L["HELP_A_NOTHING"] = "That translation is enabled in the General section, that the chat channel is ticked in Chat Channels, and that the category the term belongs to is ticked in Categories."
L["HELP_CONTACT"] = "Report a bug"
L["HELP_CONTACT_TEXT"] = "Bugs and suggestions go to the addon page on CurseForge: leave a comment there, or send a private message to the author. Copy the address below, WoW cannot open links."

-- Boton de seleccionar enlaces
L["UI_SELECT"] = "Select"
L["TT_SELECT"] = "Selects the whole link so you can copy it with Ctrl+C. WoW does not let addons write to the clipboard, so the last step is yours."

-- Valores por defecto
L["UI_RESET"] = "Restore defaults"
L["TT_RESET"] = "Puts every setting back the way it came: categories, expansions, chat channels, colour, target language and the ignored words list."
L["RESET_CONFIRM"] = "Restore every WoW Translator setting to its default value?\n\nThis also clears your ignored words list. The interface will be reloaded."
