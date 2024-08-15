Config = {}
----------------------------------------------------------------
Config.CheckForUpdates = true
Config.Debug = true
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
Config.Language = {
    notify_title = "Evidence",
    open_police_evidence = 'Open Evidence',
    locker_number = "Locker Number",
    inventory_right_access = "You can't access this?"
}