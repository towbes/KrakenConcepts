-----------------------------------
--  Ice Guillotine
--
--  Description: Bites at all targets in front. Additional effect: Max HP Down
--  Type: Physical (piercing)
--  Utsusemi/Blink absorb: 2 shadows
--  Range: Front conal (7 yalms)
--  Notes: Scylla exclusive, this skill is not used on its own and will always come after Frozen Mist.
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1.5
    local dmgmod = 1.5
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.MAX_HP_DOWN, 12, 0, 300)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    return dmg
end

return mobskillObject
