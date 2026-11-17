<p align="center"><a href="https://www.curseforge.com/wow/addons/wow-translator"><img src="https://raw.githubusercontent.com/Pirson-s-Addons/.github/main/profile/assets/readme-wt-en.svg" width="100%" alt="WoW Translator"/></a></p>

<p align="center"><b>English</b> · <a href="README.es.md">Español</a></p>

<p align="center">
<a href="https://www.curseforge.com/wow/addons/wow-translator"><b>CurseForge</b></a> ·
<a href="https://github.com/Pirson-s-Addons/WoW-Translator/releases/latest"><b>Download</b></a>
</p>

## Screenshots

<p align="center">
<a href="https://www.youtube.com/watch?v=DmyrbF9iDdQ"><img src="https://img.youtube.com/vi/DmyrbF9iDdQ/maxresdefault.jpg" width="640" alt="How to use WoW Translator v2.00"></a><br>
<sub>▶️ How to use WoW Translator v2.00</sub>
</p>

<table>
<tr>
<td align="center" width="50%"><img src="https://media.forgecdn.net/attachments/1643/305/languajes-png.png" alt="All languages in chat, in real time"><br><sub>All languages in chat, in real time</sub></td>
</tr>
</table>

## What it does

WoW Translator reads incoming chat messages and adds the meaning of WoW jargon next to each term, in the colour you choose. A message like `LFM ICC HC 25m Need Tank and Healer` keeps its original text, with the translation of every recognised acronym or word added in brackets. Nothing is sent for you: it only annotates what you receive.

## Features

- Translates dungeon and raid acronyms, slang, classes, roles, stats, professions, combat, trade, group, guild and status terms.
- 44 target languages; defaults to your game client's language.
- Whole sentences: typical messages (looking for group, recruiting, trade, crafters, portals, guild recruiting) also get the full sentence on a line below, in the speaker's voice, in 20 languages.
- Zone, item set and race names from LibBabble, in your client's language, each with its own colour.
- Turn each category and the instance names of each expansion (Classic to Midnight) on or off.
- Pick which chat channels are translated: say, yell, emote, global channels, whispers, Battle.net, guild, party, raid, instance, battleground and communities.
- Ignore list for words you never want translated.
- `/wt en` turns text written in your target language back into English WoW terms and leaves it in the chat box for you to review and send.
- Beta: also recognises WoW slang written in Korean and Simplified Chinese (off by default).
- Minimap button and options panel translated into 20 languages.

## Usage

- `/wt config` — open the options panel (also from the minimap button).
- `/wt on` / `/wt off` — enable or disable translations.
- `/wt test` — run a translation test in chat.
- `/wt search <word>` — look up a translation directly.
- `/wt en <text>` — compose a message in English.
- `/wt` — list the commands.

The options panel has General (enable, colour, target language, slang in other languages, test and reset buttons), Categories, Expansions, Chat Channels, Ignored Words and Help.

## Installation

1. Download the zip from the [latest release](https://github.com/Pirson-s-Addons/WoW-Translator/releases/latest) or from [CurseForge](https://www.curseforge.com/wow/addons/wow-translator).
2. Extract the `WoWTranslator` folder into the `Interface/AddOns/` folder of your game version:
   - Retail: `World of Warcraft/_retail_/Interface/AddOns/`
   - Mists of Pandaria Classic: `World of Warcraft/_classic_/Interface/AddOns/`
   - Classic Era: `World of Warcraft/_classic_era_/Interface/AddOns/`
   - Anniversary: `World of Warcraft/_anniversary_/Interface/AddOns/`
   - WoW Forever: `World of Warcraft/_forever_/Interface/AddOns/`
3. Restart WoW and enable the addon.

## Notes

- Besides current clients, it ships TOC files for older clients (2.4.3, 3.3.5, 4.3, 5.4, WoD 6.2, Legion 7.3, BfA 8.3 and Shadowlands 9.2), such as those used on private servers.
- Settings are saved account-wide in `WoWTranslatorDB`.
- Part of the slang (sry, ez, o7, w2w, brez, m+, ksm, touch grass...) comes from [BabelChat](https://github.com/Yumash/BabelChat) by Andrey Yumashev, used with his permission (MIT).

## For addon authors

<details>
<summary><b>Public API</b></summary>

Read-only and versioned. It reads the whole dictionary, not just the categories the player turned on. Add `## OptionalDeps: WoWTranslator` to your TOC.

```lua
local api = WoWTranslatorAPI
if api and api.version == 1 then
    api.Lookup("lfm")            -- translation in the client's language, category ("GruposDict"...)
    api.Lookup("ty", "deDE")     -- "Danke"
    api.GetTranslations("ty")    -- { esES = "Gracias", enUS = "Thank you", ... } (copy)
    api.GetTerms()               -- { { term, category, multiword }, ... } to spot slang in a text
    api.GetCategories()          -- { "SocialDict", "GruposDict", ... }
end
```
</details>

<br/>

<p align="center"><a href="https://github.com/Pirson-s-Addons"><img src="https://raw.githubusercontent.com/Pirson-s-Addons/.github/main/profile/assets/readme-footer-en.svg" width="100%" alt="Part of Pirson's Addons. See all addons."/></a></p>
