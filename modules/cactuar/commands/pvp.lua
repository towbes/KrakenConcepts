-----------------------------------
-- func: pvp
-- desc: Sets player's allegiance to Gryphons or Wyverns.
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 0,
    parameters = 's'
}

local function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer('!pvp green or blue or off')
end

commandObj.onTrigger = function(player, team)
	local teamno = 0

    local zone = player:getZone()
    if zone:getTypeMask() ~= xi.zoneType.CITY then
        player:PrintToPlayer('PVP can currently only be used in City Zones')
        return 1
    end
    if zone:getTypeMask() == xi.zoneType.CITY then
	    if team == 'blue' then
	    	teamno = 5
        elseif team == 'green' then
	    	teamno = 6
	    elseif team == 'off' then
	    	teamno = 1 -- Off/Back to Default
	    end
    end
	
	player:setAllegiance(teamno)
    player:setLocalVar('PVPMODE', 1)
end

return commandObj
