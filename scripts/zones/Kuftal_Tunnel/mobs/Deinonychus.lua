-----------------------------------
-- Area: Kuftal Tunnel
--  Mob: Deinonychus
-- Note: Place Holder for Yowie
-----------------------------------
local ID = zones[xi.zone.KUFTAL_TUNNEL]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 740, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.YOWIE_PH, 5, 7200) -- 2 hour minimum
end

return entity
