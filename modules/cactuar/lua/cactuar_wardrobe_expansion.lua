-----------------------------------
-- Add some test NPCs to GM_HOME (zone 210)
-----------------------------------
require("modules/module_utils")
require("scripts/zones/Eastern_Adoulin/Zone")
require("scripts/zones/West_Ronfaure/Zone")
require("scripts/globals/zone")
require('scripts/globals/msg') 

-----------------------------------
local m = Module:new("cactuar_wardrobe_expansion")

m:addOverride("xi.zones.Southern_San_dOria.Zone.onInitialize", function(zone)

    super(zone)
    
        local mooglin = zone:insertDynamicEntity({
        
        objtype = xi.objType.NPC,
    
        name = "Mooglin",

        look = 2364,

        x = 166.246,
        y = -2.000,
        z = 157.040,

        rotation = 122,

        widescan = 1,

        onTrade = function(player, npc, trade)

        end,


        onTrigger = function(player, npc)

local menu  = {}
local page1 = {}
local page2 = {}
local page3 = {}
local page4 = {}
local page5 = {}
local page6 = {}
local page7 = {}
local page8 = {}
local page9 = {}

container = {
wardrobe5 = {size=player:getContainerSize(xi.inv.WARDROBE5), price=5000},
wardrobe6 = {size=player:getContainerSize(xi.inv.WARDROBE6), price=10000},
wardrobe7 = {size=player:getContainerSize(xi.inv.WARDROBE7), price=20000},
wardrobe8 = {size=player:getContainerSize(xi.inv.WARDROBE8), price=50000},
}

StringifyPrice = function(n)
    return tostring(math.floor(n)):reverse():gsub("(%d%d%d)","%1,")
    :gsub(",(%-?)$","%1"):reverse()
end


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
        "Expand Mog Wardrobe 5",
        function(playerArg)
            local remaining = 80 - container.wardrobe5.size
            if remaining < 5 then
                playerArg:PrintToPlayer("Mog Wardrobe 5 is already fully expanded.", xi.msg.channel.SYSTEM_3)
                menu.options = page1
                delaySendMenu(playerArg) 
            else
                menu.options = page2
                delaySendMenu(playerArg)
            end
        end,
    },

    {
        "Expand Mog Wardrobe 6",
        function(playerArg)
            local remaining = 80 - container.wardrobe6.size
            if remaining < 5 then
                playerArg:PrintToPlayer("Mog Wardrobe 6 is already fully expanded.", xi.msg.channel.SYSTEM_3) 
                menu.options = page1
                delaySendMenu(playerArg)
            else
                menu.options = page3
                delaySendMenu(playerArg)
            end
        end,
    },

    {
        "Expand Mog Wardrobe 7",
        function(playerArg)
            local remaining = 80 - container.wardrobe7.size
            if remaining < 5 then
                playerArg:PrintToPlayer("Mog Wardrobe 7 is already fully expanded", xi.msg.channel.SYSTEM_3)
                menu.options = page1
                delaySendMenu(playerArg) 
            else
                menu.options = page4
                delaySendMenu(playerArg)
            end
        end,
    },

    {
        "Expand Mog Wardrobe 8",
        function(playerArg)
            local remaining = 80 - container.wardrobe8.size
            if remaining < 5 then
                playerArg:PrintToPlayer("Mog Wardrobe 8 is already fully expanded", xi.msg.channel.SYSTEM_3)
                menu.options = page1
                delaySendMenu(playerArg) 
            else
                menu.options = page5
                delaySendMenu(playerArg)
            end
        end,
    },

    {
        "Previous Page",
        function(playerArg)
            menu.options = page1
            delaySendMenu(playerArg)
        end,
    },
}

 -- Wardrobe 5 --
page2 =
{
    {
        "5 Wardrobe Slots",
        function(playerArg)
            quantity = 5
            price = quantity * container.wardrobe5.price

            playerArg:PrintToPlayer("Mooglin : Expand your Mog House 5 by " .. quantity .. " slots for " .. StringifyPrice(price) .. " gil?" , xi.msg.channel.NS_SAY)
            menu.options = page6
            delaySendMenu(playerArg)
        end,
    },

    {
        "Max Wardrobe Slots",
        function(playerArg)
            quantity = 80 - container.wardrobe5.size
            price = quantity * container.wardrobe5.price

            playerArg:PrintToPlayer("Mooglin : Expand your Mog House 5 by " .. quantity .. " slots for " .. StringifyPrice(price) .. " gil?" , xi.msg.channel.NS_SAY)
            menu.options = page6
            delaySendMenu(playerArg)
        end,
    },

    {
        "Previous Page",
        function(playerArg)
            menu.options = page1
            delaySendMenu(playerArg)
        end,
    },
}

-- Wardrobe 6 --
page3 = 
{
    {
        "5 Wardrobe Slots",
        function(playerArg)
            quantity = 5
            price = quantity * container.wardrobe6.price

            playerArg:PrintToPlayer("Mooglin : Expand your Mog House 6 by " .. quantity .. " slots for " .. StringifyPrice(price) .. " gil?" , xi.msg.channel.NS_SAY)
            menu.options = page7
            delaySendMenu(playerArg)
        end,
    },

    {
        "Max Wardrobe Slots",
        function(playerArg)
            quantity = 80 - container.wardrobe6.size
            price = quantity * container.wardrobe6.price

            playerArg:PrintToPlayer("Mooglin : Expand your Mog House 6 by " .. quantity .. " slots for " .. StringifyPrice(price) .. " gil?" , xi.msg.channel.NS_SAY)
            menu.options = page7
            delaySendMenu(playerArg)
        end,
    },

    {
        "Previous Page",
        function(playerArg)
            menu.options = page1
            delaySendMenu(playerArg)
        end,
    },
}

 -- Wardrobe 7 -- 
page4 =
{
    {
        "5 Wardrobe Slots",
        function(playerArg)
            quantity = 5
            price = quantity * container.wardrobe7.price

            playerArg:PrintToPlayer("Mooglin : Expand your Mog House 7 by " .. quantity .. " slots for " .. StringifyPrice(price) .. " gil?" , xi.msg.channel.NS_SAY)
            menu.options = page8
            delaySendMenu(playerArg)
        end,
    },

    {
        "Max Wardrobe Slots",
        function(playerArg)
            quantity = 80 - container.wardrobe7.size
            price = quantity * container.wardrobe7.price

            playerArg:PrintToPlayer("Mooglin : Expand your Mog House 7 by " .. quantity .. " slots for " .. StringifyPrice(price) .. " gil?" , xi.msg.channel.NS_SAY)
            menu.options = page8
            delaySendMenu(playerArg)
        end,
    },

    {
        "Previous Page",
        function(playerArg)
            menu.options = page1
            delaySendMenu(playerArg)
        end,
    },
}

-- Wardrobe 8 --
page5 = 
{
    {
        "5 Wardrobe Slots",
        function(playerArg)
            quantity = 5
            price = quantity * container.wardrobe8.price

            playerArg:PrintToPlayer("Mooglin : Expand your Mog House 8 by " .. quantity .. " slots for " .. StringifyPrice(price) .. " gil?" , xi.msg.channel.NS_SAY)
            menu.options = page9
            delaySendMenu(playerArg)
        end,
    },

    {
        "Max Wardrobe Slots",
        function(playerArg)
            quantity = 80 - container.wardrobe8.size
            price = quantity * container.wardrobe8.price

            playerArg:PrintToPlayer("Mooglin : Expand your Mog House 8 by " .. quantity .. " slots for " .. StringifyPrice(price) .. " gil?" , xi.msg.channel.NS_SAY)
            menu.options = page9
            delaySendMenu(playerArg)
        end,
    },

    {
        "Previous Page",
        function(playerArg)
            menu.options = page1
            delaySendMenu(playerArg)
        end,
    },
}

--TO DO: Combine all confirmations into one page. --
--Wadrobe 5 Confirmation -- 
page6 = 
{
    {
        "Purchase",
        function(playerArg)
            if playerArg:getGil() >= price then
                player:delGil(price)
                playerArg:changeContainerSize(xi.inv.WARDROBE5, quantity)
                playerArg:PrintToPlayer("Mog Wardrobe 5 increased by " .. quantity .. " slots.", xi.msg.channel.SYSTEM_3)
            else
                playerArg:PrintToPlayer("You do not have enough gil. ", xi.msg.channel.SYSTEM_3)
            end
        end,
    },

    {
        "Cancel",
        function(playerArg)
        end,
    },
}

-- Wardrobe 6 Confirmation --
page7 = 
{
    {
        "Purchase",
        function(playerArg)
            if playerArg:getGil() >= price then
                player:delGil(price)
                playerArg:changeContainerSize(xi.inv.WARDROBE6, quantity)
                playerArg:PrintToPlayer("Mog Wardrobe 6 increased by " .. quantity .. " slots.", xi.msg.channel.SYSTEM_3)
            else
                playerArg:PrintToPlayer("You do not have enough gil. ", xi.msg.channel.SYSTEM_3)
            end
        end,
    },

    {
        "Cancel",
        function(playerArg)
        end,
    },
}

-- Wardrobe 7 Confirmation --
page8 = 
{
    {
        "Purchase",
        function(playerArg)
            if playerArg:getGil() >= price then
                player:delGil(price)
                playerArg:changeContainerSize(xi.inv.WARDROBE7, quantity)
                playerArg:PrintToPlayer("Mog Wardrobe 7 increased by " .. quantity .. " slots.", xi.msg.channel.SYSTEM_3)
            else
                playerArg:PrintToPlayer("You do not have enough gil. ", xi.msg.channel.SYSTEM_3)
            end
        end,
    },

    {
        "Cancel",
        function(playerArg)
        end,
    },
}

-- Wardrobe 8 Confirmation --
page9 = 
{
    {
        "Purchase",
        function(playerArg)
            if playerArg:getGil() >= price then
                player:delGil(price)
                playerArg:changeContainerSize(xi.inv.WARDROBE8, quantity)
                playerArg:PrintToPlayer("Mog Wardrobe 8 increased by " .. quantity .. " slots.", xi.msg.channel.SYSTEM_3)
            else
                playerArg:PrintToPlayer("You do not have enough gil. ", xi.msg.channel.SYSTEM_3)
            end
        end,
    },

    {
        "Cancel",
        function(playerArg)
        end,
    },
}



menu.options = page1
delaySendMenu(player)
        end,
    })

