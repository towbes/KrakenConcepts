-----------------------------------
-- Area: Davoi
--   NM: One-Eyed Gwajboj
-- Involved in Quest: Under Oath
-----------------------------------
mixins = {require('scripts/mixins/job_special')}
require('scripts/globals/quests')
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

return entity
