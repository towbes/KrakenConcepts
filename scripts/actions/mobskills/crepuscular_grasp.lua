-----------------------------------
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.element.DARK, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIO, 15, 0, 120)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.DARK)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIND, 1, 0, 120)
    return dmg
end

return mobskillObject
