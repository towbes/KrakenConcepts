-----------------------------------
-- Putrid Breath
-- Description: Deals breath damage to enemies around the target.
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
    local cap = 1500
    
    if mob:getLocalVar("itemDebuff_Root") == 0 then
        cap = 500
        if mob:getName() == "Arch_Christelle" then
            cap = 800
        end
    end

    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.15, 3, xi.magic.ele.EARTH, cap)
    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.EARTH, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.EARTH)

    return dmg
end

return mobskillObject
