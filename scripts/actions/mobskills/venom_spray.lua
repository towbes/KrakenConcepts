-----------------------------------
--  Venom Spray
--
--  Description: Deals damage in a fan shaped area. Additional effect: poison
--  Type: Magical Water
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: 10' cone
--  Notes: Additional effect can be removed with Poisona.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = mob:getMainLvl() / 8 + 10

    local duration = 60
    local master = mob:getMaster()
    local skillID = skill:getID()
    if mob:isPet() then
        if master and master:isJugPet() then
            local tp = skill:getTP()
            duration = 300
            duration = math.max(60, duration * (tp/1000)) -- Minimum 60 minutes. Maximum 9 minutes.
        end
    end

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, power, 3, duration)

    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 1.8, xi.element.WATER, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 1.5, 1.75, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WATER)
    xi.mobskills.handleMobBurstMsg(mob, target, skill, xi.element.WATER)
    return dmg
end

return mobskillObject
