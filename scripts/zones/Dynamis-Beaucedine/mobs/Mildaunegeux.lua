-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Mildaunegeux
-----------------------------------
mixins =
{
    require("scripts/mixins/dynamis_beastmen"),
    require("scripts/mixins/job_special")
}
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.HP_SCALE, 300)
end

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        between = 60,
        specials =
        {
            { id = xi.jsa.HUNDRED_FISTS, cooldown = 0, hpp = 95 },
            { id = xi.jsa.PERFECT_DODGE, cooldown = 0, hpp = 95 },
            { id = xi.jsa.MIJIN_GAKURE, cooldown = 0, hpp = 25 },
        },
    })
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
