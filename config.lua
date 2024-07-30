Config = {}
----------------------------------------------------------------
Config.Locale = 'en' --choices: en - English; cs - Czech; de - German; fr - French; pl - Polish; sk - Slovakia;
Config.checkForUpdates = true
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
            {'police', 0},
            {'offpolice', 0}
        }
    }
}



----------------------------------------------------------------
Config.Marker = {
    type = 20,
    sizeX = 1.0,
    sizeY = 1.0,
    sizeZ = 1.0,
    r = 255,
    g = 255,
    b = 255,
    a = 100,
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
            title = 'Meth lab',
            description = message,
            type = notitype,
            duration = 5000
        })
    else -- clientside
        lib.notify({
            title = 'Meth lab',
            description = message,
            type = notitype,
            duration = 5000
        })
    end
end
----------------------------------------------------------------