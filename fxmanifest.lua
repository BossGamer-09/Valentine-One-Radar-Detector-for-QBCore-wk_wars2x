fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'v1_radar_qb'
author 'you + gpt'
description 'Valentine One radar detector (QBCore) integrated with Sonoran wk_wars2x'
version '1.2.0'

ui_page 'html/index.html'

files {
  'html/index.html',
  'html/style.css',
  'html/script.js'
}

shared_scripts {
  '@qb-core/shared/locale.lua',
  'config.lua',
  'shared/utils.lua'
}

client_scripts {
  'client/inventory.lua',
  'client/prop.lua',
  'client/detector.lua'
}

server_scripts {
  '@oxmysql/lib/MySQL.lua', -- optional; harmless if unused
  'server/main.lua'
}
