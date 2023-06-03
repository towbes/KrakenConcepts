-- Funguar from Shadowreign family mixin

require("scripts/globals/mixins")
require("scripts/enum/weather")

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.funguar_s = function(mob)
    --[[mob:addListener("ITEM_STOLEN", "SHROOM_S_ITEM_STOLEN", function(mob, player, itemId)
        -- remove bulbs on head from successful steals
        local animSum = mob:getAnimationSub()
        if animSum == 0 then
            mob:setAnimationSub(1)
        elseif animSum == 1 then
            mob:setAnimationSub(2)
        elseif animSum == 2 then
            mob:setAnimationSub(3)
        end
    end)--]]

    mob:addListener("COMBAT_TICK", "SHROOM_S_CTICK", function(mob)
        --[[-- adjust steal item based on the animationsub. This is adjusted by either successfully stealing or by the mob using numbshroom or queezyshroom
        local animSum = mob:getAnimationSub()
        if animSum == 0 then
            mob:setStealItemID(4373) -- Woozyshroom
        elseif animSum == 1 then
            mob:setStealItemID(4375) -- Danceshroom
        elseif animSum == 2 then
            mob:setStealItemID(5680) -- Agaricus
        elseif animSum == 3 then
            mob:itemStolen() -- Nothing left to steal
        end--]]

        -- All funguars in shadowreign area have regen in rain weather
        if mob:getWeather() == xi.weather.RAIN or mob:getWeather() == xi.weather.SQUALL then
            mob:setMod(xi.mod.REGEN, 9) -- 1% per 12s from retail capture
        else
            mob:setMod(xi.mod.REGEN, 0)
        end
    end)

    -- All funguars in shadowreign area have regen in rain weather
    mob:addListener("ROAM_TICK", "SHROOM_S_RTICK", function(mob)
        -- All funguars in shadowreign area have regen in rain weather
        if mob:getWeather() == xi.weather.RAIN or mob:getWeather() == xi.weather.SQUALL then
            mob:setMod(xi.mod.REGEN, 9) -- 1% per 12s from retail capture
        else
            mob:setMod(xi.mod.REGEN, 0)
        end
    end)
end

return g_mixins.families.funguar_s

