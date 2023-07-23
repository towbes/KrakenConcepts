-----------------------------------
-- Area: Sea Serpent Grotto
--  NPC: qm5 (???)
-- Quests: An Undying Pledge
-- !pos 135 -9 220
-----------------------------------
local ID = require("scripts/zones/Sea_Serpent_Grotto/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 18 then
        npcUtil.giveKeyItem(player, xi.ki.CALIGINOUS_BLADE)
        player:setCharVar("anUndyingPledgeCS", 3)
        player:setCharVar("anUndyingPledgeNM_killed", 0)
    end
end

return entity
