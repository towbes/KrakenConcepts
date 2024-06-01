-----------------------------------
-- Area: Cloister of Storms
-- BCNM: Waking The Beast
-----------------------------------
local cloisterOfStormsID = zones[xi.zone.CLOISTER_OF_STORMS]
-----------------------------------

local content = BattlefieldQuest:new({
    zoneId           = xi.zone.CLOISTER_OF_STORMS,
    battlefieldId    = xi.battlefield.id.WAKING_THE_BEAST_CLOISTER_OF_STORMS,
    maxPlayers       = 18,
    timeLimit        = utils.minutes(30),
    index            = 3,
    entryNpc         = 'LP_Entrance',
    exitNpc          = 'Lightning_Protocrystal',
    requiredKeyItems = { xi.ki.RAINBOW_RESONATOR, keep = true },

    questArea = xi.questLog.OTHER_AREAS,
    quest     = xi.quest.id.otherAreas.WAKING_THE_BEAST,
})

function content:onEventFinishWin(player, csid, option, npc)
    npcUtil.giveKeyItem(player, xi.ki.EYE_OF_STORMS)
end

content.groups =
{
    {
        mobIds =
        {
            {
                cloisterOfStormsID.mob.RAMUH_PRIME_WTB,     -- Ramuh
                cloisterOfStormsID.mob.RAMUH_PRIME_WTB + 1, -- Lightning Elemental
                cloisterOfStormsID.mob.RAMUH_PRIME_WTB + 2, -- Lightning Elemental
                cloisterOfStormsID.mob.RAMUH_PRIME_WTB + 3, -- Lightning Elemental
                cloisterOfStormsID.mob.RAMUH_PRIME_WTB + 4, -- Lightning Elemental
            },

            {
                cloisterOfStormsID.mob.RAMUH_PRIME_WTB + 5, -- Ramuh
                cloisterOfStormsID.mob.RAMUH_PRIME_WTB + 6, -- Lightning Elemental
                cloisterOfStormsID.mob.RAMUH_PRIME_WTB + 7, -- Lightning Elemental
                cloisterOfStormsID.mob.RAMUH_PRIME_WTB + 8, -- Lightning Elemental
                cloisterOfStormsID.mob.RAMUH_PRIME_WTB + 9, -- Lightning Elemental
            },

            {
                cloisterOfStormsID.mob.RAMUH_PRIME_WTB + 10, -- Ramuh
                cloisterOfStormsID.mob.RAMUH_PRIME_WTB + 11, -- Lightning Elemental
                cloisterOfStormsID.mob.RAMUH_PRIME_WTB + 12, -- Lightning Elemental
                cloisterOfStormsID.mob.RAMUH_PRIME_WTB + 13, -- Lightning Elemental
                cloisterOfStormsID.mob.RAMUH_PRIME_WTB + 14, -- Lightning Elemental
            },
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
