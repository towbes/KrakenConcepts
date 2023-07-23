-----------------------------------
-- Area: Port Windurst
--  NPC: Chipmy-Popmy
-----------------------------------
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 619 then
        player:setCharVar("COP_3-taru_story", 1)
    end
end

return entity
