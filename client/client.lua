lib.locale()
lib.getLocale('ox_inventory', 'open_police_evidence')
lib.getLocale('ox_inventory', 'locker_number')
lib.getLocale('ox_inventory', 'inventory_right_access')

local marker = Config.Marker
for envPrefix, data in pairs(Config.Locations) do
    local coords = data.coords
    local evMarker = lib.points.new({
        coords = coords,
        distance = 20,
        interactPoint = nil,
        nearby = function()
            DrawMarker(marker.type, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0 , 0.0, 0.0, 0.0, marker.sizeX, marker.sizeY, marker.sizeZ, marker.r, marker.g, marker.b, marker.a, false, false, 0, marker.rotate, false, false, false)
        end,
        onEnter = function(self)
            if self.interactPoint then return end
            self.interactPoint = lib.points.new({
                coords = coords,
                distance = 1,
                nearby = function()
                    if IsControlJustReleased(0, 51) then
                        local jobName, jobGrade = lib.callback.await('qtm-evidence:server:getJobAndGrade', false)
                        local canAccess = false
                        for _, data in pairs(data.job) do
                            if data[1] == jobName and data[2] <= jobGrade then
                                canAccess = true
                            end
                        end
                        if not canAccess then
                            qtm.Notification(nil, Config.Language.notifyTitle, 'error', locale('inventory_right_access'))
                            return
                        end
                        local input = lib.inputDialog(data.label, {
                            {type = 'number', label = locale('locker_number'), icon = 'calculator', required = true, min = 1, max = 999},
                          })
                        if not input then return end
                        TriggerServerEvent('qtm-evidence:server:openLocker', envPrefix, input[1], NetworkGetNetworkIdFromEntity(cache.ped))
                    end
                end,
                onEnter = function()
                    qtm.TextUI.Show('[E] '..locale('open_police_evidence'))
                end,
                onExit = function()
                    qtm.TextUI.hide()
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

