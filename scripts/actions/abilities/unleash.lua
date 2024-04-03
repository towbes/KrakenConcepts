-----------------------------------
-- Ability: Unleash
-- Description: Increases the accuracy of Charm and reduces the recast times of Sic and Ready.
-- Obtained: BST Level 96
-- Recast Time: 01:00:00
-- Duration: 0:01:00
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    if player:getPet() == nil then
        return xi.msg.basic.REQUIRES_A_PET, 0
    else
        if player:getPet():getHP() == 0 then
            return xi.msg.basic.UNABLE_TO_USE_JA, 0
        elseif player:getPet():getTarget() == nil then
            return xi.msg.basic.PET_CANNOT_DO_ACTION, 0
        else
            ability:setRecast(math.max(0, ability:getRecast() - player:getMod(xi.mod.ONE_HOUR_RECAST) * 60))
            return 0, 0
        end
    end
end

abilityObject.onUseAbility = function(player, target, ability)
    player:addStatusEffect(xi.effect.UNLEASH, 9, 3, 60)
end

return abilityObject
