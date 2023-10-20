-----------------------------------
-- Old setting from settings.lua: HOMEPOINT_HEAL
-- Set if you want Home Points to heal you like in single-player Final Fantasy games.
-----------------------------------
require('modules/module_utils')


require('scripts/actions/abilities/light_arts')
-----------------------------------
local m = Module:new('cactuar_scholar_light_arts')

m:addOverride('xi.actions.abilities.light_arts.onUseAbility', function(player, target, ability)
    player:delStatusEffectSilent(xi.effect.DARK_ARTS)
    player:delStatusEffect(xi.effect.ADDENDUM_BLACK)
    player:delStatusEffect(xi.effect.PARSIMONY)
    player:delStatusEffect(xi.effect.ALACRITY)
    player:delStatusEffect(xi.effect.MANIFESTATION)
    player:delStatusEffect(xi.effect.EBULLIENCE)
    player:delStatusEffect(xi.effect.FOCALIZATION)
    player:delStatusEffect(xi.effect.EQUANIMITY)
    player:delStatusEffect(xi.effect.IMMANENCE)

    local effectbonus = player:getMod(xi.mod.LIGHT_ARTS_EFFECT)
    local regenbonus  = 0

    if player:getMainJob() == xi.job.SCH and player:getMainLvl() >= 20 then
        regenbonus = 3 * math.floor((player:getMainLvl() - 10) / 10)
    end

    if player:getSubJob() == xi.job.SCH and player:getMainLvl() >= 20 then
        regenbonus = 3 * math.floor((player:getMainLvl() - 10) / 10)
    end

    player:addStatusEffect(xi.effect.LIGHT_ARTS, effectbonus, 0, 7200, 0, regenbonus)

    return xi.effect.LIGHT_ARTS
end)

return m
