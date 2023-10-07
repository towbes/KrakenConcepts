-----------------------------------
-- Area: North Gustaberg [S]
--  Mob: Coppercap
-- Note: PH for Gloomanita
-----------------------------------
mixins = {require('scripts/mixins/families/funguar_s')}
local ID = zones[xi.zone.NORTH_GUSTABERG_S]
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setAnimationSub(0)
--    mob:setStealItemID(4373) -- Woozyshroom is default steal item, needed here in case first action on the mob is steal
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.GLOOMANITA_PH, 10, 3600) -- 1 hour
end

return entity
