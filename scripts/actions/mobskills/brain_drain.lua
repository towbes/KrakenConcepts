-----------------------------------
-- Brain Drain
-- Deals damage to a single target. Additional effect: INT Down
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg(), xi.element.DARK, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 3, 3.25, 3.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, info.hitslanded)

    local power = target:getStat(xi.mod.INT) * 0.25
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.INT_DOWN, power, 10, 120)
    mob:addStatusEffect(xi.effect.INT_BOOST, power, 10, 120)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.DARK)

    return dmg
end

return mobskillObject
