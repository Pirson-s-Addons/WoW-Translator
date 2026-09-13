-- Comprobacion de Core/Compat.lua fuera del juego: lua Tests/compat.lua
--
-- Simula los clientes que marcan una frontera de API y verifica que cada
-- llamada acaba donde toca. Las firmas estan sacadas del codigo de interfaz de
-- Blizzard de cada version (Gethe/wow-ui-source), no de memoria.
--
-- Si alguien borra una rama del shim, o convierte una condicion de version
-- exacta en un rango, esto peta aqui en vez de en la cara de un jugador.

-- ------------------------------------------
-- ANDAMIAJE
-- ------------------------------------------

-- Marco de mentira: cualquier metodo no definido abajo no hace nada. missing
-- lista los metodos que ese cliente NO tiene: sin eso, el comodin los fingiria
-- y el shim tomaria siempre la rama moderna.
local function Frame(name, missing)
    local f = { name = name, shown = false }
    setmetatable(f, { __index = function(_, key)
        if missing and missing[key] then return nil end
        return function() end
    end })
    f.Show = function(self) self.shown = true end
    f.Hide = function(self) self.shown = false end
    return f
end

local function Environment(version, fields)
    local env = {
        pairs = pairs, ipairs = ipairs, type = type, select = select,
        string = string, tonumber = tonumber, setmetatable = setmetatable,
        table = table, tostring = tostring,
        UIParent = Frame("UIParent"),
        CreateFrame = function() return Frame() end,
        GetBuildInfo = function() return version, "0", "", 0 end,
        ColorPickerFrame = {
            SetColorRGB = function(self, r, g, b) self.r, self.g, self.b = r, g, b end,
            GetColorRGB = function(self) return self.r, self.g, self.b end,
            Hide = function() end,
            Show = function() end,
        },
    }
    for key, value in pairs(fields or {}) do env[key] = value end
    env._G = env
    return env
end

-- withArgs = false imita a un cliente que carga los ficheros sin argumentos.
local function Load(env, withArgs)
    local chunk = loadfile("Core/Compat.lua", "t", env)
    if not chunk then -- Lua 5.1
        chunk = assert(loadfile("Core/Compat.lua"))
        assert(setfenv)(chunk, env)
    end

    if withArgs == false then
        chunk()
        return assert(env.WoWTranslatorNS, "sin argumentos hace falta el namespace global")
    end

    local addonTable = {}
    chunk("WoWTranslator", addonTable)
    return addonTable
end

-- Registra con que argumentos se llamo a una funcion falsa.
local function Spy()
    local spy = {}
    spy.fn = function(...) spy.args = { ... } end
    return spy
end

