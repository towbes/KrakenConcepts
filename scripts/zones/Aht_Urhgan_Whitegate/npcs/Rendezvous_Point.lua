-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Rendezvous Point
-- For interacting with Adventuring Fellow
-----------------------------------
local ID = zones[xi.zone.AHT_URHGAN_WHITEGATE]
require("scripts/globals/rendezvous_points")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.rendezvousPoints.onTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
    xi.rendezvousPoints.onEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.rendezvousPoints.onEventFinish(player, csid, option)
end

return entity
