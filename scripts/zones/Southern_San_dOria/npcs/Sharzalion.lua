-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Sharzalion
-- !pos 95 0 111 230
-----------------------------------
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
    if csid == 64 then
        player:setCharVar("peaceForTheSpiritCS", 1)
    elseif csid == 66 then
        player:setCharVar("peaceForTheSpiritCS", 3)
    end
end

return entity
