-----------------------------------
-- Bionic Bug
-- Mineshaft 2716 ENM, Sylvan Stone
-----------------------------------
local mineshaftID = zones[xi.zone.MINE_SHAFT_2716]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.MINE_SHAFT_2716,
    battlefieldId    = xi.battlefield.id.BIONIC_BUG,
    maxPlayers       = 6,
    levelCap         = 75,
    timeLimit        = utils.minutes(30),
    index            = 2,
    entryNpc         = '_0d0',
    exitNpc          = { '_0d1', '_0d2', '_0d3' },
    requiredKeyItems = { xi.ki.SHAFT_2716_OPERATING_LEVER, message = mineshaftID.text.THE_PARTY_WILL_BE_REMOVED + 8 },
    grantXP          = 3500,
})

content:addEssentialMobs({ 'Bugboy' })

content.loot =
{
    {
        { item = xi.item.NONE,         weight = 900 },
        { item = xi.item.CLOUD_EVOKER, weight = 100 },
    },

    {
        { item = xi.item.SQUARE_OF_ELTORO_LEATHER, weight = 333 },
        { item = xi.item.PIECE_OF_CASSIA_LUMBER,   weight = 333 },
        { item = xi.item.DRAGON_BONE,              weight = 334 },
    },

    {
        { item = xi.item.NONE,                weight = 625 },
        { item = xi.item.MARTIAL_KNIFE,       weight = 75  },
        { item = xi.item.MARTIAL_SCYTHE,      weight = 75  },
        { item = xi.item.SCROLL_OF_RAISE_III, weight = 50  },
        { item = xi.item.FAERIE_HAIRPIN,      weight = 100 },
        { item = xi.item.COMMANDERS_CAPE,     weight = 75  },
    },

    {
        { item = xi.item.NONE,                weight = 625 },
        { item = xi.item.MARTIAL_KNIFE,       weight = 75  },
        { item = xi.item.MARTIAL_SCYTHE,      weight = 75  },
        { item = xi.item.SCROLL_OF_RAISE_III, weight = 50  },
        { item = xi.item.FAERIE_HAIRPIN,      weight = 100 },
        { item = xi.item.COMMANDERS_CAPE,     weight = 75  },
    },
}

return content:register()
