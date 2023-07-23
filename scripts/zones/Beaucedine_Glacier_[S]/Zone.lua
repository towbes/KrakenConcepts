-----------------------------------
-- Zone: Beaucedine_Glacier_[S] (136)
-----------------------------------
local ID = require('scripts/zones/Beaucedine_Glacier_[S]/IDs')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    xi.voidwalker.zoneOnInit(zone)
    local ScyllaRespawn = GetServerVariable("ScyllaRespawn")
    if os.time() < ScyllaRespawn then
        GetMobByID(ID.mob.SCYLLA):setRespawnTime(ScyllaRespawn - os.time())
    else
        SpawnMob(ID.mob.SCYLLA)
    end
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-180, -81.85, 280, 44)
    end

    return cs
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

return zoneObject
