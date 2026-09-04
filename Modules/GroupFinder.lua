local ADDON_NAME, addonTable = ...
local L = addonTable.L

-- ==========================================
-- BUSCADOR DE GRUPOS (LFG)
-- ==========================================
-- El título y el comentario de un grupo son texto libre escrito por el jugador
-- y concentran más jerga que el propio chat ("LFM ICC HC 25m need tank AOTC").
-- La traducción va al tooltip y no a la fila del listado: ahí hay sitio, y el
-- título de la fila ya viene truncado de serie.

local hooked = false

local function Install()
    -- Si la función no existe (sabor de cliente sin grupos premade, o Blizzard
    -- la renombró) esto no hace nada en vez de petar.
    if hooked or type(_G.LFGListUtil_SetSearchEntryTooltip) ~= "function" then return end
    hooked = true

    hooksecurefunc("LFGListUtil_SetSearchEntryTooltip", function(tooltip, resultID)
        if not tooltip or not WoWTranslatorDB or not WoWTranslatorDB.enabled then return end
        if WoWTranslatorDB.settings.showLFG == false then return end

        local info = C_LFGList and C_LFGList.GetSearchResultInfo and C_LFGList.GetSearchResultInfo(resultID)
        if not info then return end

        local added = false
        for _, raw in ipairs({ info.name, info.comment }) do
            if raw and raw ~= "" then
                local translated, changed = _G.TranslateChat(raw)
                if changed then
                    if not added then
                        tooltip:AddLine(" ")
                        tooltip:AddLine(addonTable.COLOR.brand .. (L["LFG_TT_HEADER"] or "Translation:") .. "|r")
                        added = true
                    end
                    tooltip:AddLine(translated, 1, 1, 1, true)
                end
            end
        end
        -- Sin esto el tooltip conserva el alto que tenía antes de añadir líneas.
        if added then tooltip:Show() end
    end)
end

function addonTable.InstallGroupFinderHook()
    -- El buscador de grupos es un addon de Blizzard de carga bajo demanda. Si
    -- todavía no está, se reintenta en cada ADDON_LOADED: así no hace falta
    -- acertar con su nombre, que ha cambiado entre versiones del cliente.
    Install()
    if hooked then return end

    local watcher = CreateFrame("Frame")
    watcher:RegisterEvent("ADDON_LOADED")
    watcher:SetScript("OnEvent", function(self)
        Install()
        if hooked then self:UnregisterEvent("ADDON_LOADED") end
    end)
end
