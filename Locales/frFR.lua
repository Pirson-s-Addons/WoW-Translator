local ADDON_NAME, addonTable = ...

-- ==========================================
-- FRANCAIS (frFR)
-- ==========================================
if GetLocale() ~= "frFR" then return end
local L = addonTable.L

L["UI_TITLE"] = "Configuration de WoW Translator"
L["UI_ENABLE_TEXT"] = " Activer la traduction en temps réel"
L["UI_COLOR_BTN"] = "Choisir une couleur"
L["UI_LANG_LABEL"] = "Langue à traduire:"
L["UI_TEST_BTN"] = "Tester la traduction"
L["TT_TEST_BTN"] = "Exécutez un test de traduction dans la fenêtre de chat."
L["CHAT_LOADED"] = "Addon chargé."
L["SLASH_ON"] = "Traductions: |cff00ff00ACTIVÉES|r"
L["SLASH_OFF"] = "Traductions: |cffff0000DÉSACTIVÉES|r"
L["SLASH_TEST_ORIGINAL"] = "Original: "
L["SLASH_TEST_RESULT"] = "Résultat: "
L["SLASH_TEST_ERROR"] = "Traductions désactivées"
L["TEST_NO_MATCH"] = "Aucune correspondance trouvée."
L["HELP_HEADER"] = "--- Aide WoW Translator ---"
L["HELP_CONFIG_MSG"] = "Ouvre le panneau d'options."
L["HELP_ONOFF_MSG"] = "Active ou désactive les traductions."
L["HELP_TEST_MSG"] = "Effectue un test de traduction."
L["CAT_HEADER"] = "Catégories à traduire:"
L["CAT_MAZZ"] = "Donjons et Raids"
L["CAT_SOCIAL"] = "Social et Argot"
L["CAT_CLASSES"] = "Classes"
L["CAT_ROLES"] = "Rôles"
L["CAT_STATS"] = "Statistiques"
L["CAT_PROF"] = "Métiers"
L["CAT_COMBAT"] = "Combat"
L["CAT_TRADE"] = "Commerce"
L["CAT_GROUPS"] = "Groupes"
L["CAT_GUILD"] = "Guilde"
L["CAT_ZONES"] = "Zones (Monde)"
L["CAT_SETS"] = "Ensembles d'objets"
L["CAT_STATUS"] = "État / États"
L["GEN_HEADER"] = "Configuration générale"

-- Canales
L["CH_HEADER"] = "Canaux à traduire :"
L["CH_CAT_GENERAL"] = "Général"
L["CH_CAT_WHISPERS"] = "Chuchotements / BNet"
L["CH_CAT_GUILD"] = "Guilde"
L["CH_CAT_GROUP"] = "Groupe"
L["CH_CAT_RAID"] = "Raid"
L["CH_CAT_PVP"] = "JcJ"

L["CH_SAY"] = "Dire"
L["CH_YELL"] = "Crier"
L["CH_EMOTE"] = "Emote"
L["CH_WHISPER"] = "Chuchotement (Ent)"
L["CH_WHISPER_INFORM"] = "Chuchotement (Sort)"
L["CH_BN_WHISPER"] = "BNet (Ent)"
L["CH_BN_WHISPER_INFORM"] = "BNet (Sort)"
L["CH_BN_INLINE_WHISPER"] = "BNet Inline (Ent)"
L["CH_BN_INLINE_WHISPER_INFORM"] = "BNet Inline (Sort)"
L["CH_GUILD"] = "Guilde"
L["CH_OFFICER"] = "Officier"
L["CH_CHANNEL"] = "Canaux globaux"
L["CH_PARTY"] = "Groupe"
L["CH_PARTY_LEADER"] = "Chef de groupe"
L["CH_INSTANCE"] = "Instance"
L["CH_INSTANCE_LEADER"] = "Chef d'instance"
L["CH_RAID"] = "Raid"
L["CH_RAID_LEADER"] = "Chef de raid"
L["CH_RAID_WARNING"] = "Alerte de raid"
L["CH_BATTLEGROUND"] = "Champ de bataille"
L["CH_BATTLEGROUND_LEADER"] = "Chef de CB"

-- Descripciones emergentes (Tooltips)
L["TT_ENABLE"] = "Active ou désactive toutes les traductions globalement."
L["TT_COLOR"] = "Choisissez la couleur du texte traduit dans le chat."
L["TT_LANG"] = "Sélectionnez la langue VERS laquelle vous souhaitez traduire."
L["TT_CAT_MAZZ"] = "Activer la traduction pour la terminologie des donjons et raids."
L["TT_CAT_SOCIAL"] = "Traduire l'argot courant d'Internet et les expressions sociales."
L["TT_CAT_CLASSES"] = "Traduire les noms de classes et les spécialisations."
L["TT_CAT_ROLES"] = "Traduire les rôles de donjon (Tank, Soigneur, DPS)."
L["TT_CAT_STATS"] = "Traduire les statistiques d'objets et de personnages."
L["TT_CAT_PROF"] = "Traduire les noms de métiers."
L["TT_CAT_COMBAT"] = "Traduire les termes liés au combat."
L["TT_CAT_TRADE"] = "Traduire les termes de commerce et d'économie."
L["TT_CAT_GROUPS"] = "Traduire la terminologie de recherche de groupe."
L["TT_CAT_GUILD"] = "Traduire les termes liés à la guilde."
L["TT_CAT_ZONES"] = "Traduire les noms de zones et de lieux."
L["TT_CAT_SETS"] = "Traduire les noms d'ensembles d'objets."
L["TT_CAT_STATUS"] = "Traduire les statuts et états (AFK, OOM, etc)."


