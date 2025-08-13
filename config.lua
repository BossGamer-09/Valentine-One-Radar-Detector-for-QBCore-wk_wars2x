Config = {}

-- Item name in QBCore (must match qb-core/shared/items.lua)
Config.ItemName = 'valentine_one'

-- Scan + detection parameters
Config.ScanIntervalMs = 500
Config.DetectRadius   = 250.0
Config.MinSpeedToShow = 0.0  -- speed threshold to show UI (0 = always)

-- Preferred backend: read Sonoran wk_wars2x statebags/decorators
Config.StatebagKeys = {
  front = { 'wk:radar:front_tx', 'wk_wars2x:front_tx', 'wraithv2:front_tx' },
  rear  = { 'wk:radar:rear_tx',  'wk_wars2x:rear_tx',  'wraithv2:rear_tx'  },
  laser = { 'wk:radar:laser_tx', 'wk_wars2x:laser_tx', 'wraithv2:laser_tx' }
}
Config.DecorKeys = {
  front = { 'wk_radar_front_tx' },
  rear  = { 'wk_radar_rear_tx'  }
}

-- Heuristic fallback when no state is exposed
Config.UseHeuristicFallback = true
Config.Heuristic = {
  VehicleClasses = { 18 },   -- emergency
  RequirePlayerDriver = true,
  MaxAngleDegrees = 70,
  AngleWeight = 0.25
}

-- UI & Audio
Config.UI = {
  StartHidden = true,
  UseSounds   = true,      -- HTML5 sounds (see html/script.js, uses game beeps if false)
  AlertThreshold = 0.75,   -- when to “flash” alert
}

-- Optional dash prop (set Enable = false to disable the physical device)
Config.Prop = {
  Enable = true,
  Model  = `prop_cs_remote_01`,  -- lightweight placeholder; replace with your custom model if you have one
  Bone   = 'windscreen',         -- attach near dash; tweak offset/rot for your vehicles
  Offset = vec3(0.25, 0.35, 0.18),
  Rot    = vec3(0.0, 0.0, 6.0)
}

-- Vehicles that cannot trigger detection or show UI (e.g., helicopters, heavy trucks)
Config.VehicleBlacklistModels = { `POLMAV`, `RIOT`, `RIOT2`, `AMBULAN`, `FIRETRUK` }
