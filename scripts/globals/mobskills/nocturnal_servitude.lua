-----------------------------------
---Nocturnal Servitude
-- Family: Porrogo
-- Description: Charms target and transforms them into a bat.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: N/A
-- Range: Radial
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.CHARM_I
    local power = 0

    if not target:isPC() then
        skill:setMsg(xi.msg.basic.SKILL_MISS)
        return typeEffect
    end

    local msg = xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, 3, 60)
    if msg == xi.msg.basic.SKILL_ENFEEB_IS then
        target:addStatusEffect(xi.effect.COSTUME_II, 256, 0, 60) -- 1812 alternate froggo costume but doesnt seem to work!
        mob:charm(target)
        mob:resetEnmity(target)
    end

    skill:setMsg(msg)

    return typeEffect
end

return mobskillObject
