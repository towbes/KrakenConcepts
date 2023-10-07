-----------------------------------
-- Lava_Spit
-- Deals Fire damage to enemies within an area of effect.
-----------------------------------



-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if (mob:getID() == 17072171) then -- Ob
        if (mob:getHPP() > 50) then
            return 1 -- only used under 50%
        end
    end
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local ftp
    local tp = skill:getTP()

        -- going with guess work based on reports - and using Ob's 14k max hp for scaling
    -- starts using it at 50%, or 7k/7 = 1k dmg
    -- max damage is ~2k at 1hp
    local damage = (mob:getMaxHP() - mob:getHP()) / 7
    

    if damage > 0 then
       damage = damage + math.random(1,99) -- add variance
       target:addTP(20)
       mob:addTP(80)
    end
    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.LIGHT)
    return damage
end

return mobskillObject
