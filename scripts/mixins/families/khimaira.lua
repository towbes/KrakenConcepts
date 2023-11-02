-----------------------------------
-- Khimaira family mixin
require('scripts/globals/mixins')
-----------------------------------

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.khimaira = function(khimairaMob)
    khimairaMob:addListener('CRITICAL_TAKE', 'KHIMARIA_CRITICAL_TAKE', function(mob)
        local random = math.random(1, 100)
        local chance = 1
        if random <= chance then
            if mob:getAnimationSub() == 0 then
                mob:setAnimationSub(1)
            end
        end
     end)

    khimairaMob:addListener('ABILITY_TAKE', 'KHIMARIA_ABILITY_TAKE', function(mob, attacker, ability, action)
        local abilityID = ability:getID()
        local random = math.random(1, 100)
        local chance = 1
        if 
            abilityID == 150 or  -- tomahawk
            abilityID == 46 or   -- shield bash
            abilityID == 77 or   -- weapon bash
            abilityID == 66 or   -- jump
            abilityID == 67 or   -- high jump
            abilityID == 68 or   -- super jump
            abilityID == 202 or  -- box step
            abilityID == 170     -- angon
        then
            if random <= chance then
                if mob:getAnimationSub() == 0 then
                    mob:setAnimationSub(1)
                end
            end
        end
    end)

    khimairaMob:addListener('WEAPONSKILL_TAKE', 'KHIMARIA_WEAPONSKILL_TAKE', function(mob, attacker, skillId, tp, action)
        local random = math.random(1, 100)
        local chance = 1
        if random <= chance then
            if mob:getAnimationSub() == 0 then
                mob:setAnimationSub(1)
            end
        end
    end)
end

return g_mixins.families.khimaira
