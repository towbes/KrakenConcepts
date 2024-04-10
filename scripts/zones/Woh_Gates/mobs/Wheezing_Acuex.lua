-----------------------------------
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setAnimationSub(0)
end

entity.onMobEngaged = function(mob, target)
end

entity.onMobFight = function(mob, target)
    if mob:getLocalVar('poisonAura') == 1 then
        if mob:checkDistance(target) < 5 then
            if not target:hasStatusEffect(xi.effect.POISON) then
                target:addStatusEffect(xi.effect.POISON, 15, 3, math.random(3, 6) * 3) -- Poison for 3-6 ticks.
            else
                if target:getStatusEffect(xi.effect.POISON):getPower() < 15 then
                    target:delStatusEffect(xi.effect.POISON)
                    target:addStatusEffect(xi.effect.POISON, 15, 3, math.random(3, 6) * 3) -- Poison for 3-6 ticks.
                end
            end
        end
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() == 2976 or skill:getID() == 2977 then -- Deadening Haze/Venemous Vapor
        mob:setLocalVar('poisonAura', 1)
        mob:setAnimationSub(1)

        mob:timer(20000, function(mobArg)
            mobArg:setLocalVar('poisonAura', 0)
            mobArg:setAnimationSub(0)
        end)
    end
end

entity.onMobDisengage = function(mob, target)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
end

return entity
