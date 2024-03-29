-----------------------------------
-- Area: Dynamis - Valkurm
--  Mob: Stcemqestcint
-----------------------------------
mixins = 
{
    require('scripts/mixins/dynamis_dreamland'),
    require('scripts/mixins/dynamis_beastmen')
}
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setAutoAttackEnabled(true)
    mob:setMobAbilityEnabled(true)
    mob:setMobSkillAttack(5369)
end

entity.onMobWeaponSkillPrepare = function(mob, target)
    mob:setLocalVar('skill_tp', mob:getTP())
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() == 296 then
        mob:addTP(mob:getLocalVar('skill_tp'))
        mob:setLocalVar('skill_tp', 0)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
