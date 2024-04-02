-----------------------------------
-- Charged Whisker
-- Deals Lightning damage to enemies within area of effect.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 2.5, xi.element.THUNDER, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1, 0, 3, 3.75, 4)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.THUNDER, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.THUNDER)
    xi.mobskills.handleMobBurstMsg(mob, target, skill, xi.element.THUNDER)
    return dmg
end

return mobskillObject
