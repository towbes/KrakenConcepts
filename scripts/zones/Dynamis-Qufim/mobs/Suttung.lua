-----------------------------------
-- Area: Dynamis - Qufim
--  Mob: Suttung
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DMGMAGIC_CAP, 100)
    mob:setMod(xi.mod.DMGPHYS_CAP, 100)
    mob:setMod(xi.mod.DMGBREATH_CAP, 100)
    mob:setMod(xi.mod.DMGRANGE_CAP, 100)
end

entity.onMobFight = function(mob, target)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
