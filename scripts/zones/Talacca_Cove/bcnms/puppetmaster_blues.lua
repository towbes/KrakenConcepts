-----------------------------------
-- Area: Talacca Cove
-- BCNM: Puppetmaster Blues
-----------------------------------
local battlefieldObject = {}

battlefieldObject.onBattlefieldTick = function(battlefield, tick)
    xi.battlefield.onBattlefieldTick(battlefield, tick)
end

battlefieldObject.onBattlefieldRegister = function(player, battlefield)
end

battlefieldObject.onBattlefieldEnter = function(player, battlefield)
end

battlefieldObject.onBattlefieldLeave = function(player, battlefield, leavecode)
    if leavecode == xi.battlefield.leaveCode.WON then -- play end CS. Need time and battle id for record keeping + storage
        local _, clearTime, partySize = battlefield:getRecord()

        player:setLocalVar('battlefieldWin', battlefield:getID())

        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar('[cs]bit'))
    elseif leavecode == xi.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

battlefieldObject.onEventUpdate = function(player, csid, option, npc)
end

battlefieldObject.onEventFinish = function(player, csid, option, npc)
    local PuppetmasterBluesProgress = player:getCharVar("PuppetmasterBluesProgress")
    if csid == 32001 and PuppetmasterBluesProgress == 2 then
        player:setCharVar("PuppetmasterBluesProgress", 3)
        player:delKeyItem(xi.ki.TOGGLE_SWITCH) -- BCNM entry trigger
        player:delKeyItem(xi.ki.VALKENGS_MEMORY_CHIP) -- Dont need this anymore
    end

end

return battlefieldObject
