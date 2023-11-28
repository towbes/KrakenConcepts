-----------------------------------
-- func: sjlock
-- desc: Disables the players subjob in exhange for a base stat increase. Not enabled until players speak to MogMog in Ru'lude Gardens.
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 0,
    parameters = 's'
}

local function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer('!sjlock')
end

commandObj.onTrigger = function(player, team)
	local teamno = 0
	
    local zone = player:getZone()
    if player:getCharVar('MogMog_Spoken_SubJobLock') == 0 then
        player:PrintToPlayer('You must speak to MogMog in Ru\'lude Gardens(H-5) before you can use this command.', xi.msg.channel.SYSTEM_3)
    else
        if zone:getTypeMask() == xi.zoneType.CITY and player:getSubJob() ~= 0 then
            player:independentAnimation(player, 75, 4)
            player:timer(1500, function(playerArg)
                player:independentAnimation(player, 76, 4)
            end)
            player:timer(3500, function(playerArg)
                player:independentAnimation(player, 53, 4)
            end)
            player:changesJob(0)
            player:PrintToPlayer('Your subjob has been disabled and your stats have increased.', xi.msg.channel.SYSTEM_3)
        elseif player:getSubJob() == 0 then
            player:PrintToPlayer('Your subjob is already disabled', xi.msg.channel.SYSTEM_3)
        else
            player:PrintToPlayer('You must within a city zone to use this command', xi.msg.channel.SYSTEM_3)
        end
    end
end

return commandObj
