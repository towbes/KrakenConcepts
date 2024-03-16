-----------------------------------
-- Intimidate
-- Inflicts slow on targets in a fan-shaped area of effect.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power      = 1250
    if mob:getZone():getTypeMask() == xi.zoneType.DYNAMIS then
        power = 1600
    end
    skill:setMsg(xi.mobskills.mobGazeMove(mob, target, xi.effect.SLOW, 1250, 0, 120))
    return xi.effect.SLOW
end

return mobskillObject
