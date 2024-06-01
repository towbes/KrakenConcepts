-----------------------------------
-- Today's Horoscope
-- Horlais Peak KSNM50, Lachesis Orb
-----------------------------------
local horlaisID = zones[xi.zone.HORLAIS_PEAK]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.HORLAIS_PEAK,
    battlefieldId    = xi.battlefield.id.TODAYS_HOROSCOPE,
    maxPlayers       = 6,
    levelCap         = 75,
    timeLimit        = utils.minutes(30),
    index            = 16,
    entryNpc         = 'BC_Entrance',
    exitNpc          = 'Burning_Circle',
    requiredItems    = { xi.item.LACHESIS_ORB, wearMessage = horlaisID.text.A_CRACK_HAS_FORMED, wornMessage = horlaisID.text.ORB_IS_CRACKED },
})

content:addEssentialMobs({ 'Aries' })

content.loot =
{
    {
        { item = xi.item.GIL, weight = 1000, amount = 24000 },
    },

    {
        { item = xi.item.GRAVEDIGGER,     weight = 467 },
        { item = xi.item.GONDO_SHIZUNORI, weight =  48 },
        { item = xi.item.RAMPAGER,        weight =  61 },
        { item = xi.item.RETRIBUTOR,      weight =  46 },
    },

    {
        { item = xi.item.HIERARCH_BELT,    weight = 222 },
        { item = xi.item.WARWOLF_BELT,     weight = 338 },
        { item = xi.item.PALMERINS_SHIELD, weight = 206 },
        { item = xi.item.TRAINERS_GLOVES,  weight = 206 },
    },

    {
        { item = xi.item.NONE,             weight = 342 },
        { item = xi.item.ARIES_MANTLE,     weight = 250 },
        { item = xi.item.ADAMAN_INGOT,     weight = 230 },
        { item = xi.item.ORICHALCUM_INGOT, weight = 178 },
    },

    {
        { item = xi.item.RAMPAGING_HORN, weight = 292 },
        { item = xi.item.LUMBERING_HORN, weight = 265 },
        { item = xi.item.SWORD_STRAP,    weight = 354 },
        { item = xi.item.CLAYMORE_GRIP,  weight = 89  },
    },

    {
        { item = xi.item.CORAL_FRAGMENT,           weight = 101 }, -- Coral Fragment
        { item = xi.item.CHUNK_OF_DARKSTEEL_ORE,   weight =  29 }, -- Chunk Of Darksteel Ore
        { item = xi.item.DEMON_HORN,               weight =  29 }, -- Demon Horn
        { item = xi.item.EBONY_LOG,                weight =  29 }, -- Ebony Log
        { item = xi.item.CHUNK_OF_GOLD_ORE,        weight = 101 }, -- Chunk Of Gold Ore
        { item = xi.item.SPOOL_OF_GOLD_THREAD,     weight =  29 }, -- Spool Of Gold Thread
        { item = xi.item.SLAB_OF_GRANITE,          weight =  29 }, -- Slab Of Granite
        { item = xi.item.MAHOGANY_LOG,             weight =  43 }, -- Mahogany Log
        { item = xi.item.CHUNK_OF_MYTHRIL_ORE,     weight =  29 }, -- Chunk Of Mythril Ore
        { item = xi.item.PETRIFIED_LOG,            weight =  58 }, -- Petrified Log
        { item = xi.item.CHUNK_OF_PLATINUM_ORE,    weight =  14 }, -- Chunk Of Platinum Ore
        { item = xi.item.SQUARE_OF_RAINBOW_CLOTH,  weight =  58 }, -- Square Of Rainbow Cloth
        { item = xi.item.RAM_HORN,                 weight =  14 }, -- Ram Horn
        { item = xi.item.VILE_ELIXIR,              weight =  58 }, -- Vile Elixir
        { item = xi.item.VILE_ELIXIR_P1,           weight =  29 }, -- Vile Elixir +1
        { item = xi.item.HANDFUL_OF_WYVERN_SCALES, weight =  72 }, -- Handful Of Wyvern Scales
    },

    {
        { item = xi.item.VIAL_OF_BLACK_BEETLE_BLOOD, weight =  87 }, -- Vial Of Black Beetle Blood
        { item = xi.item.DAMASCUS_INGOT,             weight =  14 }, -- Damascus Ingot
        { item = xi.item.SQUARE_OF_DAMASCENE_CLOTH,  weight =  29 }, -- Square Of Damascene Cloth
        { item = xi.item.SPOOL_OF_MALBORO_FIBER,     weight =  43 }, -- Spool Of Malboro Fiber
        { item = xi.item.PHILOSOPHERS_STONE,         weight = 174 }, -- Philosophers Stone
        { item = xi.item.PHOENIX_FEATHER,            weight = 246 }, -- Phoenix Feather
        { item = xi.item.SQUARE_OF_RAXA,             weight = 159 }, -- Square Of Raxa
    },
}

return content:register()
