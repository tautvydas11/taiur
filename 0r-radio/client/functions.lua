PlayerData = ESX.GetPlayerData()

RegisterNetEvent('esx:setJob', function(job, lastJob)
    leaveRadio()
    resetPlayer()
    PlayerData = ESX.GetPlayerData()
end)

Citizen.CreateThread(function()
    while true do
        PlayerData = ESX.GetPlayerData()
        Wait(2000)
    end
end)

local function DisableDisplayControlActions()
    DisableAllControlActions(0)
    EnableControlAction(0, 21, true) -- INPUT_SPRINT
    EnableControlAction(0, 22, true) -- INPUT_JUMP
    EnableControlAction(0, 30, true) -- INPUT_MOVE_LR
    EnableControlAction(0, 31, true) -- INPUT_MOVE_UD
    EnableControlAction(0, 59, true) -- INPUT_VEH_MOVE_LR
    EnableControlAction(0, 71, true) -- INPUT_VEH_ACCELERATE
    EnableControlAction(0, 72, true) -- INPUT_VEH_BRAKE
end

function removeRadioProp()
    local radioProp = gPlayer.prop
    if not radioProp then return end
    DetachEntity(radioProp, false, false)
    DeleteEntity(radioProp)
    gPlayer.prop = nil
end

function resetPlayer()
    if gPlayer.prop then removeRadioProp() end
    gPlayer = {
        hasRadio = false,
        isMenuOpen = false,
        onRadio = false,
        channel = 0,
        volume = 50,
        prop = nil,
        lastChannel = 0
    }
    SetNuiFocus(false, false)
    SetNuiFocusKeepInput(false)
end

local function toggleRadioAnimation(pState)
    if pState then
        local model = 'prop_cs_hand_radio'
        loadModel(model)
        gPlayer.prop = CreateObject(model, 0.0, 0.0, 0.0, true, true, true)
        local ped = PlayerPedId()
        AttachEntityToEntity(gPlayer.prop, ped, GetPedBoneIndex(ped, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true,
            false, true, 0, true)
        SetModelAsNoLongerNeeded(model)
        local dict = getRadioDict(ped)
        loadAnimDict(dict)
        TaskPlayAnim(ped, dict, 'cellphone_text_in', 4.0, -1, -1, 50, 0, false, false, false)
        RemoveAnimDict(dict)
    else
        local ped = PlayerPedId()
        local dict = getRadioDict(ped)
        StopAnimTask(ped, dict, 'cellphone_text_in', 1.0)
        Wait(100)
        loadAnimDict(dict)
        TaskPlayAnim(ped, dict, 'cellphone_text_out', 7.0, -1, -1, 50, 0, false, false, false)
        Wait(200)
        StopAnimTask(ped, dict, 'cellphone_text_out', 1.0)
        RemoveAnimDict(dict)
        removeRadioProp()
    end
end

function toggleRadio(toggle)
    toggleRadioAnimation(toggle)
    SetNuiFocus(toggle, toggle)
    SetNuiFocusKeepInput(toggle)
    gPlayer.isMenuOpen = toggle
    SendReactMessage('setRadioVisible', toggle)
    CreateThread(function()
        while gPlayer.isMenuOpen do
            DisableDisplayControlActions()
            Citizen.Wait(1)
        end
    end)
end

local function leavePMAVoiceRadio()
    exports["pma-voice"]:removePlayerFromRadio()
    exports["pma-voice"]:setVoiceProperty("radioEnabled", false)
end

local function leaveSaltyChatRadio()
    local getPlayerRadioChannel = exports.saltychat:GetRadioChannel(true)
    if getPlayerRadioChannel or getPlayerRadioChannel ~= '' then
        exports.saltychat:SetRadioChannel('', true)
    end
end

function leaveRadio()
    if Config.VoiceSystem == 'pma-voice' then
        leavePMAVoiceRadio()
    elseif Config.VoiceSystem == 'saltychat' then
        leaveSaltyChatRadio()
    end
    TriggerServerEvent('0R-radio:server:SendPlayersInRadioChannel', gPlayer.channel)
    gPlayer.onRadio = false
    gPlayer.channel = 0
end

local function connectToPMAVoiceRadio(channel)
    exports["pma-voice"]:setVoiceProperty("radioEnabled", true)
    exports["pma-voice"]:setRadioChannel(channel)
end

local function connectSaltyChatRadio(channel)
    exports.saltychat:SetRadioChannel(channel, true)
end

function connectToRadio(channel)
    if Config.VoiceSystem == 'pma-voice' then
        connectToPMAVoiceRadio(channel)
    elseif Config.VoiceSystem == 'saltychat' then
        connectSaltyChatRadio(channel)
    end
    TriggerServerEvent('0R-radio:server:SendPlayersInRadioChannel', channel)
    gPlayer.onRadio = true
    gPlayer.channel = channel
end

local function setVolumePMAVoiceRadio(value)
    exports["pma-voice"]:setRadioVolume(value)
end

local function setVolumeSaltyChatRadio(value)
    local volumeLevel = value / 100.0
    exports.saltychat:SetRadioVolume(volumeLevel)
end

-- function checkPlayerMute(playerId)
--     return exports["pma-voice"]:isPlayerMuted(playerId)
-- end

function ThreadUpdateGameTime()
    while true do
        Wait(1000)
        if gPlayer.isMenuOpen then
            SendReactMessage('setGameTime', CalculateTimeToDisplay())
        end
    end
end

function ThreadCheckAndResetRadio()
    while true do
        local mires = IsPedDeadOrDying(cache.ped)
        local racija = exports.ox_inventory:GetItemCount('radio')
        Wait(1000)
        if LocalPlayer.state.isLoggedIn and gPlayer.onRadio then
            if racija > 1 or mires then
                gPlayer.lastChannel = 0
                leaveRadio()
                print("as isjungiu")
                notify(_t('leave_channel'), 'error')
                toggleRadio(false)
                SendReactMessage("resetRadio")
            end
        end
    end
end

function checkDistanceForJammers(jammers)
    local closestDistance = -1
    local closestJammer = nil
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)

    for objectId, jammerData in pairs(jammers) do
        local distance = #(playerCoords - jammerData.coords)

        if distance < Config.JammerSettings.min_distance_between_jammers then
            closestDistance = distance
            closestJammer = jammerData
            break
        end
    end
    return closestDistance, closestJammer
