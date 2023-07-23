-----------------------------------
-- Area: The Garden of RuHmet
--  NPC: Ebon_Panel
-- !pos 100.000 -5.180 -337.661 35 | Mithra Tower
-- !pos 740.000 -5.180 -342.352 35 | Elvaan Tower
-- !pos 257.650 -5.180 -699.999 35 | Tarutaru Tower
-- !pos 577.648 -5.180 -700.000 35 | Galka Tower
-- !pos 422.351 -5.180 -100.000 35 | Hume Tower
-----------------------------------
local ID = require("scripts/zones/The_Garden_of_RuHmet/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
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
    if csid == 202 then
        player:setCharVar("PromathiaStatus", 2)
    elseif csid == 124 and option ~= 0 then -- Mithra
        player:addTitle(xi.title.WARRIOR_OF_THE_CRYSTAL)
        player:setCharVar("PromathiaStatus", 3)
        player:addKeyItem(xi.ki.LIGHT_OF_DEM)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.LIGHT_OF_DEM)
    elseif csid == 121 and option ~= 0 then -- Elvaan
        player:addTitle(xi.title.WARRIOR_OF_THE_CRYSTAL)
        player:setCharVar("PromathiaStatus", 3)
        player:addKeyItem(xi.ki.LIGHT_OF_MEA)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.LIGHT_OF_MEA)
    elseif csid == 123 and option ~= 0 then -- Tarutaru
        player:addTitle(xi.title.WARRIOR_OF_THE_CRYSTAL)
        player:setCharVar("PromathiaStatus", 3)
        player:addKeyItem(xi.ki.LIGHT_OF_HOLLA)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.LIGHT_OF_HOLLA)
    elseif csid == 122 and option ~= 0 then -- Galka
        player:addTitle(xi.title.WARRIOR_OF_THE_CRYSTAL)
        player:setCharVar("PromathiaStatus", 3)
        player:addKeyItem(xi.ki.LIGHT_OF_ALTAIEU)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.LIGHT_OF_ALTAIEU)
    end
end

return entity
