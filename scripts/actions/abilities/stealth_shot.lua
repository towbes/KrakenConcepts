-----------------------------------
-- Ability: Stealth Shot
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability, action)
    if player:hasStatusEffect(xi.effect.FLASHY_SHOT) then
        player:delStatusEffect(xi.effect.FLASHY_SHOT)
    end
    player:addStatusEffect(xi.effect.STEALTH_SHOT,1,0,60)
end

return abilityObject
