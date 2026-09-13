local ADDON_NAME, addonTable = ...

-- ==========================================
-- CLIENTES ANTIGUOS (2.4.3 .. 9.x)
-- ==========================================
-- El addon esta escrito contra la API moderna. Aqui vive TODO lo que hace falta
-- para que el mismo codigo arranque en un cliente viejo de servidor privado:
-- 2.4.3 (TBC), 3.3.5a (WotLK), 4.3.4 (Cata), 5.4.8 (MoP), 6.2.4 (WoD),
-- 7.3.5 (Legion), 8.3.7 (BfA) y 9.2.5 (Shadowlands). Cada rama esta contrastada
-- con el codigo de interfaz de Blizzard de esa version (Gethe/wow-ui-source y,
-- para 2.4.3, MOUZU/Blizzard-WoW-Interface).
--
-- Fuera de este fichero, dos reglas para no romper 2.4.3:
--   * Nada de :SetSize(w, h), que no existe: SetWidth + SetHeight.
--   * SetFontObject con el objeto (GameFontNormal), no con su nombre.
-- Los scripts SI reciben (self, ...) en 2.4.3: el global `this` que usa su
-- FrameXML es cosa de los manejadores escritos en XML, no de SetScript.
--
-- Carga EL PRIMERO de todos: CallbackHandler-1.0 se guarda securecallfunction
-- en una local nada mas cargarse, y los demas ficheros del addon dependen del
-- namespace que se monta aqui abajo.
--
-- Regla al tocar esto: detectar la FUNCION, no la version del cliente. Solo se
-- mira la version donde no hay nada que detectar (una firma que cambio).

-- ------------------------------------------
-- NAMESPACE
-- ------------------------------------------
-- Si el cliente carga los ficheros sin argumentos, el namespace tiene que ser un
-- global y cada fichero lo recoge en la segunda linea de su cabecera.
if not addonTable then
    WoWTranslatorNS = WoWTranslatorNS or {}
    addonTable = WoWTranslatorNS
end
WoWTranslatorNS = addonTable
addonTable.NAME = ADDON_NAME or "WoWTranslator"

-- ------------------------------------------
-- GLOBALES QUE FALTAN
-- ------------------------------------------

-- 9.0. Sin el, CallbackHandler peta al disparar el primer callback y se lleva
-- por delante el boton de minimapa (LibDBIcon).
if not securecallfunction then
    securecallfunction = function(func, ...) return func(...) end
end

-- Lo usa Core/Dictionary.lua. Existe desde 3.x; en 2.4.3 no.
if not wipe then
    wipe = function(t)
        for key in pairs(t) do t[key] = nil end
        return t
    end
end

-- 2.4.3 no tiene print: su FrameXML escribe con DEFAULT_CHAT_FRAME:AddMessage.
if not print then
    print = function(...)
        local parts = {}
        for i = 1, select("#", ...) do parts[i] = tostring((select(i, ...))) end
        DEFAULT_CHAT_FRAME:AddMessage(table.concat(parts, " "))
    end
end

-- Version sacada de la cadena ("3.3.5" -> 3, 3) y no del cuarto retorno de
-- GetBuildInfo: ese numero de TOC no existe en los clientes mas viejos.
--
-- OJO: los Classic de CurseForge (1.15, 2.5, 3.4, 3.80, 4.4, 5.5) tienen version
-- mayor baja pero interfaz MODERNA. Una condicion por version tiene que apuntar
-- a la version exacta que cambio, nunca a un rango "menor que".
local MAJOR, MINOR = string.match((GetBuildInfo()), "^(%d+)%.(%d+)")
MAJOR, MINOR = tonumber(MAJOR) or 99, tonumber(MINOR) or 0

-- ------------------------------------------
-- WIDGETS
-- ------------------------------------------

-- Texture:SetColorTexture llega en 7.0. Antes, SetTexture con cuatro numeros
-- hacia lo mismo (y en los clientes modernos esa forma ya no existe).
function addonTable.SetSolidColor(texture, r, g, b, a)
    if texture.SetColorTexture then
        texture:SetColorTexture(r, g, b, a)
    else
        texture:SetTexture(r, g, b, a)
    end
end

-- Region:SetShown llega en 5.0.
function addonTable.SetShown(region, shown)
    if region.SetShown then
        region:SetShown(shown)
    elseif shown then
        region:Show()
    else
        region:Hide()
    end
end

-- ScrollFrame:SetScrollChild no aparece en ningun codigo Lua de 1.12.1 ni de
-- 2.4.3 (alli el hijo se declara en XML), asi que no se puede dar por hecho.
-- Sin el, el contenido se cuelga del marco sin desplazamiento: se ve, aunque no
-- haga scroll, en vez de romper la creacion del panel.
function addonTable.SetScrollChild(scrollFrame, child)
    if scrollFrame.SetScrollChild then
        scrollFrame:SetScrollChild(child)
    else
        child:SetParent(scrollFrame)
        child:SetPoint("TOPLEFT", scrollFrame, "TOPLEFT")
    end
end

