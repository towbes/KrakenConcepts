-----------------------------------
-- Ability: Run Wild
-- Grants a +25% bonus to Pet: Attack, Accuracy, Magic Attack Bonus, Evasion, and Defense bonus and adds a Regen effect, but the pet disappears after 5 minutes. 
-- Obtained: Beastmaster Level 93
-- Recast Time: 15 minutes
-- Duration: 5 minutes
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
            return 0, 0
        end
    end
end

abilityObject.onUseAbility = function(player, target, ability)
    local jpValue  = player:getJobPointLevel(xi.jp.RUN_WILD_DURATION * 2)
    local duration = 300 + jpValue
    player:addStatusEffectEx(xi.effect.RUN_WILD, 0, 0, 0, duration)
end

return abilityObject
