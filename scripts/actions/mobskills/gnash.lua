-----------------------------------
--  Deathgnash
--  Deals damage to a single target (Sets HP to 1 for target).
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
    local hpp = mob:getHPP()
    if mob:getID() == 16998874 then
        if hpp > 50 then
            return 0
        else
            return 1
         end
    else
        return 0
    end
end


mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local currentHP = target:getHP()
    -- remove all by 5%
    local damage = 0


    -- if have more hp then 50%, then reduce
    if (target:getHPP() > 5) then
        damage = currentHP * .5
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
