-----------------------------------
-- Grapple
-- Deals physical damage to enemies within a fan-shaped area originating from pet.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits   = 1
    local accmod    = 1
    local dmgmod    = 1.5
    local tpEffect1 = xi.mobskills.physicalTpBonus.DMG_VARIES
    local tpEffect2 = xi.mobskills.physicalTpBonus.NONE
    local crit      = 0.00
    local attmod    = 1
    local info      = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, tpEffect1, 1.5, 2, 2.5, tpEffect2, 1.25, 2.25, 3.25, crit, attmod)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    return dmg
end

return mobskillObject
