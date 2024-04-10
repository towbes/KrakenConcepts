-----------------------------------
-- Rending Deluge
-- Deals water damage to enemies within range. Additional effect: Dispel.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod   = 1
    local duration = 120
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 6, xi.element.WATER, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.SILENCE, 1, 0, duration)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WATER)
    return dmg
end

return mobskillObject
