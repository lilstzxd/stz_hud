
local displayHud = false
local speedLimiterEnabled = false
local lowFuelNotified = false
local seatbeltNotified = false
local seatbeltOn = false


local function getTranslation(key)
    local lang = Config.DefaultLanguage or 'en'
    return Config.Translations[lang] and Config.Translations[lang][key] or key
end


local function showNotification(messageKey)
    local message = getTranslation(messageKey)
    lib.notify({
        title = 'Notification',
        description = message,
        type = 'inform'
    })
end

local function toggleHud(visible)
    displayHud = visible
    SendNUIMessage({
        type = "showHUD",
        display = displayHud
    })
    SendNUIMessage({
        type = "showStreetInfo",
        display = displayHud
    })
end


CreateThread(function()
    Wait(1000)
    toggleHud(false)
end)


RegisterCommand("toggleHud", function()
    local ped = PlayerPedId()
    if IsPedInAnyVehicle(ped, false) then
        toggleHud(not displayHud)
    end
end, false)


RegisterNetEvent('toggle:my:hud')
AddEventHandler('toggle:my:hud', function(visible)
    toggleHud(visible)
end)

CreateThread(function()
    while true do
        Wait(0)
        if IsControlJustPressed(1, 137) then -- Key: Bloq Mayús (137)
            speedLimiterEnabled = not speedLimiterEnabled
            if speedLimiterEnabled then
                showNotification("Limitador de velocidad: ACTIVADO")
            else
                showNotification("Limitador de velocidad: DESACTIVADO")
            end
        end
    end
end)



CreateThread(function()
    while true do
        Wait(500)

        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped, false)

        if IsPedInAnyVehicle(ped, false) and veh ~= 0 and (GetPedInVehicleSeat(veh, -1) == ped or GetPedInVehicleSeat(veh, 0) == ped) then
            local speed = GetEntitySpeed(veh) * 3.6 
            local fuel = GetVehicleFuelLevel(veh)
            local damage = (GetEntityHealth(veh) / GetEntityMaxHealth(veh)) * 100

            if Config.Notifications.lowFuelThreshold and fuel < Config.Notifications.lowFuelThreshold and not lowFuelNotified then
                showNotification('lowFuel')
                lowFuelNotified = true
            elseif fuel >= Config.Notifications.lowFuelThreshold then
                lowFuelNotified = false
            end
            if Config.FuelConsumption.enabled then
                SetVehicleFuelLevel(veh, fuel - (Config.FuelConsumption.rate * 0.005))
            end
            if Config.SpeedLimiter.enabled and speedLimiterEnabled and speed > Config.SpeedLimiter.limit then
                SetVehicleForwardSpeed(veh, Config.SpeedLimiter.limit / 3.6) 
            end

            SendNUIMessage({
                type = 'updateHUD',
                speed = speed,
                fuel = fuel,
                damage = damage,
                street = GetStreetNameFromHashKey(GetStreetNameAtCoord(table.unpack(GetEntityCoords(ped))))
            })

            if not displayHud then
                toggleHud(true)
            end

            SetPedConfigFlag(ped, 32, true) 
            SetPedConfigFlag(ped, 35, false)  
            SetPedCanBeKnockedOffVehicle(ped, 1)

            if Config.Notifications.seatbeltNotification and not IsPedInAnyHeli(ped) and not IsPedInAnyBoat(ped) and not IsPedInAnyPlane(ped) then
                if not seatbeltNotified then
                    showNotification('seatbeltOn')
                    seatbeltNotified = true
                end
            end
        else
            if displayHud then
                toggleHud(false)
            end
            seatbeltNotified = false
        end
    end
end)

