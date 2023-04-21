-----------------------------------
-- Area: The Boyahda Tree
--   NM: Voluptuous Vivian
-----------------------------------
mixins = { require("scripts/mixins/job_special") }
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.DRAW_IN, 2)
    mob:addMod(xi.mod.SLEEPRES, 500)

end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.THE_VIVISECTOR)
end

return entity
