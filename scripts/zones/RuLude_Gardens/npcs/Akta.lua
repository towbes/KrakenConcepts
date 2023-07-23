-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Akta
-----------------------------------
local ID = require("scripts/zones/RuLude_Gardens/IDs")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local FellowQuest = player:getCharVar("[Quest]Unlisted_Qualities")
    if player:getQuestStatus(xi.quest.log_id.JEUNO,xi.quest.id.jeuno.UNLISTED_QUALITIES) == QUEST_ACCEPTED and utils.mask.getBit(FellowQuest,0) == false then
        player:startEvent(10103,0,0,0,0,0,0,0,player:getFellowValue("fellowid"))
    else
        player:startEvent(116)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
