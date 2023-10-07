-----------------------------------
--  Feral Peck
--
--  Description: Deals damage to a single target reducing their HP to 5%. Resets enmity.
--  Type: Physical
--  Utsusemi/Blink absorb: No
--  Range: Single Target
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/mobskills")
require("scripts/globals/magic")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if target:isBehind(mob, 96) then
        return 1
    else
        return 0
    end
end


mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local currentHP = target:getHP()
    local damage = 0

    -- if have more hp then 30%, then reduce to 10%
    if currentHP / target:getMaxHP() > 0.2 then
        damage = currentHP * 0.90
    else
        -- else you die
        damage = currentHP
    end

    local dmg = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    mob:resetEnmity(target)
    return dmg
end

return mobskillObject
