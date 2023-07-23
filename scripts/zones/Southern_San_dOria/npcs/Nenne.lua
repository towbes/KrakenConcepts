-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Nenne
-- Starts and Finishes Quest: To Cure a Cough
-- !pos -114 -6 102 230
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/keyitems")
require("scripts/globals/shop")
require("scripts/globals/quests")
local ID = require("scripts/zones/Southern_San_dOria/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 538 then
        player:setCharVar("toCureaCough", 1)
    elseif csid == 647 then
        player:addTitle(xi.title.A_MOSS_KIND_PERSON)
        player:setCharVar("toCureaCough", 0)
        player:delKeyItem(xi.ki.COUGH_MEDICINE)
        player:addKeyItem(xi.ki.SCROLL_OF_TREASURE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.SCROLL_OF_TREASURE)
        player:addFame(xi.quest.fame_area.SANDORIA, 30)
        player:completeQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.TO_CURE_A_COUGH)
    end
end

return entity
