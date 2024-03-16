-----------------------------------
-- Crystal Shield
-- Protect II
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.PROTECT, 50, 0, 300))

    if mob:getName() == 'Lost_Suttung' then
        local power = 100
    end

    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.PROTECT, power, 0, duration))

    return xi.effect.PROTECT
end

return mobskillObject
