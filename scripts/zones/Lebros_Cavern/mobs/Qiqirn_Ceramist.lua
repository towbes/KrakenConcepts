-----------------------------------
-- Area: Lebros Cavern (Excavation Duty)
--  Mob: Qiqirn Ceramist
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    xi.assault.adjustMobLevel(mob)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.assault.addTempItem(mob, player, xi.item.QIQIRN_MINE, 50)
end

entity.onMobDespawn = function(mob)
end

return entity
