-----------------------------------
-- Area: Dynamis-Tavnazia
--  Mob: Diabolos Nox
-- Note: Mega Boss
-----------------------------------
require('scripts/globals/dynamis')
-----------------------------------
mixins =
{
    require('scripts/mixins/dynamis_beastmen')
}
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addListener('TAKE_DAMAGE', 'SOMNUS_TAKE_DAMAGE', function(mob, amount, attacker, attackType, damageType)

        if attackType == xi.attackType.MAGICAL and amount > 0 then
            mob:addMod(xi.mod.UDMGPHYS, 25)
            mob:addMod(xi.mod.UDMGMAGIC, -25)

        elseif attackType == xi.attackType.PHYSICAL and amount > 0 then
            mob:addMod(xi.mod.UDMGPHYS, -25)
            mob:addMod(xi.mod.UDMGMAGIC, 25)
        end
    end)
    mob:setMobMod(xi.mobMod.HP_SCALE, 500)
    mob:setLocalVar('[isDynamis_Arch_Megaboss]', 1)
end

entity.onMobSpawn = function(mob)
    mob:timer(3000, function(mobArg)
            -- NoctoShield
            mobArg:useMobAbility(1905, mob)
    end)
    mob:setMod(xi.mod.UDMGPHYS, 0)
    mob:setMod(xi.mod.UDMGMAGIC, 0)
    mob:setMod(xi.mod.REGAIN, 400)
end

entity.onMobFight = function(mob, target)
    for _, member in pairs(target:getParty()) do
        if member:getObjType() == xi.objType.PC then
        member:changeMusic(2, 239)
        member:changeMusic(3, 239)
        end
    end
    -- Damage reduction caps at 90% in both directions.
    if mob:getMod(xi.mod.UDMGPHYS) > 9000 then 
        mob:setMod(xi.mod.UDMGPHYS, 9000)
    elseif mob:getMod(xi.mod.UDMGPHYS) < -9000 then
        mob:setMod(xi.mod.UDMGPHYS, -9000)
    end
    if mob:getMod(xi.mod.UDMGMAGIC) > 9000 then 
        mob:setMod(xi.mod.UDMGMAGIC, 9000)
    elseif mob:getMod(xi.mod.UDMGMAGIC) < -9000 then
        mob:setMod(xi.mod.UDMGMAGIC, -9000)
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() == 1905 then
        mob:castSpell(277, mob)
    end
end

entity.onSpellPrecast = function(mob, spell)
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.NIGHTMARE_AWAKENER)
    mob:resetLocalVars()
    for _, member in pairs(player:getParty()) do
        if member:getObjType() == xi.objType.PC then
        member:changeMusic(2, 121)
        member:changeMusic(3, 121)
        end
    end
end

return entity
