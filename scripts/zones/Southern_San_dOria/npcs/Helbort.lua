-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Helbort
--  Starts and Finished Quest: A purchase of Arms
-- !pos 71 -1 65 230
-----------------------------------
local ID = zones[xi.zone.SOUTHERN_SAN_DORIA]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 594 and option == 0 then
        player:addQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.A_PURCHASE_OF_ARMS)
        player:addKeyItem(xi.ki.WEAPONS_ORDER)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.WEAPONS_ORDER)
    elseif csid == 607 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.ELM_STAFF)
        else
            player:addTitle(xi.title.ARMS_TRADER)
            player:delKeyItem(xi.ki.WEAPONS_RECEIPT)
            player:addItem(xi.item.ELM_STAFF)
            player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.ELM_STAFF)
            player:addFame(xi.quest.fame_area.SANDORIA, 30)
            player:completeQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.A_PURCHASE_OF_ARMS)
        end
    end
end

return entity
