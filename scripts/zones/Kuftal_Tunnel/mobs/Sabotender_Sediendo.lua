-----------------------------------
-- Area: Kuftal Tunnel
--  Mob: Sabotender Sediendo
-- Note: Place Holder for Sabotender Mariachi
-----------------------------------
local ID = zones[xi.zone.KUFTAL_TUNNEL]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 738, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.SABOTENDER_MARIACHI_PH, 5, 10800) -- 3 hour minimum
end

return entity
