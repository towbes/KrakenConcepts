-----------------------------------
-- Area: Mount Zhayolm
--   NM: Cerberus
-----------------------------------
local ID = zones[xi.zone.MOUNT_ZHAYOLM]
-----------------------------------
local entity = {}


local drawInPos =
{
    {330.00, -23.91, -89.09},
    {330.15, -24.00, -80.97},
    {323.57, -24.00, -80.17},
    {325.03, -24.00, -84.18},
    {321.71, -23.99, -87.13},
    {315.91, -24.14, -87.18},
    {315.18, -23.96, -80.03},
    {317.55, -23.95, -83.00},
}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.DRAW_IN, 1)
    mob:setMobMod(xi.mobMod.DRAW_IN_CUSTOM_RANGE, 15)
    mob:setMobMod(xi.mobMod.DRAW_IN_FRONT, 1)
    mob:setMod(xi.mod.STUNRES, -100) -- Need to adjust stunres so it's stunnable
    mob:setMod(xi.mod.MEVA, 350)
    mob:setMod(xi.mod.ICE_SDT, 200)
    mob:setMod(xi.mod.FIRE_SDT, 200)
    mob:useMobAbility(1892)
end

entity.onMobRoam = function(mob)
    howl = math.random()
    if howl > .95 then
        mob:useMobAbility(1892)
    end
end

entity.onMobFight = function(mob, target)
    if mob:getHPP() <= 75 and mob:getHPP() > 50 then
        mob:setMod(xi.mod.REGAIN, 60)
    elseif mob:getHPP() <= 50 and mob:getHPP() > 25 then
        mob:setMod(xi.mod.REGAIN, 40)
    elseif mob:getHPP() <= 25 then
        mob:setMod(xi.mod.REGAIN, 80)
    end

    local drawInWait = mob:getLocalVar('DrawInWait')

    if (target:getXPos() < 300 or target:getXPos() > 340) and os.time() > drawInWait then
        local rot = target:getRotPos()
        local position = math.random(1,8)
        target:setPos(drawInPos[position][1],drawInPos[position][2],drawInPos[position][3],rot)
        mob:messageBasic(232, 0, 0, target)
        mob:setLocalVar('DrawInWait', os.time() + 2)
    elseif (target:getZPos() < -95 or target:getZPos() > -67) and os.time() > drawInWait then
        local rot = target:getRotPos()
        local position = math.random(1,8)
        target:setPos(drawInPos[position][1],drawInPos[position][2],drawInPos[position][3],rot)
        mob:messageBasic(232, 0, 0, target)
        mob:setLocalVar('DrawInWait', os.time() + 2)
    end
end

entity.onMobWeaponSkillPrepare = function(mob, target)
    if mob:getHPP() <= 25 and math.random() <= 0.6 then   -- Weighted to favor GoH under 25%
        return 1790
    else
        return 0
    end

end

entity.onMobDisengage = function(mob)
    mob:useMobAbility(1892)
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.CERBERUS_MUZZLER)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(48, 72) * 3600) -- 48 - 72 hours with 1 hour windows
end

return entity
