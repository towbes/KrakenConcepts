-----------------------------------
-- Strap Cutter
-- Description: Removes and disables several random equipment slots for a period of time.
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
-- todo make a random for which gear to remove and how many pieces
    --local remove = 0xFFFF
    local numberToBlock = math.random(3,5) -- bg-wiki claims 3-5
    local equipmentToBlock = 0
    -- Need a list that corresponds to the range from xi.slot.MAIN to xi.slot.BACK - but mutable without consequence
    local equipmentSlots = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15}
    for i=1, numberToBlock do
        index = math.random(#equipmentSlots)
        slot = equipmentSlots[index]
        table.remove(equipmentSlots, index)
        target:unequipItem(slot)
        equipmentToBlock = equipmentToBlock + bit.lshift(1, slot)
    end
    target:addStatusEffectEx(xi.effect.ENCUMBRANCE_I, xi.effect.ENCUMBRANCE_I, equipmentToBlock, 0, 60)
end

return mobskillObject
