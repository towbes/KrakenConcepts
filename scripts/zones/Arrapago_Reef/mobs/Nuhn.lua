-----------------------------------
--   Area: Arrapago Reef
--    Mob: T3 ZNM - Nuhn
-- Author: Spaceballs
-----------------------------------
mixins ={require('scripts/mixins/job_special'),
require('scripts/mixins/rage')}

-----------------------------------
-- Full disclosure, there JP wiki and NA wiki does mention there being 2 phaes to the fight but I could find 0 video evidence.
-- I have taken some 'artistic liberties', in all the videos I saw Nuhn only spammed Dnash/Deathgnash - so I assumed that maybe 1-5%
-- of the time, he will use Hypnic Lamp instead and go into the other phase.
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
    mob:setMobMod(xi.mobMod.GIL_MIN, 3000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 5000)
    mob:setMod(xi.mod.ATT, 1500)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = xi.jsa.MIGHTY_STRIKES, hpp = -1},
            
        },
    })
end


entity.onMobSpawn = function(mob)
    mob:setLocalVar('[rage]timer', 5400)                 -- 90 minutes
    mob:setLocalVar('Phase', 1)  
    mob:setLocalVar('Changed',0)
    mob:setMobMod(xi.mobMod.SKILL_LIST, 5305) 
end   

entity.onMobFight = function(mob, target)
    if mob:getLocalVar('Changed') == 1 then
        if mob:getLocalVar('Phase') == 2 then  
            mob:setMod(xi.mod.REGAIN, 1000)
            mob:setMobMod(xi.mobMod.SKILL_LIST, 5306)
        else
            mob:setTP(0)
            mob:delMod(xi.mod.REGAIN, 1000)
            mob:setMobMod(xi.mobMod.SKILL_LIST, 5305)
        end
        mob:setLocalVar('Changed', 0)
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
  
end

return entity