-----------------------------------
-- Area: Upper Jeuno
--  NPC: Luto Mewrilah
-- !pos -53 0 45 244
-----------------------------------
local ID = require("scripts/zones/Upper_Jeuno/IDs")
require("scripts/globals/pets/fellow")
require("scripts/globals/fellow_utils")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/pets")
require("scripts/globals/settings")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

local fellowWeapons = {
    [1] = {
        Axe = {ID = 16640, Look = 16640},
        Club = {ID = 17034, Look = 17034},
        Dagger = {ID = 16465, Look = 16465},
        Katana = {ID = 16896, Look = 16896},
        Sword = {ID = 16535, Look = 16535},
        Shield = {ID = 12289, Look = 12289},
        HandToHand = {ID = 16385, Look = 16385},
        GreatAxe = {ID = 16704, Look = 16704},
        GreatKatana = {ID = 16960, Look = 16960},
        GreatSword = {ID = 16583, Look = 16585},
        Polearm = {ID = 16832, Look = 16832},
        Scythe = {ID = 16768, Look = 16768},
        Staff = {ID = 17088, Look = 17088}
    },
    [2] = {
        Axe = {ID = 16641, Look = 16641},
        Club = {ID = 17042, Look = 17042},
        Dagger = {ID = 16449, Look = 16449},
        Katana = {ID = 16900, Look = 16900},
        Sword = {ID = 16530, Look = 16530},
        Shield = {ID = 12415, Look = 12415},
        HandToHand = {ID = 16390, Look = 16390},
        GreatAxe = {ID = 16705, Look = 16705},
        GreatKatana = {ID = 16982, Look = 16982},
        GreatSword = {ID = 16589, Look = 16583},
        Polearm = {ID = 16833, Look = 16833},
        Scythe = {ID = 16769, Look = 16769},
        Staff = {ID = 17089, Look = 17089}
    },
    [3] = {
        Axe = {ID = 16643, Look = 16656},
        Club = {ID = 17050, Look = 17050},
        Dagger = {ID = 16455, Look = 16455},
        Katana = {ID = 17776, Look = 16897},
        Sword = {ID = 16552, Look = 16552},
        Shield = {ID = 12299, Look = 12299},
        HandToHand = {ID = 16406, Look = 16406},
        GreatAxe = {ID = 18200, Look = 18214},
        GreatKatana = {ID = 16975, Look = 16975},
        GreatSword = {ID = 16594, Look = 16594},
        Polearm = {ID = 16835, Look = 16836},
        Scythe = {ID = 16774, Look = 16774},
        Staff = {ID = 17096, Look = 17096}
    },
    [4] = {
        Axe = {ID = 16650, Look = 16650},
        Club = {ID = 17081, Look = 17081},
        Dagger = {ID = 16473, Look = 16473},
        Katana = {ID = 16907, Look = 16907},
        Sword = {ID = 16566, Look = 16566},
        Shield = {ID = 12292, Look = 12292},
        HandToHand = {ID = 16411, Look = 16411},
        GreatAxe = {ID = 18214, Look = 16706},
        GreatKatana = {ID = 16962, Look = 16962},
        GreatSword = {ID = 18375, Look = 18375},
        Polearm = {ID = 16845, Look = 16845},
        Scythe = {ID = 16770, Look = 16770},
        Staff = {ID = 17424, Look = 17424}
    },
    [5] = {
        Axe = {ID = 16644, Look = 16657},
        Club = {ID = 17026, Look = 17026},
        Dagger = {ID = 16460, Look = 16460},
        Katana = {ID = 16901, Look = 17795},
        Sword = {ID = 16513, Look = 16513},
        Shield = {ID = 12306, Look = 12306},
        HandToHand = {ID = 16399, Look = 16399},
        GreatAxe = {ID = 18216, Look = 16710},
        GreatKatana = {ID = 16970, Look = 16970},
        GreatSword = {ID = 16584, Look = 16584},
        Polearm = {ID = 16836, Look = 16837},
        Scythe = {ID = 16775, Look = 16775},
        Staff = {ID = 17091, Look = 17132}
    },
    [6] = {
        Axe = {ID = 16657, Look = 16645},
        Club = {ID = 17062, Look = 17467},
        Dagger = {ID = 17610, Look = 16480},
        Katana = {ID = 16902, Look = 16902},
        Sword = {ID = 16553, Look = 16631},
        Shield = {ID = 12300, Look = 12300},
        HandToHand = {ID = 16419, Look = 16419},
        GreatAxe = {ID = 16706, Look = 18218},
        GreatKatana = {ID = 16967, Look = 16967},
        GreatSword = {ID = 16590, Look = 16590},
        Polearm = {ID = 16847, Look = 16849},
        Scythe = {ID = 16796, Look = 16796},
        Staff = {ID = 17098, Look = 17098}
    },
    [7] = {
        Axe = {ID = 16651, Look = 17942},
        Club = {ID = 17037, Look = 17454},
        Dagger = {ID = 16468, Look = 18014},
        Katana = {ID = 16903, Look = 16903},
        Sword = {ID = 16519, Look = 17701},
        Shield = {ID = 12307, Look = 12307},
        HandToHand = {ID = 16401, Look = 18353},
        GreatAxe = {ID = 18202, Look = 18206},
        GreatKatana = {ID = 17802, Look = 17829},
        GreatSword = {ID = 16595, Look = 16595},
        Polearm = {ID = 16871, Look = 16871},
        Scythe = {ID = 18050, Look = 18054},
        Staff = {ID = 17523, Look = 17569}
    },
}

