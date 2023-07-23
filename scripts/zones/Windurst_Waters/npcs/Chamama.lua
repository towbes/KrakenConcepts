-----------------------------------
-- Area: Windurst Waters
--  NPC: Chamama
-- Involved In Quest: Inspector's Gadget
-- Starts Quest: In a Pickle
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/quests")
require("scripts/globals/keyitems")
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
    if csid == 654 and option == 1 then -- IN A PICKLE + RARAB TAIL: Quest Begin
        player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.IN_A_PICKLE)
    elseif csid == 659 then -- IN A PICKLE: Quest Turn In (1st Time)
        player:tradeComplete()
        player:completeQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.IN_A_PICKLE)
        player:needToZone(true)
        player:addItem(xi.items.BONE_HAIRPIN)
        player:messageSpecial(ID.text.ITEM_OBTAINED, xi.items.BONE_HAIRPIN)
        npcUtil.giveCurrency(player, 'gil', 200)
        player:addFame(xi.quest.fame_area.WINDURST, 75)
    elseif csid == 661 and option == 1 then
        player:setCharVar("QuestInAPickle_var", 1)
    elseif csid == 662 then -- IN A PICKLE + 200 GIL: Repeatable Quest Turn In
        player:tradeComplete()
        player:needToZone(true)
        player:addGil(xi.settings.main.GIL_RATE * 200)
        player:addFame(xi.quest.fame_area.WINDURST, 8)
        player:setCharVar("QuestInAPickle_var", 0)
    end
end

return entity
