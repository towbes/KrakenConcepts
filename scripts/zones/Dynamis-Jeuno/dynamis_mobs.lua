----------------------------------------------------------------------------------------------------
--                                      Dynamis-Jeuno                                          --
--              Primary Source of Information: https://enedin.be/dyna/html/zone/jeu.htm           --
--           Secondary Source of Information: http://www.dynamisbums.com/strategy/jeu.html        --
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
local zone = xi.zone.DYNAMIS_JEUNO
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

mobList[zone][1  ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 001-G/R
mobList[zone][2  ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 002-G/R(30)
mobList[zone][3  ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 003-G/R
mobList[zone][4  ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 004-G/R(30)
mobList[zone][5  ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 005-G/R(HP)
mobList[zone][6  ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 006-G/R
mobList[zone][7  ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 007-G/R
mobList[zone][8  ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 008-G/R
mobList[zone][9  ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 009-G/R(MP)
mobList[zone][10 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 010-G/R
mobList[zone][11 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 011-G/R(HP)
mobList[zone][12 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 012-G/R(MP)
mobList[zone][13 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 013-G/R
mobList[zone][14 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 014-G/R
mobList[zone][15 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 015-G/R
mobList[zone][16 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 016-G/R(HP)
mobList[zone][17 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 017-G/R(MP)
mobList[zone][18 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 018-G/R
mobList[zone][19 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 019-G/R
mobList[zone][20 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 020-G/R
mobList[zone][21 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 021-G/R
mobList[zone][22 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 022-G/R
mobList[zone][23 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 023-G/R(HP)
mobList[zone][24 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 024-G/R(MP)
mobList[zone][25 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 025-G/R(MP)
mobList[zone][26 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 026-G/R(HP)
mobList[zone][27 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 027-G/R
mobList[zone][28 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 028-G/R
mobList[zone][29 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 029-G/R(30)
mobList[zone][30 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 030-G/R(MP)
mobList[zone][31 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 031-G/R(HP)
mobList[zone][32 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 032-G/R
mobList[zone][33 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 033-G/R
mobList[zone][34 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 034-G/R
mobList[zone][35 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 035-G/R
mobList[zone][36 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 036-G/R
mobList[zone][37 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 037-G/R
mobList[zone][38 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 038-G/R
mobList[zone][39 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 039-G/R(MP)
mobList[zone][40 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 040-G/R(HP)
mobList[zone][41 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 041-G/R
mobList[zone][42 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 042-G/R
mobList[zone][43 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 043-G/R
mobList[zone][44 ].info = {"Statue", "Goblin Replica", nil, nil, "44_killed" } -- 044-G/S(MP)
mobList[zone][45 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 045-G/R(30)
mobList[zone][46 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 046-G/R
mobList[zone][47 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 047-G/R
mobList[zone][48 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 048-G/R
mobList[zone][49 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 049-G/R
mobList[zone][50 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 050-G/R
mobList[zone][51 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 051-G/R
mobList[zone][52 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 052-G/R
mobList[zone][53 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 053-G/R
mobList[zone][54 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 054-G/R
mobList[zone][55 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 055-G/R
mobList[zone][56 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 056-G/R(MP)
mobList[zone][57 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 057-G/R(HP)
mobList[zone][58 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 058-G/R
mobList[zone][59 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 059-G/R
mobList[zone][60 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 060-G/R
mobList[zone][61 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 061-G/R
mobList[zone][62 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 062-G/R(MP)
mobList[zone][63 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 063-G/R(HP)
mobList[zone][64 ].info = {"Statue", "Goblin Replica", nil, nil, "64_killed" } -- 064-G/S(MP)
mobList[zone][65 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 065-G/R(HP)
mobList[zone][66 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 066-G/R
mobList[zone][67 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 067-G/R(MP)
mobList[zone][68 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 068-G/R(HP)
mobList[zone][69 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 069-G/R
mobList[zone][70 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 070-G/R
mobList[zone][71 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 071-G/R
mobList[zone][72 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 072-G/R
mobList[zone][73 ].info = {"Statue", "Goblin Replica", nil, nil, "73_killed" } -- 073-G/R
mobList[zone][74 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 074-G/R
mobList[zone][75 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 075-G/R
mobList[zone][76 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 076-G/R(MP)
mobList[zone][77 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 077-G/R(HP)
mobList[zone][78 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 078-G/R(MP)
mobList[zone][79 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 079-G/R(HP)
mobList[zone][80 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 080-G/R(HP)
mobList[zone][81 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 081-G/R(MP)
mobList[zone][82 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 082-G/R(MP)
mobList[zone][83 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 083-G/R(HP)
mobList[zone][84 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 084-G/R(HP)
mobList[zone][85 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 085-G/R(MP)
mobList[zone][86 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 086-G/R
mobList[zone][87 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 087-G/R
mobList[zone][88 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 088-G/R
mobList[zone][89 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 089-G/R
mobList[zone][90 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 090-G/R
mobList[zone][91 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 091-G/R
mobList[zone][92 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 092-G/R
mobList[zone][93 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 093-G/R(HP)
mobList[zone][94 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 094-G/R(MP)
mobList[zone][95 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 095-G/R(MP)
mobList[zone][96 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 096-G/R
mobList[zone][97 ].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 097-G/R
mobList[zone][98 ].info = {"Statue", "Goblin Replica", nil, nil, "98_killed"}  -- 098-G/R
mobList[zone][99 ].info = {"Statue", "Goblin Replica", nil, nil, "99_killed" } -- 099-G/R
mobList[zone][100].info = {"Statue", "Goblin Replica", nil, nil, "100_killed"} -- 100-G/R
mobList[zone][101].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 101-G/R(MP)
mobList[zone][102].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 102-G/R(HP)
mobList[zone][103].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 103-G/R
mobList[zone][104].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 104-G/R
mobList[zone][105].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 105-G/R
mobList[zone][106].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 106-G/R
mobList[zone][107].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 107-G/R
mobList[zone][108].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 108-G/R
mobList[zone][109].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 109-G/R
mobList[zone][110].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 110-G/R
mobList[zone][111].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 111-G/R
mobList[zone][112].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 112-G/R
mobList[zone][114].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 114-G/R
mobList[zone][115].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 115-G/R
mobList[zone][116].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 116-G/R
mobList[zone][117].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 117-G/R
mobList[zone][118].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 118-G/R(MP)
mobList[zone][119].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 119-G/R(HP)
mobList[zone][120].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 120-G/R
mobList[zone][121].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 121-G/R
mobList[zone][122].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 122-G/R(MP)
mobList[zone][123].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 123-G/R(HP)
mobList[zone][124].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 124-G/R
mobList[zone][125].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 125-G/R
mobList[zone][126].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 126-G/R(HP)
mobList[zone][127].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 127-G/R(MP)
mobList[zone][128].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 128-G/R(HP)
mobList[zone][129].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 129-G/R(MP)
mobList[zone][130].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 130-G/R
mobList[zone][131].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 131-G/R
mobList[zone][132].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 132-G/R
mobList[zone][133].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 133-G/R
mobList[zone][134].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 134-G/R
mobList[zone][135].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 135-G/R
mobList[zone][136].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 136-G/R
mobList[zone][137].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 137-G/R
mobList[zone][138].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 138-G/R
mobList[zone][139].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 139-G/R
mobList[zone][140].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 140-G/R
mobList[zone][141].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 141-G/R
mobList[zone][142].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 142-G/R
mobList[zone][143].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 143-G/R
mobList[zone][144].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 144-G/R
mobList[zone][145].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 145-G/R
mobList[zone][146].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 146-G/R
mobList[zone][147].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 147-G/R
mobList[zone][148].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 148-G/R
mobList[zone][149].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 149-G/R
mobList[zone][150].info = {"Statue", "Goblin Replica", nil, nil, nil} -- 150-G/R(MP)

-- NM's and Megaboss
mobList[zone][113].info = {"NM", "Goblin Replica",               nil, nil,  "MegaBoss_Killed"   } -- 113-Replica NM (Goblin Golem)(30)
mobList[zone][151].info = {"NM", "Gabblox Magpietongue",    "Goblin", "RDM",  nil  } -- Gabblox Magpietongue
mobList[zone][152].info = {"NM", "Tufflix Loglimbs",        "Goblin", "PLD",  nil  } -- Tufflix Loglimbs
mobList[zone][153].info = {"NM", "Cloktix Longnail",        "Goblin", "DRK",  nil  } -- Cloktix Longnail
mobList[zone][154].info = {"NM", "Smeltix Thickhide",       "Goblin", "WAR",  nil  } -- Smeltix Thickhide
mobList[zone][155].info = {"NM", "Jabkix Pigeonpecs",       "Goblin", "MNK",  nil  } -- Jabkix Pigeonpecs
mobList[zone][156].info = {"NM", "Wasabix Callusdigit",     "Goblin", "SAM",  nil  } -- Wasabix Callusdigit
mobList[zone][157].info = {"NM", "Hermitrix Toothrot",      "Goblin", "BLM",  nil  } -- Hermitrix Toothrot
mobList[zone][158].info = {"NM", "Wyrmwix Snakespecs",      "Goblin", "DRG",  nil  } -- Wyrmwix Snakespecs
mobList[zone][159].info = {"NM", "Morgmox Moldnoggin",      "Goblin", "SMN",  nil  } -- Morgmox Moldnoggin
mobList[zone][160].info = {"NM", "Sparkspox Sweatbrow",     "Goblin", "WAR",  nil  } -- Sparkspox Sweatbrow
mobList[zone][161].info = {"NM", "Elixmix Hooknose",        "Goblin", "RDM",  nil  } -- Elixmix Hooknose
mobList[zone][162].info = {"NM", "Bandrix Rockjaw",         "Goblin", "THF",  nil  } -- Bandrix Rockjaw
mobList[zone][163].info = {"NM", "Buffrix Eargone",         "Goblin", "PLD",  nil  } -- Buffrix Eargone
mobList[zone][164].info = {"NM", "Humnox Drumbelly",        "Goblin", "BRD",  nil  } -- Humnox Drumbelly
mobList[zone][165].info = {"NM", "Ticktox Beadyeyes",       "Goblin", "DRK",  nil  } -- Ticktox Beadyeyes
mobList[zone][166].info = {"NM", "Lurklox Dhalmelneck",     "Goblin", "RNG",  nil  } -- Lurklox Dhalmelneck
mobList[zone][167].info = {"NM", "Trailblix Goatmug",       "Goblin", "BST",  nil  } -- Trailblix Goatmug
mobList[zone][168].info = {"NM", "Kikklix Longlegs",        "Goblin", "MNK",  nil  } -- Kikklix Longlegs
mobList[zone][169].info = {"NM", "Karashix Swollenskull",   "Goblin", "SAM",  nil  } -- Karashix Swollenskull
mobList[zone][170].info = {"NM", "Mortilox Wartpaws",       "Goblin", "SMN",  nil  } -- Mortilox Wartpaws
mobList[zone][171].info = {"NM", "Rutrix Hamgams",          "Goblin", "BST",  nil  } -- Rutrix Hamgams
mobList[zone][172].info = {"NM", "Snypestix Eaglebeak",     "Goblin", "NIN",  nil  } -- Snypestix Eaglebeak
mobList[zone][173].info = {"NM", "Anvilix Sootwrists",      "Goblin", "WAR",  nil  } -- Anvilix Sootwrists
mobList[zone][174].info = {"NM", "Bootrix Jaggedelbow",     "Goblin", "MNK",  nil  } -- Bootrix Jaggedelbow
mobList[zone][175].info = {"NM", "Mobpix Mucousmouth",      "Goblin", "THF",  nil  } -- Mobpix Mucousmouth
mobList[zone][176].info = {"NM", "Distilix Stickytoes",     "Goblin", "WHM",  nil  } -- Distilix Stickytoes
mobList[zone][177].info = {"NM", "Eremix Snottynostril",    "Goblin", "BLM",  nil  } -- Eremix Snottynostril
mobList[zone][178].info = {"NM", "Jabbrox Grannyguise",     "Goblin", "RDM",  nil  } -- Jabbrox Grannyguise
mobList[zone][179].info = {"NM", "Scruffix Shaggychest",    "Goblin", "PLD",  nil  } -- Scruffix Shaggychest
mobList[zone][180].info = {"NM", "Tymexox Ninefingers",     "Goblin", "DRK",  nil  } -- Tymexox Ninefingers
mobList[zone][181].info = {"NM", "Blazox Boneybod",         "Goblin", "BST",  nil  } -- Blazox Boneybod
mobList[zone][182].info = {"NM", "Prowlox Barrelbelly",     "Goblin", "RNG",  nil  } -- Prowlox Barrelbelly
mobList[zone][183].info = {"NM", "Slystix Megapeepers",     "Goblin", "RNG",  nil  } -- Slystix Megapeepers

----------------------------------------------------------------------------------------------------
--                                    Setup of Wave Spawning                                      --
----------------------------------------------------------------------------------------------------

---------------------------------------------
--           Wave Defeat Reqs.          --
--------------------------------------------
--mobList[zone].waveDefeatRequirements[2] = {zone:getLocalVar("MegaBoss_Killed") == 1}

mobList[zone].waveDefeatRequirements[2 ] = { zone:getLocalVar("73_killed") == 1 } -- Spawns 98-100 when 73 is killed
mobList[zone].waveDefeatRequirements[3 ] = { zone:getLocalVar("98_killed") == 1, zone:getLocalVar("99_killed") == 1, zone:getLocalVar("100_killed") == 1 } -- Spawns 101-112 when 98,99 and 100 all are killed
mobList[zone].waveDefeatRequirements[4 ] = { zone:getLocalVar("44_killed") == 1 } -- Spawns 89-97 when 44 is killed
mobList[zone].waveDefeatRequirements[5 ] = { zone:getLocalVar("64_killed") == 1 } -- Spawns 78-89 and 113 (Megaboss) when 64 is killed
mobList[zone].waveDefeatRequirements[6 ] = { zone:getLocalVar("MegaBoss_Killed") == 1 } -- Spawns 121-150 when Megaboss killed

------------------------------------------
--            Wave Spawning             --
-- Note: Wave 1 spawns at start.        --
------------------------------------------
--mobList[zone].wave# = { MobIndex#1, MobIndex#2, MobIndex#3 }

mobList[zone].wave1 = {
    1 ,     -- 001-G/R
    2 ,     -- 002-G/R(30)
    77,     -- 077-G/R(HP)
    76,     -- 076-G/R(MP)
    71,     -- 071-G/R
    70,     -- 070-G/R
    69,     -- 069-G/R
    72,     -- 072-G/R
    75,     -- 075-G/R
    74,     -- 074-G/R
    73,     -- 073-G/R
    68,     -- 068-G/R(HP)
    67,     -- 067-G/R(MP)
    3 ,     -- 003-G/R
    4 ,     -- 004-G/R(30)
    5 ,     -- 005-G/R(HP)
    9 ,     -- 009-G/R(MP)
    7 ,     -- 007-G/R
    8 ,     -- 008-G/R
    6 ,     -- 006-G/R
    10,     -- 010-G/R
    11,     -- 011-G/R(HP)
    12,     -- 012-G/R(MP)
    13,     -- 013-G/R
    14,     -- 014-G/R
    15,     -- 015-G/R
    16,     -- 016-G/R(HP)
    18,     -- 018-G/R
    17,     -- 017-G/R(MP)
    20,     -- 020-G/R
    19,     -- 019-G/R
    32,     -- 032-G/R
    34,     -- 034-G/R
    33,     -- 033-G/R
    30,     -- 030-G/R(MP)
    29,     -- 029-G/R(30)
    31,     -- 031-G/R(HP)
    28,     -- 028-G/R
    27,     -- 027-G/R
    21,     -- 021-G/R
    25,     -- 025-G/R(MP)
    26,     -- 026-G/R(HP)
    22,     -- 022-G/R
    24,     -- 024-G/R(MP)
    23,     -- 023-G/R(HP)
    36,     -- 036-G/R
    37,     -- 037-G/R
    35,     -- 035-G/R
    39,     -- 039-G/R(MP)
    38,     -- 038-G/R
    40,     -- 040-G/R(HP)
    41,     -- 041-G/R
    42,     -- 042-G/R
    43,     -- 043-G/R
    44,     -- 044-G/S(MP)
    45,     -- 045-G/R(30)
    46,     -- 046-G/R
    47,     -- 047-G/R
    49,     -- 049-G/R
    65,     -- 065-G/R(HP)
    48,     -- 048-G/R
    50,     -- 050-G/R
    58,     -- 058-G/R
    53,     -- 053-G/R
    54,     -- 054-G/R
    51,     -- 051-G/R
    55,     -- 055-G/R
    52,     -- 052-G/R
    57,     -- 057-G/R(HP)
    56,     -- 056-G/R(MP)
    66,     -- 066-G/R
    59,     -- 059-G/R
    61,     -- 061-G/R
    60,     -- 060-G/R
    63,     -- 063-G/R(HP)
    62,     -- 062-G/R(MP)
    64      -- 064-G/S(MP)
}

mobList[zone].wave2 = {
    99 ,    -- 099-G/R
    98 ,    -- 098-G/R
    100     -- 100-G/R
}

mobList[zone].wave3 = {
    101,    -- 101-G/R(MP)
    102,    -- 102-G/R(HP)
    103,    -- 103-G/R
    104,    -- 104-G/R
    105,    -- 105-G/R
    106,    -- 106-G/R
    107,    -- 107-G/R
    108,    -- 108-G/R
    109,    -- 109-G/R
    110,    -- 110-G/R
    111,    -- 111-G/R
    112     -- 112-G/R
}

mobList[zone].wave4 = {
     89,    -- 089-G/R
     90,    -- 090-G/R
     91,    -- 091-G/R
     92,    -- 092-G/R
     93,    -- 093-G/R(HP)
     94,    -- 094-G/R(MP)
     95,    -- 095-G/R(MP)
     96,    -- 096-G/R
     97     -- 097-G/R
}

mobList[zone].wave5 = {
     78,    -- 078-G/R(MP)
     79,    -- 079-G/R(HP)
     80,    -- 080-G/R(HP)
     81,    -- 081-G/R(MP)
     82,    -- 082-G/R(MP)
     83,    -- 083-G/R(HP)
     84,    -- 084-G/R(HP)
     85,    -- 085-G/R(MP)
     86,    -- 086-G/R
     87,    -- 087-G/R
     88,    -- 088-G/R
     89,    -- 089 G/R
    113,    -- 113-Replica NM (Goblin Golem)(30)
    114,    -- 114-G/R
    115,    -- 115-G/R
    116,    -- 116-G/R
    117,    -- 117-G/R
    118,    -- 118-G/R(MP)
    119,    -- 119-G/R(HP)
    120     -- 120-G/R
}

mobList[zone].wave6 = {
    121,    -- 121-G/R
    122,    -- 122-G/R(MP)
    123,    -- 123-G/R(HP)
    124,    -- 124-G/R
    125,    -- 125-G/R
    126,    -- 126-G/R(HP)
    127,    -- 127-G/R(MP)
    128,    -- 128-G/R(HP)
    129,    -- 129-G/R(MP)
    130,    -- 130-G/R
    131,    -- 131-G/R
    132,    -- 132-G/R
    133,    -- 133-G/R
    134,    -- 134-G/R
    135,    -- 135-G/R
    136,    -- 136-G/R
    137,    -- 137-G/R
    138,    -- 138-G/R
    139,    -- 139-G/R
    140,    -- 140-G/R
    141,    -- 141-G/R
    142,    -- 142-G/R
    143,    -- 143-G/R
    144,    -- 144-G/R
    145,    -- 145-G/R
    146,    -- 146-G/R
    147,    -- 147-G/R
    148,    -- 148-G/R
    149,    -- 149-G/R
    150     -- 150-G/R(MP)
}

----------------------------------------------------------------------------------------------------
--                                  Setup of Children Spawning                                    --
----------------------------------------------------------------------------------------------------
------------------------------------------
--          Normal Child Spawn          --
------------------------------------------
-- mobList[zone][MobIndex].mobchildren = {#WAR, #MNK, #WHM, #BLM, #RDM, #THF, #PLD, #DRK, #BST, #BRD, #RNG, #SAM, #NIN, #DRG, #SMN}

mobList[zone][1  ].mobchildren = {   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }
mobList[zone][2  ].mobchildren = { nil, nil, nil, nil,   1, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil  }
mobList[zone][3  ].mobchildren = { nil, nil, nil, nil, nil, nil,   1,   1, nil, nil, nil, nil, nil, nil, nil  }
mobList[zone][5  ].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil,   1, nil, nil  }
mobList[zone][8  ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil  }
mobList[zone][9  ].mobchildren = { nil,   1, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil  }
mobList[zone][10 ].mobchildren = {   1, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, }
mobList[zone][11 ].mobchildren = { nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil  }
mobList[zone][13 ].mobchildren = { nil,   2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }
mobList[zone][14 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  }
mobList[zone][15 ].mobchildren = { nil, nil, nil, nil,   1, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil  }
mobList[zone][16 ].mobchildren = { nil, nil, nil, nil, nil, nil,   1,   1, nil, nil, nil, nil, nil, nil, nil  }
mobList[zone][17 ].mobchildren = { nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }
mobList[zone][18 ].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil, nil, nil,   4, nil, nil, nil, nil  }
mobList[zone][19 ].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil,   1, nil  }
mobList[zone][20 ].mobchildren = {   1, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil  }
mobList[zone][21 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil  }
mobList[zone][23 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, }
mobList[zone][24 ].mobchildren = {   1, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }
mobList[zone][25 ].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil,   1, nil, nil, nil, nil, nil, nil  }
mobList[zone][26 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil  }
mobList[zone][27 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  }
mobList[zone][28 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil  }
mobList[zone][29 ].mobchildren = { nil,   1,   1,   1,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil  }
mobList[zone][30 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil  }
mobList[zone][31 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil  }
mobList[zone][32 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, }
mobList[zone][33 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  }
mobList[zone][34 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil,   1, nil  }
mobList[zone][35 ].mobchildren = {   1, nil, nil, nil, nil,   1 ,nil, nil, nil, nil, nil, nil, nil, nil, nil  }
mobList[zone][36 ].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }
mobList[zone][37 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil  }
mobList[zone][38 ].mobchildren = { nil, nil, nil, nil, nil, nil,   1,   1, nil, nil, nil, nil, nil, nil, nil  }
mobList[zone][39 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   3, }
mobList[zone][42 ].mobchildren = { nil,   1, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }
mobList[zone][43 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil  }
mobList[zone][45 ].mobchildren = { nil, nil,   1, nil,   1, nil,   1,   1, nil,   1, nil, nil, nil, nil, nil  }
mobList[zone][46 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil  }
mobList[zone][47 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil  }
mobList[zone][48 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil  }
mobList[zone][49 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil  }
mobList[zone][50 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil  }
mobList[zone][51 ].mobchildren = {   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }
mobList[zone][52 ].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }
mobList[zone][53 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, }
mobList[zone][54 ].mobchildren = { nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }
mobList[zone][55 ].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }
mobList[zone][58 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  }
mobList[zone][59 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil  }
mobList[zone][60 ].mobchildren = { nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }
mobList[zone][61 ].mobchildren = { nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil  }
mobList[zone][62 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil,   1, nil, nil, nil  }
mobList[zone][63 ].mobchildren = {   1, nil,   1, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil  }
mobList[zone][65 ].mobchildren = { nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil  }
mobList[zone][66 ].mobchildren = { nil, nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }
mobList[zone][67 ].mobchildren = { nil,   1, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }
mobList[zone][68 ].mobchildren = {   1, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }
mobList[zone][69 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, }
mobList[zone][70 ].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }
mobList[zone][71 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil  }
mobList[zone][72 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil  }
mobList[zone][73 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil,   1, }
mobList[zone][74 ].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil,   1, nil  }
mobList[zone][75 ].mobchildren = { nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  }
mobList[zone][76 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1,   1, nil, nil  }
mobList[zone][77 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1, nil, nil,   1, nil, nil, nil, nil  }
mobList[zone][78 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil  }
mobList[zone][79 ].mobchildren = { nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil  }
mobList[zone][80 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil  }
mobList[zone][81 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  }
mobList[zone][82 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil  }
mobList[zone][83 ].mobchildren = { nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }
mobList[zone][84 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil  }
mobList[zone][85 ].mobchildren = {   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }
mobList[zone][86 ].mobchildren = { nil, nil, nil,   3, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil  }
mobList[zone][87 ].mobchildren = { nil, nil, nil, nil, nil, nil,   1,   1, nil,    1,  1, nil, nil, nil, nil  }
mobList[zone][88 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil,   1,   1, }
mobList[zone][89 ].mobchildren = { nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }
mobList[zone][91 ].mobchildren = { nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }
mobList[zone][92 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil  }
mobList[zone][93 ].mobchildren = {   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }
mobList[zone][94 ].mobchildren = { nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }
mobList[zone][95 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, }
mobList[zone][96 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil  }
mobList[zone][97 ].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }
mobList[zone][103].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil,   1, nil, nil, nil, nil, nil  }
mobList[zone][104].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil,   1, nil, nil, nil, nil, nil  }
mobList[zone][105].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil  }
mobList[zone][106].mobchildren = { nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, }
mobList[zone][107].mobchildren = { nil, nil,   1, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil  }
mobList[zone][108].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil  }
mobList[zone][109].mobchildren = { nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil  }
mobList[zone][110].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil  }
mobList[zone][111].mobchildren = { nil, nil, nil, nil,   1, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil  }
mobList[zone][112].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil  }
mobList[zone][114].mobchildren = { nil, nil, nil,   1,   1, nil, nil, nil, nil, nil,   1, nil, nil, nil,   1, }
mobList[zone][115].mobchildren = {   1, nil, nil, nil, nil, nil, nil,   1,   1,   1, nil, nil, nil, nil, nil  }
mobList[zone][116].mobchildren = { nil,   1,   1, nil, nil, nil, nil, nil,   1, nil, nil,   1, nil, nil, nil  }
mobList[zone][117].mobchildren = { nil, nil, nil, nil, nil,   1,   1, nil, nil, nil, nil, nil,   1,   1, nil  }
mobList[zone][120].mobchildren = {   1, nil,   1,   1,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil  }
mobList[zone][121].mobchildren = {   1, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil  }
mobList[zone][122].mobchildren = { nil,   1, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil,   1, }
mobList[zone][123].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil,   1, nil, nil, nil  }
mobList[zone][124].mobchildren = { nil, nil, nil, nil, nil, nil,   1, nil,   1,   1,   1, nil, nil, nil, nil  }
mobList[zone][125].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil,   3, nil, nil  }
mobList[zone][126].mobchildren = { nil, nil,   1, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil  }
mobList[zone][127].mobchildren = { nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil  }
mobList[zone][128].mobchildren = { nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, }
mobList[zone][129].mobchildren = { nil, nil,   1, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil  }
mobList[zone][130].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil,   1, nil, nil, nil  }
mobList[zone][131].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil  }
mobList[zone][132].mobchildren = { nil,   1, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil  }
mobList[zone][133].mobchildren = {   1, nil, nil,   1, nil, nil, nil,   1, nil, nil,   1, nil, nil, nil,   1, }
mobList[zone][134].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil,   1, nil,   2, nil,   1, nil  }
mobList[zone][135].mobchildren = {   1,   1,   1,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }
mobList[zone][136].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, }
mobList[zone][137].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil  }
mobList[zone][138].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil  }
mobList[zone][139].mobchildren = { nil, nil, nil, nil, nil, nil,   3, nil, nil,   1, nil, nil, nil, nil, nil  }
mobList[zone][140].mobchildren = {   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil  }
mobList[zone][141].mobchildren = { nil,   1, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil  }
mobList[zone][142].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1, nil, nil,   1, nil,   1, nil, nil  }
mobList[zone][143].mobchildren = { nil, nil, nil, nil,   1, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil  }
mobList[zone][144].mobchildren = { nil, nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }
mobList[zone][145].mobchildren = { nil, nil, nil, nil,   1, nil,   1,   1, nil,   1, nil, nil,   1, nil, nil  }
mobList[zone][146].mobchildren = {   1,   2,   1, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil  }
mobList[zone][147].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1,   1, }
mobList[zone][148].mobchildren = { nil, nil,   1,   1, nil, nil, nil, nil, nil,   1, nil, nil,   1, nil, nil  }
mobList[zone][149].mobchildren = {   1,   1, nil, nil, nil,   1, nil, nil, nil, nil, nil,   1, nil, nil, nil  }
mobList[zone][150].mobchildren = { nil, nil, nil, nil,   1,   1,   1, nil, nil,   1, nil, nil,   1, nil, nil  }

------------------------------------------
--            NM Child Spawn            --
------------------------------------------
-- mobList[zone][MobIndex].NMchildren = {MobIndex(NM1), MobIndex(NM2), MobIndex(NM3)}
-- boolean value = forceLink true/false

mobList[zone][3  ].specificChildren = { true, 158 } -- Wyrmwix Snakespecs
mobList[zone][10 ].specificChildren = { true, 157 } -- Hermitrix Toothrot
mobList[zone][18 ].specificChildren = { true, 159 } -- Morgmox Moldnoggin
mobList[zone][23 ].specificChildren = { true, 164 } -- Humnox Drumbelly
mobList[zone][26 ].specificChildren = { true, 163 } -- Buffrix Eargone
mobList[zone][29 ].specificChildren = { true, 160 } -- Sparkspox Sweatbrow
mobList[zone][40 ].specificChildren = { true, 161 } -- Elixmix Hooknose
mobList[zone][43 ].specificChildren = { true, 167 } -- Trailblix Goatmug
mobList[zone][45 ].specificChildren = { true, 162 } -- Bandrix Rockjaw
mobList[zone][49 ].specificChildren = { true, 166 } -- Lurklox Dhalmelneck
mobList[zone][62 ].specificChildren = { true, 165 } -- Ticktox Beadyeyes
mobList[zone][73 ].specificChildren = { true, 151 } -- Gabblox Magpietongue
mobList[zone][74 ].specificChildren = { true, 152 } -- Tufflix Loglimbs
mobList[zone][75 ].specificChildren = { true, 153 } -- Cloktix Longnail
mobList[zone][86 ].specificChildren = { true, 169 } -- Karashix Swollenskull
mobList[zone][87 ].specificChildren = { true, 171 } -- Rutrix Hamgams
mobList[zone][88 ].specificChildren = { true, 172 } -- Snypestix Eaglebeak
mobList[zone][95 ].specificChildren = { true, 170 } -- Mortilox Wartpaws
mobList[zone][105].specificChildren = { true, 155 } -- Jabkix Pigeonpecs
mobList[zone][106].specificChildren = { true, 156 } -- Wasabix Callusdigit
mobList[zone][107].specificChildren = { true, 154 } -- Smeltix Thickhide
mobList[zone][120].specificChildren = { true, 168 } -- Kikklix Longlegs
mobList[zone][124].specificChildren = { true, 180 } -- Tymexox Ninefingers
mobList[zone][125].specificChildren = { true, 183 } -- Slystix Megapeepers
mobList[zone][133].specificChildren = { true, 174 } -- Bootrix Jaggedelbow
mobList[zone][134].specificChildren = { true, 173 } -- Anvilix Sootwrists
mobList[zone][135].specificChildren = { true, 175 } -- Mobpix Mucousmouth
mobList[zone][142].specificChildren = { true, 179 } -- Scruffix Shaggychest
mobList[zone][145].specificChildren = { true, 181 } -- Blazox Boneybod
mobList[zone][146].specificChildren = { true, 177 } -- Eremix Snottynostril
mobList[zone][148].specificChildren = { true, 178 } -- Jabbrox Grannyguise
mobList[zone][149].specificChildren = { true, 182 } -- Prowlox Barrelbelly
mobList[zone][150].specificChildren = { true, 176 } -- Distilix Stickytoes

------------------------------------------
--          Mob Position Info           --
-- Note: Must be setup for parent mobs, --
-- but is optional for children.        --
------------------------------------------
-- mobList[zone][MobIndex].pos = {xpos, ypos, zpos, rot}

mobList[zone][1  ].pos = { 43.351, 9.000, -52.484, 0   }
mobList[zone][2  ].pos = { 38.270, 9.000, -52.484, 0   }
mobList[zone][3  ].pos = { 49.051, 0.000, -17.590, 64  }
mobList[zone][4  ].pos = { 42.000, 0.000, -20.973, 128 }
mobList[zone][5  ].pos = { 41.176, 0.000, -26.309, 128 }
mobList[zone][6  ].pos = { 33.000, 0.005, -7.000, 64   }
mobList[zone][7  ].pos = { 30.000, 0.005, -7.000, 64   }
mobList[zone][8  ].pos = { 27.000, 0.005, -7.000, 64   }
mobList[zone][9  ].pos = { 37.984, 0.005,  -5.958, 92  }
mobList[zone][10 ].pos = { 24.000, 0.000, -35.990, 0   }
mobList[zone][11 ].pos = { 34.867,-1.500, -56.991, 128 }
mobList[zone][12 ].pos = { 25.945,-1.500, -57.049, 0   }
mobList[zone][13 ].pos = { 33.983, 0.002, -77.834, 161 }
mobList[zone][14 ].pos = { 22.014, 0.005, -74.013, 0   }
mobList[zone][15 ].pos = { 12.947, 0.002, -79.019, 192 }
mobList[zone][16 ].pos = {  3.997, 0.003, -66.821, 64  }
mobList[zone][17 ].pos = {  0.923, 0.005, -77.067, 0   }
mobList[zone][18 ].pos = {  0.050, 0.000, -89.174, 192 }
mobList[zone][19 ].pos = { -8.850, 0.005, -76.914, 128 }
mobList[zone][20 ].pos = { -9.000, 0.005, -71.000, 128 }
mobList[zone][21 ].pos = {-26.065, 0.005, -64.910, 128 }
mobList[zone][22 ].pos = {-38.596, 0.005, -62.539, 0   }
mobList[zone][23 ].pos = {-40.048, 0.005, -57.990, 254 }
mobList[zone][24 ].pos = {-41.201, 0.005, -48.389, 0   }
mobList[zone][25 ].pos = {-30.416, 0.003, -52.233, 0   }
mobList[zone][26 ].pos = {-21.129, 0.004, -51.971, 128 }
mobList[zone][27 ].pos = {-34.476, 1.000, -30.773, 192 }
mobList[zone][28 ].pos = {-25.688, 1.000, -30.595, 194 }
mobList[zone][29 ].pos = {-29.956, 3.000, -5.101,  64  }
mobList[zone][30 ].pos = {-24.019, 3.000, -9.986,  128 }
mobList[zone][31 ].pos = {-23.988, 3.000, -2.022,  128 }
mobList[zone][32 ].pos = { -8.252, 3.000, -6.256,  38  }
mobList[zone][33 ].pos = { -0.096, 3.000, -10.999, 192 }
mobList[zone][34 ].pos = {  4.692, 3.000,  0.769,  96  }
mobList[zone][35 ].pos = {-56.000, 6.000,  -5.967, 0   }
mobList[zone][36 ].pos = {-56.000, 6.000,  -2.051, 0   }
mobList[zone][37 ].pos = {-56.000, 6.000, -10.025, 190 }
mobList[zone][38 ].pos = {-56.892, 6.001,   8.025, 92  }
mobList[zone][39 ].pos = {-71.317, 5.591,  -7.930, 0   }
mobList[zone][40 ].pos = {-73.272, 5.591, -23.047, 190 }
mobList[zone][41 ].pos = {-40.552, 8.000, -19.009, 128 }
mobList[zone][42 ].pos = {-58.048,12.000, -27.905, 194 }
mobList[zone][43 ].pos = {-54.429,12.000, -34.462, 160 }
mobList[zone][44 ].pos = {-65.974,12.001, -33.006,  0  }
mobList[zone][45 ].pos = {  0.018, 3.000,  15.970, 64  }
mobList[zone][46 ].pos = {-12.005, 2.000,  38.074, 192 }
mobList[zone][47 ].pos = { 12.006, 2.000,  38.134, 192 }
mobList[zone][48 ].pos = { -0.036,-5.000,  39.787, 64  }
mobList[zone][49 ].pos = { -0.048,-2.000,  55.241, 64  }
mobList[zone][50 ].pos = {-11.824,-5.000,  52.104, 128 }
mobList[zone][51 ].pos = {-15.500, 2.000,  56.098, 0   }
mobList[zone][52 ].pos = {-21.827, 2.000,  64.080, 0   }
mobList[zone][53 ].pos = { 11.809,-5.000,  52.192, 0   }
mobList[zone][54 ].pos = { 14.601, 2.000,  57.737, 128 }
mobList[zone][55 ].pos = { 21.951, 2.000,  63.927, 128 }
mobList[zone][56 ].pos = { -6.004, 2.000,  66.106, 128 }
mobList[zone][57 ].pos = {  5.938, 2.000,  65.998, 255 }
mobList[zone][58 ].pos = { -0.063, 2.000,  82.093, 64  }
mobList[zone][59 ].pos = {  0.148, 3.000, 100.530, 64  }
mobList[zone][60 ].pos = { -1.992, 3.100, 108.075, 60  }
mobList[zone][61 ].pos = {  1.979, 3.100, 108.075, 60  }
mobList[zone][62 ].pos = { -1.992, 3.100, 120.033, 60  }
mobList[zone][63 ].pos = {  1.979, 3.100, 120.033, 60  }
mobList[zone][64 ].pos = {  0.021, 2.000, 126.701, 64  }
mobList[zone][65 ].pos = {  0.141,-5.000,  66.541, 64  }
mobList[zone][66 ].pos = { -0.072,-5.000,  26.939, 64  }
mobList[zone][67 ].pos = { -1.703, 9.000, -30.225, 64  }
mobList[zone][68 ].pos = {  1.623, 9.000, -30.151, 64  }
mobList[zone][69 ].pos = {  0.019, 9.000, -38.635, 192 }
mobList[zone][70 ].pos = { -5.897, 9.000, -43.917, 128 }
mobList[zone][71 ].pos = { -0.021, 9.000, -49.958, 64  }
mobList[zone][72 ].pos = {  5.975, 9.000, -43.983, 0   }
mobList[zone][73 ].pos = { 18.113, 9.000, -36.033, 128 }
mobList[zone][74 ].pos = {-18.011, 9.001, -50.038, 0   }
mobList[zone][75 ].pos = {  4.047, 9.000, -62.137, 192 }
mobList[zone][76 ].pos = { 20.018, 9.000, -48.742, 128 }
mobList[zone][77 ].pos = { 20.018, 9.000, -51.949, 128 }
mobList[zone][78 ].pos = {-12.069, 2.000,  72.000, 128 }
mobList[zone][79 ].pos = {  2.051, 2.000,  72.000, 0   }
mobList[zone][80 ].pos = {-13.588, 2.000,  70.086, 0   }
mobList[zone][81 ].pos = { 12.000, 2.000,  66.000, 128 }
mobList[zone][82 ].pos = {-14.417, 2.000,  53.530, 0   }
mobList[zone][83 ].pos = { 12.000, 2.000,  54.000, 128 }
mobList[zone][84 ].pos = { -7.001, 2.000,  37.179, 192 }
mobList[zone][85 ].pos = {  7.378, 2.000,  37.635, 192 }
mobList[zone][86 ].pos = { -0.036,-5.000,  39.787, 64  }
mobList[zone][87 ].pos = {  0.027, 3.000,  18.002, 64  }
mobList[zone][88 ].pos = {  0.012, 3.000,  -1.037, 192 }
mobList[zone][89 ].pos = {-38.011, 3.000,  -2.015, 128 }
mobList[zone][90 ].pos = {-38.011, 3.000,  -6.038, 128 }
mobList[zone][91 ].pos = {-38.011, 3.000, -10.020, 128 }
mobList[zone][92 ].pos = {-56.027, 6.000,  -9.053, 0   }
mobList[zone][93 ].pos = {-61.956, 6.000,   5.796, 64  }
mobList[zone][94 ].pos = {-64.924, 6.000,   5.796, 64  }
mobList[zone][95 ].pos = {-71.317, 5.591,  -7.930, 0   }
mobList[zone][96 ].pos = {-57.049, 6.000, -16.083, 192 }
mobList[zone][97 ].pos = {-40.552, 8.000, -19.009, 128 }
mobList[zone][98 ].pos = { 46.906, 7.500, -44.561, 64  }
mobList[zone][99 ].pos = { 49.457, 7.500, -44.515, 64  }
mobList[zone][100].pos = { 52.503, 7.500, -44.614, 64  }
mobList[zone][101].pos = { -1.703, 9.000, -30.225, 192 }
mobList[zone][102].pos = {  1.623, 9.000, -30.151, 192 }
mobList[zone][103].pos = { -1.703, 9.000, -36.124, 192 }
mobList[zone][104].pos = {  1.623, 9.000, -36.124, 192 }
mobList[zone][105].pos = { -5.897, 9.000, -43.917, 128 }
mobList[zone][106].pos = { -0.021, 9.000, -49.958, 64  }
mobList[zone][107].pos = {  5.975, 9.000, -43.983, 0   }
mobList[zone][108].pos = { 18.035, 9.000, -35.961, 128 }
mobList[zone][109].pos = {-19.931, 9.001, -50.028, 0   }
mobList[zone][110].pos = {  4.059, 9.000, -64.101, 192 }
mobList[zone][111].pos = { 22.825, 9.000, -50.898, 128 }
mobList[zone][112].pos = { 21.137, 9.000, -53.949, 0   }
mobList[zone][114].pos = {  4.024, 0.001, -70.961, 192 }
mobList[zone][115].pos = {  0.069, 0.005, -74.060, 128 }
mobList[zone][116].pos = {  2.042, 0.002, -74.060, 0   }
mobList[zone][117].pos = {  4.024, 0.005, -77.048, 64  }
mobList[zone][118].pos = { -2.015, 0.000, -85.922, 192 }
mobList[zone][119].pos = {  1.960, 0.000, -85.922, 192 }
mobList[zone][120].pos = { -2.015, 0.000, -89.958, 192 }
mobList[zone][121].pos = {-29.978, 0.005, -63.900, 64  }
mobList[zone][122].pos = {-39.967, 0.005, -51.981, 0   }
mobList[zone][123].pos = {-27.880,-0.000, -51.964, 0   }
mobList[zone][124].pos = {-30.043, 0.000, -36.094, 64  }
mobList[zone][125].pos = {-30.043, 3.000, -23.514, 192 }
mobList[zone][126].pos = {-31.111, 3.000,  -9.024, 128 }
mobList[zone][127].pos = {-27.008, 3.000,  -9.024, 0   }
mobList[zone][128].pos = {-31.111, 3.000,  -5.074, 128 }
mobList[zone][129].pos = {-27.008, 3.000,  -5.084, 0   }
mobList[zone][130].pos = {-15.007, 3.000, -10.003, 128 }
mobList[zone][131].pos = {-12.072, 3.000,  -2.020, 128 }
mobList[zone][132].pos = {-8.167, 3.000,  -10.015, 128 }
mobList[zone][133].pos = {  0.010, 3.000,  13.913, 64  }
mobList[zone][134].pos = {  5.949, 3.000,  -5.975, 0   }
mobList[zone][135].pos = { 33.099, 0.004,  -1.665, 64  }
mobList[zone][136].pos = { 29.211, 0.004,  -5.905, 64  }
mobList[zone][137].pos = { 33.099, 0.004,  -5.905, 64  }
mobList[zone][138].pos = { 36.986, 0.004,  -5.905, 64  }
mobList[zone][139].pos = { 44.481, 0.001, -19.216, 128 }
mobList[zone][140].pos = { 28.697, 0.000, -25.372, 64  }
mobList[zone][141].pos = { 32.192, 0.000, -25.372, 64  }
mobList[zone][142].pos = { 23.992, 0.000, -35.979, 0   }
mobList[zone][143].pos = { 34.022, 0.000, -42.434, 128 }
mobList[zone][144].pos = { 34.447,-1.500, -57.916, 128 }
mobList[zone][145].pos = { 49.590, 4.500, -36.646, 64  }
mobList[zone][146].pos = { 49.419, 9.001, -52.159, 64  }
mobList[zone][147].pos = {  3.978, 9.000, -50.966, 0   }
mobList[zone][148].pos = { -6.777, 9.000, -32.475, 53  }
mobList[zone][149].pos = {  7.145, 9.000, -32.126, 76  }
mobList[zone][150].pos = {  0.064, 4.001, -13.768, 64  }

----------------------------------------------------------------------------------------------------
--                                    Setup of Mob Functions                                      --
----------------------------------------------------------------------------------------------------
------------------------------------------
--             Patrol Paths             --
------------------------------------------
-- mobList[zone][MobIndex].patrolPath = {xpos1,ypos1,zpos1, xpos2,ypos2,zpos2,  xpos3,ypos3,zpos3}

-- mobList[zone][8  ].patrolPath = { -96,  -2, -123,     -60,  -2, -113,    -96,   -2, -123  }    -- Entrance Bridge W

mobList[zone][2  ].patrolPath = {   38, 9, -52,    22, 9,  -52,     38, 9, -52   } -- Dyna Entrance
mobList[zone][4  ].patrolPath = {   42, 0, -20,    28, 0,  -20,     42, 0, -20   } -- Dyna Entrance Top of Stairs
mobList[zone][7  ].patrolPath = {   30, 0, -7,     30, 0,  -46,     30, 0, -7    } -- E Upper Level C
mobList[zone][8  ].patrolPath = {   27, 0, -7,     27, 0,  -46,     27, 0, -7    } -- E Upper Level W
mobList[zone][6  ].patrolPath = {   33, 0, -7,     33, 0,  -46,     33, 0, -7    } -- E Upper Level E
mobList[zone][20 ].patrolPath = {   -9, 0, -71,   -31, 0,  -71,     -9, 0, -71   }
mobList[zone][19 ].patrolPath = {   -9, 0, -77,   -31, 0,  -77,     -9, 0, -77   }
mobList[zone][68 ].patrolPath = {    2, 9, -27,     2, 9,  -35,      2, 9, -27   } -- Fountain Stairs E
mobList[zone][67 ].patrolPath = {   -2, 9, -27,    -2, 9,  -35,     -2, 9, -27   } -- Fountain Stairs W
mobList[zone][70 ].patrolPath = {   -7, 9, -49,    -7, 9,  -35,     -7, 9, -49   } -- Fountain W
mobList[zone][71 ].patrolPath = {    9, 9, -51,    -7, 9,  -51,      9, 9, -51   } -- Fountain S
mobList[zone][69 ].patrolPath = {   -5, 9, -37,     5, 9,  -37,     -5, 9, -37   } -- Fountain N
mobList[zone][72 ].patrolPath = {    7, 9, -35,     7, 9,  -49,      7, 9, -35   } -- Fountain E
mobList[zone][49 ].patrolPath = {    0, -5, 61,     0, 2,   44,      0, -5, 61   } -- Palace Stairs
mobList[zone][17 ].patrolPath = {    1, 0, -69,     1, 0,  -85,      1, 0, -69   } -- Near Mega Boss
mobList[zone][21 ].patrolPath = {  -26, 0, -67,   -26, 0,  -43,    -26, 0, -67   } -- W Upper Level
mobList[zone][22 ].patrolPath = {  -37, 0, -63,   -37, 0,  -41,    -37, 0, -63   } -- W Upper Level
mobList[zone][27 ].patrolPath = {  -34, 0, -36,   -34, 3,  -14,    -34, 0, -36   } -- W Upper Level Stairs W
mobList[zone][28 ].patrolPath = {  -26, 3, -14,   -26, 0,  -38,    -26, 3, -14   } -- W Upper Level Stairs E
mobList[zone][31 ].patrolPath = {  -18, 3,  -2,   -36, 3,   -2,    -18, 3, -2    } -- N Upper Level N
mobList[zone][30 ].patrolPath = {  -18, 3, -10,   -36, 3,  -10,    -18, 3, -10   } -- N Upper Level S
mobList[zone][32 ].patrolPath = {    4, 3, -6,    -24, 3,   -6,      4, 3, -6    } -- N Upper Level C
mobList[zone][35 ].patrolPath = {  -56, 6, -6,    -68, 6,   -6,    -56, 6, -6    } -- AH C
mobList[zone][36 ].patrolPath = {  -56, 6, -2,    -68, 6,    4,    -56, 6, -2    } -- AH N
mobList[zone][37 ].patrolPath = {  -56, 6, -10,   -68, 6,  -14,    -56, 6, -10   } -- AH S
mobList[zone][41 ].patrolPath = {  -41, 8, -23,   -41, 8,  -16,    -41, 8, -23   } -- AH Stairs
mobList[zone][42 ].patrolPath = {  -54, 12, -22,  -61, 12, -31,    -54, 12, -22  } -- AH Lower Platform
mobList[zone][45 ].patrolPath = {    0, 3,  -2,     0, 3,   22,      0, 3,  -2   } -- Palace Entrance
mobList[zone][47 ].patrolPath = {   12, 2,  40,    12, 2,   68,     12, 2,  40   } -- Palace Interior E
mobList[zone][45 ].patrolPath = {  -12, 2,  40,   -12, 2,   68,    -12, 2,  40   } -- Palace Interior W
mobList[zone][58 ].patrolPath = {  -12, 2,  72,    12, 2,   72,    -12, 2,  72   } -- Palace Rear
mobList[zone][59 ].patrolPath = {    0, 2,  96,     0, 2,   76,      0, 2,  96   } -- Near Maat
mobList[zone][14 ].patrolPath = {   30, 0, -74,    12, 0,  -74,     30, 0, -74   } -- S Upper Level
mobList[zone][79 ].patrolPath = {    2, 2,  72,    10, 2,   72,      2, 2,  72   } -- Palace Repop N #1
mobList[zone][78 ].patrolPath = {   -2, 2,  72,   -12, 2,   72,     -2, 2,  72   } -- Palace Repop N #2
mobList[zone][81 ].patrolPath = {   12, 2,  68,    12, 2,   56,     12, 2,  68   } -- Palace Repop E #1
mobList[zone][83 ].patrolPath = {   12, 2,  54,    12, 2,   42,     12, 2,  54   } -- Palace Repop E #2
mobList[zone][80 ].patrolPath = {  -12, 2,  68,   -12, 2,   56,    -12, 2,  68   } -- Palace Repop W #1
mobList[zone][82 ].patrolPath = {  -12, 2,  54,   -12, 2,   42,    -12, 2,  54   } -- Palace Repop W #2
mobList[zone][85 ].patrolPath = {   12, 2,  40,    5, 2,    40,     12, 2,  40   } -- Palace Repop S #1
mobList[zone][84 ].patrolPath = {  -12, 2,  40,   -5, 2,    40,    -12, 2,  40   } -- Palace Repop S #2
mobList[zone][14 ].patrolPath = {   30, 0, -74,    12, 0,  -74,     30, 0, -74   } -- S Upper Level
mobList[zone][87 ].patrolPath = {    0, 3,   4,     0, 3,   22,      0, 3,  4    } -- 2nd Wave Outside Palace
mobList[zone][108].patrolPath = {   18, 9, -36,    11, 9,  -36,     18, 9, -36   } -- 2nd Wave Fountain E Door
mobList[zone][109].patrolPath = {  -20, 9, -50,   -11, 9,  -50,    -20, 9, -50   } -- 2nd Wave Fountain W Door
mobList[zone][110].patrolPath = {    4, 9, -64,     4, 9,  -55,      4, 9, -64   } -- 2nd Wave Fountain S Door
mobList[zone][111].patrolPath = {   17, 9, -51,    29, 9,  -51,     17, 9, -51   } -- 3rd Wave Dyna Entrance N
mobList[zone][112].patrolPath = {   21, 9, -54,    42, 9,  -54,     21, 9, -54   } -- 3rd Wave Dyna Entrance S
mobList[zone][96 ].patrolPath = {  -56, 6, -15,   -65, 6,  -15,    -56, 6, -15   } -- AH Repop S
mobList[zone][92 ].patrolPath = {  -56, 6, -12,   -56, 6,    0,    -56, 6, -12   } -- AH Repop C
mobList[zone][97 ].patrolPath = {  -41, 8, -23,   -41, 8,  -16,    -41, 8, -23   } -- AH Repop Stairs
mobList[zone][124].patrolPath = {  -26, 0, -36,   -34, 0,  -36,    -26, 0, -36   } -- Upper Level W Repop N
mobList[zone][122].patrolPath = {  -38, 0, -40,   -38, 0,  -62,    -38, 0, -40   } -- Upper Level W Repop W
mobList[zone][123].patrolPath = {  -28, 0, -62,   -28, 0,  -44,    -28, 0, -62   } -- Upper Level W Repop E
mobList[zone][121].patrolPath = {  -34, 0, -64,   -26, 0,  -64,    -34, 0, -64   } -- Upper Level W Repop S
mobList[zone][116].patrolPath = {    2, 0, -74,     6, 0,  -74,      2, 0, -74   } -- Near Mega Boss #1
mobList[zone][117].patrolPath = {    0, 0, -80,     0, 0,  -76,      0, 0, -80   } -- Near Mega Boss #2
mobList[zone][115].patrolPath = {   -2, 0, -74,    -6, 0,  -74,     -2, 0, -74   } -- Near Mega Boss #3
mobList[zone][114].patrolPath = {    0, 0, -72,     0, 0,  -68,      0, 0, -72   } -- Near Mega Boss #4
mobList[zone][126].patrolPath = {  -31, 3, -9,    -34, 3,  -12,    -31, 3, -9    } -- Repop Upper Level N #1
mobList[zone][127].patrolPath = {  -27, 3, -9,    -24, 3,  -12,    -27, 3, -9    } -- Repop Upper Level N #2
mobList[zone][129].patrolPath = {  -27, 3, -5,    -24, 3,   -2,    -27, 3, -5    } -- Repop Upper Level N #3
mobList[zone][128].patrolPath = {  -31, 3, -5,    -34, 3,   -2,    -31, 3, -5    } -- Repop Upper Level N #4
mobList[zone][132].patrolPath = {   -8, 3, -10,    -8, 3,   -2,     -8, 3, -10   } -- Repop Upper Level NC #1
mobList[zone][131].patrolPath = {  -12, 3, -2,    -12, 3,  -10,    -12, 3, -2    } -- Repop Upper Level NC #2
mobList[zone][130].patrolPath = {  -15, 3, -10,   -15, 3,   -2,    -15, 3, -10   } -- Repop Upper Level NC #3

------------------------------------------
--          Statue Eye Colors           --
------------------------------------------
-- mobList[zone][MobIndex].eyes = dynamisEyesEra.BLUE -- Flags for blue eyes. (HP)
-- mobList[zone][MobIndex].eyes = dynamisEyesEra.GREEN -- Flags for green eyes. (MP)
-- mobList[zone][MobIndex].eyes = dynamisEyesEra.RED -- Flags for red eyes. (TE)

mobList[zone][2  ].eyes = dynamisEyesEra.RED
mobList[zone][4  ].eyes = dynamisEyesEra.RED
mobList[zone][5  ].eyes = dynamisEyesEra.BLUE
mobList[zone][9  ].eyes = dynamisEyesEra.GREEN
mobList[zone][11 ].eyes = dynamisEyesEra.BLUE
mobList[zone][12 ].eyes = dynamisEyesEra.GREEN
mobList[zone][16 ].eyes = dynamisEyesEra.BLUE
mobList[zone][17 ].eyes = dynamisEyesEra.GREEN
mobList[zone][23 ].eyes = dynamisEyesEra.BLUE
mobList[zone][24 ].eyes = dynamisEyesEra.GREEN
mobList[zone][25 ].eyes = dynamisEyesEra.GREEN
mobList[zone][26 ].eyes = dynamisEyesEra.BLUE
mobList[zone][29 ].eyes = dynamisEyesEra.RED
mobList[zone][30 ].eyes = dynamisEyesEra.GREEN
mobList[zone][31 ].eyes = dynamisEyesEra.BLUE
mobList[zone][39 ].eyes = dynamisEyesEra.GREEN
mobList[zone][40 ].eyes = dynamisEyesEra.BLUE
mobList[zone][44 ].eyes = dynamisEyesEra.GREEN
mobList[zone][45 ].eyes = dynamisEyesEra.RED
mobList[zone][56 ].eyes = dynamisEyesEra.GREEN
mobList[zone][57 ].eyes = dynamisEyesEra.BLUE
mobList[zone][62 ].eyes = dynamisEyesEra.GREEN
mobList[zone][63 ].eyes = dynamisEyesEra.BLUE
mobList[zone][64 ].eyes = dynamisEyesEra.GREEN
mobList[zone][65 ].eyes = dynamisEyesEra.BLUE
mobList[zone][67 ].eyes = dynamisEyesEra.GREEN
mobList[zone][68 ].eyes = dynamisEyesEra.BLUE
mobList[zone][76 ].eyes = dynamisEyesEra.GREEN
mobList[zone][77 ].eyes = dynamisEyesEra.BLUE
mobList[zone][78 ].eyes = dynamisEyesEra.GREEN
mobList[zone][80 ].eyes = dynamisEyesEra.BLUE
mobList[zone][81 ].eyes = dynamisEyesEra.GREEN
mobList[zone][82 ].eyes = dynamisEyesEra.GREEN
mobList[zone][83 ].eyes = dynamisEyesEra.BLUE
mobList[zone][84 ].eyes = dynamisEyesEra.BLUE
mobList[zone][85 ].eyes = dynamisEyesEra.GREEN
mobList[zone][93 ].eyes = dynamisEyesEra.BLUE
mobList[zone][94 ].eyes = dynamisEyesEra.GREEN
mobList[zone][101].eyes = dynamisEyesEra.GREEN
mobList[zone][102].eyes = dynamisEyesEra.BLUE
mobList[zone][113].eyes = dynamisEyesEra.RED
mobList[zone][118].eyes = dynamisEyesEra.GREEN
mobList[zone][119].eyes = dynamisEyesEra.BLUE
mobList[zone][122].eyes = dynamisEyesEra.GREEN
mobList[zone][123].eyes = dynamisEyesEra.BLUE
mobList[zone][126].eyes = dynamisEyesEra.BLUE
mobList[zone][127].eyes = dynamisEyesEra.GREEN
mobList[zone][128].eyes = dynamisEyesEra.BLUE
mobList[zone][129].eyes = dynamisEyesEra.GREEN
mobList[zone][150].eyes = dynamisEyesEra.GREEN

------------------------------------------
--        Time Extension Values         --
------------------------------------------
-- mobList[zone][MobIndex].timeExtension = 15

mobList[zone][2  ].timeExtension = 30
mobList[zone][4  ].timeExtension = 30
mobList[zone][29 ].timeExtension = 30
mobList[zone][45 ].timeExtension = 30
mobList[zone][113].timeExtension = 30 -- Goblin Golem