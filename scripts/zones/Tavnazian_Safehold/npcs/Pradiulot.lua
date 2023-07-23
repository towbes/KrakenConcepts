-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Pradiulot
-- Involved in Quest: Unforgiven
-- !pos -20.814 -22 8.399 26
-----------------------------------
local ID = require("scripts/zones/Tavnazian_Safehold/IDs")
require("scripts/globals/keyitems")
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
    if csid == 204 then
        player:setCharVar("UnforgivenVar", 2)
        player:addKeyItem(xi.ki.MAP_OF_TAVNAZIA)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.MAP_OF_TAVNAZIA) -- Map of Tavnazia
        player:addExp(2000 * xi.settings.main.EXP_RATE)
        player:addGil(2000 * xi.settings.main.GIL_RATE)
        player:completeQuest(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.UNFORGIVEN)
    elseif csid == 206 then
        player:setCharVar("UnforgivenVar", 0)
    end
end

return entity
