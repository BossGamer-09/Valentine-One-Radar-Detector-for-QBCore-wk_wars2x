Config = {}

Config.Framework = 'qbcore'  -- or 'standalone'

Config.ItemName = 'valentine_one'

Config.ScanIntervalMs = 500
Config.DetectRadius = 250.0
Config.MinSpeedToShow = 0.0

Config.StatebagKeys = {
  front = { 'wk:radar:front_tx', 'wk_wars2x:front_tx', 'wraithv2:front_tx' },
  rear = { 'wk:radar:rear_tx', 'wk_wars2x:rear_tx', 'wraithv2:rear_tx' },
  laser = { 'wk:radar:laser_tx', 'wk_wars2x:laser_tx', 'wraithv2:laser_tx' }
}

Config.DecorKeys = {
  front = { 'wk_radar_front_tx' },
  rear = { 'wk_radar_rear_tx' }
}

Config.UseHeuristicFallback = true
Config.Heuristic = {
  VehicleClasses = { 18 },
  RequirePlayerDriver = true,
  MaxAngleDegrees = 70,
  AngleWeight = 0.25
}

Config.UI = {
  StartHidden = true,
  UseSounds = true,
  AlertThreshold = 0.75
}

Config.Prop = {
  Enable = true,
  Model = `prop_cs_remote_01`,
  Bone = 'windscreen',
  Offset = vec3(0.25, 0.35, 0.18),
  Rot = vec3(0.0, 0.0, 6.0)
}

Config.VehicleBlacklistModels = { `POLMAV`, `RIOT`, `RIOT2`, `AMBULAN`, `FIRETRUK` }

Config.StandaloneToggleKey = 'F7'

Config.RadarDetectionInterval = 5000

Config.UIColors = {
  ledOn = "#FF3B3B",
  ledOff = "#330000",
  arrowOn = "#FF7F50",
  arrowOff = "#330000"
}

Config.Jammer = {
  ItemName = 'radar_jammer',
  DurationMs = 15000,
  CooldownMs = 30000,
  StrengthReduction = 1.0
}
