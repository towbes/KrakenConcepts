-----------------------------------
-- Area: Attohwa Chasm
--  NPC: ???
-- !pos -402.574 3.999 -202.750 7
-----------------------------------
local ID = zones[xi.zone.ATTOHWA_CHASM]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if 
        npcUtil.tradeHas(trade, xi.items.ANTLION_TRAP) and
        npcUtil.popFromQM(player, npc, ID.mob.FEELER_ANTLION)
    then
        player:confirmTrade()
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.OCCASIONAL_LUMPS)
end

return entity
