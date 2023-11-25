-----------------------------------
-- Nether Blast
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onPetAbility = function(target, pet, skill)
    local level = pet:getMainLvl()
    local damage = level * 5 + 10
    local ignoreresist = true
    damage = xi.mobskills.mobMagicalMove(pet, target, skill, damage, xi.element.DARK, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, ignoreresist)
    damage = xi.mobskills.mobAddBonuses(pet, target, damage.dmg, xi.element.DARK, ignoreresist)
    damage = xi.summon.avatarFinalAdjustments(damage, pet, skill, target, xi.attackType.BREATH, xi.damageType.DARK, 1)

    target:takeDamage(damage, pet, xi.attackType.BREATH, xi.damageType.DARK)
    target:updateEnmityFromDamage(pet, damage)

    return damage
end

return abilityObject
