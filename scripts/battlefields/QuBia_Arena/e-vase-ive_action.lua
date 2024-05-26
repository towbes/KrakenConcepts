-----------------------------------
-- E-vase-ive Action
-- Qu'Bia Arena KSNM30, Lachesis Orb
-- !additem 1130
-----------------------------------
local qubiaID = zones[xi.zone.QUBIA_ARENA]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.QUBIA_ARENA,
    battlefieldId    = xi.battlefield.id.E_VASE_IVE_ACTION,
    maxPlayers       = 6,
    levelCap         = 75,
    timeLimit        = utils.minutes(30),
    index            = 2,
    entryNpc         = 'BC_Entrance',
    exitNpc          = 'Burning_Circle',
    requiredItems    = { xi.item.LACHESIS_ORB, wearMessage = qubiaID.text.A_CRACK_HAS_FORMED, wornMessage = qubiaID.text.ORB_IS_CRACKED },
})

content:addEssentialMobs({
    'Fire_Pot',
    'Ice_Pot',
    'Air_Pot',
    'Earth_Pot',
    'Thunder_Pot',
    'Water_Pot',
})

-- All but the engaged mob despawns on engage, so they are not tracked
-- for the allDeath value.  Override allDeath with death, and trigger
-- win on a single defeated mob.
content.groups[1].death = function(battlefield, mob)
    content:handleAllMonstersDefeated(battlefield, mob)
end

content.loot =
{
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
        { item = xi.item.SWORD_STRAP,     weight = 350 },
        { item = xi.item.POLE_GRIP,       weight = 200 },
        { item = xi.item.CORAL_FRAGMENT,  weight = 150 },
        { item = xi.item.CLAYMORE_GRIP,   weight = 150 },
        { item = xi.item.PHOENIX_FEATHER, weight = 150 },
    },

    {
        { item = xi.item.PETRIFIED_LOG,            weight = 250 },
        { item = xi.item.SQUARE_OF_RAINBOW_CLOTH,  weight = 100 },
        { item = xi.item.SCROLL_OF_CURE_V,         weight =  50 },
        { item = xi.item.SCROLL_OF_THUNDER_III,    weight = 200 },
        { item = xi.item.SCROLL_OF_SHELL_IV,       weight = 250 },
        { item = xi.item.SCROLL_OF_RAISE_III,      weight =  50 },
    },

    {
        { item = xi.item.NONE,                     weight = 250 },
        { item = xi.item.DEMON_HORN,               weight =  50 },
        { item = xi.item.SQUARE_OF_RAINBOW_CLOTH,  weight = 100 },
        { item = xi.item.SPOOL_OF_GOLD_THREAD,     weight = 100 },
        { item = xi.item.EBONY_LOG,                weight = 100 },
        { item = xi.item.MAHOGANY_LOG,             weight =  70 },
        { item = xi.item.RAM_HORN,                 weight =  50 },
        { item = xi.item.PHILOSOPHERS_STONE,       weight = 300 },
    },

    {
        { item = xi.item.CHUNK_OF_MYTHRIL_ORE,       weight =  100 },
        { item = xi.item.EBONY_LOG,                  weight =   50 },
        { item = xi.item.CHUNK_OF_GOLD_ORE,          weight =   50 },
        { item = xi.item.SQUARE_OF_RAINBOW_CLOTH,    weight =   50 },
        { item = xi.item.PHOENIX_FEATHER,            weight =  300 },
        { item = xi.item.VIAL_OF_BLACK_BEETLE_BLOOD, weight =   50 },
        { item = xi.item.PHILOSOPHERS_STONE,         weight =  200 },
    },

    {
        { item = xi.item.NONE,            weight =  450 },
        { item = xi.item.SQUARE_OF_RAXA,  weight =  450 },
        { item = xi.item.PHOENIX_FEATHER, weight =  300 },
    },

    {
        { item = xi.item.NONE,                      weight =  450 },
        { item = xi.item.DAMASCUS_INGOT,            weight =  100 },
        { item = xi.item.SQUARE_OF_DAMASCENE_CLOTH, weight =   50 },
        { item = xi.item.SPOOL_OF_MALBORO_FIBER,    weight =   50 },
        { item = xi.item.SLAB_OF_GRANITE,           weight =  100 },
        { item = xi.item.CHUNK_OF_PLATINUM_ORE,     weight =   50 },
        { item = xi.item.CHUNK_OF_DARKSTEEL_ORE,    weight =  100 },
        { item = xi.item.VILE_ELIXIR,               weight =   50 },
        { item = xi.item.HANDFUL_OF_WYVERN_SCALES,  weight =   50 },
        { item = xi.item.RERAISER,                  weight =   50 },
    },
}

return content:register()
