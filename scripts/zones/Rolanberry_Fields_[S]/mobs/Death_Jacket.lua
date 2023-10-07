-----------------------------------
-- Area: Rolanberry Fields [S]
-----------------------------------
local ID = require('scripts/zones/Rolanberry_Fields_[S]/IDs')
require('scripts/globals/mobs')
require('scripts/globals/hunts')
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.ERLE_PH, 15, 10800) -- 3 hours
end

return entity
