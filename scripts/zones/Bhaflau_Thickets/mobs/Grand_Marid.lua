-----------------------------------
-- Area: Bhaflau Thickets
--  MOB: Grand Marid
-- Note: 30 minute lottery
-----------------------------------
local ID = zones[xi.zone.BHAFLAU_THICKETS]
require('scripts/globals/mobs')
mixins = 
{ 
require('scripts/mixins/behavior_spawn_chigoe'),
require('scripts/mixins/families/marid'),
}
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.GRAND_MARID1_PH, 5, 1800)
    xi.mob.phOnDespawn(mob, ID.mob.GRAND_MARID2_PH, 5, 1800)
end

return entity
