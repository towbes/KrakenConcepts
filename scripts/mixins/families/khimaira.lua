-----------------------------------
-- Khimaira family mixin
require('scripts/globals/mixins')
-----------------------------------

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.khimaira = function(mob)
    mob:addListener('CRITICAL_TAKE', 'KHIMARIA_CRITICAL_TAKE', function(mob)
        local random = math.random(1, 100)
        local chance = 1
        if math.random(100) <= chance then
            if mob:getAnimationSub() == 0 then
                mob:setAnimationSub(1)
            end
        end
     end)
     mob:addListener('ABILITY_TAKE', 'KHIMARIA_ABILITY_TAKE', function(mob, attacker, ability, action)
        local abilityID = ability:getID()
        local random = math.random(1, 100)
        local chance = 1
        if abilityID == 150      -- tomahawk
        or abilityID == 46       -- shield bash
        or abilityID == 77       -- weapon bash
        or abilityID == 66       -- jump
        or abilityID == 67       -- high jump
        or abilityID == 68       -- super jump
        or abilityID == 202      -- box step
        or abilityID == 170 then -- angon
            if math.random(100) <= chance then
                if mob:getAnimationSub() == 0 then
                    mob:setAnimationSub(1)
                end
            end
        end
     end)
     mob:addListener('WEAPONSKILL_TAKE', 'KHIMARIA_WEAPONSKILL_TAKE', function(mob, attacker, skillId, tp, action)
        local random = math.random(1, 100)
        local chance = 1
        if math.random(100) <= chance then
            if mob:getAnimationSub() == 0 then
                mob:setAnimationSub(1)
            end
        end
    end)
end

return g_mixins.families.khimaira
