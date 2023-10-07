-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Maloquedil
-- Involved in Quest : Warding Vampires, Riding on the Clouds, Lure of the Wildcat (San d'Oria)
-- !pos 35 0.1 60 231
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local wildcatSandy = player:getCharVar("WildcatSandy")

    if
        player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and
        not utils.mask.getBit(wildcatSandy, 7)
    then
        player:startEvent(807)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 24 and option == 1 then
        player:addQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.WARDING_VAMPIRES)
    elseif csid == 23 then
        player:tradeComplete()
        player:addTitle(xi.title.VAMPIRE_HUNTER_D_MINUS)
        npcUtil.giveCurrency(player, 'gil', 900)
        if player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.WARDING_VAMPIRES) == QUEST_ACCEPTED then
            player:addFame(xi.quest.fame_area.SANDORIA, 30)
            player:completeQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.WARDING_VAMPIRES)
        else
            player:addFame(xi.quest.fame_area.SANDORIA, 5)
        end
    elseif csid == 807 then
        player:setCharVar('WildcatSandy', utils.mask.setBit(player:getCharVar('WildcatSandy'), 7, true))
    end
end

return entity
