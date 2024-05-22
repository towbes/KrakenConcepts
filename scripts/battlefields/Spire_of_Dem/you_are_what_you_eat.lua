-----------------------------------
-- Copycat
-- Waughroon Shrine KSNM30, Clotho Orb
-----------------------------------
local spireOfDemID = zones[xi.zone.SPIRE_OF_DEM]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.SPIRE_OF_DEM,
    battlefieldId    = xi.battlefield.id.YOU_ARE_WHAT_YOU_EAT,
    maxPlayers       = 6,
    levelCap         = 30,
    timeLimit        = utils.minutes(30),
    index            = 1,
    entryNpc         = '_0j0',
    exitNpcs         = { '_0j1', '_0j2', '_0j3' },
    requiredKeyItems = { xi.ki.CENSER_OF_ANTIPATHY, message = spireOfDemID.text.A_CRACK_HAS_FORMED },
    grantXP          = 3500,
    armouryCrates    =
    {
        spireOfDemID.mob.INGESTER + 5,
        spireOfDemID.mob.INGESTER + 11,
        spireOfDemID.mob.INGESTER + 17,
    },
})

content:addEssentialMobs({ 'Neoingester', 'Neogorger', 'Neosatiator', 'Wanderer' })
content.groups[1].spawned = false

content:addEssentialMobs({ 'Ingester' })

content.loot =
{

    {
        { item = xi.item.NONE,               weight = 200 },
        { item = xi.item.BURNING_CLUSTER,    weight = 100 },
        { item = xi.item.BITTER_CLUSTER,     weight = 100 },
        { item = xi.item.FLEETING_CLUSTER,   weight = 100 },
        { item = xi.item.PROFANE_CLUSTER,    weight = 100 },
        { item = xi.item.STARTLING_CLUSTER,  weight = 100 },
        { item = xi.item.SOMBER_CLUSTER,     weight = 100 },
        { item = xi.item.RADIANT_CLUSTER,    weight = 100 },
        { item = xi.item.MALEVOLENT_CLUSTER, weight = 100 },
    },

    {
        { item = xi.item.NONE,               weight = 200 },
        { item = xi.item.BURNING_CLUSTER,    weight = 100 },
        { item = xi.item.BITTER_CLUSTER,     weight = 100 },
        { item = xi.item.FLEETING_CLUSTER,   weight = 100 },
        { item = xi.item.PROFANE_CLUSTER,    weight = 100 },
        { item = xi.item.STARTLING_CLUSTER,  weight = 100 },
        { item = xi.item.SOMBER_CLUSTER,     weight = 100 },
        { item = xi.item.RADIANT_CLUSTER,    weight = 100 },
        { item = xi.item.MALEVOLENT_CLUSTER, weight = 100 },
    },

    {
        { item = xi.item.NONE,               weight = 200 },
        { item = xi.item.BURNING_CLUSTER,    weight = 100 },
        { item = xi.item.BITTER_CLUSTER,     weight = 100 },
        { item = xi.item.FLEETING_CLUSTER,   weight = 100 },
        { item = xi.item.PROFANE_CLUSTER,    weight = 100 },
        { item = xi.item.STARTLING_CLUSTER,  weight = 100 },
        { item = xi.item.SOMBER_CLUSTER,     weight = 100 },
        { item = xi.item.RADIANT_CLUSTER,    weight = 100 },
        { item = xi.item.MALEVOLENT_CLUSTER, weight = 100 },
    },

    {
        { item = xi.item.NONE,             weight = 500 },
        { item = xi.item.VIOLENT_VISION,   weight = 100 },
        { item = xi.item.PAINFUL_VISION,   weight = 100 },
        { item = xi.item.TIMOROUS_VISION,  weight = 100 },
        { item = xi.item.BRILLIANT_VISION, weight = 100 },
        { item = xi.item.VENERABLE_VISION, weight = 100 },
    },
}

return content:register()
