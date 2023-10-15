-----------------------------------
-- Area: Grauberg [S]
--  NPC: Fay Spring
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeHasExactly(trade, 2525) then 
        player:tradeComplete()
        -- Increase global server amity
        local amity = GetServerVariable('PixieAmity')
        if amity < 255 then
            amity = amity + 10
            SetServerVariable('PixieAmity', utils.clamp(amity, -255, 255))
        end
        local hate = player:getCharVar('PIXIE_HATE')
		hate = hate - 5
		player:setPixieHate(utils.clamp(hate, 0, 60))
        player:startEvent(501, 0, 0, 0, 2)
    end

end

entity.onTrigger = function(player, npc)
    player:startEvent(501, 0, 0, 0, 1)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
