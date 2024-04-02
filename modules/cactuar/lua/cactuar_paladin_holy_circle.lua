-----------------------------------
-- Old setting from settings.lua: HOMEPOINT_HEAL
-- Set if you want Home Points to heal you like in single-player Final Fantasy games.
-----------------------------------
require('modules/module_utils')


require('scripts/actions/abilities/holy_circle')
-----------------------------------
local m = Module:new('cactuar_paladin_holy_circle')

m:addOverride('xi.actions.abilities.holy_circle.onUseAbility', function(player, target, ability)
    -- TODO:
    -- Create Bonus vs Ecosystem handling
    -- https://www.bg-wiki.com/ffxi/Holy_Circle
    -- Main (PLD) job gives a unique 15% damage bonus against undead, 15% damage resistance from undead, and likely +15% Undead Killer.
    -- When subbed, gives 5% of these bonuses.
    local duration = 180 + player:getMod(xi.mod.HOLY_CIRCLE_DURATION)
    local power    = 15

    --if player:getMainJob() ~= xi.job.PLD then
    --    power = 5
    --end

    target:addStatusEffect(xi.effect.HOLY_CIRCLE, power, 0, duration)
end)

return m
