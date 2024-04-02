-----------------------------------
-- func: gettp <player>
-- desc: Displays target's current TP
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'is'
}

commandObj.error = function(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer('!gettp (player or mob)')
end

commandObj.onTrigger = function(player, tp, target)
    local targ = player:getCursorTarget()
    if targ ~= nil then
        player:printToPlayer(string.format('%s\'s TP is %i.', targ:getName(), targ:getTP()))
    end
end

return commandObj
