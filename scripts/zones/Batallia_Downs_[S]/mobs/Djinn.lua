-----------------------------------
-- Area: Batallia Downs [S]
--  Mob: Djinn
-----------------------------------
require('scripts/globals/mobs')
mixins = { require('scripts/mixins/families/djinn') }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
end

return entity
