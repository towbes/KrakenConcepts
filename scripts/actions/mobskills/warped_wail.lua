---------------------------------------------
-- Warped Wail
--
-- Description: Lowers maximum HP/MP of targets in an area of effect.
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: 20' radial
-- Notes: 12% reduction - Best guess based on captures
---------------------------------------------



-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.MAX_MP_DOWN
    local typeEffect2 = xi.effect.MAX_HP_DOWN
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 12, 0, 300))
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect2, 12, 0, 300))

    return typeEffect
end

return mobskillObject
