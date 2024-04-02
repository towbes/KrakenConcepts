-- ---------------------------------
-- (Clamming) Cape Teriggan
-- ---------------------------------


local clamming = require('modules/custom/custom_clamming/custom_clamming')
-- ---------------------------------
local m = Module:new('clamming_valkurm_dunes')

local weight = clamming.weight
local rate   = clamming.rate

clamming.zone[xi.zone.VALKURM_DUNES] =
{
    -- Price of Clamming Kit
    price = 500,

    drops =
    {
        { rate.VERY_COMMON, weight.LIGHT,      xi.item.SEASHELL,                'a seashell'                }, -- 24% 6pz
        { rate.COMMON,      weight.MODERATE,   xi.item.PEBBLE,                  'a pebble'                  }, -- 15% 7pz
        { rate.COMMON,      weight.LIGHT,      xi.item.CLUMP_OF_PAMTAM_KELP,    'a clump of pamtam kelp'    }, -- 15% 6pz
        { rate.UNCOMMON,    weight.VERY_LIGHT, xi.item.PIECE_OF_RATTAN_LUMBER,  'a piece of rattan lumber'  }, -- 10% 3pz
        { rate.UNCOMMON,    weight.HEAVY,      xi.item.MANTA_SKIN,              'a manta skin'              }, -- 10% 11pz
        { rate.UNCOMMON,    weight.LIGHT,      xi.item.CRAB_SHELL,              'a crab shell'              }, -- 10% 6pz
        { rate.RARE,        weight.LIGHT,      xi.item.NEBIMONITE,              'a nebimonite'              }, --  5% 6pz
        { rate.RARE,        weight.LIGHT,      xi.item.ELM_LOG,                 'an elm log'                }, --  5% 6pz
        { rate.RARE,        weight.LIGHT,      xi.item.SHALL_SHELL,             'a shall shell'             }, --  5% 6pz
        { rate.VERY_RARE,   weight.VERY_HEAVY, xi.item.RUSTY_GREATSWORD,        'a rusty greatsword'        }, --  1% 20pz
        { rate.VERY_RARE,   weight.VERY_LIGHT, xi.item.BROKEN_LINKPEARL,        'a broken linkpearl'        }, --  1% 3pz
        { rate.VERY_RARE,   weight.MODERATE,   xi.item.CORAL_FRAGMENT,          'a coral fragment'          }, --  1% 7pz
        { rate.VERY_RARE,   weight.HEAVY,      xi.item.HIGH_QUALITY_CRAB_SHELL, 'a high-quality crab shell' }, --  1% 11pz
        { rate.SUPER_RARE,  weight.LIGHT,      xi.item.PIECE_OF_OXBLOOD,        'a piece of oxblood'        }, -- .5% 6pz
        { rate.SUPER_RARE,  weight.VERY_LIGHT, xi.item.PIECE_OF_ANGEL_SKIN,     'a piece of angel skin'     }, -- .5% 3pz
    },

    -- Clamming Points do not move and are usable every 15 seconds
    points =
    {
        {  333.317,  4.0000, -163.617, },
        {  295.450,  3.6232, -145.509, },
        {  253.017,  4.0000, -153.393, },
        { -124.221,  4.0000, -112.326, },
        { -165.226,  4.0000, -112.874, },
        { -220.362,  3.8563, -109.153, },
        { -745.479, -4.3833,  103.687, },
        { -747.098, -4.2666,  144.325, },
        { -748.623, -4.1656,  188.077, },
    },

    -- One NPC per zone to sell Clamming Kit and trade in for items
    npc =
    {
        name           = 'Mithran Clammer',
        x              =  129.331,
        y              =   -7.515,
        z              =   93.113,
        r              =      237,
        look           =      '0x0100040779107F20003000400050006000700000',
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
        -- var   = '[CUSTOMQUEST]SSG_CLAMMING',
        -- value = 2 -- QUEST_COMPLETED
    -- },

    dialog = 
    {
        BROKEN =
        {
            'You broke the bucket! It\'s over.',
            ' That clamming kit is going to need rrrepairs. I\'ll take it off your hands for now.',
        },
    
        READY =
        {
            'Would you like to trrry clamming?',
            ' It\'ll cost you %d gil.',
        },
    
        DECLINE       = { 'See you again~!' },
        UPDATE        = { 'Had enough clamming for one day?', },
        EXPLAIN_SHORT = { 'Try looking for seashells by the water.', },
        FULL          = { 'You can\'t carry anymore.', },
        INELIGIBLE    = { 'I have nothing to say to you.', },
    
        NOTHING = { 'There\'s nothing in your bucket yet.', },
        WEIGHT  =
        {
            'Hmm... This weighs around %d ponzes.',
            ' Be careful to not add too much, or you\'ll break the bucket!',
        },
    
        EXPLAIN_LONG =
        {
            'What\'s clamming? Nearby are prrrime locations for digging up shellfish and an assortment of other items.',
            'You\'ll need a clamming kit to dig. Collect your finds in the bucket which comes with the kit.',
            'The starrrter bucket stores up to 50 ponzes. Be careful to not overfill it.',
            'When you\'re done, bring everrrything back here and I\'ll wrap up your findings to take home.',
        },
    
        UPGRADE =
        {
            'Wow, you filled the entire bucket!',
            'Now you\'ve prrroven yourself, how about an upgrade? This new bucket can hold up to %d ponzes!',
        },
    
        UPGRADE_AFTER =
        {
            'Here\'s your upgraded bucket.',
            ' See what else you can find!',
        },
    
        FINISH =
        {
            'All rrrright, let\'s get these wrapped up.',
            '...',
            'Here you go! You\'re welcome back any time.',
        },
    },
}

m:addOverride('xi.zones.Valkurm_Dunes.Zone.onInitialize', function(zone)
    super(zone)
    clamming.initZone(zone)
end)

-- ---------------------------------
-- Remove/break Clamming Kit between zones
-- ---------------------------------

m:addOverride('xi.zones.Valkurm_Dunes.Zone.onZoneIn', function(player, zonePrev)
    super(player, zonePrev)
    clamming.onZoneIn(player)
end)

m:addOverride('xi.zones.Valkurm_Dunes.Zone.onZoneOut', function(player)
    super(player)
    clamming.onZoneOut(player)
end)

return m
