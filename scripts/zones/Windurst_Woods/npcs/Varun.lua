-----------------------------------
-- Area: Windurst Woods
--  NPC: Varun
-- Type: Standard NPC
-- !pos 7.800 -3.5 -10.064 241
-----------------------------------
require("scripts/globals/npc_util")
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
    if csid == 100 then
        player:setCharVar("rockracketeer_sold", 4)
    elseif csid == 101 then
        player:setCharVar("rockracketeer_sold", 5)
    elseif
        csid == 102 and
        npcUtil.completeQuest(player, xi.quest.log_id.WINDURST, xi.quest.id.windurst.ROCK_RACKETEER, { gil = 2100, var = "rockracketeer_sold" })
    then
        player:confirmTrade()
    end
end

return entity
