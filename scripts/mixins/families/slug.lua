-- Slug from Shadowreign family mixin

require('scripts/globals/mixins')
require('scripts/enum/weather')

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.slug = function(mob)

    mob:addListener('COMBAT_TICK', 'SLUG_CTICK', function(mob)
        -- All slugs have regen in rain weather
        if mob:getWeather() == xi.weather.RAIN or mob:getWeather() == xi.weather.SQUALL then
            mob:setMod(xi.mod.REGEN, 9) -- 1% per 12s from retail capture
        else
            mob:setMod(xi.mod.REGEN, 0)
        end
    end)

    -- All slugs have regen in rain weather
    mob:addListener('ROAM_TICK', 'SLUG_RTICK', function(mob)
        if mob:getWeather() == xi.weather.RAIN or mob:getWeather() == xi.weather.SQUALL then
            mob:setMod(xi.mod.REGEN, 9) -- 1% per 12s from retail capture
        else
            mob:setMod(xi.mod.REGEN, 0)
        end
    end)
end

return g_mixins.families.slug

