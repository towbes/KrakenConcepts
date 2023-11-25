-----------------------------------
-- preying_posture
-- Enhances defense & magic evasion.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.msg.basic.NONE)
    xi.mobskills.mobBuffMove(mob, xi.effect.MAGIC_ATK_BOOST, 50, 0, 60)
    mob:messageBasic(xi.msg.basic.GAINS_EFFECT_OF_STATUS, xi.effect.MAGIC_ATK_BOOST)
    xi.mobskills.mobBuffMove(mob, xi.effect.ATTACK_BOOST, 50, 0, 60)
    mob:messageBasic(xi.msg.basic.GAINS_EFFECT_OF_STATUS, xi.effect.ATTACK_BOOST)
    xi.mobskills.mobBuffMove(mob, xi.effect.ACCURACY_BOOST, 50, 0, 60)
    mob:messageBasic(xi.msg.basic.GAINS_EFFECT_OF_STATUS, xi.effect.ACCURACY_BOOST)
    xi.mobskills.mobBuffMove(mob, xi.effect.INTENSION, 50, 0, 60)
    mob:messageBasic(xi.msg.basic.GAINS_EFFECT_OF_STATUS, xi.effect.INTENSION)
end

return mobskillObject