-- ------------------------------------------
-- PANEL DE OPCIONES
-- ------------------------------------------
-- Settings llega en 10.0. Antes, InterfaceOptions_AddCategory existe en todas
-- las versiones soportadas, y una subcategoria es un panel que apunta al NOMBRE
-- de su padre, no a una referencia.
local hasSettings = (Settings and Settings.RegisterCanvasLayoutCategory) and true or false

function addonTable.RegisterCategory(panel, title)
    if hasSettings then
        local category = Settings.RegisterCanvasLayoutCategory(panel, title)
        Settings.RegisterAddOnCategory(category)
        addonTable.categoryID = category:GetID()
        return category
    end

    InterfaceOptions_AddCategory(panel)
    addonTable.categoryID = panel.name
    return panel
end

function addonTable.RegisterSubcategory(parentCategory, panel)
    if hasSettings then
        Settings.RegisterCanvasLayoutSubcategory(parentCategory, panel, panel.name)
        return
    end

    panel.parent = parentCategory.name
    InterfaceOptions_AddCategory(panel)
end

function addonTable.OpenConfig()
    if hasSettings then
        Settings.OpenToCategory(addonTable.categoryID)
        return
    end

    -- 2.4.3 solo trae OpenToFrame; desde 3.x, OpenToCategory. Las dos aceptan el
    -- nombre. Fallo conocido del cliente antiguo: la primera llamada solo abre el
    -- marco, la segunda es la que selecciona la categoria.
    local open = InterfaceOptionsFrame_OpenToCategory or InterfaceOptionsFrame_OpenToFrame
    open(addonTable.categoryID)
    open(addonTable.categoryID)
end

-- ------------------------------------------
-- SELECTOR DE COLOR
-- ------------------------------------------
-- SetupColorPickerAndShow llega en 10.2.5. Antes se rellenaban los campos del
-- marco a mano y se mostraba uno mismo (mismo contrato de 2.4.3 a 9.2.5).
function addonTable.ShowColorPicker(r, g, b, apply)
    if ColorPickerFrame.SetupColorPickerAndShow then
        ColorPickerFrame:SetupColorPickerAndShow({
            swatchFunc = function() apply(ColorPickerFrame:GetColorRGB()) end,
            hasOpacity = false,
            r = r, g = g, b = b,
        })
        return
    end

    -- Aqui func se llama en cada movimiento del raton, asi que cancelar tiene
    -- que devolver el color de partida o el jugador se queda con el que arrastro.
    ColorPickerFrame.func = function() apply(ColorPickerFrame:GetColorRGB()) end
    ColorPickerFrame.cancelFunc = function() apply(r, g, b) end
    ColorPickerFrame.opacityFunc = nil
    ColorPickerFrame.hasOpacity = false
    ColorPickerFrame.previousValues = { r = r, g = g, b = b }
    ColorPickerFrame:SetColorRGB(r, g, b)
    ColorPickerFrame:Hide() -- si ya estaba visible, Show() no dispararia OnShow
    ColorPickerFrame:Show()
end

-- ------------------------------------------
-- MENU DESPLEGABLE
-- ------------------------------------------
-- UIDropDownMenu_AddSeparator llega en 7.x con firma (info, level); desde 8.0,
-- y en todos los Classic de CurseForge, solo se pasa el nivel. Aqui no hay
-- funcion que detectar, asi que manda la version. Por debajo de 7.x no existe y
-- no pasa nada: el separador es decorativo.
function addonTable.AddDropDownSeparator(level)
    if not UIDropDownMenu_AddSeparator then return end
    if MAJOR == 7 then
        UIDropDownMenu_AddSeparator(UIDropDownMenu_CreateInfo(), level)
    else
        UIDropDownMenu_AddSeparator(level)
    end
end

-- En 2.4.3, UIDropDownMenu_SetWidth y UIDropDownMenu_SetText recibian el marco
-- el ULTIMO; 3.0 lo paso delante (y 2.5 Classic ya lo lleva delante).
-- SetSelectedValue siempre lo llevo delante, asi que NO pasa por aqui.
-- Uso: DropDown(UIDropDownMenu_SetText, marco, texto)
function addonTable.DropDown(func, frame, value)
    if MAJOR == 2 and MINOR < 5 then return func(value, frame) end
    return func(frame, value)
end

-- ------------------------------------------
-- BUSCADOR DE GRUPOS
-- ------------------------------------------
-- LFGListUtil_SetSearchEntryTooltip llega en 7.x: por debajo de ahi no hay
-- nada que traducir y Modules/GroupFinder.lua se queda quieto solo. En 7.3.5
-- GetSearchResultInfo devuelve los campos sueltos (id, activityID, name,
-- comment, ...); desde 8.3, una tabla.
function addonTable.GetSearchResultInfo(resultID)
    if not (C_LFGList and C_LFGList.GetSearchResultInfo) then return nil end

    local first, _, name, comment = C_LFGList.GetSearchResultInfo(resultID)
    if type(first) == "table" then return first end
    return { name = name, comment = comment }
end
