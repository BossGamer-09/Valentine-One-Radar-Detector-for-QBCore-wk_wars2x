Utils = {}

function Utils.IsBlacklisted(vehicle)
  if vehicle == 0 then return true end
  local model = GetEntityModel(vehicle)
  for _, hash in ipairs(Config.VehicleBlacklistModels) do
    if model == hash then return true end
  end
  return false
end

function Utils.IsEmergency(vehicle)
  return GetVehicleClass(vehicle) == 18
end

function Utils.ForwardnessDot(entityFrom, entityTo)
  local posFrom = GetEntityCoords(entityFrom)
  local posTo   = GetEntityCoords(entityTo)
  local dir     = posTo - posFrom
  local len     = #(dir)
  if len < 0.001 then return 1.0 end
  dir = dir / len
  local fw = GetEntityForwardVector(entityFrom)
  return fw.x*dir.x + fw.y*dir.y + fw.z*dir.z
end

function Utils.Clamp(x, lo, hi) return math.max(lo, math.min(hi, x)) end
function Utils.Lerp(a,b,t) return a + (b-a)*t end
