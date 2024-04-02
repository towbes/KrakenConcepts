-----------------------------------
-- Area: Rolanberry Fields
--   NM: Black Triple Stars
-----------------------------------
local entity = {}

entity.onMobRoam = function(mob)
    if VanadielHour() >= 6 and VanadielHour() < 18 then -- Despawn if its day
        DespawnMob(mob:getID())
    end
end

entity.onMobDisengage = function(mob)
    if VanadielHour() >= 6 and VanadielHour() < 18 then -- Despawn if its day
        DespawnMob(mob:getID())
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.magian.onMobDeath(mob, player, optParams, set{ 3 })
    xi.hunts.checkHunt(mob, player, 215)
end

return entity
