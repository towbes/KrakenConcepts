-----------------------------------
-- Spirit Vacuum
-- Additional effect: TP Drain
-- Type: Magical
-- Utsusemi/Blink absorb: 1 shadow
-- Range: Melee
-----------------------------------

-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = 1
    power = target:getTP()
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, power, xi.element.DARK, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.NUMSHADOWS_1)

    skill:setMsg(xi.mobskills.mobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.TP, dmg))

    return dmg
end

return mobskillObject
