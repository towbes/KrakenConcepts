-----------------------------------
-- Old setting from settings.lua: HOMEPOINT_HEAL
-- Set if you want Home Points to heal you like in single-player Final Fantasy games.
-----------------------------------
require('modules/module_utils')
require('scripts/globals/homepoint')
-----------------------------------
local m = Module:new('homepoint_heal')

m:addOverride('xi.homepoint.onTrigger', function(player, csid, index)
    local playerzone = player:getZone()
    if playerzone:getTypeMask() == xi.zoneType.CITY then
        player:addHP(player:getMaxHP())
        player:addMP(player:getMaxMP())

        -- Reset Call Wyvern & Deploy
        player:resetRecast(xi.recast.ABILITY, xi.jobAbility.CALL_WYVERN)
        player:resetRecast(xi.recast.ABILITY, xi.jobAbility.DEPLOY)
    end
    super(player, csid, index)
end)

return m
