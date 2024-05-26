-----------------------------------
-- Scarlet King
-- Chamber of Oracles KSNM30, Atropos Orb
-- !additem 1180
-----------------------------------
local chamberOfOraclesID = zones[xi.zone.CHAMBER_OF_ORACLES]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.CHAMBER_OF_ORACLES,
    battlefieldId    = xi.battlefield.id.SCARLET_KING,
    maxPlayers       = 6,
    timeLimit        = utils.minutes(30),
    index            = 7,
    entryNpc         = 'SC_Entrance',
    exitNpc          = 'Shimmering_Circle',
    requiredItems    = { xi.item.ATROPOS_ORB, wearMessage = chamberOfOraclesID.text.A_CRACK_HAS_FORMED, wornMessage = chamberOfOraclesID.text.ORB_IS_CRACKED },
})

content:addEssentialMobs({ 'Purson' })

content.loot =
{
    {
        { item = xi.item.MANTICORE_HIDE, weight = 1000 },
    },

    {
        { item = xi.item.LOCK_OF_MANTICORE_HAIR, weight = 1000 },
    },

    {
        { item = xi.item.GIL, weight = 1000, amount = 24000 },

    },

    {
        { item = xi.item.WYVERN_PERCH,               weight = 200 },
        { item = xi.item.HONEBAMI,                   weight = 200 },
        { item = xi.item.ARGENT_DAGGER,              weight = 200 },
        { item = xi.item.THANATOS_BASELARD,          weight = 200 },
        { item = xi.item.VIAL_OF_BLACK_BEETLE_BLOOD, weight = 200 },
    },

    {
        { item = xi.item.SCROLL_OF_SHELL_IV, weight = 250 },
        { item = xi.item.CAPRICORN_STAFF,    weight = 150 },
        { item = xi.item.WOODVILLES_AXE,     weight = 150 },
        { item = xi.item.KING_MAKER,         weight = 150 },
        { item = xi.item.GAWAINS_AXE,        weight = 150 },
    },

    {
        { item = xi.item.VILE_ELIXIR_P1,   weight = 350 },
        { item = xi.item.VILE_ELIXIR,      weight = 100 },
        { item = xi.item.POLE_GRIP,        weight = 250 },
        { item = xi.item.SPEAR_STRAP,      weight = 100 },
        { item = xi.item.CLAYMORE_GRIP,    weight = 100 },
        { item = xi.item.SCROLL_OF_CURE_V, weight = 100 },
    },

    {
        { item = xi.item.SCROLL_OF_THUNDER_III,   weight = 150 },
        { item = xi.item.CHUNK_OF_DARKSTEEL_ORE,  weight =  50 },
        { item = xi.item.CHUNK_OF_ADAMAN_ORE,     weight =  50 },
        { item = xi.item.MAHOGANY_LOG,            weight = 100 },
        { item = xi.item.CHUNK_OF_GOLD_ORE,       weight =  50 },
        { item = xi.item.CHUNK_OF_ORICHALCUM_ORE, weight =  50 },
        { item = xi.item.GOLD_INGOT,              weight =  25 },
        { item = xi.item.SQUARE_OF_RAXA,          weight = 100 },
        { item = xi.item.PETRIFIED_LOG,           weight = 100 },
        { item = xi.item.PHOENIX_FEATHER,         weight = 100 },
        { item = xi.item.CHUNK_OF_PLATINUM_ORE,   weight =  50 },
        { item = xi.item.SQUARE_OF_RAINBOW_CLOTH, weight =  25 },
        { item = xi.item.RERAISER,                weight = 100 },
        { item = xi.item.HI_RERAISER,             weight =  50 },
    },

    {
        { item = xi.item.DAMASCUS_INGOT,            weight = 100 },
        { item = xi.item.SQUARE_OF_DAMASCENE_CLOTH, weight =  50 },
        { item = xi.item.SPOOL_OF_MALBORO_FIBER,    weight =  50 },
        { item = xi.item.PHILOSOPHERS_STONE,        weight =  50 },
        { item = xi.item.SQUARE_OF_RAXA,            weight = 100 },
        { item = xi.item.NONE,                      weight = 650 },
    }
}

return content:register()
