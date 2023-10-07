-----------------------------------
--  Hydro Wave
--
--  Description: Fires a blast of Water, dealing damage in a fan-shaped area. Additional effect: Removes a single piece of equipment.
--  Type: Magical (Water)
--  Utsusemi/Blink absorb: Wipes shadows
--  Range: Area of Effect (10 yalms)
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/status")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = 1
    local info   = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.WATER, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg    = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WATER)
    --local remove = 0xFFFF
    local numberToUnequip = 1

    -- Need a list that corresponds to the range from xi.slot.MAIN to xi.slot.BACK - but mutable without consequence
    local equipmentSlots = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15}
    for i=1, numberToUnequip do
        index = math.random(#equipmentSlots)
        slot = equipmentSlots[index]
        table.remove(equipmentSlots, index)
        target:unequipItem(slot)
    end
    return dmg
end

return mobskillObject
