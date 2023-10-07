-----------------------------------
-- Attachment: Barrage Turbine
-----------------------------------
require("scripts/globals/automaton")
-----------------------------------
local attachmentObject = {}

attachmentObject.onEquip = function(pet, attachment)
    pet:addMod(xi.mod.AUTOMATON_CAN_BARRAGE, 1)
end

attachmentObject.onUnequip = function(pet, attachment)
    pet:delMod(xi.mod.AUTOMATON_CAN_BARRAGE, 1)
end

attachmentObject.onManeuverGain = function(pet, attachment, maneuvers)
end

attachmentObject.onManeuverLose = function(pet, attachment, maneuvers)
end

attachmentObject.onUpdate = function(pet, attachment, maneuvers)
end

return attachmentObject
