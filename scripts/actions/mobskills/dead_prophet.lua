-----------------------------------
--  Throat Stab
--
--  Description: Deals damage to a single target reducing their HP to 5%. Resets enmity.
--  Type: Physical
--  Utsusemi/Blink absorb: No
--  Range: Single Target
--  Notes: Very short range, easily evaded by walking away from it.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    if not target:isInfront(mob, 48) or target:checkDistance(mob) > 15  then
        skill:setMsg(xi.msg.basic.NONE)
        return 1
    end
    local currentHP = target:getHP()
    local damage    = currentHP

    -- if have more hp then 30%, then reduce to 5%
    if target:hasStatusEffect(xi.effect.HEALING) then
        damage = currentHP * 0.75
        target:messageBasic(xi.msg.basic.NARROWLY_ESCAPE)
    else
        -- else you die
        damage = currentHP * 1.50
    end

    local dmg = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    return dmg
end

return mobskillObject
