-----------------------------------
--  Rock Smash
--  Description: Damages a single target. Additional effect: Petrification
--  Type: Physical
--  Utsusemi/Blink absorb: 1 shadow
--  Range: Melee
--  Notes: Requires No Weapon or Broken Weapon
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if(mob:getFamily() == 91) then
        local mobSkin = mob:getModelId()
           if (mobSkin == 1680) then
               return 0
           else
               return 1
           end
      end
      if mob:getAnimationSub() == 1 or mob:getMainJob() == xi.job.MNK or mob:getMainJob() == xi.job.PUP then     
           return 0
      else 
           return 1
      end
   
   end
   

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 2
    local dmgmod = 3
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)
    local power = math.random(25, 40) + mob:getMainLvl() / 3

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.PETRIFICATION, 1, 0, power)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    return dmg
end

return mobskillObject
