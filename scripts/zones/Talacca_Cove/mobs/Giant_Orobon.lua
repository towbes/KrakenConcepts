-----------------------------------
-- Area: Talacca Cove
--   NM: Giant Orobon
-- Note: Fished up
-----------------------------------
mixins = { require("scripts/mixins/families/orobon") }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
end

return entity
