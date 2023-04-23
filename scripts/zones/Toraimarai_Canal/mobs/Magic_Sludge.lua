-----------------------------------
-- Area: Toraimarai Canal
--   NM: Magic Sludge
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobSpawn = function(mob)
    mob:addMod(xi.mod.UDMGPHYS, -75)
    mob:addMod(xi.mod.UDMGRANGE, -75)
    mob:addMod(xi.mod.UDMGMAGIC, -75)
    mob:addMod(xi.mod.UDMGBREATH, -75)
end 

entity.onMobDeath = function(mob, player, optParams)
    player:setCharVar("rootProblem", 3)
end

return entity
