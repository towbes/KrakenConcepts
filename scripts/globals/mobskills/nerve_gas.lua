-----------------------------------
-- Nerve Gas
--
-- Description: Inflicts curse and powerful poison xi.effect.
-- Type: Magical
-- Wipes Shadows
-- Range: 10' Radial
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getFamily() == 316 then -- PW
        local mobSkin = mob:getModelId()
        if mobSkin == 1796 then
            return 0
        else
            return 1
        end
    elseif mob:getFamily() == 313 then -- Tinnin can use at will
        return 0
    else
        if (mob:getAnimationSub() == 0 and mob:getHPP() <= 25) then -- Only used when all 3 Hydra heads alive
            if (mob:getID() == 17093003) and (mob:getInstance():getStage() ~= 100) then -- Nyzul Isle Hydra will only use this on floor 100
                return 1
            end
            return 0
        else
            return 1

        end
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)

    local cursePower = 50
    local poisonPower = 20
    local dmgmod = 1

    if (mob:getID() == 17093003) then -- Nyzul Isle Hydra
        cursePower = 30
        poisonPower = 15
        dmgmod = 1
    end

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 5, xi.magic.ele.NONE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.NONE, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.NONE)

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.CURSE_I, cursepower, 0, 420))
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, poisonpower, 3, 60)
    return dmg
end

return mobskillObject
