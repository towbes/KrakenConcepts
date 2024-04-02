-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Pagisalis
-- Involved In Quest: Enveloped in Darkness
-- !zone 231
-----------------------------------
local ID = zones[xi.zone.NORTHERN_SAN_DORIA]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 562 and option == 0 then
        player:addQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.UNDYING_FLAMES)
    elseif csid == 563 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.FRIARS_ROPE)
        else
            player:tradeComplete()
            player:addTitle(xi.title.FAITH_LIKE_A_CANDLE)
            player:addItem(xi.item.FRIARS_ROPE)
            player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.FRIARS_ROPE)
            player:addFame(xi.quest.fame_area.SANDORIA, 30)
            player:completeQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.UNDYING_FLAMES)
        end
    end
end

return entity
