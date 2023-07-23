-----------------------------------
-- Area: Selbina
--  NPC: Jimaida
-- Involved in Quests: Under the sea
-- !pos -15 -2 -16 248
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 33 then
        player:setCharVar("underTheSeaVar", 3)
    end
end

return entity
