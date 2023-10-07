-----------------------------------
-- Area: Castle Zvahl Keep (162)
--  Mob: Count Bifrons
-----------------------------------
mixins = {require('scripts/mixins/job_special')}
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 355)
    player:addTitle(xi.title.HELLSBANE)
end

return entity
