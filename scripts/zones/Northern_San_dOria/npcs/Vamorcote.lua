-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Vamorcote
-- Starts and Finishes Quest: The Setting Sun
-- !pos -137.070 10.999 161.855 231
-----------------------------------
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
    if csid == 654 and option == 1 then --Player accepts the quest
        player:addQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_SETTING_SUN)
    elseif csid == 658 then --The player trades the Engraved Key to the NPC. Here come the rewards!
        player:tradeComplete()
        npcUtil.giveCurrency(player, 'gil', 10000)
        player:addFame(xi.quest.fame_area.SANDORIA, 30)
        player:completeQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_SETTING_SUN)
    end
end

return entity
