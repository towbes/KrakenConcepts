-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Corse
-- Note: PH for Citipati
-----------------------------------
local ID = zones[xi.zone.ATTOHWA_CHASM]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.CITIPATI_PH, 20, 10800) -- 3 hours minimum
end

return entity
