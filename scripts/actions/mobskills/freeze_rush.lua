-----------------------------------
--  Freeze Rush
--  Description: Makes an icy charge at a single target.
--  Type: Magical
--  Utsusemi/Blink absorb: 1 shadow
--  Range: Melee
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = 2
    local shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_1
    if mob:getName() == "Nightmare_Snoll" then
        shadowBehavior = xi.mobskills.shadowBehavior.IGNORE_SHADOWS
    end
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.ICE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.ICE, shadowBehavior)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.ICE)
    return dmg
end

return mobskillObject
