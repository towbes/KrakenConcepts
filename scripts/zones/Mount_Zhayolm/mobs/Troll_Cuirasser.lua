-----------------------------------
--   Area: Mount Zhayolm
--    Mob: Troll Cuirasser
-- Author: Spaceballs
--   Note: Pet of Khromasoul Bhurborlor
-----------------------------------
mixins = {require('scripts/mixins/job_special')}

-----------------------------------
local entity = {}


entity.onMobSpawn = function(mob)
    mob:setLocalVar('clock', os.time() + math.random(10,30))
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMod(xi.mod.LULLABYRES, 100)
    mob:setMod(xi.mod.SLEEPRES, 100)
    mob:setMod(xi.mod.GRAVITYRES, 100)
end

entity.onAdditionalEffect = function(mob, target, damage)
    -- fudges souleater logic instead of messing with core for the one mob in the game that uses souleater
    -- Note that this doesn't affect mobskill dmg nor does it affect dmg during blood weapon
    if mob:hasStatusEffect(xi.effect.SOULEATER) then
        local hpToDmg = 0
        -- avoid the ability to kill the mob from souleater hp reduction
        if mob:getHPP() > 1 then
            hpToDmg = math.ceil(mob:getHP() * 12 / 100)
            mob:setHP(mob:getHP() - hpToDmg)
        end
        hpToDmg = math.max(hpToDmg, 20) -- Due to resistance checking, best to floor this at 20, and double it went sending dmg
        -- printf('dmg %u', hpToDmg)
        return xi.mob.onAddEffect(mob, target, 2 * hpToDmg, xi.mob.ae.ENDARK)
    end
end


entity.onMobFight = function(mob, target)
    if os.time() >= mob:getLocalVar('clock') then
        mob:useMobAbility(709)
        mob:setLocalVar('clock', os.time() + math.random(65,85))
    end
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