-----------------------------------
-- Area: Cloister of Tremors
-- BCNM: Waking The Beast
-----------------------------------
local cloisterOfTremorsID = zones[xi.zone.CLOISTER_OF_TREMORS]
-----------------------------------

local content = BattlefieldQuest:new({
    zoneId           = xi.zone.CLOISTER_OF_TREMORS,
    battlefieldId    = xi.battlefield.id.WAKING_THE_BEAST_CLOISTER_OF_TREMORS,
    maxPlayers       = 18,
    timeLimit        = utils.minutes(30),
    index            = 3,
    entryNpc         = 'EP_Entrance',
    exitNpc          = 'Earth_Protocrystal',

    requiredKeyItems = { xi.ki.RAINBOW_RESONATOR, keep = true },

    questArea = xi.questLog.OTHER_AREAS,
    quest     = xi.quest.id.otherAreas.WAKING_THE_BEAST,
})

function content:onEventFinishWin(player, csid, option, npc)
    npcUtil.giveKeyItem(player, xi.ki.EYE_OF_TREMORS)
end

content.groups =
{
    {
        mobIds =
        {
            {
                cloisterOfTremorsID.mob.TITAN_PRIME_WTB,     -- Titan
                cloisterOfTremorsID.mob.TITAN_PRIME_WTB + 1, -- Earth Elemental
                cloisterOfTremorsID.mob.TITAN_PRIME_WTB + 2, -- Earth Elemental
                cloisterOfTremorsID.mob.TITAN_PRIME_WTB + 3, -- Earth Elemental
                cloisterOfTremorsID.mob.TITAN_PRIME_WTB + 4, -- Earth Elemental
            },

            {
                cloisterOfTremorsID.mob.TITAN_PRIME_WTB + 5, -- Titan
                cloisterOfTremorsID.mob.TITAN_PRIME_WTB + 6, -- Earth Elemental
                cloisterOfTremorsID.mob.TITAN_PRIME_WTB + 7, -- Earth Elemental
                cloisterOfTremorsID.mob.TITAN_PRIME_WTB + 8, -- Earth Elemental
                cloisterOfTremorsID.mob.TITAN_PRIME_WTB + 9, -- Earth Elemental
            },

            {
                cloisterOfTremorsID.mob.TITAN_PRIME_WTB + 10, -- Titan
                cloisterOfTremorsID.mob.TITAN_PRIME_WTB + 11, -- Earth Elemental
                cloisterOfTremorsID.mob.TITAN_PRIME_WTB + 12, -- Earth Elemental
                cloisterOfTremorsID.mob.TITAN_PRIME_WTB + 13, -- Earth Elemental
                cloisterOfTremorsID.mob.TITAN_PRIME_WTB + 14, -- Earth Elemental
            },
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
