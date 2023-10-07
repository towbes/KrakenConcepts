-----------------------------------
--   Area: Mount Zhayolm
--    Mob: Garhorlur the Brutal
-----------------------------------
mixins = {require('scripts/mixins/weapon_break')}
mixins = {require('scripts/mixins/job_special')}
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
end

return entity