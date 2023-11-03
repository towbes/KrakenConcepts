-----------------------------------
-- Area: Mount Zhayolm
--   NM: Garharlor the Unruly
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    -- Allower time for followers tp spawn
    mob:timer(5000, function(mobArg)
        for i = 1, 2 do
            xi.follow.follow(GetMobByID(mobArg:getID() + i), mobArg)
        end
    end)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
