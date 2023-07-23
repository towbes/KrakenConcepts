-----------------------------------
-- Area: The Garden of Ru'Hmet
--  NPC: particle gate
-----------------------------------
local ID = require("scripts/zones/The_Garden_of_RuHmet/IDs")
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 111 and option == 1 then
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.BRAND_OF_TWILIGHT)
        player:addKeyItem(xi.ki.BRAND_OF_TWILIGHT)
    end
end

return entity
