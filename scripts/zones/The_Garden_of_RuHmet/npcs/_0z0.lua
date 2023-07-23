-----------------------------------
-- Area: The_Garden_of_RuHmet
--  NPC: _0z0
-----------------------------------
require("scripts/globals/missions")
require("scripts/globals/keyitems")
require("scripts/globals/bcnm")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.bcnm.onTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.bcnm.onTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option, extras)
    xi.bcnm.onEventUpdate(player, csid, option, extras)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 203 then
        player:setCharVar("PromathiaStatus", 4)
    else
        xi.bcnm.onEventFinish(player, csid, option, npc)
    end
end

return entity
