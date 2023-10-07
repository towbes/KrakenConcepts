-----------------------------------
--   Area: Mount Zhayolm
--    Mob: Garharlor the Unruly
-----------------------------------
mixins = {require('scripts/mixins/weapon_break')}
mixins = {require('scripts/mixins/job_special')}
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
end

return entity