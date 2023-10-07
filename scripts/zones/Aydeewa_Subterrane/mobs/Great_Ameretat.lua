-----------------------------------
-- Area: Aydeewwa Subterrane
--  Mob: Great Ameretat
-----------------------------------
require('scripts/globals/mobs')
mixins = 
{ 
require('scripts/mixins/families/ameretat'),
}
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.HP_DRAIN, { chance = 100, power = 17})
end

entity.onMobDespawn = function(mob)
end

return entity
