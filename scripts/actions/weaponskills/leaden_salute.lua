-----------------------------------
-- Leaden Salute
-- Sword weapon skill
-- Skill Level: N/A
-- Delivers a Twofold attack. Damage varies with TP. Death Penalty: Aftermath effect varies with TP.
-- Available only after completing the Unlocking a Myth (Corsair) quest.
-- Aligned with the Shadow Gorget, Soil Gorget & Light Gorget.
-- Aligned with the Shadow Belt, Soil Belt & Light Belt.
-- Element: Darkness
-- Modifiers: AGI:30%
-- 100%TP    200%TP    300%TP
-- 4.00      4.25      4.75
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.ftp100          = 4.00
    params.ftp200          = 4.25
    params.ftp300          = 4.75

    params.str_wsc         = 0.0 
    params.dex_wsc         = 0.0
    params.vit_wsc         = 0.0
    params.agi_wsc         = 0.3
    params.int_wsc         = 0.0
    params.mnd_wsc         = 0.0
    params.chr_wsc         = 0.0
    
    params.ele             = xi.element.DARK
    params.skill           = xi.skill.MARKSMANSHIP
    params.includemab      = true

    params.useStatCoefficient = true
    params.dStat1             = xi.mod.AGI
    params.dStat2             = xi.mod.INT
    params.dStatMultiplier    = 2

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftp100 = 3.890625 params.ftp200 = 6.4921875  params.ftp300 = 9.671875
        params.agi_wsc = 1.0
    end

    -- Apply aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.RANGED, xi.aftermath.type.MYTHIC)

    local damage, tpHits, extraHits = xi.weaponskills.doMagicWeaponskill(player, target, wsID, params, tp, action, primary)

    return tpHits, extraHits, false, damage
end

return weaponskillObject