-----------------------------------
-- Area: Selbina
--  NPC: Oswald
-- Starts and Finishes Quest: Under the sea (finish), The gift, The real gift
-- !pos 48 -15 9 248
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 32 then
        player:setCharVar("underTheSeaVar", 2)
    elseif
        csid == 37 and
        npcUtil.completeQuest(player, xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.UNDER_THE_SEA, { item = 13335, fame_area = xi.quest.fame_area.SELBINA_RABAO, title = xi.title.LIL_CUPID, var = "underTheSeaVar" })
    then
        player:delKeyItem(xi.ki.ETCHED_RING)
    elseif csid == 70 and option == 50 then
        player:addQuest(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.THE_GIFT)
    elseif
        csid == 72 and
        npcUtil.completeQuest(player, xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.THE_GIFT, { item = 16497, fame_area = xi.quest.fame_area.SELBINA_RABAO, title = xi.title.SAVIOR_OF_LOVE })
    then
        player:confirmTrade()
    elseif csid == 73 and option == 50 then
        player:addQuest(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.THE_REAL_GIFT)
    elseif
        csid == 75 and
        npcUtil.completeQuest(player, xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.THE_REAL_GIFT, { item = 17385, fame_area = xi.quest.fame_area.SELBINA_RABAO, title = xi.title.THE_LOVE_DOCTOR })
    then
        player:confirmTrade()
    end
end

return entity
