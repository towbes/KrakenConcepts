-----------------------------------
-- Area: Upper Jeuno
--  NPC: Bheem
-----------------------------------
local ID = zones[xi.zone.UPPER_JEUNO]
require('scripts/globals/pets/fellow')
require('scripts/globals/fellow_utils')
require('scripts/globals/quests')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    print('hit')
    local UnlistedQualities = player:getQuestStatus(xi.quest.log_id.JEUNO,xi.quest.id.jeuno.UNLISTED_QUALITIES)
    local UnlistedQualitiesProgress = player:getCharVar('[Quest]Unlisted_Qualities')
    local LookingGlass = player:getQuestStatus(xi.quest.log_id.JEUNO,xi.quest.id.jeuno.GIRL_IN_THE_LOOKING_GLASS)
    local LookingGlassProgress = player:getCharVar('[Quest]Looking_Glass')
    local fellowParam = 0
    if UnlistedQualities >= QUEST_ACCEPTED and (UnlistedQualitiesProgress >= 7 or UnlistedQualitiesProgress == 0) then
        fellowParam = xi.fellow_utils.getFellowParam(player)
    end

    if UnlistedQualities == QUEST_ACCEPTED and UnlistedQualitiesProgress < 7 then
        player:startEvent(10037)
    elseif UnlistedQualities == QUEST_ACCEPTED and UnlistedQualitiesProgress == 7 then
        player:startEvent(10171,0,0,0,0,0,0,0,fellowParam)
    elseif LookingGlass == QUEST_ACCEPTED and LookingGlassProgress == 1 then
        player:startEvent(10040,244,0,0,0,0,0,0,fellowParam)
    else
        player:startEvent(157)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
