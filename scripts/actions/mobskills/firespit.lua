-----------------------------------
--  Firespit
--  Description: Deals fire damage to an enemy.
--  Type: Magical (Fire)
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
--    if mob:getFamily() == 91 then
--        local mobSkin = mob:getModelId()
--
--        if mobSkin == 1639 then
--            return 0
--        else
--            return 1
--        end
--    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)

    if mob:getFamily() == 176 then
        local mobSkin = mob:getModelId()

        if mobSkin == 1618 then
    local numhits = 3
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 4, xi.magic.ele.FIRE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT) -- Check for phys Umeboshi
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)

    return dmg
else

    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 4, xi.element.FIRE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)

    return dmg
end
elseif mob:getFamily() == 305 then -- Gotoh Zha the Redolent

    local numhits = 3
    local accmod = 1
    local dmgmod = 3

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 4, xi.magic.ele.FIRE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    -- scale dmg based on distance from mob when past 10 yalms: normal dmg < 10 yalms, linear reduction up to 80% reduction at 30yalms
    dmg = dmg * (1 - utils.clamp(math.max(mob:checkDistance(target) - 10, 0) / 25, 0, .8))
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)

    return dmg
end
end
return mobskillObject
