----------------------------------------------------------------------------------------------------
--                                      Dynamis-Windurst                                          --
--              Primary Source of Information: https://enedin.be/dyna/html/zone/win.htm           --
--           Secondary Source of Information: http://www.dynamisbums.com/strategy/win.html        --
--                       NOTE: Please refer to instructions for setup.                            --
-- Video References:                                                                              --
-- https://www.youtube.com/user/FFXIshibaa/search                                                 --
-- https://www.youtube.com/user/fatalbiohazard/search                                             --
-- https://www.youtube.com/watch?v=Tdv6TJOhOTc&ab_channel=DavidWindsands                          --
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
local zone = xi.zone.DYNAMIS_WINDURST
mobList = mobList or { }
mobList[zone] ={ } -- Ignore me, I just start the table.
mobList[zone].zoneID = zone -- Ignore me, I just ensure .zoneID exists.
mobList[zone].waveDefeatRequirements = { } -- Ignore me, I just start the table.
mobList[zone].waveDefeatRequirements[1] = { } -- Ignore me, I just allow for wave 1 spawning.
mobList[zone].maxWaves = 10 -- Ignore me because Oph told me to

----------------------------------------------------------------------------------------------------
--                                  Setup of Parent Spawning                                      --
----------------------------------------------------------------------------------------------------
------------------------------------------
--               Mob Info               --
-- Note: Primarily used for mobs that   --
-- are NMs or parent mobs.              --
------------------------------------------
--mobList[zone][MobIndex].info = {"Statue/NM/Nightmare", "Mob Name", "Family", "Main Job", "MobLocalVarName"}

