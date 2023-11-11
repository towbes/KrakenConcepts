-----------------------------------
-- Slashing Damage, Additional Effect: Choke
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 2
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.NUMSHADOWS_1)

    local typeEffect = xi.effect.CHOKE
    local power = mob:getMainLvl() / 4 * 0.6 + 4
    local duration = math.random(15, 20)
    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, 3, duration)

    -- 242 to a NIN, but shadows ate some hits
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    return dmg
end

return mobskillObject
