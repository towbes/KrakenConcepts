-----------------------------------
-- Area: Metalworks
--  NPC: Alois
-- Involved in Missions: Wading Beasts
-- !pos 96 -20 14 237
-----------------------------------
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCharVar("FadedPromises") == 4 then
        player:startEvent(805)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
