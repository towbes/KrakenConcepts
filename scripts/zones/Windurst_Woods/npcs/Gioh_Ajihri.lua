-----------------------------------
-- Area: Windurst Woods
--  NPC: Gioh Ajihri
-- Starts & Finishes Repeatable Quest: Twinstone Bonding
-----------------------------------
local ID = require("scripts/zones/Windurst_Woods/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 487 then
        player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.TWINSTONE_BONDING)
        player:setCharVar("GiohAijhriSpokenTo", 1)
    elseif csid == 490 then
        player:confirmTrade()
        player:needToZone(true)
        player:setCharVar("GiohAijhriSpokenTo", 0)

        if player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.TWINSTONE_BONDING) == QUEST_ACCEPTED then
            npcUtil.completeQuest(player, xi.quest.log_id.WINDURST, xi.quest.id.windurst.TWINSTONE_BONDING, { item = 17154, fame = 80, fameArea = xi.quest.fame_area.WINDURST, title = xi.title.BOND_FIXER })
        else
            player:addFame(xi.quest.fame_area.WINDURST, 10)
            npcUtil.giveCurrency(player, 'gil', 900)
        end
    elseif csid == 488 then
        player:setCharVar("GiohAijhriSpokenTo", 1)
    end
end

return entity
