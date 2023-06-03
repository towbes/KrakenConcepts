-- Marid family mixin
require("scripts/globals/mixins")
require("scripts/globals/toau")
-----------------------------------

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.marid = function(mob)
    xi.toau.mobSpecialHook("MARID", mob, 20, function(mob)
        local broken = mob:getLocalVar("TuskBroken")
        if broken < 2 then
            broken = broken + 1
            mob:setLocalVar("TuskBroken", broken)
            mob:setAnimationSub(broken)
        end
    end)

    mob:addListener("DEATH", "MARID_DEATH", function(mob, killer)
        if killer then
            local broken = mob:getLocalVar("TuskBroken")
            if broken >= 1 then
                killer:addTreasure(2147, mob)
                if broken == 2 then
                    killer:addTreasure(2147, mob)
                end
            end
        end
    end)
end

return g_mixins.families.marid
