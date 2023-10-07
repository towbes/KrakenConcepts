-----------------------------------
-- Crystal Shield
-- Protect II
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = 50
    local duration = 300

    local typeEffect = xi.effect.PROTECT

    if mob:getName() == "Lost_Suttung" then
        local power = 100
    end

    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, power, 0, duration))

    return typeEffect
end

return mobskillObject
