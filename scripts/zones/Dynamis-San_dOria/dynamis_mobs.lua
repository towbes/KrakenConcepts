----------------------------------------------------------------------------------------------------
--                                      Dynamis-San d'Oria                                        --
--              Primary Source of Information: https://enedin.be/dyna/html/zone/san.htm           --
--           Secondary Source of Information: http://www.dynamisbums.com/strategy/san.html        --
--                       NOTE: Please refer to instructions for setup.                            --
----------------------------------------------------------------------------------------------------
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/dynamis")
require("scripts/globals/zone")
----------------------------------------------------------------------------------------------------
--                                      Instructions                                              --
----------------------------------------------------------------------------------------------------
-- CAUTION: Wherever a value is skipped insert nil.
--
-- 1. MobIndex information is derrived from the group ID used in Enedin.
--    Note: All mob indexes should have a comment with the full group ID.
--    Ex. 001-G should be converted to 1.
--    Ex. 054-Q should be converted to 54.
--
-- 2. Setup wave spawning based on MobIndex where applicable. Wave 1 is always spawned at the start.
--    Ex. mobList[zone].waves = { MobIndex, MobIndex, MobIndex }
--    Ex. mobList[zone].waves2 = { 1, 7, 12 }
--
-- 3. Setup wave spawning requirements. This is handled through a localvar set on the zone based on
--    the onMobDeath() function of the NM. By default this will only be the MegaBoss.
--    mobList[zone].waveDefeatRequirements[2] = {zone:getLocalVar("MegaBoss_Killed") == 1}
--
-- 4. Setup mob positions for spawns. This is only required for statues and mobs that do not spawn
--    from a statue, NM, or nightmare mob.
--    Ex. mobList[zone][MobIndex].pos = {xpos, ypos, zpos, rot}
--
-- 5. mobList[zone][MobIndex].info should be used to indicate the mob type and name.
--    Mob type indicates spawning pattern used. Mob Name will replace the name dynamically.
--    Mob Family is only required for beastmen NMs. Main Job is only required for beastmen NMs.
--    NOTE: These should only be made for non-standard/zone specific mobs.
--    Statue Ex. mobList[zone][MobIndex].info = {"Statue", "Sergeant Tombstone", nil, nil, nil}
--    Nightmare Ex. mobList[zone][MobIndex].info = {"Nightmare", "Nightmare Scorpion", nil, nil, nil}
--    Non-beastman NM Ex. mobList[zone][MobIndex].info = {"NM", "Apocalyptic Beast", nil, nil, "Apocalyptic_Beast_killed"}
--    Beastmen NM Ex. mobList[zone][MobIndex].info = {"NM", "ElvaanSticker Bxafraff", "Orc", "DRG", "ElvaanSticker_Bxafraff_killed"}
--
-- 6. mobList[zone][MobIndex].mobchildren is used to determine the number of each job to spawn.
--    To spawn a certain job, just put in the number of that job in the order of the job list 1-15.
--    This system will automatically determine what family each of these jobs encode to.
--    For Nightmare mob spawns, simply encode the number of children in mobList[zone][MobIndex].mobchildren[1] (aka #WAR).
--    Ex. mobList[zone][MobIndex].mobchildren = {#WAR, #MNK, #WHM, #BLM, #RDM, #THF, #PLD, #DRK, #BST, #BRD, #RNG, #SAM, #NIN, #DRG, #SMN}
--    Ex. For 2 Wars: mobList[zone][MobIndex].mobchildren = {2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil}
--
-- 7.  mobList[zone][MobIndex].NMchildren is used to spawn specific NMs outlined in mobList[zone][MobIndex].info
--     MobIndex is the index of the mob spawning the NM, MobIndex(NM) points to which NM in .info it should spawn.
--     Ex. mobList[zone][MobIndex].NMchildren = {MobIndex(NM1), MobIndex(NM2), MobIndex(NM3)}
--
-- 8. mobList[zone][MobIndex].patrolPath is used to set a specific path for a mob, if left blank for that MobIndex,
--    the mob will not path on a predetermined course. If it is a statue, it will not path at all. You can add
--    as many triplets of coordinates as desired.
--    Ex. mobList[zone][MobIndex].patrolPath = {xpos1,ypos1,zpos1, xpos2,ypos2,zpos2,  xpos3,ypos3,zpos3}
--
-- 9. mobList[zone][MobIndex].eyes sets the eye color of the statue. Valid options are:
--    dynamisEyesEra.RED, dynamisEyesEra.BLUE, dynamisEyesEra.GREEN
--    Ex. mobList[zone][MobIndex].eyes = dynamisEyesEra.BLUE -- Flags for blue eyes. (HP)
--    Ex. mobList[zone][MobIndex].eyes = dynamisEyesEra.GREEN -- Flags for green eyes. (MP)
--    Ex. mobList[zone][MobIndex].eyes = dynamisEyesEra.RED -- Flags for red eyes. (TE)
--
-- 10. mobList[zone][MobIndex].timeExtension dictates the amount of time given for the TE.
--    Ex. mobList[zone][MobIndex].timeExtension = 15
--
----------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------
--                               Dependency Setup Section (IGNORE)                                --
----------------------------------------------------------------------------------------------------
local zone = xi.zone.DYNAMIS_SAN_DORIA
mobList = mobList or { }
mobList[zone] ={ } -- Ignore me, I just start the table.
mobList[zone].zoneID = zone -- Ignore me, I just ensure .zoneID exists.
mobList[zone].waveDefeatRequirements = { } -- Ignore me, I just start the table.
mobList[zone].waveDefeatRequirements[1] = { } -- Ignore me, I just allow for wave 1 spawning.
mobList[zone].maxWaves = 6 -- Ignore me because Oph told me to
----------------------------------------------------------------------------------------------------
--                                  Setup of Parent Spawning                                      --
----------------------------------------------------------------------------------------------------
------------------------------------------
--               Mob Info               --
-- Note: Primarily used for mobs that   --
-- are NMs or parent mobs.              --
------------------------------------------
--mobList[zone][MobIndex].info = {"Statue/NM/Nightmare", "Mob Name", "Family", "Main Job", "MobLocalVarName"}

mobList[zone][1  ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 001-O/S
mobList[zone][2  ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 002-O/S
mobList[zone][3  ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 003-O/S
mobList[zone][4  ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 004-O/S
mobList[zone][5  ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 005-O/S
mobList[zone][6  ].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- 006-O/W(MP)
mobList[zone][7  ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 007-O/S(15)
mobList[zone][8  ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 008-O/S
mobList[zone][9  ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 009-O/S(15)
mobList[zone][10 ].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- 010-O/W(MP)
mobList[zone][11 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 011-O/S
mobList[zone][12 ].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- 012-O/W(HP)
mobList[zone][13 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 013-O/S
mobList[zone][14 ].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- 014-O/W(MP)
mobList[zone][15 ].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- 015-O/W(HP)
mobList[zone][16 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 016-O/S
mobList[zone][17 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 017-O/S
mobList[zone][18 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 018-O/S
mobList[zone][19 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 019-O/S
mobList[zone][20 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 020-O/S
mobList[zone][21 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 021-O/S
mobList[zone][22 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 022-O/S
mobList[zone][23 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 023-O/S
mobList[zone][24 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 024-O/S
mobList[zone][25 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 025-O/S
mobList[zone][26 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 026-O/S(25)
mobList[zone][27 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 027-O/S
mobList[zone][28 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 028-O/S
mobList[zone][29 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 029-O/S
mobList[zone][30 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 030-O/S
mobList[zone][31 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 031-O/S
mobList[zone][32 ].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- 032-O/W(MP)
mobList[zone][33 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 033-O/S
mobList[zone][34 ].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- 034-O/W(HP)
mobList[zone][35 ].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- 035-O/W(MP)
mobList[zone][36 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 036-O/S
mobList[zone][37 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 037-O/S
mobList[zone][38 ].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- 038-O/W(MP)
mobList[zone][39 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 039-O/S
mobList[zone][40 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 040-O/S
mobList[zone][41 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 041-O/S(30)
mobList[zone][42 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 042-O/S
mobList[zone][43 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 043-O/S
mobList[zone][44 ].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- 044-O/W(HP)
mobList[zone][45 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 045-O/S
mobList[zone][46 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 046-O/S
mobList[zone][47 ].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- 047-O/W(MP)
mobList[zone][48 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 048-O/S
mobList[zone][49 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 049-O/S
mobList[zone][50 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 050-O/S
mobList[zone][51 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 051-O/S
mobList[zone][52 ].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- 052-O/W(HP)
mobList[zone][53 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 053-O/S
mobList[zone][54 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 054-O/S
mobList[zone][55 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 055-O/S
mobList[zone][56 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 056-O/S
mobList[zone][57 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 057-O/S
mobList[zone][58 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 058-O/S
mobList[zone][59 ].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- 059-O/W(HP)
mobList[zone][60 ].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- 060-O/W(MP)
mobList[zone][61 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 061-O/S
mobList[zone][62 ].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- 062-O/W(MP)
mobList[zone][63 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 063-O/S
mobList[zone][64 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 064-O/S(25)
mobList[zone][65 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 065-O/S
mobList[zone][66 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 066-O/S
mobList[zone][67 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 067-O/S
mobList[zone][68 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 068-O/S
mobList[zone][69 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 069-O/S
mobList[zone][70 ].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- 070-O/W(MP)
mobList[zone][71 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 071-O/S
mobList[zone][72 ].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- 072-O/W(HP)
mobList[zone][73 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 073-O/S
mobList[zone][74 ].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- 074-O/W(10)
mobList[zone][75 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 075-O/S
mobList[zone][76 ].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- 076-O/W(MP)
mobList[zone][77 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 077-O/S
mobList[zone][78 ].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- 078-O/W(HP)
mobList[zone][79 ].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- 079-O/W(MP)
mobList[zone][80 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 080-O/S
mobList[zone][81 ].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- 081-O/W(HP)
mobList[zone][82 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 082-O/S
mobList[zone][83 ].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- 083-O/W(HP)
mobList[zone][84 ].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- 084-O/W(MP)
mobList[zone][85 ].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- 085-O/W(HP)
mobList[zone][86 ].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- 086-O/W(MP)
mobList[zone][87 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 087-O/S
mobList[zone][88 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 088-O/S
mobList[zone][89 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 089-O/S
mobList[zone][90 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 090-O/S
mobList[zone][91 ].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- 091-O/W(HP)
mobList[zone][92 ].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- 092-O/W(MP)
mobList[zone][93 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 093-O/S
mobList[zone][94 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 094-O/S
mobList[zone][95 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 095-O/S
mobList[zone][96 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 096-O/S
mobList[zone][97 ].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- 097-O/W(HP)
mobList[zone][98 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 098-O/S
mobList[zone][99 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 099-O/S
mobList[zone][100].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 100-O/S
mobList[zone][101].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 101-O/S
mobList[zone][102].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 102-O/S
mobList[zone][103].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- 103-O/W(HP)
mobList[zone][104].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- 104-O/W(HP)
mobList[zone][105].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 105-O/S
mobList[zone][106].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 106-O/S
mobList[zone][107].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- 107-O/W(HP)
mobList[zone][108].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- 108-O/W(MP)
mobList[zone][110].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- 110-O/W(MP)
mobList[zone][111].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- 111-O/W(MP)
mobList[zone][112].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 112-O/S
mobList[zone][113].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- 113-O/W(HP)
mobList[zone][114].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 114-O/S
mobList[zone][115].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- 115-O/W(HP)
mobList[zone][116].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 116-O/S
mobList[zone][117].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 117-O/S
mobList[zone][118].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 118-O/S
mobList[zone][119].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 119-O/S
mobList[zone][120].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 120-O/S
mobList[zone][121].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 121-O/S
mobList[zone][122].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 122-O/S
mobList[zone][123].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 123-O/S
mobList[zone][124].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 124-O/S
mobList[zone][125].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 125-O/S
mobList[zone][126].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 126-O/S
mobList[zone][127].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 127-O/S
mobList[zone][128].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 128-O/S
mobList[zone][129].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 129-O/S
mobList[zone][130].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 130-O/S
mobList[zone][131].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 131-O/S
mobList[zone][132].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 132-O/S
mobList[zone][133].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 133-O/S
mobList[zone][134].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 134-O/S
mobList[zone][135].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 135-O/S
mobList[zone][136].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 136-O/S
mobList[zone][137].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 137-O/S
mobList[zone][138].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 138-O/S
mobList[zone][139].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 139-O/S
mobList[zone][140].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 140-O/S
mobList[zone][141].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 141-O/S
mobList[zone][142].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 142-O/S
mobList[zone][143].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 143-O/S
mobList[zone][144].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 144-O/S
mobList[zone][145].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 145-O/S
mobList[zone][146].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 146-O/S
mobList[zone][147].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 147-O/S
mobList[zone][148].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 148-O/S
mobList[zone][149].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 149-O/S
mobList[zone][150].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- 150-O/S

-- NM's and Megaboss
mobList[zone][109].info = {"NM", "Overlord's Tombstone",     nil,   nil,    "MegaBoss_Killed" } -- 109-Replica NM (Overlord's Tombstone)
mobList[zone][151].info = {"NM", "Wyrmgnasher Bjakdek",      "Orc", "DRG",  "Wyrmgnasher_Bjakdek_Killed"} -- DRG NM
mobList[zone][152].info = {"NM", "Reapertongue Gadgquok",    "Orc", "SMN",  "Reapertongue_Gadgquok_Killed"} -- SMN NM
mobList[zone][153].info = {"NM", "Voidstreaker Butchnotch",  "Orc", "NIN",  "Voidstreaker_Butchnotch_Killed"} -- NIN NM
mobList[zone][154].info = {"NM", "Battlechoir Gitchfotch",   "Orc", "BRD",  nil} -- BRD NM
mobList[zone][155].info = {"NM", "Soulsender Fugbrag",       "Orc", "BRD",  nil} -- BRD NM

----------------------------------------------------------------------------------------------------
--                                    Setup of Wave Spawning                                      --
----------------------------------------------------------------------------------------------------

---------------------------------------------
--           Wave Defeat Reqs.          --
--------------------------------------------
--mobList[zone].waveDefeatRequirements[2] = {zone:getLocalVar("MegaBoss_Killed") == 1}

mobList[zone].waveDefeatRequirements[2] = {zone:getLocalVar("Voidstreaker_Butchnotch_Killed") == 1}
mobList[zone].waveDefeatRequirements[3] = {zone:getLocalVar("MegaBoss_Killed") == 1}
mobList[zone].waveDefeatRequirements[4] = {zone:getLocalVar("Wyrmgnasher_Bjakdek_Killed") == 1, zone:getLocalVar("Reapertongue_Gadgquok_Killed") == 1}
mobList[zone].waveDefeatRequirements[5] = {zone:getLocalVar("Wyrmgnasher_Bjakdek_Killed") == 1}
mobList[zone].waveDefeatRequirements[6] = {zone:getLocalVar("Reapertongue_Gadgquok_Killed") == 1}

------------------------------------------
--            Wave Spawning             --
-- Note: Wave 1 spawns at start.        --
------------------------------------------
--mobList[zone][MobIndex].waves = { 1,nil,nil }

-- Wave 1 Spawns on loading the zone

mobList[zone].wave1 = {
    1  ,    -- 001-O/S
    2  ,    -- 002-O/S
    3  ,    -- 003-O/S
    4  ,    -- 004-O/S
    5  ,    -- 005-O/S
    6  ,    -- 006-O/W(MP)
    7  ,    -- 007-O/S(15)
    8  ,    -- 008-O/S
    9  ,    -- 009-O/S(15)
    10 ,    -- 010-O/W(MP)
    11 ,    -- 011-O/S
    12 ,    -- 012-O/W(HP)
    13 ,    -- 013-O/S
    14 ,    -- 014-O/W(MP)
    15 ,    -- 015-O/W(HP)
    16 ,    -- 016-O/S
    17 ,    -- 017-O/S
    18 ,    -- 018-O/S
    20 ,    -- 020-O/S
    22 ,    -- 022-O/S
    23 ,    -- 023-O/S
    24 ,    -- 024-O/S
    25 ,    -- 025-O/S
    26 ,    -- 026-O/S(25)
    27 ,    -- 027-O/S
    28 ,    -- 028-O/S
    29 ,    -- 029-O/S
    30 ,    -- 030-O/S
    31 ,    -- 031-O/S
    32 ,    -- 032-O/W(MP)
    33 ,    -- 033-O/S
    34 ,    -- 034-O/W(HP)
    35 ,    -- 035-O/W(MP)
    37 ,    -- 037-O/S
    38 ,    -- 038-O/W(MP)
    39 ,    -- 039-O/S
    40 ,    -- 040-O/S
    41 ,    -- 041-O/S(30)
    42 ,    -- 042-O/S
    43 ,    -- 043-O/S
    44 ,    -- 044-O/W(HP)
    45 ,    -- 045-O/S
    46 ,    -- 046-O/S
    47 ,    -- 047-O/W(MP)
    48 ,    -- 048-O/S
    49 ,    -- 049-O/S
    50 ,    -- 050-O/S
    51 ,    -- 051-O/S
    52 ,    -- 052-O/W(HP)
    53 ,    -- 053-O/S
    54 ,    -- 054-O/S
    55 ,    -- 055-O/S
    56 ,    -- 056-O/S
    57 ,    -- 057-O/S
    58 ,    -- 058-O/S
    59 ,    -- 059-O/W(HP)
    60 ,    -- 060-O/W(MP)
    61 ,    -- 061-O/S
    62 ,    -- 062-O/W(MP)
    63 ,    -- 063-O/S
    64 ,    -- 064-O/S(25)
    65 ,    -- 065-O/S
    66 ,    -- 066-O/S
    67 ,    -- 067-O/S
    68 ,    -- 068-O/S
    69 ,    -- 069-O/S
    70 ,    -- 070-O/W(MP)
    71 ,    -- 071-O/S
    72 ,    -- 072-O/W(HP)
    73 ,    -- 073-O/S
    74 ,    -- 074-O/W(10)
    75 ,    -- 075-O/S
    76 ,    -- 076-O/W(MP)
    77 ,    -- 077-O/S
    78 ,    -- 078-O/W(HP)
    79 ,    -- 079-O/W(MP)
    80 ,    -- 080-O/S
    81 ,    -- 081-O/W(HP)
    82 ,    -- 082-O/S
    83 ,    -- 083-O/W(HP)
    84 ,    -- 084-O/W(MP)
    85 ,    -- 085-O/W(HP)
    86 ,    -- 086-O/W(MP)
    87 ,    -- 087-O/S
    88 ,    -- 088-O/S
    89 ,    -- 089-O/S
    90 ,    -- 090-O/S
    91 ,    -- 091-O/W(HP)
    92 ,    -- 092-O/W(MP)
    93 ,    -- 093-O/S
    96 ,    -- 096-O/S
    97 ,    -- 097-O/W(HP)
    98 ,    -- 098-O/S
    99 ,    -- 099-O/S
    102,    -- 102-O/S
    103,    -- 103-O/W(HP)
    104,    -- 104-O/W(HP)
    105,    -- 105-O/S
    106,    -- 106-O/S
    107,    -- 107-O/W(HP)
    108     -- 108-O/W(MP)
}

-- Wave 2 spawns when Voidstreaker Butchnotch (NIN) is defeated
mobList[zone].wave2 = {
    145,	-- 145-O/S
    146,	-- 146-O/S
    147,	-- 147-O/S
    149	    -- 149-O/S
}

-- Wave 3 spawns when Overlord's Tombstone (Mega Boss) is defeated
mobList[zone].wave3 = {
    116,    -- 116-O/S
    117,    -- 117-O/S
    118,    -- 118-O/S
    119,    -- 119-O/S
    120,    -- 120-O/S
    121,    -- 121-O/S
    122,    -- 122-O/S
    123,    -- 123-O/S
    124,    -- 124-O/S
    125,    -- 125-O/S
    126,    -- 126-O/S
    127,    -- 127-O/S
    128,    -- 128-O/S
    129,    -- 129-O/S
    130,    -- 130-O/S
    131,    -- 131-O/S
    132,    -- 132-O/S
    133,    -- 133-O/S
    134,    -- 134-O/S
    135,    -- 135-O/S
    136,    -- 136-O/S
    137,    -- 137-O/S
    138,    -- 138-O/S
    139,    -- 139-O/S
    140,    -- 140-O/S
}

-- Kill of Wyrmgnasher Bjakdek and Reapertongue Gadgquok to spawn Overlords Tombstone
mobList[zone].wave4 = {
    109     -- 109-Replica NM (Overlord's Tombstone)
}

-- Two statues spawn near entrance and opposite tent when Wyrmgnasher Bjakdek is killed

mobList[zone].wave5 = {
    61,     -- 061-O/S
    143,    -- 143-O/S
    144     -- 144-O/S
}

-- Two statues spawn near entrance and opposite tent when Reapertongue Gadgquok is killed
mobList[zone].wave6 = {
    36,     -- 036-O/S
    141,    -- 141-O/S
    142     -- 142-O/S
}

----------------------------------------------------------------------------------------------------
--                                  Setup of Children Spawning                                    --
----------------------------------------------------------------------------------------------------
------------------------------------------
--          Normal Child Spawn          --
------------------------------------------
-- mobList[zone][MobIndex].mobchildren = {#WAR, #MNK, #WHM, #BLM, #RDM, #THF, #PLD, #DRK, #BST, #BRD, #RNG, #SAM, #NIN, #DRG, #SMN}

mobList[zone][1  ].mobchildren = { 2,   nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 WAR
mobList[zone][2  ].mobchildren = { nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 MNK
mobList[zone][3  ].mobchildren = { nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 MNK
mobList[zone][4  ].mobchildren = { nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 RDM
mobList[zone][5  ].mobchildren = { nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 RDM
mobList[zone][6  ].mobchildren = { nil,   3, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 3 MNK
mobList[zone][8  ].mobchildren = { nil, nil, nil, nil, nil, nil,   1,   1, nil, nil, nil, nil, nil, nil, nil  } -- 1 PLD, 1 DRK
mobList[zone][9  ].mobchildren = {   2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 WAR
mobList[zone][10 ].mobchildren = { nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 RDM
mobList[zone][11 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil  } -- 2 DRG
mobList[zone][12 ].mobchildren = { nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 WHM
mobList[zone][13 ].mobchildren = { nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 THF
mobList[zone][14 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil  } -- 2 NIN
mobList[zone][15 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil  } -- 2 SAM
mobList[zone][17 ].mobchildren = { nil,   1, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 MNK, 2 BLM
mobList[zone][19 ].mobchildren = { nil, nil, nil,   2, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil  } -- 2 BLM, 1 BST
mobList[zone][21 ].mobchildren = { nil, nil, nil, nil, nil, nil,   1, nil, nil, nil,   2, nil, nil, nil, nil  } -- 1 PLD, 2 RNG
mobList[zone][22 ].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 THF
mobList[zone][23 ].mobchildren = { nil, nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 WHM, 1 BLM
mobList[zone][24 ].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 THF
mobList[zone][28 ].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil,   1, nil, nil, nil, nil, nil  } -- 1 THF, 1 BRD
mobList[zone][29 ].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil,   1, nil, nil, nil, nil, nil  } -- 1 THF, 1 BRD
mobList[zone][29 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil  } -- 2 RNG
mobList[zone][30 ].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil,   1, nil, nil, nil, nil, nil  } -- 1 THF, 1 BRD
mobList[zone][30 ].mobchildren = { nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 WHM
mobList[zone][32 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil  } -- 2 DRK
mobList[zone][36 ].mobchildren = { nil, nil, nil, nil, nil,   2, nil, nil, nil,   1, nil, nil, nil, nil, nil  } -- 2 THF, 1 BRD
mobList[zone][37 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil  } -- 2 SAM
mobList[zone][38 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil  } -- 2 BST
mobList[zone][39 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil  } -- 2 RNG
mobList[zone][40 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil  } -- 2 NIN
mobList[zone][41 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, } -- 2 SMN
mobList[zone][42 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, } -- 2 SMN
mobList[zone][43 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, } -- 2 SMN
mobList[zone][44 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, } -- 2 SMN
mobList[zone][45 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil  } -- 2 RNG
mobList[zone][46 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil  } -- 2 NIN
mobList[zone][47 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil  } -- 2 BST
mobList[zone][48 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil  } -- 2 SAM
mobList[zone][49 ].mobchildren = {   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 WAR, 1 MNK
mobList[zone][50 ].mobchildren = { nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 WHM
mobList[zone][51 ].mobchildren = {   2, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 WAR, 1 PLD
mobList[zone][52 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil  } -- 2 RNG
mobList[zone][53 ].mobchildren = {   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 WAR, 1 MNK
mobList[zone][54 ].mobchildren = { nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 WHM
mobList[zone][55 ].mobchildren = { nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 WHM
mobList[zone][56 ].mobchildren = { nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 THF
mobList[zone][57 ].mobchildren = { nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 WHM
mobList[zone][58 ].mobchildren = { nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 PLD
mobList[zone][61 ].mobchildren = { nil,   2, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil  } -- 2 MNK, 1 BRD
mobList[zone][66 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil  } -- 2 DRK
mobList[zone][67 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil  } -- 2 DRG
mobList[zone][68 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil  } -- 2 BST
mobList[zone][69 ].mobchildren = { nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 RDM
mobList[zone][70 ].mobchildren = { nil,   2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 MNK
mobList[zone][71 ].mobchildren = { nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 BLM
mobList[zone][73 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil  } -- 2 SAM
mobList[zone][74 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1,   1, nil, nil  } -- 1 SAM, 1 NIN
mobList[zone][75 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil  } -- 2 NIN
mobList[zone][76 ].mobchildren = { nil, nil,   2, nil, nil, nil, nil, nil, nil, nil,   3, nil, nil, nil, nil  } -- 2 WHM, 3 RNG
mobList[zone][77 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil  } -- 2 DRK
mobList[zone][78 ].mobchildren = { nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 BLM
mobList[zone][79 ].mobchildren = { nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 WHM
mobList[zone][80 ].mobchildren = { nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 RDM
mobList[zone][81 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil  } -- 2 BST
mobList[zone][82 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil  } -- 1 BST
mobList[zone][83 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil  } -- 2 BST
mobList[zone][85 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil  } -- 2 BST
mobList[zone][87 ].mobchildren = { nil, nil, nil,   2,   2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 BLM, 2 RDM
mobList[zone][88 ].mobchildren = { nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 PLD
mobList[zone][89 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   3, nil, nil, nil, nil  } -- 3 RNG
mobList[zone][90 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil  } -- 2 DRK
mobList[zone][91 ].mobchildren = {   2, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 WAR, 1 RDM
mobList[zone][92 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil  } -- 2 BRD
mobList[zone][94 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil  } -- 2 NIN
mobList[zone][95 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil  } -- 2 NIN
mobList[zone][96 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil  } -- 2 DRG
mobList[zone][97 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil  } -- 2 RNG
mobList[zone][98 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil  } -- 2 DRG
mobList[zone][100].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil  } -- 1 BRD
mobList[zone][101].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil  } -- 1 BRD
mobList[zone][102].mobchildren = {   2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil  } -- 2 WAR, 2 DRG
mobList[zone][104].mobchildren = { nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 PLD
mobList[zone][105].mobchildren = { nil, nil, nil, nil,   2, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil  } -- 2 RDM, 2 DRK
mobList[zone][106].mobchildren = {   2, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 WAR, 2 PLD
mobList[zone][107].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil  } -- 2 NIN
mobList[zone][108].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil  } -- 2 SAM
mobList[zone][109].mobchildren = {   2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 WAR
mobList[zone][110].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   3, } -- 3 SMN
mobList[zone][111].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   3, nil  } -- 3 DRG
mobList[zone][116].mobchildren = { nil, nil, nil,   2, nil, nil, nil,   3, nil, nil, nil, nil, nil, nil, nil  } -- 2 BLM, 3 DRK
mobList[zone][117].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   3, nil, nil, nil, nil, nil, nil  } -- 3 BST
mobList[zone][118].mobchildren = { nil, nil, nil, nil,   2, nil, nil, nil, nil,   2, nil,   2, nil, nil, nil  } -- 2 RDM, 2 BRD, 2 SAM
mobList[zone][119].mobchildren = { nil, nil, nil, nil, nil,   2,   3, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 THF, 3 PLD
mobList[zone][120].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   3, nil  } -- 3 DRG
mobList[zone][121].mobchildren = {   2, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 WAR, 2 WHM
mobList[zone][122].mobchildren = { nil,   3,   2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 3 MNK, 2 WHM
mobList[zone][123].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil,   2, } -- 2 BRD, 2 SMN
mobList[zone][124].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, } -- 2 SMN
mobList[zone][125].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   3, nil  } -- 3 DRG
mobList[zone][126].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   4, nil, nil  } -- 4 NIN
mobList[zone][127].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   3, nil, nil, nil  } -- 3 SAM
mobList[zone][128].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   3, nil, nil, nil, nil  } -- 3 RNG
mobList[zone][129].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil,   3, nil, nil, nil, nil, nil  } -- 3 BRD
mobList[zone][130].mobchildren = { nil, nil, nil, nil, nil,   3, nil, nil, nil,   2, nil, nil, nil, nil, nil  } -- 3 THF, 2 BRD
mobList[zone][131].mobchildren = { nil, nil, nil,   2,   2, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil  } -- 2 BLM, 2 RDM, 2 SAM
mobList[zone][132].mobchildren = { nil, nil, nil, nil, nil,   3, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 3 THF
mobList[zone][133].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   3, nil, nil, nil, nil, nil, nil  } -- 3 BST
mobList[zone][134].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   3, nil, nil, nil, nil, nil, nil, nil  } -- 3 DRK
mobList[zone][135].mobchildren = { nil, nil, nil, nil, nil, nil,   3, nil, nil, nil, nil, nil, nil, nil, nil  } -- 3 PLD
mobList[zone][136].mobchildren = { nil, nil, nil, nil,   3, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 3 RDM
mobList[zone][137].mobchildren = { nil, nil,   3, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 3 WHM
mobList[zone][138].mobchildren = { nil,   3, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 3 MNK
mobList[zone][139].mobchildren = {   3, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 3 WAR
mobList[zone][140].mobchildren = { nil, nil, nil,   3, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 3 BLM
mobList[zone][141].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil  } -- 1 SAM
mobList[zone][142].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil  } -- 1 SAM
mobList[zone][143].mobchildren = { nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 MNK
mobList[zone][144].mobchildren = { nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 MNK
mobList[zone][145].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   3, nil, nil, nil, nil, nil, nil, nil  } -- 3 DRK
mobList[zone][146].mobchildren = { nil, nil, nil, nil, nil, nil,   3, nil, nil, nil, nil, nil, nil, nil, nil  } -- 3 PLD
mobList[zone][147].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, } -- 2 SMN
mobList[zone][149].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, } -- 2 SMN

------------------------------------------
--            NM Child Spawn            --
------------------------------------------
-- mobList[zone][MobIndex].NMchildren = {MobIndex(NM1), MobIndex(NM2), MobIndex(NM3)}
-- boolean value = forceLink true/false

--Specific Statues
mobList[zone][18 ].NMchildren = { false, 19 }                   -- Squire Square N, Spawns another statue
mobList[zone][20 ].NMchildren = { false, 21 }                   -- Squire Square E, Spawns another statue
mobList[zone][99 ].NMchildren = { true,  100, 101 }             -- Courtyard/WD Alley connector +2 stats
mobList[zone][147].NMchildren = { false, 148 }                  -- West Tent spawns one middle statue
mobList[zone][149].NMchildren = { false, 150 }                  -- East Tent spawns one middle statue

-- NMs
mobList[zone][32 ].NMchildren = { true, 151 }                                    -- Eastgate NM Wyrmgnasher Bjakdek (DRG)
mobList[zone][70 ].NMchildren = { true, 152 }                                    -- Westgate NM Reapertongue Gadguok (SMN)
mobList[zone][93 ].NMchildren = { true, 153, 94, 95 }                            -- Manor NM Voidstreaker Butchnotch (NIN) as well as N/S manor pop statues
mobList[zone][109].NMchildren = { true, 154, 155, 110, 111, 112, 113, 114, 115 } -- Megaboss spawns twin BRD NMs Battlechoir Gitchfotch and Soulsender Fugbrag and a bunch of statues

------------------------------------------
--          Mob Position Info           --
-- Note: Must be setup for parent mobs, --
-- but is optional for children.        --
------------------------------------------
-- mobList[zone][MobIndex].pos = {xpos, ypos, zpos, rot}

mobList[zone][1  ].pos = {  137.0790, -2.0000,  105.1504, 225   } -- Residential Area
mobList[zone][2  ].pos = {  116.4000,  0.0000,   91.6443, 225   } -- Lion Square Fount. N
mobList[zone][3  ].pos = {  123.5808,  0.0000,   84.2734, 225   } -- Lion Square Fount. E
mobList[zone][4  ].pos = {  112.5138,  0.0000,   87.5595, 225   } -- Lion Square Fount. W
mobList[zone][5  ].pos = {  119.8963,  0.0000,   80.3786, 225   } -- Lion Square Fount. S
mobList[zone][6  ].pos = {  100.0876,  1.0000,  103.6861, 32    } -- Lion Tavern
mobList[zone][7  ].pos = {  104.0628,  1.9165,   72.0631, 226   } -- on stair, SW of Lion Squ
mobList[zone][8  ].pos = {   98.8329,  4.0000,   68.6029, 255   } -- Helbort's Blades N
mobList[zone][9  ].pos = {   93.7486,  4.0000,   56.9143, 255   } -- Helbort's Blades S
mobList[zone][10 ].pos = {  101.2500,  4.0000,   50.0912, 160   } -- Door Across Helbort's Bl
mobList[zone][11 ].pos = {   94.8431,  4.0000,   38.0928, 1     } -- Rosel's Armour
mobList[zone][12 ].pos = {  101.4410,  4.0000,   32.0477, 151   } -- Door Across Rosel's Armo
mobList[zone][13 ].pos = {   97.8056,  4.0000,   45.2697, 194   } -- Alleyway, Btw. Wep+Armor
mobList[zone][14 ].pos = {  112.9542,  2.0000,   14.0701, 127   } -- Sq.Alley SW2
mobList[zone][15 ].pos = {  130.5417,  0.0000,   14.2169, 127   } -- Sq.Alley SW
mobList[zone][16 ].pos = {  143.5072,  0.0000,   27.3608, 94    } -- Sq.Alley S
mobList[zone][17 ].pos = {  147.7160,  0.0000,   42.0697, 177   } -- Sq.Alley C
mobList[zone][18 ].pos = {  140.8978,  0.0000,   55.7513, 165   } -- Sq.Alley N
mobList[zone][19 ].pos = {  142.4358,  0.0000,   69.3664, 70    } -- Sq.Alley Under Staircase
mobList[zone][20 ].pos = {  144.9005,  0.0000,   59.3423, 161   } -- Sq.Alley Northern Bldg.
mobList[zone][21 ].pos = {  156.4780, -1.0000,   41.9830, 128   } -- Sq.Alley Eastern Bldg.
mobList[zone][22 ].pos = {   79.7930,  2.0000,   12.7828, 33    } -- Cavalry Way Stair W
mobList[zone][23 ].pos = {   86.0373,  2.0000,    6.8098, 224   } -- Cavalry Way Stair C
mobList[zone][24 ].pos = {   93.6929,  2.0000,   -0.2982, 158   } -- Cavalry Way Stair E
mobList[zone][25 ].pos = {   76.0000,  2.0000,   -4.0000, 160   } -- Eastgate Outside E
mobList[zone][26 ].pos = {   68.0000,  2.0000,  -12.0000, 160   } -- Eastgate Outside C
mobList[zone][27 ].pos = {   60.0000,  2.0000,  -20.0000, 160   } -- Eastgate Outside W
mobList[zone][28 ].pos = {   92.3483,  2.0000,  -20.5081, 160   } -- Eastgate Arches E
mobList[zone][29 ].pos = {   83.9514,  2.0000,  -28.2492, 160   } -- Eastgate Arches C
mobList[zone][30 ].pos = {   76.0243,  2.0000,  -36.1443, 160   } -- Eastgate Arches W
mobList[zone][31 ].pos = {  100.0918,  1.0000,  -36.0744, 154   } -- Eastgate E
mobList[zone][32 ].pos = {   97.2104,  1.0000,  -41.3545, 160   } -- Eastgate C
mobList[zone][33 ].pos = {   92.1923,  1.0000,  -44.0674, 166   } -- Eastgate W
mobList[zone][34 ].pos = {   85.4025,  1.0000,  -70.3379, 188   } -- Eastgate Far Corner
mobList[zone][35 ].pos = {   55.7694, -8.6001,  -30.0464, 192   } -- W of Eastgate Entrance
mobList[zone][36 ].pos = {   67.5852,  2.0000,   -3.5269, 32    } -- W2 Btw. Street Vendors b
mobList[zone][37 ].pos = {   40.0124,  2.0000,  -29.8986, 232   } -- Near AH: Choco Tunnel E
mobList[zone][38 ].pos = {   28.0243,  2.0000,  -18.3093, 64    } -- Near AH: E Tent
mobList[zone][39 ].pos = {   20.0000,  2.0000,    5.0000, 64    } -- Victory Square SE
mobList[zone][40 ].pos = {   20.0000,  0.0000,   24.0000, 64    } -- Victory Square NE
mobList[zone][41 ].pos = {    0.0000,  0.5000,   13.0000, 64    } -- Victory Square Main Path
mobList[zone][42 ].pos = {    5.0000,  0.0000,   22.0000, 64    } -- Victory Square Main Path
mobList[zone][43 ].pos = {   -5.0000,  0.0000,   22.0000, 64    } -- Victory Square Main Path
mobList[zone][44 ].pos = {   -0.0834,  2.0000,   -8.9377, 64    } -- Near AH: Between Tents
mobList[zone][45 ].pos = {  -20.0000,  0.0000,   24.0000, 64    } -- Victory Square NW
mobList[zone][46 ].pos = {  -20.0000,  2.0000,    5.0000, 64    } -- Victory Square SW
mobList[zone][47 ].pos = {  -28.0377,  2.0000,  -17.1347, 64    } -- Near AH: W Tent
mobList[zone][48 ].pos = {  -39.8505,  2.0000,  -29.8840, 150   } -- Near AH: Choco Tunnel W
mobList[zone][49 ].pos = {  -13.9513,  1.7000,  -29.0579, 192   } -- AH: W
mobList[zone][50 ].pos = {  -11.0031, -3.0000,  -33.8110, 192   } -- AH: Atop W
mobList[zone][51 ].pos = {   -0.0485,  1.7000,  -25.1019, 192   } -- AH: C
mobList[zone][52 ].pos = {   -1.0120, -3.0000,  -35.0168, 192   } -- AH: Atop C
mobList[zone][53 ].pos = {   14.0580,  1.7000,  -28.4680, 192   } -- AH: E
mobList[zone][54 ].pos = {   11.0112, -3.0000,  -33.8374, 192   } -- AH: Atop E
mobList[zone][55 ].pos = {  -12.3592,  2.0000,  -73.7705, 249   } -- Choco Stable W
mobList[zone][56 ].pos = {   -7.7872,  2.0000,  -80.4531, 240   } -- Choco Stable S
mobList[zone][57 ].pos = {    5.4815,  2.0000,  -74.6288, 241   } -- Choco Stable E
mobList[zone][58 ].pos = {    6.3619,  2.2000,  -86.8097, 161   } -- Choco Stable Gate
mobList[zone][59 ].pos = {   18.1228,  2.2000,  -96.3732, 192   } -- Choco Stable Grass W
mobList[zone][60 ].pos = {   23.1852,  2.2000,  -96.2487, 192   } -- Choco Stable Grass E
mobList[zone][61 ].pos = {  -66.9165,  2.0000,   -3.3724, 96    } -- Between Street Vendors b
mobList[zone][62 ].pos = {  -55.8101, -8.6000,  -30.2507, 192   } -- E of Westgate Entrance
mobList[zone][63 ].pos = {  -72.0000,  2.0000,  -32.0000, 224   } -- Westgate Outside E
mobList[zone][64 ].pos = {  -68.0000,  2.0000,  -12.0000, 224   } -- Westgate Outside C
mobList[zone][65 ].pos = {  -88.0000,  2.0000,  -16.0000, 224   } -- Westgate Outside W
mobList[zone][66 ].pos = {  -78.5584,  2.0000,  -38.5455, 224   } -- Westgate Arches E
mobList[zone][67 ].pos = {  -86.5756,  2.0000,  -30.6161, 224   } -- Westgate Arches C
mobList[zone][68 ].pos = {  -94.4234,  2.0000,  -22.1406, 224   } -- Westgate Arches W
mobList[zone][69 ].pos = {  -91.8674,  1.0000,  -44.1162, 224   } -- Westgate E
mobList[zone][70 ].pos = {  -97.3463,  1.0000,  -41.3016, 224   } -- Westgate C
mobList[zone][71 ].pos = { -100.0368,  1.0000,  -36.6710, 224   } -- Westgate W
mobList[zone][72 ].pos = { -127.4794,  1.0000,  -29.5681, 5     } -- Westgate Far Corner
mobList[zone][73 ].pos = {  -92.8513, -2.0000,   22.3543, 32    } -- Stairs to W District E
mobList[zone][74 ].pos = {  -97.5497, -2.0000,   17.4388, 32    } -- Stairs to W District C
mobList[zone][75 ].pos = { -103.0301, -2.0000,   12.5769, 32    } -- Stairs to W District W
mobList[zone][76 ].pos = { -111.2418, -2.0000,   30.9008, 32    } -- Raimbroy's Grocery
mobList[zone][77 ].pos = { -114.0525, -2.0000,   16.5393, 12    } -- Guarding Entr. to Atop W
mobList[zone][78 ].pos = { -130.7194, -2.0000,   18.6867, 247   } -- Between Raimbroy's and T
mobList[zone][79 ].pos = { -141.3845, -2.0000,   18.2596, 0     } -- Taumila's Sundries
mobList[zone][80 ].pos = { -156.1573, -2.2000,   25.2480, 65    } -- Entrance to Raimbroy's C
mobList[zone][81 ].pos = { -174.8346, -1.0000,   24.6105, 217   } -- LW Guild E
mobList[zone][82 ].pos = { -175.0301, -1.5000,   36.6927, 95    } -- Across LW Guild
mobList[zone][83 ].pos = { -186.9280, -1.0000,   37.5468, 237   } -- LW Guild W
mobList[zone][84 ].pos = { -172.7534, -8.8000,   15.4853, 190   } -- LW Guild Catwalks S
mobList[zone][85 ].pos = { -184.4630, -1.0000,   27.4167, 224   } -- LW Guild C
mobList[zone][86 ].pos = { -196.5302, -8.8000,   39.1053, 251   } -- LW Guild Catwalks N
mobList[zone][87 ].pos = { -194.0204, -1.5000,   57.7439, 63    } -- Pikeman's Way S
mobList[zone][88 ].pos = { -193.5726, -2.0000,   68.4073, 63    } -- Pikeman's Way C
mobList[zone][89 ].pos = { -187.3062, -8.8000,   84.3538, 53    } -- Pikeman's Way Catwalks
mobList[zone][90 ].pos = { -203.9909, -2.0000,   88.3699, 33    } -- Pikeman's Way N
mobList[zone][91 ].pos = { -221.7831, -2.0000,   98.2201, 0     } -- Path to Manor
mobList[zone][92 ].pos = { -240.9783, -4.0000,   98.0767, 0     } -- Stairs to Manor
mobList[zone][93 ].pos = { -268.0030, -4.0000,   97.9851, 0     } -- Manor
mobList[zone][94 ].pos = { -257.8550, -3.6000,  117.6251, 51    } -- Manor Pop N
mobList[zone][95 ].pos = { -257.8173, -3.6000,   82.3046, 207   } -- Manor Pop S
mobList[zone][96 ].pos = { -166.8674, -2.0000,   54.1991, 142   } -- Courtyard SW
mobList[zone][97 ].pos = { -159.2271, -2.0000,   67.6593, 113   } -- Courtyard N
mobList[zone][98 ].pos = { -152.3566, -2.0000,   54.9211, 133   } -- Courtyard SE
mobList[zone][99 ].pos = { -132.2272, -4.0000,   70.2963, 64    } -- Courtyard to WD Alley Co
mobList[zone][100].pos = { -132.1907, -4.5000,   74.1945, 64    } -- Back of Watchdog Alley #
mobList[zone][101].pos = { -132.1623, -5.2500,   77.2359, 64    } -- Back of Watchdog Alley #
mobList[zone][102].pos = { -139.4806, -6.0000,   90.0122, 3     } -- Watchdog Alley Catwalk E
mobList[zone][103].pos = { -125.7547, -6.0000,   89.0013, 10    } -- Watchdog Alley NW
mobList[zone][104].pos = { -137.6403,-10.8000,   65.0534, 32    } -- Courtyard Catwalk
mobList[zone][105].pos = { -110.3660, -6.0000,   86.0028, 24    } -- Watchdog Alley N
mobList[zone][106].pos = {  -94.2479, -6.0000,   74.2410, 57    } -- Watchdog Alley C
mobList[zone][107].pos = {  -89.7747, -4.0000,   49.9768, 81    } -- Watchdog Alley S
mobList[zone][108].pos = {  -94.6474, -4.0000,   41.1507, 95    } -- Watchdog Alley Stairs
mobList[zone][109].pos = {    0.0735, -2.0000,   44.0171, 64    } -- W2 Megaboss
mobList[zone][110].pos = {   -4.0629, -2.0000,   40.9907, 60    } -- W2 Megaboss Pop Near W
mobList[zone][111].pos = {    4.0815, -2.0000,   41.0436, 68    } -- W2 Megaboss Pop Near E
mobList[zone][112].pos = {  -24.8356,  0.0000,   36.8744, 44    } -- W2 Megaboss Pop Far W
mobList[zone][113].pos = {  -17.5909,  0.0000,   37.1444, 53    } -- W2 Megaboss Pop's Pop Fa
mobList[zone][114].pos = {   23.2271,  0.0000,   35.1004, 77    } -- W2 Megaboss Pop Far E
mobList[zone][115].pos = {   15.7737,  0.0000,   34.9563, 77    } -- W2 Megaboss Pop's Pop Fa
mobList[zone][116].pos = {  -36.9843,  0.0000,   30.0222, 23    } -- W3 Victory Square NW
mobList[zone][117].pos = {  -38.0342,  0.0000,   12.9522, 0     } -- W3 Victory Square SW
mobList[zone][118].pos = {   36.9442,  0.0000,   30.2140, 96    } -- W3 Victory Square NE
mobList[zone][119].pos = {   37.9635,  0.0000,   12.9962, 127   } -- W3 Victory Square SE
mobList[zone][120].pos = {    0.0676, -3.0000,  -29.7543, 191   } -- W3 Atop AH
mobList[zone][121].pos = { -151.4307, -2.0000,   60.1692, 123   } -- W3 Courtyard E
mobList[zone][122].pos = { -166.9782, -2.0000,   58.5803, 128   } -- W3 Courtyard W
mobList[zone][123].pos = { -197.3283, -8.8011,   90.7618, 95    } -- W3 Pikeman's Way Catwalk
mobList[zone][124].pos = { -198.8831, -1.0000,   41.6770, 237   } -- W3 LW Guild N
mobList[zone][125].pos = { -167.9602, -1.0000,   12.0282, 201   } -- W3 LW Guild S
mobList[zone][126].pos = { -103.4151,  2.0000,   -8.4370, 59    } -- W3 Westgate Corner N
mobList[zone][127].pos = { -125.6019,  1.0000,  -29.4409, 251   } -- W3 Westgate Corner W
mobList[zone][128].pos = {  -85.4643,  1.0000,  -70.9384, 190   } -- W3 Westgate Corner S
mobList[zone][129].pos = {  -62.5682,  2.0000,  -48.1542, 122   } -- W3 Westgate Corner E
mobList[zone][130].pos = {   28.3832,  2.2000,  -89.9126, 134   } -- W3 Chocobo Stables Grass
mobList[zone][131].pos = {   28.3091,  2.2000,  -94.2068, 142   } -- W3 Chocobo Stables Grass
mobList[zone][132].pos = {   61.9606,  2.0000,  -47.8880, 253   } -- W3 Eastegate Corner W
mobList[zone][133].pos = {   85.3854,  1.0000,  -69.5495, 188   } -- W3 Eastegate Corner S
mobList[zone][134].pos = {  126.1979,  1.0000,  -29.2587, 126   } -- W3 Eastegate Corner E
mobList[zone][135].pos = {  103.9707,  2.0000,   -6.3490, 64    } -- W3 Eastegate Corner N
mobList[zone][136].pos = {   75.1727,  2.0000,    4.8686, 32    } -- W3 Beside Street Vendor
mobList[zone][137].pos = {  101.5461,  4.0000,   25.6043, 91    } -- W3 Cavalry Way 3-way Int
mobList[zone][138].pos = {  103.6767,  4.0000,   40.9239, 126   } -- W3 Across Rosel's Armour
mobList[zone][139].pos = {   92.4537,  4.0000,   47.9614, 1     } -- W3 Between Rosel's/Helbo
mobList[zone][140].pos = {  133.0893,  0.0000,    9.8870, 193   } -- W3 Cavalry Way Ramp Entr
mobList[zone][141].pos = {  130.6248, -1.2500,  105.9016, 96    } -- W4 Lion Square Stairs W
mobList[zone][142].pos = {  137.5452, -1.0000,   98.5752, 96    } -- W4 Lion Square Stairs S
mobList[zone][143].pos = {  108.8902,  0.0000,   85.6102, 96    } -- W4 Lion Square Fountain
mobList[zone][144].pos = {  116.5853,  0.0000,   74.9059, 96    } -- W4 Lion Square Fountain
mobList[zone][145].pos = { -210.2554, -2.0000,   95.1729, 130   } -- W2 Pikeman's Way N
mobList[zone][146].pos = { -202.6147, -2.0000,   85.8321, 157   } -- W2 Pikeman's Way C
mobList[zone][147].pos = {  -23.9535,  2.0000,  -12.1383, 0     } -- W2 Victory Square Tent W
mobList[zone][148].pos = {   -5.0312,  2.0000,  -11.8298, 51    } -- W2 Victory Square Pop Bt
mobList[zone][149].pos = {   23.8516,  2.0000,  -12.4577, 128   } -- W2 Victory Square Tent E
mobList[zone][150].pos = {    5.0829,  2.0000,  -11.8420, 75    } -- W2 Victory Square Pop Bt

----------------------------------------------------------------------------------------------------
--                                    Setup of Mob Functions                                      --
----------------------------------------------------------------------------------------------------
------------------------------------------
--             Patrol Paths             --
------------------------------------------
-- mobList[zone][MobIndex].patrolPath = {xpos1,ypos1,zpos1, xpos2,ypos2,zpos2,  xpos3,ypos3,zpos3}

--Wave 1 pathing
mobList[zone][2  ].patrolPath = { 121, 0, 96,       127, 0, 102,      121, 0, 96    }
mobList[zone][3  ].patrolPath = { 128, 0, 89,       134, 0, 95,       128, 0, 89    }
mobList[zone][4  ].patrolPath = { 112, 0, 87,       106, 0, 82,       112, 0, 87    }
mobList[zone][5  ].patrolPath = { 119, 0, 80,       113, 0, 75,       119, 0, 80    }
mobList[zone][8  ].patrolPath = { 98, 4, 68,        98, 4, 62,        98, 4, 68     }
mobList[zone][13 ].patrolPath = { 98, 4, 16,        98, 4, 56,        98, 4, 16     }
mobList[zone][14 ].patrolPath = { 104, 4, 14,       116, 2, 14,       104, 4, 15    }
mobList[zone][15 ].patrolPath = { 118, 2, 14,       133, 0, 14,       118, 2, 14    }
mobList[zone][16 ].patrolPath = { 146, 0, 30,       135, 0, 18,       146, 0, 30    }
mobList[zone][17 ].patrolPath = { 148, 0, 49,       148, 0, 33,       148, 0, 49    }
mobList[zone][18 ].patrolPath = { 130, 0, 68,       152, 0, 45,       130, 0, 68    }
mobList[zone][23 ].patrolPath = { 93, 4, 14,        81, 2, 2,         93, 4, 14     }
mobList[zone][25 ].patrolPath = { 76, 2, -4,        88, 2, -16,       76, 2, -4     }
mobList[zone][26 ].patrolPath = { 68, 2, -12,       80, 2, -24,       68, 2, -12    }
mobList[zone][27 ].patrolPath = { 60, 2, -20,       72, 2, -32,       60, 2, -20    }
mobList[zone][28 ].patrolPath = { 91, 2, -19,       98, 2, -26,       91, 2, -19    }
mobList[zone][29 ].patrolPath = { 89, 2, -33,       83, 2, -27,       89, 2, -33    }
mobList[zone][30 ].patrolPath = { 75, 2, -35,       81, 2, -41,       75, 2, -35    }
mobList[zone][37 ].patrolPath = { 40, 2, -17,       40, 2, -37,       40, 2, -17    }
mobList[zone][38 ].patrolPath = { 34, 2, -18,       14, 2, -18,       34, 2, -18    }
mobList[zone][39 ].patrolPath = { 20, 2, 5,         20, 2, -13,       20, 2, 5      }
mobList[zone][40 ].patrolPath = { 20, 0, 24,        20, 2, 8,         20, 0, 24     }
mobList[zone][41 ].patrolPath = { 0, 0, 26,         0, 2, 3,          0, 0, 26      }
mobList[zone][42 ].patrolPath = { 5, 0, 19,         5, 2, -9,         5, 0, 19      } -- Victory Square Main Path E
mobList[zone][43 ].patrolPath = { -5, 0, 19,        -5, 2, -9,        -5, 0, 19     } -- Victory Square Main Path W
mobList[zone][44 ].patrolPath = { 0, 2, -21,        0, 2, -4,         0, 2, -21     }
mobList[zone][45 ].patrolPath = { -24, 2, 15,       -24, 2, 0,        -24, 2, 15    }
mobList[zone][46 ].patrolPath = { -20, 2, 5,        -20, 2, -13,      -20, 2, 5     }
mobList[zone][47 ].patrolPath = { -34, 2, -18,      -14, 2, -18,      -34, 2, -18   }
mobList[zone][48 ].patrolPath = { -40, 2, -17,      -40, 2, -38,      -40, 2, -17   }
mobList[zone][55 ].patrolPath = { 2, 2, -74,        -12, 2, -74,      2, 2, -74     }
mobList[zone][56 ].patrolPath = { -8, 2, -80,       -23, 2, -80,      -8, 2, -80    }
mobList[zone][57 ].patrolPath = { 5, 2, -74,        18, 2, -74,       5, 2, -74     }
mobList[zone][63 ].patrolPath = { -72, 2, -32,      -60, 2, -20,      -72, 2, -32   }
mobList[zone][64 ].patrolPath = { -80, 2, -24,      -68, 2, -12,      -80, 2, -24   }
mobList[zone][65 ].patrolPath = { -88, 2, -16,      -76, 2, -4,       -88, 2, -16   }
mobList[zone][66 ].patrolPath = { -75, 2, -35,      -83, 2, -43,      -75, 2, -35   }
mobList[zone][67 ].patrolPath = { -83, 2, -27,      -91, 2, -35,      -83, 2, -27   }
mobList[zone][68 ].patrolPath = { -91, 2, -19,      -99, 2, -27,      -91, 2, -19   }
mobList[zone][74 ].patrolPath = { -96, -2, 16,      -84, 2, 4,        -96, -2, 16   }
mobList[zone][77 ].patrolPath = { -118, -2, 12,     -99, -2, 27,      -118, -2, 12  }
mobList[zone][78 ].patrolPath = { -118, -2, 18,     -136, -2, 18,     -118, -2, 18  }
mobList[zone][79 ].patrolPath = { -140, -2, 18,     -163, -1, 18,     -140, -2, 18  }
mobList[zone][87 ].patrolPath = { -190, -1, 43,     -193, -1, 55,     -190, -1, 43  }
mobList[zone][88 ].patrolPath = { -194, -2, 61,     -194, -2, 78,     -194, -2, 61  }
mobList[zone][90 ].patrolPath = { -194, -2, 80,     -212, -2, 98,     -194, -2, 80  }
mobList[zone][91 ].patrolPath = { -231, -2, 98,     -213, -2, 98,     -231, -2, 98  }
mobList[zone][92 ].patrolPath = { -240, -4, 98,     -260, -4, 98,     -240, -4, 98  }
mobList[zone][96 ].patrolPath = { -169, -2, 60,     -156, -2, 60,     -169, -2, 60  }
mobList[zone][98 ].patrolPath = { -144, -2, 60,     -154, -2, 60,     -144, -2, 60  }
mobList[zone][99 ].patrolPath = { -132, -4, 72,     -132, -4, 63,     -132, -4, 72  }
mobList[zone][103].patrolPath = { -106, -6, 88,     -128, -6, 88,     -106, -6, 88  }
mobList[zone][105].patrolPath = { -94, -6, 74,      -104, -6, 84,     -94, -6, 74   }
mobList[zone][106].patrolPath = { -90, -6, 57,      -93, -6, 71,      -90, -6, 57   }
mobList[zone][107].patrolPath = { -90, -4, 46,      -90, -4, 56,      -90, -4, 46   }
mobList[zone][108].patrolPath = { -101, 2, 34,      -91, 4, 44,       -101, 2, 34   }

--Wave 2 pathing
mobList[zone][141].patrolPath = { 132, -1, 103,     128, -1, 107,     132, -1, 103  }
mobList[zone][142].patrolPath = { 135, -1, 100,     139, -1, 96,      135, -1, 100  }
mobList[zone][143].patrolPath = { 110, 0, 80,       104, 0, 87,       110, 0, 80    }
mobList[zone][144].patrolPath = { 118, 0, 71,       112, 0, 78,       118, 0, 71    }
mobList[zone][145].patrolPath = { -212, -2, 96,     -229, -2, 98,     -212, -2, 96  }
mobList[zone][146].patrolPath = { -200, -2, 87,     -193, -2, 69,     -200, -2, 87  }

------------------------------------------
--          Statue Eye Colors           --
------------------------------------------
-- mobList[zone][MobIndex].eyes = dynamisEyesEra.BLUE -- Flags for blue eyes. (HP)
-- mobList[zone][MobIndex].eyes = dynamisEyesEra.GREEN -- Flags for green eyes. (MP)
-- mobList[zone][MobIndex].eyes = dynamisEyesEra.RED -- Flags for red eyes. (TE)

mobList[zone][6  ].eyes = dynamisEyesEra.GREEN
mobList[zone][7  ].eyes = dynamisEyesEra.RED
mobList[zone][9  ].eyes = dynamisEyesEra.RED
mobList[zone][10 ].eyes = dynamisEyesEra.GREEN
mobList[zone][12 ].eyes = dynamisEyesEra.BLUE
mobList[zone][14 ].eyes = dynamisEyesEra.GREEN
mobList[zone][15 ].eyes = dynamisEyesEra.BLUE
mobList[zone][26 ].eyes = dynamisEyesEra.RED
mobList[zone][32 ].eyes = dynamisEyesEra.GREEN
mobList[zone][34 ].eyes = dynamisEyesEra.BLUE
mobList[zone][35 ].eyes = dynamisEyesEra.GREEN
mobList[zone][38 ].eyes = dynamisEyesEra.GREEN
mobList[zone][41 ].eyes = dynamisEyesEra.RED
mobList[zone][44 ].eyes = dynamisEyesEra.BLUE
mobList[zone][47 ].eyes = dynamisEyesEra.GREEN
mobList[zone][52 ].eyes = dynamisEyesEra.BLUE
mobList[zone][59 ].eyes = dynamisEyesEra.BLUE
mobList[zone][60 ].eyes = dynamisEyesEra.GREEN
mobList[zone][62 ].eyes = dynamisEyesEra.GREEN
mobList[zone][64 ].eyes = dynamisEyesEra.RED
mobList[zone][70 ].eyes = dynamisEyesEra.GREEN
mobList[zone][72 ].eyes = dynamisEyesEra.BLUE
mobList[zone][74 ].eyes = dynamisEyesEra.RED
mobList[zone][76 ].eyes = dynamisEyesEra.GREEN
mobList[zone][78 ].eyes = dynamisEyesEra.BLUE
mobList[zone][79 ].eyes = dynamisEyesEra.GREEN
mobList[zone][81 ].eyes = dynamisEyesEra.BLUE
mobList[zone][83 ].eyes = dynamisEyesEra.BLUE
mobList[zone][84 ].eyes = dynamisEyesEra.GREEN
mobList[zone][85 ].eyes = dynamisEyesEra.BLUE
mobList[zone][86 ].eyes = dynamisEyesEra.GREEN
mobList[zone][91 ].eyes = dynamisEyesEra.BLUE
mobList[zone][92 ].eyes = dynamisEyesEra.GREEN
mobList[zone][93 ].eyes = dynamisEyesEra.RED
mobList[zone][97 ].eyes = dynamisEyesEra.BLUE
mobList[zone][103].eyes = dynamisEyesEra.BLUE
mobList[zone][104].eyes = dynamisEyesEra.BLUE
mobList[zone][107].eyes = dynamisEyesEra.BLUE
mobList[zone][108].eyes = dynamisEyesEra.GREEN
mobList[zone][110].eyes = dynamisEyesEra.GREEN
mobList[zone][111].eyes = dynamisEyesEra.GREEN
mobList[zone][113].eyes = dynamisEyesEra.BLUE
mobList[zone][115].eyes = dynamisEyesEra.BLUE

------------------------------------------
--        Time Extension Values         --
------------------------------------------
-- mobList[zone][MobIndex].timeExtension = 15

mobList[zone][7  ].timeExtension = 15 -- Serjeant Tombstone
mobList[zone][9  ].timeExtension = 15 -- Serjeant Tombstone
mobList[zone][26 ].timeExtension = 25 -- Serjeant Tombstone
mobList[zone][41 ].timeExtension = 30 -- Serjeant Tombstone
mobList[zone][64 ].timeExtension = 25 -- Serjeant Tombstone
mobList[zone][74 ].timeExtension = 10 -- Warchief Tombstone
mobList[zone][153].timeExtension = 30 -- Voidstreaker Butchnotch