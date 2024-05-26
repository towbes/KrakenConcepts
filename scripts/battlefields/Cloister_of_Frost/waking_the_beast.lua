-----------------------------------
-- Area: Cloister of Frost
-- BCNM: Waking The Beast
-----------------------------------
local cloisterOfFrostID = zones[xi.zone.CLOISTER_OF_FROST]
-----------------------------------

local content = BattlefieldQuest:new({
    zoneId           = xi.zone.CLOISTER_OF_FROST,
    battlefieldId    = xi.battlefield.id.WAKING_THE_BEAST_CLOISTER_OF_FROST,
    maxPlayers       = 18,
    timeLimit        = utils.minutes(30),
    index            = 3,
    entryNpc         = 'IP_Entrance',
    exitNpc          = 'Ice_Protocrystal',
    requiredKeyItems = { xi.ki.RAINBOW_RESONATOR, keep = true },

    questArea = xi.questLog.OTHER_AREAS,
    quest     = xi.quest.id.otherAreas.WAKING_THE_BEAST,
})

function content:onEventFinishWin(player, csid, option, npc)
    npcUtil.giveKeyItem(player, xi.ki.EYE_OF_FROST)
end

content.groups =
{
    {
        mobIds =
        {
            {
                cloisterOfFrostID.mob.SHIVA_PRIME_WTB,     -- Shiva
                cloisterOfFrostID.mob.SHIVA_PRIME_WTB + 1, -- Ice Elemental
                cloisterOfFrostID.mob.SHIVA_PRIME_WTB + 2, -- Ice Elemental
                cloisterOfFrostID.mob.SHIVA_PRIME_WTB + 3, -- Ice Elemental
                cloisterOfFrostID.mob.SHIVA_PRIME_WTB + 4, -- Ice Elemental
            },

            {
                cloisterOfFrostID.mob.SHIVA_PRIME_WTB + 5, -- Shiva
                cloisterOfFrostID.mob.SHIVA_PRIME_WTB + 6, -- Ice Elemental
                cloisterOfFrostID.mob.SHIVA_PRIME_WTB + 7, -- Ice Elemental
                cloisterOfFrostID.mob.SHIVA_PRIME_WTB + 8, -- Ice Elemental
                cloisterOfFrostID.mob.SHIVA_PRIME_WTB + 9, -- Ice Elemental
            },

            {
                cloisterOfFrostID.mob.SHIVA_PRIME_WTB + 10, -- Shiva
                cloisterOfFrostID.mob.SHIVA_PRIME_WTB + 11, -- Ice Elemental
                cloisterOfFrostID.mob.SHIVA_PRIME_WTB + 12, -- Ice Elemental
                cloisterOfFrostID.mob.SHIVA_PRIME_WTB + 13, -- Ice Elemental
                cloisterOfFrostID.mob.SHIVA_PRIME_WTB + 14, -- Ice Elemental
            },
        },


        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
