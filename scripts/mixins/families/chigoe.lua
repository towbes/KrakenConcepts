-- Chigoe family mixin

require('scripts/globals/mixins')

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.chigoe = function(chigoeMob)
    chigoeMob:addListener('SPAWN', 'CHIGOE_SPAWN', function(mob)
        mob:hideName(true)
        mob:setUntargetable(true)
    end)

    chigoeMob:addListener('ENGAGE', 'CHIGOE_ENGAGE', function(mob, target)
        mob:hideName(false)
        mob:setUntargetable(false)
    end)

    chigoeMob:addListener('DISENGAGE', 'CHIGOE_DISENGAGE', function(mob, target)
        mob:hideName(true)
        mob:setUntargetable(true)
    end)

    chigoeMob:addListener('ABILITY_TAKE', 'CHIGOE_ABILITY_TAKE', function(target, user, ability, action)
        local abilityID = ability:getID()
        if 
        abilityID == 150 or     -- tomahawk
        abilityID == 46 or      -- shield bash
        abilityID == 77 or      -- weapon bash
        abilityID == 66 or      -- jump
        abilityID == 67 or      -- high jump
        abilityID == 68 or      -- super jump
        abilityID == 202 or     -- box step
        abilityID == 170 
        then -- angon
            if target:getHP() > 0 and not target:isNM() then
                target:setMobMod(xi.mobMod.EXP_BONUS, -100)
                target:setMobMod(xi.mobMod.NO_DROPS, 1)
                target:setHP(0)
            end
        end
    end)
    
    chigoeMob:addListener('WEAPONSKILL_TAKE', 'CHIGOE_WEAPONSKILL_TAKE', function(target, user, wsid)
        if target:getHP() > 0 and not target:isNM() then
            target:setMobMod(xi.mobMod.EXP_BONUS, -100)
            target:setMobMod(xi.mobMod.NO_DROPS, 1)
            target:setHP(0)
        end
    end)
end


return g_mixins.families.chigoe