end


-- NUI'
RegisterNUICallback('joinRadio', function(channel, cb)
    local rchannel = tonumber(channel)

    if rchannel then
        if rchannel <= Config.MaxFrequency and rchannel ~= 0 then
            if not gPlayer.inJammerRange then
                if Config.RestrictedChannels[rchannel] then
                    if Config.RestrictedChannels[rchannel][PlayerData.job.name] then
                        connectToRadio(rchannel)
                        notify(_t('connected_to') .. channel .. '.00 MHz', 'success')
                        local retData = { status = true, connected = true, newChannel = gPlayer.channel }
                        cb(retData)
                        return
                    else
                        notify(_t('restricted_channel'), 'error')
                    end
                else
                    connectToRadio(rchannel)
                    notify(_t('connected_to') .. channel .. '.00 MHz', 'success')
                    local retData = { status = true, connected = true, newChannel = gPlayer.channel }
                    cb(retData)
                    return
                end
            else
                notify(_t('no_signal'), 'error')
            end
        else
            notify(_t('invalid_frequency'), 'error')
        end
    else
        notify(_t('invalid_frequency'), 'error')
    end
    cb({ status = false })
end)

RegisterNUICallback('leaveRadio', function(_, cb)
    if gPlayer.onRadio then
        notify(_t('leave_channel'), 'error')
    end
    gPlayer.lastChannel = 0
    leaveRadio()
    cb({ status = true })
end)

RegisterNUICallback("volumeUp", function(_, cb)
    if gPlayer.volume <= 95 then
        gPlayer.volume = gPlayer.volume + 5
        if Config.VoiceSystem == 'pma-voice' then
            setVolumePMAVoiceRadio(gPlayer.volume)
        elseif Config.VoiceSystem == 'saltychat' then
            setVolumeSaltyChatRadio(gPlayer.volume)
        end
        local retData = { status = true, newVolume = gPlayer.volume }
        cb(retData)
        return
    end
    cb({ status = false })
end)

RegisterNUICallback("volumeDown", function(_, cb)
    if gPlayer.volume >= 10 then
        gPlayer.volume = gPlayer.volume - 5
        if Config.VoiceSystem == 'pma-voice' then
            setVolumePMAVoiceRadio(gPlayer.volume)
        elseif Config.VoiceSystem == 'saltychat' then
            setVolumeSaltyChatRadio(gPlayer.volume)
        end
        local retData = { status = true, newVolume = gPlayer.volume }
        cb(retData)
        return
    end
    cb({ status = false })
end)

RegisterNUICallback('poweredOff', function(_, cb)
    if gPlayer.onRadio then
        notify(_t('leave_channel'), 'error')
    end
    gPlayer.lastChannel = 0
    leaveRadio()
    toggleRadio(false)
    Wait(100)
    gHasBootAnimation = false
    cb({ status = true })
end)

RegisterNUICallback("getServerVoiceSystem", function(_, cb)
    cb(Config.VoiceSystem)
end)

RegisterNUICallback('hideFrame', function(_, cb)
    toggleRadio(false)
    cb('ok')
end)

RegisterNUICallback('getHasBootAnimation', function(_, cb)
    cb(gHasBootAnimation)
end)

RegisterNUICallback("setMutePlayer", function(source, cb)
    if Config.VoiceSystem == 'pma-voice' then
        exports["pma-voice"]:toggleMutePlayer(source)
    end
    cb({ status = true })
end)
