-----------------------------------
-- Spell: Raise
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    if target:isPC() then
        if (caster:getObjType() == xi.objType.MOB) and (caster:getMobMod(xi.mobMod.PIXIE) > 0) then
            target:sendRaise(3)
        else
            target:sendRaise(3)
        end
    else
        if target:getName() == "Prishe" then
            -- CoP 8-4 Prishe
            target:setLocalVar("Raise", 1)
            target:entityAnimationPacket("sp00")
            target:addHP(target:getMaxHP())
            target:addMP(target:getMaxMP())
        end
    end

    spell:setMsg(xi.msg.basic.MAGIC_CASTS_ON)

    return 3
end

return spellObject
