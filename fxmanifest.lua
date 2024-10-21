fx_version 'adamant'
game 'gta5'
lua54 'yes'

author 'Quantum Studios'
description 'Advanced Evidence system'
version '1.0.0'

dependencies {'ox_lib', 'ox_inventory', 'qtm-lib'}

server_scripts {
    'server/*.lua'
}

client_scripts {
    'client/*.lua',
}

shared_scripts {
    '@ox_lib/init.lua',
    '@qtm-lib/imports.lua',
    'config.lua'
}

escrow_ignore {
    'server/*.lua',
    'client/*.lua',
    'config.lua'
}