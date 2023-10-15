-----------------------------------
-- Area: Dynamis-Tavnazia
--  Mob: Diabolos Umbra
-- Note: Mega Boss
-----------------------------------
require('scripts/globals/dynamis')
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.DMGPHYS, 5000)
    mob:setMod(xi.mod.MDEF, 25)
    mob:setMobMod(xi.mobMod.HP_SCALE, 500)
end

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = 1911, hpp = 80, 
            begCode = function(mob)
                mob:setLocalVar('omenUsed', 1)  
                end,
            endCode = function(mob)
            end,},
            { id = 1908, hpp = math.random(40, 50), 
            begCode = function(mob)
                mob:setLocalVar('nightmareUsed', 1)  
                end,
            endCode = function(mob)
            end,},
        },
    })

    mob:timer(3000, function(mobArg)
            -- Cacodemonia
            mobArg:useMobAbility(1909)
    end)
end

entity.onMobFight = function(mob, target)
    for _, member in pairs(target:getParty()) do
        if member:getObjType() == xi.objType.PC then
        member:changeMusic(2, 239)
        member:changeMusic(3, 239)
        end
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    local DiabolosUmbra = mob:getID()
    local Vestige1      = GetMobByID(DiabolosUmbra + 1)
    local Vestige2      = GetMobByID(DiabolosUmbra + 2)
    local x = mob:getXPos()
    local y = mob:getYPos()
    local z = mob:getZPos()
    
    if mob:getLocalVar('omenUsed') == 1 then
        Vestige1:setSpawn(x + math.random(-4, 4), y, z + math.random(-4, 4))
        Vestige1:spawn()
        Vestige1:updateEnmity(target)
    end
    if mob:getLocalVar('nightmareUsed') == 1 then
        Vestige2:setSpawn(x + math.random(-4, 4), y, z + math.random(-4, 4))
        Vestige2:spawn()
        Vestige2:updateEnmity(target)
    end
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
