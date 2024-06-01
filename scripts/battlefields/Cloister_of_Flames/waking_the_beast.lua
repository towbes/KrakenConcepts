-----------------------------------
-- Area: Cloister Of Flames
-- BCNM: Waking The Beast
-----------------------------------
local cloisterOfFlamesID = zones[xi.zone.CLOISTER_OF_FLAMES]
-----------------------------------

local content = BattlefieldQuest:new({
    zoneId           = xi.zone.CLOISTER_OF_FLAMES,
    battlefieldId    = xi.battlefield.id.WAKING_THE_BEAST_CLOISTER_OF_FLAMES,
    maxPlayers       = 18,
    timeLimit        = utils.minutes(30),
    index            = 2,
    entryNpc         = 'FP_Entrance',
    exitNpc          = 'Fire_Protocrystal',
    requiredKeyItems = { xi.ki.RAINBOW_RESONATOR, keep = true },

    questArea = xi.questLog.OTHER_AREAS,
    quest     = xi.quest.id.otherAreas.WAKING_THE_BEAST,
})

function content:onEventFinishWin(player, csid, option, npc)
    npcUtil.giveKeyItem(player, xi.ki.EYE_OF_FLAMES)
end

content.groups =
{
    {
        mobIds =
        {
            {
                cloisterOfFlamesID.mob.IFRIT_PRIME_WTB,     -- Ifrit
                cloisterOfFlamesID.mob.IFRIT_PRIME_WTB + 1, -- Fire Elemental
                cloisterOfFlamesID.mob.IFRIT_PRIME_WTB + 2, -- Fire Elemental
                cloisterOfFlamesID.mob.IFRIT_PRIME_WTB + 3, -- Fire Elemental
                cloisterOfFlamesID.mob.IFRIT_PRIME_WTB + 4, -- Fire Elemental
            },

            {
                cloisterOfFlamesID.mob.IFRIT_PRIME_WTB + 5, -- Ifrit
                cloisterOfFlamesID.mob.IFRIT_PRIME_WTB + 6, -- Fire Elemental
                cloisterOfFlamesID.mob.IFRIT_PRIME_WTB + 7, -- Fire Elemental
                cloisterOfFlamesID.mob.IFRIT_PRIME_WTB + 8, -- Fire Elemental
                cloisterOfFlamesID.mob.IFRIT_PRIME_WTB + 9, -- Fire Elemental
            },

            {
                cloisterOfFlamesID.mob.IFRIT_PRIME_WTB + 10, -- Ifrit
                cloisterOfFlamesID.mob.IFRIT_PRIME_WTB + 11, -- Fire Elemental
                cloisterOfFlamesID.mob.IFRIT_PRIME_WTB + 12, -- Fire Elemental
                cloisterOfFlamesID.mob.IFRIT_PRIME_WTB + 13, -- Fire Elemental
                cloisterOfFlamesID.mob.IFRIT_PRIME_WTB + 14, -- Fire Elemental
            },
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
