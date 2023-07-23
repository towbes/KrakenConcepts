-----------------------------------
-- Area: Al'Taieu
--  NPC: Crystalline Field
-- !pos .1 -10 -464 33
-----------------------------------
local ID = require("scripts/zones/AlTaieu/IDs")
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
    if csid == 100 and option == 1 then
        player:setPos(-20, 0.624, -355, 191, 34) -- (R)
    elseif csid == 164 then
        player:setCharVar("PromathiaStatus", 2)
    end
end

return entity
