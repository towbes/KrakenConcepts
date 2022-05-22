----------------------------------------------------------------------------------------------------
--                                      Dynamis-Xarcabard                                            --
--              Primary Source of Information: https://enedin.be/dyna/html/zone/xar.htm           --
--           Secondary Source of Information: http://www.dynamisbums.com/strategy/xar.html        --
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
local zone = xi.zone.DYNAMIS_XARCABARD
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

mobList[zone][1  ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 001-D
mobList[zone][2  ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 002-D
mobList[zone][3  ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 003-D
mobList[zone][4  ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 004-D
mobList[zone][5  ].info = {"Statue", "Statue Prototype", nil, nil, nil} -- 005-G Statue Prototype
mobList[zone][6  ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 006-D
mobList[zone][7  ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 007-D
mobList[zone][8  ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 008-D
mobList[zone][9  ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 009-D
mobList[zone][10 ].info = {"Statue", "Tombstone Prototype", nil, nil, nil} -- 010-O(30) Tombstone Prototype
mobList[zone][11 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 011-D
mobList[zone][12 ].info = {"Statue", "Effigy Prototype", nil, nil, nil} -- 012-Q Effigy Prototype
mobList[zone][13 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 013-D
mobList[zone][14 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 014-D
mobList[zone][15 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 015-D
mobList[zone][16 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 016-D
mobList[zone][17 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 017-D
mobList[zone][18 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 018-D
mobList[zone][19 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 019-D
mobList[zone][20 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 020-D
mobList[zone][21 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 021-D
mobList[zone][22 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 022-D
mobList[zone][23 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 023-D
mobList[zone][24 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 024-D
mobList[zone][25 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 025-D
mobList[zone][26 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 026-D
mobList[zone][27 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 027-D
mobList[zone][28 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 028-D
mobList[zone][29 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 029-D
mobList[zone][30 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 030-D
mobList[zone][31 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 031-D
mobList[zone][32 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 032-D
mobList[zone][33 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 033-D
mobList[zone][34 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 034-D
mobList[zone][35 ].info = {"Statue", "Vanguard Eye", nil, nil, "35_killed"} -- 035-D Vanguard Eye (spawns 36-38)
mobList[zone][36 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 036-D
mobList[zone][37 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 037-D
mobList[zone][38 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 038-D
mobList[zone][39 ].info = {"Statue", "Vanguard Eye", nil, nil, "39_killed"} -- 039-D Vanguard Eye (spawns 40-42)
mobList[zone][40 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 040-D
mobList[zone][41 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 041-D
mobList[zone][42 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 042-D
mobList[zone][43 ].info = {"Statue", "Icon Prototype", nil, nil, nil} -- 043-Y(30) Icon Prototype
mobList[zone][44 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 044-D
mobList[zone][45 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 045-D
mobList[zone][46 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 046-D
mobList[zone][47 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 047-D
mobList[zone][48 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 048-D
mobList[zone][49 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 049-D
mobList[zone][50 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 050-D
mobList[zone][51 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 051-D
mobList[zone][52 ].info = {"Statue", "Icon Prototype", nil, nil, nil} -- 052-Y(HP) Icon Prototype
mobList[zone][53 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 053-D
mobList[zone][54 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 054-D
mobList[zone][55 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 055-D
mobList[zone][56 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 056-D
mobList[zone][57 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 057-D
mobList[zone][58 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 058-D
mobList[zone][59 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 059-D
mobList[zone][60 ].info = {"Statue", "Tombstone Prototype", nil, nil, nil} -- 060-O(30) Tombstone Prototype
mobList[zone][61 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 061-D
mobList[zone][62 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 062-D
mobList[zone][63 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 063-D
mobList[zone][64 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 064-D
mobList[zone][65 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 065-D
mobList[zone][66 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 066-D
mobList[zone][67 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 067-D
mobList[zone][68 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 068-D
mobList[zone][69 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 069-D
mobList[zone][70 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 070-D
mobList[zone][71 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 071-D
mobList[zone][72 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 072-D
mobList[zone][73 ].info = {"Statue", "Icon Prototype", nil, nil, nil} -- 073-Y(MP) Icon Prototype
mobList[zone][74 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 074-D
mobList[zone][75 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 075-D
mobList[zone][76 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 076-D
mobList[zone][77 ].info = {"Statue", "Tombstone Prototype", nil, nil, nil} -- 077-O(MP) Tombstone Prototype
mobList[zone][78 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 078-D
mobList[zone][79 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 079-D
mobList[zone][80 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 080-D
mobList[zone][81 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 081-D
mobList[zone][82 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 082-D
mobList[zone][83 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 083-D
mobList[zone][84 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 084-D
mobList[zone][85 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 085-D
mobList[zone][86 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 086-D
mobList[zone][87 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 087-D
mobList[zone][88 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 088-D
mobList[zone][89 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 089-D
mobList[zone][90 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 090-D
mobList[zone][91 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 091-D
mobList[zone][92 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 092-D
mobList[zone][93 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 093-D
mobList[zone][94 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 094-D
mobList[zone][95 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 095-D
mobList[zone][96 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 096-D
mobList[zone][97 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 097-D
mobList[zone][98 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 098-D
mobList[zone][99 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 099-D
mobList[zone][100].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 100-D
mobList[zone][101].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 101-D
mobList[zone][102].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 102-D
mobList[zone][103].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 103-D
mobList[zone][104].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 104-D
mobList[zone][105].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 105-D
mobList[zone][106].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 106-D
mobList[zone][107].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 107-D
mobList[zone][108].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 108-D
mobList[zone][109].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 109-D
mobList[zone][110].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 110-D
mobList[zone][111].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 111-D
mobList[zone][112].info = {"Statue", "Effigy Prototype", nil, nil, nil} -- 112-Q(HP) Effigy Prototype
mobList[zone][113].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 113-D
mobList[zone][114].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 114-D
mobList[zone][115].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 115-D
mobList[zone][116].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 116-D
mobList[zone][117].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 117-D
mobList[zone][118].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 118-D
mobList[zone][119].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 119-D
mobList[zone][120].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 120-D
mobList[zone][121].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 121-D
mobList[zone][122].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 122-D
mobList[zone][123].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 123-D
mobList[zone][124].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 124-D
mobList[zone][125].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 125-D
mobList[zone][126].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 126-D
mobList[zone][127].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 127-D  Pops Marquis Decarabia BRD
mobList[zone][128].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 128-D  Pops Count Zaebos WAR
mobList[zone][129].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 129-D  Pops Duke Berith RDM
mobList[zone][130].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 130-D  Pops Prince Seere WHM
mobList[zone][131].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 131-D  Pops Duke Gomory MNK
mobList[zone][132].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 132-D  Pops Marquis Andras BST
mobList[zone][133].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 133-D  Pops Marquis Gamygyn NIN
mobList[zone][134].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 134-D  Pops Duke Scox DRK
mobList[zone][135].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 135-D  Pops Marquis Orias BLM
mobList[zone][136].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 136-D  Pops Count Raum THF
mobList[zone][137].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 137-D  Pops Marquis Sabnak PLD
mobList[zone][138].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 138-D  Pops Marquis Nebiros SMN
mobList[zone][139].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 139-D  Pops King Zagan DRG
mobList[zone][140].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 140-D  Pops Count Vine SAM
mobList[zone][141].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 141-D  Pops Marquis Cimeries RNG
mobList[zone][142].info = {"Statue", "Effigy Prototype", nil, nil, nil} -- 142-Q(HP)     Effigy Prototype
mobList[zone][143].info = {"Statue", "Statue Prototype", nil, nil, nil} -- 143-G(30)     Statue Prototype
mobList[zone][144].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 144-D
mobList[zone][145].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 145-D
mobList[zone][146].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 146-D
mobList[zone][147].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 147-D
mobList[zone][148].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 148-D
mobList[zone][149].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- 149-D
mobList[zone][150].info = {"Statue", "Statue Prototype", nil, nil, nil} -- 150-G(30)     Statue Prototype
mobList[zone][151].info = {"NM", "Animated Hammer",     nil, nil, nil} -- 151-Animated Hammer
mobList[zone][152].info = {"NM", "Animated Dagger",     nil, nil, nil} -- 152-Animated Dagger
mobList[zone][153].info = {"NM", "Animated Shield ",    nil, nil, nil} -- 153-Animated Shield
mobList[zone][154].info = {"NM", "Animated Claymore ",  nil, nil, nil} -- 154-Animated Claymore
mobList[zone][155].info = {"NM", "Animated Gun",        nil, nil, nil} -- 155-Animated Gun
mobList[zone][156].info = {"NM", "Animated Longbow",    nil, nil, nil} -- 156-Animated Longbow
mobList[zone][157].info = {"NM", "Animated Tachi",      nil, nil, nil} -- 157-Animated Tachi
mobList[zone][158].info = {"NM", "Animated Tabar",      nil, nil, nil} -- 158-Animated Tabar
mobList[zone][159].info = {"NM", "Animated Staff",      nil, nil, nil} -- 159-Animated Staff
mobList[zone][160].info = {"NM", "Animated Spear",      nil, nil, nil} -- 160-Animated Spear
mobList[zone][161].info = {"NM", "Animated Kunai",      nil, nil, nil} -- 161-Animated Kunai
mobList[zone][162].info = {"NM", "Animated Knuckles",   nil, nil, nil} -- 162-Animated Knuckles
mobList[zone][163].info = {"NM", "Animated Great Axe",  nil, nil, nil} -- 163-Animated Great Axe
mobList[zone][164].info = {"NM", "Animated Horn",       nil, nil, nil} -- 164-Animated Horn
mobList[zone][165].info = {"NM", "Animated Longsword",  nil, nil, nil} -- 165-Animated Longsword
mobList[zone][166].info = {"NM", "Animated Scythe",     nil, nil, nil} -- 166-Animated Scythe
mobList[zone][167].info = {"NM", "Vanguard Dragon",     nil, nil, nil} -- 167-Vanguard Dragon
mobList[zone][168].info = {"NM", "Vanguard Dragon",     nil, nil, nil} -- 168-Vanguard Dragon
mobList[zone][169].info = {"NM", "Vanguard Dragon",     nil, nil, nil} -- 169-Vanguard Dragon
mobList[zone][170].info = {"NM", "Vanguard Dragon",     nil, nil, nil} -- 170-Vanguard Dragon
mobList[zone][171].info = {"NM", "Vanguard Dragon",     nil, nil, nil} -- 171-Vanguard Dragon
mobList[zone][172].info = {"NM", "Vanguard Dragon",     nil, nil, nil} -- 172-Vanguard Dragon
mobList[zone][173].info = {"NM", "Vanguard Dragon",     nil, nil, nil} -- 173-Vanguard Dragon
mobList[zone][174].info = {"NM", "Vanguard Dragon",     nil, nil, nil} -- 174-Vanguard Dragon
mobList[zone][175].info = {"NM", "Vanguard Dragon",     nil, nil, nil} -- 175-Vanguard Dragon
mobList[zone][176].info = {"NM", "Vanguard Dragon",     nil, nil, nil} -- 176-Vanguard Dragon
mobList[zone][177].info = {"NM", "Yang",                nil, nil, "yang_killed"} -- 177-Shadow Dragon NM (Yang)
mobList[zone][178].info = {"NM", "Ying",                nil, nil, "ying_killed"} -- 178-Shadow Dragon NM (Ying)
mobList[zone][179].info = {"NM", "Dynamis Lord",        nil, nil, nil} -- 179-Dynamis Lord

-- Animated Hammer
mobList[zone][180].info = {"NM", "Satellite Hammer", nil, nil, nil} -- Satellite Hammer
mobList[zone][181].info = {"NM", "Satellite Hammer", nil, nil, nil} -- Satellite Hammer
mobList[zone][182].info = {"NM", "Satellite Hammer", nil, nil, nil} -- Satellite Hammer
mobList[zone][183].info = {"NM", "Satellite Hammer", nil, nil, nil} -- Satellite Hammer
-- Animated Dagger
mobList[zone][184].info = {"NM", "Satellite Dagger", nil, nil, nil} -- Satellite Dagger
mobList[zone][185].info = {"NM", "Satellite Dagger", nil, nil, nil} -- Satellite Dagger
mobList[zone][186].info = {"NM", "Satellite Dagger", nil, nil, nil} -- Satellite Dagger
mobList[zone][187].info = {"NM", "Satellite Dagger", nil, nil, nil} -- Satellite Dagger
-- Animated Shield
mobList[zone][188].info = {"NM", "Satellite Shield", nil, nil, nil} -- Satellite Shield
mobList[zone][189].info = {"NM", "Satellite Shield", nil, nil, nil} -- Satellite Shield
mobList[zone][190].info = {"NM", "Satellite Shield", nil, nil, nil} -- Satellite Shield
mobList[zone][191].info = {"NM", "Satellite Shield", nil, nil, nil} -- Satellite Shield
-- Animated Claymore
mobList[zone][192].info = {"NM", "Satellite Claymore", nil, nil, nil} -- Satellite Claymore
mobList[zone][193].info = {"NM", "Satellite Claymore", nil, nil, nil} -- Satellite Claymore
mobList[zone][194].info = {"NM", "Satellite Claymore", nil, nil, nil} -- Satellite Claymore
mobList[zone][195].info = {"NM", "Satellite Claymore", nil, nil, nil} -- Satellite Claymore
-- Animated Gun
mobList[zone][196].info = {"NM", "Satellite Gun", nil, nil, nil} -- Satellite Gun
mobList[zone][197].info = {"NM", "Satellite Gun", nil, nil, nil} -- Satellite Gun
mobList[zone][198].info = {"NM", "Satellite Gun", nil, nil, nil} -- Satellite Gun
mobList[zone][199].info = {"NM", "Satellite Gun", nil, nil, nil} -- Satellite Gun
-- Animated Longbow
mobList[zone][200].info = {"NM", "Satellite Longbow", nil, nil, nil} -- Satellite Longbow
mobList[zone][201].info = {"NM", "Satellite Longbow", nil, nil, nil} -- Satellite Longbow
mobList[zone][202].info = {"NM", "Satellite Longbow", nil, nil, nil} -- Satellite Longbow
mobList[zone][203].info = {"NM", "Satellite Longbow", nil, nil, nil} -- Satellite Longbow
-- Animated Tachi
mobList[zone][204].info = {"NM", "Satellite Tachi", nil, nil, nil} -- Satellite Tachi
mobList[zone][205].info = {"NM", "Satellite Tachi", nil, nil, nil} -- Satellite Tachi
mobList[zone][206].info = {"NM", "Satellite Tachi", nil, nil, nil} -- Satellite Tachi
mobList[zone][207].info = {"NM", "Satellite Tachi", nil, nil, nil} -- Satellite Tachi
-- Animated Tabar
mobList[zone][208].info = {"NM", "Satellite Tabar", nil, nil, nil} -- Satellite Tabar
mobList[zone][209].info = {"NM", "Satellite Tabar", nil, nil, nil} -- Satellite Tabar
mobList[zone][210].info = {"NM", "Satellite Tabar", nil, nil, nil} -- Satellite Tabar
mobList[zone][211].info = {"NM", "Satellite Tabar", nil, nil, nil} -- Satellite Tabar
-- Animated Staff
mobList[zone][212].info = {"NM", "Satellite Staff", nil, nil, nil} -- Satellite Staff
mobList[zone][213].info = {"NM", "Satellite Staff", nil, nil, nil} -- Satellite Staff
mobList[zone][214].info = {"NM", "Satellite Staff", nil, nil, nil} -- Satellite Staff
mobList[zone][215].info = {"NM", "Satellite Staff", nil, nil, nil} -- Satellite Staff
-- Animated Spear
mobList[zone][216].info = {"NM", "Satellite Spear", nil, nil, nil} -- Satellite Spear
mobList[zone][217].info = {"NM", "Satellite Spear", nil, nil, nil} -- Satellite Spear
mobList[zone][218].info = {"NM", "Satellite Spear", nil, nil, nil} -- Satellite Spear
mobList[zone][219].info = {"NM", "Satellite Spear", nil, nil, nil} -- Satellite Spear
-- Animated Kunai
mobList[zone][220].info = {"NM", "Satellite Kunai", nil, nil, nil} -- Satellite Kunai
mobList[zone][221].info = {"NM", "Satellite Kunai", nil, nil, nil} -- Satellite Kunai
mobList[zone][222].info = {"NM", "Satellite Kunai", nil, nil, nil} -- Satellite Kunai
mobList[zone][223].info = {"NM", "Satellite Kunai", nil, nil, nil} -- Satellite Kunai
-- Animated Knuckles
mobList[zone][224].info = {"NM", "Satellite Knuckles", nil, nil, nil} -- Satellite Knuckles
mobList[zone][225].info = {"NM", "Satellite Knuckles", nil, nil, nil} -- Satellite Knuckles
mobList[zone][226].info = {"NM", "Satellite Knuckles", nil, nil, nil} -- Satellite Knuckles
mobList[zone][227].info = {"NM", "Satellite Knuckles", nil, nil, nil} -- Satellite Knuckles
-- Animated Great Axe
mobList[zone][228].info = {"NM", "Satellite Great Axe", nil, nil, nil} -- Satellite Great Axe
mobList[zone][229].info = {"NM", "Satellite Great Axe", nil, nil, nil} -- Satellite Great Axe
mobList[zone][230].info = {"NM", "Satellite Great Axe", nil, nil, nil} -- Satellite Great Axe
mobList[zone][231].info = {"NM", "Satellite Great Axe", nil, nil, nil} -- Satellite Great Axe
-- Animated Horn
mobList[zone][232].info = {"NM", "Satellite Horn", nil, nil, nil} -- Satellite Horn
mobList[zone][233].info = {"NM", "Satellite Horn", nil, nil, nil} -- Satellite Horn
mobList[zone][234].info = {"NM", "Satellite Horn", nil, nil, nil} -- Satellite Horn
mobList[zone][235].info = {"NM", "Satellite Horn", nil, nil, nil} -- Satellite Horn
-- Animated Longsword
mobList[zone][236].info = {"NM", "Satellite Longsword", nil, nil, nil} -- Satellite Longsword
mobList[zone][237].info = {"NM", "Satellite Longsword", nil, nil, nil} -- Satellite Longsword
mobList[zone][238].info = {"NM", "Satellite Longsword", nil, nil, nil} -- Satellite Longsword
mobList[zone][239].info = {"NM", "Satellite Longsword", nil, nil, nil} -- Satellite Longsword
-- Animated Scythe
mobList[zone][240].info = {"NM", "Satellite Scythe", nil, nil, nil} -- Satellite Scythe
mobList[zone][241].info = {"NM", "Satellite Scythe", nil, nil, nil} -- Satellite Scythe
mobList[zone][242].info = {"NM", "Satellite Scythe", nil, nil, nil} -- Satellite Scythe
mobList[zone][243].info = {"NM", "Satellite Scythe", nil, nil, nil} -- Satellite Scythe
-- Demon NMs
mobList[zone][244].info = {"NM", "Marquis Decarabia",   nil, "BRD", "Decarabia_killed"  } -- Marquis Decarabia BRD
mobList[zone][245].info = {"NM", "Count Zaebos",        nil, "WAR", "Zaebos_killed"     } -- Count Zaebos WAR
mobList[zone][246].info = {"NM", "Duke Berith",         nil, "RDM", "Berith_killed"     } -- Duke Berith RDM
mobList[zone][247].info = {"NM", "Prince Seere",        nil, "WHM", "Seere_killed"      } -- Prince Seere WHM
mobList[zone][248].info = {"NM", "Duke Gomory",         nil, "MNK", "Gomory_killed"     } -- Duke Gomory MNK
mobList[zone][249].info = {"NM", "Marquis Andras",      nil, "BST", "Andras_killed"     } -- Marquis Andras BST
mobList[zone][250].info = {"NM", "Marquis Gamygyn",     nil, "NIN", "Gamygyn_killed"    } -- Marquis Gamygyn NIN
mobList[zone][251].info = {"NM", "Duke Scox",           nil, "DRK", "Scox_killed"       } -- Duke Scox DRK
mobList[zone][252].info = {"NM", "Marquis Orias",       nil, "BLM", "Orias_killed"      } -- Marquis Orias BLM
mobList[zone][253].info = {"NM", "Count Raum",          nil, "THF", "Raum_killed"       } -- Count Raum THF
mobList[zone][254].info = {"NM", "Marquis Sabnak",      nil, "PLD", "Sabnak_killed"     } -- Marquis Sabnak PLD
mobList[zone][255].info = {"NM", "Marquis Nebiros",     nil, "SMN", "Nebiros_killed"    } -- Marquis Nebiros SMN
mobList[zone][256].info = {"NM", "King Zagan",          nil, "DRG", "Zagan_killed"      } -- King Zagan DRG
mobList[zone][257].info = {"NM", "Count Vine",          nil, "SAM", "Vine_killed"       } -- Count Vine SAM
mobList[zone][258].info = {"NM", "Marquis Cimeries",    nil, "RNG", "Cimeries_killed"   } -- Marquis Cimeries RNG

----------------------------------------------------------------------------------------------------
--                                    Setup of Wave Spawning                                      --
----------------------------------------------------------------------------------------------------

---------------------------------------------
--           Wave Defeat Reqs.          --
--------------------------------------------
--mobList[zone].waveDefeatRequirements[2] = {zone:getLocalVar("MegaBoss_Killed") == 1}

mobList[zone].waveDefeatRequirements[2] = { zone:getLocalVar("35_killed") == 1, zone:getLocalVar("39_killed") == 1 } -- Spawns 43
mobList[zone].waveDefeatRequirements[3] = { zone:getLocalVar("58_killed") == 1 } -- Spawns 60
mobList[zone].waveDefeatRequirements[4] = { zone:getLocalVar("142_killed") == 1,
                                            zone:getLocalVar("143_killed") == 1,
                                            zone:getLocalVar("144_killed") == 1,
                                            zone:getLocalVar("145_killed") == 1,
                                            zone:getLocalVar("146_killed") == 1,
                                            zone:getLocalVar("147_killed") == 1,
                                            zone:getLocalVar("148_killed") == 1,
                                            zone:getLocalVar("149_killed") == 1    -- Spawns 150
                                          }
mobList[zone].waveDefeatRequirements[5] = { zone:getLocalVar("Decarabia_killed") == 1,
                                            zone:getLocalVar("Zaebos_killed") == 1,
                                            zone:getLocalVar("Berith_killed") == 1,
                                            zone:getLocalVar("Seere_killed") == 1,
                                            zone:getLocalVar("Gomory_killed") == 1,
                                            zone:getLocalVar("Andras_killed") == 1,
                                            zone:getLocalVar("Gamygyn_killed") == 1,
                                            zone:getLocalVar("Scox_killed") == 1,
                                            zone:getLocalVar("Orias_killed") == 1,
                                            zone:getLocalVar("Raum_killed") == 1,
                                            zone:getLocalVar("Sabnak_killed") == 1,
                                            zone:getLocalVar("Nebiros_killed") == 1,
                                            zone:getLocalVar("Zagan_killed") == 1,
                                            zone:getLocalVar("Vine_killed") == 1,
                                            zone:getLocalVar("Cimeries_killed") == 1  -- Demon NMs spawn Animated Weapons, Vanguard Dragons, Ying, Yang
                                          }
mobList[zone].waveDefeatRequirements[6] = { zone:getLocalVar("ying_killed") == 1,
                                            zone:getLocalVar("yang_killed") == 1
                                          }

------------------------------------------
--            Wave Spawning             --
-- Note: Wave 1 spawns at start.        --
------------------------------------------
--mobList[zone].wave# = { MobIndex#1, MobIndex#2, MobIndex#3 }

mobList[zone].wave1 = {
    1  , -- 001-D
    2  , -- 002-D
    3  , -- 003-D
    4  , -- 004-D
    5  , -- 005-G
    6  , -- 006-D
    7  , -- 007-D
    8  , -- 008-D
    9  , -- 009-D
    10 , -- 010-O(30)
    11 , -- 011-D
    12 , -- 012-Q
    13 , -- 013-D
    14 , -- 014-D
    15 , -- 015-D
    16 , -- 016-D
    17 , -- 017-D
    18 , -- 018-D
    19 , -- 019-D
    20 , -- 020-D
    21 , -- 021-D
    22 , -- 022-D
    23 , -- 023-D
    24 , -- 024-D
    25 , -- 025-D
    26 , -- 026-D
    27 , -- 027-D
    28 , -- 028-D
    29 , -- 029-D
    30 , -- 030-D
    31 , -- 031-D
    32 , -- 032-D
    33 , -- 033-D
    34 , -- 034-D
    38 , -- 038-D
    42 , -- 042-D
    44 , -- 044-D
    45 , -- 045-D
    46 , -- 046-D
    47 , -- 047-D
    48 , -- 048-D
    49 , -- 049-D
    50 , -- 050-D
    51 , -- 051-D
    52 , -- 052-Y(HP)
    53 , -- 053-D
    54 , -- 054-D
    55 , -- 055-D
    56 , -- 056-D
    57 , -- 057-D
    58 , -- 058-D
    59 , -- 059-D
    61 , -- 061-D
    62 , -- 062-D
    63 , -- 063-D
    64 , -- 064-D
    65 , -- 065-D
    66 , -- 066-D
    67 , -- 067-D
    68 , -- 068-D
    69 , -- 069-D
    70 , -- 070-D
    71 , -- 071-D
    72 , -- 072-D
    73 , -- 073-Y(MP)
    74 , -- 074-D
    75 , -- 075-D
    76 , -- 076-D
    77 , -- 077-O(MP)
    78 , -- 078-D
    79 , -- 079-D
    80 , -- 080-D
    81 , -- 081-D
    82 , -- 082-D
    83 , -- 083-D
    84 , -- 084-D
    85 , -- 085-D
    86 , -- 086-D
    87 , -- 087-D
    88 , -- 088-D
    89 , -- 089-D
    90 , -- 090-D
    91 , -- 091-D
    92 , -- 092-D
    93 , -- 093-D
    94 , -- 094-D
    95 , -- 095-D
    96 , -- 096-D
    97 , -- 097-D
    98 , -- 098-D
    99 , -- 099-D
    100, -- 100-D
    101, -- 101-D
    102, -- 102-D
    103, -- 103-D
    104, -- 104-D
    105, -- 105-D
    106, -- 106-D
    107, -- 107-D
    108, -- 108-D
    109, -- 109-D
    110, -- 110-D
    111, -- 111-D
    112, -- 112-Q(HP)
    113, -- 113-D
    114, -- 114-D
    115, -- 115-D
    116, -- 116-D
    117, -- 117-D
    118, -- 118-D
    119, -- 119-D
    120, -- 120-D
    121, -- 121-D
    122, -- 122-D
    123, -- 123-D
    124, -- 124-D
    125, -- 125-D
    126, -- 126-D
    127, -- 127-D
    128, -- 128-D
    129, -- 129-D
    130, -- 130-D
    131, -- 131-D
    132, -- 132-D
    133, -- 133-D
    134, -- 134-D
    135, -- 135-D
    136, -- 136-D
    137, -- 137-D
    138, -- 138-D
    139, -- 139-D
    140, -- 140-D
    141, -- 141-D
    142, -- 142-Q(HP)
    143, -- 143-G(30)
    144, -- 144-D
    145, -- 145-D
    146, -- 146-D
    147, -- 147-D
    148, -- 148-D
    149  -- 149-D
}

mobList[zone].wave2 = {
    43   -- Icon Prototype
}

mobList[zone].wave3 = {
    60   -- Tombstone Prototype
}

mobList[zone].wave4 = {
    150  -- Statue Prototype
}

mobList[zone].wave5 = {
    151, -- Animated Hammer
    152, -- Animated Dagger
    153, -- Animated Shield
    154, -- Animated Claymore
    155, -- Animated Gun
    156, -- Animated Longbow
    157, -- Animated Tachi
    158, -- Animated Tabar
    159, -- Animated Staff
    160, -- Animated Spear
    161, -- Animated Kunai
    162, -- Animated Knuckles
    163, -- Animated Great Axe
    164, -- Animated Horn
    165, -- Animated Longsword
    166, -- Animated Scythe
    167, -- Vanguard Dragon
    168, -- Vanguard Dragon
    169, -- Vanguard Dragon
    170, -- Vanguard Dragon
    171, -- Vanguard Dragon
    172, -- Vanguard Dragon
    173, -- Vanguard Dragon
    174, -- Vanguard Dragon
    175, -- Vanguard Dragon
    176, -- Vanguard Dragon
    177, -- Shadow Dragon NM (Yang)
    178  -- Shadow Dragon NM (Ying)
}

mobList[zone].wave6 = {
    179  -- Dynamis Lord
}
----------------------------------------------------------------------------------------------------
--                                  Setup of Children Spawning                                    --
----------------------------------------------------------------------------------------------------
------------------------------------------
--          Normal Child Spawn          --
------------------------------------------
-- mobList[zone][MobIndex].mobchildren = {#WAR, #MNK, #WHM, #BLM, #RDM, #THF, #PLD, #DRK, #BST, #BRD, #RNG, #SAM, #NIN, #DRG, #SMN}

mobList[zone][1  ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil  }  --   2 SAM
mobList[zone][2  ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2  }  --   2 SMN
mobList[zone][3  ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil  }  --   2 DRG
mobList[zone][4  ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil  }  --   2 NIN
mobList[zone][6  ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   3, nil, nil, nil, nil, nil, nil  }  --   3 BST
mobList[zone][7  ].mobchildren = { nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil,   2, nil  }  --   1 PLD  2 DRG
mobList[zone][8  ].mobchildren = { nil, nil, nil, nil, nil, nil,   1,   2, nil, nil, nil, nil, nil, nil, nil  }  --   1 PLD  2 DRK
mobList[zone][9  ].mobchildren = { nil, nil, nil, nil, nil, nil,   1,   2, nil, nil, nil, nil, nil, nil, nil  }  --   1 PLD  2 DRK
mobList[zone][11 ].mobchildren = {   1,   1,   1,   1,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  --   1 WAR  1 MNK  1 WHM  1 BLM  1 RDM  1 THF
mobList[zone][13 ].mobchildren = {   1,   1,   1,   1,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  --   1 WAR  1 MNK  1 WHM  1 BLM  1 RDM  1 THF
mobList[zone][14 ].mobchildren = { nil, nil, nil, nil,   1, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil  }  --   1 RDM  1 PLD
mobList[zone][15 ].mobchildren = { nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  --   1 MNK  1 WHM
mobList[zone][16 ].mobchildren = { nil, nil, nil, nil,   1, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil  }  --   1 RDM  1 PLD
mobList[zone][17 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil,   3, nil, nil  }  --   1 BRD  3 NIN
mobList[zone][18 ].mobchildren = {   3, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil  }  --   3 WAR  1 BRD
mobList[zone][19 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil,   3, nil, nil, nil  }  --   1 BRD  3 SAM
mobList[zone][20 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1,   2, nil, nil, nil  }  --   1 RNG  2 SAM
mobList[zone][21 ].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil,   1, nil, nil  }  --   1 THF  1 NIN
mobList[zone][22 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1,   2, nil, nil, nil  }  --   1 RNG  2 SAM
mobList[zone][23 ].mobchildren = { nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil,   1, nil, nil  }  --   2 THF  1 NIN
mobList[zone][24 ].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil,   1, nil, nil  }  --   1 THF  1 NIN
mobList[zone][25 ].mobchildren = { nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil,   1, nil, nil  }  --   2 THF  1 NIN
mobList[zone][26 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil  }  --   2 DRG
mobList[zone][27 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil  }  --   2 BST
mobList[zone][28 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2  }  --   2 SMN
mobList[zone][29 ].mobchildren = {   2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  --   2 WAR
mobList[zone][30 ].mobchildren = { nil,   2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  --   2 MNK
mobList[zone][31 ].mobchildren = { nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  --   2 WHM
mobList[zone][32 ].mobchildren = { nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  --   2 BLM
mobList[zone][33 ].mobchildren = { nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  --   2 RDM
mobList[zone][34 ].mobchildren = { nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  --   2 THF
mobList[zone][44 ].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil  }  --   1 BLM  1 RNG
mobList[zone][45 ].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil  }  --   1 BLM  1 RNG
mobList[zone][46 ].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil  }  --   1 BLM  1 RNG
mobList[zone][47 ].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil  }  --   1 BLM  1 RNG
mobList[zone][48 ].mobchildren = { nil, nil,   1, nil, nil, nil, nil, nil,   2,   1, nil, nil, nil, nil, nil  }  --   1 WHM  2 BST  1 BRD
mobList[zone][49 ].mobchildren = { nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil,   1  }  --   1 MNK  1 NIN  1 SMN
mobList[zone][50 ].mobchildren = { nil, nil,   1, nil, nil, nil, nil, nil,   2,   1, nil, nil, nil, nil, nil  }  --   1 WHM  2 BST  1 BRD
mobList[zone][51 ].mobchildren = { nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil,   1  }  --   1 MNK  1 NIN  1 SMN
mobList[zone][53 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1,   1,   1,   1  }  --   1 SAM  1 NIN  1 DRG  1 SMN
mobList[zone][54 ].mobchildren = { nil, nil, nil, nil, nil, nil,   1,   1,   1,   1,   1, nil, nil, nil, nil  }  --   1 PLD  1 DRK  1 BST  1 BRD  1 RNG
mobList[zone][55 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1,   1,   1,   1  }  --   1 SAM  1 NIN  1 DRG  1 SMN
mobList[zone][56 ].mobchildren = { nil, nil, nil, nil, nil, nil,   1,   1,   1,   1,   1, nil, nil, nil, nil  }  --   1 PLD  1 DRK  1 BST  1 BRD  1 RNG
mobList[zone][57 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1,   1, nil,   1, nil  }  --   1 RNG  1 SAM  1 DRG
mobList[zone][58 ].mobchildren = { nil, nil, nil, nil, nil,   1,   1, nil, nil, nil, nil, nil, nil, nil,   1  }  --   1 THF  1 PLD  1 SMN
mobList[zone][59 ].mobchildren = { nil, nil, nil,   1, nil, nil, nil,   1, nil, nil, nil, nil,   1, nil, nil  }  --   1 BLM  1 DRK  1 NIN
mobList[zone][61 ].mobchildren = {   1,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  --   1 WAR  1 MNK  1 WHM
mobList[zone][62 ].mobchildren = { nil, nil, nil,   1, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  --   1 BLM  2 THF
mobList[zone][63 ].mobchildren = { nil, nil, nil, nil,   3, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  --   3 RDM
mobList[zone][64 ].mobchildren = { nil, nil, nil,   1, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  --   1 BLM  2 THF
mobList[zone][65 ].mobchildren = {   1,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  --   1 WAR  1 MNK  1 WHM
mobList[zone][66 ].mobchildren = { nil, nil, nil,   1, nil, nil, nil,   3, nil, nil, nil, nil, nil, nil, nil  }  --   1 BLM  3 DRK
mobList[zone][67 ].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil,   3, nil, nil, nil  }  --   1 BLM  3 SAM
mobList[zone][68 ].mobchildren = { nil, nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  --   1 WHM  1 BLM
mobList[zone][69 ].mobchildren = { nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil  }  --   2 PLD
mobList[zone][70 ].mobchildren = { nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil  }  --   2 PLD
mobList[zone][71 ].mobchildren = { nil,   3, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  --   3 MNK
mobList[zone][72 ].mobchildren = { nil, nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  --   1 WHM  1 BLM
mobList[zone][74 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil  }  --   2 DRG
mobList[zone][75 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil  }  --   2 BST
mobList[zone][76 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   3  }  --   3 SMN
mobList[zone][78 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil  }  --   2 BST
mobList[zone][79 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil  }  --   2 DRK
mobList[zone][80 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil  }  --   2 RNG
mobList[zone][81 ].mobchildren = { nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil  }  --   2 PLD
mobList[zone][82 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil  }  --   2 BRD
mobList[zone][83 ].mobchildren = {   2, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  --   2 WAR  1 RDM
mobList[zone][84 ].mobchildren = { nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  --   2 BLM
mobList[zone][85 ].mobchildren = {   2, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  --   2 WAR  1 RDM
mobList[zone][86 ].mobchildren = { nil,   1, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  --   1 MNK  1 THF
mobList[zone][87 ].mobchildren = { nil,   1, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  --   1 MNK  1 THF
mobList[zone][88 ].mobchildren = { nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  --   2 WHM
mobList[zone][89 ].mobchildren = {   2, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil  }  --   2 WAR  1 BRD
mobList[zone][90 ].mobchildren = { nil,   2, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil  }  --   2 MNK  1 BRD
mobList[zone][91 ].mobchildren = {   2, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil  }  --   2 WAR  1 BRD
mobList[zone][92 ].mobchildren = { nil,   2, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil  }  --   2 MNK  1 BRD
mobList[zone][93 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil  }  --   2 RNG
mobList[zone][94 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   3, nil, nil, nil  }  --   3 SAM
mobList[zone][95 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil  }  --   2 RNG
mobList[zone][96 ].mobchildren = { nil, nil, nil, nil, nil,   3, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  --   3 THF
mobList[zone][97 ].mobchildren = {   1, nil, nil, nil,   1, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil  }  --   1 WAR  1 RDM  1 BRD
mobList[zone][98 ].mobchildren = { nil,   1,   1, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil  }  --   1 MNK  1 WHM  1 BST
mobList[zone][99 ].mobchildren = { nil,   1, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil  }  --   1 MNK  1 BRD
mobList[zone][100].mobchildren = {   1, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil  }  --   1 WAR  1 BRD
mobList[zone][101].mobchildren = {   1, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  --   1 WAR  1 WHM
mobList[zone][102].mobchildren = { nil, nil,   1, nil,   1, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil  }  --   1 WHM  1 RDM  1 BRD
mobList[zone][103].mobchildren = { nil, nil,   1, nil,   1, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil  }  --   1 WHM  1 RDM  1 BRD
mobList[zone][104].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   2, nil,   1, nil, nil, nil, nil, nil  }  --   2 DRK  1 BRD
mobList[zone][105].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   2, nil,   1, nil, nil, nil, nil, nil  }  --   2 DRK  1 BRD
mobList[zone][106].mobchildren = { nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil  }  --   2 PLD
mobList[zone][107].mobchildren = { nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil  }  --   1 RDM  2 NIN
mobList[zone][108].mobchildren = { nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil  }  --   1 RDM  2 NIN
mobList[zone][109].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   3, nil  }  --   3 DRG
mobList[zone][110].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2  }  --   2 SMN
mobList[zone][111].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil  }  --   2 BST
mobList[zone][113].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil  }  --   2 BST
mobList[zone][114].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   3  }  --   3 SMN
mobList[zone][115].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil,   1, nil  }  --   1 RNG  1 DRG
mobList[zone][116].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil,   1, nil  }  --   1 RNG  1 DRG
mobList[zone][117].mobchildren = { nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil,   1  }  --   1 PLD  1 SMN
mobList[zone][118].mobchildren = { nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil,   1  }  --   1 PLD  1 SMN
mobList[zone][119].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   3, nil, nil, nil, nil  }  --   3 RNG
mobList[zone][120].mobchildren = { nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil,   1  }  --   1 PLD  1 SMN
mobList[zone][121].mobchildren = { nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  --   1 RDM
mobList[zone][122].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil  }  --   2 NIN
mobList[zone][123].mobchildren = { nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  --   1 RDM
mobList[zone][124].mobchildren = { nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil  }  --   1 RDM  2 DRG
mobList[zone][125].mobchildren = { nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil  }  --   1 RDM  2 SAM
mobList[zone][126].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil  }  --   2 DRK
mobList[zone][144].mobchildren = { nil, nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  --   1 WHM  1 BLM
mobList[zone][145].mobchildren = { nil, nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  --   1 WHM  1 BLM
mobList[zone][146].mobchildren = { nil, nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  --   1 WHM  1 BLM
mobList[zone][147].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil  }  --   2 DRG
mobList[zone][148].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil  }  --   2 DRK
mobList[zone][149].mobchildren = { nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil  }  --   2 PLD

------------------------------------------
--            NM Child Spawn            --
------------------------------------------
-- mobList[zone][MobIndex].NMchildren = {MobIndex(NM1), MobIndex(NM2), MobIndex(NM3)}
-- boolean value = forceLink true/false

mobList[zone][35 ].specificChildren = { true, 36, 37, 38 }
mobList[zone][39 ].specificChildren = { true, 40, 41, 42 }
mobList[zone][127].specificChildren = { true, 244 } -- Marquis Decarabia
mobList[zone][128].specificChildren = { true, 245 } -- Count Zaebos
mobList[zone][129].specificChildren = { true, 246 } -- Duke Berith
mobList[zone][130].specificChildren = { true, 247 } -- Prince Seere
mobList[zone][131].specificChildren = { true, 248 } -- Duke Gomory
mobList[zone][132].specificChildren = { true, 249 } -- Marquis Andras
mobList[zone][133].specificChildren = { true, 250 } -- Marquis Gamygyn
mobList[zone][134].specificChildren = { true, 251 } -- Duke Scox
mobList[zone][135].specificChildren = { true, 252 } -- Marquis Orias
mobList[zone][136].specificChildren = { true, 253 } -- Count Raum
mobList[zone][137].specificChildren = { true, 254 } -- Marquis Sabnak
mobList[zone][138].specificChildren = { true, 255 } -- Marquis Nebiros
mobList[zone][139].specificChildren = { true, 256 } -- King Zagan
mobList[zone][140].specificChildren = { true, 257 } -- Count Vine
mobList[zone][141].specificChildren = { true, 258 } -- Marquis Cimerie
mobList[zone][151].specificChildren = { true, 180, 181, 182, 183 } -- Satellite Hammer
mobList[zone][152].specificChildren = { true, 184, 185, 186, 187 } -- Satellite Dagger
mobList[zone][153].specificChildren = { true, 188, 189,	190, 191 } -- Satellite Shield
mobList[zone][154].specificChildren = { true, 192, 193,	194, 195 } -- Satellite Claymore
mobList[zone][155].specificChildren = { true, 196, 197,	198, 199 } -- Satellite Gun
mobList[zone][156].specificChildren = { true, 200, 201,	202, 203 } -- Satellite Longbow
mobList[zone][157].specificChildren = { true, 204, 205,	206, 207 } -- Satellite Tachi
mobList[zone][158].specificChildren = { true, 208, 209,	210, 211 } -- Satellite Tabar
mobList[zone][159].specificChildren = { true, 212, 213,	214, 215 } -- Satellite Staff
mobList[zone][160].specificChildren = { true, 216, 217,	218, 219 } -- Satellite Spear
mobList[zone][161].specificChildren = { true, 220, 221,	222, 223 } -- Satellite Kunai
mobList[zone][162].specificChildren = { true, 224, 225,	226, 227 } -- Satellite Knuckles
mobList[zone][163].specificChildren = { true, 228, 229,	230, 231 } -- Satellite Great Axe
mobList[zone][164].specificChildren = { true, 232, 233,	234, 235 } -- Satellite Horn
mobList[zone][165].specificChildren = { true, 236, 237,	238, 239 } -- Satellite Longsword
mobList[zone][166].specificChildren = { true, 240, 241,	242, 243 } -- Satellite Scythe

------------------------------------------
--          Mob Position Info           --
-- Note: Must be setup for parent mobs, --
-- but is optional for children.        --
------------------------------------------
-- mobList[zone][MobIndex].pos = {xpos, ypos, zpos, rot}

mobList[zone][1  ].pos = {  424.1293, 0.4751,   -178.5404, 118 } -- 001-D
mobList[zone][2  ].pos = {  411.1541,-0.2269,   -172.5790, 47  } -- 002-D
mobList[zone][3  ].pos = {  406.5320, 0.2936,   -187.7396, 232 } -- 003-D
mobList[zone][4  ].pos = {  419.7373, 0.5091,   -190.8261, 163 } -- 004-D
mobList[zone][5  ].pos = {  414.4022,-0.3546,   -182.0117, 0   } -- 005-G
mobList[zone][6  ].pos = {  349.2125, 8.2605,   -192.8115, 160 } -- 006-D
mobList[zone][7  ].pos = {  346.6184, 8.4416,   -200.3669, 116 } -- 007-D
mobList[zone][8  ].pos = {  360.3178, 7.9544,   -204.3077, 33  } -- 008-D
mobList[zone][9  ].pos = {  361.7702, 8.0233,   -195.5119, 247 } -- 009-D
mobList[zone][10 ].pos = {  354.4850, 8.0746,   -198.8310, 201 } -- 010-O(30)
mobList[zone][11 ].pos = {  366.3824, 0.5812,   -253.2608, 222 } -- 011-D
mobList[zone][12 ].pos = {  360.5640, 0.2452,   -248.9267, 219 } -- 012-Q
mobList[zone][13 ].pos = {  352.6051, 0.0714,   -245.5541, 211 } -- 013-D
mobList[zone][14 ].pos = {  343.9028, 0.2481,   -289.3212, 210 } -- 014-D
mobList[zone][15 ].pos = {  338.4755, 0.4983,   -288.4618, 195 } -- 015-D
mobList[zone][16 ].pos = {  331.9529, 0.2026,   -287.8621, 187 } -- 016-D
mobList[zone][17 ].pos = {  304.9144, 6.1379,   -249.2820, 58  } -- 017-D
mobList[zone][18 ].pos = {  311.8788, 7.5565,   -237.4718, 251 } -- 018-D
mobList[zone][19 ].pos = {  310.6456, 6.1862,   -218.2143, 228 } -- 019-D
mobList[zone][20 ].pos = {  242.8440, -8.3035,  -236.5309, 19  } -- 020-D
mobList[zone][21 ].pos = {  247.3115, -10.3789, -225.4024, 10  } -- 021-D
mobList[zone][22 ].pos = {  251.7796, -11.8153, -214.2299, 15  } -- 022-D
mobList[zone][23 ].pos = {  264.3314, -6.3296,  -198.5750, 31  } -- 023-D
mobList[zone][24 ].pos = {  270.2761, -5.7290,  -187.2165, 31  } -- 024-D
mobList[zone][25 ].pos = {  276.8286, -5.6503,  -177.1220, 21  } -- 025-D
mobList[zone][26 ].pos = {  381.9445, -4.0833,  -95.9521, 32   } -- 026-D
mobList[zone][27 ].pos = {  378.4275, -5.7032,  -92.4321, 32   } -- 027-D
mobList[zone][28 ].pos = {  374.8895, -6.5000,  -88.8913, 32   } -- 028-D
mobList[zone][29 ].pos = {  297.7394, -5.2740,  -102.6164, 62  } -- 029-D
mobList[zone][30 ].pos = {  298.0390, -7.7612,  -97.1668, 191  } -- 030-D
mobList[zone][31 ].pos = {  291.0302, -7.3199,  -97.3795, 62   } -- 031-D
mobList[zone][32 ].pos = {  290.7523, -8.2855,  -92.5171, 189  } -- 032-D
mobList[zone][33 ].pos = {  283.7681, -7.4053,  -92.8302, 64   } -- 033-D
mobList[zone][34 ].pos = {  283.6383, -7.8111,  -87.8017, 190  } -- 034-D
mobList[zone][35 ].pos = {  232.0036, -19.0781, -165.1964, 150 } -- 035-D
mobList[zone][36 ].pos = {  229.4250, -20.7388, -168.6801, 149 } -- 036-D
mobList[zone][37 ].pos = {  232.7480, -20.7388, -170.5852, 159 } -- 037-D
mobList[zone][38 ].pos = {  234.2837, -20.6722, -166.8051, 155 } -- 038-D
mobList[zone][39 ].pos = {  234.5874, -19.1802, -161.8466, 147 } -- 039-D
mobList[zone][40 ].pos = {  235.5074, -20.7388, -157.9036, 150 } -- 040-D
mobList[zone][41 ].pos = {  238.2971, -20.7388, -159.5938, 141 } -- 041-D
mobList[zone][42 ].pos = {  236.8613, -20.7052, -162.9283, 155 } -- 042-D
mobList[zone][43 ].pos = {  235.3885, -20.6618, -164.8875, 149 } -- 043-Y(30)
mobList[zone][44 ].pos = {  212.2299, -17.2562, -225.9583, 253 } -- 044-D
mobList[zone][45 ].pos = {  208.1801, -16.7650, -228.9911, 62  } -- 045-D
mobList[zone][46 ].pos = {  204.6303, -18.8527, -225.5164, 135 } -- 046-D
mobList[zone][47 ].pos = {  208.4378, -18.8582, -222.6815, 194 } -- 047-D
mobList[zone][48 ].pos = {  174.3926, -18.8233, -139.4571, 29  } -- 048-D
mobList[zone][49 ].pos = {  163.9518, -20.3809, -139.4437, 94  } -- 049-D
mobList[zone][50 ].pos = {  164.5739, -16.9460, -129.4864, 160 } -- 050-D
mobList[zone][51 ].pos = {  173.8166, -17.7018, -129.4484, 223 } -- 051-D
mobList[zone][52 ].pos = {  169.2042, -18.2180, -134.7736, 0   } -- 052-Y(HP)
mobList[zone][53 ].pos = {  149.4144, -18.4039, -99.3362, 22   } -- 053-D
mobList[zone][54 ].pos = {  240.6901, -15.3077, -138.7996, 1   } -- 054-D
mobList[zone][55 ].pos = {  237.2858, -8.0000, -82.7372, 18    } -- 055-D
mobList[zone][56 ].pos = {  160.4315, -16.0000, -79.9672, 30   } -- 056-D
mobList[zone][57 ].pos = {  197.4896, -7.4749, 26.6946, 59     } -- 057-D
mobList[zone][58 ].pos = {  202.4719, -7.4778, 26.7363, 75     } -- 058-D
mobList[zone][59 ].pos = {  207.2917, -7.8752, 25.2688, 83     } -- 059-D
mobList[zone][60 ].pos = {  204.1456, -7.9310, 34.5961, 75     } -- 060-O(30)
mobList[zone][61 ].pos = {  278.9015, -7.7302, 49.4191, 83     } -- 061-D
mobList[zone][62 ].pos = {  275.8966, -7.2308, 55.7405, 126    } -- 062-D
mobList[zone][63 ].pos = {  280.3802, -7.0575, 61.1266, 195    } -- 063-D
mobList[zone][64 ].pos = {  286.5690, -7.3786, 57.6816, 236    } -- 064-D
mobList[zone][65 ].pos = {  286.6652, -7.7961, 50.4755, 18     } -- 065-D
mobList[zone][66 ].pos = {  367.8774, -7.8073, 120.7682, 5     } -- 066-D
mobList[zone][67 ].pos = {  367.1385, -8.1712, 112.7752, 8     } -- 067-D
mobList[zone][68 ].pos = {  355.6019, -7.2450, -58.0073, 61    } -- 068-D
mobList[zone][69 ].pos = {  368.1302, -8.8291, -58.4434, 62    } -- 069-D
mobList[zone][70 ].pos = {  380.6304, -3.1784, -58.9766, 64    } -- 070-D
mobList[zone][71 ].pos = {  392.9741, -0.7745, -61.0018, 64    } -- 071-D
mobList[zone][72 ].pos = {  405.4319, 0.4546, -62.2839, 68     } -- 072-D
mobList[zone][73 ].pos = {  384.3539, -3.1706, -44.0433, 77    } -- 073-Y(MP)
mobList[zone][74 ].pos = {  398.0475, -5.6198, -15.0955, 63    } -- 074-D
mobList[zone][75 ].pos = {  390.0092, -7.7016, 0.9627, 157     } -- 075-D
mobList[zone][76 ].pos = {  404.8032, -7.8646, 1.9129, 223     } -- 076-D
mobList[zone][77 ].pos = {  397.8393, -7.8562, -5.2043, 63     } -- 077-O(MP)
mobList[zone][78 ].pos = {  433.9671, -1.6716, 52.7199, 95     } -- 078-D
mobList[zone][79 ].pos = {  433.7292, -5.0768, 62.3223, 156    } -- 079-D
mobList[zone][80 ].pos = {  443.8177, -5.6656, 62.6060, 222    } -- 080-D
mobList[zone][81 ].pos = {  444.6903, -2.6507, 53.6754, 30     } -- 081-D
mobList[zone][82 ].pos = {  438.9351, -3.8096, 57.6335, 61     } -- 082-D
mobList[zone][83 ].pos = {  488.6499, -0.3915, 37.6619, 175    } -- 083-D
mobList[zone][84 ].pos = {  482.3507, -0.1661, 32.7014, 162    } -- 084-D
mobList[zone][85 ].pos = {  489.0281, -0.2256, 29.6058, 156    } -- 085-D
mobList[zone][86 ].pos = {  501.9442, -7.8484, 198.5639, 68    } -- 086-D
mobList[zone][87 ].pos = {  504.2140, -8.1312, 207.0567, 70    } -- 087-D
mobList[zone][88 ].pos = {  534.2434, -7.8169, 221.5235, 119   } -- 088-D
mobList[zone][89 ].pos = {  60.5113, -24.0736, -267.0519, 182  } -- 089-D
mobList[zone][90 ].pos = {  60.1930, -23.8032, -274.8913, 71   } -- 090-D
mobList[zone][91 ].pos = {  91.3642, -24.0450, -251.7222, 158  } -- 091-D
mobList[zone][92 ].pos = {  97.5249, -23.9710, -264.3413, 48   } -- 092-D
mobList[zone][93 ].pos = {  6.8732, -23.8575, -362.9837, 195   } -- 093-D
mobList[zone][94 ].pos = {  16.8527, -23.1585, -363.1671, 196  } -- 094-D
mobList[zone][95 ].pos = {  26.8581, -23.4904, -362.9120, 191  } -- 095-D
mobList[zone][96 ].pos = {  36.8740, -24.0000, -362.7977, 191  } -- 096-D
mobList[zone][97 ].pos = { -28.5253, -15.6275, 42.0637, 0      } -- 097-D
mobList[zone][98 ].pos = { -27.8314, -15.8221, 33.8259, 0      } -- 098-D
mobList[zone][99 ].pos = { 49.7393, -15.7784, 15.4163, 36      } -- 099-D
mobList[zone][100].pos = { 43.6486, -15.6278, 11.4668, 48      } -- 100-D
mobList[zone][101].pos = { 36.3999, -15.7803, 8.4163, 43       } -- 101-D
mobList[zone][102].pos = { 65.5793, -17.6682, -47.7914, 14     } -- 102-D
mobList[zone][103].pos = { 67.9447, -18.0770, -40.1728, 255    } -- 103-D
mobList[zone][104].pos = { 64.0896, -24.0238, -74.4542, 58     } -- 104-D
mobList[zone][105].pos = { 80.9163, -23.7844, -74.2179, 65     } -- 105-D
mobList[zone][106].pos = {  23.2533, -33.0965, 139.2529, 67    } -- 106-D
mobList[zone][107].pos = {  23.0874, -34.1983, 144.2162, 0     } -- 107-D
mobList[zone][108].pos = {  23.0806, -34.8438, 149.1463, 125   } -- 108-D
mobList[zone][109].pos = {  22.5083, -35.0776, 154.2627, 181   } -- 109-D
mobList[zone][110].pos = {-117.4516, -36.0000, 80.3362, 73     } -- 110-D
mobList[zone][111].pos = {-111.8803, -36.2595, 80.4930, 63     } -- 111-D
mobList[zone][112].pos = {-107.7923, -39.8030, 35.8958, 159    } -- 112-Q(HP)
mobList[zone][113].pos = {-136.6303, -28.1860, 85.6807, 61     } -- 113-D
mobList[zone][114].pos = {-138.6653, -20.2562, 115.8844, 54    } -- 114-D
mobList[zone][115].pos = { 44.6229, -35.7960, 110.5585, 191    } -- 115-D
mobList[zone][116].pos = { 38.1159, -35.7175, 110.3267, 199    } -- 116-D
mobList[zone][117].pos = { 219.4501, -23.0169, 133.2112, 63    } -- 117-D
mobList[zone][118].pos = { 215.0627, -24.7103, 137.4886, 65    } -- 118-D
mobList[zone][119].pos = { 219.4539, -25.7846, 142.8087, 62    } -- 119-D
mobList[zone][120].pos = { 223.0426, -24.8310, 137.9934, 63    } -- 120-D
mobList[zone][121].pos = { 173.1911, -33.3553, 68.7402, 131    } -- 121-D
mobList[zone][122].pos = { 190.3257, -28.9476, 88.3894, 187    } -- 122-D
mobList[zone][123].pos = { 240.7466, -27.3345, 94.7047, 190    } -- 123-D
mobList[zone][124].pos = { 246.9428, -27.4052, 95.9730, 190    } -- 124-D
mobList[zone][125].pos = { 300.8132, -27.8000, 220.3610, 63    } -- 125-D
mobList[zone][126].pos = { 298.7344, -28.0975, 229.8743, 63    } -- 126-D
mobList[zone][127].pos = { 150.5660, -21.0480, -36.7252, 94    } -- 127-D
mobList[zone][128].pos = { 155.2857, -21.0238, -40.4494, 92    } -- 128-D
mobList[zone][129].pos = { 159.5335, -21.0480, -44.6545, 94    } -- 129-D
mobList[zone][130].pos = { 119.6976, -28.7700, -112.1791, 127  } -- 130-D
mobList[zone][131].pos = { 119.6369, -28.7261, -118.1067, 129  } -- 131-D
mobList[zone][132].pos = { 119.5703, -28.7700, -124.0673, 128  } -- 132-D
mobList[zone][133].pos = {  66.0471, -28.5111, -200.4550, 97   } -- 133-D
mobList[zone][134].pos = {  61.7481, -28.4765, -196.2649, 95   } -- 134-D
mobList[zone][135].pos = {  57.0693, -28.5111, -192.5350, 95   } -- 135-D
mobList[zone][136].pos = {  39.2806, -28.7143, -139.9675, 125  } -- 136-D
mobList[zone][137].pos = {  39.5865, -28.6676, -134.0237, 127  } -- 137-D
mobList[zone][138].pos = {  39.5281, -28.7143, -128.0194, 126  } -- 138-D
mobList[zone][139].pos = {  -7.1555, -28.5546, -106.6829, 144  } -- 139-D
mobList[zone][140].pos = {  -4.9817, -28.4989, -101.1111, 139  } -- 140-D
mobList[zone][141].pos = {  -2.8697, -28.5546, -95.5164, 146   } -- 141-D
mobList[zone][142].pos = { -45.5989, -24.2095, -125.2383, 230  } -- 142-Q(HP)
mobList[zone][143].pos = { -86.0996, -24.2289, -85.1929, 232   } -- 143-G(30)
mobList[zone][144].pos = {-129.0694, -23.7477, -43.8721, 6     } -- 144-D
mobList[zone][145].pos = {-128.6296, -23.2130, -33.8281, 9     } -- 145-D
mobList[zone][146].pos = {-127.8140, -22.4947, -23.8494, 6     } -- 146-D
mobList[zone][147].pos = {-127.0488, -18.8946, -13.8742, 6     } -- 147-D
mobList[zone][148].pos = {-125.7572, -15.9298, -4.0155, 9      } -- 148-D
mobList[zone][149].pos = {-124.7990, -16.0928, 5.8331, 27      } -- 149-D
mobList[zone][150].pos = {-150.0562, -16.1019, -6.8322, 23     } -- 150-G(30)
-- Animated Weapons, Dragons
mobList[zone][178].pos = { -365.6851, -36.0043, 15.7061, 253   } -- ying
mobList[zone][177].pos = { -366.2450, -36.3298, 24.8477, 255   } -- yang
mobList[zone][151].pos = { 338.2422, 0.0671, -377.4373, 192    } -- Animated hammer
mobList[zone][152].pos = { 146.8420, -25.2636, -226.5739, 3    } -- Animated dagger
mobList[zone][153].pos = { 90.9604, -24.0000, -375.0468, 218   } -- Animated shield
mobList[zone][154].pos = { -22.1978, -24.5956, -493.4288, 199  } -- Animated claymore
mobList[zone][155].pos = {-255.5342, -17.6566, -161.5427, 192  } -- Animated gun
mobList[zone][156].pos = {-296.0583, -25.8233, 161.7301, 68    } -- Animated longbow
mobList[zone][157].pos = { -100.4566, -15.8000, 138.8280, 128  } -- Animated tachi
mobList[zone][158].pos = { -122.0494, -36.0412, 124.8039, 58   } -- Animated tabar
mobList[zone][159].pos = { 49.1101, -36.2815, 61.7415, 183     } -- Animated staff
mobList[zone][160].pos = { 152.0960, -35.9728, 19.3087, 224    } -- Animated spear
mobList[zone][161].pos = { 241.9540, -28.4264, 63.3540, 199    } -- Animated kunai
mobList[zone][162].pos = { 342.1594, -27.8198, 378.1761, 68    } -- Animated knuckles
mobList[zone][163].pos = { 320.5472, -8.3209, 168.3653, 72     } -- Animated great axe
mobList[zone][164].pos = { 386.6498, -9.5122, 25.9243, 21      } -- Animated horn
mobList[zone][165].pos = { 582.5316, -8.0575, 296.7370, 73     } -- Animated longsword
mobList[zone][166].pos = { 577.9836, 0.1949, -18.2714, 195     } -- Animated scythe
mobList[zone][167].pos = {-213.8854, -6.7935, 42.7936, 1       } -- Vanguard Dragon
mobList[zone][168].pos = {-237.1062, -11.4733, 66.6790, 228    } -- Vanguard Dragon
mobList[zone][169].pos = {-247.0509, -11.9911, -11.5988, 253   } -- Vanguard Dragon
mobList[zone][170].pos = {-235.2860, -11.7157, -87.2030, 0     } -- Vanguard Dragon
mobList[zone][171].pos = {-276.5036, -20.0000, -81.0512, 255   } -- Vanguard Dragon
mobList[zone][172].pos = {-268.2993, -18.4545, 33.5037, 45     } -- Vanguard Dragon
mobList[zone][173].pos = {-284.7049, -20.2053, 121.2283, 59    } -- Vanguard Dragon
mobList[zone][174].pos = {-317.0527, -27.8170, 72.3022, 21     } -- Vanguard Dragon
mobList[zone][175].pos = {-297.9739, -23.4600, -2.6931, 226    } -- Vanguard Dragon
mobList[zone][176].pos = {-308.7357, -26.5187, -37.8035, 226   } -- Vanguard Dragon


----------------------------------------------------------------------------------------------------
--                                    Setup of Mob Functions                                      --
----------------------------------------------------------------------------------------------------
------------------------------------------
--             Patrol Paths             --
------------------------------------------
-- mobList[zone][MobIndex].patrolPath = {xpos1,ypos1,zpos1, xpos2,ypos2,zpos2,  xpos3,ypos3,zpos3}

------------------------------------------
--          Statue Eye Colors           --
------------------------------------------
-- mobList[zone][MobIndex].eyes = dynamisEyesEra.BLUE -- Flags for blue eyes. (HP)
-- mobList[zone][MobIndex].eyes = dynamisEyesEra.GREEN -- Flags for green eyes. (MP)
-- mobList[zone][MobIndex].eyes = dynamisEyesEra.RED -- Flags for red eyes. (TE)

mobList[zone][10 ].eyes = dynamisEyesEra.RED
mobList[zone][43 ].eyes = dynamisEyesEra.RED
mobList[zone][52 ].eyes = dynamisEyesEra.BLUE
mobList[zone][60 ].eyes = dynamisEyesEra.RED
mobList[zone][73 ].eyes = dynamisEyesEra.GREEN
mobList[zone][77 ].eyes = dynamisEyesEra.GREEN
mobList[zone][112].eyes = dynamisEyesEra.BLUE
mobList[zone][142].eyes = dynamisEyesEra.BLUE
mobList[zone][143].eyes = dynamisEyesEra.RED
mobList[zone][150].eyes = dynamisEyesEra.RED

------------------------------------------
--        Time Extension Values         --
------------------------------------------
-- mobList[zone][MobIndex].timeExtension = 15

mobList[zone][10 ].timeExtension = 30 -- Tombstone Prototype
mobList[zone][43 ].timeExtension = 30 -- Icon Prototype
mobList[zone][60 ].timeExtension = 30 -- Tombstone Prototype
mobList[zone][143].timeExtension = 30 -- Statue Prototype
mobList[zone][150].timeExtension = 30 -- Statue Prototype