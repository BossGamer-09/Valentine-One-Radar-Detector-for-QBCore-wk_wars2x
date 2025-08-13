# Valentine One Radar Detector for QBCore  
*Integrated with [wk_wars2x](https://github.com/sonoran-Software/wk_wars2x) Police Radar*

---

## Description

This resource adds the iconic Valentine One radar and laser detector to your FiveM QBCore server.  
It features a realistic in-game UI with radar bands, directional arrows, and signal strength indicators — all powered by real police radar signals from [wk_wars2x](https://github.com/sonoran-Software/wk_wars2x).

---

## Features

- Full integration with **wk_wars2x** police radar and laser detection  
- Realistic Valentine One UI with LED bands and directional arrows  
- QBCore item integration — players must own/use the Valentine One to activate it  
- Optional prop that attaches the device to the vehicle dashboard  
- Configurable UI colors, sounds, detection range, and keybinds  

---

## Folder Structure

v1_radar_qb/
├── fxmanifest.lua # Resource manifest
├── config.lua # Configurable settings
├── shared/
│ └── utils.lua # Shared helper functions
├── client/
│ ├── detector.lua # Client radar detection & NUI logic
│ ├── inventory.lua # Item usage handling
│ └── prop.lua # Optional Valentine One prop attachment
├── server/
│ └── main.lua # Server item validation & commands
└── html/
├── index.html # NUI display markup
├── style.css # NUI styling
└── script.js # NUI logic & sound handling

yaml
Copy
Edit

---

## Installation

1. Make sure [wk_wars2x](https://github.com/sonoran-Software/wk_wars2x) is installed and running on your server.  
2. Place the `v1_radar_qb` folder inside your server’s `resources/` directory.  
3. Add the following line to your `server.cfg`:
   ```cfg
   ensure v1_radar_qb
Add the Valentine One item to your qb-core/shared/items.lua file:

lua
Copy
Edit
['valentine_one'] = {
    name = 'valentine_one',
    label = 'Valentine One',
    weight = 1500,
    type = 'item',
    image = 'valentine_one.png', -- place in qb-inventory/html/images/
    unique = true,
    useable = true,
    shouldClose = true,
    description = 'Radar/Laser detector for your vehicle.'
},
(Optional) For instant radar detection updates, add this line inside the wk_wars2x client detection event:

lua
Copy
Edit
TriggerEvent('wk:radarDetection', { band = "Ka", direction = "front", strength = 0.85 })
Usage
Obtain the Valentine One item in your inventory.

Use the item to toggle the radar detector on or off.

When activated inside a vehicle, the detector will alert you to nearby police radar and laser signals using the NUI display.

If enabled, the Valentine One prop attaches to your vehicle dashboard for realism.

Configuration
Customize settings in config.lua including:

Detection range and polling intervals

UI colors and sound effects

Prop model, offsets, and toggle keys

Requirements & Support
Requires QBCore Framework.

Compatible with Sonoran wk_wars2x.

Tested on FiveM servers.

License
Free for non-commercial use and modification. Please credit original authors if redistributing.

Credits
Sonoran Software — wk_wars2x

UI inspired by the real-world Valentine One radar detector

Preview
