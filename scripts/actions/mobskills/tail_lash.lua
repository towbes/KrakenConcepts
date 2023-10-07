---------------------------------------------------
-- Tail Lash
-- Deals backwards arc damage to targets behind Amphiptere.
---------------------------------------------------



-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if not target:isBehind(mob, 96) then
        return 1
    else
        return 0
    end
end


mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 2
    local dmgmod = 2.0
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 2, 3, 4)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.NUMSHADOWS_3)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    return dmg
end

return mobskillObject
