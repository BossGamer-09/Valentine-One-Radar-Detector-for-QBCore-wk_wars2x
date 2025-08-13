local QBCore = exports['qb-core']:GetCoreObject()
local HasDetector = exports['v1_radar_qb']:HasDetector()
local Enabled = false
local DetectorVisible = false

-- Helpers to show/hide NUI & prop
local function showUI(show)
    if show and not DetectorVisible then
        SendNUIMessage({ type = 'show' })
        DetectorVisible = true
    elseif not show and DetectorVisible then
        SendNUIMessage({ type = 'hide' })
        DetectorVisible = false
    end
end

local function showProp(veh)
    TriggerEvent('v1:prop:show', veh)
end
local function hideProp()
    TriggerEvent('v1:prop:hide')
end

-- Toggle via item use (server triggers this event)
RegisterNetEvent('v1:toggle', function()
    HasDetector = exports['v1_radar_qb']:HasDetector()
    if not HasDetector then
        QBCore.Functions.Notify("You don't have a Valentine One.", 'error')
        return
    end
    Enabled = not Enabled
    if Enabled then
        QBCore.Functions.Notify("Valentine One Activated", 'success')
    else
        QBCore.Functions.Notify("Valentine One Deactivated", 'error')
        showUI(false)
        hideProp()
    end
end)

-- Read Sonoran wk_wars2x statebags/decors on a source vehicle
local function readAntennaDirection(leoVeh)
    local ent = Entity(leoVeh)
    if ent and ent.state then
        for _, k in ipairs(Config.StatebagKeys.front) do if ent.state[k] then return 'front' end end
        for _, k in ipairs(Config.StatebagKeys.rear)  do if ent.state[k] then return 'rear'  end end
    end
    -- decor fallback
    for _, k in ipairs(Config.DecorKeys.front) do
        if DecorExistOn(leoVeh, k) then
            local t = DecorGetType(k)
            if (t == 1 and DecorGetBool(leoVeh, k)) or (t == 2 and DecorGetInt(leoVeh, k) ~= 0) then
                return 'front'
            end
        end
    end
    for _, k in ipairs(Config.DecorKeys.rear) do
        if DecorExistOn(leoVeh, k) then
            local t = DecorGetType(k)
            if (t == 1 and DecorGetBool(leoVeh, k)) or (t == 2 and DecorGetInt(leoVeh, k) ~= 0) then
                return 'rear'
            end
        end
    end
    return 'side'
end

-- Heuristic fallback if no state exposed
local function heuristicActive(leoVeh, myVeh)
    if not Config.UseHeuristicFallback then return false, 'side' end
    if GetVehicleClass(leoVeh) ~= 18 then return false, 'side' end
    if Config.Heuristic.RequirePlayerDriver then
        local ped = GetPedInVehicleSeat(leoVeh, -1)
        if ped == 0 or not IsPedAPlayer(ped) then return false, 'side' end
    end
    local dot = Utils.ForwardnessDot(leoVeh, myVeh)
    local angle = math.deg(math.acos(Utils.Clamp(math.abs(dot), -1.0, 1.0)))
    if angle > Config.Heuristic.MaxAngleDegrees then return false, 'side' end
    return true, (dot >= 0 and 'front' or 'rear')
end

-- Band guess by distance (fun/immersion)
local function bandForDistance(m)
  if m <= 55.0 then return "Ka"
  elseif m <= 120.0 then return "K"
  elseif m <= 200.0 then return "X"
  else return "Ka" end
end

-- Main scan loop (also supports external events from wk_wars2x; see below)
CreateThread(function()
    while true do
        Wait(Config.ScanIntervalMs)
        if not Enabled then goto continue end
        HasDetector = exports['v1_radar_qb']:HasDetector()
        if not HasDetector then
            if DetectorVisible then showUI(false) hideProp() end
            goto continue
        end

        local ped = PlayerPedId()
        if not IsPedInAnyVehicle(ped, false) then
            if DetectorVisible then showUI(false) hideProp() end
            goto continue
        end

        local myVeh = GetVehiclePedIsIn(ped, false)
        if Utils.IsBlacklisted(myVeh) then
            if DetectorVisible then showUI(false) hideProp() end
            goto continue
        end

        -- find nearest LEO radar source
        local myPos = GetEntityCoords(myVeh)
        local closestVeh, closestDist, matched = 0, Config.DetectRadius, false
        local handle, veh = FindFirstVehicle()
        local success = true
        repeat
            if veh ~= 0 and veh ~= myVeh then
                local dist = #(GetEntityCoords(veh) - myPos)
                if dist <= closestDist then
                    -- try statebag/decor flags
                    local dir = readAntennaDirection(veh)
                    local active = (dir ~= 'side') -- if we saw front/rear state, consider active
                    if not active then
                        active, dir = heuristicActive(veh, myVeh)
                    end
                    if active then
                        closestVeh, closestDist, matched = veh, dist, true
                    end
                end
            end
            success, veh = FindNextVehicle(handle)
        until not success
        EndFindVehicle(handle)

        if matched then
            local intensity = Utils.Clamp(1.0 - (closestDist / Config.DetectRadius), 0.0, 1.0)
            -- angle weighting for realism
            local dot = Utils.ForwardnessDot(closestVeh, myVeh)
            intensity = intensity * (1.0 - Config.Heuristic.AngleWeight + Config.Heuristic.AngleWeight * math.abs(dot))

            local band = bandForDistance(closestDist)

            showUI(true)
            showProp(myVeh)
            SendNUIMessage({
                type = 'update',
                band = band,
                direction = (dot >= 0 and 'front' or 'rear'),
                strength = intensity
            })
        else
            showUI(false)
            hideProp()
        end

        ::continue::
    end
end)

-- OPTIONAL: Direct hook from wk_wars2x (if you add this Trigger in that resource)
-- TriggerEvent('wk:radarDetection', { band="Ka", direction="front"/"rear"/"side", strength=0..1 })
RegisterNetEvent('wk:radarDetection', function(data)
    if not Enabled then return end
    if not exports['v1_radar_qb']:HasDetector() then return end
    local ped = PlayerPedId()
    if not IsPedInAnyVehicle(ped, false) then return end
    local myVeh = GetVehiclePedIsIn(ped, false)
    showUI(true)
    showProp(myVeh)
    SendNUIMessage({
        type      = 'update',
        band      = data.band or 'Ka',
        direction = data.direction or 'front',
        strength  = Utils.Clamp(tonumber(data.strength) or 0.6, 0.0, 1.0)
    })
end)

-- Clean up on resource stop
AddEventHandler('onResourceStop', function(res)
    if res == GetCurrentResourceName() then
        SendNUIMessage({ type = 'hide' })
        hideProp()
    end
end)
