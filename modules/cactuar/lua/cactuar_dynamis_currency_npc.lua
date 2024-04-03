-----------------------------------
-- Adds Dynamis currency exchange/bank NPCs in Southern Sandora, Bastok Mines, Windurst Woods.
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('cactuar_dynamis_currency_npc')

m:addOverride('xi.zones.Southern_San_dOria.Zone.onInitialize', function(zone)

    super(zone)
    
        local CurrencyNPC = zone:insertDynamicEntity({
        
        objtype = xi.objType.NPC,
    
        name = 'Alvinne Claiveur',

        -- look = 2364,
        look = '0x0100020417101720A33017401750156000700080',

        x = 130.619,
        y = -2.200,
        z = 117.883,

        rotation = 248,

        widescan = 1,

        onTrade = function(player, npc, trade)
            bronzepieceCount = trade:getItemQty(xi.item.ORDELLE_BRONZEPIECE)
            silverpieceCount = trade:getItemQty(xi.item.MONTIONT_SILVERPIECE)
            goldpieceCount = trade:getItemQty(xi.item.RANPERRE_GOLDPIECE)

            onebyneCount = trade:getItemQty(xi.item.ONE_BYNE_BILL)
            onehundredbyneCount = trade:getItemQty(xi.item.ONE_HUNDRED_BYNE_BILL)
            onethousandbyneCount = trade:getItemQty(xi.item.TEN_THOUSAND_BYNE_BILL)

            whiteshellCount = trade:getItemQty(xi.item.TUKUKU_WHITESHELL)
            jadeshellCount = trade:getItemQty(xi.item.LUNGO_NANGO_JADESHELL)
            stripeshellCount = trade:getItemQty(xi.item.RIMILALA_STRIPESHELL)

            sandoriaCurrencyTotal = player:getCharVar('Dynamis_Currency[1452]')
            bastokCurrencyTotal = player:getCharVar('Dynamis_Currency[1455]')
            windurstCurrencyTotal = player:getCharVar('Dynamis_Currency[1449]')
            
            trade:confirmItem(xi.item.ORDELLE_BRONZEPIECE, bronzepieceCount)
            trade:confirmItem(xi.item.MONTIONT_SILVERPIECE, silverpieceCount)
            trade:confirmItem(xi.item.RANPERRE_GOLDPIECE, goldpieceCount)

            trade:confirmItem(xi.item.ONE_BYNE_BILL, onebyneCount)
            trade:confirmItem(xi.item.ONE_HUNDRED_BYNE_BILL, onehundredbyneCount)
            trade:confirmItem(xi.item.TEN_THOUSAND_BYNE_BILL, onethousandbyneCount)

            trade:confirmItem(xi.item.TUKUKU_WHITESHELL, whiteshellCount)
            trade:confirmItem(xi.item.LUNGO_NANGO_JADESHELL, jadeshellCount)
            trade:confirmItem(xi.item.RIMILALA_STRIPESHELL, stripeshellCount)
            
            player:confirmTrade()

            -- For auditing
            sandoriaCurrencyTraded = bronzepieceCount + (silverpieceCount * 100) + (goldpieceCount * 10000)
            bastokCurrencyTraded   = onebyneCount + (onehundredbyneCount * 100) + (onethousandbyneCount * 10000)
            windurstCurrencyTraded = whiteshellCount + (jadeshellCount * 100) + (stripeshellCount * 10000)
            print("[AUDIT] Traded Dynamis Currency",  "Player:",player:getName(), player:getID(), "Sandoria:",sandoriaCurrencyTraded, "Bastok:",bastokCurrencyTraded, "Windurst:",windurstCurrencyTraded)

            player:setCharVar('Dynamis_Currency[1452]', sandoriaCurrencyTotal + bronzepieceCount + (silverpieceCount * 100) + (goldpieceCount * 10000))
            player:setCharVar('Dynamis_Currency[1455]', bastokCurrencyTotal + onebyneCount + (onehundredbyneCount * 100) + (onethousandbyneCount * 10000))
            player:setCharVar('Dynamis_Currency[1449]', windurstCurrencyTotal + whiteshellCount + (jadeshellCount * 100) + (stripeshellCount * 10000))

            npc:facePlayer(player)
            player:printToPlayer('Alvinne Claiveur: I have tallied the currency you traded me and stored it in your bank.', xi.msg.channel.NS_SAY)


            player:printToPlayer('You now have '.. sandoriaCurrencyTotal + bronzepieceCount + (silverpieceCount * 100) + (goldpieceCount * 10000) ..' Bronzepieces stored.', xi.msg.channel.NS_SAY)
            player:printToPlayer('You now have '.. bastokCurrencyTotal + onebyneCount + (onehundredbyneCount * 100) + (onethousandbyneCount * 10000) ..' Bynes stored.', xi.msg.channel.NS_SAY)
            player:printToPlayer('You now have '.. windurstCurrencyTotal + whiteshellCount + (jadeshellCount * 100) + (stripeshellCount * 10000) ..' Whiteshells stored.', xi.msg.channel.NS_SAY)


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
local page10 = {}
local page11 = {}
local page12 = {}
local page13 = {}


StringifyPrice = function(n)
    return tostring(math.floor(n)):reverse():gsub('(%d%d%d)','%1,')
    :gsub(',(%-?)$','%1'):reverse()
end

npc:facePlayer(player)

local delaySendMenu = function(player)
    player:timer(50, function(playerArg)
        playerArg:customMenu(menu)
    end)
end

menu =
{
    title = 'Currency Withdrawal',
    options = {},
}

-- Currency Catagory Menu
page1 =
{
    {   
        'SandOria Currency',
        function(playerArg)
                menu.options = page2
                currencyTotal = playerArg:getCharVar('Dynamis_Currency[1452]')
                playerArg:printToPlayer('You currently have '.. currencyTotal ..' Bronzepieces stored.', xi.msg.channel.NS_SAY)
                delaySendMenu(playerArg) 
        end,
    },

    {
        'Bastok Currency',
        function(playerArg)
                menu.options = page6
                currencyTotal = playerArg:getCharVar('Dynamis_Currency[1455]')
                playerArg:printToPlayer('You currently have '.. currencyTotal ..' Bynes stored.', xi.msg.channel.NS_SAY)
                delaySendMenu(playerArg)
        end,
    },

    {
        'Windurst Currency',
        function(playerArg)
                menu.options = page10
                currencyTotal = playerArg:getCharVar('Dynamis_Currency[1449]')
                playerArg:printToPlayer('You currently have '.. currencyTotal ..' Whiteshells stored.', xi.msg.channel.NS_SAY)
                delaySendMenu(playerArg) 
        end,
    },

    {
        'Exit',
        function(playerArg)
        end,
    },
}

 -- Sandoria Currency Denominations
page2 =
{
    {
        'Ordelle Bronzepieces',
        function(playerArg)
            menu.options = page3
            delaySendMenu(playerArg)
        end,
    },

    {
        'Montiont Silverpieces',
        function(playerArg)
            menu.options = page4
            delaySendMenu(playerArg)
        end,
    },

    {
        'Ranperre Goldpieces',
        function(playerArg)
            menu.options = page5
            delaySendMenu(playerArg)
        end,
    },

    {
        'Previous Page',
        function(playerArg)
            menu.options = page1
            delaySendMenu(playerArg)
        end,
    },
}

-- Sandoria Currency Singles Withdrawl Amount
page3 = 
{
    {
        'Ordelle Bronzepiece (1)',
        function(playerArg)
            quantity      = 1
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1452]')
            newTotal      = currencyTotal - quantity
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= quantity then
                playerArg:addItem(xi.item.ORDELLE_BRONZEPIECE, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.ORDELLE_BRONZEPIECE, quantity)
                playerArg:setCharVar('Dynamis_Currency[1452]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' Ordelle Bronzepieces. You have ('.. newTotal ..') bronzepieces remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' Ordelle Bronzepiece is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.ORDELLE_BRONZEPIECE)
            end
            menu.options = page3
            delaySendMenu(playerArg)
        end,
    },

    {
        'Ordelle Bronzepiece (5)',
        function(playerArg)
            quantity      = 5
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1452]')
            newTotal      = currencyTotal - quantity
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= quantity then
                playerArg:addItem(xi.item.ORDELLE_BRONZEPIECE, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.ORDELLE_BRONZEPIECE, quantity)
                playerArg:setCharVar('Dynamis_Currency[1452]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' Ordelle Bronzepieces. You have ('.. newTotal ..') bronzepieces remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' Ordelle Bronzepiece is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.ORDELLE_BRONZEPIECE)
            end
            menu.options = page3
            delaySendMenu(playerArg)
        end,
    },

    {
        'Ordelle Bronzepiece (10)',
        function(playerArg)
            quantity      = 10
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1452]')
            newTotal      = currencyTotal - quantity
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= quantity then
                playerArg:addItem(xi.item.ORDELLE_BRONZEPIECE, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.ORDELLE_BRONZEPIECE, quantity)
                playerArg:setCharVar('Dynamis_Currency[1452]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' Ordelle Bronzepieces. You have ('.. newTotal ..') bronzepieces remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' Ordelle Bronzepiece is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.ORDELLE_BRONZEPIECE)
            end
            menu.options = page3
            delaySendMenu(playerArg)
        end,
    },

    {
        'Previous Page',
        function(playerArg)
            menu.options = page2
            delaySendMenu(playerArg)
        end,
    },
}

-- Sandoria Currency Singles Withdrawl Amount
page4 = 
{
    {
        'Montiont Silverpiece (1)',
        function(playerArg)
            quantity      = 1
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1452]')
            newTotal      = currencyTotal - quantity * 100
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= (quantity * 100) then
                playerArg:addItem(xi.item.MONTIONT_SILVERPIECE, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.MONTIONT_SILVERPIECE, quantity)
                playerArg:setCharVar('Dynamis_Currency[1452]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' Montiont Silverpiece. You have ('.. newTotal ..') Ordelle Bronzepieces remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' Montiont Silverpiece is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.MONTIONT_SILVERPIECE)
            end
            menu.options = page4
            delaySendMenu(playerArg)
        end,
    },

    {
        'Montiont Silverpiece (5)',
        function(playerArg)
            quantity      = 5
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1452]')
            newTotal      = currencyTotal - quantity * 100
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= (quantity * 100) then
                playerArg:addItem(xi.item.MONTIONT_SILVERPIECE, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.MONTIONT_SILVERPIECE, quantity)
                playerArg:setCharVar('Dynamis_Currency[1452]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' Montiont Silverpieces. You have ('.. newTotal ..') Ordelle Bronzepieces remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' Montiont Silverpieces is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.MONTIONT_SILVERPIECE)
            end
            menu.options = page4
            delaySendMenu(playerArg)
        end,
    },

    {
        'Montiont Silverpiece (10)',
        function(playerArg)
            quantity      = 10
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1452]')
            newTotal      = currencyTotal - quantity * 100
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= (quantity * 100) then
                playerArg:addItem(xi.item.MONTIONT_SILVERPIECE, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.MONTIONT_SILVERPIECE, quantity)
                playerArg:setCharVar('Dynamis_Currency[1452]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' Montiont Silverpieces. You have ('.. newTotal ..') Ordelle Bronzepieces remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' Montiont Silverpieces is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.MONTIONT_SILVERPIECE)
            end
            menu.options = page4
            delaySendMenu(playerArg)
        end,
    },

    {
        'Previous Page',
        function(playerArg)
            menu.options = page2
            delaySendMenu(playerArg)
        end,
    },
}

-- Sandoria Currency Thousand Withdrawl Amount
page5 = 
{
    {
        'Ranperre Goldpiece (1)',
        function(playerArg)
            quantity      = 1
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1452]')
            newTotal      = currencyTotal - quantity * 10000
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= (quantity * 10000) then
                playerArg:addItem(xi.item.RANPERRE_GOLDPIECE, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.RANPERRE_GOLDPIECE, quantity)
                playerArg:setCharVar('Dynamis_Currency[1452]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' Ranperre Goldpiece. You have ('.. newTotal ..') Ordelle Bronzepieces remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' Ranperre Goldpiece is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.RANPERRE_GOLDPIECE)
            end
            menu.options = page5
            delaySendMenu(playerArg)
        end,
    },

    {
        'Previous Page',
        function(playerArg)
            menu.options = page2
            delaySendMenu(playerArg)
        end,
    },
}

 -- Bastok Currency Denominations
page6 =
{
    {
        'One Byne Bills',
        function(playerArg)
            menu.options = page7
            delaySendMenu(playerArg)
        end,
    },

    {
        'One Hundred Byne Bills',
        function(playerArg)
            menu.options = page8
            delaySendMenu(playerArg)
        end,
    },

    {
        'Ten Thousand Byne Bills',
        function(playerArg)
            menu.options = page9
            delaySendMenu(playerArg)
        end,
    },

    {
        'Previous Page',
        function(playerArg)
            menu.options = page1
            delaySendMenu(playerArg)
        end,
    },
}

-- Bastok Currency Singles Withdrawl Amount
page7 = 
{
    {
        'One Byne Bill (1)',
        function(playerArg)
            quantity      = 1
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1455]')
            newTotal      = currencyTotal - quantity
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= quantity then
                playerArg:addItem(xi.item.ONE_BYNE_BILL, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.ONE_BYNE_BILL, quantity)
                playerArg:setCharVar('Dynamis_Currency[1455]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' One Byne Bills. You have ('.. newTotal ..') Byne Bills remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' One Byne Bill is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.ONE_BYNE_BILL)
            end
            menu.options = page7
            delaySendMenu(playerArg)
        end,
    },

    {
        'One Byne Bill (5)',
        function(playerArg)
            quantity      = 5
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1455]')
            newTotal      = currencyTotal - quantity
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= quantity then
                playerArg:addItem(xi.item.ONE_BYNE_BILL, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.ONE_BYNE_BILL, quantity)
                playerArg:setCharVar('Dynamis_Currency[1455]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' One Byne Bills. You have ('.. newTotal ..') Byne Bills remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' One Byne Bills is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.ONE_BYNE_BILL)
            end
            menu.options = page7
            delaySendMenu(playerArg)
        end,
    },

    {
        'One Byne Bill (10)',
        function(playerArg)
            quantity      = 10
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1455]')
            newTotal      = currencyTotal - quantity
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= quantity then
                playerArg:addItem(xi.item.ONE_BYNE_BILL, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.ONE_BYNE_BILL, quantity)
                playerArg:setCharVar('Dynamis_Currency[1455]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' One Byne Bills. You have ('.. newTotal ..') Byne Bills remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' One Byne Bills is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.ONE_BYNE_BILL)
            end
            menu.options = page7
            delaySendMenu(playerArg)
        end,
    },

    {
        'Previous Page',
        function(playerArg)
            menu.options = page6
            delaySendMenu(playerArg)
        end,
    },
}

-- Bastok Currency Singles Withdrawl Amount
page8 = 
{
    {
        'One Hundred Byne Bill (1)',
        function(playerArg)
            quantity      = 1
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1455]')
            newTotal      = currencyTotal - quantity * 100
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= (quantity * 100) then
                playerArg:addItem(xi.item.ONE_HUNDRED_BYNE_BILL, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.ONE_HUNDRED_BYNE_BILL, quantity)
                playerArg:setCharVar('Dynamis_Currency[1455]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' One Hundred Byne Bills. You have ('.. newTotal ..') Byne Bills remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' One Hundred Byne Bill is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.ONE_HUNDRED_BYNE_BILL)
            end
            menu.options = page8
            delaySendMenu(playerArg)
        end,
    },

    {
        'One Hundred Byne Bill (5)',
        function(playerArg)
            quantity      = 5
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1455]')
            newTotal      = currencyTotal - quantity * 100
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= (quantity * 100) then
                playerArg:addItem(xi.item.ONE_HUNDRED_BYNE_BILL, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.ONE_HUNDRED_BYNE_BILL, quantity)
                playerArg:setCharVar('Dynamis_Currency[1455]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' One Hundred Byne Bills. You have ('.. newTotal ..') Byne Bills remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' One Hundred Byne Bills is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.ONE_HUNDRED_BYNE_BILL)
            end
            menu.options = page8
            delaySendMenu(playerArg)
        end,
    },

    {
        'One Hundred Byne Bill (10)',
        function(playerArg)
            quantity      = 10
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1455]')
            newTotal      = currencyTotal - quantity * 100
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= (quantity * 100) then
                playerArg:addItem(xi.item.ONE_HUNDRED_BYNE_BILL, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.ONE_HUNDRED_BYNE_BILL, quantity)
                playerArg:setCharVar('Dynamis_Currency[1455]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' One Hundred Byne Bills. You have ('.. newTotal ..') Byne Bills remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' One Hundred Byne Bills is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.ONE_HUNDRED_BYNE_BILL)
            end
            menu.options = page8
            delaySendMenu(playerArg)
        end,
    },

    {
        'Previous Page',
        function(playerArg)
            menu.options = page6
            delaySendMenu(playerArg)
        end,
    },
}

-- Bastok Currency Thousand Withdrawl Amount
page9 = 
{
    {
        'Ten Thousand Byne Bill (1)',
        function(playerArg)
            quantity      = 1
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1455]')
            newTotal      = currencyTotal - quantity * 10000
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= (quantity * 10000) then
                playerArg:addItem(xi.item.TEN_THOUSAND_BYNE_BILL, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.TEN_THOUSAND_BYNE_BILL, quantity)
                playerArg:setCharVar('Dynamis_Currency[1455]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' Ten Thousand Byne Bill. You have ('.. newTotal ..') Byne Bills remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' Ten Thousand Byne Bill is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.TEN_THOUSAND_BYNE_BILL)
            end
            menu.options = page9
            delaySendMenu(playerArg)
        end,
    },

    {
        'Previous Page',
        function(playerArg)
            menu.options = page6
            delaySendMenu(playerArg)
        end,
    },
}

-- Windurst Currency Denominations
page10 =
{
    {
        'Tukuku Whiteshells',
        function(playerArg)
            menu.options = page11
            delaySendMenu(playerArg)
        end,
    },

    {
        'Lungo Nango Jadeshell',
        function(playerArg)
            menu.options = page12
            delaySendMenu(playerArg)
        end,
    },

    {
        'Rimilala Stripeshell',
        function(playerArg)
            menu.options = page13
            delaySendMenu(playerArg)
        end,
    },

    {
        'Previous Page',
        function(playerArg)
            menu.options = page1
            delaySendMenu(playerArg)
        end,
    },
}

-- Windurst Currency Singles Withdrawl Amount
page11 = 
{
    {
        'Tukuku Whiteshell (1)',
        function(playerArg)
            quantity      = 1
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1449]')
            newTotal      = currencyTotal - quantity
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= quantity then
                playerArg:addItem(xi.item.TUKUKU_WHITESHELL, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.TUKUKU_WHITESHELL, quantity)
                playerArg:setCharVar('Dynamis_Currency[1449]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' Tukuku Whiteshells. You have ('.. newTotal ..') Tukuku Whiteshells remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' Tukuku Whiteshells is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.TUKUKU_WHITESHELL)
            end
            menu.options = page11
            delaySendMenu(playerArg)
        end,
    },

    {
        'Tukuku Whiteshell (5)',
        function(playerArg)
            quantity      = 5
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1449]')
            newTotal      = currencyTotal - quantity
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= quantity then
                playerArg:addItem(xi.item.TUKUKU_WHITESHELL, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.TUKUKU_WHITESHELL, quantity)
                playerArg:setCharVar('Dynamis_Currency[1449]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' Tukuku Whiteshells. You have ('.. newTotal ..') Tukuku Whiteshells remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' Tukuku Whiteshells is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.TUKUKU_WHITESHELL)
            end
            menu.options = page11
            delaySendMenu(playerArg)
        end,
    },

    {
        'Tukuku Whiteshell (10)',
        function(playerArg)
            quantity      = 10
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1449]')
            newTotal      = currencyTotal - quantity
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= quantity then
                playerArg:addItem(xi.item.TUKUKU_WHITESHELL, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.TUKUKU_WHITESHELL, quantity)
                playerArg:setCharVar('Dynamis_Currency[1449]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' Tukuku Whiteshells. You have ('.. newTotal ..') Tukuku Whiteshells remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' Tukuku Whiteshells is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.TUKUKU_WHITESHELL)
            end
            menu.options = page11
            delaySendMenu(playerArg)
        end,
    },

    {
        'Previous Page',
        function(playerArg)
            menu.options = page10
            delaySendMenu(playerArg)
        end,
    },
}

-- Windurst Currency Hundreds Withdrawl Amount
page12 = 
{
    {
        'Lungo Nango Jadeshell (1)',
        function(playerArg)
            quantity      = 1
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1449]')
            newTotal      = currencyTotal - quantity * 100
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= (quantity * 100) then
                playerArg:addItem(xi.item.LUNGO_NANGO_JADESHELL, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.LUNGO_NANGO_JADESHELL, quantity)
                playerArg:setCharVar('Dynamis_Currency[1449]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' Lungo Nango Jadeshells. You have ('.. newTotal ..') Tukuku Whiteshells remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' Lungo Nango Jadeshells is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.LUNGO_NANGO_JADESHELL)
            end
            menu.options = page12
            delaySendMenu(playerArg)
        end,
    },

    {
        'Lungo Nango Jadeshell (5)',
        function(playerArg)
            quantity      = 5
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1449]')
            newTotal      = currencyTotal - quantity * 100
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= (quantity * 100) then
                playerArg:addItem(xi.item.LUNGO_NANGO_JADESHELL, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.LUNGO_NANGO_JADESHELL, quantity)
                playerArg:setCharVar('Dynamis_Currency[1449]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' Lungo Nango Jadeshells. You have ('.. newTotal ..') Tukuku Whiteshells remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' Lungo Nango Jadeshells is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.LUNGO_NANGO_JADESHELL)
            end
            menu.options = page12
            delaySendMenu(playerArg)
        end,
    },

    {
        'Lungo Nango Jadeshell (10)',
        function(playerArg)
            quantity      = 10
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1449]')
            newTotal      = currencyTotal - quantity * 100
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= (quantity * 100) then
                playerArg:addItem(xi.item.LUNGO_NANGO_JADESHELL, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.LUNGO_NANGO_JADESHELL, quantity)
                playerArg:setCharVar('Dynamis_Currency[1449]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' Lungo Nango Jadeshells. You have ('.. newTotal ..') Tukuku Whiteshells remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' Lungo Nango Jadeshells is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.LUNGO_NANGO_JADESHELL)
            end
            menu.options = page12
            delaySendMenu(playerArg)
        end,
    },

    {
        'Previous Page',
        function(playerArg)
            menu.options = page10
            delaySendMenu(playerArg)
        end,
    },
}

-- Windurst Currency Thousand Withdrawl Amount
page13 = 
{
    {
        'Rimilala Stripeshell (1)',
        function(playerArg)
            quantity      = 1
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1449]')
            newTotal      = currencyTotal - quantity * 10000
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= (quantity * 10000) then
                playerArg:addItem(xi.item.RIMILALA_STRIPESHELL, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.RIMILALA_STRIPESHELL, quantity)
                playerArg:setCharVar('Dynamis_Currency[1449]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' Rimilala Stripeshells. You have ('.. newTotal ..') Tukuku Whiteshells remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' Rimilala Stripeshells is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.RIMILALA_STRIPESHELL)
            end
            menu.options = page13
            delaySendMenu(playerArg)
        end,
    },

    {
        'Previous Page',
        function(playerArg)
            menu.options = page10
            delaySendMenu(playerArg)
        end,
    },
}


menu.options = page1
delaySendMenu(player)
        end,
    })

end)

