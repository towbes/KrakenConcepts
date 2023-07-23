-----------------------------------
-- Area: Ru'Lud Gardens
--  NPC: Venessa
-----------------------------------
local ID = require("scripts/zones/RuLude_Gardens/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/keyitems")
require("scripts/globals/items")
-----------------------------------
local entity = {}

local rewards =
{
    {   xi.items.BRILLIANT_VISION,  xi.items.SUMMONING_EARRING },
    {     xi.items.PAINFUL_VISION,       xi.items.DARK_EARRING },
    {    xi.items.TIMOROUS_VISION, xi.items.ENFEEBLING_EARRING },
    {   xi.items.VENERABLE_VISION,     xi.items.STRING_EARRING },
    {     xi.items.VIOLENT_VISION,    xi.items.BUCKLER_EARRING },
    {   xi.items.AUDACIOUS_VISION,     xi.items.DIVINE_EARRING },
    {   xi.items.ENDEARING_VISION,    xi.items.SINGING_EARRING },
    { xi.items.PUNCTILIOUS_VISION,   xi.items.PARRYING_EARRING },
    {      xi.items.VERNAL_VISION,    xi.items.EVASION_EARRING },
    {       xi.items.VIVID_VISION,    xi.items.HEALING_EARRING },
    {   xi.items.MALICIOUS_VISION,   xi.items.NINJUTSU_EARRING },
    { xi.items.PRETENTIOUS_VISION,  xi.items.ELEMENTAL_EARRING },
    {    xi.items.PRISTINE_VISION,       xi.items.WIND_EARRING },
    {      xi.items.SOLEMN_VISION,   xi.items.GUARDING_EARRING },
    {     xi.items.VALIANT_VISION, xi.items.AUGMENTING_EARRING },
    {   xi.items.IMPETUOUS_VISION,     xi.items.TOREADERS_RING },
    {     xi.items.TENUOUS_VISION,        xi.items.ASTRAL_ROPE },
    {       xi.items.SNIDE_VISION,      xi.items.SAFETY_MANTLE },
    {        xi.items.GRAVE_IMAGE,          xi.items.HABU_SKIN },
    {     xi.items.BEATIFIC_IMAGE,          xi.items.TIGER_EYE },
    {     xi.items.VALOROUS_IMAGE,    xi.items.RHEIYOH_LEATHER },
    {      xi.items.ANCIENT_IMAGE,     xi.items.OVERSIZED_FANG },
    {       xi.items.VIRGIN_IMAGE,      xi.items.SUPER_CERMENT },
}

entity.onTrade = function(player, npc, trade)
    local reward = 0

    -- Get what reward should be given according to traded item
    for _, prize in pairs(rewards) do
        if npcUtil.tradeHasExactly(trade, prize[1]) then
            reward = prize[2]
            player:setCharVar("veneReward", reward)
            player:startEvent(10066, reward)
        end
    end
end

entity.onTrigger = function(player, npc)
    -- Player has attempted the ENM at least once
    if
        player:getCurrentMission(xi.mission.log_id.COP) > xi.mission.id.cop.THE_RITES_OF_LIFE and
        player:getCharVar("[ENM]VenessaComplete") == 1
    then
        player:startEvent(10065)
    -- Player can do ENM but hasn't done it
    elseif player:getCurrentMission(xi.mission.log_id.COP) > xi.mission.id.cop.THE_RITES_OF_LIFE then
        player:startEvent(10064)
    -- Player has not progressed far enough in CoP
    else
        player:startEvent(10064, 99)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
