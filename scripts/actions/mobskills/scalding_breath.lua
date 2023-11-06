-----------------------------------
-- Deals water damage to enemies within range. Additional effect: BURN.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = 3
    local power    = 30
    local duration = 45
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg(), xi.element.WATER, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.BURN, power, 0, duration)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WATER)
    target:setTP(0)
    return dmg
end

return mobskillObject
