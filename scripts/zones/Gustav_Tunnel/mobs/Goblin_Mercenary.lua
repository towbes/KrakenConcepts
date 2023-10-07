-----------------------------------
-- Area: Gustav Tunnel
--  Mob: Goblin Mercenary
-- Note: Place holder Wyvernpoacher Drachlox
-----------------------------------
local ID = zones[xi.zone.GUSTAV_TUNNEL]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 764, 3, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 765, 3, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.WYVERNPOACHER_DRACHLOX_PH, 5, 7200) -- 2 hour minimum
end

return entity
