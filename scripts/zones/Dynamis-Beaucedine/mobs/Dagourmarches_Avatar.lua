-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Dagourmarche
-----------------------------------
mixins =
{
    -- mixins = { require('scripts/mixins/families/avatar') }
}
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.SKILL_LIST, 36)
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
