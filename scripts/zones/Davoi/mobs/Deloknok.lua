-----------------------------------
-- Area: Davoi
--  Mob: Deloknok
-----------------------------------
mixins = {require('scripts/mixins/job_special')}
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
