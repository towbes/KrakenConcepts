-----------------------------------
-- Area: Bibiki Bay
--  NPC: Warmachine
-- !pos -345.236 -3.188 -976.563 4
-----------------------------------
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Bibiki_Bay/IDs")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 43 then
        local coloredDropID = player:getCharVar("ColoredDrop")
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, coloredDropID)
        else
            player:addItem(coloredDropID)
            player:messageSpecial(ID.text.ITEM_OBTAINED, coloredDropID)
            player:setCharVar("COP_3-taru_story", 2)
            player:setCharVar("ColoredDrop", 0)
        end
    end
end

return entity
