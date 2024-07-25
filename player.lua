local isHudToggled = false
local withRadarToggle = true

local ESX = nil
local QBCore = nil
local Framework = Config.Framework

-- Initialize the ESX or QBcore framework
if Framework == 'esx' then
    ESX = exports["es_extended"]:getSharedObject()
elseif Framework == 'qbcore' then
    QBCore = exports['qb-core']:GetCoreObject()
end

local function GetRealPedHealth(ped)
    return math.floor(GetEntityHealth(ped) - 100) < 0 and 0 or math.floor(GetEntityHealth(ped) - 100)
end

local function sendNuiMessage(action, data)
    local payload = { type = tostring(action) }
    if data and type(data) == 'table' then
        for k, v in pairs(data) do
            payload[k] = v
        end
    end
    SendNUIMessage(payload)
end

local function onTick(data, thirst)
    local stats = {}
    if type(data) == "number" and thirst ~= nil then
        stats.hunger = data
        stats.thirst = thirst
        sendNuiMessage('updatePlayerStats', {
            health = GetRealPedHealth(PlayerPedId()),
            armor = GetPedArmour(PlayerPedId()),
            hunger = data,
            thirst = thirst
        })
    elseif type(data) == "table" then
        for k, v in pairs(data) do
            stats[v.name] = v.percent
        end
        sendNuiMessage('updatePlayerStats', stats)
    end
end

local function showNotification(text)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
    DrawNotification(false, false)
end

-- Handle ESX or QBcore events
if Framework == 'esx' then
    RegisterNetEvent('esx_status:onTick', onTick)
    RegisterNetEvent('hud:client:UpdateNeeds', onTick)
elseif Framework == 'qbcore' then
    RegisterNetEvent('hud:client:UpdateNeeds', function(newHunger, newThirst)
        onTick(newHunger, newThirst)
    end)
end

RegisterCommand('hud', function()
    isHudToggled = not isHudToggled
    showNotification(('Hud is now %s'):format(isHudToggled and 'enabled' or 'disabled'))
end, false)

CreateThread(function()
    while true do
        while (Framework == 'esx' and ESX == nil) or (Framework == 'qbcore' and QBCore == nil) do
            Wait(0)
        end

        local playerPed = PlayerPedId()
        local playerId = PlayerId()

        if Framework == 'esx' then
            sendNuiMessage('updatePlayerStats', {
                health = GetRealPedHealth(playerPed),
                armor = GetPedArmour(playerPed),
                hunger = ESX.GetPlayerData().hunger,
                thirst = ESX.GetPlayerData().thirst 
            })
        elseif Framework == 'qbcore' then
            local playerData = QBCore.Functions.GetPlayerData()
            sendNuiMessage('updatePlayerStats', {
                health = GetRealPedHealth(playerPed),
                armor = GetPedArmour(playerPed),
                hunger = playerData.hunger,
                thirst = playerData.thirst 
            })
        end

        DisplayRadar(true)

        Wait(1000)
    end
end)
