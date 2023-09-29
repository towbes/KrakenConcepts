-- ---------------------------------
-- (Clamming) Cape Teriggan
-- ---------------------------------
require("scripts/globals/zone")
require("scripts/globals/items")
local clamming = require("modules/custom/custom_clamming/custom_clamming")
-- ---------------------------------
local m = Module:new("clamming_buburimu_beninsula")

local weight = clamming.weight
local rate   = clamming.rate

clamming.zone[xi.zone.BUBURIMU_PENINSULA] =
{
    -- Price of Clamming Kit
    price = 2000,

    drops =
    {
        { rate.VERY_COMMON, weight.LIGHT,      xi.items.SEASHELL,                "a seashell"                }, -- 24% 6pz
        { rate.COMMON,      weight.MODERATE,   xi.items.PEBBLE,                  "a pebble"                  }, -- 15% 7pz
        { rate.COMMON,      weight.LIGHT,      xi.items.CLUMP_OF_PAMTAM_KELP,    "a clump of pamtam kelp"    }, -- 15% 6pz
        { rate.UNCOMMON,    weight.VERY_LIGHT, xi.items.PIECE_OF_RATTAN_LUMBER,  "a piece of rattan lumber"  }, -- 10% 3pz
        { rate.UNCOMMON,    weight.HEAVY,      xi.items.MANTA_SKIN,              "a manta skin"              }, -- 10% 11pz
        { rate.UNCOMMON,    weight.LIGHT,      xi.items.CRAB_SHELL,              "a crab shell"              }, -- 10% 6pz
        { rate.RARE,        weight.LIGHT,      xi.items.NEBIMONITE,              "a nebimonite"              }, --  5% 6pz
        { rate.RARE,        weight.LIGHT,      xi.items.ELM_LOG,                 "an elm log"                }, --  5% 6pz
        { rate.RARE,        weight.LIGHT,      xi.items.SHALL_SHELL,             "a shall shell"             }, --  5% 6pz
        { rate.VERY_RARE,   weight.VERY_HEAVY, xi.items.RUSTY_GREATSWORD,        "a rusty greatsword"        }, --  1% 20pz
        { rate.VERY_RARE,   weight.VERY_LIGHT, xi.items.BROKEN_LINKPEARL,        "a broken linkpearl"        }, --  1% 3pz
        { rate.VERY_RARE,   weight.MODERATE,   xi.items.CORAL_FRAGMENT,          "a coral fragment"          }, --  1% 7pz
        { rate.VERY_RARE,   weight.HEAVY,      xi.items.HIGH_QUALITY_CRAB_SHELL, "a high-quality crab shell" }, --  1% 11pz
        { rate.SUPER_RARE,  weight.LIGHT,      xi.items.PIECE_OF_OXBLOOD,        "a piece of oxblood"        }, -- .5% 6pz
        { rate.SUPER_RARE,  weight.VERY_LIGHT, xi.items.PIECE_OF_ANGEL_SKIN,     "a piece of angel skin"     }, -- .5% 3pz
    },

    -- Clamming Points do not move and are usable every 15 seconds
    points =
    {
        { -229.644,  19.895, -309.805, },
        { -209.942,  20.000, -313.188, },
        { -107.017,  19.797, -307.955, },
        {  -69.305,  20.000, -313.151, },
        {  427.690,  19.778,  146.676, },
        {  432.550,  20.000,  108.837, },
        {  451.113,  20.000,  111.090, },
    },

    -- One NPC per zone to sell Clamming Kit and trade in for items
    npc =
    {
        name           = "Mithran Clammer",
        x              =  153.326,
        y              =   0.7977,
        z              =  -180.644,
        r              =        23,
        look           =      "0x0100040779107F20003000400050006000700000",
        -- spawnAnimation =        0,
        -- flags          =        6,
    },

    -- ---------------------------------
    -- Optional settings
    -- ---------------------------------

    -- Custom dialog for this NPC (See custom_clamming.lua)
    -- dialog = {},

    -- Require var value to access clamming
    -- requirement = {
        -- var   = "[CUSTOMQUEST]SSG_CLAMMING",
        -- value = 2 -- QUEST_COMPLETED
    -- },

    dialog = 
    {
        BROKEN =
        {
            "You broke the bucket! It's over.",
            " That clamming kit is going to need rrrepairs. I'll take it off your hands for now.",
        },
    
        READY =
        {
            "Would you like to trrry clamming?",
            " It'll cost you %d gil.",
        },
    
        DECLINE       = { "See you again~!" },
        UPDATE        = { "Had enough clamming for one day?", },
        EXPLAIN_SHORT = { "Try looking for seashells by the water.", },
        FULL          = { "You can't carry anymore.", },
        INELIGIBLE    = { "I have nothing to say to you.", },
    
        NOTHING = { "There's nothing in your bucket yet.", },
        WEIGHT  =
        {
            "Hmm... This weighs around %d ponzes.",
            " Be careful to not add too much, or you'll break the bucket!",
        },
    
        EXPLAIN_LONG =
        {
            "What's clamming? Nearby are prrrime locations for digging up shellfish and an assortment of other items.",
            "You'll need a clamming kit to dig. Collect your finds in the bucket which comes with the kit.",
            "The starrrter bucket stores up to 50 ponzes. Be careful to not overfill it.",
            "When you're done, bring everrrything back here and I'll wrap up your findings to take home.",
        },
    
        UPGRADE =
        {
            "Wow, you filled the entire bucket!",
            "Now you've prrroven yourself, how about an upgrade? This new bucket can hold up to %d ponzes!",
        },
    
        UPGRADE_AFTER =
        {
            "Here's your upgraded bucket.",
            " See what else you can find!",
        },
    
        FINISH =
        {
            "All rrrright, let's get these wrapped up.",
            "...",
            "Here you go! You're welcome back any time.",
        },
    },
}

m:addOverride("xi.zones.Buburimu_Peninsula.Zone.onInitialize", function(zone)
    super(zone)
    clamming.initZone(zone)
end)

-- ---------------------------------
-- Remove/break Clamming Kit between zones
-- ---------------------------------

m:addOverride("xi.zones.Buburimu_Peninsula.Zone.onZoneIn", function(player, zonePrev)
    super(player, zonePrev)
    clamming.onZoneIn(player)
end)

m:addOverride("xi.zones.Buburimu_Peninsula.Zone.onZoneOut", function(player)
    super(player)
    clamming.onZoneOut(player)
end)

return m
