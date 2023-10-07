-----------------------------------
-- Area: Rolanberry Fields [S]
--   NM: Dyinyinga
-----------------------------------
local entity = {}

local updateRegen = function(mob)
    if mob:getWeather() == xi.weather.RAIN or mob:getWeather() == xi.weather.SQUALL then
        mob:setMod(xi.mod.REGEN, 75) -- Noticeably high Auto Regen during rain weather.
    else
        mob:setMod(xi.mod.REGEN, 0)
    end
end

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.DMGMAGIC, 25)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:addListener("EFFECT_LOSE", "DYINYINGA_EFFECT_LOSE", function(owner, effect)
        local effectType = effect:getType()
        if effectType == xi.effect.WEIGHT then
            owner:addMod(xi.mod.GRAVITYRES, 10)
        end
        if effectType == xi.effect.BIND then
            owner:addMod(xi.mod.BINDRES, 10)
        end
    end)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.TARGET_DISTANCE_OFFSET, 50)
    mob:setMod(xi.mod.BINDRES, -75)
    mob:setMod(xi.mod.GRAVITYRES, -75)
    updateRegen(mob)
end

entity.onMobFight = function(mob, target)
    local distance = mob:checkDistance(target)
    if(distance < 2) then
        -- This should really be an on/off effect based on distance, for now I've done the next best - creating a pulse of status effects
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.AMNESIA, 0, 0, 7)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SILENCE, 0, 0, 7)
    end
    updateRegen(mob)
end

entity.onMobRoam = function(mob)
    updateRegen(mob)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.SLOW, { chance = 100, duration = 120 })
end

entity.onMobEngaged = function (mob, target)
    if mob:getHPP() == 100 then
        mob:setMod(xi.mod.BINDRES, -75)
        mob:setMod(xi.mod.GRAVITYRES, -75)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 511)
end

return entity
