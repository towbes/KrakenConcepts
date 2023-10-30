--[[
Orobon Family Mixin

Description:
When initializing the orobon family mixin, one can specify whether or not the lure
is breakable, as well as the chance required to make the lure break given the
possibly methods. Otherwise it is a default 10%. ****Needs verification****
These variables are named lure and chance respectively.

Example:
 xi.mix.orobon.config(mob, { lureBreak = false, chance = 50 })

Notes:
Orobon's lure break when players deal critical damage, and deliver a WS or
a JA that deals damage. After their lure is broken, it will then be a 100%
drop.

AnimationSubs:
4: Default
1: Broken Lure
Else: ???
--]]
require("scripts/globals/mixins")
-----------------------------------
xi = xi or {}
xi.mix = xi.mix or {}
xi.mix.orobon = xi.mix.orobon or {}

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

local tryBreakLure = function(mob)
    -- Default odds require validation. Very little information exists.
    if
        math.random(1, 100) < mob:getLocalVar("[OROBON]breakChance") and
        mob:getLocalVar("[OROBON]canBreakLure") >= 1 and
        mob:getAnimationSub() ~= 1
    then
        mob:setAnimationSub(1)

        mob:addListener("ITEM_DROPS", "ITEM_DROPS_OROBON", function(mobArg, loot)
            loot:addItem(xi.items.OROBON_LURE, xi.drop_rate.ALWAYS)
        end)
    end
end

xi.mix.orobon.config = function(mob, params)
    if type(params.lureBreak) == "boolean" and not params.lureBreak then
        mob:setLocalVar("[OROBON]canBreakLure", 0)
    end

    if params.chance and type(params.chance) == "number" then
        mob:setLocalVar("[OROBON]breakChance", params.chance)
    end
end

g_mixins.families.orobon = function(orobonMob)
    orobonMob:addListener("SPAWN", "OROBON_SPAWN", function(mob)
        mob:setLocalVar("[OROBON]canBreakLure", 1)
        mob:setLocalVar("[OROBON]breakChance", 10)
    end)

    orobonMob:addListener("CRITICAL_TAKE", "CRITIAL_TAKE_OROBON", function(mob)
        tryBreakLure(mob)
    end)

    orobonMob:addListener("WEAPONSKILL_TAKE", "WEAPON_SKILL_TAKE_OROBON", function(mob)
        tryBreakLure(mob)
    end)

    orobonMob:addListener("ABILITY_TAKE", "ABILITY_TAKE_OROBON", function(mob, target, ability, action)
        local id = ability:getID()
        if
            id == xi.jobAbility.SHIELD_BASH or
            id == xi.jobAbility.WEAPON_BASH or
            id == xi.jobAbility.EAGLE_EYE_SHOT or
            id == xi.jobAbility.MIJIN_GAKURE or
            id == xi.jobAbility.JUMP or
            id == xi.jobAbility.HIGH_JUMP or
            id == xi.jobAbility.BLADE_BASH or
            id == xi.jobAbility.CHI_BLAST or
            id == xi.jobAbility.FIRE_SHOT or
            id == xi.jobAbility.ICE_SHOT or
            id == xi.jobAbility.EARTH_SHOT or
            id == xi.jobAbility.WIND_SHOT or
            id == xi.jobAbility.ICE_SHOT or
            id == xi.jobAbility.WATER_SHOT
        then
            tryBreakLure(mob)
        end
    end)
end

return g_mixins.families.orobon