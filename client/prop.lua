local PropHandle = 0
local Visible = false

local function ensureModel(model)
  if not IsModelValid(model) then return false end
  if not HasModelLoaded(model) then
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(0) end
  end
  return true
end

local function attachToVehicle(veh)
  if PropHandle ~= 0 then DeleteEntity(PropHandle) PropHandle = 0 end
  if veh == 0 then return end
  if not ensureModel(Config.Prop.Model) then return end

  local boneIdx = GetEntityBoneIndexByName(veh, Config.Prop.Bone)
  if boneIdx == -1 then boneIdx = 0 end

  PropHandle = CreateObject(Config.Prop.Model, 0.0, 0.0, 0.0, false, false, false)
  SetEntityCollision(PropHandle, false, false)
  SetEntityCompletelyDisableCollision(PropHandle, true, false)
  SetEntityAsMissionEntity(PropHandle, true, true)
  AttachEntityToEntity(
    PropHandle, veh, boneIdx,
    Config.Prop.Offset.x, Config.Prop.Offset.y, Config.Prop.Offset.z,
    Config.Prop.Rot.x, Config.Prop.Rot.y, Config.Prop.Rot.z,
    false, false, false, false, 2, true
  )
  Visible = true
end

local function detachAndDelete()
  if PropHandle ~= 0 then
    DeleteEntity(PropHandle)
    PropHandle = 0
  end
  Visible = false
end

-- API for detector.lua
RegisterNetEvent('v1:prop:show', function(veh)
  if not Config.Prop.Enable then return end
  attachToVehicle(veh)
end)

RegisterNetEvent('v1:prop:hide', function()
  if not Config.Prop.Enable then return end
  detachAndDelete()
end)

-- Clean up on stop
AddEventHandler('onResourceStop', function(res)
  if res == GetCurrentResourceName() then
    detachAndDelete()
  end
end)
