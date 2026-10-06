<h1 align="center">WoW Translator</h1>

<p align="center">
  <b>Traduce términos, acrónimos y jerga de World of Warcraft directamente en el chat</b>
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
<a href="README.md">🇬🇧 English</a>
</p>

---

## 📸 Capturas

<p align="center">
<a href="https://www.youtube.com/watch?v=DmyrbF9iDdQ"><img src="https://img.youtube.com/vi/DmyrbF9iDdQ/maxresdefault.jpg" width="640" alt="Cómo se usa WoW Translator v2.00"></a><br>
<sub>▶️ Cómo se usa WoW Translator v2.00</sub>
</p>

<table>
<tr>
<td align="center" width="50%"><img src="https://media.forgecdn.net/attachments/1643/305/languajes-png.png" alt="Todos los idiomas en el chat, en tiempo real"><br><sub>Todos los idiomas en el chat, en tiempo real</sub></td>
</tr>
</table>

---

## Qué hace
WoW Translator lee los mensajes que llegan al chat y añade junto a cada término de la jerga de WoW su significado, en el color que elijas. Un mensaje como `LFM ICC HC 25m Need Tank and Healer` conserva el texto original, con la traducción de cada acrónimo o palabra reconocida entre paréntesis. No envía nada por ti: solo anota lo que recibes.

## Funciones
- Traduce acrónimos de mazmorras y bandas, jerga, clases, roles, estadísticas, profesiones y términos de combate, comercio, grupos, hermandad y estados.
- 44 idiomas de destino; por defecto, el idioma de tu cliente.
- Nombres de zonas, conjuntos de objetos y razas de LibBabble, en el idioma de tu cliente y cada uno con su propio color.
- Activa o desactiva cada categoría y los nombres de instancia de cada expansión (de Classic a Midnight).
- Elige qué canales de chat se traducen: decir, gritar, emociones, canales globales, susurros, Battle.net, hermandad, grupo, banda, instancia, campo de batalla y comunidades.
- Lista de palabras ignoradas que nunca se traducen.
- `/wt en` convierte un texto escrito en tu idioma de destino a los términos de WoW en inglés y lo deja en la caja de chat para que lo revises y lo envíes tú.
- Beta: también reconoce jerga de WoW escrita en coreano y chino simplificado (desactivado por defecto).
- Botón en el minimapa y panel de opciones traducido a 20 idiomas.

## Instalación
1. Descarga el zip de la [última release](https://github.com/Pirson-s-Addons/WoW-Translator/releases/latest) o de [CurseForge](https://www.curseforge.com/wow/addons/wow-translator).
2. Extrae la carpeta `WoWTranslator` en la carpeta `Interface/AddOns/` de tu versión del juego:
   - Retail: `World of Warcraft/_retail_/Interface/AddOns/`
   - Mists of Pandaria Classic: `World of Warcraft/_classic_/Interface/AddOns/`
   - Classic Era: `World of Warcraft/_classic_era_/Interface/AddOns/`
   - Anniversary: `World of Warcraft/_anniversary_/Interface/AddOns/`
   - WoW Forever: `World of Warcraft/_classic_beta_/Interface/AddOns/`
3. Reinicia WoW y activa el addon.

## Uso
- `/wt config` — abre el panel de opciones (también desde el botón del minimapa).
- `/wt on` / `/wt off` — activa o desactiva las traducciones.
- `/wt test` — hace una prueba de traducción en el chat.
- `/wt search <palabra>` — busca una traducción directamente.
- `/wt en <texto>` — redacta un mensaje en inglés.
- `/wt` — muestra la lista de comandos.

El panel de opciones tiene General (activar, color, idioma de destino, jerga en otros idiomas, botones de prueba y de valores por defecto), Categorías, Expansiones, Canales de chat, Palabras ignoradas y Ayuda.

## Notas
- Además de los clientes actuales, incluye TOC para clientes antiguos (2.4.3, 3.3.5, 4.3, 5.4, WoD 6.2, Legion 7.3, BfA 8.3 y Shadowlands 9.2), como los que se usan en servidores privados.
- Los ajustes se guardan para toda la cuenta en `WoWTranslatorDB`.

---

**Autor**: Pirson · [GitHub](https://github.com/Pirson-s-Addons) · [CurseForge](https://www.curseforge.com/members/pirson/projects) · Licencia MIT
