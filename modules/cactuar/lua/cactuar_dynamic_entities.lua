-----------------------------------
-- Add some test NPCs to GM_HOME (zone 210)
-----------------------------------
require("modules/module_utils")
require("scripts/zones/Eastern_Adoulin/Zone")
require("scripts/zones/West_Ronfaure/Zone")
require("scripts/globals/zone")
require('scripts/globals/msg') 

-----------------------------------
local m = Module:new("cactuar_dynamic_entities")

m:addOverride("xi.zones.Eastern_Adoulin.Zone.onInitialize", function(zone)

    -- Call the zone's original function for onInitialize
    super(zone)

    -- Insert NPC into zone
    local horro = zone:insertDynamicEntity({

        -- NPC or MOB
        objtype = xi.objType.NPC,

        -- The name visible to players
        -- NOTE: Even if you plan on making the name invisible, we're using it internally for lookups
        --     : So populate it with something unique-ish even if you aren't going to use it.
        --     : You can then hide the name with entity:hideName(true)
        -- NOTE: This name CAN include spaces and underscores.
        name = "Horro",

        -- You can use regular model ids (See documentation/model_ids.txt, or play around with !costume)
        look = 2430,

        -- You can also use the raw packet look information (as a string), as seen in npc_list and mob_pools
        -- look = "0x0100020500101120003000400050006000700000",

        -- Set the position using in-game x, y and z
        x = -131.000,
        y = 0.000,
        z = -11.000,

        -- Rotation is scaled 0-255, with 0 being East
        rotation = 192,

        -- Overriding widescan is only available to NPCs.
        widescan = 1,

        -- onTrade and onTrigger can be hooked up to your dynamic entity,
        -- just like with regular entities. You can also omit these.
        onTrade = function(player, npc, trade)
            -- NOTE: We have to use getPacketName, because the regular name is modified and being used
            --     : for internal lookups
            -- player:PrintToPlayer("No, thanks!", 0, npc:getPacketName())
        end,

        -- The entity will not be "triggerable" unless you populate onTrigger
        onTrigger = function(player, npc)
            -- NOTE: We have to use getPacketName, because the regular name is modified and being used
            --     : for internal lookups
            -- player:PrintToPlayer("Welcome to GM Home!", 0, npc:getPacketName())
            -- Forward declarations (required)
local menu  = {}
local page1 = {}
local page2 = {}
local page3 = {}
local page4 = {}

-- We need just a tiny delay to let the previous menu context be cleared out
-- "New pages" are actually just whole new menus!
local delaySendMenu = function(player)
    player:timer(50, function(playerArg)
        playerArg:customMenu(menu)
    end)
end
            menu =
{
    title = "Mog Wardrobe Expansion",
    options = {},
}

page1 =
{
    {
        "Buy Mog Wardrobe Slots",
        function(playerArg)
            playerArg:PrintToPlayer("Horro: How many would you like to buy?", xi.msg.channel.NS_SAY)
            playerArg:independentAnimation(playerArg, 251, 4) -- Hearts
            menu.options = page2
            delaySendMenu(playerArg)
        end,
    },
}

page2 =
{
    {
        "10 Wardrobe Slots",
        function(playerArg)
            playerArg:PrintToPlayer("Horro: 10 Wardrobe Slots will cost you 10,000 Gil.", xi.msg.channel.NS_SAY)
            menu.options = page3
            delaySendMenu(playerArg)
        end,
    },
    {
        "80 Wardrobe Slots (Max)",
        function(playerArg)
            playerArg:PrintToPlayer("Horro: 10 Wardrobe Slots will cost you 80,000 Gil.", xi.msg.channel.NS_SAY)
            menu.options = page4
            delaySendMenu(playerArg)
        end,
    },
    {
        "Previous Page",
        function(playerArg)
            menu.options = page2
            delaySendMenu(playerArg)
        end,
    },
}
page3 =
{
    {
        "Confirm: 10,000 Gil for 10 Wardrobe Slots",
        function(playerArg)
            playerArg:PrintToPlayer("Horro: Thank you for doing buisness!", xi.msg.channel.NS_SAY)
            playerArg:PrintToPlayer("You have purchased 10 Wardrobe Slots for 10,000 Gil", xi.msg.channel.SYSTEM_3)
            playerArg:independentAnimation(playerArg, 252, 4) -- Music Notes
            --npc:independentAnimation(npc, 122, 9)
        end,
    },
    {
        "Previous Page",
        function(playerArg)
            menu.options = page3
            delaySendMenu(playerArg)
        end,
    },
}
page4 =
{
    {
        "Confirm: 80,000 Gil for 80 Wardrobe Slots",
        function(playerArg)
            playerArg:PrintToPlayer("You have purchased 80 Wardrobe Slots for 80,000 Gil", xi.msg.channel.NS_SAY)
            playerArg:independentAnimation(playerArg, 252, 4) -- Music Notes
        end,
    },
    {
        "Previous Page",
        function(playerArg)
            menu.options = page3
            delaySendMenu(playerArg)
        end,
    },
}
npc:facePlayer(player)
menu.options = page1
delaySendMenu(player)
        end,
    })

    -- Use the mob object however you like
    -- horro:getID() etc.
    -- We're not doing anything with it, so ignore this object
    utils.unused(horro)

    -- You could also just not capture the object
    -- zone:insertDynamicEntity({ ...
end)

m:addOverride("xi.zones.West_Ronfaure.Zone.onInitialize", function(zone)

    -- Call the zone's original function for onInitialize
    super(zone)

-- local zone = player:getZone()

local mob = zone:insertDynamicEntity({
    -- NPC or MOB
    objtype = xi.objType.MOB,

    -- The name visible to players
    -- NOTE: Even if you plan on making the name invisible, we're using it internally for lookups
    --     : So populate it with something unique-ish even if you aren't going to use it.
    --     : You can then hide the name with entity:hideName(true)
    -- NOTE: This name CAN include spaces and underscores.
    name = "Wild Boar",

    -- Set the position using in-game x, y and z
    -- x = player:getXPos(),
    -- y = player:getYPos(),
    -- z = player:getZPos(),
    -- rotation = player:getRotPos(),

    -- Fafnir's entry in mob_groups:
    -- INSERT INTO `mob_groups` VALUES (5, 1280, 154, 'Fafnir', 0, 128, 805, 70000, 0, 90, 90, 0)
    --                       groupId ---^        ^--- groupZoneId
    groupId = 100,
    groupZoneId = 100,

    -- You can provide an onMobDeath function if you want: if you don't
    -- add one, an empty one will be inserted for you behind the scenes.
    onMobDeath = function(mob, playerArg, optParams)
    end,

    onMobDespawn = function(mob, playerArg, optParams)
        mob:timer(8000, function(mobArg)
            mobArg:spawn()
        end)
    end,

    -- If set to true, the internal id assigned to this mob will be released for other dynamic entities to use
    -- after this mob has died. Defaults to false.
    releaseIdOnDisappear = false,

    -- You can apply mixins like you would with regular mobs. mixinOptions aren't supported yet.
    mixins =
    {
        require("scripts/mixins/rage"),
        require("scripts/mixins/job_special"),
    },

    -- The "whooshy" special animation that plays when Trusts or Dynamis mobs spawn
    specialSpawnAnimation = true,
})

-- Use the mob object as you normally would
mob:setSpawn(-317, -52, 308, 127)

mob:setDropID(0) -- No loot!

mob:setMobMod(xi.mobMod.NO_DROPS, 1)

mob:spawn()

end)

return m
