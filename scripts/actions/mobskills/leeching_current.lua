-----------------------------------
-- Leeching Current
-- Steals enemy HP (AoE). 
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    local hpp = mob:getHPP()
    if mob:getID() == 16998874 then
        if hpp <= 50 then
           return 0
        else
            return 1
        end
    else
        return 0
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dmgspread = 1000 / skill:getTotalTargets()
    local dmgmod = 1
    local info   = xi.mobskills.mobMagicalMove(mob, target, skill, dmgspread, xi.magic.ele.WATER, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg    = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

        skill:setMsg(xi.mobskills.mobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.HP, dmg))

    return dmg
end

return mobskillObject
