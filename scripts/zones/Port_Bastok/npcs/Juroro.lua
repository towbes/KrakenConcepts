-----------------------------------
-- Area: Port Bastok
--  NPC: Juroro
-- Starts and Finishes Quest: Trial by Earth
-- !pos 32 7 -41 236
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/quests")
local ID = require("scripts/zones/Port_Bastok/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local trialByEarth = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.TRIAL_BY_EARTH)
    local hasWhisperOfTremors = player:hasKeyItem(xi.ki.WHISPER_OF_TREMORS)

    if
        (trialByEarth == QUEST_AVAILABLE and player:getFameLevel(xi.quest.fame_area.BASTOK) >= 6) or
        (trialByEarth == QUEST_COMPLETED and os.time() > player:getCharVar("TrialByEarth_date"))
    then
        player:startEvent(249, 0, xi.ki.TUNING_FORK_OF_EARTH) -- Start and restart quest "Trial by Earth"
    elseif
        trialByEarth == QUEST_ACCEPTED and
        not player:hasKeyItem(xi.ki.TUNING_FORK_OF_EARTH) and
        not hasWhisperOfTremors
    then
        player:startEvent(284, 0, xi.ki.TUNING_FORK_OF_EARTH) -- Defeat against Titan : Need new Fork
    elseif trialByEarth == QUEST_ACCEPTED and not hasWhisperOfTremors then
        player:startEvent(250, 0, xi.ki.TUNING_FORK_OF_EARTH, 1)
    elseif trialByEarth == QUEST_ACCEPTED and hasWhisperOfTremors then
        local numitem = 0

        if player:hasItem(17438) then
            numitem = numitem + 1
        end  -- Titan's Cudgel

        if player:hasItem(13244) then
            numitem = numitem + 2
        end  -- Earth Belt

        if player:hasItem(13563) then
            numitem = numitem + 4
        end  -- Earth Ring

        if player:hasItem(1205) then
            numitem = numitem + 8
        end   -- Desert Light

        if player:hasSpell(299) then
            numitem = numitem + 32
        end  -- Ability to summon Titan

        player:startEvent(252, 0, xi.ki.TUNING_FORK_OF_EARTH, 1, 0, numitem)
    else
        player:startEvent(253)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
