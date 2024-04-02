-----------------------------------
-- Daze
-----------------------------------



-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1.5
    local dmgmod = 6.0

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.PIERCING, info.hitslanded)
    target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.PIERCING)
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
