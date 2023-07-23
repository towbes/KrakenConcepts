-----------------------------------
-- Zone: Lufaise_Meadows (24)
-----------------------------------
local ID = require('scripts/zones/Lufaise_Meadows/IDs')
require('scripts/globals/conquest')
require('scripts/globals/items')
require('scripts/globals/keyitems')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/titles')
require('scripts/globals/helm')
require('scripts/globals/exp_controller')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    zone:registerTriggerArea(1, 179, -26, 327, 219, -18, 347)

    SetServerVariable("realPadfoot", math.random(1, 5))
    for _, v in pairs(ID.mob.PADFOOT) do
        local respawnP = GetServerVariable("\\[SPAWN\\]"..v)
        if os.time() > respawnP then
            SpawnMob(v)
        else
            GetMobByID(v):setRespawnTime(respawnP - os.time())
        end
    end

    GetMobByID(ID.mob.YALUN_EKE):setLocalVar("chooseYalun", math.random(1, 2))

    xi.conq.setRegionalConquestOverseers(zone:getRegionID())

    xi.helm.initZone(zone, xi.helm.type.LOGGING)
    xi.exp_controller.onInitialize(zone)

end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conq.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(458, 6, -4, 82)
    end

    return cs
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onTriggerAreaLeave = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 116 then
        player:setCharVar("PromathiaStatus", 7)
        player:addTitle(xi.title.BANISHER_OF_EMPTINESS)
    end
end

return zoneObject
