-----------------------------------
-- Area: Norg
--  NPC: Stray Cloud
-- Starts and Ends Quest: An Undying Pledge
-- !pos-20.617, 1.097, -29.165, 133
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 225 then
        player:addQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.AN_UNDYING_PLEDGE)
        player:setCharVar("anUndyingPledgeCS", 1)
    elseif
        csid == 227 and
        npcUtil.completeQuest(player, xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.AN_UNDYING_PLEDGE, {
            item = 12375,
            fameArea = xi.quest.fame_area.NORG,
            fame = 50,
            var = "anUndyingPledgeCS",
        })
    then
        player:delKeyItem(xi.ki.CALIGINOUS_BLADE)
    end
end

return entity
