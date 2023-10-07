-----------------------------------
-- Area: The Eldieme Necropolis
--  MOB: Namorodo
-----------------------------------
local ID = zones[xi.zone.THE_ELDIEME_NECROPOLIS]

require('scripts/globals/pets/fellow')
require('scripts/globals/fellow_utils')
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobSpawn = function(mob)
    mob:setMagicCastingEnabled(false)
    mob:timer(30000, function(mob) mob:setMagicCastingEnabled(true) end)
end

entity.onMobFight = function(mob, target)
end

entity.onMobDeath = function(mob, player, optParams)
    local personality = player:getFellowValue('personality')
    local fellow = player:getFellow()
    if fellow ~= nil then
        function checkPersonality(personality)
            local personaTable = {4,8,12,16,40,44,20,24,28,32,36,48}
            for i,v in ipairs(personaTable) do
                if v == personality then
                    return i - 1
                end
            end
        end
        player:showText(fellow, ID.text.SEEMS_TO_BE_THE_END + checkPersonality(personality))
        player:setCharVar('[Quest]Looking_Glass', 3)
        player:timer(30000, function(player) player:despawnFellow() end) -- 30 sec to talk to fellow
    end
end


return entity