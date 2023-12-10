-----------------------------------
-- Ability: Flashy Shot
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability, action)
    if player:hasStatusEffect(xi.effect.STEALTH_SHOT) then
        player:delStatusEffect(xi.effect.STEALTH_SHOT)
    end
    player:addStatusEffect(xi.effect.FLASHY_SHOT,1,0,60)

end

return abilityObject
