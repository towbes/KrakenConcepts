-----------------------------------
-- Area: Dynamis-Tavnazia
--  Mob: Diabolos Club
-- Note: Mega Boss
-----------------------------------
require('scripts/globals/dynamis')
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = 1911, hpp = 80, 
            begCode = function(mob)
                end,
            endCode = function(mob)
            end,},
            { id = 1908, hpp = math.random(40, 50), 
            begCode = function(mob)
                end,
            endCode = function(mob)
            end,},
        },
    })
end

entity.onMobFight = function(mob, target)
    for _, member in pairs(target:getParty()) do
        if member:getObjType() == xi.objType.PC then
        member:changeMusic(2, 239)
        member:changeMusic(3, 239)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.dynamis.megaBossOnDeath(mob, player, optParams)
    player:addTitle(xi.title.NIGHTMARE_AWAKENER)
    for _, member in pairs(player:getParty()) do
        if member:getObjType() == xi.objType.PC then
        member:changeMusic(2, 121)
        member:changeMusic(3, 121)
        end
    end
end

return entity
