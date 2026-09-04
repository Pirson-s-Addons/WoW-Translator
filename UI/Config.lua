local ADDON_NAME, addonTable = ...

-- ==========================================
-- REGISTRO DEL PANEL DE OPCIONES
-- ==========================================
-- La raíz es la vista "Acerca de" y los ajustes cuelgan de ella como
-- subcategorías. El orden de registro es el orden del árbol.

function addonTable.CreateConfigUI()
    local title = "|TInterface\\AddOns\\WoWTranslator\\img\\logo_wt:16:16|t  " ..
        addonTable.COLOR.brand .. "WoW Translator|r"

    local panel = addonTable.CreateAboutUI(title)

    local category = Settings.RegisterCanvasLayoutCategory(panel, title)
    Settings.RegisterAddOnCategory(category)
    addonTable.categoryID = category:GetID()

    addonTable.CreateGeneralUI(category)
    addonTable.CreateCategoriesUI(category)
    addonTable.CreateExpansionsUI(category)
    addonTable.CreateChannelsUI(category)
    addonTable.CreateIgnoreListUI(category)
    addonTable.CreateHelpUI(category)
end
