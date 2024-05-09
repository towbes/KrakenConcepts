-----------------------------------
-- Moa Constrictors
-- Balga's Dais KSNM30, Atropos Orb
-----------------------------------
local balgasID = zones[xi.zone.BALGAS_DAIS]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.BALGAS_DAIS,
    battlefieldId    = xi.battlefield.id.MOA_CONSTRICTORS,
    maxPlayers       = 6,
    levelCap         = 99,
    timeLimit        = utils.minutes(30),
    index            = 17,
    entryNpc         = 'BC_Entrance',
    exitNpc          = 'Burning_Circle',
    requiredItems    = { xi.item.ATROPOS_ORB, wearMessage = balgasID.text.A_CRACK_HAS_FORMED, wornMessage = balgasID.text.ORB_IS_CRACKED },
})

content:addEssentialMobs({ 'Giant_Moa' })

content.loot =
{

    {
        quantity = 2,
        { item = xi.item.COCKATRICE_SKIN, weight = 1000 }, -- Cockatrice Skin
    },

    {
        { item = xi.item.NONE,      weight = 800 }, -- Nothing
        { item = xi.item.DODO_SKIN, weight = 200 }, -- Dodo Skin
    },

    {
        { item = xi.item.EXPUNGER,       weight = 250 }, -- Expunger
        { item = xi.item.MORGENSTERN,    weight = 250 }, -- Morgenstern
        { item = xi.item.HEART_SNATCHER, weight = 250 }, -- Heart Snatcher
        { item = xi.item.GRAVEDIGGER,    weight = 250 }, -- Gravedigger
    },

    {
        { item = xi.item.OSTREGER_MITTS, weight = 250 }, -- Ostreger Mitts
        { item = xi.item.PINEAL_HAT,     weight = 250 }, -- Pineal Hat
        { item = xi.item.EVOKERS_BOOTS,  weight = 250 }, -- Evoker's Boots
        { item = xi.item.TRACKERS_KECKS, weight = 250 }, -- Tracker's Kecks
    },

    {
        { item = xi.item.ADAMAN_INGOT,     weight = 250 }, -- Adaman Ingot
        { item = xi.item.ORICHALCUM_INGOT, weight = 350 }, -- Orichalcum
        { item = xi.item.ABSORBING_SHIELD, weight = 350 }, -- Absorbing Shield
    },
    
    {
        { item = xi.item.NONE,          weight = 300 }, -- Nothing
        { item = xi.item.POLE_GRIP,     weight = 500 }, -- Pole Grip
        { item = xi.item.SPEAR_STRAP,   weight = 100 }, -- Spear Strap
        { item = xi.item.CLAYMORE_GRIP, weight = 100 }, -- Claymore Grip
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
