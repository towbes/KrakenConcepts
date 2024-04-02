-----------------------------------
-- Area: Mamook
--   NM: Wartkin (T2 ZNM minions)
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 30)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobSpawn = function(mob)
end

entity.onMobFight = function(mob, target)
    if mob:getBattleTime() == 30 then
        DespawnMob(mob:getID())
    end
end

entity.onMobEngage = function(mob, target)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.POISON, {power = 50})
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity