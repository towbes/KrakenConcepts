-----------------------------------
-- Area: Windurst Waters
--  NPC: Mashuu-Ajuu
-- Starts and Finished Quest: Reap What You Sow
-- Involved in Quest: Making the Grade
-- !pos 129 -6 167 238
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(429)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if
        ((csid == 463 and option == 3) or (csid == 479 and option == 3)) and
        player:getFreeSlotsCount() == 0
    then
        -- REAP WHAT YOU SOW + HERB SEEDS: QUEST START - ACCEPTED - INVENTORY FULL
        player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.items.BAG_OF_HERB_SEEDS)
    elseif csid == 463 and option == 3 then                      -- REAP WHAT YOU SOW + HERB SEEDS: QUEST START - ACCEPTED
        player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.REAP_WHAT_YOU_SOW)
        player:addItem(xi.items.BAG_OF_HERB_SEEDS)
        player:messageSpecial(ID.text.ITEM_OBTAINED, xi.items.BAG_OF_HERB_SEEDS)
    elseif
        (csid == 475 or csid == 477) and
        player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.REAP_WHAT_YOU_SOW) == QUEST_ACCEPTED and
        player:getFreeSlotsCount() == 0
    then
        -- inventory full on quest turn in
        player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.items.STATIONERY_SET)
    elseif csid == 475 then                                -- REAP WHAT YOU SOW + 500 GIL: Quest Turn In: Sobbing Fungus turned in
        player:addGil(xi.settings.main.GIL_RATE * 500)
        player:tradeComplete()
        player:needToZone(true)
        if player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.REAP_WHAT_YOU_SOW) == QUEST_ACCEPTED then
            player:completeQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.REAP_WHAT_YOU_SOW)
            player:addFame(xi.quest.fame_area.WINDURST, 75)
            player:addItem(xi.items.STATIONERY_SET)
            player:messageSpecial(ID.text.ITEM_OBTAINED, xi.items.STATIONERY_SET)
        elseif player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.REAP_WHAT_YOU_SOW) == QUEST_COMPLETED then
            player:addFame(xi.quest.fame_area.WINDURST, 8)
            player:setCharVar("QuestReapSow_var", 0)
        end
    elseif csid == 477 then                                -- REAP WHAT YOU SOW + GIL + Stationary Set: Quest Turn In: Deathball turned in
        player:addGil(xi.settings.main.GIL_RATE * 700)
        player:tradeComplete()
        player:needToZone(true)
        if player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.REAP_WHAT_YOU_SOW) == QUEST_ACCEPTED then
            player:completeQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.REAP_WHAT_YOU_SOW)
            player:addFame(xi.quest.fame_area.WINDURST, 75)
            player:addItem(xi.items.STATIONERY_SET)
            player:messageSpecial(ID.text.ITEM_OBTAINED, xi.items.STATIONERY_SET)
        elseif player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.REAP_WHAT_YOU_SOW) == QUEST_COMPLETED then
            player:addFame(xi.quest.fame_area.WINDURST, 8)
            player:setCharVar("QuestReapSow_var", 0)
        end
    elseif csid == 479 and option == 3 then                 -- REAP WHAT YOU SOW + HERB SEEDS: REPEATABLE QUEST START - ACCEPTED
        player:setCharVar("QuestReapSow_var", 1)
        player:addItem(xi.items.BAG_OF_HERB_SEEDS)
        player:messageSpecial(ID.text.ITEM_OBTAINED, xi.items.BAG_OF_HERB_SEEDS)
    end
end

return entity
