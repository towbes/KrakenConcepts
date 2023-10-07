-----------------------------------
-- Ranged Attack
-- Deals a ranged attack to a single target.
-----------------------------------



-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1.5
    local dmgmod = 3.0

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.PIERCING, info.hitslanded)
    target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.PIERCING)
    return dmg
end

return mobskillObject
