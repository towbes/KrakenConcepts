-----------------------------------
-- Area: Dynamis-Tavnazia
--  Mob: Diabolos's Vestige
-- Note: Mega Boss
-----------------------------------
require('scripts/globals/dynamis')
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setAutoAttackEnabled(false)
    mob:setMagicCastingEnabled(false)
    mob:setUntargetable(true)
end

entity.onMobSpawn = function(mob)
    mob:timer(2500, function(mobArg)
        mobArg:useMobAbility()
    end)
end

entity.onMobFight = function(mob, target)
end

entity.onMobWeaponSkill = function(target, mob, skill)
    mob:timer(2500, function(mobArg)
        DespawnMob(mob:getID())
    end)
end
        

entity.onMobDeath = function(mob, player, optParams)
end

return entity
