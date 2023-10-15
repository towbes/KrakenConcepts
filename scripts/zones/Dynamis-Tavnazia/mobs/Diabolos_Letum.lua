-----------------------------------
-- Area: Dynamis-Tavnazia
--  Mob: Diabolos Letum
-- Note: Mega Boss
-----------------------------------
require('scripts/globals/dynamis')
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setAutoAttackEnabled(false)
    mob:addListener('MAGIC_USE', 'LETUM_MAGIC_USE', function(mobArg, target, spell, action)
        if spell:tookEffect() then
            mobArg:useMobAbility(1908)
        end
    end)
    mob:setMobMod(xi.mobMod.HP_SCALE, 500)
    mob:setMobMod(xi.mobMod.MAGIC_DELAY, 20)
end

entity.onMobSpawn = function(mob)
    local chance = math.random(1, 100)
    if chance > 50 then
        mob:timer(3000, function(mobArg)
            -- Cacodemonia
            mobArg:useMobAbility(1909)
        end)
    end
end

entity.onMobFight = function(mob, target)
    for _, member in pairs(target:getParty()) do
        if member:getObjType() == xi.objType.PC then
        member:changeMusic(2, 239)
        member:changeMusic(3, 239)
        end
    end
end

entity.onSpellCast = function(mob, target, spell)
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() == 1908 then -- Nightmare
        mob:timer(5000, function(mobArg)
            mobArg:useMobAbility(1919) -- Daydream
        end)
    end
end


entity.onSpellPrecast = function(mob, spell)
    if 
    spell:getID() == xi.magic.spell.DRAIN or
    spell:getID() == xi.magic.spell.DRAIN_II or
    spell:getID() == xi.magic.spell.ASPIR 
    then
    -- drain casted by diabolos letum is AOE
    spell:setAoE(xi.magic.aoe.RADIAL)
    spell:setRadius(10)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.NIGHTMARE_AWAKENER)
    mob:resetLocalVars()
    for _, member in pairs(player:getParty()) do
        if member:getObjType() == xi.objType.PC then
        member:changeMusic(2, 121)
        member:changeMusic(3, 121)
        end
    end
end

return entity
