CreateThread(ThreadCheckAndResetRadio)
CreateThread(ThreadUpdateGameTime)

CreateThread(function()
    local removingJammerObject = false
    while true do
        local sleep = 2000
        if Config.JammerSettings.available and next(gSpawnedJammerObjects) ~= nil then
            local jobName = PlayerData.job.name
            local isOnDuty = PlayerData.job.onduty
            if Config.JammerSettings.restricted_jobs[jobName] and isOnDuty then
                local playerPed = PlayerPedId()
                local playerCoords = GetEntityCoords(playerPed)
                for k, v in pairs(gSpawnedJammerObjects) do
                    local dist = #(playerCoords - v.coords)
                    if dist <= 2.0 then
                        sleep = 5
                        --[[
                            "If you want, you can use your own textUI plugin instead of drawText."
                        ]]
                        DrawText3D(v.coords.x, v.coords.y, v.coords.z, "Remove [E]")
                        if IsControlJustReleased(0, 38) and not removingJammerObject then
                            removingJammerObject = true
                            -- QBCore.Functions.Progressbar("remove_object", _t('jammer_remove_object'), 2500, false, true,
                            --     {
                            --         disableMovement = true,
                            --         disableCarMovement = true,
                            --         disableMouse = false,
                            --         disableCombat = true,
                            --     },
                            --     {
                            --         animDict = "weapons@first_person@aim_rng@generic@projectile@thermal_charge@",
                            --         anim = "plant_floor",
                            --         flags = 16,
                            --     },
                            --     {},
                            --     {},
                            --     function() -- Done
                            --         removingJammerObject = false
                            --         StopAnimTask(PlayerPedId(),
                            --             "weapons@first_person@aim_rng@generic@projectile@thermal_charge@",
                            --             "plant_floor", 1.0)
                            --         TriggerServerEvent('0R-radio:server:DeleteJammerObject', k)
                            --     end,
                            --     function() -- Cancel
                            --         removingJammerObject = false
                            --         StopAnimTask(PlayerPedId(),
                            --             "weapons@first_person@aim_rng@generic@projectile@thermal_charge@",
                            --             "plant_floor", 1.0)
                            --         notify(_t("jammer_cancel_remove_object"), "error")
                            --     end
                            -- )

                                if     lib.progressCircle({
                                    duration = 5000,
                                    position = 'bottom',
                                    useWhileDead = false,
                                    canCancel = true,
                                    disable = {
                                        car = true,
                                        move = true,
                                    },
                                    anim = {
                                        dict = 'clothingtie',
                                        clip = 'try_tie_positive_a'
                                    }
                                }) then
                                    removingJammerObject = false
                                    StopAnimTask(PlayerPedId(), "weapons@first_person@aim_rng@generic@projectile@thermal_charge@", "plant_floor", 1.0)
                                    TriggerServerEvent('0R-radio:server:DeleteJammerObject', k)
                                else
                                    removingJammerObject = false
                                    StopAnimTask(PlayerPedId(),
                                        "weapons@first_person@aim_rng@generic@projectile@thermal_charge@",
                                        "plant_floor", 1.0)
                                    notify(_t("jammer_cancel_remove_object"), "error")
                                end


                        end
                    end
                end
            end
        end
        Wait(sleep)
    end
end)

CreateThread(function()
    while true do
        Wait(1000)
        if Config.JammerSettings.available and gPlayer.hasRadio then
            local jobName = PlayerData.job.name
            local isOnDuty = PlayerData.job.onduty
            if not (Config.JammerSettings.restricted_jobs[jobName] and isOnDuty) then
                local playerPed = PlayerPedId()
                local playerCoords = GetEntityCoords(playerPed)
                local inRange = false
                for k, v in pairs(gSpawnedJammerObjects) do
                    local dist = #(playerCoords - v.coords)

                    if dist <= Config.JammerSettings.range then
                        inRange = true
                        break
                    end
                end
                gPlayer.inJammerRange = inRange
                SendReactMessage("setJammerHud", inRange)
            else
                gPlayer.inJammerRange = false
                SendReactMessage("setJammerHud", false)
            end
        else
            gPlayer.inJammerRange = false
            SendReactMessage("setJammerHud", false)
        end
    end
end)


CreateThread(function()
    local _sendInfo = true
    while true do
        Wait(1000)
        if Config.JammerSettings.available and gPlayer.hasRadio and (gPlayer.channel > 0 or gPlayer.lastChannel > 0) then
            if gPlayer.inJammerRange then
                if _sendInfo then
                    notify(_t("no_signal_disconnected"), "error")
                    _sendInfo = false
                end
                if gPlayer.channel ~= 0 then
                    gPlayer.lastChannel = gPlayer.channel
                    leaveRadio()
                end
            else
                if not _sendInfo then
                    notify(_t("no_signal_reconnect"), "success")
                    _sendInfo = true
                end
                if gPlayer.lastChannel > 0 then
                    connectToRadio(gPlayer.lastChannel)
                    gPlayer.lastChannel = 0
                end
            end
        end
    end
end)
