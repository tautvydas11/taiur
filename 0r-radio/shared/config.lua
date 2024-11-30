Config = {}

-- Voice system selection: "pma-voice" or "saltychat".
Config.VoiceSystem = "pma-voice"

-- Use a custom notification system (true) or the default one (false).
Config.UseCustomNotify = false

-- Radio item name
Config.RadioItem = "radio"

Config.RadioToggleKey = "O"

-- Restricted channels for professions.
Config.RestrictedChannels = {
    [1] = { police = true},
    [2] = { police = true },
    [3] = { police = true, aras = true, music = true},
    [4] = { police = true, aras = true, ambulance = true, music = true},
    [5] = { aras = true },
    [6] = { aras = true },
    [7] = { ambulance = true},
    [8] = { ambulance = true},
    [9] = { mechanic = true},
    [10] = { mechanic = true},
    [11] = { fire = true},
    [12] = { gauja1 = true},
    [13] = { gauja2 = true},
    [14] = { gauja3 = true},
    [15] = { gauja4 = true},
    [16] = { gauja5 = true},
    [17] = { gauja6 = true},
    [18] = { mafija = true},
    [19] = { mafija = true, gauja1 = true, gauja2 = true, gauja3 = true, gauja4 = true, gauja5 = true, gauja6 = true},
    [20] = { mafija = true, music = true},

}

-- Jammer settings to interfere with communication.
Config.JammerSettings = {
    available = true,                    -- Jammers are available in the game.
    item_name = 'jammer',                -- Name of the jammer item used by players.
    restricted_jobs = { police = true }, -- Only certain jobs can use jammers.
    object = "sm_prop_smug_jammer",      -- Object representing the jammer in the game world.
    min_distance_between_jammers = 15,   -- Minimum distance allowed between two jammers.
    range = 10.0,                        -- Effective range of the jammers.
}

-- Maximum frequency value allowed in the game's radio communication system.
Config.MaxFrequency = 99

-- Default language/locale for the game's text-based content (English).
Config.Locale = 'en'

-- ! PMA Voice Configs
-- Radio communication effects and animation settings.
-- Enable radio submix (voice sounds like on real radio).
Config.RadioEffect = true
-- Enable animation while talking on the radio.
Config.RadioAnimation = true
-- Default keybind for talking on the radio (CAPS).
Config.RadioKey = 'ALT'
