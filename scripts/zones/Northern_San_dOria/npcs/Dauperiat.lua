-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Dauperiat
-- Starts and Finishes Quest: Blackmail (R)
-- !zone 231
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/keyitems")
require("scripts/globals/shop")
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
    if csid == 643 then
        player:addQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.BLACKMAIL)
        player:addKeyItem(xi.ki.SUSPICIOUS_ENVELOPE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.SUSPICIOUS_ENVELOPE)
    elseif csid == 646 and option == 1 then
        player:setCharVar("BlackMailQuest", 2)
    elseif csid == 648 then
        player:tradeComplete()
        npcUtil.giveCurrency(player, 'gil', 900)
        if player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.BLACKMAIL) == QUEST_ACCEPTED then
            player:addFame(xi.quest.fame_area.SANDORIA, 30)
            player:completeQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.BLACKMAIL)
        else
            player:addFame(xi.quest.fame_area.SANDORIA, 5)
        end
    elseif csid == 40 and option == 1 then
        player:addQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.BLACKMAIL)
    end
end

return entity
