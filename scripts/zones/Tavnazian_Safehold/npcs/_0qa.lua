-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: walnut door
-- Involved in mission 2-4
-- !pos 111 -41 41 26
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
    if csid == 543 then
        player:setCharVar("PromathiaStatus", 6)
    end
end

return entity
