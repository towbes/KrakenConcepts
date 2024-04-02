-----------------------------------
-- Area: Kuftal Tunnel
--  Mob: Recluse Spider
-- Note: Place Holder for Arachne
-----------------------------------
local ID = zones[xi.zone.KUFTAL_TUNNEL]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 737, 2, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 739, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.ARACHNE_PH, 5, 7200) -- 2 hour minimum
end

return entity
