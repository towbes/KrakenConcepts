-----------------------------------
-- Scream
-- 15' Reduces MND of players in area of effect.
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.MND_DOWN
    local typeEffect2 = xi.effect.TERROR
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 10, 3, 120))
    if mob:getZone():getType() == xi.zoneType.DYNAMIS then
        skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect2, 30, 0, 10))

        mob:timer(4000, function(mobArg)
            mob:messageBasic(xi.msg.basic.IS_EFFECT, 306, typeEffect2, target)
        end)
    end

    return typeEffect
end

return mobskillObject
