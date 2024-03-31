-----------------------------------
-- Sundering Snip
-- AOE Physical Damage. Additional effect: Defense Down, Magic Defense Down.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 3.5
    local power    = 30
    local duration = 120

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.DEFENSE_DOWN, power, 0, duration)
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.MAGIC_DEF_DOWN, power, 0, duration)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    return dmg
end

return mobskillObject
