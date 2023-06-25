-----------------------------------
-- func: !menu
-- desc: Player Functions
-- note: title and options are required.
--     : onStart, onCancelled, and onEnd are optional.
--     : You must provide at least one option.
--     : Incorrectly creating or configuring a menu
--     : will not result in a crash or broken menus,
--     : but will produce scary looking warnings in
--     : the log.
-----------------------------------
require("scripts/globals/msg")

---@type CommandSpec
local this = {}

cmdprops =
{
    permission = 0,
    parameters = ""
}

 function onTrigger(player)

    if player:getLocalVar("helpMenu") > 0 then
        player:PrintToPlayer("Menu is already in use.", xi.msg.channel.NS_LINKSHELL3)
        return
    end

    local menu =
    {
        title = "Refund Merits",
        onStart = function(playerArg)
            -- NOTE: This could be used to lock the player in place
            -- playerArg:PrintToPlayer("Help Menu Opening", xi.msg.channel.NS_LINKSHELL3)
            playerArg:setLocalVar("helpMenu", 1)
        end,

        options = {},

        onCancelled = function(playerArg)
            -- playerArg:PrintToPlayer("Help Menu Cancelled", xi.msg.channel.NS_LINKSHELL3)
        end,

        onEnd = function(playerArg)
            -- NOTE: This could be used to release a locked player,
            -- playerArg:PrintToPlayer("Help Menu Closing", xi.msg.channel.NS_LINKSHELL3)
            playerArg:setLocalVar("helpMenu", 0)
        end,
    }

    local refundMerits = player:getVar("refundMerits")
    if refundMerits > 0 then
        table.insert(menu.options, {
            "Refund Merits",
            function(playerArg)
                local currentMerits = playerArg:getMeritCount()
                local totalMerits = currentMerits + refundMerits
                local remainder = 0
                if totalMerits > 30 then
                    remainder = totalMerits - 30
                    totalMerits = 30
                end
                playerArg:setMerits(totalMerits)
                playerArg:setVar("refundMerits", remainder)
                playerArg:PrintToPlayer(string.format("Merits are now set to %i with a remainder or %i left", totalMerits, remainder), xi.msg.channel.NS_LINKSHELL3)
            end,
        })
    end

        table.insert(menu.options, {
            "Exit",
        })

    player:customMenu(menu)
end

return this
