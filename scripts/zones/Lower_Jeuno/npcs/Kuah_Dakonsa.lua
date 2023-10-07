-----------------------------------
-- Area: Lower Jeuno
--  NPC: Kuah Dakonsa
-- !pos -42 0 -65 245
-----------------------------------
local ID = zones[xi.zone.LOWER_JEUNO]
require('scripts/globals/quests')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local FellowQuest = player:getCharVar('[Quest]Unlisted_Qualities')
    if (player:getQuestStatus(xi.quest.log_id.JEUNO,xi.quest.id.jeuno.UNLISTED_QUALITIES) == QUEST_ACCEPTED and utils.mask.getBit(FellowQuest,2) == false) then
        player:startEvent(20000,0,0,0,0,0,0,0,player:getFellowValue('fellowid'))
    else
        player:startEvent(190)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
