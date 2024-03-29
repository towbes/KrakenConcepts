-----------------------------------
-- Area: Dynamis - Qufim
--  Mob: Antaeus
-- Note: Mega Boss
-----------------------------------
require('scripts/globals/dynamis')
mixins =
{
    require('scripts/mixins/dynamis_beastmen'),
    require('scripts/mixins/job_special')
}
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.SPECIAL_SKILL, 1636)
    mob:setMobMod(xi.mobMod.HP_SCALE, 400)
end

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.jsa.EES_GIGA, hpp = 50 },
        },
    })
    mob:setLocalVar('[isDynamis_Arch_Megaboss]', 1)

    -- Set Removable Mods
    mob:setMod(xi.mod.REGEN, 1000)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 0)

    mob:setLocalVar('AntaeusRegen', 1)

    mob:setMod(xi.mod.CRITHITRATE, 100)
    mob:setLocalVar('AntaeusCrit', 1)

    mob:setMod(xi.mod.UDMGRANGE, -99)
    mob:setMod(xi.mod.UDMGPHYS, -99)
    mob:setMod(xi.mod.UDMGMAGIC, -99)
    mob:setMod(xi.mod.UDMGBREATH, -99)
    mob:setLocalVar('AntaeusDMG', 1)
    
    -- Set Non-Removable Mods
    -- Anateus should not standback and should be able to avoid most RAs via melee range. (https://ffxiclopedia.fandom.com/wiki/Antaeus)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    -- Sleep Res and Lullaby Res are unverified but added in case (https://ffxiclopedia.fandom.com/wiki/Antaeus)
    mob:setMod(xi.mod.SLEEPRES, 99)
    mob:setMod(xi.mod.LULLABYRES, 99)
    -- Adding Normal Dynamis Boss Resistances and Regain
    mob:setMod(xi.mod.GRAVITYRES, 40)
    mob:setMod(xi.mod.BINDRES, 40)
    mob:setMod(xi.mod.REGAIN, 150)
    mob:setMod(xi.mod.STUNRES, 50)
end

entity.onMobFight = function(mob, target)
    for _, member in pairs(target:getParty()) do
        if member:getObjType() == xi.objType.PC then
        member:changeMusic(2, 88)
        member:changeMusic(3, 88)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    mob:resetLocalVars()
    for _, member in pairs(player:getParty()) do
        if member:getObjType() == xi.objType.PC then
        member:changeMusic(2, 121)
        member:changeMusic(3, 121)
        end
    end
end

return entity
