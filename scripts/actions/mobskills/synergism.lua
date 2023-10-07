---------------------------------------------
--  Synergism (1826)
--
--  Used by Dextrose ZNM
--  Description: Absorbs HP from any nearby flans, should not kill the target.
---------------------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    -- make sure to leave atleast 5% hp
    local neededHP = math.ceil(mob:getMaxHP() / 4)
    local expandableHP = target:getHP() - math.ceil(target:getMaxHP() * 0.05)

    local dmg = math.min(neededHP, expandableHP)
    skill:setMsg(xi.mobskills.mobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.HP, dmg))
    return dmg
end

return mobskillObject
