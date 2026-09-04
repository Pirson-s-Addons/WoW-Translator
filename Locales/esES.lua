local ADDON_NAME, addonTable = ...

-- ==========================================
-- ESPANOL (esES / esMX)
-- ==========================================
local locale = GetLocale()
if locale ~= "esES" and locale ~= "esMX" then return end
local L = addonTable.L

L["UI_TITLE"] = "Configuración de WoW Translator"
L["UI_ENABLE_TEXT"] = " Activar Traducción en tiempo real"
L["UI_COLOR_BTN"] = "Elegir Color"
L["UI_LANG_LABEL"] = "Idioma a traducir:"
L["UI_TEST_BTN"] = "Probar Traducción"
L["TT_TEST_BTN"] = "Realiza una prueba de traducción en la ventana de chat."
L["CHAT_LOADED"] = "Addon Cargado."
L["SLASH_ON"] = "Traducciones: |cff00ff00ACTIVADAS|r"
L["SLASH_OFF"] = "Traducciones: |cffff0000DESACTIVADAS|r"
L["SLASH_TEST_ORIGINAL"] = "Original: "
L["SLASH_TEST_RESULT"] = "Resultado: "
L["SLASH_TEST_ERROR"] = "Traducciones desactivadas"
L["TEST_NO_MATCH"] = "No se encontraron coincidencias."
L["HELP_HEADER"] = "--- WoW Translator Ayuda ---"
L["HELP_CONFIG_MSG"] = "Abre el panel de opciones."
L["HELP_ONOFF_MSG"] = "Activa o desactiva las traducciones."
L["HELP_TEST_MSG"] = "Realiza una prueba de traducción."
L["CAT_HEADER"] = "Categorías a traducir:"
L["CAT_MAZZ"] = "Mazmorras y Bandas"
L["CAT_SOCIAL"] = "Social y Jerga"
L["CAT_CLASSES"] = "Clases"
L["CAT_ROLES"] = "Roles"
L["CAT_STATS"] = "Estadísticas"
L["CAT_PROF"] = "Profesiones"
L["CAT_COMBAT"] = "Combate"
L["CAT_TRADE"] = "Comercio"
L["CAT_GROUPS"] = "Grupos"
L["CAT_GUILD"] = "Hermandad"
L["CAT_ZONES"] = "Zonas (Mundo)"
L["CAT_SETS"] = "Sets de Objetos"
L["CAT_STATUS"] = "Estado / Estados"
L["GEN_HEADER"] = "Configuración General"
L["EXP_HEADER"] = "Instancias por Expansión:"

-- Canales
L["CH_HEADER"] = "Canales a traducir:"
L["CH_CAT_GENERAL"] = "General"
L["CH_CAT_WHISPERS"] = "Susurros / BNet"
L["CH_CAT_GUILD"] = "Hermandad"
L["CH_CAT_GROUP"] = "Grupo"
L["CH_CAT_RAID"] = "Banda"
L["CH_CAT_PVP"] = "JcJ"

L["CH_SAY"] = "Decir"
L["CH_YELL"] = "Grito"
L["CH_EMOTE"] = "Emoción"
L["CH_WHISPER"] = "Susurro (Ent)"
L["CH_WHISPER_INFORM"] = "Susurro (Sal)"
L["CH_BN_WHISPER"] = "BNet (Ent)"
L["CH_BN_WHISPER_INFORM"] = "BNet (Sal)"
L["CH_BN_INLINE_WHISPER"] = "BNet Inline (Ent)"
L["CH_BN_INLINE_WHISPER_INFORM"] = "BNet Inline (Sal)"
L["CH_GUILD"] = "Hermandad"
L["CH_OFFICER"] = "Oficiales"
L["CH_CHANNEL"] = "Globales"
L["CH_PARTY"] = "Grupo"
L["CH_PARTY_LEADER"] = "Líder de Grupo"
L["CH_INSTANCE"] = "Instancia"
L["CH_INSTANCE_LEADER"] = "Líder de Instancia"
L["CH_RAID"] = "Banda"
L["CH_RAID_LEADER"] = "Líder de Banda"
L["CH_RAID_WARNING"] = "Alerta de Banda"
L["CH_BATTLEGROUND"] = "Campo de Batalla"
L["CH_BATTLEGROUND_LEADER"] = "Líder de CB"

-- Descripciones emergentes (Tooltips)
L["TT_ENABLE"] = "Activa o desactiva todas las traducciones de forma global."
L["TT_COLOR"] = "Elige el color del texto traducido en el chat."
L["TT_LANG"] = "Selecciona a qué idioma quieres traducir los mensajes."
L["TT_CAT_MAZZ"] = "Traducir terminología de mazmorras y bandas."
L["TT_CAT_SOCIAL"] = "Traducir jerga común de internet y expresiones sociales."
L["TT_CAT_CLASSES"] = "Traducir nombres de clases y especializaciones."
L["TT_CAT_ROLES"] = "Traducir roles (Tanque, Sanador, DPS)."
L["TT_CAT_STATS"] = "Traducir estadísticas de objetos y personajes."
L["TT_CAT_PROF"] = "Traducir nombres de profesiones."
L["TT_CAT_COMBAT"] = "Traducir términos relacionados con el combate."
L["TT_CAT_TRADE"] = "Traducir términos de comercio y economía."
L["TT_CAT_GROUPS"] = "Traducir terminología de búsqueda de grupo."
L["TT_CAT_GUILD"] = "Traducir términos relacionados con la hermandad."
L["TT_CAT_ZONES"] = "Traducir nombres de zonas y lugares del mundo."
L["TT_CAT_SETS"] = "Traducir nombres de sets de objetos."
L["TT_CAT_STATUS"] = "Traducir estados y situaciones (AFK, OOM, etc)."

