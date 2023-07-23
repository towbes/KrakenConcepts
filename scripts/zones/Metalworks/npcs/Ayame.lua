-----------------------------------
-- Area: Metalworks
--  NPC: Ayame
-- !pos 133 -19 34 237
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCharVar("FadedPromises") == 1 then
        player:startEvent(803)
    elseif player:getCharVar("FadedPromises") == 3 then
        player:startEvent(804)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
