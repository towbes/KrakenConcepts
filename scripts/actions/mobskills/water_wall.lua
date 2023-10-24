-----------------------------------
-- Water Wall
-- Enhances defense.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.DEFENSE_BOOST
    local power      = 100
    if mob:getZone():getTypeMask() == xi.zoneType.DYNAMIS then
        power = 200
    end
    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, power, 0, 60))
    return typeEffect
end

return mobskillObject
