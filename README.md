<h1 align="center">WoW Translator</h1>

<p align="center">
  <b>Translates World of Warcraft terms, acronyms and slang right in your chat</b>
</p>

<p align="center">
<a href="https://github.com/Pirson-s-Addons/WoW-Translator/releases/latest">
<img src="https://img.shields.io/github/v/release/Pirson-s-Addons/WoW-Translator?style=for-the-badge&color=A78BFA">
</a>
<img src="https://img.shields.io/badge/WoW-Retail_·_Classic_·_Legacy-C4B5FD?style=for-the-badge">
<a href="LICENSE">
<img src="https://img.shields.io/badge/License-MIT-E9D5FF?style=for-the-badge">
</a>
</p>

<p align="center">
<a href="README.es.md">🇪🇸 Español</a>
</p>

---

## 📸 Screenshots

<p align="center">
<a href="https://www.youtube.com/watch?v=DmyrbF9iDdQ"><img src="https://img.youtube.com/vi/DmyrbF9iDdQ/maxresdefault.jpg" width="640" alt="How to use WoW Translator v2.00"></a><br>
<sub>▶️ How to use WoW Translator v2.00</sub>
</p>

<table>
<tr>
<td align="center" width="50%"><img src="https://media.forgecdn.net/attachments/1643/305/languajes-png.png" alt="All languages in chat, in real time"><br><sub>All languages in chat, in real time</sub></td>
</tr>
</table>

---

## What it does
WoW Translator reads incoming chat messages and adds the meaning of WoW jargon next to each term, in the colour you choose. A message like `LFM ICC HC 25m Need Tank and Healer` keeps its original text, with the translation of every recognised acronym or word added in brackets. Nothing is sent for you: it only annotates what you receive.

## Features
- Translates dungeon and raid acronyms, slang, classes, roles, stats, professions, combat, trade, group, guild and status terms.
- 44 target languages; defaults to your game client's language.
- Zone, item set and race names from LibBabble, in your client's language, each with its own colour.
- Turn each category and the instance names of each expansion (Classic to Midnight) on or off.
- Pick which chat channels are translated: say, yell, emote, global channels, whispers, Battle.net, guild, party, raid, instance, battleground and communities.
- Ignore list for words you never want translated.
- `/wt en` turns text written in your target language back into English WoW terms and leaves it in the chat box for you to review and send.
- Beta: also recognises WoW slang written in Korean and Simplified Chinese (off by default).
- Minimap button and options panel translated into 20 languages.

## Installation
1. Download the zip from the [latest release](https://github.com/Pirson-s-Addons/WoW-Translator/releases/latest) or from [CurseForge](https://www.curseforge.com/wow/addons/wow-translator).
2. Extract the `WoWTranslator` folder into the `Interface/AddOns/` folder of your game version:
   - Retail: `World of Warcraft/_retail_/Interface/AddOns/`
   - Mists of Pandaria Classic: `World of Warcraft/_classic_/Interface/AddOns/`
   - Classic Era: `World of Warcraft/_classic_era_/Interface/AddOns/`
   - Anniversary: `World of Warcraft/_anniversary_/Interface/AddOns/`
   - WoW Forever: `World of Warcraft/_classic_beta_/Interface/AddOns/`
3. Restart WoW and enable the addon.

## Usage
- `/wt config` — open the options panel (also from the minimap button).
- `/wt on` / `/wt off` — enable or disable translations.
- `/wt test` — run a translation test in chat.
- `/wt search <word>` — look up a translation directly.
- `/wt en <text>` — compose a message in English.
- `/wt` — list the commands.

The options panel has General (enable, colour, target language, slang in other languages, test and reset buttons), Categories, Expansions, Chat Channels, Ignored Words and Help.

## Notes
- Besides current clients, it ships TOC files for older clients (2.4.3, 3.3.5, 4.3, 5.4, WoD 6.2, Legion 7.3, BfA 8.3 and Shadowlands 9.2), such as those used on private servers.
- Settings are saved account-wide in `WoWTranslatorDB`.

---

**Author**: Pirson · [GitHub](https://github.com/Pirson-s-Addons) · [CurseForge](https://www.curseforge.com/members/pirson/projects) · MIT License