m:addOverride('xi.zones.Bastok_Mines.Zone.onInitialize', function(zone)

    super(zone)
    
        local CurrencyNPC = zone:insertDynamicEntity({
        
        objtype = xi.objType.NPC,
    
        name = 'Rising Bull',

        look = '0x0100020817101720A33017401750156000700080',

        x = 97.864,
        y = 0.994,
        z = -73.949,

        rotation = 255,

        widescan = 1,

        onTrade = function(player, npc, trade)
            bronzepieceCount = trade:getItemQty(xi.item.ORDELLE_BRONZEPIECE)
            silverpieceCount = trade:getItemQty(xi.item.MONTIONT_SILVERPIECE)
            goldpieceCount = trade:getItemQty(xi.item.RANPERRE_GOLDPIECE)

            onebyneCount = trade:getItemQty(xi.item.ONE_BYNE_BILL)
            onehundredbyneCount = trade:getItemQty(xi.item.ONE_HUNDRED_BYNE_BILL)
            onethousandbyneCount = trade:getItemQty(xi.item.TEN_THOUSAND_BYNE_BILL)

            whiteshellCount = trade:getItemQty(xi.item.TUKUKU_WHITESHELL)
            jadeshellCount = trade:getItemQty(xi.item.LUNGO_NANGO_JADESHELL)
            stripeshellCount = trade:getItemQty(xi.item.RIMILALA_STRIPESHELL)

            sandoriaCurrencyTotal = player:getCharVar('Dynamis_Currency[1452]')
            bastokCurrencyTotal = player:getCharVar('Dynamis_Currency[1455]')
            windurstCurrencyTotal = player:getCharVar('Dynamis_Currency[1449]')

            trade:confirmItem(xi.item.ORDELLE_BRONZEPIECE, bronzepieceCount)
            trade:confirmItem(xi.item.MONTIONT_SILVERPIECE, silverpieceCount)
            trade:confirmItem(xi.item.RANPERRE_GOLDPIECE, goldpieceCount)

            trade:confirmItem(xi.item.ONE_BYNE_BILL, onebyneCount)
            trade:confirmItem(xi.item.ONE_HUNDRED_BYNE_BILL, onehundredbyneCount)
            trade:confirmItem(xi.item.TEN_THOUSAND_BYNE_BILL, onethousandbyneCount)

            trade:confirmItem(xi.item.TUKUKU_WHITESHELL, whiteshellCount)
            trade:confirmItem(xi.item.LUNGO_NANGO_JADESHELL, jadeshellCount)
            trade:confirmItem(xi.item.RIMILALA_STRIPESHELL, stripeshellCount)
            
            player:confirmTrade()

            -- For auditing
            sandoriaCurrencyTraded = bronzepieceCount + (silverpieceCount * 100) + (goldpieceCount * 10000)
            bastokCurrencyTraded   = onebyneCount + (onehundredbyneCount * 100) + (onethousandbyneCount * 10000)
            windurstCurrencyTraded = whiteshellCount + (jadeshellCount * 100) + (stripeshellCount * 10000)
            print("[AUDIT] Traded Dynamis Currency",  "Player:",player:getName(), player:getID(), "Sandoria:",sandoriaCurrencyTraded, "Bastok:",bastokCurrencyTraded, "Windurst:",windurstCurrencyTraded)

            player:setCharVar('Dynamis_Currency[1452]', sandoriaCurrencyTotal + bronzepieceCount + (silverpieceCount * 100) + (goldpieceCount * 10000))
            player:setCharVar('Dynamis_Currency[1455]', bastokCurrencyTotal + onebyneCount + (onehundredbyneCount * 100) + (onethousandbyneCount * 10000))
            player:setCharVar('Dynamis_Currency[1449]', windurstCurrencyTotal + whiteshellCount + (jadeshellCount * 100) + (stripeshellCount * 10000))

            npc:facePlayer(player)
            player:printToPlayer('Rising Bull: I have tallied the currency you traded me and stored it in your bank.', xi.msg.channel.NS_SAY)


            player:printToPlayer('You now have '.. sandoriaCurrencyTotal + bronzepieceCount + (silverpieceCount * 100) + (goldpieceCount * 10000) ..' Bronzepieces stored.', xi.msg.channel.NS_SAY)
            player:printToPlayer('You now have '.. bastokCurrencyTotal + onebyneCount + (onehundredbyneCount * 100) + (onethousandbyneCount * 10000) ..' Bynes stored.', xi.msg.channel.NS_SAY)
            player:printToPlayer('You now have '.. windurstCurrencyTotal + whiteshellCount + (jadeshellCount * 100) + (stripeshellCount * 10000) ..' Whiteshells stored.', xi.msg.channel.NS_SAY)


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
local page10 = {}
local page11 = {}
local page12 = {}
local page13 = {}


StringifyPrice = function(n)
    return tostring(math.floor(n)):reverse():gsub('(%d%d%d)','%1,')
    :gsub(',(%-?)$','%1'):reverse()
end

npc:facePlayer(player)

local delaySendMenu = function(player)
    player:timer(50, function(playerArg)
        playerArg:customMenu(menu)
    end)
end

menu =
{
    title = 'Currency Withdrawal',
    options = {},
}

-- Currency Catagory Menu
page1 =
{
    {   
        'SandOria Currency',
        function(playerArg)
                menu.options = page2
                currencyTotal = playerArg:getCharVar('Dynamis_Currency[1452]')
                playerArg:printToPlayer('You currently have '.. currencyTotal ..' Bronzepieces stored.', xi.msg.channel.NS_SAY)
                delaySendMenu(playerArg) 
        end,
    },

    {
        'Bastok Currency',
        function(playerArg)
                menu.options = page6
                currencyTotal = playerArg:getCharVar('Dynamis_Currency[1455]')
                playerArg:printToPlayer('You currently have '.. currencyTotal ..' Bynes stored.', xi.msg.channel.NS_SAY)
                delaySendMenu(playerArg)
        end,
    },

    {
        'Windurst Currency',
        function(playerArg)
                menu.options = page10
                currencyTotal = playerArg:getCharVar('Dynamis_Currency[1449]')
                playerArg:printToPlayer('You currently have '.. currencyTotal ..' Whiteshells stored.', xi.msg.channel.NS_SAY)
                delaySendMenu(playerArg) 
        end,
    },

    {
        'Exit',
        function(playerArg)
        end,
    },
}

 -- Sandoria Currency Denominations
page2 =
{
    {
        'Ordelle Bronzepieces',
        function(playerArg)
            menu.options = page3
            delaySendMenu(playerArg)
        end,
    },

    {
        'Montiont Silverpieces',
        function(playerArg)
            menu.options = page4
            delaySendMenu(playerArg)
        end,
    },

    {
        'Ranperre Goldpieces',
        function(playerArg)
            menu.options = page5
            delaySendMenu(playerArg)
        end,
    },

    {
        'Previous Page',
        function(playerArg)
            menu.options = page1
            delaySendMenu(playerArg)
        end,
    },
}

-- Sandoria Currency Singles Withdrawl Amount
page3 = 
{
    {
        'Ordelle Bronzepiece (1)',
        function(playerArg)
            quantity      = 1
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1452]')
            newTotal      = currencyTotal - quantity
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= quantity then
                playerArg:addItem(xi.item.ORDELLE_BRONZEPIECE, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.ORDELLE_BRONZEPIECE, quantity)
                playerArg:setCharVar('Dynamis_Currency[1452]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' Ordelle Bronzepieces. You have ('.. newTotal ..') bronzepieces remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' Ordelle Bronzepiece is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.ORDELLE_BRONZEPIECE)
            end
            menu.options = page3
            delaySendMenu(playerArg)
        end,
    },

    {
        'Ordelle Bronzepiece (5)',
        function(playerArg)
            quantity      = 5
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1452]')
            newTotal      = currencyTotal - quantity
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= quantity then
                playerArg:addItem(xi.item.ORDELLE_BRONZEPIECE, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.ORDELLE_BRONZEPIECE, quantity)
                playerArg:setCharVar('Dynamis_Currency[1452]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' Ordelle Bronzepieces. You have ('.. newTotal ..') bronzepieces remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' Ordelle Bronzepiece is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.ORDELLE_BRONZEPIECE)
            end
            menu.options = page3
            delaySendMenu(playerArg)
        end,
    },

    {
        'Ordelle Bronzepiece (10)',
        function(playerArg)
            quantity      = 10
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1452]')
            newTotal      = currencyTotal - quantity
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= quantity then
                playerArg:addItem(xi.item.ORDELLE_BRONZEPIECE, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.ORDELLE_BRONZEPIECE, quantity)
                playerArg:setCharVar('Dynamis_Currency[1452]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' Ordelle Bronzepieces. You have ('.. newTotal ..') bronzepieces remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' Ordelle Bronzepiece is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.ORDELLE_BRONZEPIECE)
            end
            menu.options = page3
            delaySendMenu(playerArg)
        end,
    },

    {
        'Previous Page',
        function(playerArg)
            menu.options = page2
            delaySendMenu(playerArg)
        end,
    },
}

-- Sandoria Currency Singles Withdrawl Amount
page4 = 
{
    {
        'Montiont Silverpiece (1)',
        function(playerArg)
            quantity      = 1
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1452]')
            newTotal      = currencyTotal - quantity * 100
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= (quantity * 100) then
                playerArg:addItem(xi.item.MONTIONT_SILVERPIECE, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.MONTIONT_SILVERPIECE, quantity)
                playerArg:setCharVar('Dynamis_Currency[1452]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' Montiont Silverpiece. You have ('.. newTotal ..') Ordelle Bronzepieces remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' Montiont Silverpiece is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.MONTIONT_SILVERPIECE)
            end
            menu.options = page4
            delaySendMenu(playerArg)
        end,
    },

    {
        'Montiont Silverpiece (5)',
        function(playerArg)
            quantity      = 5
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1452]')
            newTotal      = currencyTotal - quantity * 100
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= (quantity * 100) then
                playerArg:addItem(xi.item.MONTIONT_SILVERPIECE, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.MONTIONT_SILVERPIECE, quantity)
                playerArg:setCharVar('Dynamis_Currency[1452]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' Montiont Silverpieces. You have ('.. newTotal ..') Ordelle Bronzepieces remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' Montiont Silverpieces is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.MONTIONT_SILVERPIECE)
            end
            menu.options = page4
            delaySendMenu(playerArg)
        end,
    },

    {
        'Montiont Silverpiece (10)',
        function(playerArg)
            quantity      = 10
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1452]')
            newTotal      = currencyTotal - quantity * 100
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= (quantity * 100) then
                playerArg:addItem(xi.item.MONTIONT_SILVERPIECE, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.MONTIONT_SILVERPIECE, quantity)
                playerArg:setCharVar('Dynamis_Currency[1452]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' Montiont Silverpieces. You have ('.. newTotal ..') Ordelle Bronzepieces remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' Montiont Silverpieces is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.MONTIONT_SILVERPIECE)
            end
            menu.options = page4
            delaySendMenu(playerArg)
        end,
    },

    {
        'Previous Page',
        function(playerArg)
            menu.options = page2
            delaySendMenu(playerArg)
        end,
    },
}

-- Sandoria Currency Thousand Withdrawl Amount
page5 = 
{
    {
        'Ranperre Goldpiece (1)',
        function(playerArg)
            quantity      = 1
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1452]')
            newTotal      = currencyTotal - quantity * 10000
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= (quantity * 10000) then
                playerArg:addItem(xi.item.RANPERRE_GOLDPIECE, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.RANPERRE_GOLDPIECE, quantity)
                playerArg:setCharVar('Dynamis_Currency[1452]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' Ranperre Goldpiece. You have ('.. newTotal ..') Ordelle Bronzepieces remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' Ranperre Goldpiece is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.RANPERRE_GOLDPIECE)
            end
            menu.options = page5
            delaySendMenu(playerArg)
        end,
    },

    {
        'Previous Page',
        function(playerArg)
            menu.options = page2
            delaySendMenu(playerArg)
        end,
    },
}

 -- Bastok Currency Denominations
page6 =
{
    {
        'One Byne Bills',
        function(playerArg)
            menu.options = page7
            delaySendMenu(playerArg)
        end,
    },

    {
        'One Hundred Byne Bills',
        function(playerArg)
            menu.options = page8
            delaySendMenu(playerArg)
        end,
    },

    {
        'Ten Thousand Byne Bills',
        function(playerArg)
            menu.options = page9
            delaySendMenu(playerArg)
        end,
    },

    {
        'Previous Page',
        function(playerArg)
            menu.options = page1
            delaySendMenu(playerArg)
        end,
    },
}

-- Bastok Currency Singles Withdrawl Amount
page7 = 
{
    {
        'One Byne Bill (1)',
        function(playerArg)
            quantity      = 1
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1455]')
            newTotal      = currencyTotal - quantity
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= quantity then
                playerArg:addItem(xi.item.ONE_BYNE_BILL, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.ONE_BYNE_BILL, quantity)
                playerArg:setCharVar('Dynamis_Currency[1455]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' One Byne Bills. You have ('.. newTotal ..') Byne Bills remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' One Byne Bill is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.ONE_BYNE_BILL)
            end
            menu.options = page7
            delaySendMenu(playerArg)
        end,
    },

    {
        'One Byne Bill (5)',
        function(playerArg)
            quantity      = 5
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1455]')
            newTotal      = currencyTotal - quantity
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= quantity then
                playerArg:addItem(xi.item.ONE_BYNE_BILL, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.ONE_BYNE_BILL, quantity)
                playerArg:setCharVar('Dynamis_Currency[1455]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' One Byne Bills. You have ('.. newTotal ..') Byne Bills remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' One Byne Bills is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.ONE_BYNE_BILL)
            end
            menu.options = page7
            delaySendMenu(playerArg)
        end,
    },

    {
        'One Byne Bill (10)',
        function(playerArg)
            quantity      = 10
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1455]')
            newTotal      = currencyTotal - quantity
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= quantity then
                playerArg:addItem(xi.item.ONE_BYNE_BILL, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.ONE_BYNE_BILL, quantity)
                playerArg:setCharVar('Dynamis_Currency[1455]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' One Byne Bills. You have ('.. newTotal ..') Byne Bills remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' One Byne Bills is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.ONE_BYNE_BILL)
            end
            menu.options = page7
            delaySendMenu(playerArg)
        end,
    },

    {
        'Previous Page',
        function(playerArg)
            menu.options = page6
            delaySendMenu(playerArg)
        end,
    },
}

-- Bastok Currency Singles Withdrawl Amount
page8 = 
{
    {
        'One Hundred Byne Bill (1)',
        function(playerArg)
            quantity      = 1
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1455]')
            newTotal      = currencyTotal - quantity * 100
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= (quantity * 100) then
                playerArg:addItem(xi.item.ONE_HUNDRED_BYNE_BILL, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.ONE_HUNDRED_BYNE_BILL, quantity)
                playerArg:setCharVar('Dynamis_Currency[1455]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' One Hundred Byne Bills. You have ('.. newTotal ..') Byne Bills remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' One Hundred Byne Bill is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.ONE_HUNDRED_BYNE_BILL)
            end
            menu.options = page8
            delaySendMenu(playerArg)
        end,
    },

    {
        'One Hundred Byne Bill (5)',
        function(playerArg)
            quantity      = 5
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1455]')
            newTotal      = currencyTotal - quantity * 100
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= (quantity * 100) then
                playerArg:addItem(xi.item.ONE_HUNDRED_BYNE_BILL, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.ONE_HUNDRED_BYNE_BILL, quantity)
                playerArg:setCharVar('Dynamis_Currency[1455]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' One Hundred Byne Bills. You have ('.. newTotal ..') Byne Bills remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' One Hundred Byne Bills is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.ONE_HUNDRED_BYNE_BILL)
            end
            menu.options = page8
            delaySendMenu(playerArg)
        end,
    },

    {
        'One Hundred Byne Bill (10)',
        function(playerArg)
            quantity      = 10
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1455]')
            newTotal      = currencyTotal - quantity * 100
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= (quantity * 100) then
                playerArg:addItem(xi.item.ONE_HUNDRED_BYNE_BILL, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.ONE_HUNDRED_BYNE_BILL, quantity)
                playerArg:setCharVar('Dynamis_Currency[1455]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' One Hundred Byne Bills. You have ('.. newTotal ..') Byne Bills remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' One Hundred Byne Bills is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.ONE_HUNDRED_BYNE_BILL)
            end
            menu.options = page8
            delaySendMenu(playerArg)
        end,
    },

    {
        'Previous Page',
        function(playerArg)
            menu.options = page6
            delaySendMenu(playerArg)
        end,
    },
}

-- Bastok Currency Thousand Withdrawl Amount
page9 = 
{
    {
        'Ten Thousand Byne Bill (1)',
        function(playerArg)
            quantity      = 1
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1455]')
            newTotal      = currencyTotal - quantity * 10000
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= (quantity * 10000) then
                playerArg:addItem(xi.item.TEN_THOUSAND_BYNE_BILL, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.TEN_THOUSAND_BYNE_BILL, quantity)
                playerArg:setCharVar('Dynamis_Currency[1455]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' Ten Thousand Byne Bill. You have ('.. newTotal ..') Byne Bills remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' Ten Thousand Byne Bill is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.TEN_THOUSAND_BYNE_BILL)
            end
            menu.options = page9
            delaySendMenu(playerArg)
        end,
    },

    {
        'Previous Page',
        function(playerArg)
            menu.options = page6
            delaySendMenu(playerArg)
        end,
    },
}

-- Windurst Currency Denominations
page10 =
{
    {
        'Tukuku Whiteshells',
        function(playerArg)
            menu.options = page11
            delaySendMenu(playerArg)
        end,
    },

    {
        'Lungo Nango Jadeshell',
        function(playerArg)
            menu.options = page12
            delaySendMenu(playerArg)
        end,
    },

    {
        'Rimilala Stripeshell',
        function(playerArg)
            menu.options = page13
            delaySendMenu(playerArg)
        end,
    },

    {
        'Previous Page',
        function(playerArg)
            menu.options = page1
            delaySendMenu(playerArg)
        end,
    },
}

-- Windurst Currency Singles Withdrawl Amount
page11 = 
{
    {
        'Tukuku Whiteshell (1)',
        function(playerArg)
            quantity      = 1
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1449]')
            newTotal      = currencyTotal - quantity
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= quantity then
                playerArg:addItem(xi.item.TUKUKU_WHITESHELL, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.TUKUKU_WHITESHELL, quantity)
                playerArg:setCharVar('Dynamis_Currency[1449]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' Tukuku Whiteshells. You have ('.. newTotal ..') Tukuku Whiteshells remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' Tukuku Whiteshells is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.TUKUKU_WHITESHELL)
            end
            menu.options = page11
            delaySendMenu(playerArg)
        end,
    },

    {
        'Tukuku Whiteshell (5)',
        function(playerArg)
            quantity      = 5
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1449]')
            newTotal      = currencyTotal - quantity
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= quantity then
                playerArg:addItem(xi.item.TUKUKU_WHITESHELL, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.TUKUKU_WHITESHELL, quantity)
                playerArg:setCharVar('Dynamis_Currency[1449]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' Tukuku Whiteshells. You have ('.. newTotal ..') Tukuku Whiteshells remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' Tukuku Whiteshells is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.TUKUKU_WHITESHELL)
            end
            menu.options = page11
            delaySendMenu(playerArg)
        end,
    },

    {
        'Tukuku Whiteshell (10)',
        function(playerArg)
            quantity      = 10
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1449]')
            newTotal      = currencyTotal - quantity
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= quantity then
                playerArg:addItem(xi.item.TUKUKU_WHITESHELL, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.TUKUKU_WHITESHELL, quantity)
                playerArg:setCharVar('Dynamis_Currency[1449]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' Tukuku Whiteshells. You have ('.. newTotal ..') Tukuku Whiteshells remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' Tukuku Whiteshells is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.TUKUKU_WHITESHELL)
            end
            menu.options = page11
            delaySendMenu(playerArg)
        end,
    },

    {
        'Previous Page',
        function(playerArg)
            menu.options = page10
            delaySendMenu(playerArg)
        end,
    },
}

-- Windurst Currency Hundreds Withdrawl Amount
page12 = 
{
    {
        'Lungo Nango Jadeshell (1)',
        function(playerArg)
            quantity      = 1
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1449]')
            newTotal      = currencyTotal - quantity * 100
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= (quantity * 100) then
                playerArg:addItem(xi.item.LUNGO_NANGO_JADESHELL, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.LUNGO_NANGO_JADESHELL, quantity)
                playerArg:setCharVar('Dynamis_Currency[1449]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' Lungo Nango Jadeshells. You have ('.. newTotal ..') Tukuku Whiteshells remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' Lungo Nango Jadeshells is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.LUNGO_NANGO_JADESHELL)
            end
            menu.options = page12
            delaySendMenu(playerArg)
        end,
    },

    {
        'Lungo Nango Jadeshell (5)',
        function(playerArg)
            quantity      = 5
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1449]')
            newTotal      = currencyTotal - quantity * 100
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= (quantity * 100) then
                playerArg:addItem(xi.item.LUNGO_NANGO_JADESHELL, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.LUNGO_NANGO_JADESHELL, quantity)
                playerArg:setCharVar('Dynamis_Currency[1449]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' Lungo Nango Jadeshells. You have ('.. newTotal ..') Tukuku Whiteshells remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' Lungo Nango Jadeshells is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.LUNGO_NANGO_JADESHELL)
            end
            menu.options = page12
            delaySendMenu(playerArg)
        end,
    },

    {
        'Lungo Nango Jadeshell (10)',
        function(playerArg)
            quantity      = 10
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1449]')
            newTotal      = currencyTotal - quantity * 100
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= (quantity * 100) then
                playerArg:addItem(xi.item.LUNGO_NANGO_JADESHELL, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.LUNGO_NANGO_JADESHELL, quantity)
                playerArg:setCharVar('Dynamis_Currency[1449]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' Lungo Nango Jadeshells. You have ('.. newTotal ..') Tukuku Whiteshells remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' Lungo Nango Jadeshells is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.LUNGO_NANGO_JADESHELL)
            end
            menu.options = page12
            delaySendMenu(playerArg)
        end,
    },

    {
        'Previous Page',
        function(playerArg)
            menu.options = page10
            delaySendMenu(playerArg)
        end,
    },
}

-- Windurst Currency Thousand Withdrawl Amount
page13 = 
{
    {
        'Rimilala Stripeshell (1)',
        function(playerArg)
            quantity      = 1
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1449]')
            newTotal      = currencyTotal - quantity * 10000
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= (quantity * 10000) then
                playerArg:addItem(xi.item.RIMILALA_STRIPESHELL, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.RIMILALA_STRIPESHELL, quantity)
                playerArg:setCharVar('Dynamis_Currency[1449]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' Rimilala Stripeshells. You have ('.. newTotal ..') Tukuku Whiteshells remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' Rimilala Stripeshells is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.RIMILALA_STRIPESHELL)
            end
            menu.options = page13
            delaySendMenu(playerArg)
        end,
    },

    {
        'Previous Page',
        function(playerArg)
            menu.options = page10
            delaySendMenu(playerArg)
        end,
    },
}


menu.options = page1
delaySendMenu(player)
        end,
    })

end)

