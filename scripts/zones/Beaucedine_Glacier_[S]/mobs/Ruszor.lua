-----------------------------------
-- Area: Beaucedine Glacier [S]
-----------------------------------
local ID = require('scripts/zones/Beaucedine_Glacier_[S]/IDs')
mixins = 
{
    require('scripts/mixins/families/ruszor'),
}
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
end

entity.onMobSpawn = function(mob)
end

entity.onMobFight = function(mob, target)
end

entity.onMobWeaponSkillPrepare = function (mob, target)
end

entity.onMobWeaponSkill = function(target, mob, skill)
end

entity.onMobDisengage = function(mob)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
