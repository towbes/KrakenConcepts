-----------------------------------
-- Area: Lower Jeuno
--  NPC: Ghebi Damomohe
-- Type: Standard Merchant
-- Starts and Finishes Quest: Tenshodo Membership
-- !pos 16 0 -5 245
-----------------------------------
local lowerJeunoID = zones[xi.zone.LOWER_JEUNO]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local astralCovenantCD = player:getCharVar('[ENM]AstralCovenant')

    if
        npcUtil.tradeHas(trade, xi.item.FLORID_STONE) and
        player:hasKeyItem(xi.ki.PSOXJA_PASS) and
        astralCovenantCD < os.time()
    then
        player:startEvent(10047, 1782)
        player:confirmTrade()

    elseif
        trade:getItemQty(xi.item.TENSHODO_INVITE) > 0 and
        player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.TENSHODO_MEMBERSHIP) ~= QUEST_COMPLETED
    then
        if player:getFreeSlotsCount() > 0 then
            if npcUtil.tradeHas(trade, xi.item.TENSHODO_INVITE) then
                -- Finish Quest: Tenshodo Membership (Invitation)
                player:startEvent(108)
            end
        else
            player:messageSpecial(lowerJeunoID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.TENSHODO_INVITE)
        end
    end
end

entity.onTrigger = function(player, npc)
    local astralCovenantCD = player:getCharVar('[ENM]AstralCovenant')

    if
        player:hasKeyItem(xi.ki.PSOXJA_PASS) and
        astralCovenantCD < VanadielTime()
    then
        player:startEvent(106, 4, 1, 1782, 604)
    elseif
        player:hasKeyItem(xi.ki.PSOXJA_PASS) and
        astralCovenantCD >= VanadielTime()
    then
        player:startEvent(106, 4, 2, 675, astralCovenantCD)
    elseif
        player:hasKeyItem(xi.ki.ASTRAL_COVENANT)
    then
        player:startEvent(106, 4)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 106 and option == 0 then
        local stock =
        {
            4405,  144, -- Rice Ball
            4457, 2700, -- Eel Kabob
            4467,    3, -- Garlic Cracker
        }

        xi.shop.general(player, stock, xi.quest.fame_area.NORG)

    elseif csid == 108 then
        player:completeQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.TENSHODO_MEMBERSHIP)
        npcUtil.giveKeyItem(player, xi.ki.TENSHODO_MEMBERS_CARD)
        player:setTitle(xi.title.TENSHODO_MEMBER)

    elseif csid == 10047 then
        player:setCharVar('[ENM]AstralCovenant', VanadielTime() + (xi.settings.main.ENM_COOLDOWN * 3600)) -- Current time + (ENM_COOLDOWN*1hr in seconds)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.ASTRAL_COVENANT)
        player:addKeyItem(xi.ki.ASTRAL_COVENANT)
    end
end

return entity
