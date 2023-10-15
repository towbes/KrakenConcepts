-----------------------------------
-- Area: Rolanberry Fields [S]
-----------------------------------
local ID = require('scripts/zones/Rolanberry_Fields_[S]/IDs')
require('scripts/globals/mobs')
require('scripts/globals/hunts')
mixins = {require('scripts/mixins/families/slug')}
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.DYINYINGA_PH, 10, 3600) -- 1 hour cooldown 10% pop chance, reports of 1-2 hour respawn
end

return entity
