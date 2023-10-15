-----------------------------------
--   Area: Aydeewa Subterrane
--    Mob: Nosferatu's Bats
-- Author: Spaceballs
--   Note: Pet of Nosferatu
-----------------------------------
mixins = {require('scripts/mixins/job_special')}

-----------------------------------
local entity = {}
local ID = zones[xi.zone.AYDEEWA_SUBTERRANE]

entity.onMobSpawn = function(mob)
    mob:setAutoAttackEnabled(false)
    mob:setLocalVar('time2die', os.time() + 6 )
    mob:setLocalVar('ws', os.time() + 2 )
    mob:setLocalVar('hit', 0 )
end    

entity.onMobFight = function(mob, target)
    if os.time() >= mob:getLocalVar('time2die') then
        DespawnMob(mob:getID())
    end
    if os.time() >=mob:getLocalVar('ws') and mob:getLocalVar('hit') == 0 then
        if mob:getLocalVar('AF') == 1 then
            mob:useMobAbility(1158) --  turbulence
        else
            mob:useMobAbility(395) -- jet stream
        end
        mob:setLocalVar('hit', 1 )
    end
end

-- Death stuff
entity.onMobDeath = function(mob, player, isKiller)
    if mob:getLocalVar('AF') == 1 then
        GetMobByID(ID.mob.NOSFERATU):setLocalVar('AF', 3)
        mob:setLocalVar('AF', 0) 
    end
end

entity.onMobDespawn = function(mob)
    if mob:getLocalVar('AF') == 1 then
        GetMobByID(ID.mob.NOSFERATU):setLocalVar('AF', 3)
        mob:setLocalVar('AF', 0) 
    end
end

return entity