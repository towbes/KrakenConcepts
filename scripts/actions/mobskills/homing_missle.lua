-----------------------------------
-- Homing Missle
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local targetcurrentHP = target:getHP()
    local targetmaxHP = target:getMaxHP()
    local hpset = targetmaxHP * 0.20
    local dmg = 0

    if targetcurrentHP > hpset then
        dmg = targetcurrentHP - hpset
    end

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.ELEMENTAL)

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIND, 1, 0, 30)

    return dmg
end

return mobskillObject
