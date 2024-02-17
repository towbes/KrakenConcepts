-----------------------------------
-- Area: Mount Zhayolm
--  NPC: ??? (Puppetmaster Blues Quest)
-- !pos 760.798 -14.972 1.656
-----------------------------------
local ID = zones[xi.zone.MOUNT_ZHAYOLM]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local PuppetmasterBluesProgress = player:getCharVar("PuppetmasterBluesProgress")

    player:messageSpecial(7541) -- always displays

    if (PuppetmasterBluesProgress == 2 and not player:hasKeyItem(xi.ki.TOGGLE_SWITCH)) then
        player:addKeyItem(xi.ki.TOGGLE_SWITCH)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.TOGGLE_SWITCH)
    end

end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
