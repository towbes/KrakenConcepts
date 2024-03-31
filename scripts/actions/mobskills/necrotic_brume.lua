-----------------------------------
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = 1
    local duration = math.random(10, 15)
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 4.5, xi.element.DARK, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 25, 0, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 25, 0, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.CURSE_II, 200, 0, duration)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.DARK)
    return dmg
end

return mobskillObject
