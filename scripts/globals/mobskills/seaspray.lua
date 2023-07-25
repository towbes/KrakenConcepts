---------------------------------------------
--  Sea Spray
--  utsusemi/Blink absorb: Ignores shadows
--  Description: Deals water damage that inflicts slow in a cone
--  Type: Magical (Water/Breath)
--  Range:
---------------------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/status")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local cap = 2000
    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.030, 3.0, xi.magic.ele.WATER, cap)
    local dmg    = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.WATER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.WATER)

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLOW, 2000, 0, 60)
    
    return dmg
end

return mobskillObject
