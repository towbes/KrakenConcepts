-- Soulflayer family mixin
require('scripts/globals/mixins')
-----------------------------------

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

local function updateShieldAnimation(mob)
    -- MAGICAL dmg was taken - therefore the shield is down
    if (mob:getAnimationSub() > 0) then
        mob:setAnimationSub(0)
    end
end


g_mixins.families.soulflayer = function(mob)
    mob:addListener('TAKE_DAMAGE', 'SOULFLAYER_TAKE_DAMAGE', function(mob, amount, attacker, attackType, damageType)
        if attackType == xi.attackType.MAGICAL then
            updateShieldAnimation(mob)
        end
        -- about to die
        if (amount > mob:getHP()) then
            mob:setAnimationSub(0)
        end
    end)
end

return g_mixins.families.soulflayer