local function updateMatchingFellowWeapon(player, maxWeaponlevel, trade)
    local weapon = nil
    for i=1,maxWeaponlevel do
        for k,v in pairs(fellowWeapons[i]) do
            if npcUtil.tradeHasExactly(trade, v.ID) then
                weapon = v.ID
                if (k == "Shield") then
                    player:setFellowValue("sub", weapon)
                else
                    player:setFellowValue("main", weapon)
                end
            end
        end
    end

    return weapon
end

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeHas(trade, 14810) and player:getLocalVar("StartOver") == 1 then
        local fellowParam = getFellowParam(player)
        player:startEvent(10049,244,0,0,0,0,0,0,fellowParam)
        return
    end

    local UnlistedQualities = player:getQuestStatus(xi.quest.log_id.JEUNO,xi.quest.id.jeuno.UNLISTED_QUALITIES)
    if UnlistedQualities == QUEST_COMPLETED then
        local weaponlevel = player:getFellowValue("weaponlvl")
        local weapon = updateMatchingFellowWeapon(player, weaponlevel, trade)
        if (weapon == nil) then
            -- no match found
            return
        end
        player:confirmTrade()
        local fellowParam = getFellowParam(player)
        player:startEvent(10052, 0, weapon, 0, 0, 0, 0, 0, fellowParam)
    end
end

