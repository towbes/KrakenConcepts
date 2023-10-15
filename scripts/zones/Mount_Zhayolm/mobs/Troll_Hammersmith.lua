-----------------------------------
--   Area: Mount Zhayolm
--    Mob: Troll Hammersmith
-- Author: Spaceballs
--   Note: Pet of Khromasoul Bhurborlor
-----------------------------------
mixins = {require('scripts/mixins/job_special')}

-----------------------------------
local entity = {}

entity.onMobWeaponSkillPrepare = function(mob)
    if math.random() < .5 then
        return 2083
    end
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.REGAIN, 500)
    mob:setMod(xi.mod.LULLABYRES, 100)
    mob:setMod(xi.mod.SLEEPRES, 100)
    mob:setMod(xi.mod.GRAVITYRES, 100)
end
entity.onMobDespawn = function(mob)
end

entity.onMobDeath = function(mob, player, isKiller)
end

entity.onMobRoam = function(mob)
    local ID = zones[xi.zone.MOUNT_ZHAYOLM]
    local mother = GetMobByID(ID.mob.KHROMASOUL_BHURBORLOR)
    if mother:isSpawned() and mother:getCurrentAction() == xi.act.ATTACK then
        mob:updateEnmity(mother:getTarget())
    end
end

return entity