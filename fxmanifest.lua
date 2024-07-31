fx_version 'adamant'
game 'gta5'
lua54 'yes'

author 'Quantum Studios'
description 'Advanced Evidence system'
version '1.0.0'

dependencies {'ox_lib', 'ox_inventory'}

server_scripts {
    'server/*.lua'
}

client_scripts {
    'client/*.lua',
}

shared_scripts {
    'config.lua',
    '@ox_lib/init.lua'
}

files {
    'locales/*.*'
}