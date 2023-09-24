-----------------------------------
-- Recoil Dive
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getZone():getType() == xi.zoneType.DYNAMIS then
        skill:setAoE(4)
    end
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 3.5
    local shadowsTaken = xi.mobskills.shadowBehavior.NUMSHADOWS_1
    if mob:getZone():getType() == xi.zoneType.DYNAMIS then
        shadowsTaken = xi.mobskills.shadowBehavior.NUMSHADOWS_2
    end
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.CRIT_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, shadowsTaken)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    return dmg
end

return mobskillObject
