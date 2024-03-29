-----------------------------------
-- Area: Dynamis - Valkurm
--  Mob: Lost Nantina
-----------------------------------
mixins = 
{
    require('scripts/mixins/dynamis_dreamland'),
    require('scripts/mixins/dynamis_beastmen')
}
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.HP_SCALE, 1000)
end

entity.onMobSpawn = function(mob)
    mob:setAutoAttackEnabled(false)
    mob:setMobMod(xi.mobMod.SKILL_LIST, 5370)
    mob:setLocalVar('skillOrder', 0) -- 3 Blow, into 3 Uppercut, into 1 Attractant.
end

entity.onMobFight = function(mob, target)
    mob:setMod(xi.mod.REGAIN, 1250)
    for _, member in pairs(target:getParty()) do
        if member:getObjType() == xi.objType.PC then
        member:changeMusic(2, 88)
        member:changeMusic(3, 88)
        end
    end
end

entity.onMobWeaponSkillPrepare = function(mob, target)
    if mob:getLocalVar('skillOrder') == 0 and mob:getTarget() ~= nil and mob:canUseAbilities() and mob:checkDistance(target) < 6 and mob:getCurrentAction() <= 1 then
        mob:setLocalVar('skillOrder', 1)
        return 581
    elseif mob:getLocalVar('skillOrder') == 1 and mob:getTarget() ~= nil and mob:canUseAbilities() and mob:checkDistance(target) < 6 and mob:getCurrentAction() <= 1 then
        mob:setLocalVar('skillOrder', 2)
        return 581
    elseif mob:getLocalVar('skillOrder') == 2 and mob:getTarget() ~= nil and mob:canUseAbilities() and mob:checkDistance(target) < 6 and mob:getCurrentAction() <= 1 then
        mob:setLocalVar('skillOrder', 3)
        return 581
    elseif mob:getLocalVar('skillOrder') == 3 and mob:getTarget() ~= nil and mob:canUseAbilities() and mob:checkDistance(target) < 6 and mob:getCurrentAction() <= 1 then
        mob:setLocalVar('skillOrder', 4)
        return 584
    elseif mob:getLocalVar('skillOrder') == 4 and mob:getTarget() ~= nil and mob:canUseAbilities() and mob:checkDistance(target) < 6 and mob:getCurrentAction() <= 1 then
        mob:setLocalVar('skillOrder', 5)
        return 584
    elseif mob:getLocalVar('skillOrder') == 5 and mob:getTarget() ~= nil and mob:canUseAbilities() and mob:checkDistance(target) < 6 and mob:getCurrentAction() <= 1 then
        mob:setLocalVar('skillOrder', 6)
        return 584
    elseif mob:getLocalVar('skillOrder') == 6 and mob:getTarget() ~= nil and mob:canUseAbilities() and mob:checkDistance(target) < 6 and mob:getCurrentAction() <= 1 then
        mob:setLocalVar('skillOrder', 0)
        return 1619
    end
end

entity.onMobDeath = function(mob, player, optParams)
    for _, member in pairs(player:getParty()) do
        if member:getObjType() == xi.objType.PC then
        member:changeMusic(2, 121)
        member:changeMusic(3, 121)
        end
    end
    mob:resetLocalVars()
end

return entity
