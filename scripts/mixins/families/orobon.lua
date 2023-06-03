-- Orobon family mixin
require("scripts/globals/mixins")
require("scripts/enum/weather")
require("scripts/globals/toau")
-----------------------------------

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.orobon = function(mob)
    xi.toau.mobSpecialHook("OROBON", mob, 10, function(mob)
        local isBroken = mob:getLocalVar("LureBroken")
        if not isBroken and mob:getAnimationSub() == 0 then
            mob:setLocalVar("LureBroken", 1)
            mob:setAnimationSub(1)
        end
    end)

    mob:addListener("DEATH", "OROBON_DEATH", function(mob, killer)
        if mob:getLocalVar("LureBroken") > 0 then
            local numLures = math.random(1,2)
            for _ = 1, numLures do
                killer:addTreasure(2154, mob)
            end
        end
    end)
end

return g_mixins.families.orobon
