-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Eperdur
-- Starts and Finishes Quest: Acting in Good Faith (finish), Healing the Land,
-- !pos 129 -6 96 231
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
local ID = require("scripts/zones/Northern_San_dOria/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 680 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.items.SCROLL_OF_TELEPORT_MEA)
        else
            player:addTitle(xi.title.PILGRIM_TO_MEA)
            player:delKeyItem(xi.ki.GANTINEUXS_LETTER)
            player:addItem(xi.items.SCROLL_OF_TELEPORT_MEA)
            player:messageSpecial(ID.text.ITEM_OBTAINED, xi.items.SCROLL_OF_TELEPORT_MEA) -- Scroll of Teleport-Mea
            player:addFame(xi.quest.fame_area.WINDURST, 30)
            player:completeQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.ACTING_IN_GOOD_FAITH)
        end
    elseif csid == 681 and option == 0 then
        player:addQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.HEALING_THE_LAND)
        player:addKeyItem(xi.ki.SEAL_OF_BANISHING)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.SEAL_OF_BANISHING)
    elseif csid == 683 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.items.SCROLL_OF_TELEPORT_HOLLA)
        else
            player:addTitle(xi.title.PILGRIM_TO_HOLLA)
            player:addItem(xi.items.SCROLL_OF_TELEPORT_HOLLA)
            player:messageSpecial(ID.text.ITEM_OBTAINED, xi.items.SCROLL_OF_TELEPORT_HOLLA) -- Scroll of Teleport-Holla
            player:needToZone(true)
            player:addFame(xi.quest.fame_area.SANDORIA, 30)
            player:completeQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.HEALING_THE_LAND)
        end
    elseif csid == 685 and option == 0 then
        player:addQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.SORCERY_OF_THE_NORTH)
    elseif csid == 687 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.items.SCROLL_OF_TELEPORT_VAHZL)
        else
            player:delKeyItem(xi.ki.FEIYIN_MAGIC_TOME)
            player:addItem(xi.items.SCROLL_OF_TELEPORT_VAHZL)
            player:messageSpecial(ID.text.ITEM_OBTAINED, xi.items.SCROLL_OF_TELEPORT_VAHZL) -- Scroll of Teleport-Vahzl
            player:addFame(xi.quest.fame_area.SANDORIA, 30)
            player:completeQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.SORCERY_OF_THE_NORTH)
        end
    end
end

return entity
