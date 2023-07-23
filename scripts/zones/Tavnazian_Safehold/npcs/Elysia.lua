-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Elysia
-- Starts Quest: Unforgiven
-- !pos -50.410 -22.204 -41.640 26
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 200 then
        player:addQuest(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.UNFORGIVEN)
    elseif csid == 202 then
        player:setCharVar("UnforgivenVar", 1)
    end
end

return entity
