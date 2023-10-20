-----------------------------------
-- func: setrefundmerits <amount> <player>
-- desc: Sets a player's merits to use with the !merits command.
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 5,
    parameters = 'is'
}

local function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer('!setrefundmerits <amount> (player)')
end

commandObj.onTrigger = function(player, amount, target)

    local targ
    if target == nil then
        targ = player
    else
        targ = GetPlayerByName(target)
        if targ == nil then
            error(player, string.format('Player named '%s' not found!', target))
            return
        end
    end

    if amount == nil or amount < 0 then
        error(player, 'Invalid amount.')
        return
    end

    local totalMerits = amount
    targ:setCharVar('refundMerits', totalMerits)
    local merits = targ:getCharVar('refundMerits')
    player:PrintToPlayer(string.format('Set refunded merits for %s to %i.', targ:getName(), merits))

end

return commandObj