-----------------------------------
-- Area: Pashhow Marshlands [S]
--  Mob: Lou Carcolh
-- Note: PH for Nommo
-----------------------------------
mixins = {require("scripts/mixins/families/slug")}
local ID = zones[xi.zone.PASHHOW_MARSHLANDS_S]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.NOMMO_PH, 5, 3600) -- 1 hour
end

return entity
