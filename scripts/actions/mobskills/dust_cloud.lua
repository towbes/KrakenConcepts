-----------------------------------
-- Dust Cloud
-- Deals Earth damage to targets in a fan-shaped area of effect. Additional effect: Blind
-- Range: 10' cone
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local duration = 120

    if mob:getMainLvl() < 10 then
        duration = duration / 2
    end

    local dmgmod = 1
    local info   = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg(), xi.element.EARTH, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 0, 0, 1.75, 2, 2.25)
    local dmg    = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.EARTH, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.EARTH)
    xi.mobskills.handleMobBurstMsg(mob, target, skill, xi.element.EARTH)

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 15, 0, duration)

    return dmg
end

return mobskillObject
