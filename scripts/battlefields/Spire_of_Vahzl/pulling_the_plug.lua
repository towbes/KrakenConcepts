-----------------------------------
-- ENM: Pulling The Plug
-- Spire of Vahzl
-----------------------------------
local spireOfVahzlID = zones[xi.zone.SPIRE_OF_VAHZL]
-----------------------------------

local content = Battlefield:new({
    zoneId                = xi.zone.SPIRE_OF_VAHZL,
    battlefieldId         = xi.battlefield.id.PULLING_THE_PLUG,
    maxPlayers            = 18,
    levelCap              = 50,
    timeLimit             = utils.minutes(30),
    index                 = 1,
    entryNpc              = '_0n0',
    exitNpcs              = { '_0n1', '_0n2', '_0n3' },
    requiredKeyItems      = { xi.ki.CENSER_OF_ACRIMONY, message = spireOfVahzlID.text.THE_PARTY_WILL_BE_REMOVED + 8 },
    grantXP               = 3000,
    armouryCrates    =
    {
        spireOfVahzlID.mob.MEMORY_RECEPTACLE_RED_OFFSET + 9,
        spireOfVahzlID.mob.MEMORY_RECEPTACLE_RED_OFFSET + 19,
        spireOfVahzlID.mob.MEMORY_RECEPTACLE_RED_OFFSET + 29,
    },
})

function content:entryRequirement(player, npc, isRegistrant, trade)
    local currentRequirements = player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.DESIRES_OF_EMPTINESS)
    return currentRequirements
end

function content:checkSkipCutscene(player)
    return player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.DESIRES_OF_EMPTINESS)
end

function content:onBattlefieldEnter(player, battlefield)
    player:setCharVar('[ENM]VenessaComplete', 1)
end

content:addEssentialMobs({ 'Memory_Receptacle_green', 'Memory_Receptacle_teal', 'Memory_Receptacle_blue', 'Contemplator', 'Ingurgitator', 'Repiner', 'Neoingurgitator' })
content.groups[1].spawned = false

content:addEssentialMobs({ 'Memory_Receptacle_red' })

content.loot =
{
    {
        { item = xi.item.NONE,               weight = 200 },
        { item = xi.item.BITTER_CLUSTER,     weight = 100 },
        { item = xi.item.BURNING_CLUSTER,    weight = 100 },
        { item = xi.item.FLEETING_CLUSTER,   weight = 100 },
        { item = xi.item.MALEVOLENT_CLUSTER, weight = 100 },
        { item = xi.item.PROFANE_CLUSTER,    weight = 100 },
        { item = xi.item.RADIANT_CLUSTER,    weight = 100 },
        { item = xi.item.SOMBER_CLUSTER,     weight = 100 },
        { item = xi.item.STARTLING_CLUSTER,  weight = 100 },
    },

    {
        { item = xi.item.BEATIFIC_IMAGE, weight = 333 },
        { item = xi.item.GRAVE_IMAGE,    weight = 333 },
        { item = xi.item.VALOROUS_IMAGE, weight = 333 },
    },

    {
        { item = xi.item.ANCIENT_IMAGE, weight = 333 },
        { item = xi.item.VIRGIN_IMAGE,  weight = 333 },
    },

    {
        { item = xi.item.NONE,             weight = 736 },
        { item = xi.item.IMPETUOUS_VISION, weight = 167 },
        { item = xi.item.SNIDE_VISION,     weight = 66  },
        { item = xi.item.TENUOUS_VISION,   weight = 31  },
    },  
}

return content:register()
