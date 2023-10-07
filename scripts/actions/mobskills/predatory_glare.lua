-----------------------------------
-- Predatory Glare
-- Description: Stun
-- Type: Physical (Blunt)
-----------------------------------

-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.STUN
    skill:setMsg(xi.mobskills.mobGazeMove(mob, target, typeEffect, 1, 0, 15))
    return typeEffect
end

return mobskillObject
