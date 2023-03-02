-----------------------------------
-- Bone Crusher
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if (mob:getID() == 17072171) then -- Ob
        if (mob:getHPP() > 50) then
            return 1 -- only used under 50%
        end
    end
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 2
    local accmod = 1
    local dmgmod = 2
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)

    local chance = 0.033 * skill:getTP()
    if target:getMod(xi.mod.STATUSRES) < 100 and target:getMod(xi.mod.STUNRES) < 100 then
        if not target:hasStatusEffect(xi.effect.STUN) and chance >= math.random()*100 then
    local typeEffect = xi.effect.STUN
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 0, 5)
        end
    end
    return dmg
end

return mobskillObject
