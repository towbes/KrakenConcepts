-----------------------------------
-- Area: Rolanberry Fields [S]
--  Mob: Coppercap
-- Note: Items stolen removes caps from head
-----------------------------------
require('scripts/globals/mobs')
mixins = {require('scripts/mixins/families/funguar_s')}
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setAnimationSub(0)
--    mob:setStealItemID(4373) -- Woozyshroom is default steal item, needed here in case first action on the mob is steal

end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
