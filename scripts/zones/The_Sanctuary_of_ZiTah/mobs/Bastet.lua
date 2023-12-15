-----------------------------------
-- Area: The Sanctuary of ZiTah
--   NM: Bastet
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.move.MOVE_SPEED_STACKABLE, 12)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 325)
end

return entity
