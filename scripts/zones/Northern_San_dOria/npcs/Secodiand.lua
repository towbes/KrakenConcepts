-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Secodiand
-- Starts and Finishes Quest: Fear of the dark
-- !pos -160 -0 137 231
-----------------------------------
require("scripts/globals/shop")
require("scripts/globals/quests")
local ID = require("scripts/zones/Northern_San_dOria/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
