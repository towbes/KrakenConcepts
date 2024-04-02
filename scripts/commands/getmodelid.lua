-----------------------------------
-- func: !getmodel
-- desc: Prints the target modelID, animationID and animationSubID
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 's'
}

commandObj.error = function(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer('!getmodel <target>')
end

commandObj.onTrigger = function(player)
    local target = player:getCursorTarget()

    if target ~= nil and target:isMob() or target:isNPC() then
        player:printToPlayer(string.format(
            '%s (%d): model %d, animation %d, animationSub %d',
            target:getName(),
            target:getID(),
            target:getModelId(),
            target:getAnimation(),
            target:getAnimationSub()
        ))
    else
        error(player, string.format('Target is not a mob or NPC'))
    end
end

return commandObj
