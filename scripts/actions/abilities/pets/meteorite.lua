-----------------------------------
-- Meteorite
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onPetAbility = function(target, pet, skill)
    local dint = pet:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)
    local dmg = 500 + dint * 1.5 + pet:getTP() / 20
    target:updateEnmityFromDamage(pet, dmg)
    target:takeDamage(dmg, pet, xi.attackType.MAGICAL, xi.damageType.LIGHT)

    local ele = xi.element.LIGHT
    local magicBurst = xi.mobskills.calculateMobMagicBurst(pet, ele, target)
    if (magicBurst > 1) and target:hasStatusEffect(xi.effect.SKILLCHAIN) then -- Gated as this is run per target.
        skill:setMsg(xi.msg.basic.JA_MAGIC_BURST)
    else
        skill:setMsg(xi.msg.basic.DAMAGE)
    end

    return dmg
end

return abilityObject