L["TT_CH_GENERIC"] = "Activa la traducción para este canal específico."

-- Minimapa
L["QT_MINIMAP_TT"] =
"|cffd597ffWoW Translator|r\n|cffffffffClick:|r Abrir Configuración"

-- Buscador de grupos / Palabras ignoradas
L["CAT_LFG"] = "Buscador de grupos"
L["TT_CAT_LFG"] = "Añade al tooltip del Buscador de grupos la traducción del título y el comentario del grupo."
L["LFG_TT_HEADER"] = "Traducción:"
L["HELP_OUT_MSG"] = "Redacta un mensaje en inglés."
L["OUT_USAGE"] = "Uso: /wt en <texto>"
L["IGN_TITLE"] = "Palabras Ignoradas"
L["IGN_DESC"] = "Las palabras de esta lista no se traducen nunca. Útil para acrónimos cortos que chocan con palabras corrientes."
L["IGN_ADD"] = "Añadir"
L["IGN_INPUT_TT"] = "Escribe una palabra o frase y pulsa Intro."
L["IGN_EMPTY"] = "Todavía no hay palabras ignoradas."
L["IGN_REMOVE_TT"] = "Quitar de la lista."


L["CAT_RACES"] = "Razas"
L["HELP_SEARCH_MSG"] = "Busca una traducción directamente."
L["SEARCH_NOT_FOUND"] = "No se encontró traducción para: "
L["SEARCH_USAGE"] = "Uso: /wt search <palabra o frase>"
L["TT_CAT_RACES"] = "Traduce los nombres de las razas jugables."

-- Panel de opciones
L["OPT_GENERAL"] = "General"
L["OPT_CATEGORIES"] = "Categorías"
L["OPT_EXPANSIONS"] = "Expansiones"
L["OPT_CHANNELS"] = "Canales de chat"
L["OPT_LINKS"] = "Enlaces"
L["OPT_COMMANDS"] = "Comandos"
L["OPT_AUTHOR"] = "Autor:"
L["OPT_VERSION"] = "Versión:"
L["OPT_ABOUT_DESC"] = "Traduce sobre la marcha términos, acrónimos y jerga de World of Warcraft en el chat y en el Buscador de grupos. Elige qué traducir en las secciones de abajo."
L["OUT_HELP"] = "Escribe la frase en tu idioma y el addon la deja en inglés en la caja de chat, lista para enviar. Nunca la envía por ti. Solo cubre la jerga de WoW, no el idioma completo."

-- Vista de ayuda
L["OPT_HELP"] = "Ayuda"
L["HELP_INTRO"] = "WoW Translator lee el chat y, cada vez que reconoce un término, acrónimo o palabra de jerga de World of Warcraft, añade su significado al lado en el color que elijas. Nunca reescribe el mensaje: el texto original se queda siempre. También funciona en el Buscador de grupos, donde añade al tooltip la traducción del título y el comentario del grupo."
L["HELP_FAQ"] = "Preguntas frecuentes"
L["HELP_Q_SCOPE"] = "¿Traduce todo el chat?"
L["HELP_A_SCOPE"] = "No. Solo conoce términos, acrónimos y jerga del juego, no el idioma entero. Un mensaje en francés se queda en francés; lo que se explica es 'LFM', 'ICC', 'wipe' y similares."
L["HELP_Q_TARGET"] = "¿Qué es el idioma destino?"
L["HELP_A_TARGET"] = "Es el idioma AL que se traduce. El origen siempre es el inglés, que es el idioma en el que están escritos estos términos. Ponlo en tu propio idioma desde la sección General."
L["HELP_Q_COMPOSE"] = "¿Para qué sirve /wt en?"
L["HELP_Q_IGNORE"] = "Una palabra se traduce y no quiero que lo haga"
L["HELP_A_IGNORE"] = "Añádela en la sección Palabras Ignoradas. El caso típico son los acrónimos cortos que chocan con palabras corrientes. Deja de traducirse al momento, sin recargar la interfaz."
L["HELP_Q_NOTHING"] = "No traduce nada, ¿qué miro?"
L["HELP_A_NOTHING"] = "Que la traducción esté activada en la sección General, que el canal de chat esté marcado en Canales de chat, y que la categoría a la que pertenece el término esté marcada en Categorías."
L["HELP_CONTACT"] = "Reportar un error"
L["HELP_CONTACT_TEXT"] = "Los fallos y las sugerencias van a la página del addon en CurseForge: deja un comentario ahí, o manda un mensaje privado al autor. Copia la dirección de abajo, WoW no puede abrir enlaces."

-- Boton de seleccionar enlaces
L["UI_SELECT"] = "Seleccionar"
L["TT_SELECT"] = "Selecciona el enlace entero para que puedas copiarlo con Ctrl+C. WoW no deja a los addons escribir en el portapapeles, así que el último paso lo das tú."

-- Valores por defecto
L["UI_RESET"] = "Valores por defecto"
L["TT_RESET"] = "Devuelve todos los ajustes a como venían: categorías, expansiones, canales de chat, color, idioma destino y la lista de palabras ignoradas."
L["RESET_CONFIRM"] = "¿Devolver todos los ajustes de WoW Translator a sus valores por defecto?\n\nEsto también vacía tu lista de palabras ignoradas. Se recargará la interfaz."
