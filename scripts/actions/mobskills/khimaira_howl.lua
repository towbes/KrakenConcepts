---------------------------------------------
-- Khimaira Howl
-- Description: Animation Only, used when Khim Roams or Tyger's Special Abilities
---------------------------------------------





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
