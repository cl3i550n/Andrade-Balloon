-- Spawn Balloon --------------------------------------------------------------------
local balloon = nil
local Blips = {}

local T = Translation.Langs[Config.Lang]

-- Thread for interaction with balloon locations
Citizen.CreateThread(function()
    while true do
        local playerCoords = GetEntityCoords(PlayerPedId())
        local nearLocation = false

        for _, location in pairs(Config.BalloonLocations) do
            local distance = Vdist(playerCoords, location.coords.x, location.coords.y, location.coords.z)
            if distance < 3.0 then
                DrawTxt(T.PressButton, 0.50, 0.85, 0.7, 0.7, true, 255, 255, 255, 255, true)
                if IsControlJustReleased(0, Config.KeyToBuyBalloon) then
                    TriggerServerEvent('Andrade-Ballon:BuyBalloon')
                end
                nearLocation = true
                break
            end
        end

        Citizen.Wait(nearLocation and 0 or 500)
    end
end)

-- Thread for creating blips for all balloon locations
Citizen.CreateThread(function()
    for _, location in pairs(Config.BalloonLocations) do
        local blip = N_0x554d9d53f696d002(1664425300, location.coords.x, location.coords.y, location.coords.z)
        SetBlipSprite(blip, -1595467349, 1)
        SetBlipScale(blip, 0.2)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, location.name)
        table.insert(Blips, blip)
    end
end)

-- Optimized DrawTxt function
function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local varStr = CreateVarString(10, "LITERAL_STRING", str)
    SetTextScale(w, h)
    SetTextColor(col1, col2, col3, a)
    SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
    DisplayText(varStr, x, y)
end

-- Net event for spawning the balloon
RegisterNetEvent('Andrade-Ballon:SpawnBalloon')
AddEventHandler('Andrade-Ballon:SpawnBalloon', function()
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local head = GetEntityHeading(playerPed)
    local hash = GetHashKey('hotAirBalloon01')

    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(10)
    end

    if balloon and DoesEntityExist(balloon) then
        DeleteEntity(balloon)
    end

    balloon = CreateVehicle(hash, coords.x, coords.y - 2.0, coords.z, head, true, true)
    SetModelAsNoLongerNeeded(hash)
end)

-- Clean up blips when the resource stops
AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    for _, blip in pairs(Blips) do
        RemoveBlip(blip)
    end
end)
