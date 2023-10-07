-----------------------------------
-- Area: East Ronfaure
--  Mob: Rambukk
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 152)
end

entity.onMobDespawn = function(mob)
    xi.mob.nmTODPersist(mob, math.random(900, 3600)) -- 15 min to 1 hour
end

return entity
