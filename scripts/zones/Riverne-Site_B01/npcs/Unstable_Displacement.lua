-----------------------------------
-- Area: Riverne Site #B01
--  NPC: Unstable Displacement
-- Note: entrance for 'Storms of Fate' and 'The Wyrmking Descends'
-- !pos -612.800 1.750 693.190 29
-----------------------------------
local ID = zones[xi.zone.RIVERNE_SITE_B01]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.bcnm.onTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if not xi.bcnm.onTrigger(player, npc) then
        player:messageSpecial(ID.text.SPACE_SEEMS_DISTORTED)
    end
end

entity.onEventUpdate = function(player, csid, option, extras)
    xi.bcnm.onEventUpdate(player, csid, option, extras)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.bcnm.onEventFinish(player, csid, option, npc)
end

return entity
