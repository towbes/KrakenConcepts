-----------------------------------
-- Area: Horlais Peak
--  NPC: Armoury Crate
-----------------------------------
local entity = {}

local loot =
{
    -- BCNM Tails of Woe
    [1] =
    {
        {
            { itemid = xi.item.BLITZ_RING, droprate = 150 }, -- blitz Ring
            { itemid = xi.item.NONE,       droprate = 850 }, -- Nothing
        },

        {
            { itemid = xi.item.AEGIS_RING,    droprate = 300 }, -- aegis Ring
            { itemid = xi.item.TUNDRA_MANTLE, droprate = 200 }, -- tundra mantle
            { itemid = xi.item.DRUIDS_ROPE,   droprate = 200 }, -- druids rope
            { itemid = xi.item.NONE,          droprate = 300 }, -- Nothing
        },

        {
            { itemid = xi.item.FIRE_SPIRIT_PACT,     droprate = 145 }, -- firespirit
            { itemid = xi.item.SCROLL_OF_ERASE,      droprate = 165 }, -- erase
            { itemid = xi.item.SCROLL_OF_PHALANX,    droprate = 140 }, -- phalanx
            { itemid = xi.item.SCROLL_OF_ABSORB_STR, droprate = 123 }, -- absorb-str
            { itemid = xi.item.PERIDOT,              droprate =  94 }, -- peridot
            { itemid = xi.item.PEARL,                droprate =  94 }, -- pearl
            { itemid = xi.item.GREEN_ROCK,           droprate =  13 }, -- green rock
            { itemid = xi.item.AMETRINE,             droprate =  53 }, -- ametrine
            { itemid = xi.item.GOLD_BEASTCOIN,       droprate =  70 }, -- gold beastcoin
            { itemid = xi.item.MYTHRIL_BEASTCOIN,    droprate =  50 }, -- mythril beastcoin
            { itemid = xi.item.YELLOW_ROCK,          droprate =  53 }, -- yellow rock
            { itemid = xi.item.NONE,                 droprate =   0 }, -- nothing
        },

        {
            { itemid = xi.item.SCROLL_OF_ERASE,      droprate = 125 }, -- erase
            { itemid = xi.item.SCROLL_OF_PHALANX,    droprate = 110 }, -- phalanx
            { itemid = xi.item.SCROLL_OF_ABSORB_STR, droprate = 104 }, -- absorb-str
            { itemid = xi.item.PERIDOT,              droprate =  94 }, -- peridot
            { itemid = xi.item.PEARL,                droprate =  94 }, -- pearl
            { itemid = xi.item.GREEN_ROCK,           droprate =  53 }, -- green rock
            { itemid = xi.item.AMETRINE,             droprate =  73 }, -- ametrine
            { itemid = xi.item.GOLD_BEASTCOIN,       droprate =  70 }, -- gold beastcoin
            { itemid = xi.item.MYTHRIL_BEASTCOIN,    droprate =  70 }, -- mythril beastcoin
            { itemid = xi.item.YELLOW_ROCK,          droprate =  73 }, -- yellow rock
            { itemid = xi.item.NONE,                 droprate =  94 }, -- nothing
        },

        {
            { itemid = 4896, droprate = 174 }, -- firespirit
            { itemid = 4751, droprate =  16 }, -- vile elixir
            { itemid = 4714, droprate = 114 }, -- icespikes
            { itemid = 4717, droprate = 174 }, -- refresh
            { itemid = 4947, droprate = 138 }, -- utsusemi ni
            { itemid =  772, droprate =  18 }, -- green rock
            { itemid =  775, droprate =  18 }, -- black rock
            { itemid =  770, droprate =  17 }, -- blue rock
            { itemid =  769, droprate =  16 }, -- red rock
            { itemid =  774, droprate =  16 }, -- purple rock
            { itemid =  776, droprate =  16 }, -- white rock
            { itemid =  771, droprate =  17 }, -- yellow rock
            { itemid =  773, droprate =  17 }, -- translucent rock
            { itemid = 4172, droprate =  21 }, -- reraiser
            { itemid =  699, droprate =  22 }, -- oak log
            { itemid =  701, droprate =  18 }, -- rosewood log
            { itemid =  748, droprate = 120 }, -- gold beastcoin
            { itemid =  749, droprate = 102 }, -- mythril beastcoin
            { itemid =  792, droprate =  21 }, -- pearl
            { itemid =  798, droprate =  23 }, -- Turquoise
            { itemid =  808, droprate =  19 }, -- Goshenite
            { itemid =  793, droprate =  18 }, -- Black pearl
            { itemid =  815, droprate =  17 }, -- sphene
            { itemid =  790, droprate =  20 }, -- garnet
            { itemid =  811, droprate =  18 }, -- ametrine
            { itemid =    0, droprate =   0 }, -- nothing
        },

        {
            { itemid = 4714, droprate = 87 }, -- icespikes
            { itemid = 4717, droprate = 75 }, -- refresh
            { itemid = 4947, droprate = 75 }, -- utsusemi ni
            { itemid =  699, droprate = 80 }, -- oak log
            { itemid =  701, droprate = 97 }, -- rosewood log
            { itemid =  792, droprate = 86 }, -- pearl
            { itemid =  798, droprate = 88 }, -- Turquoise
            { itemid =  808, droprate = 79 }, -- Goshenite
            { itemid =  793, droprate = 93 }, -- Black pearl
            { itemid =  815, droprate = 79 }, -- sphene
            { itemid =  790, droprate = 71 }, -- garnet
            { itemid =  811, droprate = 90 }, -- ametrine
            { itemid =    0, droprate =  0 }, -- nothing
        },
    },

    -- BCNM Dismemberment Brigade
    [2] =
    {
        {
            { itemid = xi.item.KABRAKANS_AXE, droprate = 250 }, -- kabrakans_axe
            { itemid = xi.item.SARNGA,        droprate = 250 }, -- sarnga
            { itemid = xi.item.DRAGVANDIL,    droprate = 250 }, -- dragvandil
            { itemid = xi.item.HAMELIN_FLUTE, droprate = 250 }, -- hamelin_flute
        },

        {
            { itemid = xi.item.NONE,            droprate = 400 }, -- nothing
            { itemid = xi.item.SPECTACLES,      droprate = 200 }, -- spectacles
            { itemid = xi.item.ASSAULT_EARRING, droprate = 200 }, -- assault_earring
            { itemid = xi.item.PEACE_RING,      droprate = 200 }, -- peace_ring
        },

        {
            { itemid = xi.item.NONE,             droprate = 200 }, -- nothing
            { itemid = xi.item.TRANSLUCENT_ROCK, droprate = 200 }, -- translucent_rock
            { itemid = xi.item.GREEN_ROCK,       droprate = 200 }, -- green_rock
            { itemid = xi.item.YELLOW_ROCK,      droprate = 200 }, -- yellow_rock
            { itemid = xi.item.PURPLE_ROCK,      droprate = 200 }, -- purple_rock
        },

        {
            { itemid = xi.item.PAINITE,         droprate = 100 }, -- painite
            { itemid = xi.item.JADEITE,         droprate = 100 }, -- jadeite
            { itemid = xi.item.MYTHRIL_INGOT,   droprate = 100 }, -- mythril_ingot
            { itemid = xi.item.STEEL_INGOT,     droprate = 100 }, -- steel_ingot
            { itemid = xi.item.FLUORITE,        droprate = 100 }, -- fluorite
            { itemid = xi.item.GOLD_INGOT,      droprate = 100 }, -- gold_ingot
            { itemid = xi.item.ZIRCON,          droprate = 100 }, -- zircon
            { itemid = xi.item.CHRYSOBERYL,     droprate = 100 }, -- chrysoberyl
            { itemid = xi.item.DARKSTEEL_INGOT, droprate = 100 }, -- darksteel_ingot
            { itemid = xi.item.MOONSTONE,       droprate = 100 }, -- moonstone
        },

        {
            { itemid = xi.item.NONE,           droprate =  900 }, -- nothing
            { itemid = xi.item.VILE_ELIXIR_P1, droprate =  100 }, -- vile_elixir_+1
        },
    },

    -- BCNM Hostile Herbivores
    [4] =
    {
        {
            { itemid = xi.item.NONE,         droprate = 50 }, -- Nothing
            { itemid = xi.item.OCEAN_BELT,   droprate = 95 }, -- Ocean Belt
            { itemid = xi.item.JUNGLE_BELT,  droprate = 95 }, -- Jungle Belt
            { itemid = xi.item.STEPPE_BELT,  droprate = 95 }, -- Steppe Belt
            { itemid = xi.item.DESERT_BELT,  droprate = 95 }, -- Desert Belt
            { itemid = xi.item.FOREST_BELT,  droprate = 95 }, -- Forest Belt
            { itemid = xi.item.OCEAN_STONE,  droprate = 95 }, -- Ocean Stone
            { itemid = xi.item.JUNGLE_STONE, droprate = 95 }, -- Jungle Stone
            { itemid = xi.item.STEPPE_STONE, droprate = 95 }, -- Steppe Stone
            { itemid = xi.item.DESERT_STONE, droprate = 95 }, -- Desert Stone
            { itemid = xi.item.FOREST_STONE, droprate = 95 }, -- Forest Stone
        },

        {
            { itemid = xi.item.GUARDIANS_RING, droprate = 64 }, -- Guardians Ring
            { itemid = xi.item.KAMPFER_RING,   droprate = 65 }, -- Kampfer Ring
            { itemid = xi.item.CONJURERS_RING, droprate = 65 }, -- Conjurers Ring
            { itemid = xi.item.SHINOBI_RING,   droprate = 65 }, -- Shinobi Ring
            { itemid = xi.item.SLAYERS_RING,   droprate = 65 }, -- Slayers Ring
            { itemid = xi.item.SORCERERS_RING, droprate = 65 }, -- Sorcerers Ring
            { itemid = xi.item.SOLDIERS_RING,  droprate = 64 }, -- Soldiers Ring
            { itemid = xi.item.TAMERS_RING,    droprate = 65 }, -- Tamers Ring
            { itemid = xi.item.TRACKERS_RING,  droprate = 64 }, -- Trackers Ring
            { itemid = xi.item.DRAKE_RING,     droprate = 65 }, -- Drake Ring
            { itemid = xi.item.FENCERS_RING,   droprate = 65 }, -- Fencers Ring
            { itemid = xi.item.MINSTRELS_RING, droprate = 65 }, -- Minstrels Ring
            { itemid = xi.item.MEDICINE_RING,  droprate = 64 }, -- Medicine Ring
            { itemid = xi.item.ROGUES_RING,    droprate = 65 }, -- Rogues Ring
            { itemid = xi.item.RONIN_RING,     droprate = 64 }, -- Ronin Ring
            { itemid = xi.item.PLATINUM_RING,  droprate = 30 }, -- Platinum Ring
        },

        {
            { itemid = xi.item.NONE,                droprate = 100 }, -- Nothing
            { itemid = xi.item.SCROLL_OF_QUAKE,     droprate = 176 }, -- Scroll Of Quake
            { itemid = xi.item.LIGHT_SPIRIT_PACT,   droprate =  10 }, -- Light Spirit Pact
            { itemid = xi.item.SCROLL_OF_FREEZE,    droprate = 176 }, -- Scroll Of Freeze
            { itemid = xi.item.SCROLL_OF_REGEN_III, droprate = 176 }, -- Scroll Of Regen Iii
            { itemid = xi.item.RERAISER,            droprate =  60 }, -- Reraiser
            { itemid = xi.item.VILE_ELIXIR,         droprate =  60 }, -- Vile Elixir
            { itemid = xi.item.SCROLL_OF_RAISE_II,  droprate = 176 }, -- Scroll Of Raise Ii
        },

        {
            { itemid = xi.item.NONE,                droprate = 100 }, -- Nothing
            { itemid = xi.item.SCROLL_OF_QUAKE,     droprate = 176 }, -- Scroll Of Quake
            { itemid = xi.item.LIGHT_SPIRIT_PACT,   droprate =  10 }, -- Light Spirit Pact
            { itemid = xi.item.SCROLL_OF_FREEZE,    droprate = 176 }, -- Scroll Of Freeze
            { itemid = xi.item.SCROLL_OF_REGEN_III, droprate = 176 }, -- Scroll Of Regen Iii
            { itemid = xi.item.RERAISER,            droprate =  60 }, -- Reraiser
            { itemid = xi.item.VILE_ELIXIR,         droprate =  60 }, -- Vile Elixir
            { itemid = xi.item.SCROLL_OF_RAISE_II,  droprate = 176 }, -- Scroll Of Raise Ii
        },

        {
            { itemid = xi.item.RAM_HORN,                 droprate =  59 }, -- Ram Horn
            { itemid = xi.item.MAHOGANY_LOG,             droprate =  59 }, -- Mahogany Log
            { itemid = xi.item.MYTHRIL_INGOT,            droprate = 200 }, -- Mythril Ingot
            { itemid = xi.item.MANTICORE_HIDE,           droprate =  59 }, -- Manticore Hide
            { itemid = xi.item.HANDFUL_OF_WYVERN_SCALES, droprate =  90 }, -- Handful Of Wyvern Scales
            { itemid = xi.item.WYVERN_SKIN,              droprate =  90 }, -- Wyvern Skin
            { itemid = xi.item.PETRIFIED_LOG,            droprate = 176 }, -- Petrified Log
            { itemid = xi.item.DARKSTEEL_INGOT,          droprate =  59 }, -- Darksteel Ingot
            { itemid = xi.item.RAM_SKIN,                 droprate =  59 }, -- Ram Skin
            { itemid = xi.item.PLATINUM_INGOT,           droprate =  90 }, -- Platinum Ingot
        },

        {
            { itemid = xi.item.NONE,                     droprate = 100 }, -- Nothing
            { itemid = xi.item.RAM_HORN,                 droprate =  59 }, -- Ram Horn
            { itemid = xi.item.MAHOGANY_LOG,             droprate =  59 }, -- Mahogany Log
            { itemid = xi.item.MYTHRIL_INGOT,            droprate = 200 }, -- Mythril Ingot
            { itemid = xi.item.MANTICORE_HIDE,           droprate =  59 }, -- Manticore Hide
            { itemid = xi.item.HANDFUL_OF_WYVERN_SCALES, droprate =  90 }, -- Handful Of Wyvern Scales
            { itemid = xi.item.WYVERN_SKIN,              droprate =  90 }, -- Wyvern Skin
            { itemid = xi.item.PETRIFIED_LOG,            droprate = 176 }, -- Petrified Log
            { itemid = xi.item.DARKSTEEL_INGOT,          droprate =  59 }, -- Darksteel Ingot
            { itemid = xi.item.RAM_SKIN,                 droprate =  59 }, -- Ram Skin
            { itemid = xi.item.PLATINUM_INGOT,           droprate =  90 }, -- Platinum Ingot
        },
    },

    -- BCNM Carapace Combatants
    [8] =
    {
        {
            { itemid = xi.item.BEETLE_JAW, droprate = 1000 }, -- beetle_jaw
        },

        {
            { itemid = xi.item.BEETLE_SHELL, droprate = 1000 }, -- beetle_shell
        },

        {
            { itemid = xi.item.NONE,        droprate = 250 }, -- nothing
            { itemid = xi.item.KATANA_OBI,  droprate = 150 }, -- katana_obi
            { itemid = xi.item.STAFF_BELT,  droprate = 150 }, -- staff_belt
            { itemid = xi.item.SONG_BELT,   droprate = 150 }, -- song_belt
            { itemid = xi.item.CESTUS_BELT, droprate = 150 }, -- cestus_belt
            { itemid = xi.item.PICK_BELT,   droprate = 150 }, -- pick_belt
        },

        {
            { itemid = xi.item.NONE,              droprate = 125 }, -- nothing
            { itemid = xi.item.GENIN_EARRING,     droprate = 125 }, -- genin_earring
            { itemid = xi.item.MAGICIANS_EARRING, droprate = 125 }, -- magicians_earring
            { itemid = xi.item.PILFERERS_EARRING, droprate = 125 }, -- pilferers_earring
            { itemid = xi.item.WARLOCKS_EARRING,  droprate = 125 }, -- warlocks_earring
            { itemid = xi.item.WRESTLERS_EARRING, droprate = 125 }, -- wrestlers_earring
            { itemid = xi.item.WYVERN_EARRING,    droprate = 125 }, -- wyvern_earring
            { itemid = xi.item.KILLER_EARRING,    droprate = 125 }, -- killer_earring
        },

        {
            { itemid = xi.item.NONE,                   droprate = 160 }, -- nothing
            { itemid = xi.item.CHUNK_OF_DARKSTEEL_ORE, droprate = 140 }, -- chunk_of_darksteel_ore
            { itemid = xi.item.MYTHRIL_INGOT,          droprate = 140 }, -- mythril_ingot
            { itemid = xi.item.SILVER_INGOT,           droprate = 140 }, -- silver_ingot
            { itemid = xi.item.STEEL_INGOT,            droprate = 140 }, -- steel_ingot
            { itemid = xi.item.CHUNK_OF_MYTHRIL_ORE,   droprate = 140 }, -- chunk_of_mythril_ore
            { itemid = xi.item.SARDONYX,               droprate = 140 }, -- sardonyx
        },

        {
            { itemid = xi.item.NONE,                   droprate = 250 }, -- nothing
            { itemid = xi.item.SCROLL_OF_DISPEL,       droprate = 125 }, -- scroll_of_dispel
            { itemid = xi.item.SCROLL_OF_UTSUSEMI_NI,  droprate = 125 }, -- scroll_of_utsusemi_ni
            { itemid = xi.item.SCROLL_OF_FIRE_II,      droprate = 125 }, -- scroll_of_fire_ii
            { itemid = xi.item.SCROLL_OF_MAGIC_FINALE, droprate = 125 }, -- scroll_of_magic_finale
            { itemid = xi.item.SCROLL_OF_ABSORB_AGI,   droprate = 125 }, -- scroll_of_absorb-agi
            { itemid = xi.item.SCROLL_OF_ABSORB_INT,   droprate = 125 }, -- scroll_of_absorb-int
        },

        {
            { itemid = xi.item.NONE,               droprate = 500 }, -- nothing
            { itemid = xi.item.JUG_OF_SCARLET_SAP, droprate = 500 }, -- jug_of_scarlet_sap
        },

        {
            { itemid = xi.item.NONE,               droprate = 750 }, -- nothing
            { itemid = xi.item.JUG_OF_SCARLET_SAP, droprate = 250 }, -- jug_of_scarlet_sap
        },

        {
            { itemid = xi.item.NONE,     droprate = 900 }, -- nothing
            { itemid = xi.item.HI_ETHER, droprate = 100 }, -- hi-ether
        },
    },

    -- BCNM Shooting Fish
    [9] =
    {
        {
            { itemid = xi.item.MANNEQUIN_HEAD, droprate = 1000 }, -- mannequin_head
        },

        {
            { itemid = xi.item.SHALL_SHELL, droprate = 1000 }, -- shall_shell
        },

        {
            { itemid = xi.item.MYTHRIL_BEASTCOIN, droprate = 300 }, -- mythril_beastcoin
            { itemid = xi.item.BLACK_ROCK,        droprate =  70 }, -- black_rock
            { itemid = xi.item.PURPLE_ROCK,       droprate =  30 }, -- purple_rock
            { itemid = xi.item.WHITE_ROCK,        droprate = 100 }, -- white_rock
            { itemid = xi.item.PLATOON_BOW,       droprate = 100 }, -- platoon_bow
            { itemid = xi.item.PLATOON_MACE,      droprate = 100 }, -- platoon_mace
            { itemid = xi.item.PLATOON_DISC,      droprate = 150 }, -- platoon_disc
            { itemid = xi.item.PLATOON_GUN,       droprate = 150 }, -- platoon_gun
        },

        {
            { itemid = xi.item.MYTHRIL_BEASTCOIN, droprate = 310 }, -- mythril_beastcoin
            { itemid = xi.item.GREEN_ROCK,        droprate =  50 }, -- green_rock
            { itemid = xi.item.YELLOW_ROCK,       droprate =  40 }, -- yellow_rock
            { itemid = xi.item.BLUE_ROCK,         droprate =  40 }, -- blue_rock
            { itemid = xi.item.RED_ROCK,          droprate =  40 }, -- red_rock
            { itemid = xi.item.TRANSLUCENT_ROCK,  droprate = 110 }, -- translucent_rock
            { itemid = xi.item.PLATOON_CESTI,     droprate = 130 }, -- platoon_cesti
            { itemid = xi.item.PLATOON_CUTTER,    droprate = 100 }, -- platoon_cutter
            { itemid = xi.item.PLATOON_SPATHA,    droprate =  80 }, -- platoon_spatha
            { itemid = xi.item.PLATOON_ZAGHNAL,   droprate = 100 }, -- platoon_zaghnal
        },

        {
            { itemid = xi.item.NONE,                    droprate = 670 }, -- nothing
            { itemid = xi.item.HANDFUL_OF_PUGIL_SCALES, droprate = 190 }, -- handful_of_pugil_scales
            { itemid = xi.item.SHALL_SHELL,             droprate = 140 }, -- shall_shell
        },

        {
            { itemid = xi.item.NONE,           droprate = 930 }, -- nothing
            { itemid = xi.item.MANNEQUIN_BODY, droprate =  70 }, -- mannequin_body
        },

        {
            { itemid = xi.item.SCROLL_OF_BLAZE_SPIKES,  droprate = 180 }, -- scroll_of_blaze_spikes
            { itemid = xi.item.SCROLL_OF_HORDE_LULLABY, droprate = 510 }, -- scroll_of_horde_lullaby
            { itemid = xi.item.THUNDER_SPIRIT_PACT,     droprate = 280 }, -- thunder_spirit_pact
            { itemid = xi.item.SCROLL_OF_WARP,          droprate =  30 }, -- scroll_of_warp
        },
    },

    -- BCNM Dropping Like Flies
    [10] =
    {
        {
            { itemid = xi.item.GIL, droprate = 1000, amount = 4000 }, -- Gil
        },

        {
            { itemid = xi.item.INSECT_WING, droprate = 1000 }, -- Insect Wing
        },

        {
            { itemid = xi.item.MANNEQUIN_HEAD, droprate = 1000 }, -- Mannequin Head
        },

        {
            { itemid = xi.item.NONE,            droprate = 636 }, -- Nothing
            { itemid = xi.item.EMPEROR_HAIRPIN, droprate = 364 }, -- Emperor Hairpin
        },

        {
            { itemid = xi.item.ASHIGARU_TARGE,  droprate = 175 }, -- Ashigaru Targe
            { itemid = xi.item.BEATERS_ASPIS,   droprate = 175 }, -- Beaters Aspis
            { itemid = xi.item.VARLETS_TARGE,   droprate = 175 }, -- Varlets Targe
            { itemid = xi.item.WRESTLERS_ASPIS, droprate = 175 }, -- Wrestlers Aspis
            { itemid = xi.item.CLEAR_TOPAZ,     droprate = 100 }, -- Clear Topaz
            { itemid = xi.item.LAPIS_LAZULI,    droprate = 100 }, -- Lapis Lazuli
            { itemid = xi.item.LIGHT_OPAL,      droprate = 100 }, -- Light Opal
        },

        {
            { itemid = xi.item.MERCENARY_MANTLE, droprate = 250 }, -- Mercenary Mantle
            { itemid = xi.item.SINGERS_MANTLE,   droprate = 250 }, -- Singers Mantle
            { itemid = xi.item.WIZARDS_MANTLE,   droprate = 250 }, -- Wizards Mantle
            { itemid = xi.item.WYVERN_MANTLE,    droprate = 250 }, -- Wyvern Mantle
        },

        {
            { itemid = xi.item.SCROLL_OF_UTSUSEMI_NI,   droprate =  70 }, -- Scroll Of Utsusemi Ni
            { itemid = xi.item.SCROLL_OF_MAGIC_FINALE,  droprate =  70 }, -- Scroll Of Magic Finale
            { itemid = xi.item.JUG_OF_QUADAV_BUG_BROTH, droprate = 150 }, -- Jug Of Quadav Bug Broth
            { itemid = xi.item.ONYX,                    droprate = 100 }, -- Onyx
            { itemid = xi.item.LAPIS_LAZULI,            droprate = 100 }, -- Lapis Lazuli
            { itemid = xi.item.LIGHT_OPAL,              droprate = 100 }, -- Light Opal
            { itemid = xi.item.SCROLL_OF_DISPEL,        droprate = 150 }, -- Scroll Of Dispel
            { itemid = xi.item.SCROLL_OF_ERASE,         droprate = 100 }, -- Scroll Of Erase
            { itemid = xi.item.ELM_LOG,                 droprate =  90 }, -- Elm Log
            { itemid = xi.item.MANNEQUIN_BODY,          droprate =  70 }, -- Mannequin Body
        },
    },

    -- KSNM Horns of War
    [11] =
    {
        {
            {itemid =  1441, droprate = 158}, -- Libation Abjuration
            {itemid = 17939, droprate = 263}, -- Kriegsbeil
            {itemid = 17823, droprate =  92}, -- Shinsoku
            {itemid = 18173, droprate =  79}, -- Nokizaru Shuriken
            {itemid = 17694, droprate =  66}, -- Guespiere
            {itemid = 17464, droprate = 105}, -- Purgatory Mace
            {itemid = 18351, droprate = 237}, -- Meteor Cesti
        },
        {
            {itemid =  1442, droprate = 169}, -- Oblation Abjuration
            {itemid = 17789, droprate =  12}, -- Unsho
            {itemid = 17838, droprate = 235}, -- Harlequins Horn
            {itemid = 18088, droprate =  77}, -- Dreizack
            {itemid = 18211, droprate = 248}, -- Gawains Axe
            {itemid = 17578, droprate = 195}, -- Zen Pole
            {itemid = 17695, droprate =  64}, -- Bayards Sword

        },
        {
            {itemid =  703, droprate = 556}, -- Petrified Log
            {itemid = 1446, droprate = 289}, -- Lacquer Tree Log
            {itemid =  831, droprate =  25}, -- Square Of Shining Cloth
            {itemid =  722, droprate = 130}, -- Divine Log
        },
        {
            {itemid =   860, droprate = 572}, -- Behemoth Hide
            {itemid =   883, droprate = 428}, -- Behemoth Horn
            {itemid = 17108, droprate =  53}, -- Healing Staff
        },
        {
            {itemid =  902, droprate =  86}, -- Demon Horn
            {itemid =  703, droprate =  47}, -- Petrified Log
            {itemid = 1132, droprate =  47}, -- Square Of Raxa
            {itemid =  830, droprate =   7}, -- Square Of Rainbow Cloth
            {itemid = 4173, droprate =  99}, -- Hi-reraiser
            {itemid =  703, droprate = 179}, -- Petrified Log
            {itemid =  942, droprate = 113}, -- Philosophers Stone
            {itemid =  737, droprate =  47}, -- Chunk Of Gold Ore
            {itemid =  644, droprate =  60}, -- Chunk Of Mythril Ore
            {itemid =  887, droprate =  47}, -- Coral Fragment
            {itemid =  700, droprate =  60}, -- Mahogany Log
            {itemid =  866, droprate =  20}, -- Handful Of Wyvern Scales
            {itemid =  645, droprate =  20}, -- Chunk Of Darksteel Ore
            {itemid =  895, droprate =  47}, -- Ram Horn
            {itemid =  702, droprate =  73}, -- Ebony Log
            {itemid = 4172, droprate =   7}, -- Reraiser
            {itemid =  738, droprate =  20}, -- Chunk Of Platinum Ore
            {itemid = 4174, droprate =  20}, -- Vile Elixir
            {itemid = 4175, droprate =   1}, -- Vile Elixir +1
        },
        {
            {itemid = 1527, droprate = 199}, -- Behemoth Tongue
            {itemid =  883, droprate = 318}, -- Behemoth Horn
            {itemid = 4199, droprate = 147}, -- Strength Potion
            {itemid = 4201, droprate =  68}, -- Dexterity Potion
            {itemid = 4205, droprate = 134}, -- Agility Potion
            {itemid = 4203, droprate = 134}, -- Vitality Potion
        },
        {
            {itemid =  4209, droprate = 172}, -- Mind Potion
            {itemid =  4207, droprate =  80}, -- Intelligence Potion
            {itemid =  4211, droprate = 106}, -- Charisma Potion
            {itemid =  4213, droprate = 172}, -- Icarus Wing
            {itemid = 17840, droprate = 239}, -- Angel Lyre
            {itemid =   785, droprate = 107}, -- Emerald
            {itemid =   804, droprate =  41}, -- Spinel
            {itemid =   786, droprate =  55}, -- Ruby
            {itemid =   787, droprate =  28}, -- Diamond
        },
        {
            {itemid = 4135, droprate = 289}, -- Hi-ether +3
            {itemid = 4119, droprate = 237}, -- Hi-potion +3
            {itemid = 4173, droprate = 198}, -- Hi-reraiser
            {itemid = 4175, droprate = 276}, -- Vile Elixir +1
        },
        {
            {itemid =  887, droprate = 123}, -- Coral Fragment
            {itemid = 1132, droprate =   5}, -- Square Of Raxa
            {itemid =  902, droprate =  98}, -- Demon Horn
            {itemid =  737, droprate =  18}, -- Chunk Of Gold Ore
            {itemid =  644, droprate =  71}, -- Chunk Of Mythril Ore
            {itemid = 4174, droprate =  44}, -- Vile Elixir
            {itemid =  895, droprate =  19}, -- Ram Horn
            {itemid =  703, droprate = 280}, -- Petrified Log
            {itemid =  738, droprate =   5}, -- Chunk Of Platinum Ore
            {itemid =  700, droprate =  45}, -- Mahogany Log
            {itemid =  866, droprate =  58}, -- Handful Of Wyvern Scales
            {itemid = 1465, droprate =  31}, -- Slab Of Granite
            {itemid =  645, droprate =  30}, -- Chunk Of Darksteel Ore
            {itemid =  702, droprate =  30}, -- Ebony Log
            {itemid = 4173, droprate =  30}, -- Hi-reraiser
            {itemid =  823, droprate =  96}, -- Spool Of Gold Thread
            {itemid =  830, droprate =  17}, -- Square Of Rainbow Cloth
        },
        {
            {itemid = 1132, droprate = 114}, -- Square Of Raxa
            {itemid =  837, droprate =  50}, -- Spool Of Malboro Fiber
            {itemid =  942, droprate = 220}, -- Philosophers Stone
            {itemid =  844, droprate = 404}, -- Phoenix Feather
            {itemid =  836, droprate =  62}, -- Square Of Damascene Cloth
            {itemid =  658, droprate =  49}, -- Damascus Ingot
            {itemid = 1110, droprate = 101}, -- Vial Of Black Beetle Blood
        },
    },

    -- BCNM Under Observation
    [12] =
    {
        {
            { itemid = xi.item.NONE,          droprate = 910 }, -- Nothing
            { itemid = xi.item.PEACOCK_CHARM, droprate =  90 }, -- Peacock Charm
        },

        {
            { itemid = xi.item.NONE,          droprate = 467 }, -- Nothing
            { itemid = xi.item.BEHOURD_LANCE, droprate =  48 }, -- Behourd Lance
            { itemid = xi.item.MUTILATOR,     droprate =  61 }, -- Mutilator
            { itemid = xi.item.RAIFU,         droprate =  46 }, -- Raifu
            { itemid = xi.item.TILT_BELT,     droprate = 302 }, -- Tilt Belt
            { itemid = xi.item.TOURNEY_PATAS, droprate =  76 }, -- Tourney Patas
        },

        {
            { itemid = xi.item.NONE,                  droprate = 413 }, -- Nothing
            { itemid = xi.item.BUZZARD_TUCK,          droprate =  42 }, -- Buzzard Tuck
            { itemid = xi.item.DE_SAINTRES_AXE,       droprate =  77 }, -- De Saintres Axe
            { itemid = xi.item.GRUDGE_SWORD,          droprate =  73 }, -- Grudge Sword
            { itemid = xi.item.MANTRA_BELT,           droprate = 258 }, -- Mantra Belt
            { itemid = xi.item.SCROLL_OF_REFRESH,     droprate =  68 }, -- Scroll Of Refresh
            { itemid = xi.item.SCROLL_OF_UTSUSEMI_NI, droprate =  55 }, -- Scroll Of Utsusemi Ni
            { itemid = xi.item.SCROLL_OF_ICE_SPIKES,  droprate =  14 }, -- Scroll Of Ice Spikes
        },

        {
            { itemid = xi.item.SCROLL_OF_ICE_SPIKES,  droprate = 114 }, -- Scroll Of Ice Spikes
            { itemid = xi.item.SCROLL_OF_REFRESH,     droprate = 174 }, -- Scroll Of Refresh
            { itemid = xi.item.SCROLL_OF_UTSUSEMI_NI, droprate = 138 }, -- Scroll Of Utsusemi Ni
            { itemid = xi.item.RED_ROCK,              droprate =  16 }, -- Red Rock
            { itemid = xi.item.BLUE_ROCK,             droprate =  17 }, -- Blue Rock
            { itemid = xi.item.YELLOW_ROCK,           droprate =  17 }, -- Yellow Rock
            { itemid = xi.item.GREEN_ROCK,            droprate =  18 }, -- Green Rock
            { itemid = xi.item.TRANSLUCENT_ROCK,      droprate =  17 }, -- Translucent Rock
            { itemid = xi.item.PURPLE_ROCK,           droprate =  16 }, -- Purple Rock
            { itemid = xi.item.BLACK_ROCK,            droprate =  18 }, -- Black Rock
            { itemid = xi.item.WHITE_ROCK,            droprate =  16 }, -- White Rock
            { itemid = xi.item.MYTHRIL_BEASTCOIN,     droprate = 102 }, -- Mythril Beastcoin
            { itemid = xi.item.GOLD_BEASTCOIN,        droprate = 120 }, -- Gold Beastcoin
            { itemid = xi.item.OAK_LOG,               droprate =  22 }, -- Oak Log
            { itemid = xi.item.AMETRINE,              droprate =  18 }, -- Ametrine
            { itemid = xi.item.BLACK_PEARL,           droprate =  18 }, -- Black Pearl
            { itemid = xi.item.GARNET,                droprate =  20 }, -- Garnet
            { itemid = xi.item.GOSHENITE,             droprate =  19 }, -- Goshenite
            { itemid = xi.item.PEARL,                 droprate =  21 }, -- Pearl
            { itemid = xi.item.PERIDOT,               droprate =  35 }, -- Peridot
            { itemid = xi.item.SPHENE,                droprate =  17 }, -- Sphene
            { itemid = xi.item.TURQUOISE,             droprate =  23 }, -- Turquoise
            { itemid = xi.item.RERAISER,              droprate =  21 }, -- Reraiser
            { itemid = xi.item.VILE_ELIXIR,           droprate =  16 }, -- Vile Elixir
        },

        {
            { itemid = xi.item.FIRE_SPIRIT_PACT,     droprate = 116 }, -- Fire Spirit Pact
            { itemid = xi.item.SCROLL_OF_ABSORB_STR, droprate = 113 }, -- Scroll Of Absorb-str
            { itemid = xi.item.SCROLL_OF_ERASE,      droprate = 137 }, -- Scroll Of Erase
            { itemid = xi.item.SCROLL_OF_ICE_SPIKES, droprate =  67 }, -- Scroll Of Ice Spikes
            { itemid = xi.item.SCROLL_OF_PHALANX,    droprate =  99 }, -- Scroll Of Phalanx
            { itemid = xi.item.AMETRINE,             droprate =  58 }, -- Ametrine
            { itemid = xi.item.BLACK_PEARL,          droprate =  52 }, -- Black Pearl
            { itemid = xi.item.GARNET,               droprate =  51 }, -- Garnet
            { itemid = xi.item.GOSHENITE,            droprate =  65 }, -- Goshenite
            { itemid = xi.item.PEARL,                droprate =  61 }, -- Pearl
            { itemid = xi.item.PERIDOT,              droprate =  63 }, -- Peridot
            { itemid = xi.item.SPHENE,               droprate =  55 }, -- Sphene
            { itemid = xi.item.TURQUOISE,            droprate =  62 }, -- Turquoise
        },

        {
            { itemid = xi.item.HECTEYES_EYE, droprate = 1000 }, -- Hecteyes Eye
        },

        {
            { itemid = xi.item.VIAL_OF_MERCURY, droprate = 1000 }, -- Vial Of Mercury
        },
    },

    -- BCNM Eye of the Tiger
    [13] =
    {
        {
            { itemid = xi.item.BLACK_TIGER_FANG, droprate = 1000 }, -- black_tiger_fang
        },

        {
            { itemid = xi.item.BLACK_TIGER_FANG, droprate = 1000 }, -- black_tiger_fang
        },

        {
            { itemid = xi.item.NONE,     droprate = 700 }, -- nothing
            { itemid = xi.item.NUE_FANG, droprate = 300 }, -- nue_fang
        },

        {
            { itemid = xi.item.NONE,                    droprate = 125 }, -- nothing
            { itemid = xi.item.IVORY_MITTS,             droprate = 125 }, -- ivory_mitts
            { itemid = xi.item.SUPER_RIBBON,            droprate = 125 }, -- super_ribbon
            { itemid = xi.item.MANA_CIRCLET,            droprate = 125 }, -- mana_circlet
            { itemid = xi.item.RIVAL_RIBBON,            droprate = 125 }, -- rival_ribbon
            { itemid = xi.item.SLY_GAUNTLETS,           droprate = 125 }, -- sly_gauntlets
            { itemid = xi.item.SHOCK_MASK,              droprate = 125 }, -- shock_mask
            { itemid = xi.item.SPIKED_FINGER_GAUNTLETS, droprate = 125 }, -- spiked_finger_gauntlets
        },

        {
            { itemid = xi.item.INTELLECT_TORQUE, droprate = 125 }, -- intellect_torque
            { itemid = xi.item.ESOTERIC_MANTLE,  droprate = 125 }, -- esoteric_mantle
            { itemid = xi.item.TEMPLARS_MANTLE,  droprate = 125 }, -- templars_mantle
            { itemid = xi.item.SNIPERS_MANTLE,   droprate = 125 }, -- snipers_mantle
            { itemid = xi.item.HATEFUL_COLLAR,   droprate = 125 }, -- hateful_collar
            { itemid = xi.item.STORM_GORGET,     droprate = 125 }, -- storm_gorget
            { itemid = xi.item.HEAVY_MANTLE,     droprate = 125 }, -- heavy_mantle
            { itemid = xi.item.BENIGN_NECKLACE,  droprate = 125 }, -- benign_necklace
        },

        {
            { itemid = xi.item.NONE,           droprate = 125 }, -- nothing
            { itemid = xi.item.GOLD_INGOT,     droprate = 125 }, -- gold_ingot
            { itemid = xi.item.RAM_HORN,       droprate = 125 }, -- ram_horn
            { itemid = xi.item.WYVERN_SKIN,    droprate = 125 }, -- wyvern_skin
            { itemid = xi.item.EBONY_LOG,      droprate = 125 }, -- ebony_log
            { itemid = xi.item.MYTHRIL_INGOT,  droprate = 125 }, -- mythril_ingot
            { itemid = xi.item.RAM_SKIN,       droprate = 125 }, -- ram_skin
            { itemid = xi.item.CORAL_FRAGMENT, droprate = 125 }, -- coral_fragment
        },

        {
            { itemid = xi.item.NONE,                  droprate = 400 }, -- nothing
            { itemid = xi.item.SLICE_OF_BUFFALO_MEAT, droprate = 200 }, -- slice_of_buffalo_meat
            { itemid = xi.item.SLICE_OF_DRAGON_MEAT,  droprate = 200 }, -- slice_of_dragon_meat
            { itemid = xi.item.SLICE_OF_COEURL_MEAT,  droprate = 200 }, -- slice_of_coeurl_meat
        },

        {
            { itemid = xi.item.NONE,               droprate = 625 }, -- nothing
            { itemid = xi.item.SCROLL_OF_FREEZE,   droprate = 125 }, -- scroll_of_freeze
            { itemid = xi.item.SCROLL_OF_RAISE_II, droprate = 125 }, -- scroll_of_raise_ii
            { itemid = xi.item.SCROLL_OF_QUAKE,    droprate = 125 }, -- scroll_of_quake
        },
    },

    -- BCNM Shots in the Dark
    [14] =
    {
        {
            { itemid = xi.item.GOLD_BEASTCOIN,    droprate = 500 }, -- gold_beastcoin
            { itemid = xi.item.MYTHRIL_BEASTCOIN, droprate = 500 }, -- mythril_beastcoin
        },

        {
            { itemid = xi.item.STEEL_INGOT, droprate = 500 }, -- steel_ingot
            { itemid = xi.item.AQUAMARINE,  droprate = 500 }, -- aquamarine
        },

        {
            { itemid = xi.item.NONE,         droprate = 500 }, -- nothing
            { itemid = xi.item.DEMON_QUIVER, droprate = 500 }, -- demon_quiver
        },

        {
            { itemid =     0, droprate =  200 }, -- nothing
            { itemid = 14661, droprate =  400 }, -- teleport_ring_holla
            { itemid = 14664, droprate =  400 }, -- teleport_ring_vahzl
        },

        {
            { itemid = 13687, droprate =  250 }, -- sapient_cape
            { itemid = 14870, droprate =  250 }, -- trainers_wristbands
            { itemid =  4224, droprate =  500 }, -- demon_quiver
        },
    },

    -- KSNM Double Dragonian
    [15] =
    {
        {
            { itemid = xi.item.SUBDUER,        droprate = 222 }, -- Subduer
            { itemid = xi.item.DISSECTOR,      droprate = 302 }, -- Dissector
            { itemid = xi.item.DESTROYERS,     droprate = 245 }, -- Destroyers
            { itemid = xi.item.HEART_SNATCHER, droprate = 208 }, -- Heart Snatcher
        },

        {
            { itemid = xi.item.NONE,                 droprate = 638 }, -- Nothing
            { itemid = xi.item.VIAL_OF_DRAGON_BLOOD, droprate =  10 }, -- Vial Of Dragon Blood
            { itemid = xi.item.DRAGON_HEART,         droprate = 176 }, -- Dragon Heart
            { itemid = xi.item.SLICE_OF_DRAGON_MEAT, droprate = 176 }, -- Slice Of Dragon Meat
        },

        {
            { itemid = xi.item.NONE,                 droprate = 638 }, -- Nothing
            { itemid = xi.item.VIAL_OF_DRAGON_BLOOD, droprate =  10 }, -- Vial Of Dragon Blood
            { itemid = xi.item.DRAGON_HEART,         droprate = 176 }, -- Dragon Heart
            { itemid = xi.item.SLICE_OF_DRAGON_MEAT, droprate = 176 }, -- Slice Of Dragon Meat
        },

        {
            { itemid = xi.item.NONE,        droprate = 392 }, -- Nothing
            { itemid = xi.item.SPEAR_STRAP, droprate = 354 }, -- Spear Strap
            { itemid = xi.item.SWORD_STRAP, droprate = 165 }, -- Sword Strap
            { itemid = xi.item.POLE_GRIP,   droprate =  89 }, -- Pole Grip
        },

        {
            { itemid = xi.item.MINUET_EARRING,   droprate = 586 }, -- Minuet Earring
            { itemid = xi.item.ADAMAN_INGOT,     droprate = 184 }, -- Adaman Ingot
            { itemid = xi.item.ORICHALCUM_INGOT, droprate = 207 }, -- Orichalcum Ingot
        },

        {
            { itemid = xi.item.SORROWFUL_HARP,  droprate = 238 }, -- Sorrowful Harp
            { itemid = xi.item.ATTILAS_EARRING, droprate = 250 }, -- Attilas Earring
            { itemid = xi.item.DURANDAL,        droprate = 225 }, -- Durandal
            { itemid = xi.item.HOPLITES_HARPE,  droprate = 275 }, -- Hoplites Harpe
        },

        {
            { itemid = xi.item.CHUNK_OF_GOLD_ORE,        droprate = 122 }, -- Chunk Of Gold Ore
            { itemid = xi.item.RERAISER,                 droprate =  54 }, -- Reraiser
            { itemid = xi.item.CHUNK_OF_MYTHRIL_ORE,     droprate =  41 }, -- Chunk Of Mythril Ore
            { itemid = xi.item.DEMON_HORN,               droprate =  81 }, -- Demon Horn
            { itemid = xi.item.EBONY_LOG,                droprate = 149 }, -- Ebony Log
            { itemid = xi.item.HANDFUL_OF_WYVERN_SCALES, droprate =  54 }, -- Handful Of Wyvern Scales
            { itemid = xi.item.VILE_ELIXIR_P1,           droprate =  27 }, -- Vile Elixir +1
            { itemid = xi.item.MAHOGANY_LOG,             droprate =  41 }, -- Mahogany Log
            { itemid = xi.item.CORAL_FRAGMENT,           droprate =  95 }, -- Coral Fragment
            { itemid = xi.item.PETRIFIED_LOG,            droprate = 108 }, -- Petrified Log
            { itemid = xi.item.PHOENIX_FEATHER,          droprate = 135 }, -- Phoenix Feather
            { itemid = xi.item.CHUNK_OF_PLATINUM_ORE,    droprate =  54 }, -- Chunk Of Platinum Ore
            { itemid = xi.item.RAM_HORN,                 droprate =  14 }, -- Ram Horn
            { itemid = xi.item.SQUARE_OF_RAINBOW_CLOTH,  droprate =  14 }, -- Square Of Rainbow Cloth
            { itemid = xi.item.CHUNK_OF_DARKSTEEL_ORE,   droprate =  68 }, -- Chunk Of Darksteel Ore
            { itemid = xi.item.HI_RERAISER,              droprate =  14 }, -- Hi-reraiser
            { itemid = xi.item.SQUARE_OF_RAXA,           droprate = 135 }, -- Square Of Raxa
        },

        {
            { itemid = xi.item.SQUARE_OF_DAMASCENE_CLOTH,  droprate =  96 }, -- Square Of Damascene Cloth
            { itemid = xi.item.DAMASCUS_INGOT,             droprate =  27 }, -- Damascus Ingot
            { itemid = xi.item.PHILOSOPHERS_STONE,         droprate = 164 }, -- Philosophers Stone
            { itemid = xi.item.PHOENIX_FEATHER,            droprate = 260 }, -- Phoenix Feather
            { itemid = xi.item.SPOOL_OF_MALBORO_FIBER,     droprate =  96 }, -- Spool Of Malboro Fiber
            { itemid = xi.item.SQUARE_OF_RAXA,             droprate = 288 }, -- Square Of Raxa
            { itemid = xi.item.VIAL_OF_BLACK_BEETLE_BLOOD, droprate =  41 }, -- Vial Of Black Beetle Blood
        },
    },

        -- KSNM Today's Horoscope
    [16] =
    {
        {
            {itemid = 65535, droprate = 1000, amount = 24000}, -- Gil
        },
        {
            {itemid = 18053, droprate = 222}, -- Gravedigger
            {itemid = 18097, droprate = 302}, -- Gondo-Shizunori
            {itemid = 18217, droprate = 245}, -- Rampager
            {itemid = 17944, droprate = 231}, -- Retributor
        },
        {
            {itemid = 15295, droprate = 250}, -- Hierarch Belt
            {itemid = 15294, droprate = 338}, -- Warwolf Belt
            {itemid = 12407, droprate = 206}, -- Palmerin's Shield
            {itemid = 14871, droprate = 206}, -- Trainer's Gloves
        },
        {
            {itemid = 0, droprate = 342},     -- Nothing
            {itemid = 13693, droprate = 250}, -- Aries Mantle
            {itemid = 655, droprate = 230},   -- Adaman Ingot
            {itemid = 747, droprate = 178},   -- Orichalcum Ingot
        },
        {
            {itemid = 911, droprate = 292},   -- Rampaging Horn
            {itemid = 910, droprate = 265},   -- Lumbering Horn
            {itemid = 19024, droprate = 354}, -- Sword Strap
            {itemid = 19027, droprate = 89},  -- Claymore Grip
        },
        {
            {itemid = 737, droprate = 109},   -- Chunk Of Gold Ore
            {itemid = 4172, droprate = 34},   -- Reraiser
            {itemid = 644, droprate = 41},    -- Chunk Of Mythril Ore
            {itemid = 902, droprate = 61},    -- Demon Horn
            {itemid = 702, droprate = 121},   -- Ebony Log
            {itemid = 866, droprate = 44},    -- Handful Of Wyvern Scales
            {itemid = 4175, droprate = 27},   -- Vile Elixir +1
            {itemid = 700, droprate = 41},    -- Mahogany Log
            {itemid = 887, droprate = 80},    -- Coral Fragment
            {itemid = 703, droprate = 72},    -- Petrified Log
            {itemid = 844, droprate = 111},   -- Phoenix Feather
            {itemid = 738, droprate = 44},    -- Chunk Of Platinum Ore
            {itemid = 895, droprate = 14},    -- Ram Horn
            {itemid = 830, droprate = 14},    -- Square Of Rainbow Cloth
            {itemid = 645, droprate = 68},    -- Chunk Of Darksteel Ore
            {itemid = 4173, droprate = 14},   -- Hi-reraiser
            {itemid = 1132, droprate = 105},  -- Square Of Raxa
        },
        {
            {itemid = 0, droprate = 150},     -- Nothing
            {itemid = 836, droprate = 90},    -- Square Of Damascene Cloth
            {itemid = 658, droprate = 29},    -- Damascus Ingot
            {itemid = 942, droprate = 148},   -- Philosophers Stone
            {itemid = 844, droprate = 234},   -- Phoenix Feather
            {itemid = 837, droprate = 76},    -- Spool Of Malboro Fiber
            {itemid = 1132, droprate = 232},  -- Square Of Raxa
            {itemid = 1110, droprate = 41},   -- Vial Of Black Beetle Blood
        },
    },

    -- KSNM Contaminated Colosseum
    [17] =
    {
        {
            { itemid = xi.item.SPOOL_OF_MALBORO_FIBER, droprate = 1000 }, -- Spool Of Malboro Fiber
        },

        {
            { itemid = xi.item.MICHISHIBA_NO_TSUYU, droprate = 217 }, -- Michishiba-no-tsuyu
            { itemid = xi.item.MORGENSTERN,         droprate = 174 }, -- Morgenstern
            { itemid = xi.item.SENJUINRIKIO,        droprate = 333 }, -- Senjuinrikio
            { itemid = xi.item.THYRSUSSTAB,         droprate = 174 }, -- Thyrsusstab
        },

        {
            { itemid = xi.item.CASSIE_EARRING, droprate = 101 }, -- Cassie Earring
            { itemid = xi.item.CLAYMORE_GRIP,  droprate =  43 }, -- Claymore Grip
            { itemid = xi.item.MALBORO_VINE,   droprate = 275 }, -- Malboro Vine
            { itemid = xi.item.MORBOLGER_VINE, droprate = 275 }, -- Morbolger Vine
            { itemid = xi.item.POLE_GRIP,      droprate = 203 }, -- Pole Grip
            { itemid = xi.item.SPEAR_STRAP,    droprate = 116 }, -- Spear Strap
        },

        {
            { itemid = xi.item.ADAMAN_INGOT,     droprate = 159 }, -- Adaman Ingot
            { itemid = xi.item.ORICHALCUM_INGOT, droprate = 290 }, -- Orichalcum Ingot
            { itemid = xi.item.OSCAR_SCARF,      droprate = 406 }, -- Oscar Scarf
        },

        {
            { itemid = xi.item.EVOKERS_BOOTS,  droprate = 159 }, -- Evokers Boots
            { itemid = xi.item.OSTREGER_MITTS, droprate = 217 }, -- Ostreger Mitts
            { itemid = xi.item.PINEAL_HAT,     droprate = 145 }, -- Pineal Hat
            { itemid = xi.item.TRACKERS_KECKS, droprate = 159 }, -- Trackers Kecks
        },

        {
            { itemid = xi.item.CORAL_FRAGMENT,           droprate = 101 }, -- Coral Fragment
            { itemid = xi.item.CHUNK_OF_DARKSTEEL_ORE,   droprate =  29 }, -- Chunk Of Darksteel Ore
            { itemid = xi.item.DEMON_HORN,               droprate =  29 }, -- Demon Horn
            { itemid = xi.item.EBONY_LOG,                droprate =  29 }, -- Ebony Log
            { itemid = xi.item.CHUNK_OF_GOLD_ORE,        droprate = 101 }, -- Chunk Of Gold Ore
            { itemid = xi.item.SPOOL_OF_GOLD_THREAD,     droprate =  29 }, -- Spool Of Gold Thread
            { itemid = xi.item.SLAB_OF_GRANITE,          droprate =  29 }, -- Slab Of Granite
            { itemid = xi.item.MAHOGANY_LOG,             droprate =  43 }, -- Mahogany Log
            { itemid = xi.item.CHUNK_OF_MYTHRIL_ORE,     droprate =  29 }, -- Chunk Of Mythril Ore
            { itemid = xi.item.PETRIFIED_LOG,            droprate =  58 }, -- Petrified Log
            { itemid = xi.item.CHUNK_OF_PLATINUM_ORE,    droprate =  14 }, -- Chunk Of Platinum Ore
            { itemid = xi.item.SQUARE_OF_RAINBOW_CLOTH,  droprate =  58 }, -- Square Of Rainbow Cloth
            { itemid = xi.item.RAM_HORN,                 droprate =  14 }, -- Ram Horn
            { itemid = xi.item.VILE_ELIXIR,              droprate =  58 }, -- Vile Elixir
            { itemid = xi.item.VILE_ELIXIR_P1,           droprate =  29 }, -- Vile Elixir +1
            { itemid = xi.item.HANDFUL_OF_WYVERN_SCALES, droprate =  72 }, -- Handful Of Wyvern Scales
        },

        {
            { itemid = xi.item.VIAL_OF_BLACK_BEETLE_BLOOD, droprate =  87 }, -- Vial Of Black Beetle Blood
            { itemid = xi.item.DAMASCUS_INGOT,             droprate =  14 }, -- Damascus Ingot
            { itemid = xi.item.SQUARE_OF_DAMASCENE_CLOTH,  droprate =  29 }, -- Square Of Damascene Cloth
            { itemid = xi.item.SPOOL_OF_MALBORO_FIBER,     droprate =  43 }, -- Spool Of Malboro Fiber
            { itemid = xi.item.PHILOSOPHERS_STONE,         droprate = 174 }, -- Philosophers Stone
            { itemid = xi.item.PHOENIX_FEATHER,            droprate = 246 }, -- Phoenix Feather
            { itemid = xi.item.SQUARE_OF_RAXA,             droprate = 159 }, -- Square Of Raxa
        },
    },
}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local battlefield = player:getBattlefield()
    if battlefield then
        xi.battlefield.HandleLootRolls(battlefield, loot[battlefield:getID()], nil, npc)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
