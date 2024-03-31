-----------------------------------
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    if target:checkDistance(mob) > 10  then
        skill:setMsg(xi.msg.basic.NONE)
        return 1
    end
    local dmgmod   = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 6, xi.element.WATER, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STR_DOWN, 20, 3, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DEX_DOWN, 20, 3, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.VIT_DOWN, 20, 3, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.AGI_DOWN, 20, 3, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.MND_DOWN, 20, 3, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.INT_DOWN, 20, 3, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.CHR_DOWN, 20, 3, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIO, 25, 3, 120)
    
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WATER)
    return dmg
end

return mobskillObject
