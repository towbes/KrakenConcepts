-----------------------------------
-- Frightful Roar
--
-- Description: Weakens defense of enemies within range.
-- Type: Magical (Wind)
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.DEFENSE_DOWN
    local power      = 10
    if mob:getZone():getType() == xi.zoneType.DYNAMIS then
        power = 50
    end
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, 0, 180))
    return typeEffect
end

return mobskillObject
