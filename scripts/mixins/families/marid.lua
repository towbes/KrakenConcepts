-- Marid family mixin
require('scripts/globals/mixins')
-----------------------------------

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.marid = function(mob)
    mob:addListener('CRITICAL_TAKE', 'MARID_CRITICAL_TAKE', function(mob)
        local random = math.random(1, 100)
        local chance = 20
        local broken = mob:getLocalVar('TuskBroken')
        if broken < 2 then
            if random <= chance then
                broken = broken + 1
                mob:setLocalVar('TuskBroken', broken)
                mob:setAnimationSub(broken)
            end
        end
    end)

    mob:addListener('DEATH', 'MARID_DEATH', function(mob, killer)
        if killer then
            local broken = mob:getLocalVar('TuskBroken')
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
