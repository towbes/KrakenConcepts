-----------------------------------
-- Area: Aydeewa Subterrane
--  NPC: Dampsoil
-- Note: Used to spawn Crystal Eater
-- !pos -300 36 -30
-----------------------------------
local ID = zones[xi.zone.AYDEEWA_SUBTERRANE]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local flag = false

    for i = 0, 7 do
        if npcUtil.tradeHasExactly(trade, xi.item.FIRE_CRYSTAL + i) then
            flag = true
        end
    end

    if
        not GetMobByID(ID.mob.CRYSTAL_EATER):isSpawned() and
        flag
    then
        if os.time() > npc:getLocalVar('tradeCooldown') then
            local trades = npc:getLocalVar('trades')

            if trades >= 3 and math.random(1, 100) <= 50 then
                player:messageSpecial(ID.text.MUSHROOM_INTO_MONSTER)
                SpawnMob(ID.mob.CRYSTAL_EATER):updateClaim(player)
                npc:setLocalVar('trades', 0)
            else
                player:messageSpecial(ID.text.MUSHROOM_GROWN_A_BIT)
                npc:setLocalVar('trades', trades + 1)
            end

            npc:setLocalVar('tradeCooldown', os.time() + 4800) -- 1hr 20min until next trade
            player:confirmTrade()

        else
            player:messageSpecial(ID.text.MUSHROOM_NO_MORE_FERT)
        end

    else
        player:messageSpecial(ID.text.NOTHING_HAPPENS)
    end
end

entity.onTrigger = function(player, npc)
    if npc:getLocalVar('trades') == 0 then
        player:messageSpecial(ID.text.MUSHROOM_GROWING_HERE)

    elseif os.time() > npc:getLocalVar('tradeCooldown') then
        player:messageSpecial(ID.text.MUSHROOM_NO_MORE_FERT)

    else
        player:messageSpecial(ID.text.MUSHROOM_GROWING_HERE + 1)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
