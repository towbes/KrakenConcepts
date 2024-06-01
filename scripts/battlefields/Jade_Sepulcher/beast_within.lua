-----------------------------------
-- Area: Jade Sepulcher
-- BCNM: Beast Within (BLU LB Fight)
-----------------------------------
local jadeSepulcherID = zones[xi.zone.JADE_SEPULCHER]
-----------------------------------

local content = BattlefieldQuest:new({
    zoneId                = xi.zone.JADE_SEPULCHER,
    battlefieldId         = xi.battlefield.id.BEAST_WITHIN,
    isMission             = true,
    maxPlayers            = 1,
    levelCap              = 75,
    allowSubjob           = false,
    timeLimit             = utils.minutes(10),
    index                 = 2,
    entryNpc              = '_1v0',
    exitNpcs              = { '_1v1', '_1v2', '_1v3' },
    questArea             = xi.questLog.AHT_URHGAN,
    quest                 = xi.quest.id.ahtUrhgan.THE_BEAST_WITHIN,
    requiredItems         = { xi.item.BLUE_MAGES_TESTIMONY, wearMessage = jadeSepulcherID.text.TESTIMONY_WEARS, wornMessage = jadeSepulcherID.text.TESTIMONY_IS_TORN },
})

function content:entryRequirement(player, npc, isRegistrant, trade)
    return xi.quest.getVar(player, xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.THE_BEAST_WITHIN, 'Prog') == 3 and player:getMainJob() == xi.job.BLU and
    player:getMainLvl() >= 66
end

content.groups =
{
    {
        mobIds =
        {
            { jadeSepulcherID.mob.RAUBAHN     },
            { jadeSepulcherID.mob.RAUBAHN + 1 },
            { jadeSepulcherID.mob.RAUBAHN + 2 },
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
