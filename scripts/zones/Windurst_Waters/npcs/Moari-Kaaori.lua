-----------------------------------
-- Area: Windurst Waters
--  NPC: Moari-Kaaori
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
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
    if csid == 514 and option == 1 then
        player:setCharVar("FLOWER_PROGRESS", 1)
        player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.SAY_IT_WITH_FLOWERS)
    elseif csid == 520 then -- First completion, Iron Sword awarded.
        if player:getFreeSlotsCount() > 0 then
            player:tradeComplete()
            player:addItem(xi.items.IRON_SWORD)
            player:completeQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.SAY_IT_WITH_FLOWERS)
            player:addFame(xi.quest.fame_area.WINDURST, 30)
            player:messageSpecial(ID.text.ITEM_OBTAINED, xi.items.IRON_SWORD)
            player:setCharVar("FLOWER_PROGRESS", 0)
            player:needToZone(true)
            player:setTitle(xi.title.CUPIDS_FLORIST)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.items.IRON_SWORD)
        end
    elseif csid == 522 then -- Wrong flowers so complete quest, but smaller reward/fame and no title.
        player:completeQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.SAY_IT_WITH_FLOWERS)
        player:tradeComplete()
        npcUtil.giveCurrency(player, 'gil', 100)
        player:addFame(xi.quest.fame_area.WINDURST, 10)
        player:needToZone(true)
        player:setCharVar("FLOWER_PROGRESS", 0)
    elseif csid == 523 then
        player:setCharVar("FLOWER_PROGRESS", 1)
    elseif csid == 525 then -- Repeatable quest rewards.
        player:tradeComplete()
        player:addFame(xi.quest.fame_area.WINDURST, 30)
        player:addGil(xi.settings.main.GIL_RATE * 400)
        player:setCharVar("FLOWER_PROGRESS", 0)
        player:needToZone(true)
        player:setTitle(xi.title.CUPIDS_FLORIST)
    end
end

return entity
