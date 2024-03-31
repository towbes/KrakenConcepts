-----------------------------------
-- xi.effect.SANGE
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.DAKEN, 100)
    target:addMod(xi.mod.RACC, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.DAKEN, 100)
    target:delMod(xi.mod.RACC, effect:getPower())
end

return effectObject
