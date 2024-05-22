-----------------------------------
-- Area: Stellar Fulcrum
--  NPC: Qe'Lov Gate
-----------------------------------
require('scripts/globals/bcnm')
require('scripts/globals/missions')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.bcnm.onTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
