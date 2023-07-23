-----------------------------------
-- Area: Windurst Waters
--  NPC: Gantineux
-- Starts Quest: Acting in Good Faith
-- !pos -83 -9 3 238
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/shop")
require("scripts/globals/quests")
local ID = require("scripts/zones/Windurst_Waters/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if
        player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.ACTING_IN_GOOD_FAITH) == QUEST_COMPLETED
    then
        player:startEvent(10023) -- New standard dialog after "Acting in Good Faith"
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 10019 and option == 0 then
        player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.ACTING_IN_GOOD_FAITH)
        player:addKeyItem(xi.ki.SPIRIT_INCENSE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.SPIRIT_INCENSE)
    elseif csid == 10021 then
        player:addKeyItem(xi.ki.GANTINEUXS_LETTER)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.GANTINEUXS_LETTER)
    end
end

return entity
