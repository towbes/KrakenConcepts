-----------------------------------
require('modules/module_utils')


require('scripts/actions/abilities/arcane_circle')
-----------------------------------
local m = Module:new('cactuar_dark_knight_arcane_circle')

m:addOverride('xi.actions.abilities.arcane_circle.onUseAbility', function(player, target, ability)
    -- TODO:
    -- Create Bonus vs Ecosystem handling
    -- https://www.bg-wiki.com/ffxi/Arcane_Circle
    -- Main (DRK) job gives a unique 15% damage bonus against arcana, 15% damage resistance from arcana, and likely +15% Arcana Killer.
    -- When subbed, gives 5% of these bonuses.

    -- Job Points bonus will need to be handled in the Bonus vs Ecosystem handling system
    -- https://www.bg-wiki.com/ffxi/Job_Points#Dark_Knight
    -- Arcane Circle Effect: Reduces the amount of damage taken from arcana while under the effects of Arcane Circle.
    local duration
    if xi.settings.main.ENABLE_ROV == 1 then
        duration = 180 * (1 + (player:getMod(xi.mod.ARCANE_CIRCLE_DURATION) / 100))
    else
        duration = 60 * (1 + (player:getMod(xi.mod.ARCANE_CIRCLE_DURATION) / 100))
    end
    local power    = 15 + player:getMod(xi.mod.ARCANE_CIRCLE_POTENCY)

    --if player:getMainJob() ~= xi.job.DRK then
    --    power = 5
    --end

    target:addStatusEffect(xi.effect.ARCANE_CIRCLE, power, 0, duration)
end)

return m
