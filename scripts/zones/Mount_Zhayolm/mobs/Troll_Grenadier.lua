-----------------------------------
--   Area: Mount Zhayolm
--    Mob: Troll Grenadier
-- Author: Spaceballs
--   Note: Pet of Khromasoul Bhurborlor
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.LULLABYRES, 100)
    mob:setMod(xi.mod.SLEEPRES, 100)
    mob:setMod(xi.mod.GRAVITYRES, 100)
end

entity.onMobDespawn = function(mob)
end

entity.onMobDeath = function(mob, player, isKiller)
end

entity.onMobRoam = function(mob)
    local ID = require("scripts/zones/Mount_Zhayolm/IDs")
    local mother = GetMobByID(ID.mob.KHROMASOUL_BHURBORLOR)
    if mother:isSpawned() and mother:getCurrentAction() == xi.act.ATTACK then
        mob:updateEnmity(mother:getTarget())
    end
end

return entity