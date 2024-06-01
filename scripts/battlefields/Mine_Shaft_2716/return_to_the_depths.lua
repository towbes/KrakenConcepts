-----------------------------------
-- Return To The Depths
-- Mine Shaft #2716 mission battlefield
-----------------------------------
local mineshaftID = zones[xi.zone.MINE_SHAFT_2716]
-----------------------------------

local content = BattlefieldMission:new({
    zoneId                = xi.zone.MINE_SHAFT_2716,
    battlefieldId         = xi.battlefield.id.RETURN_TO_THE_DEPTHS,
    isMission             = true,
    maxPlayers            = 6,
    levelCap              = 50,
    timeLimit             = utils.minutes(30),
    index                 = 1,
    entryNpc              = '_0d0',
    exitNpc               = { '_0d1', '_0d2', '_0d3' },
    questArea             = xi.questLog.BASTOK,
    quest                 = xi.quest.id.bastok.RETURN_TO_THE_DEPTHS,
    grantGil              = 10000,
})

content.groups =
{
    {
        mobIds =
        {
            {
                mineshaftID.mob.TWILOTAK,
            },

            {
                mineshaftID.mob.TWILOTAK + 7,
            },

            {
                mineshaftID.mob.TWILOTAK + 14,
            },
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
