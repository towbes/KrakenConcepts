-----------------------------------
-- Foul Waters
-- Deals Water damage to targets in front of mob. Additional Effect: Drown + Weight
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 6, xi.element.WATER, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    local typeEffect = xi.effect.DROWN
    local power = mob:getMainLvl() / 4 * 0.6 + 7
    local duration = math.random(30, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, 3, duration)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.WEIGHT, 50, 0, duration)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WATER)
    return dmg
end

return mobskillObject
