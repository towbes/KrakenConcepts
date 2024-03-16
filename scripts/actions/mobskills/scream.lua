-----------------------------------
-- Scream
-- 15' Reduces MND of players in area of effect.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.MND_DOWN, 10, 3, 120))
    if mob:getZone():getTypeMask() == xi.zoneType.DYNAMIS then
        skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.TERROR, 30, 0, 10))

        mob:timer(4000, function(mobArg)
            mob:messageBasic(xi.msg.basic.IS_EFFECT, 306, xi.effect.TERROR, target)
        end)
    end

    return xi.effect.MND_DOWN
end

return mobskillObject
