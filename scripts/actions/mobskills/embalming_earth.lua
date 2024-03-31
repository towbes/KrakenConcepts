-----------------------------------
-- Deals Earth damage to enemies within range. Additional effect: Slow.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = 6
    local power    = 33
    local duration = 120
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg(), xi.element.EARTH, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.EARTH, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.SLOW, power, 0, duration)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.EARTH)
    return dmg
end

return mobskillObject
