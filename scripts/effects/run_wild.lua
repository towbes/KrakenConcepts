-----------------------------------
-- xi.effect.RUN_WILD
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local pet = target:getPet()
    print('works')
    if pet then
        pet:addMod(xi.mod.ATTP, 25)
        pet:addMod(xi.mod.DEFP, 25)
        pet:addMod(xi.mod.EVA, 25)
        pet:addMod(xi.mod.MATT, 25)
        pet:addMod(xi.mod.REGEN, 2)
    end
end

effectObject.onEffectTick = function(target, effect)
    local pet = target:getPet()
    if pet:isDead() then
        target:delStatusEffectSilent(effect)
    end
end

effectObject.onEffectLose = function(target, effect)
    local pet = target:getPet()
    if pet then
        pet:delMod(xi.mod.ATTP, 25)
        pet:delMod(xi.mod.DEFP, 25)
        pet:delMod(xi.mod.EVA, 25)
        pet:delMod(xi.mod.MATT, 25)
        pet:delMod(xi.mod.REGEN, 2)
    end
    target:despawnPet()
end

return effectObject
