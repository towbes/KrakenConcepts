-----------------------------------
-- Area: The Eldieme Necropolis
--  Mob: Anemone
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDespawn = function(mob)
    xi.mob.nmTODPersist(mob, math.random(75600, 86400)) -- 21 to 24 hours
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
