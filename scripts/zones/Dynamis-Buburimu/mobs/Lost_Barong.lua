-----------------------------------
-- Area: Dynamis - Buburimu
--  Mob: Barong
-----------------------------------
mixins =
{
    require('scripts/mixins/dynamis_beastmen')
}
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.HP_SCALE, 1000)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.SKILL_LIST, 5373)
    mob:setMod(xi.mod.REGAIN, 1250)
end

entity.onMobFight = function(mob, target)
    for _, member in pairs(target:getParty()) do
        if member:getObjType() == xi.objType.PC then
        member:changeMusic(2, 88)
        member:changeMusic(3, 88)
        end
    end
    
    -- Resets threat on every auto attack
    mob:addListener('ATTACK', 'BARONG_ATTACK', function(barong)
        barong:resetEnmity(target)
    end)
end

entity.onMobDeath = function(mob, player, optParams)
    mob:removeListener('BARONG_ATTACK')
    for _, member in pairs(player:getParty()) do
        if member:getObjType() == xi.objType.PC then
        member:changeMusic(2, 121)
        member:changeMusic(3, 121)
        end
    end
end

return entity