end)

m:addOverride("xi.zones.Bastok_Markets.Zone.onInitialize", function(zone)

    super(zone)
    
        local mooglin = zone:insertDynamicEntity({
        
        objtype = xi.objType.NPC,
    
        name = "Mooglin",

        look = 2364,

        x = -152.726,
        y = -4.000,
        z = -35.392,

        rotation = 161,

        widescan = 1,

        onTrade = function(player, npc, trade)

        end,


        onTrigger = function(player, npc)

local menu  = {}
local page1 = {}
local page2 = {}
local page3 = {}
local page4 = {}
local page5 = {}
local page6 = {}
local page7 = {}
local page8 = {}
local page9 = {}

container = {
wardrobe5 = {size=player:getContainerSize(xi.inv.WARDROBE5), price=5000},
wardrobe6 = {size=player:getContainerSize(xi.inv.WARDROBE6), price=10000},
wardrobe7 = {size=player:getContainerSize(xi.inv.WARDROBE7), price=20000},
wardrobe8 = {size=player:getContainerSize(xi.inv.WARDROBE8), price=50000},
}

StringifyPrice = function(n)
    return tostring(math.floor(n)):reverse():gsub("(%d%d%d)","%1,")
    :gsub(",(%-?)$","%1"):reverse()
end


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
        "Expand Mog Wardrobe 5",
        function(playerArg)
            local remaining = 80 - container.wardrobe5.size
            if remaining < 5 then
                playerArg:PrintToPlayer("Mog Wardrobe 5 is already fully expanded.", xi.msg.channel.SYSTEM_3)
                menu.options = page1
                delaySendMenu(playerArg) 
            else
                menu.options = page2
                delaySendMenu(playerArg)
            end
        end,
    },

    {
        "Expand Mog Wardrobe 6",
        function(playerArg)
            local remaining = 80 - container.wardrobe6.size
            if remaining < 5 then
                playerArg:PrintToPlayer("Mog Wardrobe 6 is already fully expanded.", xi.msg.channel.SYSTEM_3) 
                menu.options = page1
                delaySendMenu(playerArg)
            else
                menu.options = page3
                delaySendMenu(playerArg)
            end
        end,
    },

    {
        "Expand Mog Wardrobe 7",
        function(playerArg)
            local remaining = 80 - container.wardrobe7.size
            if remaining < 5 then
                playerArg:PrintToPlayer("Mog Wardrobe 7 is already fully expanded", xi.msg.channel.SYSTEM_3)
                menu.options = page1
                delaySendMenu(playerArg) 
            else
                menu.options = page4
                delaySendMenu(playerArg)
            end
        end,
    },

    {
        "Expand Mog Wardrobe 8",
        function(playerArg)
            local remaining = 80 - container.wardrobe8.size
            if remaining < 5 then
                playerArg:PrintToPlayer("Mog Wardrobe 8 is already fully expanded", xi.msg.channel.SYSTEM_3)
                menu.options = page1
                delaySendMenu(playerArg) 
            else
                menu.options = page5
                delaySendMenu(playerArg)
            end
        end,
    },

    {
        "Previous Page",
        function(playerArg)
            menu.options = page1
            delaySendMenu(playerArg)
        end,
    },
}

 -- Wardrobe 5 --
page2 =
{
    {
        "5 Wardrobe Slots",
        function(playerArg)
            quantity = 5
            price = quantity * container.wardrobe5.price

            playerArg:PrintToPlayer("Mooglin : Expand your Mog House 5 by " .. quantity .. " slots for " .. StringifyPrice(price) .. " gil?" , xi.msg.channel.NS_SAY)
            menu.options = page6
            delaySendMenu(playerArg)
        end,
    },

    {
        "Max Wardrobe Slots",
        function(playerArg)
            quantity = 80 - container.wardrobe5.size
            price = quantity * container.wardrobe5.price

            playerArg:PrintToPlayer("Mooglin : Expand your Mog House 5 by " .. quantity .. " slots for " .. StringifyPrice(price) .. " gil?" , xi.msg.channel.NS_SAY)
            menu.options = page6
            delaySendMenu(playerArg)
        end,
    },

    {
        "Previous Page",
        function(playerArg)
            menu.options = page1
            delaySendMenu(playerArg)
        end,
    },
}

-- Wardrobe 6 --
page3 = 
{
    {
        "5 Wardrobe Slots",
        function(playerArg)
            quantity = 5
            price = quantity * container.wardrobe6.price

            playerArg:PrintToPlayer("Mooglin : Expand your Mog House 6 by " .. quantity .. " slots for " .. StringifyPrice(price) .. " gil?" , xi.msg.channel.NS_SAY)
            menu.options = page7
            delaySendMenu(playerArg)
        end,
    },

    {
        "Max Wardrobe Slots",
        function(playerArg)
            quantity = 80 - container.wardrobe6.size
            price = quantity * container.wardrobe6.price

            playerArg:PrintToPlayer("Mooglin : Expand your Mog House 6 by " .. quantity .. " slots for " .. StringifyPrice(price) .. " gil?" , xi.msg.channel.NS_SAY)
            menu.options = page7
            delaySendMenu(playerArg)
        end,
    },

    {
        "Previous Page",
        function(playerArg)
            menu.options = page1
            delaySendMenu(playerArg)
        end,
    },
}

 -- Wardrobe 7 -- 
page4 =
{
    {
        "5 Wardrobe Slots",
        function(playerArg)
            quantity = 5
            price = quantity * container.wardrobe7.price

            playerArg:PrintToPlayer("Mooglin : Expand your Mog House 7 by " .. quantity .. " slots for " .. StringifyPrice(price) .. " gil?" , xi.msg.channel.NS_SAY)
            menu.options = page8
            delaySendMenu(playerArg)
        end,
    },

    {
        "Max Wardrobe Slots",
        function(playerArg)
            quantity = 80 - container.wardrobe7.size
            price = quantity * container.wardrobe7.price

            playerArg:PrintToPlayer("Mooglin : Expand your Mog House 7 by " .. quantity .. " slots for " .. StringifyPrice(price) .. " gil?" , xi.msg.channel.NS_SAY)
            menu.options = page8
            delaySendMenu(playerArg)
        end,
    },

    {
        "Previous Page",
        function(playerArg)
            menu.options = page1
            delaySendMenu(playerArg)
        end,
    },
}

-- Wardrobe 8 --
page5 = 
{
    {
        "5 Wardrobe Slots",
        function(playerArg)
            quantity = 5
            price = quantity * container.wardrobe8.price

            playerArg:PrintToPlayer("Mooglin : Expand your Mog House 8 by " .. quantity .. " slots for " .. StringifyPrice(price) .. " gil?" , xi.msg.channel.NS_SAY)
            menu.options = page9
            delaySendMenu(playerArg)
        end,
    },

    {
        "Max Wardrobe Slots",
        function(playerArg)
            quantity = 80 - container.wardrobe8.size
            price = quantity * container.wardrobe8.price

            playerArg:PrintToPlayer("Mooglin : Expand your Mog House 8 by " .. quantity .. " slots for " .. StringifyPrice(price) .. " gil?" , xi.msg.channel.NS_SAY)
            menu.options = page9
            delaySendMenu(playerArg)
        end,
    },

    {
        "Previous Page",
        function(playerArg)
            menu.options = page1
            delaySendMenu(playerArg)
        end,
    },
}

--TO DO: Combine all confirmations into one page. --
--Wadrobe 5 Confirmation -- 
page6 = 
{
    {
        "Purchase",
        function(playerArg)
            if playerArg:getGil() >= price then
                player:delGil(price)
                playerArg:changeContainerSize(xi.inv.WARDROBE5, quantity)
                playerArg:PrintToPlayer("Mog Wardrobe 5 increased by " .. quantity .. " slots.", xi.msg.channel.SYSTEM_3)
            else
                playerArg:PrintToPlayer("You do not have enough gil. ", xi.msg.channel.SYSTEM_3)
            end
        end,
    },

    {
        "Cancel",
        function(playerArg)
        end,
    },
}

-- Wardrobe 6 Confirmation --
page7 = 
{
    {
        "Purchase",
        function(playerArg)
            if playerArg:getGil() >= price then
                player:delGil(price)
                playerArg:changeContainerSize(xi.inv.WARDROBE6, quantity)
                playerArg:PrintToPlayer("Mog Wardrobe 6 increased by " .. quantity .. " slots.", xi.msg.channel.SYSTEM_3)
            else
                playerArg:PrintToPlayer("You do not have enough gil. ", xi.msg.channel.SYSTEM_3)
            end
        end,
    },

    {
        "Cancel",
        function(playerArg)
        end,
    },
}

-- Wardrobe 7 Confirmation --
page8 = 
{
    {
        "Purchase",
        function(playerArg)
            if playerArg:getGil() >= price then
                player:delGil(price)
                playerArg:changeContainerSize(xi.inv.WARDROBE7, quantity)
                playerArg:PrintToPlayer("Mog Wardrobe 7 increased by " .. quantity .. " slots.", xi.msg.channel.SYSTEM_3)
            else
                playerArg:PrintToPlayer("You do not have enough gil. ", xi.msg.channel.SYSTEM_3)
            end
        end,
    },

    {
        "Cancel",
        function(playerArg)
        end,
    },
}

-- Wardrobe 8 Confirmation --
page9 = 
{
    {
        "Purchase",
        function(playerArg)
            if playerArg:getGil() >= price then
                player:delGil(price)
                playerArg:changeContainerSize(xi.inv.WARDROBE8, quantity)
                playerArg:PrintToPlayer("Mog Wardrobe 8 increased by " .. quantity .. " slots.", xi.msg.channel.SYSTEM_3)
            else
                playerArg:PrintToPlayer("You do not have enough gil. ", xi.msg.channel.SYSTEM_3)
            end
        end,
    },

    {
        "Cancel",
        function(playerArg)
        end,
    },
}



menu.options = page1
delaySendMenu(player)
        end,
    })

