-----------------------------------
-- Area: Fei'Yin
--   NM: Altedour I Tavnazia
-- Involved in Quest: Pieuje's Decision
-----------------------------------
mixins = {require('scripts/mixins/job_special')}
require('scripts/globals/mobs')
require('scripts/globals/quests')
require('scripts/globals/utils')
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.MP_DRAIN)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DMGMAGIC,-70)
    mob:addMod(xi.mod.ACC, 175)
end 

entity.onMobFight = function(mob, target)
    local TP = (100 - mob:getHPP()) * 0.5
    if mob:getMod(xi.mod.REGAIN) ~= utils.clamp(TP, 1, 100) then
        mob:setMod(xi.mod.REGAIN, utils.clamp(TP, 1, 100))
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
