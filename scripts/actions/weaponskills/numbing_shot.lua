-----------------------------------
-- Numbing Shot
-- Marksmanship weapon skill
-- Skill level: 290
-- Main of sub must be Ranger or Corsair
-- Aligned with the Thunder & Breeze Gorget.
-- Aligned with the Thunder Belt & Breeze Belt.
-- Element: Ice
-- Modifiers: AGI 80%
-- 100%TP    200%TP    300%TP
-- 3.00      3.00      3.00
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 2
    -- params.numHits = 1
    params.ftpMod = { 3.0, 3.0, 3.0 }
    params.agi_wsc = 0.6

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.agi_wsc = 0.7
    end

    params.meleedmg = 0
    params.melee = true

    local weaponDamage       = 4
    local weaponType         = player:getWeaponSkillType(xi.slot.MAIN)
    local meleeWeapon        = player:getWeaponDmg() * 0.9
    local meleeWeaponOffhand = player:getOffhandDmg() * 0.35
    local rangedWeapon       = player:getRangedDmg()

    if weaponType == xi.skill.HAND_TO_HAND then
        weaponDamage = math.floor(player:getSkillLevel(1) * 110 / 276) -- +130 at capped A+ h2h
	else
        weaponDamage = meleeWeapon + rangedWeapon + meleeWeaponOffhand
	end
	
	if weaponDamage < 4 then
		weaponDamage = 4
	end
	
	params.meleedmg = math.ceil(weaponDamage * 1.5)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doRangedWeaponskill(player, target, wsID, params, tp, action, primary)

    if damage > 0 and not target:hasStatusEffect(xi.effect.PARALYSIS) and not target:hasImmunity(xi.immunity.PARALYZE) then
        local duration = (tp / 1000 * 60) * applyResistanceAddEffect(player, target, xi.element.ICE, 0)
        target:addStatusEffect(xi.effect.PARALYSIS, 30, 0, duration)
        player:messagePublic(xi.msg.basic.SKILL_ENFEEB, target, wsID, xi.effect.PARALYSIS)
    end

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
