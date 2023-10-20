local commandObj = {}

commandObj.cmdprops =
{
    permission = 0,
    parameters = ''
}

local function getDaySuffix(day)
    if day == 1 or day == 21 or day == 31 then
        return 'st'
    elseif day == 2 or day == 22 then
        return 'nd'
    elseif day == 3 or day == 23 then
        return 'rd'
    else
        return 'th'
    end
end

commandObj.onTrigger = function(player)
    -- Get the current time in seconds since the epoch
    local currentTime = os.time()

    -- Format the current time using os.date()
    local formattedTime = os.date('%A, %B', currentTime)
    local day = tonumber(os.date('%d', currentTime)) -- Convert to number
    local year = os.date('%Y', currentTime)
    local hour = os.date('%I', currentTime)
    local minute = os.date('%M', currentTime)
    local period = os.date('%p', currentTime)

    local daySuffix = getDaySuffix(day)
    formattedTime = formattedTime .. ' ' .. day .. daySuffix .. ', ' .. year .. ' ' .. hour .. ':' .. minute .. ' ' .. period

    player:PrintToPlayer(formattedTime)
end

return commandObj