m:addOverride('xi.zones.Windurst_Walls.Zone.onInitialize', function(zone)

    super(zone)
    
        local CurrencyNPC = zone:insertDynamicEntity({
        
        objtype = xi.objType.NPC,
    
        name = 'Ahko Mewlmirih',

        look = '0x0100020717101720A33017401750156000700080',

        x = -203.208,
        y = 0.000,
        z = -101.020,

        rotation = 120,

        widescan = 1,

        onTrade = function(player, npc, trade)
            bronzepieceCount = trade:getItemQty(xi.item.ORDELLE_BRONZEPIECE)
            silverpieceCount = trade:getItemQty(xi.item.MONTIONT_SILVERPIECE)
            goldpieceCount = trade:getItemQty(xi.item.RANPERRE_GOLDPIECE)

            onebyneCount = trade:getItemQty(xi.item.ONE_BYNE_BILL)
            onehundredbyneCount = trade:getItemQty(xi.item.ONE_HUNDRED_BYNE_BILL)
            onethousandbyneCount = trade:getItemQty(xi.item.TEN_THOUSAND_BYNE_BILL)

            whiteshellCount = trade:getItemQty(xi.item.TUKUKU_WHITESHELL)
            jadeshellCount = trade:getItemQty(xi.item.LUNGO_NANGO_JADESHELL)
            stripeshellCount = trade:getItemQty(xi.item.RIMILALA_STRIPESHELL)

            sandoriaCurrencyTotal = player:getCharVar('Dynamis_Currency[1452]')
            bastokCurrencyTotal = player:getCharVar('Dynamis_Currency[1455]')
            windurstCurrencyTotal = player:getCharVar('Dynamis_Currency[1449]')
            
            trade:confirmItem(xi.item.ORDELLE_BRONZEPIECE, bronzepieceCount)
            trade:confirmItem(xi.item.MONTIONT_SILVERPIECE, silverpieceCount)
            trade:confirmItem(xi.item.RANPERRE_GOLDPIECE, goldpieceCount)

            trade:confirmItem(xi.item.ONE_BYNE_BILL, onebyneCount)
            trade:confirmItem(xi.item.ONE_HUNDRED_BYNE_BILL, onehundredbyneCount)
            trade:confirmItem(xi.item.TEN_THOUSAND_BYNE_BILL, onethousandbyneCount)

            trade:confirmItem(xi.item.TUKUKU_WHITESHELL, whiteshellCount)
            trade:confirmItem(xi.item.LUNGO_NANGO_JADESHELL, jadeshellCount)
            trade:confirmItem(xi.item.RIMILALA_STRIPESHELL, stripeshellCount)
            
            player:confirmTrade()

            -- For auditing
            sandoriaCurrencyTraded = bronzepieceCount + (silverpieceCount * 100) + (goldpieceCount * 10000)
            bastokCurrencyTraded   = onebyneCount + (onehundredbyneCount * 100) + (onethousandbyneCount * 10000)
            windurstCurrencyTraded = whiteshellCount + (jadeshellCount * 100) + (stripeshellCount * 10000)
            print("[AUDIT] Traded Dynamis Currency",  "Player:",player:getName(), player:getID(), "Sandoria:",sandoriaCurrencyTraded, "Bastok:",bastokCurrencyTraded, "Windurst:",windurstCurrencyTraded)

            player:setCharVar('Dynamis_Currency[1452]', sandoriaCurrencyTotal + bronzepieceCount + (silverpieceCount * 100) + (goldpieceCount * 10000))
            player:setCharVar('Dynamis_Currency[1455]', bastokCurrencyTotal + onebyneCount + (onehundredbyneCount * 100) + (onethousandbyneCount * 10000))
            player:setCharVar('Dynamis_Currency[1449]', windurstCurrencyTotal + whiteshellCount + (jadeshellCount * 100) + (stripeshellCount * 10000))

            npc:facePlayer(player)
            player:printToPlayer('Ahko Mewlmirih: I have tallied the currency you traded me and stored it in your bank.', xi.msg.channel.NS_SAY)


            player:printToPlayer('You now have '.. sandoriaCurrencyTotal + bronzepieceCount + (silverpieceCount * 100) + (goldpieceCount * 10000) ..' Bronzepieces stored.', xi.msg.channel.NS_SAY)
            player:printToPlayer('You now have '.. bastokCurrencyTotal + onebyneCount + (onehundredbyneCount * 100) + (onethousandbyneCount * 10000) ..' Bynes stored.', xi.msg.channel.NS_SAY)
            player:printToPlayer('You now have '.. windurstCurrencyTotal + whiteshellCount + (jadeshellCount * 100) + (stripeshellCount * 10000) ..' Whiteshells stored.', xi.msg.channel.NS_SAY)


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
local page10 = {}
local page11 = {}
local page12 = {}
local page13 = {}


StringifyPrice = function(n)
    return tostring(math.floor(n)):reverse():gsub('(%d%d%d)','%1,')
    :gsub(',(%-?)$','%1'):reverse()
end

npc:facePlayer(player)

local delaySendMenu = function(player)
    player:timer(50, function(playerArg)
        playerArg:customMenu(menu)
    end)
end

menu =
{
    title = 'Currency Withdrawal',
    options = {},
}

-- Currency Catagory Menu
page1 =
{
    {   
        'SandOria Currency',
        function(playerArg)
                menu.options = page2
                currencyTotal = playerArg:getCharVar('Dynamis_Currency[1452]')
                playerArg:printToPlayer('You currently have '.. currencyTotal ..' Bronzepieces stored.', xi.msg.channel.NS_SAY)
                delaySendMenu(playerArg) 
        end,
    },

    {
        'Bastok Currency',
        function(playerArg)
                menu.options = page6
                currencyTotal = playerArg:getCharVar('Dynamis_Currency[1455]')
                playerArg:printToPlayer('You currently have '.. currencyTotal ..' Bynes stored.', xi.msg.channel.NS_SAY)
                delaySendMenu(playerArg)
        end,
    },

    {
        'Windurst Currency',
        function(playerArg)
                menu.options = page10
                currencyTotal = playerArg:getCharVar('Dynamis_Currency[1449]')
                playerArg:printToPlayer('You currently have '.. currencyTotal ..' Whiteshells stored.', xi.msg.channel.NS_SAY)
                delaySendMenu(playerArg) 
        end,
    },

    {
        'Exit',
        function(playerArg)
        end,
    },
}

 -- Sandoria Currency Denominations
page2 =
{
    {
        'Ordelle Bronzepieces',
        function(playerArg)
            menu.options = page3
            delaySendMenu(playerArg)
        end,
    },

    {
        'Montiont Silverpieces',
        function(playerArg)
            menu.options = page4
            delaySendMenu(playerArg)
        end,
    },

    {
        'Ranperre Goldpieces',
        function(playerArg)
            menu.options = page5
            delaySendMenu(playerArg)
        end,
    },

    {
        'Previous Page',
        function(playerArg)
            menu.options = page1
            delaySendMenu(playerArg)
        end,
    },
}

-- Sandoria Currency Singles Withdrawl Amount
page3 = 
{
    {
        'Ordelle Bronzepiece (1)',
        function(playerArg)
            quantity      = 1
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1452]')
            newTotal      = currencyTotal - quantity
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= quantity then
                playerArg:addItem(xi.item.ORDELLE_BRONZEPIECE, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.ORDELLE_BRONZEPIECE, quantity)
                playerArg:setCharVar('Dynamis_Currency[1452]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' Ordelle Bronzepieces. You have ('.. newTotal ..') bronzepieces remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' Ordelle Bronzepiece is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.ORDELLE_BRONZEPIECE)
            end
            menu.options = page3
            delaySendMenu(playerArg)
        end,
    },

    {
        'Ordelle Bronzepiece (5)',
        function(playerArg)
            quantity      = 5
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1452]')
            newTotal      = currencyTotal - quantity
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= quantity then
                playerArg:addItem(xi.item.ORDELLE_BRONZEPIECE, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.ORDELLE_BRONZEPIECE, quantity)
                playerArg:setCharVar('Dynamis_Currency[1452]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' Ordelle Bronzepieces. You have ('.. newTotal ..') bronzepieces remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' Ordelle Bronzepiece is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.ORDELLE_BRONZEPIECE)
            end
            menu.options = page3
            delaySendMenu(playerArg)
        end,
    },

    {
        'Ordelle Bronzepiece (10)',
        function(playerArg)
            quantity      = 10
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1452]')
            newTotal      = currencyTotal - quantity
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= quantity then
                playerArg:addItem(xi.item.ORDELLE_BRONZEPIECE, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.ORDELLE_BRONZEPIECE, quantity)
                playerArg:setCharVar('Dynamis_Currency[1452]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' Ordelle Bronzepieces. You have ('.. newTotal ..') bronzepieces remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' Ordelle Bronzepiece is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.ORDELLE_BRONZEPIECE)
            end
            menu.options = page3
            delaySendMenu(playerArg)
        end,
    },

    {
        'Previous Page',
        function(playerArg)
            menu.options = page2
            delaySendMenu(playerArg)
        end,
    },
}

-- Sandoria Currency Singles Withdrawl Amount
page4 = 
{
    {
        'Montiont Silverpiece (1)',
        function(playerArg)
            quantity      = 1
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1452]')
            newTotal      = currencyTotal - quantity * 100
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= (quantity * 100) then
                playerArg:addItem(xi.item.MONTIONT_SILVERPIECE, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.MONTIONT_SILVERPIECE, quantity)
                playerArg:setCharVar('Dynamis_Currency[1452]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' Montiont Silverpiece. You have ('.. newTotal ..') Ordelle Bronzepieces remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' Montiont Silverpiece is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.MONTIONT_SILVERPIECE)
            end
            menu.options = page4
            delaySendMenu(playerArg)
        end,
    },

    {
        'Montiont Silverpiece (5)',
        function(playerArg)
            quantity      = 5
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1452]')
            newTotal      = currencyTotal - quantity * 100
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= (quantity * 100) then
                playerArg:addItem(xi.item.MONTIONT_SILVERPIECE, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.MONTIONT_SILVERPIECE, quantity)
                playerArg:setCharVar('Dynamis_Currency[1452]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' Montiont Silverpieces. You have ('.. newTotal ..') Ordelle Bronzepieces remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' Montiont Silverpieces is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.MONTIONT_SILVERPIECE)
            end
            menu.options = page4
            delaySendMenu(playerArg)
        end,
    },

    {
        'Montiont Silverpiece (10)',
        function(playerArg)
            quantity      = 10
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1452]')
            newTotal      = currencyTotal - quantity * 100
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= (quantity * 100) then
                playerArg:addItem(xi.item.MONTIONT_SILVERPIECE, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.MONTIONT_SILVERPIECE, quantity)
                playerArg:setCharVar('Dynamis_Currency[1452]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' Montiont Silverpieces. You have ('.. newTotal ..') Ordelle Bronzepieces remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' Montiont Silverpieces is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.MONTIONT_SILVERPIECE)
            end
            menu.options = page4
            delaySendMenu(playerArg)
        end,
    },

    {
        'Previous Page',
        function(playerArg)
            menu.options = page2
            delaySendMenu(playerArg)
        end,
    },
}

-- Sandoria Currency Thousand Withdrawl Amount
page5 = 
{
    {
        'Ranperre Goldpiece (1)',
        function(playerArg)
            quantity      = 1
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1452]')
            newTotal      = currencyTotal - quantity * 10000
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= (quantity * 10000) then
                playerArg:addItem(xi.item.RANPERRE_GOLDPIECE, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.RANPERRE_GOLDPIECE, quantity)
                playerArg:setCharVar('Dynamis_Currency[1452]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' Ranperre Goldpiece. You have ('.. newTotal ..') Ordelle Bronzepieces remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' Ranperre Goldpiece is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.RANPERRE_GOLDPIECE)
            end
            menu.options = page5
            delaySendMenu(playerArg)
        end,
    },

    {
        'Previous Page',
        function(playerArg)
            menu.options = page2
            delaySendMenu(playerArg)
        end,
    },
}

 -- Bastok Currency Denominations
page6 =
{
    {
        'One Byne Bills',
        function(playerArg)
            menu.options = page7
            delaySendMenu(playerArg)
        end,
    },

    {
        'One Hundred Byne Bills',
        function(playerArg)
            menu.options = page8
            delaySendMenu(playerArg)
        end,
    },

    {
        'Ten Thousand Byne Bills',
        function(playerArg)
            menu.options = page9
            delaySendMenu(playerArg)
        end,
    },

    {
        'Previous Page',
        function(playerArg)
            menu.options = page1
            delaySendMenu(playerArg)
        end,
    },
}

-- Bastok Currency Singles Withdrawl Amount
page7 = 
{
    {
        'One Byne Bill (1)',
        function(playerArg)
            quantity      = 1
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1455]')
            newTotal      = currencyTotal - quantity
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= quantity then
                playerArg:addItem(xi.item.ONE_BYNE_BILL, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.ONE_BYNE_BILL, quantity)
                playerArg:setCharVar('Dynamis_Currency[1455]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' One Byne Bills. You have ('.. newTotal ..') Byne Bills remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' One Byne Bill is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.ONE_BYNE_BILL)
            end
            menu.options = page7
            delaySendMenu(playerArg)
        end,
    },

    {
        'One Byne Bill (5)',
        function(playerArg)
            quantity      = 5
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1455]')
            newTotal      = currencyTotal - quantity
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= quantity then
                playerArg:addItem(xi.item.ONE_BYNE_BILL, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.ONE_BYNE_BILL, quantity)
                playerArg:setCharVar('Dynamis_Currency[1455]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' One Byne Bills. You have ('.. newTotal ..') Byne Bills remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' One Byne Bills is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.ONE_BYNE_BILL)
            end
            menu.options = page7
            delaySendMenu(playerArg)
        end,
    },

    {
        'One Byne Bill (10)',
        function(playerArg)
            quantity      = 10
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1455]')
            newTotal      = currencyTotal - quantity
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= quantity then
                playerArg:addItem(xi.item.ONE_BYNE_BILL, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.ONE_BYNE_BILL, quantity)
                playerArg:setCharVar('Dynamis_Currency[1455]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' One Byne Bills. You have ('.. newTotal ..') Byne Bills remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' One Byne Bills is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.ONE_BYNE_BILL)
            end
            menu.options = page7
            delaySendMenu(playerArg)
        end,
    },

    {
        'Previous Page',
        function(playerArg)
            menu.options = page6
            delaySendMenu(playerArg)
        end,
    },
}

-- Bastok Currency Singles Withdrawl Amount
page8 = 
{
    {
        'One Hundred Byne Bill (1)',
        function(playerArg)
            quantity      = 1
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1455]')
            newTotal      = currencyTotal - quantity * 100
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= (quantity * 100) then
                playerArg:addItem(xi.item.ONE_HUNDRED_BYNE_BILL, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.ONE_HUNDRED_BYNE_BILL, quantity)
                playerArg:setCharVar('Dynamis_Currency[1455]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' One Hundred Byne Bills. You have ('.. newTotal ..') Byne Bills remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' One Hundred Byne Bill is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.ONE_HUNDRED_BYNE_BILL)
            end
            menu.options = page8
            delaySendMenu(playerArg)
        end,
    },

    {
        'One Hundred Byne Bill (5)',
        function(playerArg)
            quantity      = 5
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1455]')
            newTotal      = currencyTotal - quantity * 100
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= (quantity * 100) then
                playerArg:addItem(xi.item.ONE_HUNDRED_BYNE_BILL, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.ONE_HUNDRED_BYNE_BILL, quantity)
                playerArg:setCharVar('Dynamis_Currency[1455]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' One Hundred Byne Bills. You have ('.. newTotal ..') Byne Bills remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' One Hundred Byne Bills is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.ONE_HUNDRED_BYNE_BILL)
            end
            menu.options = page8
            delaySendMenu(playerArg)
        end,
    },

    {
        'One Hundred Byne Bill (10)',
        function(playerArg)
            quantity      = 10
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1455]')
            newTotal      = currencyTotal - quantity * 100
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= (quantity * 100) then
                playerArg:addItem(xi.item.ONE_HUNDRED_BYNE_BILL, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.ONE_HUNDRED_BYNE_BILL, quantity)
                playerArg:setCharVar('Dynamis_Currency[1455]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' One Hundred Byne Bills. You have ('.. newTotal ..') Byne Bills remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' One Hundred Byne Bills is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.ONE_HUNDRED_BYNE_BILL)
            end
            menu.options = page8
            delaySendMenu(playerArg)
        end,
    },

    {
        'Previous Page',
        function(playerArg)
            menu.options = page6
            delaySendMenu(playerArg)
        end,
    },
}

-- Bastok Currency Thousand Withdrawl Amount
page9 = 
{
    {
        'Ten Thousand Byne Bill (1)',
        function(playerArg)
            quantity      = 1
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1455]')
            newTotal      = currencyTotal - quantity * 10000
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= (quantity * 10000) then
                playerArg:addItem(xi.item.TEN_THOUSAND_BYNE_BILL, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.TEN_THOUSAND_BYNE_BILL, quantity)
                playerArg:setCharVar('Dynamis_Currency[1455]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' Ten Thousand Byne Bill. You have ('.. newTotal ..') Byne Bills remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' Ten Thousand Byne Bill is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.TEN_THOUSAND_BYNE_BILL)
            end
            menu.options = page9
            delaySendMenu(playerArg)
        end,
    },

    {
        'Previous Page',
        function(playerArg)
            menu.options = page6
            delaySendMenu(playerArg)
        end,
    },
}

-- Windurst Currency Denominations
page10 =
{
    {
        'Tukuku Whiteshells',
        function(playerArg)
            menu.options = page11
            delaySendMenu(playerArg)
        end,
    },

    {
        'Lungo Nango Jadeshell',
        function(playerArg)
            menu.options = page12
            delaySendMenu(playerArg)
        end,
    },

    {
        'Rimilala Stripeshell',
        function(playerArg)
            menu.options = page13
            delaySendMenu(playerArg)
        end,
    },

    {
        'Previous Page',
        function(playerArg)
            menu.options = page1
            delaySendMenu(playerArg)
        end,
    },
}

-- Windurst Currency Singles Withdrawl Amount
page11 = 
{
    {
        'Tukuku Whiteshell (1)',
        function(playerArg)
            quantity      = 1
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1449]')
            newTotal      = currencyTotal - quantity
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= quantity then
                playerArg:addItem(xi.item.TUKUKU_WHITESHELL, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.TUKUKU_WHITESHELL, quantity)
                playerArg:setCharVar('Dynamis_Currency[1449]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' Tukuku Whiteshells. You have ('.. newTotal ..') Tukuku Whiteshells remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' Tukuku Whiteshells is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.TUKUKU_WHITESHELL)
            end
            menu.options = page11
            delaySendMenu(playerArg)
        end,
    },

    {
        'Tukuku Whiteshell (5)',
        function(playerArg)
            quantity      = 5
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1449]')
            newTotal      = currencyTotal - quantity
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= quantity then
                playerArg:addItem(xi.item.TUKUKU_WHITESHELL, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.TUKUKU_WHITESHELL, quantity)
                playerArg:setCharVar('Dynamis_Currency[1449]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' Tukuku Whiteshells. You have ('.. newTotal ..') Tukuku Whiteshells remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' Tukuku Whiteshells is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.TUKUKU_WHITESHELL)
            end
            menu.options = page11
            delaySendMenu(playerArg)
        end,
    },

    {
        'Tukuku Whiteshell (10)',
        function(playerArg)
            quantity      = 10
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1449]')
            newTotal      = currencyTotal - quantity
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= quantity then
                playerArg:addItem(xi.item.TUKUKU_WHITESHELL, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.TUKUKU_WHITESHELL, quantity)
                playerArg:setCharVar('Dynamis_Currency[1449]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' Tukuku Whiteshells. You have ('.. newTotal ..') Tukuku Whiteshells remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' Tukuku Whiteshells is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.TUKUKU_WHITESHELL)
            end
            menu.options = page11
            delaySendMenu(playerArg)
        end,
    },

    {
        'Previous Page',
        function(playerArg)
            menu.options = page10
            delaySendMenu(playerArg)
        end,
    },
}

-- Windurst Currency Hundreds Withdrawl Amount
page12 = 
{
    {
        'Lungo Nango Jadeshell (1)',
        function(playerArg)
            quantity      = 1
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1449]')
            newTotal      = currencyTotal - quantity * 100
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= (quantity * 100) then
                playerArg:addItem(xi.item.LUNGO_NANGO_JADESHELL, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.LUNGO_NANGO_JADESHELL, quantity)
                playerArg:setCharVar('Dynamis_Currency[1449]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' Lungo Nango Jadeshells. You have ('.. newTotal ..') Tukuku Whiteshells remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' Lungo Nango Jadeshells is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.LUNGO_NANGO_JADESHELL)
            end
            menu.options = page12
            delaySendMenu(playerArg)
        end,
    },

    {
        'Lungo Nango Jadeshell (5)',
        function(playerArg)
            quantity      = 5
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1449]')
            newTotal      = currencyTotal - quantity * 100
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= (quantity * 100) then
                playerArg:addItem(xi.item.LUNGO_NANGO_JADESHELL, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.LUNGO_NANGO_JADESHELL, quantity)
                playerArg:setCharVar('Dynamis_Currency[1449]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' Lungo Nango Jadeshells. You have ('.. newTotal ..') Tukuku Whiteshells remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' Lungo Nango Jadeshells is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.LUNGO_NANGO_JADESHELL)
            end
            menu.options = page12
            delaySendMenu(playerArg)
        end,
    },

    {
        'Lungo Nango Jadeshell (10)',
        function(playerArg)
            quantity      = 10
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1449]')
            newTotal      = currencyTotal - quantity * 100
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= (quantity * 100) then
                playerArg:addItem(xi.item.LUNGO_NANGO_JADESHELL, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.LUNGO_NANGO_JADESHELL, quantity)
                playerArg:setCharVar('Dynamis_Currency[1449]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' Lungo Nango Jadeshells. You have ('.. newTotal ..') Tukuku Whiteshells remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' Lungo Nango Jadeshells is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.LUNGO_NANGO_JADESHELL)
            end
            menu.options = page12
            delaySendMenu(playerArg)
        end,
    },

    {
        'Previous Page',
        function(playerArg)
            menu.options = page10
            delaySendMenu(playerArg)
        end,
    },
}

-- Windurst Currency Thousand Withdrawl Amount
page13 = 
{
    {
        'Rimilala Stripeshell (1)',
        function(playerArg)
            quantity      = 1
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1449]')
            newTotal      = currencyTotal - quantity * 10000
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= (quantity * 10000) then
                playerArg:addItem(xi.item.RIMILALA_STRIPESHELL, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.RIMILALA_STRIPESHELL, quantity)
                playerArg:setCharVar('Dynamis_Currency[1449]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' Rimilala Stripeshells. You have ('.. newTotal ..') Tukuku Whiteshells remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' Rimilala Stripeshells is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.RIMILALA_STRIPESHELL)
            end
            menu.options = page13
            delaySendMenu(playerArg)
        end,
    },

    {
        'Previous Page',
        function(playerArg)
            menu.options = page10
            delaySendMenu(playerArg)
        end,
    },
}


menu.options = page1
delaySendMenu(player)
        end,
    })

end)

