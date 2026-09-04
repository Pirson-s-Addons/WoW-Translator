local ADDON_NAME, addonTable = ...
local L = addonTable.L

-- ==========================================
-- BOTÓN DEL MINIMAPA
-- ==========================================
-- LibDataBroker + LibDBIcon son OptionalDeps: si no están, simplemente no hay
-- botón y el addon sigue funcionando con /wt.

function addonTable.CreateMinimapButton()
    local LDB = LibStub("LibDataBroker-1.1", true)
    local LDBIcon = LibStub("LibDBIcon-1.0", true)
    if not LDB or not LDBIcon then return end

    local dataObject = LDB:NewDataObject("WoWTranslator", {
        type = "launcher",
        icon = "Interface\\Addons\\WoWTranslator\\img\\logo_wt",

        OnClick = function()
            Settings.OpenToCategory(addonTable.categoryID)
        end,

        OnTooltipShow = function(tooltip)
            tooltip:AddLine(L["QT_MINIMAP_TT"] or "Click: Open Settings")
        end,
    })

    WoWTranslatorDB.minimap = WoWTranslatorDB.minimap or {}

    if not LDBIcon:IsRegistered("WoWTranslator") then
        LDBIcon:Register("WoWTranslator", dataObject, WoWTranslatorDB.minimap)
    end
end
