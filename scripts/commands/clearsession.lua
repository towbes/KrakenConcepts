---------------------------------------------------------------------------------------------------
-- func: clearsession
-- desc: Clears a target's account session allowing them to log back in if hung
---------------------------------------------------------------------------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 3,
    parameters = 's'
}

commandObj.error = function(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer('!clearsession <player>')
end

commandObj.onTrigger = function(player, targName)
    -- validate target
    if (targName == nil) then
        return error(player, 'You must supply the name of an offline player.')
    end

    if player:clearSession(targName) == true then
        return player:PrintToPlayer(string.format('Cleared %s\'s session.', targName))
    end

    return player:PrintToPlayer(string.format('No player named %s found.', targName))
end

return commandObj
