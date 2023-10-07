-----------------------------------
-- Zone: Lufaise_Meadows (24)
require('scripts/globals/exp_controller')
local ID = zones[xi.zone.LUFAISE_MEADOWS]
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    zone:registerTriggerArea(1, 179, -26, 327, 219, -18, 347)

    SetServerVariable('realPadfoot', math.random(1, 5))
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
    if
        triggerAreaID == 1 and
        player:getCurrentMission(xi.mission.log_id.COP) == xi.mission.id.cop.DAWN and
        player:getCharVar("PromathiaStatus") == 6
    then
        player:startEvent(116)
    end
end
zoneObject.onEventFinish = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option)
    if csid == 116 then
        player:setCharVar("PromathiaStatus", 7)
        player:addTitle(xi.title.BANISHER_OF_EMPTINESS)
    end
end

return zoneObject
