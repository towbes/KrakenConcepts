-----------------------------------
-- Fireball
-- Deals Fire damage in an area of effect.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg(), xi.element.FIRE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 2.75, 4, 5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    xi.mobskills.handleMobBurstMsg(mob, target, skill, xi.element.FIRE)
    return dmg
end

return mobskillObject
