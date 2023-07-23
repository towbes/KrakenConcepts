-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Hinaree
-- Type: Standard NPC
-- !pos -301.535 -10.199 97.698 230
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
    if csid == 757 then
        player:setCharVar("COP_louverance_story", 1)
    end
end

return entity
