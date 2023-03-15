-----------------------------------
-- Area: Ceizak Battlegrounds
-- NPC: Root
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/zone")
local entity = {}
local resultTable = {}

entity.onMobSpawn = function(mob)
end

entity.onMobDeath = function(mob, npc, player, optParams)
    local zone = npc:getZone()
    local resultTable = zone:queryEntitiesByName('_790')
    local resultTable2 = zone:queryEntitiesByName('_791')
    mob:setAnimation(xi.animation.OPEN_DOOR)
    resultTable[1]:openDoor(50)
    resultTable2[1]:openDoor(50)
end

return entity
