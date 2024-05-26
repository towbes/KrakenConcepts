-----------------------------------
-- Area: Cloister of Gales
-- BCNM: Waking The Beast
-----------------------------------
local cloisterOfGalesID = zones[xi.zone.CLOISTER_OF_GALES]
-----------------------------------

local content = BattlefieldQuest:new({
    zoneId           = xi.zone.CLOISTER_OF_GALES,
    battlefieldId    = xi.battlefield.id.WAKING_THE_BEAST_CLOISTER_OF_GALES,
    maxPlayers       = 18,
    timeLimit        = utils.minutes(30),
    index            = 3,
    entryNpc         = 'WP_Entrance',
    exitNpc          = 'Wind_Protocrystal',
    requiredKeyItems = { xi.ki.RAINBOW_RESONATOR, keep = true },

    questArea = xi.questLog.OTHER_AREAS,
    quest     = xi.quest.id.otherAreas.WAKING_THE_BEAST,
})

function content:onEventFinishWin(player, csid, option, npc)
    npcUtil.giveKeyItem(player, xi.ki.EYE_OF_GALES)
end

content.groups =
{
    {
        mobIds =
        {
            {
                cloisterOfGalesID.mob.GARUDA_PRIME_WTB,     -- Garuda
                cloisterOfGalesID.mob.GARUDA_PRIME_WTB + 1, -- Wind Elemental
                cloisterOfGalesID.mob.GARUDA_PRIME_WTB + 2, -- Wind Elemental
                cloisterOfGalesID.mob.GARUDA_PRIME_WTB + 3, -- Wind Elemental
                cloisterOfGalesID.mob.GARUDA_PRIME_WTB + 4, -- Wind Elemental
            },

            {
                cloisterOfGalesID.mob.GARUDA_PRIME_WTB + 5, -- Garuda
                cloisterOfGalesID.mob.GARUDA_PRIME_WTB + 6, -- Wind Elemental
                cloisterOfGalesID.mob.GARUDA_PRIME_WTB + 7, -- Wind Elemental
                cloisterOfGalesID.mob.GARUDA_PRIME_WTB + 8, -- Wind Elemental
                cloisterOfGalesID.mob.GARUDA_PRIME_WTB + 9, -- Wind Elemental
            },

            {
                cloisterOfGalesID.mob.GARUDA_PRIME_WTB + 10, -- Garuda
                cloisterOfGalesID.mob.GARUDA_PRIME_WTB + 11, -- Wind Elemental
                cloisterOfGalesID.mob.GARUDA_PRIME_WTB + 12, -- Wind Elemental
                cloisterOfGalesID.mob.GARUDA_PRIME_WTB + 13, -- Wind Elemental
                cloisterOfGalesID.mob.GARUDA_PRIME_WTB + 14, -- Wind Elemental
            },
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
