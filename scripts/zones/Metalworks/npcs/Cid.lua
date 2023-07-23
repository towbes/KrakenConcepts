-----------------------------------
-- Area: Metalworks
--  NPC: Cid
-- !pos -12 -12 1 237
-----------------------------------
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 897 then
        player:setCharVar("COP_tenzen_story", 1)
    end
end

return entity
