-----------------------------------
-- Old setting from settings.lua: HOMEPOINT_HEAL
-- Set if you want Home Points to heal you like in single-player Final Fantasy games.
-----------------------------------
require('modules/module_utils')


require('scripts/actions/abilities/dark_arts')
-----------------------------------
local m = Module:new('cactuar_scholar_dark_arts')

m:addOverride('xi.actions.abilities.dark_arts.onUseAbility', function(player, target, ability)
    player:delStatusEffectSilent(xi.effect.LIGHT_ARTS)
    player:delStatusEffect(xi.effect.ADDENDUM_WHITE)
    player:delStatusEffect(xi.effect.PENURY)
    player:delStatusEffect(xi.effect.CELERITY)
    player:delStatusEffect(xi.effect.ACCESSION)
    player:delStatusEffect(xi.effect.RAPTURE)
    player:delStatusEffect(xi.effect.ALTRUISM)
    player:delStatusEffect(xi.effect.TRANQUILITY)
    player:delStatusEffect(xi.effect.PERPETUANCE)

    local helixbonus = 0

    if player:getMainJob() == xi.job.SCH and player:getMainLvl() >= 20 then
        helixbonus = math.floor(player:getMainLvl() / 4)
    end

    if player:getSubJob() == xi.job.SCH and player:getMainLvl() >= 20 then
        helixbonus = math.floor(player:getMainLvl() / 4)
    end

    player:addStatusEffect(xi.effect.DARK_ARTS, 1, 0, 7200, 0, helixbonus)

    return xi.effect.DARK_ARTS
end)

return m
