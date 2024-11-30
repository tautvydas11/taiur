-- exports QBCore
ESX = exports["es_extended"]:getSharedObject()

-- load playerData
PlayerData = ESX.GetPlayerData()

---@type boolean
gHasBootAnimation = false

---
-- The player data table that stores various properties related to the player.
---@field hasRadio (boolean) Indicates whether the player has a radio item (true) or not (false).
---@field isMenuOpen (boolean) Indicates whether the player's menu is open (true) or not (false).
---@field onRadio (boolean) Indicates whether the player is currently using the radio (true) or not (false).
---@field channel (number) The current radio channel the player is tuned to.
---@field volume (number) The volume level of the radio for the player.
---@field prop (number | nil) The number representing the radio prop, or nil if no radio prop is associated.
---@field inJammerRange (boolean)
---@field lastChannel (number | nil)
gPlayer = {
    hasRadio = false,
    isMenuOpen = false,
    onRadio = false,
    channel = 0,
    volume = 50,
    prop = nil,
    inJammerRange = false,
    lastChannel = 0,
}

gSpawnedJammerObjects = {}
