---------------------------------------------
-- Skill: Heliovoid
-- Absorbs one status effect from all players in range.
-- Type: Magical
-- Utsusemi/Blink absorb: 1 shadow
-- Range: Melee
---------------------------------------------
-----------------------------------




-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    -- try to drain buff
    local effect = mob:stealStatusEffect(target, xi.effectFlag.DISPELABLE)
    if effect ~= 0 then
        skill:setMsg(xi.msg.basic.EFFECT_DRAINED)
        return 1
    else
        skill:setMsg(xi.msg.basic.NO_EFFECT) -- no effect
    end
end

return mobskillObject