local QBCore = exports['qb-core']:GetCoreObject()

-- Usable item toggles the detector on/off client-side
QBCore.Functions.CreateUseableItem(Config.ItemName, function(src, item)
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    -- Optional: validate the item actually exists in inventory count > 0
    TriggerClientEvent('v1:toggle', src)
end)

-- (Optional) Admin/LEO command to “confiscate” detector (example)
QBCore.Commands.Add('confiscatev1', 'Confiscate a player\'s Valentine One', {{name='id', help='Server ID'}}, false, function(source, args)
    local target = tonumber(args[1] or -1)
    if not target or target < 1 then
        TriggerClientEvent('QBCore:Notify', source, 'Invalid ID', 'error')
        return
    end
    local Player = QBCore.Functions.GetPlayer(target)
    if not Player then
        TriggerClientEvent('QBCore:Notify', source, 'Player not found', 'error')
        return
    end
    local removed = Player.Functions.RemoveItem(Config.ItemName, 1)
    if removed then
        TriggerClientEvent('QBCore:Notify', source, 'Confiscated V1', 'success')
        TriggerClientEvent('QBCore:Notify', target, 'Your Valentine One was confiscated', 'error')
        TriggerClientEvent('v1:toggle', target) -- force off if it was on
    else
        TriggerClientEvent('QBCore:Notify', source, 'Player does not have a V1', 'error')
    end
end, 'admin')
