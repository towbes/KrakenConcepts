---------------------------------------------------
-- Seismic Tail
-- Deals extreme damage to targets behind the user.
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
    local numhits = math.random(2, 3)
    local accmod  = 2
    local dmgmod  = 0.80

    local info           = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 2, 3, 4)
    local dmg            = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, xi.mobskills.shadowBehavior.NUMSHADOWS_3)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    
    if mob:getID() == 16998874 then
        mob:setLocalVar('Phase', 1)
        mob:setLocalVar('Changed',1)
    end

    return dmg
end

return mobskillObject
