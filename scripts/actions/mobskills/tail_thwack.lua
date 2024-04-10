-----------------------------------
-- AOE Attack. Additional Effect: Defense Down -50%
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits  = 1
    local accmod   = 1
    local dmgmod   = 3
    local power    = 50
    local duration = 30
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.NUMSHADOWS_3)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.DEFENSE_DOWN, power, 0, duration)
    skill:setMsg(xi.msg.basic.DAMAGE_SECONDARY)
    return dmg
end

return mobskillObject
