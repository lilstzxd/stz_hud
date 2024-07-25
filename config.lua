Config = {}

-- Framework used for the game. Options are 'esx' or 'qbcore'.
Config.Framework = 'esx'  -- Can be 'esx' or 'qbcore'

-- Default language for notifications and messages.
Config.DefaultLanguage = 'es' 

-- Speed limiter configuration
Config.SpeedLimiter = {
    enabled = true,  -- Enable or disable the speed limiter feature.
    limit = 80,      -- Speed limit in km/h for the speed limiter.
    toggleKey = 20   -- Key for toggling the speed limiter (default is Caps Lock / Key Code 20)
}

-- Fuel consumption settings
Config.FuelConsumption = {
    enabled = true,  -- Enable or disable fuel consumption feature.
    rate = 4.0      -- Rate of fuel consumption per unit of time.
}

-- Notification settings
Config.Notifications = {
    lowFuelThreshold = 15, -- Threshold for low fuel warning notification in percentage.
    seatbeltNotification = true -- Enable or disable seatbelt notifications.
}

-- Translations for notifications and messages in different languages
Config.Translations = {
    en = {
        speedLimiterOn = "Speed limiter: ENABLED", -- Message shown when speed limiter is enabled.
        speedLimiterOff = "Speed limiter: DISABLED", -- Message shown when speed limiter is disabled.
        lowFuel = "Warning! Low fuel.", -- Message shown when fuel is low.
        seatbeltOn = "Seatbelt: ON", -- Message shown when seatbelt is fastened.
        seatbeltOff = "Seatbelt: OFF" -- Message shown when seatbelt is unfastened.
    },
    es = {
        speedLimiterOn = "Limitador de velocidad: ACTIVADO", -- Message shown when speed limiter is enabled.
        speedLimiterOff = "Limitador de velocidad: DESACTIVADO", -- Message shown when speed limiter is disabled.
        lowFuel = "¡Advertencia! Poca gasolina.", -- Message shown when fuel is low.
        seatbeltOn = "Cinturón de seguridad: PUESTO", -- Message shown when seatbelt is fastened.
        seatbeltOff = "Cinturón de seguridad: QUITADO" -- Message shown when seatbelt is unfastened.
    }
}
