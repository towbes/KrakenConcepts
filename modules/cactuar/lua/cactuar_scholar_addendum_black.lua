-----------------------------------
-- Old setting from settings.lua: HOMEPOINT_HEAL
-- Set if you want Home Points to heal you like in single-player Final Fantasy games.
-----------------------------------
require('modules/module_utils')


require('scripts/actions/abilities/addendum_black')
-----------------------------------
local m = Module:new('cactuar_scholar_addendum_black')

m:addOverride('xi.actions.abilities.addendum_black.onUseAbility', function(player, target, ability)
    player:delStatusEffectSilent(xi.effect.LIGHT_ARTS)
    player:delStatusEffectSilent(xi.effect.ADDENDUM_WHITE)
    player:delStatusEffectSilent(xi.effect.DARK_ARTS)

    local effectbonus = player:getMod(xi.mod.DARK_ARTS_EFFECT)
    local helixbonus  = 0

    if player:getMainJob() == xi.job.SCH and player:getMainLvl() >= 20 then
        helixbonus = math.floor(player:getMainLvl() / 4)
    end

    if player:getSubJob() == xi.job.SCH and player:getSubLvl() >= 20 then
        helixbonus = math.floor(player:getMainLvl() / 4)
    end

    player:addStatusEffectEx(xi.effect.ADDENDUM_BLACK, xi.effect.ADDENDUM_BLACK, effectbonus, 0, 7200, 0, helixbonus, true)

    return xi.effect.ADDENDUM_BLACK
end)

return m
