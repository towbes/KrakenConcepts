-----------------------------------
-- Bomb Toss
-- Throws a bomb at an enemy.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    local suicideCheck = math.random(0, 100)

    if
        not mob:isNM() and
        not mob:isInDynamis() and
        suicideCheck <= 15 -- 15% chance to use bomb_toss_suicide if bomb_toss is picked (50%)
    then
        mob:useMobAbility(592)
        return 1
    end
    
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.element.FIRE, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    
    if mob:getName() == "Wilywox_Tenderpalm" then
        local bombTossHPP = 1 + (mob:getMaxHP() / mob:getHP()) / 100 * 1.25 -- Bomb Toss power increases at lower HP
        local power = math.random(5, 7)
         dmgmod = 1
         info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * bombTossHPP * power, xi.magic.ele.FIRE, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
         dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    end
    
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    return dmg
end

return mobskillObject
