-----------------------------------
-- ID: 16607
-- Chaosbringer
-----------------------------------
local itemObject = {}

itemObject.onItemDrop = function(target, item)
end

itemObject.onItemEquip = function(target, item)
    local Grudge = target:getCharVar('EVERYONES_GRUDGE_KILLS')

    if (Grudge > 560) then
        target:addMod(xi.mod.CRITHITRATE, 1)
        target:addMod(xi.mod.DMG, 200)
    end
    if (Grudge > 540) then
        target:addMod(xi.mod.CRITHITRATE, 1)
        target:addMod(xi.mod.DMG, 200)
    end
    if (Grudge > 520) then
        target:addMod(xi.mod.CRITHITRATE, 1)
        target:addMod(xi.mod.DMG, 200)
    end
    if (Grudge > 500) then
        target:addMod(xi.mod.CRITHITRATE, 1)
        target:addMod(xi.mod.DMG, 200)
    end
    if (Grudge > 480) then
        target:addMod(xi.mod.CRITHITRATE, 1)
        target:addMod(xi.mod.DMG, 200)
    end
end

itemObject.onItemUnequip = function(target, item)
    local Grudge = target:getCharVar('EVERYONES_GRUDGE_KILLS')

    if (Grudge > 560) then
        target:delMod(xi.mod.CRITHITRATE, 1)
        target:delMod(xi.mod.DMG, 200)
    end
    if (Grudge > 540) then
        target:delMod(xi.mod.CRITHITRATE, 1)
        target:delMod(xi.mod.DMG, 200)
    end
    if (Grudge > 520) then
        target:delMod(xi.mod.CRITHITRATE, 1)
        target:delMod(xi.mod.DMG, 200)
    end
    if (Grudge > 500) then
        target:delMod(xi.mod.CRITHITRATE, 1)
        target:delMod(xi.mod.DMG, 200)
    end
    if (Grudge > 480) then
        target:delMod(xi.mod.CRITHITRATE, 1)
        target:delMod(xi.mod.DMG, 200)
    end
end

return itemObject
