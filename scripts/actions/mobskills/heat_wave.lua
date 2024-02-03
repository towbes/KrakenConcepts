---------------------------------------------
-- Heat Wave
-- Burns opponents in an area of effect
--
-- Note: I do not know of any mob other than Reacton that uses this skill
--       but should it ever happen, I've defaulted the damage to the same
--       damage formula used by the similar 'Cold Wave' skill.
---------------------------------------------
-----------------------------------



-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    -- Reacton cannot use this skill before phase 2
    if mob:getID() == 17031599 and mob:getAnimationSub() < 1 then
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.BURN

    -- Reacton does a 40dmg per tick
    if mob:getID() == 17031599 then
        power = 40
    else
        power = 10
    end

    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, 0, 120)
    return typeEffect
end

return mobskillObject
