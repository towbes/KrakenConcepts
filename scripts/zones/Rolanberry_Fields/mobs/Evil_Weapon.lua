-----------------------------------
-- Area: Rolanberry Fields
--  Mob: Evil Weapon
-- Note: PH for Eldritch Edge
-----------------------------------
local ID = zones[xi.zone.ROLANBERRY_FIELDS]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.ELDRITCH_EDGE_PH, 20, 5400) -- 90 minute minimum
end

return entity
