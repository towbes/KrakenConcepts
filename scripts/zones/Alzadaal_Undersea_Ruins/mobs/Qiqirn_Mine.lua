------------------------------------------
-- Qiqirn Mine
--  blows up 8-9 seconds after spawn using entityAnimationPacket mai1
------------------------------------------


local entity = {}

entity.onMobInitialize = function(mob)
--    mob:addListener('ON_AGGRO_PLAYER', 'MINE_AGGRO', function(mob, player)
--        if (mob and mob:isSpawned() and mob:isAlive()) then
--            if (mob:getLocalVar('MineAggro') == 0) then
--                mob:setLocalVar('MineAggro', 1)
--                -- mine blast - 1838
--                mob:useMobAbility(1838, player)
--            end
--        end
--    end)
end
entity.onMobRoam = function(mob)

end

entity.onMobEngage = function(mob, target)
    mob:useMobAbility(1838, target)
    mob:entityAnimationPacket('mai1')
        mob:timer(1100, function(mob)
            DespawnMob(mob:getID())
        end)
end

entity.onMobSpawn = function(mob)
    -- 3 roaming ticks seems to do it
    mob:setLocalVar('SelfDestructCountdown', 3)
    mob:setMod(xi.mod.LULLABYRES, 100)
    mob:setMod(xi.mod.SLEEPRES, 100)
    mob:setMod(xi.mod.STUNRES, 100)
    mob:setUntargetable(false)
    mob:setAutoAttackEnabled(false)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
end

entity.onMobSkillFinished = function(mob, target, skill)
    mob:setHP(0)
    mob:timer(500, function(mob)
        DespawnMob(mob:getID())
    end)
end

entity.onMobDespawn = function(mob)
    mob:setLocalVar('MineAggro', 0)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity