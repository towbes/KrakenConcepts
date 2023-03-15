-----------------------------------
-- Area: Ceizak Battlegrounds
-- NPC: Root
-----------------------------------
-- require("scripts/globals/colonization_reives")
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/zone")
local ID = require('scripts/zones/Ceizak_Battlegrounds/IDs')
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local zone = npc:getZone()
    local resultTable = zone:queryEntitiesByName('_790')
    local resultTable2 = zone:queryEntitiesByName('_791')

    resultTable[1]:openDoor(50)
    resultTable2[1]:openDoor(50)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