-- Modernos: Settings + separador (level) + marco delante en el desplegable.
local function ModernFields(log)
    return {
        Settings = {
            RegisterCanvasLayoutCategory = function() return { GetID = function() return 42 end } end,
            RegisterAddOnCategory = function() log[#log + 1] = "addon" end,
            RegisterCanvasLayoutSubcategory = function() log[#log + 1] = "sub" end,
            OpenToCategory = function(id) log[#log + 1] = "open:" .. id end,
        },
    }
end

-- Comprueba separador y orden del desplegable de un cliente.
local function CheckDropDown(version, addonTable, env, separatorWithInfo, frameLast)
    local sep = Spy()
    env.UIDropDownMenu_AddSeparator = sep.fn
    env.UIDropDownMenu_CreateInfo = function() return {} end
    addonTable.AddDropDownSeparator(1)
    if separatorWithInfo then
        assert(type(sep.args[1]) == "table" and sep.args[2] == 1, version .. ": separador (info, level)")
    else
        assert(sep.args[1] == 1 and sep.args[2] == nil, version .. ": separador (level)")
    end

    local set = Spy()
    addonTable.DropDown(set.fn, "marco", 200)
    if frameLast then
        assert(set.args[1] == 200 and set.args[2] == "marco", version .. ": marco el ultimo")
    else
        assert(set.args[1] == "marco" and set.args[2] == 200, version .. ": marco delante")
    end
end

-- ------------------------------------------
-- RETAIL Y CLASSIC DE CURSEFORGE (interfaz moderna)
-- ------------------------------------------
-- Versiones sacadas de las etiquetas del repo: todas usan Settings, separador
-- (level) y marco delante, aunque su version mayor sea baja.
for _, version in ipairs({ "12.1.5", "1.15.9", "2.5.6", "3.4.3", "3.80.2", "4.4.2", "5.5.4" }) do
    local log = {}
    local env = Environment(version, ModernFields(log))
    local addonTable = Load(env)

    addonTable.RegisterCategory(Frame("raiz"), "raiz")
    assert(addonTable.categoryID == 42, version .. ": categoria de Settings")
    addonTable.RegisterSubcategory({}, Frame("General"))
    addonTable.OpenConfig()
    assert(log[1] == "addon" and log[2] == "sub" and log[3] == "open:42", version .. ": Settings")

    CheckDropDown(version, addonTable, env, false, false)
end

-- Selector de color moderno: 10.2.5+ y la mayoria de Classic.
do
    local picked
    local env = Environment("12.1.5", {
        ColorPickerFrame = {
            SetupColorPickerAndShow = function(_, opts) opts.swatchFunc() end,
            GetColorRGB = function() return 0, 1, 0 end,
        },
    })
    Load(env).ShowColorPicker(0, 0, 0, function(r, g, b) picked = g end)
    assert(picked == 1, "el swatchFunc lee el color del propio marco")

    local tex = { SetColorTexture = function(self, ...) self.args = { ... } end }
    Load(env).SetSolidColor(tex, 1, 1, 1, 0.15)
    assert(tex.args[4] == 0.15, "SetColorTexture en clientes modernos")
end

-- ------------------------------------------
-- 9.2.5 y 8.3.7 (InterfaceOptions, separador (level), LFG en tabla)
-- ------------------------------------------
for _, version in ipairs({ "9.2.5", "8.3.7" }) do
    local opened = {}
    local env = Environment(version, {
        InterfaceOptions_AddCategory = function() end,
        InterfaceOptionsFrame_OpenToCategory = function(name) opened[#opened + 1] = name end,
        C_LFGList = { GetSearchResultInfo = function() return { name = "n", comment = "c" } end },
    })
    local addonTable = Load(env)
    addonTable.RegisterCategory(Frame("WoW Translator"), "WoW Translator")
    addonTable.OpenConfig()
    assert(opened[1] == "WoW Translator" and opened[2] == "WoW Translator", version .. ": doble llamada")
    assert(addonTable.GetSearchResultInfo(1).comment == "c")
    CheckDropDown(version, addonTable, env, false, false)
end

-- ------------------------------------------
-- 7.3.5 LEGION (separador (info, level), LFG en campos sueltos)
-- ------------------------------------------
do
    local env = Environment("7.3.5", {
        InterfaceOptions_AddCategory = function() end,
        InterfaceOptionsFrame_OpenToCategory = function() end,
        -- id, activityID, name, comment, ... (LFGList.lua de 7.3.5)
        C_LFGList = { GetSearchResultInfo = function() return 1, 2, "LFM ICC", "need tank" end },
    })
    local legion = Load(env)

    assert(env.securecallfunction, "falta el shim de securecallfunction")
    assert(env.securecallfunction(function(a, b) return a + b end, 2, 3) == 5)

    local root, sub = Frame("WoW Translator"), Frame("General")
    assert(legion.RegisterCategory(root, "WoW Translator") == root)
    legion.RegisterSubcategory(root, sub)
    assert(sub.parent == "WoW Translator", "la subcategoria apunta al padre por nombre")

    local color
    legion.ShowColorPicker(1, 0.5, 0, function(r, g, b) color = { r, g, b } end)
    env.ColorPickerFrame.func()
    assert(color[1] == 1 and color[2] == 0.5 and color[3] == 0)
    env.ColorPickerFrame.cancelFunc()
    assert(color[1] == 1, "cancelar devuelve el color de partida")

    local info = legion.GetSearchResultInfo(7)
    assert(info.name == "LFM ICC" and info.comment == "need tank")

    CheckDropDown("7.3.5", legion, env, true, false)
end

-- ------------------------------------------
-- 3.3.5a WOTLK (sin SetColorTexture, sin SetShown, sin separador, sin LFG)
-- ------------------------------------------
do
    local env = Environment("3.3.5", {
        InterfaceOptions_AddCategory = function() end,
        InterfaceOptionsFrame_OpenToCategory = function() end,
    })
    local wotlk = Load(env)

    wotlk.AddDropDownSeparator(1) -- no existe la funcion: no debe petar

    local tex = { SetTexture = function(self, ...) self.args = { ... } end }
    wotlk.SetSolidColor(tex, 1, 1, 1, 0.15)
    assert(tex.args[4] == 0.15, "sin SetColorTexture, el color va por SetTexture(r, g, b, a)")

    local label = Frame("vacio", { SetShown = true })
    wotlk.SetShown(label, true)
    assert(label.shown)
    wotlk.SetShown(label, false)
    assert(not label.shown)

    assert(wotlk.GetSearchResultInfo(1) == nil, "sin C_LFGList no hay nada que traducir")

    local set = Spy()
    wotlk.DropDown(set.fn, "marco", 200)
    assert(set.args[1] == "marco", "3.3.5: marco delante")
end

-- ------------------------------------------
-- 2.4.3 TBC (sin varargs, sin print, OpenToFrame, marco al final)
-- ------------------------------------------
do
    local opened, chat = {}, {}
    local env = Environment("2.4.3", {
        InterfaceOptions_AddCategory = function() end,
        InterfaceOptionsFrame_OpenToFrame = function(name) opened[#opened + 1] = name end,
        DEFAULT_CHAT_FRAME = { AddMessage = function(_, msg) chat[#chat + 1] = msg end },
    })
    local tbc = Load(env, false)

    assert(env.WoWTranslatorNS == tbc, "el namespace global es el que recogen los demas ficheros")
    assert(tbc.NAME == "WoWTranslator", "sin argumentos, el nombre del addon se pone a mano")

    assert(env.wipe, "2.4.3 no trae wipe")
    local t = { a = 1 }
    env.wipe(t)
    assert(next(t) == nil)

    tbc.RegisterCategory(Frame("WoW Translator"), "WoW Translator")
    tbc.OpenConfig()
    assert(opened[1] == "WoW Translator", "2.4.3 abre con OpenToFrame")

    local set = Spy()
    tbc.DropDown(set.fn, "marco", 200)
    assert(set.args[1] == 200 and set.args[2] == "marco", "2.4.3: marco el ultimo")

    local scroll, child, parent = Frame("scroll", { SetScrollChild = true }), Frame("hijo"), nil
    child.SetParent = function(_, p) parent = p end
    tbc.SetScrollChild(scroll, child)
    assert(parent == scroll, "sin SetScrollChild el contenido se cuelga del marco")

    local modernScroll, assigned = Frame("scroll"), nil
    modernScroll.SetScrollChild = function(_, c) assigned = c end
    tbc.SetScrollChild(modernScroll, child)
    assert(assigned == child, "con SetScrollChild se usa el metodo")

    assert(env.print, "2.4.3 no trae print")
    env.print("hola", 42)
    assert(chat[1] == "hola 42", "print escribe en DEFAULT_CHAT_FRAME")
end

print("Core/Compat.lua OK: retail, Classic x6, 9.2.5, 8.3.7, 7.3.5, 3.3.5a y 2.4.3")
