-----------------------------------
-- Miasmic Breath
-- Description: A toxic odor is exhaled on any players in a fan-shaped area of effect.
-- Type: Breath
-- Utsusemi/Blink absorb: Ignores Shadows
-- Range: 15' Conal
-- Notes: Only used by Cirrate Christelle
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)

    local typeEffect = xi.effect.POISON
    local power = math.random(150, 200)

    if mob:getLocalVar("itemDebuff_Fungus") == 0 then
        power = 30
        if mob:getName() == "Arch_Christelle" then
            power = 75
        end
    end

    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, 3, 60)
    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.1, 1.25, xi.magic.ele.FIRE, 200)

    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.FIRE)
    return dmg
end

return mobskillObject
