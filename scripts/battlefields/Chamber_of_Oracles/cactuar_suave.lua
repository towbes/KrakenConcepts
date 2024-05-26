-----------------------------------
-- Cactuar Suave
-- Chamber of Oracles KSNM30, Clothos Orb
-- !additem 1175
-----------------------------------
local chamberOfOraclesID = zones[xi.zone.CHAMBER_OF_ORACLES]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.CHAMBER_OF_ORACLES,
    battlefieldId    = xi.battlefield.id.CACTUAR_SUAVE,
    maxPlayers       = 6,
    timeLimit        = utils.minutes(30),
    index            = 5,
    entryNpc         = 'SC_Entrance',
    exitNpc          = 'Shimmering_Circle',
    requiredItems    = { xi.item.CLOTHOS_ORB, wearMessage = chamberOfOraclesID.text.A_CRACK_HAS_FORMED, wornMessage = chamberOfOraclesID.text.ORB_IS_CRACKED },
})

content:addEssentialMobs({ 'Sabotender_Campeon', 'Sabotender_Amante' })

content.loot =
{
    {
        { item = xi.item.BAG_OF_CACTUS_STEMS, weight = 1000 },
    },

    {
        { item = xi.item.CACTUAR_NEEDLE, weight = 1000 },
    },

    {

        { item = xi.item.CACTUAR_ROOT, weight = 1000 },
    },

    {
        { item = xi.item.CACTUAR_RIBBON,  weight = 250 },
        { item = xi.item.CAPRICORN_STAFF, weight = 250 },
        { item = xi.item.ARGENT_DAGGER,   weight = 250 },
        { item = xi.item.BALANS_SWORD,    weight = 250 },
    },

    {
        { item = xi.item.ZISKAS_CROSSBOW,   weight = 200 },
        { item = xi.item.HONEBAMI,          weight = 200 },
        { item = xi.item.UNJI,              weight = 200 },
        { item = xi.item.TAILLEFERS_DAGGER, weight = 200 },
        { item = xi.item.SCHILTRON_SPEAR,   weight = 200 },
    },

    {
        { item = xi.item.CORAL_FRAGMENT,          weight =  50 },
        { item = xi.item.CHUNK_OF_DARKSTEEL_ORE,  weight =  50 },
        { item = xi.item.DEMON_HORN,              weight =  50 },
        { item = xi.item.EBONY_LOG,               weight =  50 },
        { item = xi.item.CHUNK_OF_GOLD_ORE,       weight =  50 },
        { item = xi.item.SPOOL_OF_GOLD_THREAD,    weight =  50 },
        { item = xi.item.SLAB_OF_GRANITE,         weight =  50 },
        { item = xi.item.HI_RERAISER,             weight =  50 },
        { item = xi.item.MAHOGANY_LOG,            weight =  50 },
        { item = xi.item.MYTHRIL_INGOT,           weight =  50 },
        { item = xi.item.CHUNK_OF_MYTHRIL_ORE,    weight =  50 },
        { item = xi.item.PETRIFIED_LOG,           weight =  50 },
        { item = xi.item.PHILOSOPHERS_STONE,      weight =  50 },
        { item = xi.item.SQUARE_OF_RAINBOW_CLOTH, weight =  50 },
        { item = xi.item.RAM_HORN,                weight =  50 },
        { item = xi.item.SQUARE_OF_RAXA,          weight =  50 },
        { item = xi.item.RERAISER,                weight =  50 },
        { item = xi.item.SCROLL_OF_THUNDER_III,   weight =  50 },
        { item = xi.item.SCROLL_OF_CURE_V,        weight =  50 },
        { item = xi.item.SCROLL_OF_SHELL_V,       weight =  50 },
    },

    {
        { item = xi.item.DAMASCUS_INGOT,            weight = 100 },
        { item = xi.item.SQUARE_OF_DAMASCENE_CLOTH, weight = 150 },
        { item = xi.item.SPOOL_OF_MALBORO_FIBER,    weight = 100 },
        { item = xi.item.PHILOSOPHERS_STONE,        weight = 100 },
        { item = xi.item.PHOENIX_FEATHER,           weight =  50 },
        { item = xi.item.SQUARE_OF_RAXA,            weight = 100 },
        { item = xi.item.NONE,                      weight = 250 },
    }
}

return content:register()
