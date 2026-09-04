local ADDON_NAME, addonTable = ...

-- ==========================================
-- CONSTANTES Y AYUDAS COMUNES
-- ==========================================
-- Lo mínimo que comparten varios ficheros. Si esto crece más allá de colores y
-- un print, es que le corresponde a un módulo propio, no a un cajón de sastre.

addonTable.PREFIX = "|cffffff00[|r|cffd597ffWoW Translator|r|cffffff00]|r "

addonTable.COLOR = {
    brand = "|cffd597ff", -- el morado del addon
    gold  = "|cffffff00",
    white = "|cffffffff",
    red   = "|cffff0000",
}

function addonTable.Print(...)
    print(addonTable.PREFIX .. table.concat({ ... }))
end