end)

m:addOverride("xi.zones.Windurst_Woods.Zone.onInitialize", function(zone)

    super(zone)
    
        local mooglin = zone:insertDynamicEntity({
        
        objtype = xi.objType.NPC,
    
        name = "Mooglin",

        look = 2364,

        x = -103.878,
        y = -4.000,
        z = 31.748,

        rotation = 246,

        widescan = 1,

        onTrade = function(player, npc, trade)

        end,


        onTrigger = function(player, npc)

local menu  = {}
local page1 = {}
local page2 = {}
local page3 = {}
local page4 = {}
local page5 = {}
local page6 = {}
local page7 = {}
local page8 = {}
local page9 = {}

container = {
wardrobe5 = {size=player:getContainerSize(xi.inv.WARDROBE5), price=5000},
wardrobe6 = {size=player:getContainerSize(xi.inv.WARDROBE6), price=10000},
wardrobe7 = {size=player:getContainerSize(xi.inv.WARDROBE7), price=20000},
wardrobe8 = {size=player:getContainerSize(xi.inv.WARDROBE8), price=50000},
}

StringifyPrice = function(n)
    return tostring(math.floor(n)):reverse():gsub("(%d%d%d)","%1,")
    :gsub(",(%-?)$","%1"):reverse()
end


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
        "Expand Mog Wardrobe 5",
        function(playerArg)
            local remaining = 80 - container.wardrobe5.size
            if remaining < 5 then
                playerArg:PrintToPlayer("Mog Wardrobe 5 is already fully expanded.", xi.msg.channel.SYSTEM_3)
                menu.options = page1
                delaySendMenu(playerArg) 
            else
                menu.options = page2
                delaySendMenu(playerArg)
            end
        end,
    },

    {
        "Expand Mog Wardrobe 6",
        function(playerArg)
            local remaining = 80 - container.wardrobe6.size
            if remaining < 5 then
                playerArg:PrintToPlayer("Mog Wardrobe 6 is already fully expanded.", xi.msg.channel.SYSTEM_3) 
                menu.options = page1
                delaySendMenu(playerArg)
            else
                menu.options = page3
                delaySendMenu(playerArg)
            end
        end,
    },

    {
        "Expand Mog Wardrobe 7",
        function(playerArg)
            local remaining = 80 - container.wardrobe7.size
            if remaining < 5 then
                playerArg:PrintToPlayer("Mog Wardrobe 7 is already fully expanded", xi.msg.channel.SYSTEM_3)
                menu.options = page1
                delaySendMenu(playerArg) 
            else
                menu.options = page4
                delaySendMenu(playerArg)
            end
        end,
    },

    {
        "Expand Mog Wardrobe 8",
        function(playerArg)
            local remaining = 80 - container.wardrobe8.size
            if remaining < 5 then
                playerArg:PrintToPlayer("Mog Wardrobe 8 is already fully expanded", xi.msg.channel.SYSTEM_3)
                menu.options = page1
                delaySendMenu(playerArg) 
            else
                menu.options = page5
                delaySendMenu(playerArg)
            end
        end,
    },

    {
        "Previous Page",
        function(playerArg)
            menu.options = page1
            delaySendMenu(playerArg)
        end,
    },
}

 -- Wardrobe 5 --
page2 =
{
    {
        "5 Wardrobe Slots",
        function(playerArg)
            quantity = 5
            price = quantity * container.wardrobe5.price

            playerArg:PrintToPlayer("Mooglin : Expand your Mog House 5 by " .. quantity .. " slots for " .. StringifyPrice(price) .. " gil?" , xi.msg.channel.NS_SAY)
            menu.options = page6
            delaySendMenu(playerArg)
        end,
    },

    {
        "Max Wardrobe Slots",
        function(playerArg)
            quantity = 80 - container.wardrobe5.size
            price = quantity * container.wardrobe5.price

            playerArg:PrintToPlayer("Mooglin : Expand your Mog House 5 by " .. quantity .. " slots for " .. StringifyPrice(price) .. " gil?" , xi.msg.channel.NS_SAY)
            menu.options = page6
            delaySendMenu(playerArg)
        end,
    },

    {
        "Previous Page",
        function(playerArg)
            menu.options = page1
            delaySendMenu(playerArg)
        end,
    },
}

-- Wardrobe 6 --
page3 = 
{
    {
        "5 Wardrobe Slots",
        function(playerArg)
            quantity = 5
            price = quantity * container.wardrobe6.price

            playerArg:PrintToPlayer("Mooglin : Expand your Mog House 6 by " .. quantity .. " slots for " .. StringifyPrice(price) .. " gil?" , xi.msg.channel.NS_SAY)
            menu.options = page7
            delaySendMenu(playerArg)
        end,
    },

    {
        "Max Wardrobe Slots",
        function(playerArg)
            quantity = 80 - container.wardrobe6.size
            price = quantity * container.wardrobe6.price

            playerArg:PrintToPlayer("Mooglin : Expand your Mog House 6 by " .. quantity .. " slots for " .. StringifyPrice(price) .. " gil?" , xi.msg.channel.NS_SAY)
            menu.options = page7
            delaySendMenu(playerArg)
        end,
    },

    {
        "Previous Page",
        function(playerArg)
            menu.options = page1
            delaySendMenu(playerArg)
        end,
    },
}

 -- Wardrobe 7 -- 
page4 =
{
    {
        "5 Wardrobe Slots",
        function(playerArg)
            quantity = 5
            price = quantity * container.wardrobe7.price

            playerArg:PrintToPlayer("Mooglin : Expand your Mog House 7 by " .. quantity .. " slots for " .. StringifyPrice(price) .. " gil?" , xi.msg.channel.NS_SAY)
            menu.options = page8
            delaySendMenu(playerArg)
        end,
    },

    {
        "Max Wardrobe Slots",
        function(playerArg)
            quantity = 80 - container.wardrobe7.size
            price = quantity * container.wardrobe7.price

            playerArg:PrintToPlayer("Mooglin : Expand your Mog House 7 by " .. quantity .. " slots for " .. StringifyPrice(price) .. " gil?" , xi.msg.channel.NS_SAY)
            menu.options = page8
            delaySendMenu(playerArg)
        end,
    },

    {
        "Previous Page",
        function(playerArg)
            menu.options = page1
            delaySendMenu(playerArg)
        end,
    },
}

-- Wardrobe 8 --
page5 = 
{
    {
        "5 Wardrobe Slots",
        function(playerArg)
            quantity = 5
            price = quantity * container.wardrobe8.price

            playerArg:PrintToPlayer("Mooglin : Expand your Mog House 8 by " .. quantity .. " slots for " .. StringifyPrice(price) .. " gil?" , xi.msg.channel.NS_SAY)
            menu.options = page9
            delaySendMenu(playerArg)
        end,
    },

    {
        "Max Wardrobe Slots",
        function(playerArg)
            quantity = 80 - container.wardrobe8.size
            price = quantity * container.wardrobe8.price

            playerArg:PrintToPlayer("Mooglin : Expand your Mog House 8 by " .. quantity .. " slots for " .. StringifyPrice(price) .. " gil?" , xi.msg.channel.NS_SAY)
            menu.options = page9
            delaySendMenu(playerArg)
        end,
    },

    {
        "Previous Page",
        function(playerArg)
            menu.options = page1
            delaySendMenu(playerArg)
        end,
    },
}

--TO DO: Combine all confirmations into one page. --
--Wadrobe 5 Confirmation -- 
page6 = 
{
    {
        "Purchase",
        function(playerArg)
            if playerArg:getGil() >= price then
                player:delGil(price)
                playerArg:changeContainerSize(xi.inv.WARDROBE5, quantity)
                playerArg:PrintToPlayer("Mog Wardrobe 5 increased by " .. quantity .. " slots.", xi.msg.channel.SYSTEM_3)
            else
                playerArg:PrintToPlayer("You do not have enough gil. ", xi.msg.channel.SYSTEM_3)
            end
        end,
    },

    {
        "Cancel",
        function(playerArg)
        end,
    },
}

-- Wardrobe 6 Confirmation --
page7 = 
{
    {
        "Purchase",
        function(playerArg)
            if playerArg:getGil() >= price then
                player:delGil(price)
                playerArg:changeContainerSize(xi.inv.WARDROBE6, quantity)
                playerArg:PrintToPlayer("Mog Wardrobe 6 increased by " .. quantity .. " slots.", xi.msg.channel.SYSTEM_3)
            else
                playerArg:PrintToPlayer("You do not have enough gil. ", xi.msg.channel.SYSTEM_3)
            end
        end,
    },

    {
        "Cancel",
        function(playerArg)
        end,
    },
}

-- Wardrobe 7 Confirmation --
page8 = 
{
    {
        "Purchase",
        function(playerArg)
            if playerArg:getGil() >= price then
                player:delGil(price)
                playerArg:changeContainerSize(xi.inv.WARDROBE7, quantity)
                playerArg:PrintToPlayer("Mog Wardrobe 7 increased by " .. quantity .. " slots.", xi.msg.channel.SYSTEM_3)
            else
                playerArg:PrintToPlayer("You do not have enough gil. ", xi.msg.channel.SYSTEM_3)
            end
        end,
    },

    {
        "Cancel",
        function(playerArg)
        end,
    },
}

-- Wardrobe 8 Confirmation --
page9 = 
{
    {
        "Purchase",
        function(playerArg)
            if playerArg:getGil() >= price then
                player:delGil(price)
                playerArg:changeContainerSize(xi.inv.WARDROBE8, quantity)
                playerArg:PrintToPlayer("Mog Wardrobe 8 increased by " .. quantity .. " slots.", xi.msg.channel.SYSTEM_3)
            else
                playerArg:PrintToPlayer("You do not have enough gil. ", xi.msg.channel.SYSTEM_3)
            end
        end,
    },

    {
        "Cancel",
        function(playerArg)
        end,
    },
}


npc:facePlayer(player)
menu.options = page1
delaySendMenu(player)
        end,
    })

end)

return m
