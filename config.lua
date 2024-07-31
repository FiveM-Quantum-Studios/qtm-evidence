Config = {}
----------------------------------------------------------------
Config.CheckForUpdates = true
Config.Debug = true
Config.Framework = 'ESX' --Currently only ESX and qb
----------------------------------------------------------------
Config.LoggingTypes = {
    ['info'] = '[^4Info^0]',
    ['debug'] = '[^3DEBUG^0]',
    ['error'] = '[^1ERROR^0]',
}
----------------------------------------------------------------
Config.Locations = {
    ['policeevidence'] = { --Stash prefix
        coords = vector3(452.46, -980.15, 30.68),
        label = 'Police Evidence',
        stash = {
            weight = 10000,
            slots = 10
        },
        job = {
            {'police', 1},
            {'offpolice', 0}
        }
    },
    ['usmsevidence'] = { --Stash prefix
        coords = vector3(443.16, -976.46, 30.689),
        label = 'USMS Evidence',
        stash = {
            weight = 10000,
            slots = 10
        },
        job = {
            {'usms', 1},
            {'offusms', 0}
        }
    }
}



----------------------------------------------------------------
Config.Marker = {
    type = 20,
    sizeX = 0.5,
    sizeY = 0.5,
    sizeZ = 0.5,
    r = 30,
    g = 150,
    b = 30,
    a = 255,
    rotate = true,
    distance = 2
}
----------------------------------------------------------------
Config.Noti = {
    --Notifications types:
    success = 'success',
    error = 'error',
    info = 'inform',
    warning = 'warning',
}
Config.Notification = function(source, notitype, message)
    if IsDuplicityVersion() then -- serverside
        TriggerClientEvent('ox_lib:notify', source, {
            title = 'Evidence locker',
            description = message,
            type = notitype,
            duration = 5000
        })
    else -- clientside
        lib.notify({
            title = 'Evidence locker',
            description = message,
            type = notitype,
            duration = 5000
        })
    end
end
----------------------------------------------------------------
