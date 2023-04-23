-----------------------------------
-- Area: Ordelles Caves
--   NM: Gerwitz's Sword
-- !pos -51 0.1 3 193
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
