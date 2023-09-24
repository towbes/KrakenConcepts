-----------------------------------
-- Sticky Thread
-- Inflicts slow on targets in a fan-shaped area of effect.
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.SLOW
    local power      = 1250
    if mob:getZone():getType() == xi.zoneType.DYNAMIS then
        power = 1600
    end

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, 0, 120))

    return typeEffect
end

return mobskillObject
