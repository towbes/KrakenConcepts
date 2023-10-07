-----------------------------------
-- Foot Kick
-- Deals critical damage. Chance of critical hit varies with TP.
-- 100% TP: ??? / 200% TP: ??? / 300% TP: ???
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 2.6
    local shadowsTaken = xi.mobskills.shadowBehavior.NUMSHADOWS_1
    if mob:getZone():getType() == xi.zoneType.DYNAMIS then
        shadowsTaken = xi.mobskills.shadowBehavior.IGNORE_SHADOWS
    end
    
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.CRIT_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, shadowsTaken)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    return dmg
end

return mobskillObject
