-----------------------------------
-- Royale Ramble
-- Balga's Dais KSNM30, Lachesis Orb
-----------------------------------
local balgasID = zones[xi.zone.BALGAS_DAIS]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.BALGAS_DAIS,
    battlefieldId    = xi.battlefield.id.ROYALE_RAMBLE,
    maxPlayers       = 6,
    levelCap         = 99,
    timeLimit        = utils.minutes(30),
    index            = 16,
    entryNpc         = 'BC_Entrance',
    exitNpc          = 'Burning_Circle',
    requiredItems    = { xi.item.LACHESIS_ORB, wearMessage = balgasID.text.A_CRACK_HAS_FORMED, wornMessage = balgasID.text.ORB_IS_CRACKED },
    armouryCrates    =
    {
        balgasID.mob.KING_OF_CUPS + 6,
        balgasID.mob.KING_OF_CUPS + 13,
        balgasID.mob.KING_OF_CUPS + 20,
    },
})
content:addEssentialMobs({ 'Queen_of_Cups', 'Queen_of_Batons' })
content.groups[1].spawned = false

content:addEssentialMobs({ 'King_of_Cups', 'King_of_Batons', 'King_of_Swords', 'King_of_Coins' })

content.loot =
{

    {
        { item = xi.item.ORICHALCUM_INGOT, weight = 1000 },
    },

    {
        { item = xi.item.COFFINMAKER,     weight = 250 },
        { item = xi.item.DESTROYERS,      weight = 250 },
        { item = xi.item.DISSECTOR,       weight = 250 },
        { item = xi.item.GONDO_SHIZUNORI, weight = 250 },
    },

    {
        { item = xi.item.HIERARCH_BELT,    weight = 250 },
        { item = xi.item.PALMERINS_SHIELD, weight = 250 },
        { item = xi.item.TRAINERS_GLOVES,  weight = 250 },
        { item = xi.item.WARWOLF_BELT,     weight = 250 },
    },
    
    {
        { item = xi.item.NONE,          weight = 300 },
        { item = xi.item.POLE_GRIP,     weight = 100 },
        { item = xi.item.SWORD_STRAP,   weight = 280 },
        { item = xi.item.CLAYMORE_GRIP, weight = 70 },
        { item = xi.item.TRUMP_CROWN,   weight = 520 },
    },

    {
        { item = xi.item.KING_OF_CUPS_CARD,   weight = 250 },
        { item = xi.item.KING_OF_BATONS_CARD, weight = 250 },
        { item = xi.item.KING_OF_SWORDS_CARD, weight = 250 },
        { item = xi.item.KING_OF_COINS_CARD,  weight = 250 },
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
