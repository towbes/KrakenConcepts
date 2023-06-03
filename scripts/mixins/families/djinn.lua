-- Dijinn family mixin
require("scripts/globals/mixins")
require("scripts/enum/weather")
-----------------------------------

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.dijinn = function(mob)
    mob:addListener("TAKE_DAMAGE", "DJINN_TAKE_DAMAGE", function(mob, amount, attacker, attackType, damageType)
        local offset = 5 -- Vanadiel Days go from Fire=1 to Dark=8.  DamageType goes from 0 to 13, With Fire=6 and Dark=13
        -- Ignoring attackType.NONE so dot ticks dont trigger
        if (attackType ~= xi.attackType.NONE and VanadielDayElement() + offset == damageType) then
            mob:addTP(1000)
        end
    end)
end

return g_mixins.families.dijinn
