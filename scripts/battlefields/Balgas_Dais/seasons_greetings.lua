-----------------------------------
-- Seasons Greetings
-- Balga's Dais KSNM30, Clotho Orb
-----------------------------------
local balgasID = zones[xi.zone.BALGAS_DAIS]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.BALGAS_DAIS,
    battlefieldId    = xi.battlefield.id.SEASONS_GREETINGS,
    maxPlayers       = 6,
    levelCap         = 99,
    timeLimit        = utils.minutes(30),
    index            = 15,
    entryNpc         = 'BC_Entrance',
    exitNpc          = 'Burning_Circle',
    requiredItems    = { xi.item.CLOTHO_ORB, wearMessage = balgasID.text.A_CRACK_HAS_FORMED, wornMessage = balgasID.text.ORB_IS_CRACKED },
})

content:addEssentialMobs({ 'Gilagoge_Tlugvi', 'Goga_Tlugvi', 'Ulagohvsdi_Tlugvi', 'Gola_Tlugvi' })

content.loot =
{
    {
        { item = xi.item.THYRSUSSTAB, weight = 200 },
        { item = xi.item.RAMPAGER,    weight = 200 },
        { item = xi.item.MORGENSTERN, weight = 200 },
        { item = xi.item.SUBDUER,     weight = 200 },
        { item = xi.item.EXPUNGER,    weight = 200 },

    },

    {
        { item = xi.item.DURANDAL,        weight = 250 },
        { item = xi.item.HOPLITES_HARPE,  weight = 250 },
        { item = xi.item.SORROWFUL_HARP,  weight = 250 },
        { item = xi.item.ATTILAS_EARRING, weight = 250 },
    },

    {
        { item = xi.item.ADAMAN_INGOT,     weight = 333 },
        { item = xi.item.ORICHALCUM_INGOT, weight = 333 },
        { item = xi.item.ROOT_SABOTS,      weight = 333 },
    },
    
    {
        { item = xi.item.DIVINE_LOG,       weight = 650 },
        { item = xi.item.LACQUER_TREE_LOG, weight =  50 },
        { item = xi.item.POLE_GRIP,        weight = 500 }, -- Pole Grip
        { item = xi.item.SPEAR_STRAP,      weight = 100 }, -- Spear Strap
        { item = xi.item.SWORD_STRAP,      weight = 100 },
    },

    {
        { item = xi.item.CHUNK_OF_MYTHRIL_ORE,     weight =  60 }, -- Mythril Ore
        { item = xi.item.CHUNK_OF_DARKSTEEL_ORE,   weight =  60 }, -- Darksteel ore
        { item = xi.item.MAHOGANY_LOG,             weight =  60 }, -- Mahogany Log
        { item = xi.item.EBONY_LOG,                weight =  60 }, -- Ebony Log
        { item = xi.item.PETRIFIED_LOG,            weight =  60 }, -- Petrified Log
        { item = xi.item.CHUNK_OF_GOLD_ORE,        weight =  60 }, -- Gold ore
        { item = xi.item.CHUNK_OF_PLATINUM_ORE,    weight =  60 }, -- Platinum ore
        { item = xi.item.SPOOL_OF_GOLD_THREAD,     weight =  60 }, -- Gold Thread
        { item = xi.item.SQUARE_OF_RAINBOW_CLOTH,  weight = 110 }, -- Rainbow Cloth
        { item = xi.item.HANDFUL_OF_WYVERN_SCALES, weight =  60 }, -- Wyvern Scales
        { item = xi.item.CORAL_FRAGMENT,           weight =  60 }, -- Coral Fragment
        { item = xi.item.RAM_HORN,                 weight =  60 }, -- Ram Horn
        { item = xi.item.DEMON_HORN,               weight = 110 }, -- Demon Horn
        { item = xi.item.HI_RERAISER,              weight =  60 }, -- Hi-Reraiser
        { item = xi.item.VILE_ELIXIR,              weight =  60 }, -- Vile Elixer
    },

    {
        { item = xi.item.DAMASCUS_INGOT,             weight =  50 }, -- Damascus Ingot
        { item = xi.item.SQUARE_OF_DAMASCENE_CLOTH,  weight =  50 }, -- Damascene Cloth
        { item = xi.item.PHOENIX_FEATHER,            weight = 300 }, -- Phoenix Feather
        { item = xi.item.PHILOSOPHERS_STONE,         weight = 350 }, -- Philosopher's Stone
        { item = xi.item.VIAL_OF_BLACK_BEETLE_BLOOD, weight =  50 }, -- Beetle Blood
        { item = xi.item.SQUARE_OF_RAXA,             weight = 200 }, -- Raxa
    },
}

return content:register()
