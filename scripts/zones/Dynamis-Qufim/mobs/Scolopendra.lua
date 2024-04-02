-----------------------------------
-- Area: Dynamis - Qufim
--  Mob: Scolopendra
-----------------------------------
mixins =
{
    require('scripts/mixins/dynamis_beastmen')
}
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
end

entity.onMobSpawn = function(mob)
end

entity.onMobFight = function(mob, target)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
