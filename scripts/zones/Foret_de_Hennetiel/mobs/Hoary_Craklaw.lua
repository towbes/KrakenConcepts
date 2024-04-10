-----------------------------------
-- Area: Foret de Hennetiel
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobSkillAttack(5397)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
