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

cmdprops =
{
    permission = 0,
    parameters = ""
}

onTrigger = function(player)

    if player:getLocalVar("helpMenu") > 0 then
        player:PrintToPlayer("Menu is already in use.", xi.msg.channel.NS_LINKSHELL3)
        return
    end

    local menu =
    {
        title = "Help Menu",
        onStart = function(playerArg)
           -- NOTE: This could be used to lock the player in place
           -- playerArg:PrintToPlayer("Help Menu Opening", xi.msg.channel.NS_LINKSHELL3)
           -- playerArg:setLocalVar("helpMenu", 1)
        end,

        options = {},

        onCancelled = function(playerArg)
            -- playerArg:PrintToPlayer("Help Menu Cancelled", xi.msg.channel.NS_LINKSHELL3)
        end,

        onEnd = function(playerArg)
            -- NOTE: This could be used to release a locked player,
            -- playerArg:PrintToPlayer("Help Menu Closing", xi.msg.channel.NS_LINKSHELL3)
            -- playerArg:setLocalVar("helpMenu", 0)
        end,
    }
    local Unstuck = player:getVar("Unstuck")
    local UnstuckUses = player:getVar("UnstuckUses")
    if Unstuck ~= 1 then
        table.insert(menu.options, {
            "Unstuck",
            function(playerArg)
                local zone = player:getZoneID()
            if (zone == nil or zone < 0 or zone > 297) then
                playerArg:PrintToPlayer("Unstuck selected but unable to assist", xi.msg.channel.NS_LINKSHELL3)
            elseif zone == 0 then
                playerArg:warp()
            else
                 -- playerArg:PrintToPlayer("Unstuck Selected", xi.msg.channel.NS_LINKSHELL3)
                    uses = UnstuckUses + 1
                    playerArg:setVar("Unstuck", 1)
                    playerArg:setVar("UnstuckUses", uses)
                    playerArg:addStatusEffect(xi.effect.TERROR, 60, 0, 61)
                    if Unstuck == 1 then
                        playerArg:queue(60, function(playerArg)
                        playerArg:setPos(0, 0, 0, 0, zone, true)
                        end)
                    end
                end
            end,
        })
    end

    local Unstuck = player:getVar("Unstuck")
    if Unstuck ~= 0 then
        table.insert(menu.options, {
            "Cancel Unstuck",
            function(playerArg)
             -- playerArg:PrintToPlayer("Unstuck Selected", xi.msg.channel.NS_LINKSHELL3)
                playerArg:setVar("Unstuck", 0)
                playerArg:delStatusEffect(xi.effect.TERROR)
            end,
        })
    end

    local party = player:getParty()
    if #party > 1 then
        table.insert(menu.options, {
            "Reset Party List",
            function(playerArg)
             -- playerArg:PrintToPlayer("Reset Party Selected", xi.msg.channel.NS_LINKSHELL3)
                playerArg:reloadParty()
            end,
        })
    end

    table.insert(menu.options, {
        "Exit",
    })

    player:customMenu(menu)
end

return