entity.onTrigger = function(player, npc)
    local wildcatJeuno = player:getCharVar("WildcatJeuno")
    local UnlistedQualities = player:getQuestStatus(xi.quest.log_id.JEUNO,xi.quest.id.jeuno.UNLISTED_QUALITIES)
    local UnlistedQualitiesProgress = player:getCharVar("[Quest]Unlisted_Qualities")
    local LookingGlass = player:getQuestStatus(xi.quest.log_id.JEUNO,xi.quest.id.jeuno.GIRL_IN_THE_LOOKING_GLASS)
    local LookingGlassProgress = player:getCharVar("[Quest]Looking_Glass")
    local MirrorMirror = player:getQuestStatus(xi.quest.log_id.JEUNO,xi.quest.id.jeuno.MIRROR_MIRROR)
    local MirrorMirrorProgress = player:getCharVar("[Quest]Mirror_Mirror")
    local needToZone = player:needToZone()
    local fellowParam = 0
    local bond = 0
    local weaponlevel = 0

    if UnlistedQualities == QUEST_COMPLETED then
        fellowParam = xi.fellow_utils.getFellowParam(player)
        bond = player:getFellowValue("bond")
        weaponlevel = player:getFellowValue("weaponlvl")
    end

    if
        player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and
        not utils.mask.getBit(wildcatJeuno, 7)
    then
        player:startEvent(10085)
    elseif UnlistedQualities == QUEST_AVAILABLE and player:getRank(player:getNation()) >= 4 and xi.settings.main.ENABLE_ADVENTURING_FELLOWS == true then  -- Rank 4 not required after 2013
        player:startEvent(10031)
    elseif UnlistedQualities == QUEST_ACCEPTED and UnlistedQualitiesProgress < 15 then
        player:startEvent(10033)
    elseif UnlistedQualities == QUEST_ACCEPTED and UnlistedQualitiesProgress == 15 then
        player:startEvent(10032)
    elseif UnlistedQualities == QUEST_COMPLETED and LookingGlass < QUEST_ACCEPTED and needToZone == true then
        player:startEvent(10034)
    elseif UnlistedQualities == QUEST_COMPLETED and LookingGlass == QUEST_AVAILABLE then
        player:startEvent(10039)
    elseif LookingGlass == QUEST_ACCEPTED and LookingGlassProgress < 4 then
        player:startEvent(10042)
    elseif LookingGlass == QUEST_ACCEPTED and LookingGlassProgress == 4 then
        player:startEvent(10043,244,0,0,0,0,0,0,fellowParam)
    elseif LookingGlass == QUEST_COMPLETED and MirrorMirror < QUEST_ACCEPTED and needToZone == true then
        player:startEvent(10048)
    elseif LookingGlass == QUEST_COMPLETED and MirrorMirror == QUEST_AVAILABLE then
        player:startEvent(10044,244,0,0,0,0,0,0,fellowParam)
    elseif MirrorMirror == QUEST_ACCEPTED and MirrorMirrorProgress < 3 then
        player:startEvent(10045)
    elseif MirrorMirror == QUEST_ACCEPTED and MirrorMirrorProgress == 3 then
        player:startEvent(10046,244,14810,0,0,0,0,0,fellowParam)
    elseif MirrorMirror == QUEST_COMPLETED and player:getLocalVar("StartOver") == 1 then
        player:startEvent(10053,244,14810,0,0,0,0,0,fellowParam)
    elseif MirrorMirror == QUEST_COMPLETED then
        if (player:getEquipID(xi.slot.EAR1) == 14810 or player:getEquipID(xi.slot.EAR2) == 14810) then
            if (bond >= 10 and weaponlevel == 0) then
                player:startEvent(10050, 0, 0, 0, 0, 0, 0, 0, fellowParam)
            elseif (bond >= 20 and weaponlevel == 1) then
                player:startEvent(10051, 0, 0, 0, 0, 0, 0, 0, fellowParam)
            elseif (bond >= 40 and weaponlevel == 2) then
                player:startEvent(10068, 0, 0, 0, 0, 0, 0, 0, fellowParam)
            elseif (bond >= 50 and weaponlevel == 3) then
                player:startEvent(10069, 0, 0, 0, 0, 0, 0, 0, fellowParam)
            elseif (bond >= 60 and weaponlevel == 4) then
                player:startEvent(10070, 0, 0, 0, 0, 0, 0, 0, fellowParam)
            elseif (bond >= 90 and weaponlevel == 5) then
                player:startEvent(10076, 0, 0, 0, 0, 0, 0, 0, fellowParam)
            elseif (bond >= 110 and weaponlevel == 6) then
                player:startEvent(10077, 0, 0, 0, 0, 0, 0, 0, fellowParam)
            else
                player:startEvent(10047,244,14810,0,0,0,0,0,fellowParam)
            end
        else
            player:startEvent(10047,244,14810,0,0,0,0,0,fellowParam)
        end
    else
        player:startEvent(10041) -- Standard dialog
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
