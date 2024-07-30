if Config.Framework == 'ESX' then
    ESX = exports["es_extended"]:getSharedObject()
elseif Config.Framework == 'qb' then
    QBCore = exports['qb-core']:GetCoreObject()
end

---Get player job name
---@param src string
---@return string
function getPlayerJobName(src)
    if Config.Framework == 'ESX' then
        return ESX.GetPlayerFromId(src).getJob().name
    elseif Config.Framework == 'qb' then
        return QBCore.Functions.GetPlayer(src).PlayerData.job.name
    end
end

---Get player job grade
---@param src string
---@return integer
function getPlayerJobGrade(src)
    if Config.Framework == 'ESX' then
        return ESX.GetPlayerFromId(src).getJob().grade
    elseif Config.Framework == 'qb' then
        return QBCore.Functions.GetPlayer(src).PlayerData.job.grade.level
    end
end

---Callback for getting player job name and grade
---@param source string
---@return string
---@return integer
lib.callback.register('qtm-evidence:server:getJobAndGrade', function(source)
    return getPlayerJobName(source), getPlayerJobGrade(source)
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
        Unr3al.Logging('info', 'Player '..src..' is trying to open evidence with invalid entity')
        return
    end

    local canAccess, jobName, jobGrade = false, getPlayerJobName(src), getPlayerJobGrade(src)
    for _, data in pairs(locker.job) do
        Unr3al.Logging('debug', data[1], data[2], jobName, jobGrade)
        if data[1] == jobName and data[2] <= jobGrade then
            canAccess = true
        end
    end
    if not canAccess then 
        Unr3al.Logging('debug', 'Access not allowed')
        return
    end
    local inventory = exports.ox_inventory:GetInventory(stashName, false)
    if not inventory then
        exports.ox_inventory:RegisterStash(stashName, stashLabel, locker.stash.slots, locker.stash.weight, false, locker.job, locker.coords)
        while not exports.ox_inventory:GetInventory(stashName, false) do
            Wait(500)
        end
    end
    exports.ox_inventory:forceOpenInventory(src, 'stash', stashName)
end)



Unr3al = {}
Unr3al.Logging = function(code, ...)
    if not Unr3al.TableContains({'error', 'debug', 'info'}, code) then
        if not Config.Debug and code == 'debug' then return end
        local action = ...
        local args = {...}
        table.remove(args, 1)

        print(Config.LoggingTypes[action], ...)
    else
        if not Config.Debug and code ~= 'error' then return end
        print(Config.LoggingTypes[code], ...)
    end
end
if Config.checkForUpdates then
    lib.versionCheck('FiveM-Quantum-Studios/qtm-evidence')
end