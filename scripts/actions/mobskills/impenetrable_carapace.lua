-----------------------------------
-- Impenetrable Carapace
-- Enhances defense & magic evasion.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect  = xi.effect.DEFENSE_BOOST
    local typeEffect2 = xi.effect.MAGIC_EVASION_BOOST

    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, 50, 0, 60))
    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect2, 50, 0, 60))

    return typeEffect
end

return mobskillObject
