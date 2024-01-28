-----------------------------------
-- Area: Mount Zhayolm
--  Mob: Wamoura
-- Note: PH for Ignamoth
-----------------------------------
local ID = zones[xi.zone.MOUNT_ZHAYOLM]
-----------------------------------
local entity = {}

function evolvedFromPrince(mob)
    local evolved = false
    local mobId = mob:getID()

    for i,v in pairs(ID.mob.EVOLVING_WAMOURA_PRINCES) do
        if mobId == v+1 then
            evolved = true
        end
    end

    return evolved    
end

entity.onMobDeath = function(mob)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.IGNAMOTH_PH, 10, 7200) -- 2 hours
    
    if evolvedFromPrince(mob) then
        local princeID = mob:getID() - 1
        DisallowRespawn(princeID, false)
    end
end

return entity
