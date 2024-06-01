-----------------------------------
-- Come Into My Parlor
-- Qu'Bia Arena KSNM30, Clotho Orb
-----------------------------------
local qubiaID = zones[xi.zone.QUBIA_ARENA]
-----------------------------------

local content = Battlefield:new({
    zoneId        = xi.zone.QUBIA_ARENA,
    battlefieldId = xi.battlefield.id.COME_INTO_MY_PARLOR,
    maxPlayers    = 6,
    levelCap      = 75,
    timeLimit     = utils.minutes(30),
    index         = 1,
    entryNpc      = 'BC_Entrance',
    exitNpc       = 'Burning_Circle',
    requiredItems = { xi.item.CLOTHO_ORB, wearMessage = qubiaID.text.A_CRACK_HAS_FORMED, wornMessage = qubiaID.text.ORB_IS_CRACKED },
    armouryCrates    =
    {
        qubiaID.mob.ANANSI + 1,
        qubiaID.mob.ANANSI + 11,
        qubiaID.mob.ANANSI + 21,
    },
})

content.groups =
{
    {
        mobIds =
        {
            { qubiaID.mob.ANANSI      },
            { qubiaID.mob.ANANSI + 10 },
            { qubiaID.mob.ANANSI + 20 },
        },
    },

    {
        mobIds =
        {
            {
                -- + 0 = Anansi
                -- + 1 = Armory Crate
                qubiaID.mob.ANANSI + 2,
                qubiaID.mob.ANANSI + 3,
                qubiaID.mob.ANANSI + 4,
                qubiaID.mob.ANANSI + 5,
                qubiaID.mob.ANANSI + 6,
                qubiaID.mob.ANANSI + 7,
                qubiaID.mob.ANANSI + 8,
                qubiaID.mob.ANANSI + 9,
            },

            {
                -- + 10 = Anansi
                -- + 11 = Armory Crate
                qubiaID.mob.ANANSI + 12,
                qubiaID.mob.ANANSI + 13,
                qubiaID.mob.ANANSI + 14,
                qubiaID.mob.ANANSI + 15,
                qubiaID.mob.ANANSI + 16,
                qubiaID.mob.ANANSI + 17,
                qubiaID.mob.ANANSI + 18,
                qubiaID.mob.ANANSI + 19,
            },

            {
                -- + 20 = Anansi
                -- + 21 = Armory Crate
                qubiaID.mob.ANANSI + 22,
                qubiaID.mob.ANANSI + 23,
                qubiaID.mob.ANANSI + 24,
                qubiaID.mob.ANANSI + 25,
                qubiaID.mob.ANANSI + 26,
                qubiaID.mob.ANANSI + 27,
                qubiaID.mob.ANANSI + 28,
                qubiaID.mob.ANANSI + 29,
            },
        },

        allDeath = utils.bind(content.handleAllMonstersDefeated, content),
        spawned  = false,
    },
}

content.loot =
{
    {
        { item = xi.item.NONE,        weight = 250 },
        { item = xi.item.OCEAN_BELT,  weight = 150 },
        { item = xi.item.FOREST_BELT, weight = 150 },
        { item = xi.item.STEPPE_BELT, weight = 150 },
        { item = xi.item.JUNGLE_BELT, weight = 150 },
        { item = xi.item.DESERT_BELT, weight = 150 },
    },

    {
        { item = xi.item.NONE,              weight = 250 },
        { item = xi.item.SOLDIERS_EARRING,  weight =  50 },
        { item = xi.item.KAMPFER_EARRING,   weight =  50 },
        { item = xi.item.MEDICINE_EARRING,  weight =  50 },
        { item = xi.item.SORCERERS_EARRING, weight =  50 },
        { item = xi.item.FENCERS_EARRING,   weight =  50 },
        { item = xi.item.ROGUES_EARRING,    weight =  50 },
        { item = xi.item.GUARDIAN_EARRING,  weight =  50 },
        { item = xi.item.SLAYERS_EARRING,   weight =  50 },
        { item = xi.item.TAMERS_EARRING,    weight =  50 },
        { item = xi.item.MINSTRELS_EARRING, weight =  50 },
        { item = xi.item.TRACKERS_EARRING,  weight =  50 },
        { item = xi.item.RONINS_EARRING,    weight =  50 },
        { item = xi.item.SHINOBI_EARRING,   weight =  50 },
        { item = xi.item.DRAKE_EARRING,     weight =  50 },
        { item = xi.item.CONJURER_EARRING,  weight =  50 },
    },

    {
        { item = xi.item.NONE,        weight = 450 },
        { item = xi.item.SWORD_STRAP, weight = 250 },
        { item = xi.item.POLE_GRIP,   weight =  50 },
        { item = xi.item.SPEAR_STRAP, weight = 250 },
    },

    {
        { item = xi.item.NONE,                  weight = 600 },
        { item = xi.item.SCROLL_OF_CURE_V,      weight = 100 },
        { item = xi.item.SCROLL_OF_THUNDER_III, weight = 100 },
        { item = xi.item.SCROLL_OF_SHELL_IV,    weight = 100 },
        { item = xi.item.LIGHT_SPIRIT_PACT,     weight = 100 },
    },

    {
        { item = xi.item.NONE,                     weight =  90 },
        { item = xi.item.DEMON_HORN,               weight =  70 },
        { item = xi.item.PETRIFIED_LOG,            weight =  70 },
        { item = xi.item.SQUARE_OF_RAXA,           weight =  70 },
        { item = xi.item.SQUARE_OF_RAINBOW_CLOTH,  weight =  70 },
        { item = xi.item.PETRIFIED_LOG,            weight =  70 },
        { item = xi.item.CHUNK_OF_GOLD_ORE,        weight =  70 },
        { item = xi.item.CHUNK_OF_MYTHRIL_ORE,     weight =  70 },
        { item = xi.item.CORAL_FRAGMENT,           weight =  70 },
        { item = xi.item.MAHOGANY_LOG,             weight =  70 },
        { item = xi.item.RAM_HORN,                 weight =  70 },
        { item = xi.item.CHUNK_OF_PLATINUM_ORE,    weight =  70 },
        { item = xi.item.VILE_ELIXIR_P1,           weight =  70 },
    },

    {
        { item = xi.item.NONE,                       weight =  270 },
        { item = xi.item.DAMASCUS_INGOT,             weight =   50 },
        { item = xi.item.SQUARE_OF_DAMASCENE_CLOTH,  weight =   50 },
        { item = xi.item.SPOOL_OF_MALBORO_FIBER,     weight =   50 },
        { item = xi.item.PHILOSOPHERS_STONE,         weight =  250 },
        { item = xi.item.VIAL_OF_BLACK_BEETLE_BLOOD, weight =   50 },
        { item = xi.item.SQUARE_OF_RAXA,             weight =  350 },
    },
}

return content:register()
