-----------------------------------
-- func: !help
-- desc: Opens the Help Menu
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

    local refundMerits = player:getVar("refundMerits")
    if refundMerits > 0 then
        table.insert(menu.options, {
            "Refund Merits" .. "(" .. refundMerits .. ")",
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
                playerArg:PrintToPlayer(string.format("Merits are now set to %i with a balance of %i", totalMerits, remainder), xi.msg.channel.NS_LINKSHELL3)
            end,
        })
    end
    
    local UnstuckUses = player:getVar("UnstuckUses")
    local delay = 1
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
                    playerArg:addStatusEffect(xi.effect.TERROR, delay, 0, delay+1)
                    uses = UnstuckUses + 1
                    playerArg:setVar("UnstuckUses", uses)
                    playerArg:queue(delay, function(playerArg)
                    playerArg:setPos(0, 0, 0, 0, zone, true)
                    end)
                end
            end,
        })

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
