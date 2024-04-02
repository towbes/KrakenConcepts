-----------------------------------
-- Area: Halvung
--   NM: Dorgerwor the Astute
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
mixins = {require('scripts/mixins/weapon_break')}
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
