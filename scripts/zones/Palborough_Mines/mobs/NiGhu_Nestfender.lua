-----------------------------------
-- Area: Palborough Mines
--   NM: Ni'Ghu Nestfender
-- Involed in Quest: The Talekeeper's Truth
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
    mob:setMod(xi.mod.SILENCERES, 150)
    mob:setMod(xi.mod.DMGPHYS, -50)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DMGPHYS, -50)
    mob:addMod(xi.mod.SILENCERES, 150)
end 

entity.onMobMagicPrepare = function(mob, target, spellId)
    local rnd = math.random()

    if mob:getHPP() < 40 then
        if rnd < 0.4 then
            return 3 -- Cure III
        elseif rnd < 0.8 then
            return 4 -- Cure IV
        elseif rnd < 0.9 then
            return 46 -- Protect IV
        else
            return 112 -- Flash
        end
    elseif mob:getHPP() < 98 then
        if rnd < 0.35 then
            return 112 -- Flash
        elseif rnd < 0.55 then
            return 21 -- Holy
        elseif rnd < 0.55 then
            return 29 -- Banish II
        elseif rnd < 0.85 then
            return 46 -- Protect 4
        else
            return 3 -- Cure III
        end
    elseif mob:getHPP() > 97 then
        return 21 -- Holy
    end

end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
