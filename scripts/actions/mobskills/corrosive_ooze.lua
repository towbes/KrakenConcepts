-----------------------------------
--  Corrosive Ooze
--  Family: Slugs
--  Description: Deals water damage to an enemy. Additional Effect: Attack Down and Defense Down.
--  Type: Magical
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: Radial
--  Notes:
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.ATTACK_DOWN, 15, 0, 120)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DEFENSE_DOWN, 15, 0, 120)

    local dmgmod = 1
    local baseDamage = mob:getWeaponDmg()
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, baseDamage, xi.element.WATER, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1, 0, 4, 4.5, 5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WATER)
    xi.mobskills.handleMobBurstMsg(mob, target, skill, xi.element.WATER)
    return dmg
end

return mobskillObject
