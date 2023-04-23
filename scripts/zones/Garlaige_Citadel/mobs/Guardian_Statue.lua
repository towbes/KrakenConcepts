-----------------------------------
-- Area: Garlaige Citadel
--   NM: Guardian Statue
-- Involved in Quest: Peace for the Spirit
-----------------------------------
require("scripts/globals/mobs")
require("scripts/globals/quests")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.HP_DRAIN, {chance = 50, power = math.random(450, 550)})
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 10)
    mob:setMod(xi.mod.REGAIN, 150)
end 

entity.onMobFight = function(mob, target)
    if mob:getTP() >= 1000 then
        mob:useMobAbility()
    end

    if mob:getHPP() <= 50 then
        mob:setMod(xi.mod.REGAIN, 250)
    elseif mob:getHPP() <= 25 then
        mob:setMod(xi.mod.REGAIN, 400)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
