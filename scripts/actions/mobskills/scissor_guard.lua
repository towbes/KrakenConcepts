-----------------------------------
-- Scissor Guard
-- Enhances defense 100%.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = 100
    if mob:getZone():getTypeMask() == xi.zoneType.DYNAMIS then
        power = 200
    end
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.DEFENSE_BOOST, power, 0, 60))
    return xi.effect.DEFENSE_BOOST
end

return mobskillObject
