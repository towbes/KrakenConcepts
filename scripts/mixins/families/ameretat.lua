-- Ameretat (sub?)family mixin

require('scripts/globals/mixins')

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

local function getDistBetween(pos1, pos2)
    return math.sqrt((pos1.x - pos2.x) ^ 2 + (pos1.y - pos2.y) ^ 2 + (pos1.z - pos2.z) ^ 2)
end

g_mixins.families.ameretat = function(ameretatMob)
    -- set default to 25 HP Drain per hit, and a 150 HP Regen per tick.
    -- this can be overridden in onMobSpawn()
    ameretatMob:addListener('SPAWN', 'AMERETAT_SPAWN', function(mob)
        mob:setLocalVar('HPDrainPotency', 25)
        mob:setLocalVar('RegenPotency', 150)
    end)

    ameretatMob:addListener('ENGAGE', 'AMERETAT_ENGAGE', function(mob)
        if mob:getLocalVar('HPDrainEnabled') == 0 then
            mob:addMod(xi.mod.REGEN, mob:getLocalVar('RegenPotency'))
        end
    end)

    ameretatMob:addListener('DISENGAGE', 'AMERETAT_DISENGAGE', function(mob)
        if mob:getLocalVar('HPDrainEnabled') == 0 then
            mob:delMod(xi.mod.REGEN, mob:getLocalVar('RegenPotency'))
        end
    end)

    ameretatMob:addListener('COMBAT_TICK', 'AMERETAT_CTICK', function(mob, target)
        local ctCooldown = mob:getLocalVar('ctCooldown')
        if ctCooldown < os.time() then
            mob:setLocalVar('ctCooldown', os.time() + 1)

            -- determine distance and current status to toggle between endrain/regen
            local dist = getDistBetween(mob:getPos(), mob:getSpawnPos())
            local drainEnabled = mob:getLocalVar('HPDrainEnabled')
            local potency = mob:getLocalVar('RegenPotency')

            if dist >= 20 and drainEnabled == 0 then
                mob:setLocalVar('HPDrainEnabled', 1)
                mob:delMod(xi.mod.REGEN, potency)
                mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
            elseif dist < 20 and drainEnabled == 1 then
                mob:setLocalVar('HPDrainEnabled', 0)
                mob:addMod(xi.mod.REGEN, potency)
                mob:setMobMod(xi.mobMod.ADD_EFFECT, 0)
            end
        end
    end)
end

return g_mixins.families.ameretat
