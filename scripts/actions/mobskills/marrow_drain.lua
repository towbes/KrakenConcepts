-----------------------------------
-- Marrow Drain
-- Steals an enemy's MP. Ineffective against undead.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:isMobType(xi.mobskills.mobType.NOTORIOUS) then
        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    if mob:getID() == 16945320 then -- Stringes
        local dmgmod = 3.5 * (math.random(90, 110) / 100)
        local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 2.3, xi.magic.ele.DARK, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
        local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
        skill:setMsg(xi.mobskills.mobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.HP, dmg))

        return dmg

    else
        local dmgmod = 1
        local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 2.3, xi.magic.ele.DARK, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
        local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    
        skill:setMsg(xi.mobskills.mobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.MP, dmg))

        return dmg

    end
end

return mobskillObject
