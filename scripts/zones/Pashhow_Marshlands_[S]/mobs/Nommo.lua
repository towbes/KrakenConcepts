-----------------------------------
-- Area: Pashhow Marshlands [S]
--   NM: Nommo
-----------------------------------
mixins = {require('scripts/mixins/families/slug')}
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 509)
end

return entity
