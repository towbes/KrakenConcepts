-----------------------------------
-- mantid_melee_jump
-- AOE Auto.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    if target:checkDistance(mob) > 10 then
        skill:setMsg(xi.msg.basic.NONE)
        return 1
    end
    local numhits = 1
    local accmod  = 1
    local dmgmod  = 2
    local info    = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg     = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    skill:setMsg(xi.msg.basic.DAMAGE_SECONDARY)
    return dmg
end

return mobskillObject
