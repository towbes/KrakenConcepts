-----------------------------------
-- Meteorite
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    local dint = pet:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)
    local dmg = 500 + dint * 1.5 + pet:getTP() / 20

    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    target:updateEnmityFromDamage(pet, dmg)
    target:takeDamage(dmg, pet, xi.attackType.MAGICAL, xi.damageType.LIGHT)

    local ele = xi.element.LIGHT
    local magicBurst = xi.mobskills.calculateMobMagicBurst(pet, ele, target)
    if (magicBurst > 1) and target:hasStatusEffect(xi.effect.SKILLCHAIN) then -- Gated as this is run per target.
        skill:setMsg(xi.msg.basic.JA_MAGIC_BURST)
    else
        skill:setMsg(xi.msg.basic.DAMAGE)
    end

    return dmg
end

return abilityObject
