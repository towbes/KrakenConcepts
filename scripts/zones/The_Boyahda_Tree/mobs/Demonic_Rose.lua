-----------------------------------
-- Area: The Boyahda Tree
--  Mob: Demonic Rose
-- Note: Placeholder V. Vivian
-----------------------------------
local ID = zones[xi.zone.THE_BOYAHDA_TREE]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.VOLUPTUOUS_VIVIAN_PH, 10, 57600) -- 16 hour minimum
end

return entity
