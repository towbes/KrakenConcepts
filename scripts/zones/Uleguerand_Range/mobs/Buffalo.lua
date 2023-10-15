-----------------------------------
-- Area: Uleguerand Range
--  Mob: Buffalo
-- Note: PH for Bonnacon
-----------------------------------
local ID = zones[xi.zone.ULEGUERAND_RANGE]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.BONNACON_PH, 5, 3600) -- 1 hour minimum
end

return entity
