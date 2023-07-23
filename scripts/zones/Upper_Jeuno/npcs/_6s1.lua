-----------------------------------
-- Area: Upper Jeuno
--  NPC: Marble Bridge Eatery (Door)
-- !pos -96.6 -0.2 92.3 244
-----------------------------------
local ID = require("scripts/zones/Upper_Jeuno/IDs")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
    if
        (csid == 84 or csid == 204) and
        option == 4
    then
        player:updateEvent(ring[1], ring[2], ring[3])
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 129 then
        player:setCharVar("PromathiaStatus", 5)
    elseif
        (csid == 84 or csid == 204) and
        option >= 5 and
        option <= 7
    then
        if player:getFreeSlotsCount() ~= 0 then
            local currentDay = tonumber(os.date("%j"))
            local ringsTaken = player:getCharVar("COP-ringsTakenbr")
            player:addItem(ring[option - 4])
            player:messageSpecial(ID.text.ITEM_OBTAINED, ring[option - 4])
            player:setCharVar("COP-ringsTakenbr", ringsTaken + 1)
            player:setCharVar("COP-lastRingday", currentDay)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, ring[option - 4])
        end
    end
end

return entity