m:addOverride('xi.zones.RuLude_Gardens.Zone.onInitialize', function(zone)

    super(zone)
    
        local CurrencyNPC = zone:insertDynamicEntity({
        
        objtype = xi.objType.NPC,
    
        name = 'Siggurd',

        look = '0x0100020117101720A33017401750156000700080',

        x = 52.992,
        y = 9.000,
        z = -52.996,

        rotation = 127,

        widescan = 1,

        onTrade = function(player, npc, trade)
            bronzepieceCount = trade:getItemQty(xi.item.ORDELLE_BRONZEPIECE)
            silverpieceCount = trade:getItemQty(xi.item.MONTIONT_SILVERPIECE)
            goldpieceCount = trade:getItemQty(xi.item.RANPERRE_GOLDPIECE)

            onebyneCount = trade:getItemQty(xi.item.ONE_BYNE_BILL)
            onehundredbyneCount = trade:getItemQty(xi.item.ONE_HUNDRED_BYNE_BILL)
            onethousandbyneCount = trade:getItemQty(xi.item.TEN_THOUSAND_BYNE_BILL)

            whiteshellCount = trade:getItemQty(xi.item.TUKUKU_WHITESHELL)
            jadeshellCount = trade:getItemQty(xi.item.LUNGO_NANGO_JADESHELL)
            stripeshellCount = trade:getItemQty(xi.item.RIMILALA_STRIPESHELL)

            sandoriaCurrencyTotal = player:getCharVar('Dynamis_Currency[1452]')
            bastokCurrencyTotal = player:getCharVar('Dynamis_Currency[1455]')
            windurstCurrencyTotal = player:getCharVar('Dynamis_Currency[1449]')
            
            trade:confirmItem(xi.item.ORDELLE_BRONZEPIECE, bronzepieceCount)
            trade:confirmItem(xi.item.MONTIONT_SILVERPIECE, silverpieceCount)
            trade:confirmItem(xi.item.RANPERRE_GOLDPIECE, goldpieceCount)

            trade:confirmItem(xi.item.ONE_BYNE_BILL, onebyneCount)
            trade:confirmItem(xi.item.ONE_HUNDRED_BYNE_BILL, onehundredbyneCount)
            trade:confirmItem(xi.item.TEN_THOUSAND_BYNE_BILL, onethousandbyneCount)

            trade:confirmItem(xi.item.TUKUKU_WHITESHELL, whiteshellCount)
            trade:confirmItem(xi.item.LUNGO_NANGO_JADESHELL, jadeshellCount)
            trade:confirmItem(xi.item.RIMILALA_STRIPESHELL, stripeshellCount)
            
            player:confirmTrade()

            -- For auditing
            sandoriaCurrencyTraded = bronzepieceCount + (silverpieceCount * 100) + (goldpieceCount * 10000)
            bastokCurrencyTraded   = onebyneCount + (onehundredbyneCount * 100) + (onethousandbyneCount * 10000)
            windurstCurrencyTraded = whiteshellCount + (jadeshellCount * 100) + (stripeshellCount * 10000)
            print("[AUDIT] Traded Dynamis Currency",  "Player:",player:getName(), player:getID(), "Sandoria:",sandoriaCurrencyTraded, "Bastok:",bastokCurrencyTraded, "Windurst:",windurstCurrencyTraded)

            player:setCharVar('Dynamis_Currency[1452]', sandoriaCurrencyTotal + bronzepieceCount + (silverpieceCount * 100) + (goldpieceCount * 10000))
            player:setCharVar('Dynamis_Currency[1455]', bastokCurrencyTotal + onebyneCount + (onehundredbyneCount * 100) + (onethousandbyneCount * 10000))
            player:setCharVar('Dynamis_Currency[1449]', windurstCurrencyTotal + whiteshellCount + (jadeshellCount * 100) + (stripeshellCount * 10000))

            npc:facePlayer(player)
            player:printToPlayer('Siggurd: I have tallied the currency you traded me and stored it in your bank.', xi.msg.channel.NS_SAY)


            player:printToPlayer('You now have '.. sandoriaCurrencyTotal + bronzepieceCount + (silverpieceCount * 100) + (goldpieceCount * 10000) ..' Bronzepieces stored.', xi.msg.channel.NS_SAY)
            player:printToPlayer('You now have '.. bastokCurrencyTotal + onebyneCount + (onehundredbyneCount * 100) + (onethousandbyneCount * 10000) ..' Bynes stored.', xi.msg.channel.NS_SAY)
            player:printToPlayer('You now have '.. windurstCurrencyTotal + whiteshellCount + (jadeshellCount * 100) + (stripeshellCount * 10000) ..' Whiteshells stored.', xi.msg.channel.NS_SAY)


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
local page10 = {}
local page11 = {}
local page12 = {}
local page13 = {}


StringifyPrice = function(n)
    return tostring(math.floor(n)):reverse():gsub('(%d%d%d)','%1,')
    :gsub(',(%-?)$','%1'):reverse()
end

npc:facePlayer(player)

local delaySendMenu = function(player)
    player:timer(50, function(playerArg)
        playerArg:customMenu(menu)
    end)
end

menu =
{
    title = 'Currency Withdrawal',
    options = {},
}

-- Currency Catagory Menu
page1 =
{
    {   
        'SandOria Currency',
        function(playerArg)
                menu.options = page2
                currencyTotal = playerArg:getCharVar('Dynamis_Currency[1452]')
                playerArg:printToPlayer('You currently have '.. currencyTotal ..' Bronzepieces stored.', xi.msg.channel.NS_SAY)
                delaySendMenu(playerArg) 
        end,
    },

    {
        'Bastok Currency',
        function(playerArg)
                menu.options = page6
                currencyTotal = playerArg:getCharVar('Dynamis_Currency[1455]')
                playerArg:printToPlayer('You currently have '.. currencyTotal ..' Bynes stored.', xi.msg.channel.NS_SAY)
                delaySendMenu(playerArg)
        end,
    },

    {
        'Windurst Currency',
        function(playerArg)
                menu.options = page10
                currencyTotal = playerArg:getCharVar('Dynamis_Currency[1449]')
                playerArg:printToPlayer('You currently have '.. currencyTotal ..' Whiteshells stored.', xi.msg.channel.NS_SAY)
                delaySendMenu(playerArg) 
        end,
    },

    {
        'Exit',
        function(playerArg)
        end,
    },
}

 -- Sandoria Currency Denominations
page2 =
{
    {
        'Ordelle Bronzepieces',
        function(playerArg)
            menu.options = page3
            delaySendMenu(playerArg)
        end,
    },

    {
        'Montiont Silverpieces',
        function(playerArg)
            menu.options = page4
            delaySendMenu(playerArg)
        end,
    },

    {
        'Ranperre Goldpieces',
        function(playerArg)
            menu.options = page5
            delaySendMenu(playerArg)
        end,
    },

    {
        'Previous Page',
        function(playerArg)
            menu.options = page1
            delaySendMenu(playerArg)
        end,
    },
}

-- Sandoria Currency Singles Withdrawl Amount
page3 = 
{
    {
        'Ordelle Bronzepiece (1)',
        function(playerArg)
            quantity      = 1
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1452]')
            newTotal      = currencyTotal - quantity
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= quantity then
                playerArg:addItem(xi.item.ORDELLE_BRONZEPIECE, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.ORDELLE_BRONZEPIECE, quantity)
                playerArg:setCharVar('Dynamis_Currency[1452]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' Ordelle Bronzepieces. You have ('.. newTotal ..') bronzepieces remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' Ordelle Bronzepiece is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.ORDELLE_BRONZEPIECE)
            end
            menu.options = page3
            delaySendMenu(playerArg)
        end,
    },

    {
        'Ordelle Bronzepiece (5)',
        function(playerArg)
            quantity      = 5
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1452]')
            newTotal      = currencyTotal - quantity
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= quantity then
                playerArg:addItem(xi.item.ORDELLE_BRONZEPIECE, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.ORDELLE_BRONZEPIECE, quantity)
                playerArg:setCharVar('Dynamis_Currency[1452]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' Ordelle Bronzepieces. You have ('.. newTotal ..') bronzepieces remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' Ordelle Bronzepiece is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.ORDELLE_BRONZEPIECE)
            end
            menu.options = page3
            delaySendMenu(playerArg)
        end,
    },

    {
        'Ordelle Bronzepiece (10)',
        function(playerArg)
            quantity      = 10
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1452]')
            newTotal      = currencyTotal - quantity
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= quantity then
                playerArg:addItem(xi.item.ORDELLE_BRONZEPIECE, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.ORDELLE_BRONZEPIECE, quantity)
                playerArg:setCharVar('Dynamis_Currency[1452]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' Ordelle Bronzepieces. You have ('.. newTotal ..') bronzepieces remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' Ordelle Bronzepiece is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.ORDELLE_BRONZEPIECE)
            end
            menu.options = page3
            delaySendMenu(playerArg)
        end,
    },

    {
        'Previous Page',
        function(playerArg)
            menu.options = page2
            delaySendMenu(playerArg)
        end,
    },
}

-- Sandoria Currency Singles Withdrawl Amount
page4 = 
{
    {
        'Montiont Silverpiece (1)',
        function(playerArg)
            quantity      = 1
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1452]')
            newTotal      = currencyTotal - quantity * 100
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= (quantity * 100) then
                playerArg:addItem(xi.item.MONTIONT_SILVERPIECE, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.MONTIONT_SILVERPIECE, quantity)
                playerArg:setCharVar('Dynamis_Currency[1452]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' Montiont Silverpiece. You have ('.. newTotal ..') Ordelle Bronzepieces remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' Montiont Silverpiece is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.MONTIONT_SILVERPIECE)
            end
            menu.options = page4
            delaySendMenu(playerArg)
        end,
    },

    {
        'Montiont Silverpiece (5)',
        function(playerArg)
            quantity      = 5
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1452]')
            newTotal      = currencyTotal - quantity * 100
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= (quantity * 100) then
                playerArg:addItem(xi.item.MONTIONT_SILVERPIECE, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.MONTIONT_SILVERPIECE, quantity)
                playerArg:setCharVar('Dynamis_Currency[1452]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' Montiont Silverpieces. You have ('.. newTotal ..') Ordelle Bronzepieces remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' Montiont Silverpieces is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.MONTIONT_SILVERPIECE)
            end
            menu.options = page4
            delaySendMenu(playerArg)
        end,
    },

    {
        'Montiont Silverpiece (10)',
        function(playerArg)
            quantity      = 10
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1452]')
            newTotal      = currencyTotal - quantity * 100
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= (quantity * 100) then
                playerArg:addItem(xi.item.MONTIONT_SILVERPIECE, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.MONTIONT_SILVERPIECE, quantity)
                playerArg:setCharVar('Dynamis_Currency[1452]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' Montiont Silverpieces. You have ('.. newTotal ..') Ordelle Bronzepieces remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' Montiont Silverpieces is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.MONTIONT_SILVERPIECE)
            end
            menu.options = page4
            delaySendMenu(playerArg)
        end,
    },

    {
        'Previous Page',
        function(playerArg)
            menu.options = page2
            delaySendMenu(playerArg)
        end,
    },
}

-- Sandoria Currency Thousand Withdrawl Amount
page5 = 
{
    {
        'Ranperre Goldpiece (1)',
        function(playerArg)
            quantity      = 1
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1452]')
            newTotal      = currencyTotal - quantity * 10000
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= (quantity * 10000) then
                playerArg:addItem(xi.item.RANPERRE_GOLDPIECE, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.RANPERRE_GOLDPIECE, quantity)
                playerArg:setCharVar('Dynamis_Currency[1452]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' Ranperre Goldpiece. You have ('.. newTotal ..') Ordelle Bronzepieces remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' Ranperre Goldpiece is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.RANPERRE_GOLDPIECE)
            end
            menu.options = page5
            delaySendMenu(playerArg)
        end,
    },

    {
        'Previous Page',
        function(playerArg)
            menu.options = page2
            delaySendMenu(playerArg)
        end,
    },
}

 -- Bastok Currency Denominations
page6 =
{
    {
        'One Byne Bills',
        function(playerArg)
            menu.options = page7
            delaySendMenu(playerArg)
        end,
    },

    {
        'One Hundred Byne Bills',
        function(playerArg)
            menu.options = page8
            delaySendMenu(playerArg)
        end,
    },

    {
        'Ten Thousand Byne Bills',
        function(playerArg)
            menu.options = page9
            delaySendMenu(playerArg)
        end,
    },

    {
        'Previous Page',
        function(playerArg)
            menu.options = page1
            delaySendMenu(playerArg)
        end,
    },
}

-- Bastok Currency Singles Withdrawl Amount
page7 = 
{
    {
        'One Byne Bill (1)',
        function(playerArg)
            quantity      = 1
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1455]')
            newTotal      = currencyTotal - quantity
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= quantity then
                playerArg:addItem(xi.item.ONE_BYNE_BILL, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.ONE_BYNE_BILL, quantity)
                playerArg:setCharVar('Dynamis_Currency[1455]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' One Byne Bills. You have ('.. newTotal ..') Byne Bills remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' One Byne Bill is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.ONE_BYNE_BILL)
            end
            menu.options = page7
            delaySendMenu(playerArg)
        end,
    },

    {
        'One Byne Bill (5)',
        function(playerArg)
            quantity      = 5
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1455]')
            newTotal      = currencyTotal - quantity
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= quantity then
                playerArg:addItem(xi.item.ONE_BYNE_BILL, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.ONE_BYNE_BILL, quantity)
                playerArg:setCharVar('Dynamis_Currency[1455]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' One Byne Bills. You have ('.. newTotal ..') Byne Bills remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' One Byne Bills is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.ONE_BYNE_BILL)
            end
            menu.options = page7
            delaySendMenu(playerArg)
        end,
    },

    {
        'One Byne Bill (10)',
        function(playerArg)
            quantity      = 10
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1455]')
            newTotal      = currencyTotal - quantity
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= quantity then
                playerArg:addItem(xi.item.ONE_BYNE_BILL, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.ONE_BYNE_BILL, quantity)
                playerArg:setCharVar('Dynamis_Currency[1455]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' One Byne Bills. You have ('.. newTotal ..') Byne Bills remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' One Byne Bills is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.ONE_BYNE_BILL)
            end
            menu.options = page7
            delaySendMenu(playerArg)
        end,
    },

    {
        'Previous Page',
        function(playerArg)
            menu.options = page6
            delaySendMenu(playerArg)
        end,
    },
}

-- Bastok Currency Singles Withdrawl Amount
page8 = 
{
    {
        'One Hundred Byne Bill (1)',
        function(playerArg)
            quantity      = 1
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1455]')
            newTotal      = currencyTotal - quantity * 100
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= (quantity * 100) then
                playerArg:addItem(xi.item.ONE_HUNDRED_BYNE_BILL, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.ONE_HUNDRED_BYNE_BILL, quantity)
                playerArg:setCharVar('Dynamis_Currency[1455]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' One Hundred Byne Bills. You have ('.. newTotal ..') Byne Bills remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' One Hundred Byne Bill is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.ONE_HUNDRED_BYNE_BILL)
            end
            menu.options = page8
            delaySendMenu(playerArg)
        end,
    },

    {
        'One Hundred Byne Bill (5)',
        function(playerArg)
            quantity      = 5
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1455]')
            newTotal      = currencyTotal - quantity * 100
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= (quantity * 100) then
                playerArg:addItem(xi.item.ONE_HUNDRED_BYNE_BILL, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.ONE_HUNDRED_BYNE_BILL, quantity)
                playerArg:setCharVar('Dynamis_Currency[1455]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' One Hundred Byne Bills. You have ('.. newTotal ..') Byne Bills remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' One Hundred Byne Bills is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.ONE_HUNDRED_BYNE_BILL)
            end
            menu.options = page8
            delaySendMenu(playerArg)
        end,
    },

    {
        'One Hundred Byne Bill (10)',
        function(playerArg)
            quantity      = 10
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1455]')
            newTotal      = currencyTotal - quantity * 100
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= (quantity * 100) then
                playerArg:addItem(xi.item.ONE_HUNDRED_BYNE_BILL, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.ONE_HUNDRED_BYNE_BILL, quantity)
                playerArg:setCharVar('Dynamis_Currency[1455]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' One Hundred Byne Bills. You have ('.. newTotal ..') Byne Bills remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' One Hundred Byne Bills is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.ONE_HUNDRED_BYNE_BILL)
            end
            menu.options = page8
            delaySendMenu(playerArg)
        end,
    },

    {
        'Previous Page',
        function(playerArg)
            menu.options = page6
            delaySendMenu(playerArg)
        end,
    },
}

-- Bastok Currency Thousand Withdrawl Amount
page9 = 
{
    {
        'Ten Thousand Byne Bill (1)',
        function(playerArg)
            quantity      = 1
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1455]')
            newTotal      = currencyTotal - quantity * 10000
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= (quantity * 10000) then
                playerArg:addItem(xi.item.TEN_THOUSAND_BYNE_BILL, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.TEN_THOUSAND_BYNE_BILL, quantity)
                playerArg:setCharVar('Dynamis_Currency[1455]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' Ten Thousand Byne Bill. You have ('.. newTotal ..') Byne Bills remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' Ten Thousand Byne Bill is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.TEN_THOUSAND_BYNE_BILL)
            end
            menu.options = page9
            delaySendMenu(playerArg)
        end,
    },

    {
        'Previous Page',
        function(playerArg)
            menu.options = page6
            delaySendMenu(playerArg)
        end,
    },
}

-- Windurst Currency Denominations
page10 =
{
    {
        'Tukuku Whiteshells',
        function(playerArg)
            menu.options = page11
            delaySendMenu(playerArg)
        end,
    },

    {
        'Lungo Nango Jadeshell',
        function(playerArg)
            menu.options = page12
            delaySendMenu(playerArg)
        end,
    },

    {
        'Rimilala Stripeshell',
        function(playerArg)
            menu.options = page13
            delaySendMenu(playerArg)
        end,
    },

    {
        'Previous Page',
        function(playerArg)
            menu.options = page1
            delaySendMenu(playerArg)
        end,
    },
}

-- Windurst Currency Singles Withdrawl Amount
page11 = 
{
    {
        'Tukuku Whiteshell (1)',
        function(playerArg)
            quantity      = 1
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1449]')
            newTotal      = currencyTotal - quantity
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= quantity then
                playerArg:addItem(xi.item.TUKUKU_WHITESHELL, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.TUKUKU_WHITESHELL, quantity)
                playerArg:setCharVar('Dynamis_Currency[1449]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' Tukuku Whiteshells. You have ('.. newTotal ..') Tukuku Whiteshells remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' Tukuku Whiteshells is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.TUKUKU_WHITESHELL)
            end
            menu.options = page11
            delaySendMenu(playerArg)
        end,
    },

    {
        'Tukuku Whiteshell (5)',
        function(playerArg)
            quantity      = 5
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1449]')
            newTotal      = currencyTotal - quantity
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= quantity then
                playerArg:addItem(xi.item.TUKUKU_WHITESHELL, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.TUKUKU_WHITESHELL, quantity)
                playerArg:setCharVar('Dynamis_Currency[1449]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' Tukuku Whiteshells. You have ('.. newTotal ..') Tukuku Whiteshells remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' Tukuku Whiteshells is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.TUKUKU_WHITESHELL)
            end
            menu.options = page11
            delaySendMenu(playerArg)
        end,
    },

    {
        'Tukuku Whiteshell (10)',
        function(playerArg)
            quantity      = 10
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1449]')
            newTotal      = currencyTotal - quantity
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= quantity then
                playerArg:addItem(xi.item.TUKUKU_WHITESHELL, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.TUKUKU_WHITESHELL, quantity)
                playerArg:setCharVar('Dynamis_Currency[1449]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' Tukuku Whiteshells. You have ('.. newTotal ..') Tukuku Whiteshells remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' Tukuku Whiteshells is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.TUKUKU_WHITESHELL)
            end
            menu.options = page11
            delaySendMenu(playerArg)
        end,
    },

    {
        'Previous Page',
        function(playerArg)
            menu.options = page10
            delaySendMenu(playerArg)
        end,
    },
}

-- Windurst Currency Hundreds Withdrawl Amount
page12 = 
{
    {
        'Lungo Nango Jadeshell (1)',
        function(playerArg)
            quantity      = 1
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1449]')
            newTotal      = currencyTotal - quantity * 100
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= (quantity * 100) then
                playerArg:addItem(xi.item.LUNGO_NANGO_JADESHELL, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.LUNGO_NANGO_JADESHELL, quantity)
                playerArg:setCharVar('Dynamis_Currency[1449]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' Lungo Nango Jadeshells. You have ('.. newTotal ..') Tukuku Whiteshells remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' Lungo Nango Jadeshells is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.LUNGO_NANGO_JADESHELL)
            end
            menu.options = page12
            delaySendMenu(playerArg)
        end,
    },

    {
        'Lungo Nango Jadeshell (5)',
        function(playerArg)
            quantity      = 5
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1449]')
            newTotal      = currencyTotal - quantity * 100
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= (quantity * 100) then
                playerArg:addItem(xi.item.LUNGO_NANGO_JADESHELL, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.LUNGO_NANGO_JADESHELL, quantity)
                playerArg:setCharVar('Dynamis_Currency[1449]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' Lungo Nango Jadeshells. You have ('.. newTotal ..') Tukuku Whiteshells remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' Lungo Nango Jadeshells is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.LUNGO_NANGO_JADESHELL)
            end
            menu.options = page12
            delaySendMenu(playerArg)
        end,
    },

    {
        'Lungo Nango Jadeshell (10)',
        function(playerArg)
            quantity      = 10
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1449]')
            newTotal      = currencyTotal - quantity * 100
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= (quantity * 100) then
                playerArg:addItem(xi.item.LUNGO_NANGO_JADESHELL, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.LUNGO_NANGO_JADESHELL, quantity)
                playerArg:setCharVar('Dynamis_Currency[1449]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' Lungo Nango Jadeshells. You have ('.. newTotal ..') Tukuku Whiteshells remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' Lungo Nango Jadeshells is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.LUNGO_NANGO_JADESHELL)
            end
            menu.options = page12
            delaySendMenu(playerArg)
        end,
    },

    {
        'Previous Page',
        function(playerArg)
            menu.options = page10
            delaySendMenu(playerArg)
        end,
    },
}

-- Windurst Currency Thousand Withdrawl Amount
page13 = 
{
    {
        'Rimilala Stripeshell (1)',
        function(playerArg)
            quantity      = 1
            currencyTotal = playerArg:getCharVar('Dynamis_Currency[1449]')
            newTotal      = currencyTotal - quantity * 10000
            zoneID        = zones[player:getZoneID()]
            if playerArg:getFreeSlotsCount() ~= 0 and currencyTotal >= (quantity * 10000) then
                playerArg:addItem(xi.item.RIMILALA_STRIPESHELL, quantity)
                playerArg:messageSpecial(zoneID.text.ITEM_OBTAINED, xi.item.RIMILALA_STRIPESHELL, quantity)
                playerArg:setCharVar('Dynamis_Currency[1449]', newTotal)
                playerArg:printToPlayer('You withdraw '.. quantity ..' Rimilala Stripeshells. You have ('.. newTotal ..') Tukuku Whiteshells remaining.', xi.msg.channel.SYSTEM_3)
            elseif currencyTotal < quantity then
                playerArg:printToPlayer('Quantity: '.. quantity ..' Rimilala Stripeshells is more than what you have in storage. Unable to withdraw.', xi.msg.channel.SYSTEM_3)
            else
                playerArg:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.RIMILALA_STRIPESHELL)
            end
            menu.options = page13
            delaySendMenu(playerArg)
        end,
    },

    {
        'Previous Page',
        function(playerArg)
            menu.options = page10
            delaySendMenu(playerArg)
        end,
    },
}


menu.options = page1
delaySendMenu(player)
        end,
    })

end)

return m
