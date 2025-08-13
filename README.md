===========================================
Valentine One Radar Detector for QBCore + wk_wars2x
===========================================

Description:
------------
This resource adds a fully functional Valentine One radar and laser detector to your FiveM QBCore server.
It integrates with the Sonoran wk_wars2x police radar system to show realistic alerts including band types,
directional arrows, and signal strength with a clean NUI display.

Folder Structure:
-----------------
v1_radar_qb/
  fxmanifest.lua
  config.lua
  shared/
    utils.lua
  client/
    detector.lua      -- radar detection + NUI updates
    inventory.lua     -- QBCore usable item logic
    prop.lua          -- optional Valentine One prop attachment
  server/
    main.lua          -- QBCore item checks and commands
  html/
    index.html        -- NUI display
    style.css
    script.js

Installation:
-------------
1. Ensure you have wk_wars2x resource installed and running for police radar signals.
2. Place the v1_radar_qb folder into your server resources directory.
3. Add to your server.cfg:
     ensure v1_radar_qb
4. Add this item definition to qb-core/shared/items.lua:

   ['valentine_one'] = {
     name = 'valentine_one',
     label = 'Valentine One',
     weight = 1500,
     type = 'item',
     image = 'valentine_one.png', -- place image in qb-inventory/html/images/
     unique = true,
     useable = true,
     shouldClose = true,
     description = 'Radar/Laser detector for your vehicle.'
   },

5. (Optional) For instant updates, add this inside wk_wars2x client detection logic:

   TriggerEvent('wk:radarDetection', { band = "Ka", direction = "front", strength = 0.85 })

Usage:
------
- Obtain the Valentine One item in your inventory.
- Use the item to toggle the radar detector on or off.
- When active and in a vehicle, it will detect nearby police radar signals and display alerts on the NUI.
- Optional prop attaches to your vehicle dashboard when enabled.

Configuration:
--------------
All config options are in config.lua, including detection radius, UI settings, prop model and offsets.

Support:
--------
Works with QBCore framework and wk_wars2x police radar resource.

License:
--------
Free to use and modify for non-commercial FiveM servers.

Credits:
--------
- wk_wars2x by Sonoran Software
- Valentine One UI inspired by the real radar detector device

===========================================
