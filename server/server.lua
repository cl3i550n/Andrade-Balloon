local VORPcore = exports.vorp_core:GetCore()
local T = Translation.Langs[Config.Lang]

RegisterNetEvent('Andrade-Ballon:BuyBalloon', function()
    local src = source
    local Character = VORPcore.getUser(src).getUsedCharacter
    local money = Character.money
    local coast = Config.BallonPrice

    if Config.EnableTax then
        if money >= Config.BallonPrice then
            Character.removeCurrency(0, coast)
            TriggerClientEvent('Andrade-Ballon:SpawnBalloon', src)
            VORPcore.NotifyRightTip(src, T.TaxOfUse .. ' ' .. coast .. ' ' .. T.ToUseBalloon, 4000)
        else
            VORPcore.NotifyRightTip(src, T.IfNecessary .. ' ' .. coast .. ' ' .. T.ToUseBalloon, 4000)
        end
    else
        TriggerClientEvent('Andrade-Ballon:SpawnBalloon', src)
    end
end)
