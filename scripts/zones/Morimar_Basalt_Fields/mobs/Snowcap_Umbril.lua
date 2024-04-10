-----------------------------------
-- Area: Morimar Basalt Fields
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setAnimationSub(5)
end

entity.onMobEngaged = function(mob, target)
    mob:setAnimationSub(0)
end

entity.onMobDisengage = function(mob, target)
    mob:setAnimationSub(5)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
end

return entity
