-----------------------------------
-- Area: Windurst Waters
--  NPC: Ohbiru-Dohbiru
-- Involved in quest: Food For Thought, Say It with Flowers
--  Starts and finishes quest: Toraimarai Turmoil
-- !pos 23 -5 -193 238
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/titles")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Windurst_Waters/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    local flowerList =
    {
        [0] = { itemid = 948, gil = 300 }, -- Carnation
        [1] = { itemid = 941, gil = 200 }, -- Red Rose
        [2] = { itemid = 949, gil = 250 }, -- Rain Lily
        [3] = { itemid = 956, gil = 150 }, -- Lilac
        [4] = { itemid = 957, gil = 200 }, -- Amaryllis
        [5] = { itemid = 958, gil = 100 }  -- Marguerite
    }

    -- Check Missions first (priority?)
    local turmoil = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.TORAIMARAI_TURMOIL)

    if csid == 785 and option == 1 then -- Adds Toraimarai turmoil
        player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.TORAIMARAI_TURMOIL)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.RHINOSTERY_CERTIFICATE)
        player:addKeyItem(xi.ki.RHINOSTERY_CERTIFICATE) -- Rhinostery Certificate
    elseif csid == 791 and turmoil == QUEST_ACCEPTED then -- Completes Toraimarai turmoil - first time
        npcUtil.giveCurrency(player, 'gil', 4500)
        player:completeQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.TORAIMARAI_TURMOIL)
        player:addFame(xi.quest.fame_area.WINDURST, 100)
        player:addTitle(xi.title.CERTIFIED_RHINOSTERY_VENTURER)
        player:tradeComplete()
    elseif csid == 791 and turmoil == 2 then -- Completes Toraimarai turmoil - repeats
        npcUtil.giveCurrency(player, 'gil', 4500)
        player:addFame(xi.quest.fame_area.WINDURST, 50)
        player:tradeComplete()
    elseif csid == 516 then
        if option < 7 then
            local choice = flowerList[option]
            if choice and player:getGil() >= choice.gil then
                if player:getFreeSlotsCount() > 0 then
                    player:addItem(choice.itemid)
                    player:messageSpecial(ID.text.ITEM_OBTAINED, choice.itemid)
                    player:delGil(choice.gil)
                    player:needToZone(true)
                else
                    player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, choice.itemid)
                end
            else
                player:messageSpecial(ID.text.NOT_HAVE_ENOUGH_GIL)
            end
        elseif option == 7 then
            player:setCharVar("FLOWER_PROGRESS", 2)
        end
    end
end

return entity
