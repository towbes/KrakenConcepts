-----------------------------------
-- Area: Windurst Waters
--  NPC: Kerutoto
-- Involved in Quests:
--   Riding on the Clouds
--   Food for Thought
-- !pos 13 -5 -157
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
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
    -- WAKING DREAMS
    if csid == 918 then
        player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.WAKING_DREAMS)
        npcUtil.giveKeyItem(player, xi.ki.VIAL_OF_DREAM_INCENSE)
    elseif csid == 920 then
        local reward = { fame = 0 }

        if option == 1 and not player:hasItem(xi.items.DIABOLOSS_POLE) then
            reward.item = xi.items.DIABOLOSS_POLE
        elseif option == 2 and not player:hasItem(xi.items.DIABOLOSS_EARRING) then
            reward.item = xi.items.DIABOLOSS_EARRING
        elseif option == 3 and not player:hasItem(xi.items.DIABOLOSS_RING) then
            reward.item = xi.items.DIABOLOSS_RING
        elseif option == 4 and not player:hasItem(xi.items.DIABOLOSS_TORQUE) then
            reward.item = xi.items.DIABOLOSS_TORQUE
        elseif option == 5 then
            reward.gil = 15000
        elseif option == 6 and not player:hasSpell(xi.magic.spell.DIABOLOS) then
            player:addSpell(xi.magic.spell.DIABOLOS)
            player:messageSpecial(ID.text.DIABOLOS_UNLOCKED, 0, 0, 0)
        end

        if npcUtil.completeQuest(player, xi.quest.log_id.WINDURST, xi.quest.id.windurst.WAKING_DREAMS, reward) then
            player:delKeyItem(xi.ki.WHISPER_OF_DREAMS)
            player:setCharVar("Darkness_Named_date", getMidnight())
        end
    end
end

return entity
