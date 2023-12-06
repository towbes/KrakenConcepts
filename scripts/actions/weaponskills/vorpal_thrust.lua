-----------------------------------
-- Vorpal Thrust
-- Polearm weapon skill
-- Skill Level: 175
-- Delivers a single-hit attack. Chance of params.critical varies with TP.
-- Will stack with Sneak Attack.
-- Aligned with the Aqua Gorget & Light Gorget.
-- Aligned with the Aqua Belt & Light Belt.
-- Element: None
-- Modifiers: STR:50%  AGI:50%
-- 100%TP    200%TP    300%TP
-- 1.00      1.00      1.00
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 2
    params.ftp100 = 1.25 params.ftp200 = 1.25 params.ftp300 = 1.25
    params.str_wsc = 0.2 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.2 params.int_wsc = 0.0 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.crit100 = 0.3 params.crit200 = 0.6 params.crit300 = 0.9
    params.canCrit = true
    params.acc100 = 0.0 params.acc200 = 0.0 params.acc300 = 0.0
    params.atk100 = 1 params.atk200 = 1.15 params.atk300 = 1.25

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.str_wsc = 0.5 params.agi_wsc = 0.5
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    if damage > 0 and criticalHit == true then
        player:addMod(xi.mod.CRITHITRATE, 10)
        player:addMod(xi.mod.CRIT_DMG_INCREASE, 10)
        player:addMod(xi.mod.RANGED_CRIT_DMG_INCREASE, 10)
        player:timer(30000, function(playerArg)
            playerArg:delMod(xi.mod.CRITHITRATE, 10)
            playerArg:delMod(xi.mod.CRIT_DMG_INCREASE, 10)
            playerArg:delMod(xi.mod.RANGED_CRIT_DMG_INCREASE, 10)
        end)
    end

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
