-----------------------------------
-- func: getrefundmerits <player>
-- desc: Gets a players total refunded merits.
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 's'
}

local function error(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer('!getrefundmerits (player)')
end

commandObj.onTrigger = function(player, target)

    local targ
    if target == nil then
        targ = player
    else
        targ = GetPlayerByName(target)
        if targ == nil then
            error(player, string.format('Player named %s not found!', target))
            return
        end
    end

    local merits = targ:getCharVar('refundMerits')
    player:printToPlayer(string.format('The total refunded merits for %s is %s.', targ:getName(), merits))

end

return commandObj