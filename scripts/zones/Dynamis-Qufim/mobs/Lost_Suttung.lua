-----------------------------------
-- Area: Dynamis - Qufim
--  Mob: Suttung
-----------------------------------
mixins =
{
    require('scripts/mixins/dynamis_beastmen')
}
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.HP_SCALE, 750)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.ACC, 225)
    mob:setMod(xi.mod.ATT, 500)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 0)
    mob:setMod(xi.mod.DMGMAGIC_CAP, 100)
    mob:setMod(xi.mod.DMGPHYS_CAP, 100)
    mob:setMod(xi.mod.DMGBREATH_CAP, 100)
    mob:setMod(xi.mod.DMGRANGE_CAP, 100)
    mob:setMod(xi.mod.SLEEPRES, 99)
    mob:setMod(xi.mod.LULLABYRES, 99)
    -- Adding Normal Dynamis Boss Resistances and Regain
    mob:setMod(xi.mod.GRAVITYRES, 40)
    mob:setMod(xi.mod.BINDRES, 40)
    mob:setMod(xi.mod.REGAIN, 100)
    mob:setMod(xi.mod.STUNRES, 99)
end

entity.onMobFight = function(mob, target)
    for _, member in pairs(target:getParty()) do
        if member:getObjType() == xi.objType.PC then
        member:changeMusic(2, 88)
        member:changeMusic(3, 88)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    for _, member in pairs(player:getParty()) do
        if member:getObjType() == xi.objType.PC then
        member:changeMusic(2, 121)
        member:changeMusic(3, 121)
        end
    end
end

return entity
