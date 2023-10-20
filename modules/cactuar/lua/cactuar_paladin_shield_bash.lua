-----------------------------------
-- Old setting from settings.lua: HOMEPOINT_HEAL
-- Set if you want Home Points to heal you like in single-player Final Fantasy games.
-----------------------------------
require('modules/module_utils')


require('scripts/actions/abilities/shield_bash')
-----------------------------------
local m = Module:new('cactuar_paladin_shield_bash')

m:addOverride('xi.actions.abilities.shield_bash.onUseAbility', function(player, target, ability)
    local shieldSize = player:getShieldSize()
    local jpValue = player:getJobPointLevel(xi.jp.SHIELD_BASH_EFFECT)
    local damage = 0
    local chance = 90

    damage = player:getMod(xi.mod.SHIELD_BASH)

    if shieldSize == 1 or shieldSize == 5 then
        damage = 25 + damage
    elseif shieldSize == 2 then
        damage = 38 + damage
    elseif shieldSize == 3 then
        damage = 65 + damage
    elseif shieldSize == 4 then
        damage = 90 + damage
    end

    -- Main job factors
    if player:getMainJob() == xi.job.PLD or player:getSubJob() == xi.job.PLD then
        damage = math.floor(damage)
    else
        damage = math.floor(damage / 2.2)
        chance = 80
    end

    damage = damage + jpValue * 10

    -- Calculate stun proc chance
    chance = chance + (player:getMainLvl() - target:getMainLvl()) * 5

    if math.random() * 100 < chance then
        target:addStatusEffect(xi.effect.STUN, 1, 0, 6)
    end

    -- Randomize damage
    local ratio = player:getStat(xi.mod.ATT) / target:getStat(xi.mod.DEF)

    if ratio > 1.3 then
        ratio = 1.3
    end

    if ratio < 0.2 then
        ratio = 0.2
    end

    local pdif = math.random(ratio * 0.8 * 1000, ratio * 1.2 * 1000)
    damage = damage * (pdif / 1000)
    damage = utils.stoneskin(target, damage)

    target:takeDamage(damage, player, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    target:updateEnmityFromDamage(player, damage)
    ability:setMsg(xi.msg.basic.JA_DAMAGE)

    return damage
end)

return m
