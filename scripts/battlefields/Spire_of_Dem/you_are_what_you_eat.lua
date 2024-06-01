-----------------------------------
-- ENM: You Are What You Eat
-- Spire of Dem
-----------------------------------
require('scripts/missions/cop/helpers')
local spireOfDemID = zones[xi.zone.SPIRE_OF_DEM]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.SPIRE_OF_DEM,
    battlefieldId    = xi.battlefield.id.YOU_ARE_WHAT_YOU_EAT,
    maxPlayers       = 18,
    levelCap         = 30,
    timeLimit        = utils.minutes(30),
    index            = 1,
    entryNpc         = '_0j0',
    exitNpcs         = { '_0j1', '_0j2', '_0j3' },
    requiredKeyItems = { xi.ki.CENSER_OF_ANTIPATHY, message = spireOfDemID.text.THE_PARTY_WILL_BE_REMOVED + 8 },
    grantXP          = 1500,
    armouryCrates    =
    {
        spireOfDemID.mob.PROGENERATOR + 20,
        spireOfDemID.mob.PROGENERATOR + 26,
        spireOfDemID.mob.PROGENERATOR + 32,
    },
})

function content:entryRequirement(player, npc, isRegistrant, trade)
    local currentRequirements = player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_MOTHERCRYSTALS)
    return currentRequirements
end

function content:checkSkipCutscene(player)
    return player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_MOTHERCRYSTALS)
end

content:addEssentialMobs({ 'Ingester'})

content.groups =
{
    {
        mobs = { 'Ingester' },
        superlink = true,
        spawned = true,
        death = utils.bind(content.handleAllMonstersDefeated, content),
    },
    {
        mobs = { 'Neosatiator' },
        superlink = true,
        spawned = false,
    },
    {
        mobs = { 'Neogorger' },
        superlink = true,
        spawned = false,
    },
    {
        mobs = { 'Neoingester' },
        superlink = true,
        spawned = false,
    },
    {
        mobs = { 'Wanderer' },
        superlink = true,
        spawned = false,
    },
}

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