-- Quick Translate UI
-- Minimapa
L["QT_MINIMAP_TT"] =
"|cffd597ffWoW Translator|r\n|cffffffffClic :|r Ouvrir les paramètres"

-- Buscador de grupos / Palabras ignoradas
L["CAT_LFG"] = "Recherche de groupe"
L["TT_CAT_LFG"] = "Ajoute la traduction du titre et du commentaire du groupe à l'infobulle de la recherche de groupe."
L["LFG_TT_HEADER"] = "Traduction :"
L["HELP_OUT_MSG"] = "Rédiger un message en anglais."
L["OUT_USAGE"] = "Utilisation : /wt en <texte>"
L["IGN_TITLE"] = "Mots ignorés"
L["IGN_DESC"] = "Les mots de cette liste ne sont jamais traduits. Utile pour les acronymes courts qui entrent en conflit avec des mots courants."
L["IGN_ADD"] = "Ajouter"
L["IGN_INPUT_TT"] = "Saisissez un mot ou une expression et appuyez sur Entrée."
L["IGN_EMPTY"] = "Aucun mot ignoré pour l'instant."
L["IGN_REMOVE_TT"] = "Retirer de la liste."


L["CAT_RACES"] = "Races"
L["EXP_HEADER"] = "Donjons et raids par extension :"
L["HELP_SEARCH_MSG"] = "Rechercher directement une traduction."
L["SEARCH_NOT_FOUND"] = "Aucune traduction trouvée pour : "
L["SEARCH_USAGE"] = "Utilisation : /wt search <mot ou expression>"
L["TT_CAT_RACES"] = "Traduit les noms des races jouables."
L["TT_CH_GENERIC"] = "Activer la traduction pour ce canal de discussion."

-- Panel de opciones
L["OPT_GENERAL"] = "Général"
L["OPT_CATEGORIES"] = "Catégories"
L["OPT_EXPANSIONS"] = "Extensions"
L["OPT_CHANNELS"] = "Canaux de discussion"
L["OPT_LINKS"] = "Liens"
L["OPT_COMMANDS"] = "Commandes"
L["OPT_AUTHOR"] = "Auteur :"
L["OPT_VERSION"] = "Version :"
L["OPT_ABOUT_DESC"] = "Traduit à la volée les termes, acronymes et l'argot de World of Warcraft dans la discussion et la recherche de groupe. Choisissez quoi traduire dans les sections ci-dessous."
L["OUT_HELP"] = "Écrivez la phrase dans votre langue et l'addon la dépose en anglais dans la zone de discussion, prête à être envoyée. Il ne l'envoie jamais à votre place. Il ne couvre que l'argot de WoW, pas toute la langue."

-- Vista de ayuda
L["OPT_HELP"] = "Aide"
L["HELP_INTRO"] = "WoW Translator lit la discussion et, chaque fois qu'il reconnaît un terme, un acronyme ou de l'argot de World of Warcraft, ajoute sa signification juste à côté, dans la couleur de votre choix. Il ne réécrit jamais le message : le texte d'origine reste toujours. Il fonctionne aussi dans la recherche de groupe, où il ajoute à l'infobulle la traduction du titre et du commentaire."
L["HELP_FAQ"] = "Questions fréquentes"
L["HELP_Q_SCOPE"] = "Traduit-il toute la discussion ?"
L["HELP_A_SCOPE"] = "Non. Il ne connaît que les termes, acronymes et l'argot du jeu, pas la langue entière. Un message en allemand reste en allemand ; ce qui est expliqué, c'est 'LFM', 'ICC', 'wipe' et compagnie."
L["HELP_Q_TARGET"] = "Que signifie la langue cible ?"
L["HELP_A_TARGET"] = "C'est la langue VERS laquelle on traduit. La source est toujours l'anglais, la langue dans laquelle ces termes sont écrits. Réglez-la sur votre propre langue dans la section Général."
L["HELP_Q_COMPOSE"] = "À quoi sert /wt en ?"
L["HELP_Q_IGNORE"] = "Un mot est traduit et je ne le veux pas"
L["HELP_A_IGNORE"] = "Ajoutez-le dans la section Mots ignorés. Le cas typique, ce sont les acronymes courts qui entrent en conflit avec des mots courants. Il cesse d'être traduit immédiatement, sans rechargement."
L["HELP_Q_NOTHING"] = "Il ne traduit rien, que vérifier ?"
L["HELP_A_NOTHING"] = "Que la traduction soit activée dans la section Général, que le canal soit coché dans Canaux de discussion, et que la catégorie du terme soit cochée dans Catégories."
L["HELP_CONTACT"] = "Signaler un bug"
L["HELP_CONTACT_TEXT"] = "Les bugs et suggestions vont sur la page de l'addon sur CurseForge : laissez-y un commentaire, ou envoyez un message privé à l'auteur. Copiez l'adresse ci-dessous, WoW ne peut pas ouvrir de liens."

-- Boton de seleccionar enlaces
L["UI_SELECT"] = "Sélectionner"
L["TT_SELECT"] = "Sélectionne le lien entier pour que vous puissiez le copier avec Ctrl+C. WoW ne laisse pas les addons écrire dans le presse-papiers, la dernière étape vous revient."

-- Valores por defecto
L["UI_RESET"] = "Valeurs par défaut"
L["TT_RESET"] = "Remet tous les réglages dans leur état d'origine : catégories, extensions, canaux de discussion, couleur, langue cible et liste des mots ignorés."
L["RESET_CONFIRM"] = "Remettre tous les réglages de WoW Translator à leurs valeurs par défaut ?\n\nCela vide aussi votre liste de mots ignorés. L'interface sera rechargée."
