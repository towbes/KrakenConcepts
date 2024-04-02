-----------------------------------
--  Aqua Cannon
--
--  Description: Fires a powerful blast of Water, dealing damage in a fan-shaped area. Additional effect: knockback.
--  Type: Magical (Water)
--  Utsusemi/Blink absorb: Wipes shadows
--  Range: Front conal (16 yalms)
--  Notes: Scylla exclusive, this skill is not used on its own and will always come after Aqua Wave.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = 1.5
    local info   = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.element.WATER, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg    = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WATER)

    return dmg
end

return mobskillObject
