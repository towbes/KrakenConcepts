---------------------------------------------
-- Fantod
-- Hippogryph Boost Ability.
---------------------------------------------



---------------------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.BOOST
    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, 60, 0, 180))
    return typeEffect
end

return mobskillObject
