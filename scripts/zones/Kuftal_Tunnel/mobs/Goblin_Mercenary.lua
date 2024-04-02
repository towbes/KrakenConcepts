-----------------------------------
-- Area: Kuftal Tunnel
--  Mob: Goblin Mercenary
-- Note: Place Holder for Bloodthirster Madkix
-----------------------------------
local ID = zones[xi.zone.KUFTAL_TUNNEL]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 740, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.BLOODTHIRSTER_MADKIX_PH, 5, 7200) -- 2 hour minimum
end

return entity
