-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Dagourmarche
-----------------------------------
mixins =
{
    require('scripts/mixins/dynamis_beastmen'),
    require('scripts/mixins/job_special')
}
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.REGAIN, 100)
    mob:setMobMod(xi.mobMod.SKILL_LIST, 714)
end

entity.onMobEngage = function(mob, target)
end

entity.onMobFight = function(mob, target)
end

entity.onMobWeaponSkillPrepare = function(mob, target)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
