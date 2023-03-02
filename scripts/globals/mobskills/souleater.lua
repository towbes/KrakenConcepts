-----------------------------------
-- Souleater
-- Souleater Ability.
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.SOULEATER
    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, 1, 60))
    return typeEffect
end

return mobskillObject
