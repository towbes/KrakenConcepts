-----------------------------------
-- Area: Cloister of Tides
-- BCNM: Waking The Beast
-----------------------------------
local cloisterOfTidesID = zones[xi.zone.CLOISTER_OF_TIDES]
-----------------------------------

local content = BattlefieldQuest:new({
    zoneId           = xi.zone.CLOISTER_OF_TIDES,
    battlefieldId    = xi.battlefield.id.WAKING_THE_BEAST_CLOISTER_OF_TIDES,
    maxPlayers       = 18,
    timeLimit        = utils.minutes(30),
    index            = 2,
    entryNpc         = 'WP_Entrance',
    exitNpc          = 'Water_Protocrystal',
    requiredKeyItems = { xi.ki.RAINBOW_RESONATOR, keep = true },

    questArea = xi.questLog.OTHER_AREAS,
    quest     = xi.quest.id.otherAreas.WAKING_THE_BEAST,
})

function content:onEventFinishWin(player, csid, option, npc)
    npcUtil.giveKeyItem(player, xi.ki.EYE_OF_TIDES)
end

content.groups =
{
    {
        mobIds =
        {
            {
                cloisterOfTidesID.mob.LEVIATHAN_PRIME_WTB,     -- Leviathan
                cloisterOfTidesID.mob.LEVIATHAN_PRIME_WTB + 1, -- Water Elemental
                cloisterOfTidesID.mob.LEVIATHAN_PRIME_WTB + 2, -- Water Elemental
                cloisterOfTidesID.mob.LEVIATHAN_PRIME_WTB + 3, -- Water Elemental
                cloisterOfTidesID.mob.LEVIATHAN_PRIME_WTB + 4, -- Water Elemental
            },

            {
                cloisterOfTidesID.mob.LEVIATHAN_PRIME_WTB + 5, -- Leviathan
                cloisterOfTidesID.mob.LEVIATHAN_PRIME_WTB + 6, -- Water Elemental
                cloisterOfTidesID.mob.LEVIATHAN_PRIME_WTB + 7, -- Water Elemental
                cloisterOfTidesID.mob.LEVIATHAN_PRIME_WTB + 8, -- Water Elemental
                cloisterOfTidesID.mob.LEVIATHAN_PRIME_WTB + 9, -- Water Elemental
            },

            {
                cloisterOfTidesID.mob.LEVIATHAN_PRIME_WTB + 10, -- Leviathan
                cloisterOfTidesID.mob.LEVIATHAN_PRIME_WTB + 11, -- Water Elemental
                cloisterOfTidesID.mob.LEVIATHAN_PRIME_WTB + 12, -- Water Elemental
                cloisterOfTidesID.mob.LEVIATHAN_PRIME_WTB + 13, -- Water Elemental
                cloisterOfTidesID.mob.LEVIATHAN_PRIME_WTB + 14, -- Water Elemental
            },
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
