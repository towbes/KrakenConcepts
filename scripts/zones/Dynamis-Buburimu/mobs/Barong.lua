-----------------------------------
-- Area: Dynamis - Buburimu
--  Mob: Aitvaras
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.SKILL_LIST, 5373)
end

entity.onMobFight = function(mob)
    mob:setMod(xi.mod.REGAIN, 1250)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
