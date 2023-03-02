---------------------------------------------
-- Hypnic Lamp
-- Description: Sleeps opponents with a gaze attack.
-- Type: Gaze
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: conal gaze
---------------------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getID() == 16998874 then
        if math.random(1,100) > 50 then
            return 0
        else
            return 1
        end
    else
        return 0
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.SLEEP_I
    local duration = 60

    skill:setMsg(xi.mobskills.mobGazeMove(mob, target, typeEffect, 1, 0, duration))
    
    if mob:getID() == 16998874 then
        mob:setLocalVar("Phase", 2)
        mob:setLocalVar("Changed",1)
    end

    return typeEffect
end

return mobskillObject
