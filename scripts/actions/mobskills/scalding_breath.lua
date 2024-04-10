-----------------------------------
-- Deals water damage to enemies within range. Additional effect: BURN.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    -- local dmgmod = 5
    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.2, 2, xi.element.WATER, 700)
    local power    = 30
    local duration = 45
    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.WATER, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.BURN, power, 0, duration)
    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.WATER)
    target:setTP(0)
    return dmg
end

return mobskillObject
