-----------------------------------
--  Broadside Barrage
--
--  Description: Damage varies with TP.
--  Type: Physical (Blunt)
--  Reduces INT and MND
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
    local dmgmod = 2.5
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)

    if dmg > 0 then
        xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.INT_DOWN, 10, 0, 60)
        xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.MND_DOWN, 10, 0, 60)
    end

    return dmg
end

return mobskillObject
