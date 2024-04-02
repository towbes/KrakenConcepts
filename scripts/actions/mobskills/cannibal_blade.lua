---------------------------------------------
-- Cannibal Blade
---------------------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)

    local dmg = math.random(60,120) + mob:getMainLvl() * 3
    
    dmg = target:physicalDmgTaken(target, dmg, xi.damageType.SLASHING)
    dmg = dmg * target:getMod(xi.mod.SLASHRES) / 1000
    
    if mob:checkDistance(target) > 7 then
        dmg = dmg/4
    end
    
    dmg = dmg - target:getMod(xi.mod.PHALANX)
    
    dmg = utils.stoneskin(target, dmg)

    if not target:isUndead() then
        mob:addHP(dmg)
        skill:setMsg(xi.mobskills.mobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.HP, dmg))
    end
    
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)

    return dmg
end

return mobskillObject
