-----------------------------------
-- Substitute
-- Dummy ability used for 2hr animation by Jailer of Love.
-----------------------------------
require("scripts/globals/mobskills")
require("settings/main")
require("scripts/globals/status")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.msg.basic.NONE)
    return 0
end

return mobskillObject
