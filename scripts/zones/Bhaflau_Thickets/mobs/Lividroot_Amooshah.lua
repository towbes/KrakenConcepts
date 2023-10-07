-----------------------------------
-- Area: Bhaflau Thickets
--  ZNM: Lividroot Amooshah

-----------------------------------
require('scripts/globals/hunts')
-----------------------------------
local entity = {}

local function phaseChange(mob)
    -- shouldn't happen, but let's make sure we do not exceed phase 4
    local phase = mob:getLocalVar('phase') + 1
    mob:setLocalVar('phase', phase)
    mob:setLocalVar('phaseChange', 0)

    -- disable and disappear for a second
    mob:setStatus(xi.status.INVISIBLE)
    mob:setAutoAttackEnabled(false)
    mob:setMagicCastingEnabled(false)
    mob:setMobAbilityEnabled(false)

    mob:timer(1000, function(mob)
        mob:setStatus(xi.status.UPDATE)
        mob:setAutoAttackEnabled(true)
        mob:setMagicCastingEnabled(true)
        mob:setMobAbilityEnabled(true)
    end)

    -- fill hp and gets a buff every phase changes
    mob:setHP(mob:getMaxHP())
    mob:addMod(xi.mod.DMGPHYS, -10)
    mob:addMod(xi.mod.MEVA, 25)

    if phase > 3 then
        -- final phase
        mob:setUnkillable(false)
    end
end

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
    mob:setMobMod(xi.mobMod.GIL_MIN, 4500)
    mob:setMobMod(xi.mobMod.GIL_MAX, 7500)

    -- immune to sleep and high res to slow/elegy
    mob:setMod(xi.mod.SLEEPRES, 100)
    mob:setMod(xi.mod.SLOWRES, 80)

    -- slowly builds resistance to gravity and bind
    --mob:setMod(xi.mod.RESBUILD_BIND, 15)
    --mob:setMod(xi.mod.RESBUILD_GRAVITY, 15)

    -- has regain and endrain
    mob:setMod(xi.mod.REGAIN, 100)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar('[rage]timer', 4500)
    mob:setLocalVar('phase', 1)
    mob:setUnkillable(true)
end

entity.onMobFight = function(mob, target)
    if mob:getHP() <= 100 and mob:getLocalVar('phase') < 4 and mob:getLocalVar('phaseChange') == 0 then
        -- trigger the phase change
        mob:setLocalVar('phaseChange', 1)
        if mob:getLocalVar('phase') < 4 then
            mob:timer(4000, function(mobArg)
                phaseChange(mobArg)
            end)
        end
        mob:useMobAbility(317)
        -- mob:setTP(3000)
    end
end

entity.onMobWeaponSkillPrepare = function(mob, target)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.HP_DRAIN, { chance = 75, power = math.random(24, 49) })
end

entity.onMobWeaponSkill = function(target, mob, skill)
end


entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 448)
end

return entity
