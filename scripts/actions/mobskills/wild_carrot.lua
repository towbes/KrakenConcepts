-----------------------------------
-- Wild Carrot
-- Description: Restores HP.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local potency = skill:getParam()

    if potency == 0 then
        potency = 13
    end

    potency = potency - math.random(0, potency / 4)
    skill:setMsg(xi.msg.basic.SELF_HEAL)

    if mob:getZone():getTypeMask() == xi.zoneType.DYNAMIS then
    local erase = target:eraseStatusEffect()

        if erase == xi.effect.NONE then
            mob:messageBasic(xi.msg.basic.NONE, 0, 0, 0)
        else
            mob:messageBasic(xi.msg.basic.SKILL_ERASE, 323, erase)
        end
    end

    return xi.mobskills.mobHealMove(mob, mob:getMaxHP() * potency / 100)
end

return mobskillObject
