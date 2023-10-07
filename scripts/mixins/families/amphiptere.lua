-- Amphiptere family mixin

require('scripts/globals/mixins')

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.amphiptere = function(amphiptereMob)
    amphiptereMob:addListener('SPAWN', 'AMPHIPTERE_SPAWN', function(mob)
        mob:hideName(true)
        mob:setUntargetable(false)
        mob:setAnimationSub(1)
        mob:setMobMod(xi.mobMod.NO_MOVE, 0)
        mob:setAutoAttackEnabled(true)

    end)

    amphiptereMob:addListener('ENGAGE', 'AMPHIPTERE_ENGAGE', function(mob, target)
        mob:hideName(false)
        mob:setUntargetable(false)
        mob:setAnimationSub(0)
    end)

    amphiptereMob:addListener('DISENGAGE', 'AMPHIPTERE_DISENGAGE', function(mob, target)
        mob:hideName(true)
        mob:setUntargetable(true)
        mob:setAnimationSub(1)
    end)
    mob:addListener("COMBAT_TICK", "REAVING_WIND", function(mob)
        local knockback = mob:getLocalVar("knockback")
    
        if mob:getBattleTime() < knockback then
            mob:setAnimationSub(2)
            mob:setMobMod(xi.mobMod.NO_MOVE, 0)
            mob:setAutoAttackEnabled(true)
    
            --local enmityList = mob:getEnmityList()
            --for _,v in ipairs(enmityList) do
                    if mob:getCurrentAction() == xi.act.ATTACK then
                        mob:useMobAbility(2434)
                    end
                --end        
        else
            mob:setLocalVar("knockback", 0) 
            mob:setAnimationSub(0)
            mob:setMobMod(xi.mobMod.NO_MOVE, 0)
            mob:setAutoAttackEnabled(true)
        end
    end)
    mob:addListener("WEAPONSKILL_STATE_EXIT", "SET_RW_DURATION", function(mob, skillID)
        local knockback = mob:getLocalVar("knockback")
        if skillID == 2431 then
            mob:setLocalVar("knockback", mob:getBattleTime() + 20)
        end
    end)
end


return g_mixins.families.amphiptere
