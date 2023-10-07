-----------------------------------
-- Area: Halvung
--  Mob: Achamoth Nympha
-- Author: Spaceballs
-----------------------------------
local ID = zones[xi.zone.HALVUNG]
local entity = {}

entity.onMobDeath = function(mob)

end

entity.onMobDespawn = function(mob)
    local mother = GetMobByID(ID.mob.ACHAMOTH)
    if mother:isSpawned() then
        mother:setLocalVar('bigAdds', mother:getLocalVar('bigAdds') - 1)
    end
end

return entity