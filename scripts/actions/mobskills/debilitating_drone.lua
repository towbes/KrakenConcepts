-----------------------------------
-- Debilitating Drone
-- Randomly reduces 2 attributes of target.
-- Type: Magical
-- Notes: Can also use the ability to target itself and remove all debuffs (whispers_of_ire_self.lua)
-----------------------------------




-----------------------------------
local mobskillObject = {}

local attributesDown =
{
    xi.effect.STR_DOWN,
    xi.effect.DEX_DOWN,
    xi.effect.VIT_DOWN,
    xi.effect.AGI_DOWN,
    xi.effect.MND_DOWN,
    xi.effect.INT_DOWN,
    xi.effect.CHR_DOWN,
}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local amount = 1
    if mob:getZone():getType() == xi.zoneType.DYNAMIS then
        amount = 2
    end
    local count = 0
    local statsReduced = {}
    local size = amount

    while size > 0 do
        local effectType = math.random(1, 7)
        local check = true

        for i = 1, amount do
            if effectType == statsReduced[i] then
                check = false
            end
        end

        if check then
            xi.mobskills.mobStatusEffectMove(mob, target, attributesDown[effectType], 10, 0, 60)
            count = count + 1
            statsReduced[count] = effectType
            size = size - 1
        end
    end

    if count > 0 then
        skill:setMsg(xi.msg.basic.EFFECT_DRAINED)
    else
        skill:setMsg(xi.msg.basic.SKILL_MISS)
    end

    return count
end

return mobskillObject
