-----------------------------------
-- Old setting from settings.lua: HOMEPOINT_HEAL
-- Set if you want Home Points to heal you like in single-player Final Fantasy games.
-----------------------------------
require('modules/module_utils')


require('scripts/actions/abilities/hasso')
-----------------------------------
local m = Module:new('cactuar_samurai_hasso')

m:addOverride('xi.actions.abilities.hasso.onUseAbility', function(player, target, ability)
    local strboost = 0

    if target:getMainJob() == xi.job.SAM then
        strboost = (target:getMainLvl() / 7) + target:getJobPointLevel(xi.jp.HASSO_EFFECT)
    elseif target:getSubJob() == xi.job.SAM then
        strboost = (target:getMainLvl() / 7) + target:getJobPointLevel(xi.jp.HASSO_EFFECT)
    end

    if strboost > 0 then
        target:delStatusEffect(xi.effect.HASSO)
        target:delStatusEffect(xi.effect.SEIGAN)
        target:addStatusEffect(xi.effect.HASSO, strboost, 0, 300)
    end
end)

return m
