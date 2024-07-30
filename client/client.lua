lib.locale()
lib.getLocale('ox_inventory', 'open_police_evidence')
lib.getLocale('ox_inventory', 'locker_number')

local marker = Config.Marker
for envPrefix, data in pairs(Config.Locations) do
    local coords = data.coords
    local evMarker = lib.points.new({
        coords = coords,
        distance = 20,
        interactPoint = nil,
        nearby = function()
            DrawMarker(marker.type, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0 , 0.0, 0.0, 0.0, marker.sizeX, marker.sizeY, marker.sizeZ, marker.r, marker.b, marker.g, marker.a, false, false, 0, marker.rotate, false, false, false)
        end,
        onEnter = function(self)
            local jobName, jobGrade = lib.callback.await('qtm-evidence:server:getJobAndGrade', false)
            local canAccess = false
            for _, data in pairs(data.job) do
                if data[1] == jobName and data[2] <= jobGrade then
                    canAccess = true
                end
            end
            if not canAccess then return end
            if self.interactPoint then return end
            self.interactPoint = lib.points.new({
                coords = coords,
                distance = 1,
                nearby = function()
                    if IsControlJustReleased(0, 51) then
                        local input = lib.inputDialog(data.label, {
                            {type = 'number', label = locale('locker_number'), icon = 'calculator', required = true, min = 1, max = 999},
                          })
                        if not input then return end
                        TriggerServerEvent('qtm-evidence:server:openLocker', envPrefix, input[1], NetworkGetNetworkIdFromEntity(cache.ped))
                    end
                end,
                onEnter = function()
                    lib.showTextUI('[E] '..locale('open_police_evidence'))
                end,
                onExit = function()
                    lib.hideTextUI()
                end
            })
        end,
        onExit = function(self)
            if not self.interactPoint then return end
            self.interactPoint:remove()
            self.interactPoint = nil
        end,
    })
end

