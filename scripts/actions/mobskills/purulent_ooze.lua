-----------------------------------
-- Purulent Ooze
-- Family: Slugs
-- Description: Deals Water damage in a fan-shaped area of effect. Additional effect: Bio and Max HP Down
-- Type: Magical
-- Utsusemi/Blink absorb: Wipes shadows
-- Range: Cone
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = 1
    local baseDamage = mob:getWeaponDmg()
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, baseDamage, xi.element.WATER, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1, 0, 3, 3.5, 4)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIO, 5, 3, 120, 0, 10)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.MAX_HP_DOWN, 10, 0, 120)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WATER)
    xi.mobskills.handleMobBurstMsg(mob, target, skill, xi.element.WATER)
    return dmg
end

return mobskillObject
