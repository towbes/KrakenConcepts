-----------------------------------
-- Area: Metalworks
--  NPC: Romualdo
-- Involved in Quest: Stamp Hunt
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local fadedPromises = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.FADED_PROMISES)

    if
        fadedPromises == QUEST_AVAILABLE and
        player:getMainJob() == xi.job.NIN and
        player:getMainLvl() >= 20 and
        player:getFameLevel(xi.quest.fame_area.NORG) >= 4
    then
        player:startEvent(802)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
