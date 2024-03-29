-----------------------------------
--  Cursed Sphere
--  Description: Deals Dark damage to enemies within area of effect.
--  Type: Magical Dark (Element)
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod       = 1
    local tpvalue      = 0
    local ignoreresist = 0
    local info         = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg(), xi.element.DARK, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, tpvalue, ignoreresist, 2, 3, 4)
    local dmg          = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.DARK)
    xi.mobskills.handleMobBurstMsg(mob, target, skill, xi.element.DARK)
    return dmg
end

return mobskillObject
