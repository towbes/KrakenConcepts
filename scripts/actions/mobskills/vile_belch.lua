---------------------------------------------
--  Sea Spray
--  utsusemi/Blink absorb: Ignores shadows
--  Description: Deals water damage that inflicts slow in a cone
--  Type: Magical (Water/Breath)
--  Range:
---------------------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/status")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local plagued = false
    local silence = false
    local typeEffect

    plagued = xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PLAGUE, 5, 3, 60)
    silence = xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SILENCE, 1, 0, 60)

    skill:setMsg(xi.msg.basic.SKILL_ENFEEB_IS)

    -- display plague first, else silence
    if plagued == xi.msg.basic.SKILL_ENFEEB_IS then
        typeEffect = xi.effect.PLAGUE
    elseif silence == xi.msg.basic.SKILL_ENFEEB_IS then
        typeEffect = xi.effect.SILENCE
    else
        skill:setMsg(xi.msg.basic.SKILL_MISS)
    end

    return typeEffect
end


return mobskillObject
