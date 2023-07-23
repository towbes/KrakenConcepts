-----------------------------------
-- Area: Mhaura
--  NPC: Blandine
-- Start Quest: The Sand Charmz
-- !pos 23 -7 41 249
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
    if csid == 125 then
        player:addQuest(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.THE_SAND_CHARM)
        player:setCharVar("theSandCharmVar", 1)
    elseif csid == 124 then
        player:setCharVar("theSandCharmVar", 3)
    elseif csid == 128 then
        player:setCharVar("SmallDialogByBlandine", 0)
    end
end

return entity
