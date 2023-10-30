-----------------------------------
-- Area: Caedarva Mire
--   NM: Khimaira
-----------------------------------
require('scripts/globals/toau')
local ID = zones[xi.zone.CAEDARVA_MIRE]
-----------------------------------
local entity = {}

local drawInPos =
{
    {838.88,  0.00, 358.86},
    {834.93, -0.14, 363.68},
    {840.13, -0.31, 366.46},
    {842.69,  0.00, 360.12},
    {846.15, -0.27, 360.25},
    {845.30, -0.51, 366.68},
    {850.33, -1.34, 365.43},
    {850.40, -1.45, 355.85},
}

entity.onMobInitialize = function(mob)
    xi.toau.mobSpecialHook('KHIMAIRA', mob, 1, function(mob)
        if mob:getAnimationSub() == 0 then
            mob:setAnimationSub(1)
        end
    end)

    mob:addListener('EFFECT_LOSE', 'KHIMAIRA_EFFECT_LOSE', function(owner, effect)
        local effectType = effect:getTypeMask()
        if effectType == xi.effect.STUN then
            owner:addMod(xi.mod.STUNRES, 5)
        end
    end)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 20)
    mob:setMod(xi.mod.MDEF, 100) -- 385 * 1.32/2 = 254 nether blast
    mob:setMod(xi.mod.STATUSRES, 50)
    mob:setMod(xi.mod.PARALYZERES, 50)
    mob:setMod(xi.mod.STUNRES, -75)
    mob:setAnimationSub(0)
end

entity.onMobFight = function(mob, target)
    local drawInWait = mob:getLocalVar('DrawInWait')

    if (target:getXPos() < 814 or target:getXPos() > 865) and os.time() > drawInWait then
        local rot = target:getRotPos()
        local position = math.random(1,8)
        target:setPos(drawInPos[position][1],drawInPos[position][2],drawInPos[position][3],rot)
        mob:messageBasic(232, 0, 0, target)
        mob:setLocalVar('DrawInWait', os.time() + 2)
    elseif (target:getZPos() < 345 or target:getZPos() > 377) and os.time() > drawInWait then
        local rot = target:getRotPos()
        local position = math.random(1,8)
        target:setPos(drawInPos[position][1],drawInPos[position][2],drawInPos[position][3],rot)
        mob:messageBasic(232, 0, 0, target)
        mob:setLocalVar('DrawInWait', os.time() + 2)
    end
end

entity.onMobEngaged = function (mob, target)
    if mob:getHPP() == 100 then
        mob:setMod(xi.mod.STUNRES, -75)
    end
end


entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.KHIMAIRA_CARVER)
end

entity.onMobDespawn = function(mob)
    local respawn = math.random(48,72)*3600 -- 48 to 72 hours in 60min windows
    --UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(respawn)
	--SetServerVariable('KhimairaRespawn',(os.time() + respawn))
end

return entity
