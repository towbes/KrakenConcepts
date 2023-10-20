-----------------------------------
-- Old setting from settings.lua: HOMEPOINT_HEAL
-- Set if you want Home Points to heal you like in single-player Final Fantasy games.
-----------------------------------
require('modules/module_utils')


require('scripts/actions/abilities/meditate')
-----------------------------------
local m = Module:new('cactuar_samurai_meditate')

m:addOverride('xi.actions.abilities.meditate.onUseAbility', function(player, target, ability)
    local amount   = 12
    local duration = 15 + player:getMod(xi.mod.MEDITATE_DURATION)

    if player:getMainJob() == xi.job.SAM then
        amount = 20 + target:getJobPointLevel(xi.jp.MEDITATE_EFFECT) * 5
    end

    if player:getSubJob() == xi.job.SAM then
        amount = 20 + target:getJobPointLevel(xi.jp.MEDITATE_EFFECT) * 5
    end

    player:addStatusEffectEx(xi.effect.MEDITATE, 0, amount, 3, duration)
end)

return m
