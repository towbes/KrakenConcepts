-----------------------------------
-- Area: Ranguemont Pass
--   NM: Tros
-- Involved in Quest: Painful Memory
-- !pos -289 -45 212 166
-----------------------------------
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.REGAIN, 150)
end

entity.onMobDeath = function(mob, player, optParams)
    if player:hasKeyItem(xi.ki.MERTAIRES_BRACELET) then
        player:setCharVar("TrosKilled", 1)
        player:setCharVar("Tros_Timer", os.time())
    end
end

return entity
