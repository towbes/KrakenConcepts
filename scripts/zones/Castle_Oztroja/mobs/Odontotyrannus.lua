-----------------------------------
-- Area: Castle Oztroja
--   NM: Odontotyrannus
-- Involved in Quest: A Boy's Dream
-----------------------------------
mixins = {require('scripts/mixins/job_special')}
require('scripts/globals/quests')

-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

return entity
