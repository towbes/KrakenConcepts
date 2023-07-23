-----------------------------------
-- Area: Lower Jeuno
--  NPC: Bluffnix
-- Starts and Finishes Quests: Gobbiebags I-X
-- !pos -43.099 5.900 -114.788 245
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- LURE OF THE WILDCAT
    if
        player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and
        not utils.mask.getBit(player:getCharVar("WildcatJeuno"), 12)
    then
        player:startEvent(10056)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
