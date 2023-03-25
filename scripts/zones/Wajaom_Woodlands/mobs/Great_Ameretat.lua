-----------------------------------
-- Area: Wajaom Woodlands
--  Mob: Great Ameretat
-- Note: PH for Jaded Jody
-----------------------------------
local ID = require("scripts/zones/Wajaom_Woodlands/IDs")
require("scripts/globals/mobs")
mixins = 
{ 
require("scripts/mixins/families/ameretat"),
}
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.HP_DRAIN, { chance = 100, power = 17})
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.JADED_JODY_PH, 10, 7200) -- 2 hours
end

return entity
