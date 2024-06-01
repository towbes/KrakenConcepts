-----------------------------------
-- Area: Promyvion-Mea
--   NM: Stray
-----------------------------------
mixins =
{
    require('scripts/mixins/families/empty')
}
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    xi.promyvion.strayOnMobSpawn(mob)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
