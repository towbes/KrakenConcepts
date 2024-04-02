-----------------------------------
-- Area: Foret de Hennetiel
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobSkillAttack(5399)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