mobList[zone][1  ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 001-Y/A
mobList[zone][2  ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 002-Y/A
mobList[zone][3  ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 003-Y/A
mobList[zone][4  ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 004-Y/A
mobList[zone][5  ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 005-Y/A
mobList[zone][6  ].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- 006-Y/M(HP)
mobList[zone][7  ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 007-Y/A
mobList[zone][8  ].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- 008-Y/M(MP)(20)
mobList[zone][9  ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 009-Y/A
mobList[zone][10 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 010-Y/A
mobList[zone][11 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 011-Y/A
mobList[zone][12 ].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- 012-Y/M(HP)
mobList[zone][13 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 013-Y/A
mobList[zone][14 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 014-Y/A
mobList[zone][15 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 015-Y/A
mobList[zone][16 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 016-Y/A
mobList[zone][17 ].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- 017-Y/M(MP)
mobList[zone][18 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 018-Y/A(20)
mobList[zone][19 ].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- 019-Y/M(HP)
mobList[zone][20 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 020-Y/A
mobList[zone][21 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 021-Y/A
mobList[zone][22 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 022-Y/A
mobList[zone][23 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 023-Y/A
mobList[zone][24 ].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- 024-Y/M(HP)
mobList[zone][25 ].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- 025-Y/M(MP)
mobList[zone][26 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 026-Y/A
mobList[zone][27 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 027-Y/A
mobList[zone][28 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 028-Y/A
mobList[zone][29 ].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- 029-Y/M(HP)
mobList[zone][30 ].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- 030-Y/M(MP)
mobList[zone][31 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 031-Y/A(10)
mobList[zone][32 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 032-Y/A
mobList[zone][33 ].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- 033-Y/M(MP)
mobList[zone][34 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 034-Y/A
mobList[zone][35 ].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- 035-Y/M(HP)
mobList[zone][36 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 036-Y/A
mobList[zone][37 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 037-Y/A
mobList[zone][38 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 038-Y/A
mobList[zone][39 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 039-Y/A
mobList[zone][40 ].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- 040-Y/M(MP)
mobList[zone][41 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 041-Y/A(20)
mobList[zone][42 ].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- 042-Y/M(HP)
mobList[zone][43 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 043-Y/A
mobList[zone][44 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 044-Y/A
mobList[zone][45 ].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- 045-Y/M(MP)
mobList[zone][46 ].info = { "Statue", "Avatar Idol",    nil, nil, nil }  -- 046-Y/A.Idol
mobList[zone][47 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 047-Y/M
mobList[zone][48 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 048-Y/M
mobList[zone][49 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 049-Y/A
mobList[zone][50 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 050-Y/A
mobList[zone][51 ].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- 051-Y/M(HP)
mobList[zone][52 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 052-Y/A
mobList[zone][53 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 053-Y/A
mobList[zone][54 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 054-Y/A
mobList[zone][55 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 055-Y/A
mobList[zone][56 ].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- 056-Y/M(HP)
mobList[zone][57 ].info = { "Statue", "Manifest Icon",  nil, nil, "57_killed" }  -- 057-Y/M(MP)
mobList[zone][58 ].info = { "Statue", "Avatar Icon",    nil, nil, "58_killed" }  -- 058-Y/A(10)
mobList[zone][59 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 059-Y/A
mobList[zone][60 ].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- 060-Y/M(MP)
mobList[zone][61 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 061-Y/A
mobList[zone][62 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 062-Y/A
mobList[zone][63 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 063-Y/A
mobList[zone][64 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 064-Y/A
mobList[zone][65 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 065-Y/A
mobList[zone][66 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 066-Y/M(20)
mobList[zone][67 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 067-Y/A
mobList[zone][68 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 068-Y/A
mobList[zone][69 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 069-Y/A
mobList[zone][70 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 070-Y/A
mobList[zone][71 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 071-Y/A
mobList[zone][72 ].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- 072-Y/M(MP)
mobList[zone][73 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 073-Y/A
mobList[zone][74 ].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- 074-Y/M(HP)
mobList[zone][75 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 075-Y/A
mobList[zone][76 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 076-Y/A
mobList[zone][77 ].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- 077-Y/M(MP)
mobList[zone][78 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 078-Y/A
mobList[zone][79 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 079-Y/A
mobList[zone][80 ].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- 080-Y/M(MP)
mobList[zone][81 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 081-Y/A
mobList[zone][82 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 082-Y/A
mobList[zone][83 ].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- 083-Y/M(HP)
mobList[zone][84 ].info = { "Statue", "Avatar Idol",    nil, nil, nil }  -- 084-Y/A.Idol
mobList[zone][85 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 085-Y/A
mobList[zone][86 ].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- 086-Y/M(MP)
mobList[zone][87 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 087-Y/A
mobList[zone][88 ].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- 088-Y/M(HP)
mobList[zone][89 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 089-Y/A
mobList[zone][90 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 090-Y/A
mobList[zone][91 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 091-Y/A
mobList[zone][92 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 092-Y/A
mobList[zone][93 ].info = { "Statue", "Avatar Idol",    nil, nil, nil }  -- 093-Y/A.Idol
mobList[zone][94 ].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- 094-Y/M(HP)
mobList[zone][95 ].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- 095-Y/M(HP)
mobList[zone][96 ].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- 096-Y/M(MP)
mobList[zone][97 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 097-Y/A
mobList[zone][98 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 098-Y/A
mobList[zone][99 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 099-Y/A
mobList[zone][100].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- 100-Y/M(HP)
mobList[zone][101].info = { "Statue", "Avatar Icon",    nil, nil, "101_killed" }  -- 101-Y/M(20)
mobList[zone][102].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 102-Y/A
mobList[zone][103].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 103-Y/A
mobList[zone][104].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 104-Y/A
mobList[zone][105].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 105-Y/A
mobList[zone][106].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 106-Y/A
mobList[zone][107].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 107-Y/A
mobList[zone][108].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 108-Y/A
mobList[zone][109].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 109-Y/A
mobList[zone][110].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- 110-Y/M(HP)
mobList[zone][111].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- 111-Y/M(MP)
mobList[zone][112].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 112-Y/A
mobList[zone][113].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 113-Y/A
mobList[zone][114].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 114-Y/M
mobList[zone][115].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 115-Y/M
mobList[zone][116].info = { "Statue", "Manifest Idol",  nil, nil, nil }  -- 116-Y/A.Idol
mobList[zone][117].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- 117-Y/M(HP)
mobList[zone][118].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- 118-Y/M(MP)
mobList[zone][119].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 119-Y/M
mobList[zone][120].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 120-Y/M
mobList[zone][122].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 122-Y/M
mobList[zone][123].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 123-Y/M
mobList[zone][124].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 124-Y/M
mobList[zone][125].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 125-Y/M
mobList[zone][126].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- 126-Y/M(HP)
mobList[zone][127].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- 127-Y/M(MP)
mobList[zone][128].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 128-Y/A
mobList[zone][129].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 129-Y/A
mobList[zone][130].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 130-Y/A
mobList[zone][131].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- 131-Y/M(MP)
mobList[zone][132].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 132-Y/A
mobList[zone][133].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- 133-Y/M(HP)
mobList[zone][134].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 134-Y/A
mobList[zone][135].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 135-Y/A
mobList[zone][136].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- 136-Y/M(HP)
mobList[zone][137].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- 137-Y/M(MP)
mobList[zone][138].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- 138-Y/M(HP)
mobList[zone][139].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- 139-Y/M(MP)
mobList[zone][140].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 140-Y/M
mobList[zone][141].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 141-Y/M
mobList[zone][142].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 142-Y/M
mobList[zone][143].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 143-Y/M
mobList[zone][144].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 144-Y/M
mobList[zone][145].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 145-Y/M
mobList[zone][146].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 146-Y/A
mobList[zone][147].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 147-Y/M
mobList[zone][148].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 148-Y/A
mobList[zone][149].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 149-Y/M
mobList[zone][150].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- 150-Y/M

-- NM's and Megaboss
mobList[zone][121].info = { "NM", "Tzee Xicu Idol",               nil,   nil, "MegaBoss_Killed" }   -- 121-Replica NM (Tzee Xicu Idol)
mobList[zone][151].info = { "NM", "Maa Febi the Steadfast",  "Yagudo", "PLD", nil }                 -- Maa Febi the Steadfast
mobList[zone][152].info = { "NM", "Muu Febi the Steadfast",  "Yagudo", "PLD", nil }                 -- Muu Febi the Steadfast
mobList[zone][153].info = { "NM", "Haa Pevi the Stentorian", "Yagudo", "SMN", "Haa_killed" }        -- Haa Pevi the Stentorian
mobList[zone][154].info = { "NM", "Loo Hepe the Eyepiercer", "Yagudo", "RDM", "Loo_killed" }        -- Loo Hepe the Eyepiercer
mobList[zone][155].info = { "NM", "Wuu Qoho the Razorclaw",  "Yagudo", "MNK", "Wuu_killed" }        -- Wuu Qoho the Razorclaw
mobList[zone][156].info = { "NM", "Xoo Kaza the Solemn",     "Yagudo", "BLM", "Xoo_killed" }        -- Xoo Kaza the Solemn

----------------------------------------------------------------------------------------------------
--                                    Setup of Wave Spawning                                      --
----------------------------------------------------------------------------------------------------

---------------------------------------------
--           Wave Defeat Reqs.          --
--------------------------------------------
--mobList[zone].waveDefeatRequirements[2] = {zone:getLocalVar("MegaBoss_Killed") == 1}

mobList[zone].waveDefeatRequirements[2 ] = { zone:getLocalVar("MegaBoss_Killed") == 1} -- Spawns statues when boss dies
mobList[zone].waveDefeatRequirements[3 ] = { zone:getLocalVar("Wuu_killed") == 1 } -- Wuu Qoho the Razorclaw spawns 2 Statues at Heavens Tower
mobList[zone].waveDefeatRequirements[4 ] = { zone:getLocalVar("Xoo_killed") == 1 } -- Xoo Kaza the Solemn NM spawns 2 Statues at Heavens Tower
mobList[zone].waveDefeatRequirements[5 ] = { zone:getLocalVar("Haa_killed") == 1 } -- Haa Pevi the Stentorian NM spawns 2 Statues at Heavens Tower
mobList[zone].waveDefeatRequirements[6 ] = { zone:getLocalVar("Wuu_killed") == 1, zone:getLocalVar("Xoo_killed") == 1, zone:getLocalVar("Haa_killed") == 1} -- Spawn main Heavens Tower statues + the RDM NM on 3 NM deaths
mobList[zone].waveDefeatRequirements[7 ] = { zone:getLocalVar("58_killed" == 1) } -- pops 59-61 on bridge when defeated
mobList[zone].waveDefeatRequirements[8 ] = { zone:getLocalVar("101_killed") == 1 } -- pops 102/103 under bridge when defeated
mobList[zone].waveDefeatRequirements[9 ] = { zone:getLocalVar("57_killed" ) == 1 } -- pops 54/55 under bridge when defeated
mobList[zone].waveDefeatRequirements[10] = { zone:getLocalVar("Loo_killed") == 1 } -- Pops zone boss

------------------------------------------
--            Wave Spawning             --
-- Note: Wave 1 spawns at start.        --
------------------------------------------
--mobList[zone][MobIndex].waves = { 1,nil,nil }

-- Spawns on zone entry
mobList[zone].wave1 = {
    1  ,    -- 001-Y/A
    2  ,    -- 002-Y/A
    3  ,    -- 003-Y/A
    4  ,    -- 004-Y/A
    5  ,    -- 005-Y/A
    6  ,    -- 006-Y/M(HP)
    7  ,    -- 007-Y/A
    8  ,    -- 008-Y/M(MP)(20)
    9  ,    -- 009-Y/A
    10 ,    -- 010-Y/A
    11 ,    -- 011-Y/A
    12 ,    -- 012-Y/M(HP)
    13 ,    -- 013-Y/A
    14 ,    -- 014-Y/A
    15 ,    -- 015-Y/A
    16 ,    -- 016-Y/A
    17 ,    -- 017-Y/M(MP)
    18 ,    -- 018-Y/A(20)
    19 ,    -- 019-Y/M(HP)
    20 ,    -- 020-Y/A
    21 ,    -- 021-Y/A
    24 ,    -- 024-Y/M(HP)
    26 ,    -- 026-Y/A
    27 ,    -- 027-Y/A
    28 ,    -- 028-Y/A
    29 ,    -- 029-Y/M(HP)
    30 ,    -- 030-Y/M(MP)
    31 ,    -- 031-Y/A(10)
    32 ,    -- 032-Y/A
    34 ,    -- 034-Y/A
    35 ,    -- 035-Y/M(HP)
    38 ,    -- 038-Y/A
    39 ,    -- 039-Y/A
    40 ,    -- 040-Y/M(MP)
    41 ,    -- 041-Y/A(20)
    43 ,    -- 043-Y/A
    44 ,    -- 044-Y/A
    45 ,    -- 045-Y/M(MP)
    46 ,    -- 046-Y/A.Idol
    51 ,    -- 051-Y/M(HP)
    52 ,    -- 052-Y/A
    53 ,    -- 053-Y/A
    56 ,    -- 056-Y/M(HP)
    57 ,    -- 057-Y/M(MP)
    58 ,    -- 058-Y/A(10)
    65 ,    -- 065-Y/A
    66 ,    -- 066-Y/M(20)
    69 ,    -- 069-Y/A
    72 ,    -- 072-Y/M(MP)
    73 ,    -- 073-Y/A
    74 ,    -- 074-Y/M(HP)
    77 ,    -- 077-Y/M(MP)
    80 ,    -- 080-Y/M(MP)
    84 ,    -- 084-Y/A.Idol
    88 ,    -- 088-Y/M(HP)
    89 ,    -- 089-Y/A
    91 ,    -- 091-Y/A
    93 ,    -- 093-Y/A.Idol
    94 ,    -- 094-Y/M(HP)
    95 ,    -- 095-Y/M(HP)
    96 ,    -- 096-Y/M(MP)
    97 ,    -- 097-Y/A
    101,    -- 101-Y/M(20)
    104,    -- 104-Y/A
    105,    -- 105-Y/A
    106,    -- 106-Y/A
    107,    -- 107-Y/A
    108,    -- 108-Y/A
    109,    -- 109-Y/A
    130,    -- 130-Y/A
    131,    -- 131-Y/M(MP)
    132,    -- 132-Y/A
    133,    -- 133-Y/M(HP)
    134,    -- 134-Y/A
    135,    -- 135-Y/A
    136,    -- 136-Y/M(HP)
    137     -- 137-Y/M(MP)
}

-- Spawns statues when boss dies
mobList[zone].wave2 = {
    126,    -- 126-Y/M(HP)
    127,    -- 127-Y/M(MP)
    128,    -- 128-Y/A
    129,    -- 129-Y/A
    130,    -- 130-Y/A
    131,    -- 131-Y/M(MP)
    132,    -- 132-Y/A
    133,    -- 133-Y/M(HP)
    134,    -- 134-Y/A
    135,    -- 135-Y/A
    136,    -- 136-Y/M(HP)
    137,    -- 137-Y/M(MP)
    138,    -- 138-Y/M(HP)
    139,    -- 139-Y/M(MP)
    140,    -- 140-Y/M
    141,    -- 141-Y/M
    142,    -- 142-Y/M
    143,    -- 143-Y/M
    144,    -- 144-Y/M
    145,    -- 145-Y/M
    146,    -- 146-Y/A
    147,    -- 147-Y/M
    148,    -- 148-Y/A
    149,    -- 149-Y/M
    150     -- 150-Y/M
}

-- Wuu Qoho the Razorclaw spawns 2 Statues at Heavens Tower
mobList[zone].wave3 = {
    108,    -- 108-Y/A
    109     -- 109-Y/A
}

-- Xoo Kaza the Solemn NM spawns 2 Statues at Heavens Tower
mobList[zone].wave4 = {
    110,    -- 110-Y/M(HP)
    111	    -- 111-Y/M(MP)
}

-- Haa Pevi the Stentorian NM spawns 2 Statues at Heavens Tower
mobList[zone].wave5 = {
    113,    -- 113-Y/A
    112	    -- 112-Y/A
}

-- Spawn main Heavens Tower statues + the RDM NM on 3 NM deaths
mobList[zone].wave6 = {
    114,    -- 114-Y/M
    115,    -- 115-Y/M
    116     -- 116-Y/A.Idol
}

mobList[zone].wave7 = {
    59,     -- 059-Y/A
    60,     -- 060-Y/M(MP)
    61      -- 061-Y/A
}

mobList[zone].wave8 = {
    103,    -- 103-Y/A
    102	    -- 102-Y/A
}

mobList[zone].wave9 = {
    55,     -- 055-Y/A
    54	    -- 054-Y/A
}

mobList[zone].wave10 = {
    121     -- 121-Replica NM (Tzee Xicu Idol)
}

----------------------------------------------------------------------------------------------------
--                                  Setup of Children Spawning                                    --
----------------------------------------------------------------------------------------------------
------------------------------------------
--          Normal Child Spawn          --
------------------------------------------
-- mobList[zone][MobIndex].mobchildren = {#WAR, #MNK, #WHM, #BLM, #RDM, #THF, #PLD, #DRK, #BST, #BRD, #RNG, #SAM, #NIN, #DRG, #SMN}

mobList[zone][1  ].mobchildren = { nil, nil, nil, nil, nil, nil,   1,   1, nil, nil, nil, nil, nil, nil, nil  } -- 1 PLD 1 DRK
mobList[zone][2  ].mobchildren = { nil, nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 WHM 1 BLM
mobList[zone][3  ].mobchildren = { nil, nil, nil, nil,   1, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil  } -- 1 RDM 1 BRD
mobList[zone][4  ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil  } -- 1 RNG
mobList[zone][6  ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1,   1, nil, nil  } -- 1 SAM 1 NIN
mobList[zone][7  ].mobchildren = { nil,   2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 MNK
mobList[zone][8  ].mobchildren = {   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil  } -- 1 WAR 2 DRG
mobList[zone][9  ].mobchildren = { nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil,   2, nil, nil  } -- 2 THF 2 NIN
mobList[zone][11 ].mobchildren = {   2, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil  } -- 2 WAR 2 BST
mobList[zone][12 ].mobchildren = { nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 PLD
mobList[zone][13 ].mobchildren = { nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 WHM
mobList[zone][14 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil,   1, nil, nil, nil  } -- 1 DRK 1 SAM
mobList[zone][15 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil,   1, nil, nil, nil  } -- 1 DRK 1 SAM
mobList[zone][16 ].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, } -- 1 BLM 2 SMN
mobList[zone][17 ].mobchildren = { nil, nil, nil, nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 RDM 1 THF
mobList[zone][18 ].mobchildren = {   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil  } -- 1 WAR 1 SAM
mobList[zone][19 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil  } -- 2 NIN
mobList[zone][20 ].mobchildren = { nil,   1, nil, nil, nil,   1, nil, nil, nil,   1, nil, nil, nil, nil, nil  } -- 1 MNK 1 THF 1 BRD
mobList[zone][21 ].mobchildren = { nil, nil,   1, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 WHM 1 PLD
mobList[zone][22 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil  } -- 1 DRK
mobList[zone][23 ].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 BLM
mobList[zone][24 ].mobchildren = { nil, nil, nil, nil, nil,   2, nil, nil, nil,   1, nil, nil, nil, nil, nil  } -- 2 THF 1 BRD
mobList[zone][25 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil,   2, nil  } -- 1 BST 2 DRG
mobList[zone][26 ].mobchildren = { nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 BLM
mobList[zone][27 ].mobchildren = {   2, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil  } -- 2 WAR 2 RNG
mobList[zone][28 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1, nil,   1,   1, nil, nil, nil, nil  } -- 1 DRK 1 BRD 1 RNG
mobList[zone][29 ].mobchildren = {   1,   1, nil, nil, nil,   1, nil, nil, nil, nil, nil,   1, nil, nil, nil  } -- 1 WAR 1 MNK 1 THF 1 SAM
mobList[zone][30 ].mobchildren = { nil, nil, nil, nil,   1, nil,   1,   1, nil, nil, nil, nil,   1, nil, nil  } -- 1 RDM 1 PLD 1 DRK 1 NIN
mobList[zone][31 ].mobchildren = { nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil,   1, } -- 2 THF 1 SMN
mobList[zone][32 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   3, nil  } -- 3 DRG
mobList[zone][33 ].mobchildren = { nil, nil, nil, nil,   2, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil  } -- 2 RDM 1 BST
mobList[zone][34 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil  } -- 2 BST
mobList[zone][36 ].mobchildren = { nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 WHM
mobList[zone][37 ].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 BLM
mobList[zone][38 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil  } -- 1 BRD
mobList[zone][39 ].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 THF
mobList[zone][41 ].mobchildren = {   1, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil  } -- 1 WAR 1 WHM 1 SAM
mobList[zone][42 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil  } -- 2 NIN
mobList[zone][43 ].mobchildren = { nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, } -- 1 WHM 1 SMN
mobList[zone][44 ].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 BLM
mobList[zone][45 ].mobchildren = { nil,   2, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 MNK 2 PLD
mobList[zone][47 ].mobchildren = {   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil  } -- 1 WAR 1 DRG
mobList[zone][48 ].mobchildren = {   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil  } -- 1 WAR 1 SAM
mobList[zone][53 ].mobchildren = { nil, nil, nil, nil,   2,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 RDM 1 THF
mobList[zone][54 ].mobchildren = { nil, nil,   1, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil  } -- 1 WHM 1 BRD
mobList[zone][55 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil  } -- 2 DRK
mobList[zone][56 ].mobchildren = { nil, nil, nil,   2, nil, nil,   1, nil, nil, nil, nil, nil,   1, nil, nil  } -- 2 BLM 1 PLD 1 NIN
mobList[zone][57 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, } -- 1 SMN
mobList[zone][60 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil  } -- 1 BST
mobList[zone][63 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil  } -- 1 DRG
mobList[zone][65 ].mobchildren = {   1,   1,   1,   1, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 WAR 1 MNK 1 WHM 1 BLM 1 THF
mobList[zone][66 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1, nil,   1, nil, nil, nil, nil,   1, } -- 1 DRK 1 BRD 1 SMN
mobList[zone][67 ].mobchildren = { nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 WHM
mobList[zone][68 ].mobchildren = { nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 WHM
mobList[zone][69 ].mobchildren = {   2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 WAR
mobList[zone][72 ].mobchildren = {   1,   1, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil  } -- 1 WAR 1 MNK 1 BST
mobList[zone][73 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  } -- 1 NIN
mobList[zone][74 ].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil,   1, nil,   1, nil  } -- 1 THF 1 SAM 1 DRG
mobList[zone][75 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil  } -- 1 RNG
mobList[zone][77 ].mobchildren = { nil, nil, nil, nil,   2, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil  } -- 2 RDM 1 BRD
mobList[zone][78 ].mobchildren = { nil, nil, nil,   1, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 BLM 1 PLD
mobList[zone][79 ].mobchildren = { nil, nil,   1, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil  } -- 1 WHM 1 DRK
mobList[zone][80 ].mobchildren = { nil, nil, nil, nil, nil,   1,   1, nil, nil,   1, nil, nil, nil, nil, nil  } -- 1 THF 1 PLD 1 BRD
mobList[zone][81 ].mobchildren = { nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 RDM
mobList[zone][82 ].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 BLM
mobList[zone][83 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, } -- 1 SMN
mobList[zone][84 ].mobchildren = { nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 BLM
mobList[zone][85 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil  } -- 2 DRK
mobList[zone][86 ].mobchildren = { nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 PLD
mobList[zone][87 ].mobchildren = { nil, nil,   1, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 WHM 1 RDM
mobList[zone][90 ].mobchildren = { nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 RDM
mobList[zone][92 ].mobchildren = { nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 RDM
mobList[zone][93 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, } -- 2 SMN
mobList[zone][94 ].mobchildren = { nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, } -- 1 WHM 2 SMN
mobList[zone][95 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, } -- 2 SMN
mobList[zone][97 ].mobchildren = { nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 RDM
mobList[zone][98 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil  } -- 1 DRK
mobList[zone][99 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil  } -- 1 BST
mobList[zone][100].mobchildren = { nil, nil, nil, nil, nil, nil,   1, nil, nil,   1, nil, nil, nil, nil, nil  } -- 1 PLD 1 BRD
mobList[zone][101].mobchildren = { nil,   1, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil  } -- 1 MNK 2 RNG
mobList[zone][102].mobchildren = {   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  } -- 1 WAR 1 NIN
mobList[zone][103].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1,   1, nil  } -- 1 NIN 1 DRG
mobList[zone][104].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 BLM
mobList[zone][105].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil  } -- 1 RNG
mobList[zone][106].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil  } -- 1 RNG
mobList[zone][107].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 BLM
mobList[zone][108].mobchildren = {   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 WAR
mobList[zone][111].mobchildren = {   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 WAR
mobList[zone][112].mobchildren = {   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 WAR
mobList[zone][114].mobchildren = { nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 THF
mobList[zone][115].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil  } -- 2 NIN
mobList[zone][116].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1, nil,   1, nil, nil, nil, nil, nil  } -- 1 DRK 1 BRD
mobList[zone][117].mobchildren = { nil, nil, nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 BLM 1 RDM
mobList[zone][118].mobchildren = { nil, nil, nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 BLM 1 RDM
mobList[zone][119].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   1, nil,   1,   1, nil, nil, nil  } -- 1 BST 1 RNG 1 SAM
mobList[zone][120].mobchildren = { nil,   1, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  } -- 1 MNK 1 BLM 1 NIN
mobList[zone][121].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil  } -- 2 RNG
mobList[zone][122].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil,   1, nil, nil,   1, nil, nil, nil  } -- 1 BLM 1 BST 1 SAM
mobList[zone][123].mobchildren = {   1,   1, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 WAR 1 MNK 1 BLM
mobList[zone][126].mobchildren = { nil, nil, nil, nil, nil, nil,   1,   1, nil, nil, nil, nil,   1, nil, nil  } -- 1 PLD 1 DRK 1 NIN
mobList[zone][127].mobchildren = { nil, nil, nil, nil,   1,   1, nil, nil,   1, nil,   1, nil, nil, nil, nil  } -- 1 RDM 1 THF 1 BST 1 RNG
mobList[zone][128].mobchildren = { nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, } -- 1 MNK 1 SMN
mobList[zone][129].mobchildren = { nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  } -- 1 MNK 1 NIN
mobList[zone][130].mobchildren = { nil,   1, nil, nil, nil, nil, nil, nil,   1, nil, nil,   1, nil, nil, nil  } -- 1 MNK 1 BST 1 SAM
mobList[zone][131].mobchildren = { nil, nil,   1, nil, nil, nil, nil, nil, nil,   1,   1, nil, nil, nil, nil  } -- 1 WHM 1 BRD 1 RNG
mobList[zone][132].mobchildren = { nil, nil, nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, } -- 1 BLM 1 RDM 1 SMN
mobList[zone][133].mobchildren = { nil, nil, nil,   1,   1, nil, nil,   1, nil, nil,   1, nil, nil,   1, nil  } -- 1 BLM 1 RDM 1 DRK 1 RNG 1 DRG
mobList[zone][134].mobchildren = { nil,   1, nil, nil, nil, nil, nil,   1, nil,   1, nil, nil, nil, nil, nil  } -- 1 MNK 1 DRK 1 BRD
mobList[zone][135].mobchildren = { nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil,   1, nil  } -- 1 PLD 1 DRG
mobList[zone][136].mobchildren = { nil, nil,   1, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 WHM 1 THF
mobList[zone][137].mobchildren = {   1, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil,   1, nil, nil  } -- 1 WAR 1 THF 1 NIN
mobList[zone][138].mobchildren = {   1, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil  } -- 1 WAR 1 BLM 1 SAM
mobList[zone][139].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil, nil,   1, nil, nil,   1, nil  } -- 1 THF 1 RNG 1 DRG
mobList[zone][140].mobchildren = {   1, nil, nil, nil, nil,   1, nil, nil, nil,   1 ,nil, nil,   1, nil, nil  } -- 1 WAR 1 THF 1 BRD 1 NIN
mobList[zone][141].mobchildren = { nil, nil,   1, nil, nil, nil,   1, nil, nil, nil, nil,   1,   1, nil, nil  } -- 1 WHM 1 PLD 1 SAM 1 NIN
mobList[zone][142].mobchildren = { nil, nil, nil, nil,   1, nil, nil,   1,   1, nil, nil, nil, nil,   1, nil  } -- 1 RDM 1 DRK 1 BST 1 DRG
mobList[zone][143].mobchildren = { nil, nil,   1, nil, nil, nil, nil, nil,   1,   1, nil, nil,   1, nil, nil  } -- 1 WHM 1 BST 1 BRD 1 NIN
mobList[zone][144].mobchildren = {   1, nil, nil, nil, nil,   1, nil, nil, nil, nil,   1,   1, nil, nil,   1, } -- 1 WAR 1 THF 1 RNG 1 SAM 1 SMN
mobList[zone][145].mobchildren = { nil,   1, nil, nil, nil, nil,   1,   1, nil,   1, nil, nil, nil, nil, nil  } -- 1 MNK 1 PLD 1 DRK 1 BRD
mobList[zone][146].mobchildren = { nil, nil,   1, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil,   1, } -- 1 WHM 1 BST 1 SMN
mobList[zone][147].mobchildren = {   1, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil,   1, nil,   1, nil  } -- 1 WAR 1 BLM 1 SAM 1 DRG   
mobList[zone][148].mobchildren = { nil, nil, nil, nil,   1, nil,   1,   1, nil,   1, nil, nil,   1, nil, nil  } -- 1 RDM 1 PLD 1 DRK 1 BRD 1 NIN
mobList[zone][149].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil,   1, nil, nil,  1, nil,    1,   1, } -- 1 THF 1 BST 1 SAM 1 DRG 1 SMN
mobList[zone][150].mobchildren = {   1,   1, nil,   1, nil, nil,   1, nil, nil, nil,   1, nil, nil, nil, nil  } -- 1 WAR 1 MNK 1 BLM 1 PLD 1 RNG

------------------------------------------
--            NM Child Spawn            --
------------------------------------------
-- mobList[zone][MobIndex].NMchildren = {MobIndex(NM1), MobIndex(NM2), MobIndex(NM3)}
-- boolean value = forceLink true/false

mobList[zone][21 ].NMchildren = { true, 22, 23 }
mobList[zone][24 ].NMchildren = { false, 25 }
mobList[zone][32 ].NMchildren = { true, 33 }
mobList[zone][35 ].NMchildren = { true, 36, 37 }
mobList[zone][41 ].NMchildren = { false, 42 }
mobList[zone][46 ].NMchildren = { true, 47, 48, 49, 50, 155 }
mobList[zone][97 ].NMchildren = { false, 98 }
mobList[zone][98 ].NMchildren = { false, 99 }
mobList[zone][99 ].NMchildren = { false, 100 }
mobList[zone][93 ].NMchildren = { true, 153 }
mobList[zone][89 ].NMchildren = { false, 90 }
mobList[zone][91 ].NMchildren = { false, 92 }
mobList[zone][66 ].NMchildren = { true, 67, 68 }
mobList[zone][84 ].NMchildren = { true, 85, 86, 87, 156 }
mobList[zone][80 ].NMchildren = { false, 81, 82, 83 }
mobList[zone][69 ].NMchildren = { true, 70, 71 }
mobList[zone][72 ].NMchildren = { false, 73 }
mobList[zone][74 ].NMchildren = { false, 75, 76 }
mobList[zone][77 ].NMchildren = { false, 78, 79 }
mobList[zone][116].NMchildren = { true, 117, 118, false, 119, 120}
mobList[zone][121].NMchildren = { true, 122, 123, 124, 125, 151, 152 }

------------------------------------------
--          Mob Position Info           --
-- Note: Must be setup for parent mobs, --
-- but is optional for children.        --
------------------------------------------
-- mobList[zone][MobIndex].pos = {xpos, ypos, zpos, rot}

mobList[zone][1  ].pos = { -191.3586,  -0.8007, -119.4225, 131 }
mobList[zone][2  ].pos = { -157.1326,  -1.0388, -132.5858, 162 }
mobList[zone][3  ].pos = { -153.2661,  -1.3726, -126.0487, 169 }
mobList[zone][4  ].pos = { -133.2595,  -2.8095, -141.1245, 129 }
mobList[zone][5  ].pos = { -127.3385,  -2.5025, -141.3002, 129 }
mobList[zone][6  ].pos = { -122.0694,  -2.5000, -141.4553, 129 }
mobList[zone][7  ].pos = { -108.9324,  -2.7290, -131.4035, 78  }
mobList[zone][8  ].pos = {  -78.4401,  -2.5000, -118.3830, 115 }
mobList[zone][9  ].pos = {  -52.5199,  -2.5000, -111.0963, 115 }
mobList[zone][10 ].pos = {  -37.1980,  -2.5000,  -84.0250, 86  }
mobList[zone][11 ].pos = {  -23.3699,  -2.5000,  -59.9240, 87  }
mobList[zone][12 ].pos = {    0.4056,  -3.9816,  -64.6868, 181 }
mobList[zone][13 ].pos = {   -0.5679,  -4.6828,  -40.2208, 57  }
mobList[zone][14 ].pos = {   -4.0851,  -6.9034,  -34.4860, 55  }
mobList[zone][15 ].pos = {    3.0496,  -6.8929,  -33.3899, 66  }
mobList[zone][16 ].pos = {   23.3167,  -2.5356,  -54.0313, 128 } -- AH W
mobList[zone][17 ].pos = {   35.8530,  -1.7400,  -67.6000, 192 } -- AH Front #2
mobList[zone][18 ].pos = {   44.0394,  -2.5000,  -59.0231, 56  } -- AH Front #3
mobList[zone][19 ].pos = {   52.0825,  -2.5000,  -67.6000, 57  } -- AH Front #4
mobList[zone][20 ].pos = {   35.9294,  -1.5051,  -73.7492, 192 } -- AH Front #1
mobList[zone][21 ].pos = {   83.9324,  -2.5000,  -96.0296, 159 }
mobList[zone][22 ].pos = {   73.4111,  -2.5000,  -82.0445, 156 }
mobList[zone][23 ].pos = {   70.7359,  -2.5000,  -84.8624, 157 }
mobList[zone][24 ].pos = {   96.5838,  -2.9733, -150.9429, 161 }
mobList[zone][25 ].pos = {   65.3009,  -2.5000,  -63.9545, 62  }
mobList[zone][26 ].pos = {   65.1695,  -7.5000,  -58.1862, 188 }
mobList[zone][27 ].pos = {   49.7591,  -7.2500,  -50.2882, 125 }
mobList[zone][28 ].pos = {   32.7444,  -6.5569,  -39.2404, 91  }
mobList[zone][29 ].pos = {   -8.9197,  -9.1494,  -17.4656, 193 }
mobList[zone][30 ].pos = {   10.2201,  -9.3104,  -12.8596, 188 }
mobList[zone][31 ].pos = {   29.4569, -10.0000,    9.8415, 115 }
mobList[zone][32 ].pos = {   47.1577,  -9.7839,   26.4536, 203 }
mobList[zone][33 ].pos = {   36.4718, -10.0000,   14.1809, 107 }
mobList[zone][34 ].pos = {   48.9704,  -9.9449,   41.3764, 90  }
mobList[zone][35 ].pos = {   63.9901,  -9.8617,   26.3874, 112 }
mobList[zone][36 ].pos = {   56.4283,  -9.9857,   22.8728, 116 }
mobList[zone][37 ].pos = {   51.1535,  -9.7235,   26.0237, 96  }
mobList[zone][38 ].pos = {   71.1621,  -8.2875,   41.9001, 96  }
mobList[zone][39 ].pos = {   63.9502,  -9.3320,   44.8385, 85  }
mobList[zone][40 ].pos = {   84.2937,  -5.1750,   52.7730, 139 }
mobList[zone][41 ].pos = {   90.3063,  -4.3568,   89.1465, 120 }
mobList[zone][42 ].pos = {   79.5591,  -2.5393,  101.2697, 11  }
mobList[zone][43 ].pos = {   99.7152,  -2.5000,  112.4246, 134 }
mobList[zone][44 ].pos = {  100.5174,  -2.5203,  118.6604, 128 }
mobList[zone][45 ].pos = {  109.7585,  -8.0000,  114.0638, 133 }
mobList[zone][46 ].pos = {  118.6259, -11.5000,  152.0082, 128 }
mobList[zone][47 ].pos = {  119.1999, -11.5000,  147.4525, 136 }
mobList[zone][48 ].pos = {  118.8364, -11.5000,  157.4733, 119 }
mobList[zone][49 ].pos = {  111.9339, -11.0061,  151.8975, 130 }
mobList[zone][50 ].pos = {   96.7755,  -7.8592,  151.8655, 124 }
mobList[zone][51 ].pos = {  101.5380, -10.2956,  137.2695, 228 }
mobList[zone][52 ].pos = {  104.0310,  -9.4472,  175.3735, 156 }
mobList[zone][53 ].pos = {   92.5824,  -7.5977,  188.4694, 97  }
mobList[zone][54 ].pos = {  105.8542,  -8.0000,  189.9759, 101 }
mobList[zone][55 ].pos = {   94.0309,  -8.0000,  201.6249, 84  }
mobList[zone][56 ].pos = {   99.9479, -13.0000,  195.7264, 97  }
mobList[zone][57 ].pos = {  118.8019, -12.5000,  202.3472, 103 }
mobList[zone][58 ].pos = {  -89.5390,  -2.5000,   39.1034, 223 }
mobList[zone][59 ].pos = {  -75.2515,  -2.5000,   27.8064, 32  }
mobList[zone][60 ].pos = {  -65.9548,  -2.5000,   19.0511, 29  }
mobList[zone][61 ].pos = {  -58.6351,  -2.5000,   11.6573, 30  }
mobList[zone][62 ].pos = {  -87.9502,  -4.7914,   63.2007, 69  }
mobList[zone][63 ].pos = {  -88.0065,  -5.0000,   68.2049, 67  }
mobList[zone][64 ].pos = {  -88.0727,  -5.0000,   71.9304, 61  }
mobList[zone][65 ].pos = {  -89.5757,  -9.4564,  104.8087, 254 } -- Island leading to HT
mobList[zone][66 ].pos = {  -68.2300,  -5.0599,  123.0997, 132 }
mobList[zone][67 ].pos = {  -72.9114,  -5.0000,  128.4209, 152 }
mobList[zone][68 ].pos = {  -75.5207,  -5.6239,  122.5561, 140 }
mobList[zone][69 ].pos = {  -97.8836,  -5.4114,  131.3158, 240 }
mobList[zone][70 ].pos = {  -96.6092,  -5.0255,  126.1928, 245 }
mobList[zone][71 ].pos = { -101.2070,  -5.2500,  136.3775, 251 }
mobList[zone][72 ].pos = {  -98.6045,  -5.0716,  121.7827, 252 }
mobList[zone][73 ].pos = {  -85.3194,  -7.2805,  116.8355, 191 }
mobList[zone][74 ].pos = { -106.9414,  -5.2500,  138.3956, 247 }
mobList[zone][75 ].pos = {  -99.4352,  -5.3920,  150.1503, 211 }
mobList[zone][76 ].pos = {  -94.2243,  -5.6397,  148.8194, 203 }
mobList[zone][77 ].pos = { -110.5085, -10.0000,  127.4100, 242 }
mobList[zone][78 ].pos = { -116.7779, -10.0000,  131.8773, 239 }
mobList[zone][79 ].pos = { -113.9647, -10.0000,  116.8070, 239 }
mobList[zone][80 ].pos = { -182.8609,  -2.3945,  147.8914, 1   }
mobList[zone][81 ].pos = { -166.9078,  -2.5000,  147.9220, 250 }
mobList[zone][82 ].pos = { -155.1755,  -2.5000,  147.9511, 1   }
mobList[zone][83 ].pos = { -147.0541,  -2.5000,  147.9715, 255 }
mobList[zone][84 ].pos = {  -97.4772, -18.0000,  194.7494, 38  }
mobList[zone][85 ].pos = {  -93.9415, -13.0165,  190.3358, 35  }
mobList[zone][86 ].pos = {  -90.3463, -12.5000,  205.7868, 39  }
mobList[zone][87 ].pos = { -102.3704, -17.5000,  199.8088, 34  }
mobList[zone][88 ].pos = { -116.9012, -17.5000,  202.7513, 26  }
mobList[zone][89 ].pos = {  -57.1476, -12.5000,  226.7977, 198 }
mobList[zone][90 ].pos = {  -38.1715, -12.5000,  243.5549, 231 }
mobList[zone][91 ].pos = {  -51.9927, -12.5000,  234.5901, 232 }
mobList[zone][92 ].pos = {  -61.2544, -12.5000,  209.1542, 202 }
mobList[zone][93 ].pos = {  -25.9441, -13.0000,  259.9019, 63  }
mobList[zone][94 ].pos = {  -29.3468, -18.0000,  264.7773, 92  } -- HotH Roof #1
mobList[zone][95 ].pos = {  -20.0292, -17.5000,  271.5286, 63  }
mobList[zone][96 ].pos = {  -18.2790, -15.8131,  283.6844, 64  }
mobList[zone][97 ].pos = {   14.9524,  -7.6141,  258.5253, 73  }
mobList[zone][98 ].pos = {    6.4487,  -7.3724,  265.7156, 2   }
mobList[zone][99 ].pos = {   -3.5774,  -9.8122,  272.4613, 22  }
mobList[zone][100].pos = {   -3.8707, -10.0098,  281.4271, 66  }
mobList[zone][101].pos = {    5.8521,  -2.5000,  277.6603, 225 }
mobList[zone][102].pos = {   22.6764,   0.2154,  242.4806, 230 }
mobList[zone][103].pos = {   28.1538,   0.8503,  237.1400, 237 }
mobList[zone][104].pos = {   48.0043,  -7.5000,  226.0027, 64  } -- Bridge to HotH #3
mobList[zone][105].pos = {   42.0040,  -7.5000,  219.0071, 255 } -- Bridge to HotH #2
mobList[zone][106].pos = {   54.0082,  -7.5000,  220.0016, 128 } -- Bridge to HotH #1
mobList[zone][107].pos = {   48.0042,  -7.5000,  213.0020, 192 } -- Bridge to HotH #4
mobList[zone][108].pos = {  -55.4420, -13.2692,  125.4680, 42  } -- Bridge to HT #2
mobList[zone][109].pos = {  -53.2480, -13.2613,  121.7133, 170 } -- Bridge to HT #1
mobList[zone][110].pos = {  -51.1625, -13.5000,  128.1870, 42  } -- Bridge to HT #3
mobList[zone][111].pos = {  -48.9547, -13.5000,  124.2935, 170 } -- Bridge to HT #4
mobList[zone][112].pos = {  -45.7040, -13.5000,  131.2713, 42  } -- Bridge to HT #6
mobList[zone][113].pos = {  -43.1181, -13.5000,  127.9526, 170 } -- Bridge to HT #5
mobList[zone][114].pos = {  -29.6329, -16.0000,  180.4627, 67  }
mobList[zone][115].pos = {   30.1441, -16.0000,  180.0908, 66  }
mobList[zone][116].pos = {   -0.1259, -16.7500,  135.3097, 63  }
mobList[zone][117].pos = {   -1.9202, -16.7500,  132.4733, 63  }
mobList[zone][118].pos = {    1.5785, -16.7500,  130.8298, 68  }
mobList[zone][119].pos = {  -79.2530,  -9.6845,  112.8428, 104 }
mobList[zone][120].pos = {  -76.7854,  -9.8010,  107.8378, 108 }
mobList[zone][121].pos = {   43.6181,  -2.2996,  -65.4926, 64  }
mobList[zone][122].pos = {   40.3916,  -2.5000,  -59.3094, 67  }
mobList[zone][123].pos = {   48.2035,  -2.5000,  -59.4354, 65  }
mobList[zone][124].pos = {   35.9184,  -2.3574,  -65.5872, 62  }
mobList[zone][125].pos = {   52.4692,  -2.5000,  -66.7366, 80  }
mobList[zone][126].pos = {    2.0926,  -9.6610,    4.3648, 52  }
mobList[zone][127].pos = {   -8.2887,  -8.1750,    0.9049, 61  }
mobList[zone][128].pos = {   15.3171,  -9.7436,  -20.1585, 199 }
mobList[zone][129].pos = {  -15.3458,  -9.4624,  -20.5847, 200 }
mobList[zone][130].pos = {  -24.7360,  -2.5000,  -62.6215, 84  }
mobList[zone][131].pos = {  -42.5879,  -2.5000,  -93.5101, 82  }
mobList[zone][132].pos = {  -52.6701,  -2.5000, -110.9600, 114 }
mobList[zone][133].pos = {  -97.5736,  -2.5000, -123.1625, 116 }
mobList[zone][134].pos = { -203.1892,   0.0000, -102.3044, 139 }
mobList[zone][135].pos = { -203.7979,  -0.2568, -139.7601, 127 }
mobList[zone][136].pos = { -224.4653,  -0.2500,  -98.4432, 3   }
mobList[zone][137].pos = { -224.6530,  -0.2500, -142.7501, 2   }
mobList[zone][138].pos = {   83.4762,  -2.5000,   78.5478, 81  }
mobList[zone][139].pos = {   79.1087,  -2.5000,   79.9801, 78  }
mobList[zone][140].pos = {   88.7325,  -5.2644,  147.4140, 141 }
mobList[zone][141].pos = {   88.6722,  -5.4650,  153.6191, 129 }
mobList[zone][142].pos = {   88.1672,  -7.5000,  200.0317, 68  }
mobList[zone][143].pos = {  -18.3020, -12.4241,  242.4440, 165 }
mobList[zone][144].pos = {  -88.6582, -12.4611,  204.1679, 34  }
mobList[zone][145].pos = {  -67.7383, -11.6475,  182.5894, 198 }
mobList[zone][146].pos = {  -73.0340,  -8.9370,  170.9037, 218 }
mobList[zone][147].pos = {  -88.9700,  -6.1359,  162.0545, 244 }
mobList[zone][148].pos = { -151.7798,  -2.5000,  148.1190, 1   }
mobList[zone][149].pos = {   -0.2031, -16.0000,  195.0251, 63  }
mobList[zone][150].pos = {   35.0899, -16.0000,  160.1173, 65  }

----------------------------------------------------------------------------------------------------
--                                    Setup of Mob Functions                                      --
----------------------------------------------------------------------------------------------------
------------------------------------------
--             Patrol Paths             --
------------------------------------------
-- mobList[zone][MobIndex].patrolPath = {xpos1,ypos1,zpos1, xpos2,ypos2,zpos2,  xpos3,ypos3,zpos3}

mobList[zone][8  ].patrolPath = { -96,  -2, -123,     -60,  -2, -113,    -96,   -2, -123  }    -- Entrance Bridge W
mobList[zone][10 ].patrolPath = { -48,  -2, -104,     -29,  -2,  -70,    -48,   -2, -104  }    -- Entrance Bridge E
mobList[zone][13 ].patrolPath = {   0,  -9,  -20,      -0,  -4,  -51,      0,   -9, -20   }    -- AH W Ramp
mobList[zone][17 ].patrolPath = {  38,  -2,  -60,      38,  -2,  -67,     38,   -2, -58   }     -- AH #1
mobList[zone][18 ].patrolPath = {  46,  -1,  -70,      46,  -2,  -59,     46,   -1, -70   }     -- AH #2
mobList[zone][19 ].patrolPath = {  54,  -2,  -60,      54,  -2,  -67,     54,   -2, -60   }     -- AH #3
mobList[zone][52 ].patrolPath = {  99,  -8,  179,     108, -11,  171,     99,   -8, 179   } -- E House Ramp
mobList[zone][73 ].patrolPath = { -84,  -9,  111,     -85,  -6,  121,     -84,  -9, 111   } -- Island to HT
mobList[zone][62 ].patrolPath = { -88,  -2,   48,     -88,  -5,   82,     -88,  -2, 48    } -- SW Bridge #1
mobList[zone][63 ].patrolPath = { -88,  -2,   48,     -88,  -5,   82,     -88,  -2, 48    } -- SW Bridge #2
mobList[zone][64 ].patrolPath = { -88,  -2,   48,     -88,  -5,   82,     -88,  -2, 48    } -- SW Bridge #3
mobList[zone][89 ].patrolPath = { -57, -13,  226,     -61, -13,  209,     -57, -13, 226   } -- NW Bridge S
mobList[zone][91 ].patrolPath = { -52, -13,  234,     -36, -13,  244,     -52, -13, 234   } -- NW Bridge N
mobList[zone][107].patrolPath = {  48,  -8,  213,      48,  -8,  216,      48,  -8, 213   } -- Bridge to HotH #4
mobList[zone][106].patrolPath = {  54,  -8,  220,      51,  -8,  220,      54,  -8, 220   } -- Bridge to HotH #1
mobList[zone][104].patrolPath = {  48,  -8,  226,      48,  -8,  223,      48,  -8, 226   } -- Bridge to HotH #3
mobList[zone][105].patrolPath = {  42,  -8,  219,      45,  -8,  219,      42,  -8, 219   } -- Bridge to HotH #2

------------------------------------------
--          Statue Eye Colors           --
------------------------------------------
-- mobList[zone][MobIndex].eyes = dynamisEyesEra.BLUE -- Flags for blue eyes. (HP)
-- mobList[zone][MobIndex].eyes = dynamisEyesEra.GREEN -- Flags for green eyes. (MP)
-- mobList[zone][MobIndex].eyes = dynamisEyesEra.RED -- Flags for red eyes. (TE)

mobList[zone][6  ].eyes = dynamisEyesEra.BLUE
mobList[zone][8  ].eyes = dynamisEyesEra.GREEN
mobList[zone][12 ].eyes = dynamisEyesEra.BLUE
mobList[zone][17 ].eyes = dynamisEyesEra.GREEN
mobList[zone][18 ].eyes = dynamisEyesEra.RED
mobList[zone][19 ].eyes = dynamisEyesEra.BLUE
mobList[zone][24 ].eyes = dynamisEyesEra.BLUE
mobList[zone][25 ].eyes = dynamisEyesEra.GREEN
mobList[zone][29 ].eyes = dynamisEyesEra.BLUE
mobList[zone][30 ].eyes = dynamisEyesEra.GREEN
mobList[zone][31 ].eyes = dynamisEyesEra.RED
mobList[zone][32 ].eyes = dynamisEyesEra.GREEN
mobList[zone][35 ].eyes = dynamisEyesEra.BLUE
mobList[zone][40 ].eyes = dynamisEyesEra.GREEN
mobList[zone][41 ].eyes = dynamisEyesEra.RED
mobList[zone][42 ].eyes = dynamisEyesEra.BLUE
mobList[zone][45 ].eyes = dynamisEyesEra.GREEN
mobList[zone][51 ].eyes = dynamisEyesEra.BLUE
mobList[zone][56 ].eyes = dynamisEyesEra.BLUE
mobList[zone][57 ].eyes = dynamisEyesEra.GREEN
mobList[zone][58 ].eyes = dynamisEyesEra.RED
mobList[zone][60 ].eyes = dynamisEyesEra.GREEN
mobList[zone][66 ].eyes = dynamisEyesEra.RED
mobList[zone][72 ].eyes = dynamisEyesEra.GREEN
mobList[zone][74 ].eyes = dynamisEyesEra.BLUE
mobList[zone][77 ].eyes = dynamisEyesEra.GREEN
mobList[zone][80 ].eyes = dynamisEyesEra.GREEN
mobList[zone][83 ].eyes = dynamisEyesEra.BLUE
mobList[zone][88 ].eyes = dynamisEyesEra.BLUE
mobList[zone][94 ].eyes = dynamisEyesEra.BLUE
mobList[zone][95 ].eyes = dynamisEyesEra.BLUE
mobList[zone][100].eyes = dynamisEyesEra.BLUE
mobList[zone][101].eyes = dynamisEyesEra.RED
mobList[zone][110].eyes = dynamisEyesEra.BLUE
mobList[zone][111].eyes = dynamisEyesEra.GREEN
mobList[zone][117].eyes = dynamisEyesEra.BLUE
mobList[zone][118].eyes = dynamisEyesEra.GREEN
mobList[zone][126].eyes = dynamisEyesEra.BLUE
mobList[zone][127].eyes = dynamisEyesEra.GREEN
mobList[zone][131].eyes = dynamisEyesEra.GREEN
mobList[zone][133].eyes = dynamisEyesEra.BLUE
mobList[zone][136].eyes = dynamisEyesEra.BLUE
mobList[zone][137].eyes = dynamisEyesEra.GREEN
mobList[zone][138].eyes = dynamisEyesEra.BLUE
mobList[zone][139].eyes = dynamisEyesEra.GREEN

------------------------------------------
--        Time Extension Values         --
------------------------------------------
-- mobList[zone][MobIndex].timeExtension = 15

mobList[zone][8  ].timeExtension = 20 --Avatar Icon
mobList[zone][18 ].timeExtension = 20 --Avatar Icon
mobList[zone][31 ].timeExtension = 10 --Avatar Icon
mobList[zone][41 ].timeExtension = 20 --Avatar Icon
mobList[zone][58 ].timeExtension = 20 --Avatar Icon
mobList[zone][66 ].timeExtension = 20 --Avatar Icon
mobList[zone][101].timeExtension = 10 --Avatar Icon
mobList[zone][121].timeExtension = 30 --Tzee_Xicu_Idol