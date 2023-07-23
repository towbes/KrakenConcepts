-----------------------------------
-- Area: Bastok Markets
--  NPC: Michea
-- Starts: Father Figure (100%) | The Elvaan Goldsmith (100%)
-- Involed in: Distant Loyalties
-- !pos -298 -16 -157 235
-----------------------------------
require("scripts/globals/keyitems")
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
    -- DISTANT LOYALTIES
    if csid == 315 then
        player:delKeyItem(xi.ki.GOLDSMITHING_ORDER)
        player:setCharVar("DistantLoyaltiesProgress", 2)
    elseif csid == 317 then
        player:confirmTrade()
        player:setCharVar("DistantLoyaltiesProgress", 3)
        player:needToZone(true)
    elseif csid == 318 then
        player:setCharVar("DistantLoyaltiesProgress", 4)
        npcUtil.giveKeyItem(player, xi.ki.MYTHRIL_HEARTS)
    end
end

return entity
