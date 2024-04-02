-----------------------------------
-- Area: Uleguerand Range
--   NM: Father Frost
-----------------------------------
local ID = zones[xi.zone.ULEGUERAND_RANGE]
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.AUTO_SPIKES, 1)
    mob:addStatusEffect(xi.effect.ICE_SPIKES, 45, 0, 0)
    mob:getStatusEffect(xi.effect.ICE_SPIKES):setEffectFlags(xi.effectFlag.DEATH)
end

entity.onMobDeath = function(mob, player, isKiller)
end

entity.onMobDespawn = function(mob)
    if os.time() < mob:getLocalVar('timeToGrow') then
        DisallowRespawn(ID.mob.FATHER_FROST, true)
        DisallowRespawn(ID.mob.MAIDEN_PH, false)
        GetMobByID(ID.mob.MAIDEN_PH):setRespawnTime(GetMobRespawnTime(ID.mob.MAIDEN_PH))
    end
end

return entity
