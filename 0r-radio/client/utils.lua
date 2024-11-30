--- A simple wrapper around SendNUIMessage that you can use to
--- dispatch actions to the React frame.
---
---@param action string The action you wish to target
---@param data any The data you wish to send along with this action
function SendReactMessage(action, data)
    SendNUIMessage({
        action = action,
        data = data
    })
end

---@param name string resource name
---@return boolean
function hasResource(name)
    return GetResourceState(name):find('start') ~= nil
end

---@param dict string
function loadAnimDict(dict)
    if not HasAnimDictLoaded(dict) then
        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do
            Wait(0)
        end
    end
end

---@param ped number
---@return string dict
function getRadioDict(ped)
    return IsPedInAnyVehicle(ped, false) and 'cellphone@in_car@ds' or 'cellphone@'
end

---@param model number | string
function loadModel(model)
    if HasModelLoaded(model) then
        return
    end
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(0)
    end
end

-- Checks if a player has a "radio" in their inventory.
---@param PlayerItems (table) The table containing the player's inventory items.
---@return (boolean) Returns true if the player has a "radio" item, false otherwise.
function hasRadioItem(PlayerItems)
    local racija = exports.ox_inventory:GetItemCount('radio')
    if racija > 0 then
        return true
    else
        return false
    end
    -- for _, item in pairs(PlayerItems) do
    --     if item.name == Config.RadioItem then
    --         return true
    --     end
    -- end
    -- return false
end

local function customNotify(text, type, duration, icon)
    --[[
        You can add your custom notification plugin here.
        The following is just an example.
	]]
    -- if hasResource('ox_lib') then
    --     exports.ox_lib:notify({
    --         type = type,
    --         description = text,
    --         duration = duration,
    --         icon = icon
    --     })
    -- end
end

---@param type string inform / success / error
---@param text string Notification text
---@param duration? number (optional) Duration in miliseconds, custom notify.
---@param icon? string (optional) icon name, custom notify.
function notify(text, type, duration, icon)
    if Config.UseCustomNotify then
        customNotify(text, type, duration, icon)
    else
        exports['okokNotify']:Alert('Racija', text, duration, type)
    end
end

-- Calculates the current time to display, formatting the hour and minute values with leading zeros if needed.
---@return (table) A table containing the formatted time values.
--- - `hour` (number): The current hour.
--- - `minute` (string): The formatted minute (with leading zeros if needed).
function CalculateTimeToDisplay()
    local hour = GetClockHours()
    local minute = GetClockMinutes()

    local obj = {}

    if minute <= 9 then
        minute = "0" .. minute
    end

    obj.hour = hour
    obj.minute = minute

    return obj
end

-- Draws 3D text at the specified world coordinates.
---@param x (number) The X-coordinate of the text in the world.
---@param y (number) The Y-coordinate of the text in the world.
---@param z (number) The Z-coordinate of the text in the world.
---@param text (string) The text to be displayed.
function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0 + 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end
