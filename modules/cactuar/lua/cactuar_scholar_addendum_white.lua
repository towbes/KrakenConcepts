-----------------------------------
-- Old setting from settings.lua: HOMEPOINT_HEAL
-- Set if you want Home Points to heal you like in single-player Final Fantasy games.
-----------------------------------
require('modules/module_utils')


require('scripts/actions/abilities/addendum_white')
-----------------------------------
local m = Module:new('cactuar_scholar_addendum_white')

m:addOverride('xi.actions.abilities.addendum_white.onUseAbility', function(player, target, ability)
    player:delStatusEffectSilent(xi.effect.DARK_ARTS)
    player:delStatusEffectSilent(xi.effect.ADDENDUM_BLACK)
    player:delStatusEffectSilent(xi.effect.LIGHT_ARTS)

    local effectbonus = player:getMod(xi.mod.LIGHT_ARTS_EFFECT)
    local regenbonus  = 0

    if player:getMainJob() == xi.job.SCH and player:getMainLvl() >= 20 then
        regenbonus = 3 * math.floor((player:getMainLvl() - 10) / 10)
    end

    if player:getSubJob() == xi.job.SCH and player:getSubLvl() >= 20 then
        regenbonus = 3 * math.floor((player:getMainLvl() - 10) / 10)
    end

    player:addStatusEffectEx(xi.effect.ADDENDUM_WHITE, xi.effect.ADDENDUM_WHITE, effectbonus, 0, 7200, 0, regenbonus, true)

    return xi.effect.ADDENDUM_WHITE
end)

return m
