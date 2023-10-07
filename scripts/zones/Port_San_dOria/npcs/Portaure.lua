-----------------------------------
-- Area: Port San d'Oria
--  NPC: Portaure
-----------------------------------
require('scripts/quests/flyers_for_regine')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    quests.ffr.onTrade(player, npc, trade, 3) -- FLYERS FOR REGINE
end

entity.onTrigger = function(player, npc)
    local MirrorMirror = player:getQuestStatus(xi.quest.log_id.JEUNO,xi.quest.id.jeuno.MIRROR_MIRROR)
    local MirrorMirrorProgress = player:getCharVar('[Quest]Mirror_Mirror')
    local fellowParam = xi.fellow_utils.getFellowParam(player)

    if MirrorMirror == QUEST_ACCEPTED and MirrorMirrorProgress == 1 then
        player:startEvent(745,0,0,0,0,0,0,0,fellowParam)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
