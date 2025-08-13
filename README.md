=======================================================
        Valentine One Radar Detector for QBCore
          Integrated with wk_wars2x Police Radar
=======================================================

DESCRIPTION
-----------
This resource brings the iconic Valentine One radar and laser detector
to your FiveM QBCore server. It offers a realistic in-game experience
with a custom NUI display showing radar bands, directional arrows,
and signal strength based on real police radar signals from the
wk_wars2x resource.

FEATURES
--------
• Full integration with wk_wars2x police radar and laser detection
• Realistic Valentine One UI with LEDs and arrows
• QBCore item integration – must own/use the Valentine One to activate
• Optional prop that attaches the device to your vehicle’s dashboard
• Configurable UI colors, sounds, and detection settings

FOLDER STRUCTURE
----------------
v1_radar_qb/
│
├── fxmanifest.lua          # Resource manifest
├── config.lua              # Configurable settings
├── shared/
│    └── utils.lua          # Shared helper functions
├── client/
│    ├── detector.lua       # Client radar detection & NUI logic
│    ├── inventory.lua      # Item usage handling
│    └── prop.lua           # Optional Valentine One prop attachment
├── server/
│    └── main.lua           # Server item validation & commands
└── html/
     ├── index.html         # NUI display markup
     ├── style.css          # NUI styling
     └── script.js          # NUI logic & sound handling

INSTALLATION
------------
1. Ensure wk_wars2x is installed and running for police radar detection.
2. Place the 'v1_radar_qb' folder into your server’s resources directory.
3. Add the following line to your server.cfg:
   ensure v1_radar_qb
4. Add this item definition in qb-core/shared/items.lua:

   ['valentine_one'] = {
       name = 'valentine_one',
       label = 'Valentine One',
       weight = 1500,
       type = 'item',
       image = 'valentine_one.png',  -- place in qb-inventory/html/images/
       unique = true,
       useable = true,
       shouldClose = true,
       description = 'Radar/Laser detector for your vehicle.'
   },

5. (Optional) For instant detection updates, insert this in wk_wars2x client radar detection:

   TriggerEvent('wk:radarDetection', { band = "Ka", direction = "front", strength = 0.85 })

USAGE
-----
• Obtain the Valentine One item in your inventory.
• Use the item to toggle the radar detector on/off.
• When active inside a vehicle, it will detect police radar/laser signals
  and display alerts on the Valentine One UI.
• The device prop will attach to your vehicle dashboard if enabled in config.

CONFIGURATION
-------------
• Modify config.lua to customize detection range, UI colors, sounds,
  prop attachment options, and keybinds.

SUPPORT & REQUIREMENTS
----------------------
• Requires QBCore framework.
• Compatible with Sonoran wk_wars2x police radar resource.
• Tested on FiveM servers.

LICENSE
-------
This resource is free to use and modify for non-commercial purposes.
Please credit original authors if redistributed.

CREDITS
-------
• wk_wars2x by Sonoran Software
• Valentine One UI inspired by the real radar detector device

=======================================================
