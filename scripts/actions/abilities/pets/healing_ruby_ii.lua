-----------------------------------
-- Healing Ruby II
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onPetAbility = function(target, pet, skill)
    if target:hasStatusEffect(xi.effect.CURSE_II) then
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT) -- no effect
        return 1
    end
    local base = 28 + pet:getMainLvl() * 4

    if target:getHP() + base > target:getMaxHP() then
        base = target:getMaxHP() - target:getHP() --cap it
    end

    skill:setMsg(xi.msg.basic.SELF_HEAL)
    target:addHP(base)
    pet:updateEnmityFromCure(pet, base)
    return base
end

return abilityObject
