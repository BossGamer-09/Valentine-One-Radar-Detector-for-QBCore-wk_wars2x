local QBCore = exports['qb-core']:GetCoreObject()
local HasDetector = false

local function refreshInv()
    local PlayerData = QBCore.Functions.GetPlayerData()
    HasDetector = false
    for _, item in pairs(PlayerData.items or {}) do
        if item.name == Config.ItemName then
            HasDetector = true
            break
        end
    end
end

AddEventHandler('QBCore:Client:OnPlayerLoaded', refreshInv)
RegisterNetEvent('QBCore:Client:OnPlayerUnload', function() HasDetector = false end)
RegisterNetEvent('QBCore:Player:SetPlayerData', refreshInv)

CreateThread(function()
    while true do
        refreshInv()
        Wait(5000)
    end
end)

exports('HasDetector', function() return HasDetector end)
