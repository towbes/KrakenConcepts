-----------------------------------
-- Area: Dynamis - Buburimu
--  Mob: Aitvaras
-----------------------------------
mixins =
{
    require('scripts/mixins/dynamis_beastmen')
}
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.SKILL_LIST, 5372)
end

entity.onMobFight = function(mob)
    mob:setMod(xi.mod.REGAIN, 1250)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
