-----------------------------------
-- AOE Blind, Paralysis, Silence centered on mob.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 50, 0, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 35, 0, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SILENCE, 1, 0, 60)
    skill:setMsg(xi.msg.basic.NONE)
end

return mobskillObject
