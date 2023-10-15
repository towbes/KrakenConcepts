-----------------------------------
-- Area: Southern San d'Oria
-- NPC : Amaura
-- Involved in Quest: The Medicine Woman, To Cure a Cough
-- !pos -85 -6 89 230
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
    if csid == 645 then
        player:addQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.TO_CURE_A_COUGH)
    elseif csid == 646 then
        player:delKeyItem(xi.ki.THYME_MOSS)
        player:addKeyItem(xi.ki.COUGH_MEDICINE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.COUGH_MEDICINE)
    end
end

return entity
