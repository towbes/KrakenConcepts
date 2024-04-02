-----------------------------------
-- Area: Dynamis - Xarcabard
--  Mob: Vanguards Avatar
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
end

entity.onMobSpawn = function(mob)
    local avatarRoll = math.random(1,6)
    if avatarRoll == 1 then
        mob:setModelId(19) -- Titan
        mob:setMobMod(xi.mobMod.SKILL_LIST, 45)
    elseif avatarRoll == 2 then
        mob:setModelId(18) -- Ifrit
        mob:setMobMod(xi.mobMod.SKILL_LIST, 38)
    elseif avatarRoll == 3 then
        mob:setModelId(20) -- Leviathan
        mob:setMobMod(xi.mobMod.SKILL_LIST, 40)
    elseif avatarRoll == 4 then
        mob:setModelId(23) -- Ramuh
        mob:setMobMod(xi.mobMod.SKILL_LIST, 43)
    elseif avatarRoll == 5 then
        mob:setModelId(21) -- Garuda
        mob:setMobMod(xi.mobMod.SKILL_LIST, 37)
    elseif avatarRoll == 6 then
        mob:setModelId(22) -- Shiva
        mob:setMobMod(xi.mobMod.SKILL_LIST, 44)
    end
end

entity.onMobFight = function(mob, target)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
