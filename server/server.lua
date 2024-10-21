---Callback for getting player job name and grade
---@param source string
---@return string
---@return integer
lib.callback.register('qtm-evidence:server:getJobAndGrade', function(source)
    return qtm.Framework.GetJob(source).name, qtm.Framework.GetJob(source).grade_level
end)

---Event for opening evidence locker
---@param envPrefix string
---@param lockerNumber integer
---@param netId integer
RegisterNetEvent('qtm-evidence:server:openLocker', function(envPrefix, lockerNumber, netId)
    local src, entity = source, NetworkGetEntityFromNetworkId(netId)
    local locker = Config.Locations[envPrefix]
    local stashName, stashLabel = envPrefix..'_'..lockerNumber, locker.label
    
	if not DoesEntityExist(entity) then
        qtm.Logging('info', 'Player '..src..' is trying to open evidence with invalid entity')
        return
    end

    local canAccess, jobName, jobGrade = false, qtm.Framework.getJob(src).name, qtm.Framework.getJob(src).grade_level
    for _, data in pairs(locker.job) do
        qtm.Logging('debug', data[1] .. data[2] .. jobName .. jobGrade)
        if data[1] == jobName and data[2] <= jobGrade then
            canAccess = true
        end
    end
    if not canAccess then
        qtm.Notification(src, Config.Language.notify_title, 'error', Config.Language.inventory_right_access)
        qtm.Logging('debug', 'Access not allowed')
        return
    end
    local inventory = qtm.Inventory.GetInventory(stashName, false)
    if not inventory then
        qtm.Inventory.RegisterStash(stashName, stashLabel, locker.stash.slots, locker.stash.weight, false, locker.job, locker.coords)
        while not qtm.Inventory.GetInventory(stashName, false) do
            Wait(500)
        end
    end
    qtm.Inventory.ForceOpenInventory(src, 'stash', stashName)
end)


if Config.CheckForUpdates then
    qtm.Server.VersionChecker('qtm-evidence')
end