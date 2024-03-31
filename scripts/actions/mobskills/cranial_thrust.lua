-----------------------------------
-- Conal Physical Damage. Additional effect: Max HP Down
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 3.5
    local power    = 25
    local duration = 60

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.MAX_HP_DOWN, power, 0, duration)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    return dmg
end

return mobskillObject
