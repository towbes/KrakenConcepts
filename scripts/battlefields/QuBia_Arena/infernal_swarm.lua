-----------------------------------
-- Infernal Swarm
-- Qu'Bia Arena KSNM30, Atropos Orb
-----------------------------------
local qubiaID = zones[xi.zone.QUBIA_ARENA]
-----------------------------------

local content = Battlefield:new({
    zoneId        = xi.zone.QUBIA_ARENA,
    battlefieldId = xi.battlefield.id.INFERNAL_SWARM,
    maxPlayers    = 6,
    levelCap      = 75,
    timeLimit     = utils.minutes(30),
    index         = 3,
    entryNpc      = 'BC_Entrance',
    exitNpc       = 'Burning_Circle',
    requiredItems = { xi.item.ATROPOS_ORB, wearMessage = qubiaID.text.A_CRACK_HAS_FORMED, wornMessage = qubiaID.text.ORB_IS_CRACKED },
})

content:addEssentialMobs({ 'Beelzebub', 'Hell_Fly' })

content.loot =
{
    {
        { item = xi.item.NONE,            weight = 350 },
        { item = xi.item.EBONY_LOG,       weight = 150 },
        { item = xi.item.PHOENIX_FEATHER, weight = 500 },
    },

    {
        { item = xi.item.NONE,            weight = 500 },
        { item = xi.item.PHOENIX_FEATHER, weight = 500 },
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
        { item = xi.item.NONE,        weight = 250 },
        { item = xi.item.OCEAN_SASH,  weight = 150 },
        { item = xi.item.FOREST_SASH, weight = 150 },
        { item = xi.item.STEPPE_SASH, weight = 150 },
        { item = xi.item.JUNGLE_SASH, weight = 150 },
        { item = xi.item.DESERT_SASH, weight = 150 },
    },

    {
        { item = xi.item.NONE,          weight = 450 },
        { item = xi.item.STAFF_STRAP,   weight =  50 },
        { item = xi.item.CLAYMORE_GRIP, weight =  50 },
        { item = xi.item.POLE_GRIP,     weight = 300 },
        { item = xi.item.SPEAR_STRAP,   weight = 150 },
    },

    {
        { item = xi.item.NONE,               weight = 100 },
        { item = xi.item.PHILOSOPHERS_STONE, weight = 400 },
        { item = xi.item.PHOENIX_FEATHER,    weight = 500 },
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
