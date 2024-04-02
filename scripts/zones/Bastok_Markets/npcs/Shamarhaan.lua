-----------------------------------
-- Area: Bastok Markets
--  NPC: Shamarhaan
-- Involved in quest: No Strings Attached
-- !pos -285.382 -13.021 -84.743 235
-----------------------------------
local ID = zones[xi.zone.BASTOK_MARKETS]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local PuppetmasterBlues = player:getQuestStatus(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.PUPPETMASTER_BLUES)
    local PuppetmasterBluesProgress = player:getCharVar("PuppetmasterBluesProgress")
    if (PuppetmasterBluesProgress == 1) then
        player:startEvent(437) -- cs - asks player to help Iruki-Waraki
    elseif (PuppetmasterBluesProgress == 2) then
        player:startEvent(438) -- reminds players to get a toggle switch and go to Talacca Cove
    elseif (PuppetmasterBluesProgress == 3) then
        player:startEvent(439) -- cs - Post Talacca Cove win, sends player to Iruki-Waraki
    elseif (PuppetmasterBluesProgress == 4) then
        player:startEvent(440) -- reminds player to go to Iruki-Waraki
    elseif (NoStringsAttached == QUEST_COMPLETE) then
        player:startEvent(436) -- encourages you
    else
        player:startEvent(433) -- acts indifferent to you
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if (csid == 437) then -- No matter what the player chooses, this CS returns option 0
        player:setCharVar("PuppetmasterBluesProgress", 2)
        player:addKeyItem(xi.ki.VALKENGS_MEMORY_CHIP)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.VALKENGS_MEMORY_CHIP)
    elseif (csid == 439) then
        player:setCharVar("PuppetmasterBluesProgress", 4)
    end
end

return entity
