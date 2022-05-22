----------------------------------------------------------------------------------------------------
--                                      Dynamis-Valkurm                                           --
--              Primary Source of Information: https://enedin.be/dyna/html/zone/val.htm           --
--           Secondary Source of Information: http://www.dynamisbums.com/strategy/val.html        --
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
local zone = xi.zone.DYNAMIS_VALKURM
mobList = mobList or { }
mobList[zone] ={ } -- Ignore me, I just start the table.
mobList[zone].zoneID = zone -- Ignore me, I just ensure .zoneID exists.
mobList[zone].waveDefeatRequirements = { } -- Ignore me, I just start the table.
mobList[zone].waveDefeatRequirements[1] = { } -- Ignore me, I just allow for wave 1 spawning.
mobList[zone].maxWaves = 2 -- Ignore me because Oph told me to

----------------------------------------------------------------------------------------------------
--                                  Setup of Parent Spawning                                      --
----------------------------------------------------------------------------------------------------
------------------------------------------
--               Mob Info               --
-- Note: Primarily used for mobs that   --
-- are NMs or parent mobs.              --
------------------------------------------
--mobList[zone][MobIndex].info = {"Statue/NM/Nightmare", "Mob Name", "Family", "Main Job", "MobLocalVarName"}

-- Wave 1
-- Nightmare Mobs + NMs Based on https://enedin.be/dyna/html/zone/frame_val1.htm
-- Nightmare Mobs
-- Hippogryph Sands
mobList[zone][21 ].info = {"Nightmare", "Nightmare Fly", nil, nil, nil} -- ( 021 ) Nightmare Fly x3 Recovers Subjobs
mobList[zone][130].info = {"Nightmare", "Nightmare Fly", nil, nil, nil} -- ( 021 )
mobList[zone][131].info = {"Nightmare", "Nightmare Fly", nil, nil, nil} -- ( 021 )
-- Sheep Sands
mobList[zone][22 ].info = {"Nightmare", "Nightmare Fly", nil, nil, nil} -- ( 022 )  Nightmare Fly x3 Recover Subjobs
mobList[zone][132].info = {"Nightmare", "Nightmare Fly", nil, nil, nil} -- ( 022 )
mobList[zone][133].info = {"Nightmare", "Nightmare Fly", nil, nil, nil} -- ( 022 )
-- Manticore Sands
mobList[zone][23 ].info = {"Nightmare", "Nightmare Fly", nil, nil, nil} -- ( 023 ) Nightmare Fly x3 Recover Subjobs
mobList[zone][134].info = {"Nightmare", "Nightmare Fly", nil, nil, nil} -- ( 023 )
mobList[zone][135].info = {"Nightmare", "Nightmare Fly", nil, nil, nil} -- ( 023 )

-- NM based on https://enedin.be/dyna/html/zone/frame_val1.htm
-- Funguar NM Area
mobList[zone][5  ].info = {"NM", "Fairy Ring", nil, nil, nil} -- ( 005 ) Fairy Ring - Inhibits Cirrate Christelle's 'Miasmic Breath' effect; Removes Cirrate Christelle's enhanced movement speed
-- Flytrap NM Area
mobList[zone][10 ].info = {"Nightmare", "Dragontrap", nil, nil, nil} -- ( 010 ) Flytrap NMs (Dragontrap ×3)
mobList[zone][287].info = {"Nightmare", "Dragontrap", nil, nil, nil} -- Inhibits Cirrate Christelle's 'Putrid Breath' effect
mobList[zone][288].info = {"Nightmare", "Dragontrap", nil, nil, nil} -- Makes Cirrate Christelle unable to summon Nightmare Morbols
-- Treant NM Area
mobList[zone][15 ].info = {"NM", "Stcemqestcint", nil, nil, nil} -- ( 015 ) Stcemqestcint - Inhibits Cirrate Christelle's 'Vampiric Lash' effect
-- Gobbue NM Area
mobList[zone][20 ].info = {"NM", "Nant'ina", nil, nil, nil} -- ( 020 ) Nant'ina - Inhibits Cirrate Christelle's 'Fragrant Breath' effect
-- Boss Area
mobList[zone][24 ].info = {"NM", "Cirrate Christelle", nil, nil, "MegaBoss_Killed"} -- ( 024 ) Cirrate Christelle - Spawns 025-052
-- Spawns
mobList[zone][25 ].info = {"Statue",    "Goblin_Replica",       "Goblin", nil, nil} -- (025-G)
mobList[zone][26 ].info = {"Statue",    "Manifest_Icon",        "Yagudo", nil, nil} -- (026-Y)
mobList[zone][27 ].info = {"Statue",    "Adamanking_Effigy",    "Quadav", nil, nil} -- (027-Q)
mobList[zone][28 ].info = {"Statue",    "Sergeant_Tombstone",   "Orc",    nil, nil} -- (028-O)
mobList[zone][29 ].info = {"Nightmare", "Nightmare_Manticore",  nil,      nil, nil} -- ( 029 ) Nightmare Manticore (×3)
mobList[zone][136].info = {"Nightmare", "Nightmare_Manticore",  nil,      nil, nil} -- ( 029 )
mobList[zone][137].info = {"Nightmare", "Nightmare_Manticore",  nil,      nil, nil} -- ( 029 )
mobList[zone][30 ].info = {"Nightmare", "Nightmare_Hippogryph", nil,      nil, nil} -- ( 030 ) Nightmare Hippogryph (×3)
mobList[zone][138].info = {"Nightmare", "Nightmare_Hippogryph", nil,      nil, nil} -- ( 030 )
mobList[zone][139].info = {"Nightmare", "Nightmare_Hippogryph", nil,      nil, nil} -- ( 030 )
mobList[zone][31 ].info = {"Nightmare", "Nightmare_Sabotender", nil,      nil, nil} -- ( 031 ) Nightmare Sabotender (×3)
mobList[zone][140].info = {"Nightmare", "Nightmare_Sabotender", nil,      nil, nil} -- ( 031 )
mobList[zone][141].info = {"Nightmare", "Nightmare_Sabotender", nil,      nil, nil} -- ( 031 )
mobList[zone][32 ].info = {"Nightmare", "Nightmare_Sheep",      nil,      nil, nil} -- ( 032 ) Nightmare Sheep (×3)
mobList[zone][142].info = {"Nightmare", "Nightmare_Sheep",      nil,      nil, nil} -- ( 032 )
mobList[zone][143].info = {"Nightmare", "Nightmare_Sheep",      nil,      nil, nil} -- ( 032 )

-- Initial Statues based on https://enedin.be/dyna/html/zone/frame_val1.htm
-- Funguar NM Area
mobList[zone][1  ].info = {"Statue", "Manifest_Icon",      "Yagudo", nil, nil} -- (001-Y)
mobList[zone][2  ].info = {"Statue", "Manifest_Icon",      "Yagudo", nil, nil} -- (002-Y)
mobList[zone][3  ].info = {"Statue", "Manifest_Icon",      "Yagudo", nil, nil} -- (003-Y)
mobList[zone][4  ].info = {"Statue", "Manifest_Icon",      "Yagudo", nil, nil} -- (004-Y)
-- Flytrap NM Area
mobList[zone][6  ].info = {"Statue", "Goblin_Replica",     "Goblin", nil, nil} -- (006-G)
mobList[zone][7  ].info = {"Statue", "Goblin_Replica",     "Goblin", nil, nil} -- (007-G)
mobList[zone][8  ].info = {"Statue", "Goblin_Replica",     "Goblin", nil, nil} -- (008-G)
mobList[zone][9  ].info = {"Statue", "Goblin_Replica",     "Goblin", nil, nil} -- (009-G)
-- Treant NM Area
mobList[zone][11 ].info = {"Statue", "Sergeant_Tombstone", "Orc",    nil, nil} -- (011-O)
mobList[zone][12 ].info = {"Statue", "Sergeant_Tombstone", "Orc",    nil, nil} -- (012-O)
mobList[zone][13 ].info = {"Statue", "Sergeant_Tombstone", "Orc",    nil, nil} -- (013-O)
mobList[zone][14 ].info = {"Statue", "Sergeant_Tombstone", "Orc",    nil, nil} -- (014-O)
-- Goobbue NM Area
mobList[zone][16 ].info = {"Statue", "Adamanking_Effigy",  "Quadav", nil, nil} -- (016-Q)
mobList[zone][17 ].info = {"Statue", "Adamanking_Effigy",  "Quadav", nil, nil} -- (017-Q)
mobList[zone][18 ].info = {"Statue", "Adamanking_Effigy",  "Quadav", nil, nil} -- (018-Q)
mobList[zone][19 ].info = {"Statue", "Adamanking_Effigy",  "Quadav", nil, nil} -- (019-Q)

-- Wave 2 Manticore Sands and Goobubue NM Area
-- Nightmare Mobs + NMs Based on https://enedin.be/dyna/html/zone/frame_val2.htm
-- Nightmare Mobs
mobList[zone][110].info = {"Nightmare", "Nightmare_Manticore", nil, nil, nil} -- ( 110 ) Nightmare Manticore (×3)
mobList[zone][244].info = {"Nightmare", "Nightmare_Manticore", nil, nil, nil} -- ( 110 )
mobList[zone][245].info = {"Nightmare", "Nightmare_Manticore", nil, nil, nil} -- ( 110 )
mobList[zone][111].info = {"Nightmare", "Nightmare_Manticore", nil, nil, nil} -- ( 111 ) Nightmare Manticore (×3)
mobList[zone][246].info = {"Nightmare", "Nightmare_Manticore", nil, nil, nil} -- ( 111 )
mobList[zone][247].info = {"Nightmare", "Nightmare_Manticore", nil, nil, nil} -- ( 111 )
mobList[zone][112].info = {"Nightmare", "Nightmare_Manticore", nil, nil, nil} -- ( 112 ) Nightmare Manticore (×3)
mobList[zone][248].info = {"Nightmare", "Nightmare_Manticore", nil, nil, nil} -- ( 112 )
mobList[zone][249].info = {"Nightmare", "Nightmare_Manticore", nil, nil, nil} -- ( 112 )
mobList[zone][113].info = {"Nightmare", "Nightmare_Manticore", nil, nil, nil} -- ( 113 ) Nightmare Manticore (×3)
mobList[zone][250].info = {"Nightmare", "Nightmare_Manticore", nil, nil, nil} -- ( 113 )
mobList[zone][251].info = {"Nightmare", "Nightmare_Manticore", nil, nil, nil} -- ( 113 )
mobList[zone][114].info = {"Nightmare", "Nightmare_Manticore", nil, nil, nil} -- ( 114 ) Nightmare Manticore (×3)
mobList[zone][252].info = {"Nightmare", "Nightmare_Manticore", nil, nil, nil} -- ( 114 )
mobList[zone][253].info = {"Nightmare", "Nightmare_Manticore", nil, nil, nil} -- ( 114 )
mobList[zone][115].info = {"Nightmare", "Nightmare_Manticore", nil, nil, nil} -- ( 115 ) Nightmare Manticore (×3)
mobList[zone][254].info = {"Nightmare", "Nightmare_Manticore", nil, nil, nil} -- ( 115 )
mobList[zone][255].info = {"Nightmare", "Nightmare_Manticore", nil, nil, nil} -- ( 115 )
mobList[zone][116].info = {"Nightmare", "Nightmare_Manticore", nil, nil, nil} -- ( 116 ) Nightmare Manticore (×3)
mobList[zone][256].info = {"Nightmare", "Nightmare_Manticore", nil, nil, nil} -- ( 116 )
mobList[zone][257].info = {"Nightmare", "Nightmare_Manticore", nil, nil, nil} -- ( 116 )
mobList[zone][117].info = {"Nightmare", "Nightmare_Manticore", nil, nil, nil} -- ( 117 ) Nightmare Manticore (×3)
mobList[zone][258].info = {"Nightmare", "Nightmare_Manticore", nil, nil, nil} -- ( 117 )
mobList[zone][259].info = {"Nightmare", "Nightmare_Manticore", nil, nil, nil} -- ( 117 )
mobList[zone][118].info = {"Nightmare", "Nightmare_Manticore", nil, nil, nil} -- ( 118 ) Nightmare Manticore (×3)
mobList[zone][260].info = {"Nightmare", "Nightmare_Manticore", nil, nil, nil} -- ( 118 )
mobList[zone][261].info = {"Nightmare", "Nightmare_Manticore", nil, nil, nil} -- ( 118 )
mobList[zone][119].info = {"Nightmare", "Nightmare_Manticore", nil, nil, nil} -- ( 119 ) Nightmare Manticore (×4)
mobList[zone][262].info = {"Nightmare", "Nightmare_Manticore", nil, nil, nil} -- ( 119 )
mobList[zone][263].info = {"Nightmare", "Nightmare_Manticore", nil, nil, nil} -- ( 119 )
mobList[zone][264].info = {"Nightmare", "Nightmare_Manticore", nil, nil, nil} -- ( 119 )
mobList[zone][120].info = {"Nightmare", "Nightmare_Manticore", nil, nil, nil} -- ( 120 ) Nightmare Manticore (×3)
mobList[zone][265].info = {"Nightmare", "Nightmare_Manticore", nil, nil, nil} -- ( 120 )
mobList[zone][266].info = {"Nightmare", "Nightmare_Manticore", nil, nil, nil} -- ( 120 )
mobList[zone][121].info = {"Nightmare", "Nightmare_Manticore", nil, nil, nil} -- ( 121 ) Nightmare Manticore (×3)
mobList[zone][267].info = {"Nightmare", "Nightmare_Manticore", nil, nil, nil} -- ( 121 )
mobList[zone][268].info = {"Nightmare", "Nightmare_Manticore", nil, nil, nil} -- ( 121 )
mobList[zone][122].info = {"Nightmare", "Nightmare_Manticore", nil, nil, nil} -- ( 122 ) Nightmare Manticore (×3)
mobList[zone][269].info = {"Nightmare", "Nightmare_Manticore", nil, nil, nil} -- ( 122 )
mobList[zone][270].info = {"Nightmare", "Nightmare_Manticore", nil, nil, nil} -- ( 122 )
mobList[zone][123].info = {"Nightmare", "Nightmare_Manticore", nil, nil, nil} -- ( 123 ) Nightmare Manticore (×4)
mobList[zone][271].info = {"Nightmare", "Nightmare_Manticore", nil, nil, nil} -- ( 123 )
mobList[zone][272].info = {"Nightmare", "Nightmare_Manticore", nil, nil, nil} -- ( 123 )
mobList[zone][273].info = {"Nightmare", "Nightmare_Manticore", nil, nil, nil} -- ( 123 )
mobList[zone][124].info = {"Nightmare", "Nightmare_Manticore", nil, nil, nil} -- ( 124 ) Nightmare Manticore (×4)
mobList[zone][274].info = {"Nightmare", "Nightmare_Manticore", nil, nil, nil} -- ( 124 )
mobList[zone][275].info = {"Nightmare", "Nightmare_Manticore", nil, nil, nil} -- ( 124 )
mobList[zone][276].info = {"Nightmare", "Nightmare_Manticore", nil, nil, nil} -- ( 124 )
-- Goobbue NM Area
mobList[zone][125].info = {"Nightmare", "Nightmare_Manticore",  nil, nil, nil} -- ( 125 ) Nightmare Manticore (×3)
mobList[zone][277].info = {"Nightmare", "Nightmare_Manticore",  nil, nil, nil} -- ( 125 )
mobList[zone][278].info = {"Nightmare", "Nightmare_Manticore",  nil, nil, nil} -- ( 125 )
mobList[zone][126].info = {"Nightmare", "Nightmare_Manticore",  nil, nil, nil} -- ( 126 ) Nightmare Manticore (×3)
mobList[zone][279].info = {"Nightmare", "Nightmare_Manticore",  nil, nil, nil} -- ( 126 )
mobList[zone][280].info = {"Nightmare", "Nightmare_Manticore",  nil, nil, nil} -- ( 126 )
mobList[zone][127].info = {"Nightmare", "Nightmare_Manticore",  nil, nil, nil} -- ( 127 ) Nightmare Manticore (×3)
mobList[zone][281].info = {"Nightmare", "Nightmare_Manticore",  nil, nil, nil} -- ( 127 )
mobList[zone][282].info = {"Nightmare", "Nightmare_Manticore",  nil, nil, nil} -- ( 127 )
mobList[zone][128].info = {"Nightmare", "Nightmare_Sabotender", nil, nil, nil} -- ( 128 ) Nightmare Sabotender (×3)
mobList[zone][283].info = {"Nightmare", "Nightmare_Sabotender", nil, nil, nil} -- ( 128 )
mobList[zone][284].info = {"Nightmare", "Nightmare_Sabotender", nil, nil, nil} -- ( 128 )
mobList[zone][129].info = {"Nightmare", "Nightmare_Sabotender", nil, nil, nil} -- ( 129 ) Nightmare Sabotender (×3)
mobList[zone][285].info = {"Nightmare", "Nightmare_Sabotender", nil, nil, nil} -- ( 129 )
mobList[zone][286].info = {"Nightmare", "Nightmare_Sabotender", nil, nil, nil} -- ( 129 )

-- Wave 3 Sheep Sands and Treant NM Area
-- Nightmare Mobs + NMs Based on https://enedin.be/dyna/html/zone/frame_val2.htm
-- Nightmare Mobs
mobList[zone][87 ].info = {"Nightmare", "Nightmare_Sheep", nil, nil, nil} -- ( 087 ) Nightmare Sheep (×3)
mobList[zone][212].info = {"Nightmare", "Nightmare_Sheep", nil, nil, nil} -- ( 087 )
mobList[zone][213].info = {"Nightmare", "Nightmare_Sheep", nil, nil, nil} -- ( 087 )
mobList[zone][88 ].info = {"Nightmare", "Nightmare_Sheep", nil, nil, nil} -- ( 088 ) Nightmare Sheep (×3)
mobList[zone][214].info = {"Nightmare", "Nightmare_Sheep", nil, nil, nil} -- ( 088 )
mobList[zone][215].info = {"Nightmare", "Nightmare_Sheep", nil, nil, nil} -- ( 088 )
mobList[zone][89 ].info = {"Nightmare", "Nightmare_Sheep", nil, nil, nil} -- ( 089 ) Nightmare Sheep (×3)
mobList[zone][216].info = {"Nightmare", "Nightmare_Sheep", nil, nil, nil} -- ( 089 )
mobList[zone][217].info = {"Nightmare", "Nightmare_Sheep", nil, nil, nil} -- ( 089 )
mobList[zone][90 ].info = {"Nightmare", "Nightmare_Sheep", nil, nil, nil} -- ( 090 ) Nightmare Sheep (×3)
mobList[zone][218].info = {"Nightmare", "Nightmare_Sheep", nil, nil, nil} -- ( 090 )
mobList[zone][219].info = {"Nightmare", "Nightmare_Sheep", nil, nil, nil} -- ( 090 )
mobList[zone][91 ].info = {"Nightmare", "Nightmare_Sheep", nil, nil, nil} -- ( 091 ) Nightmare Sheep (×3)
mobList[zone][220].info = {"Nightmare", "Nightmare_Sheep", nil, nil, nil} -- ( 091 )
mobList[zone][221].info = {"Nightmare", "Nightmare_Sheep", nil, nil, nil} -- ( 091 )
mobList[zone][92 ].info = {"Nightmare", "Nightmare_Sheep", nil, nil, nil} -- ( 092 ) Nightmare Sheep (×3)
mobList[zone][222].info = {"Nightmare", "Nightmare_Sheep", nil, nil, nil} -- ( 092 )
mobList[zone][223].info = {"Nightmare", "Nightmare_Sheep", nil, nil, nil} -- ( 092 )
mobList[zone][93 ].info = {"Nightmare", "Nightmare_Sheep", nil, nil, nil} -- ( 093 ) Nightmare Sheep (×2)
mobList[zone][224].info = {"Nightmare", "Nightmare_Sheep", nil, nil, nil} -- ( 093 )
mobList[zone][94 ].info = {"Nightmare", "Nightmare_Sheep", nil, nil, nil} -- ( 094 ) Nightmare Sheep (×2)
mobList[zone][225].info = {"Nightmare", "Nightmare_Sheep", nil, nil, nil} -- ( 094 )
mobList[zone][95 ].info = {"Nightmare", "Nightmare_Sheep", nil, nil, nil} -- ( 095 ) Nightmare Sheep (×2)
mobList[zone][226].info = {"Nightmare", "Nightmare_Sheep", nil, nil, nil} -- ( 095 )
mobList[zone][96 ].info = {"Nightmare", "Nightmare_Sheep", nil, nil, nil} -- ( 096 ) Nightmare Sheep (×2)
mobList[zone][227].info = {"Nightmare", "Nightmare_Sheep", nil, nil, nil} -- ( 096 )
mobList[zone][97 ].info = {"Nightmare", "Nightmare_Sheep", nil, nil, nil} -- ( 097 ) Nightmare Sheep (×2)
mobList[zone][228].info = {"Nightmare", "Nightmare_Sheep", nil, nil, nil} -- ( 097 )
mobList[zone][98 ].info = {"Nightmare", "Nightmare_Sheep", nil, nil, nil} -- ( 098 ) Nightmare Sheep (×2)
mobList[zone][229].info = {"Nightmare", "Nightmare_Sheep", nil, nil, nil} -- ( 098 )
mobList[zone][99 ].info = {"Nightmare", "Nightmare_Sheep", nil, nil, nil} -- ( 099 ) Nightmare Sheep (×2)
mobList[zone][230].info = {"Nightmare", "Nightmare_Sheep", nil, nil, nil} -- ( 099 )
mobList[zone][100].info = {"Nightmare", "Nightmare_Sheep", nil, nil, nil} -- ( 100 ) Nightmare Sheep (×2)
mobList[zone][231].info = {"Nightmare", "Nightmare_Sheep", nil, nil, nil} -- ( 100 )
mobList[zone][101].info = {"Nightmare", "Nightmare_Sheep", nil, nil, nil} -- ( 101 ) Nightmare Sheep (×2)
mobList[zone][232].info = {"Nightmare", "Nightmare_Sheep", nil, nil, nil} -- ( 101 )
mobList[zone][102].info = {"Nightmare", "Nightmare_Sheep", nil, nil, nil} -- ( 102 ) Nightmare Sheep (×2)
mobList[zone][233].info = {"Nightmare", "Nightmare_Sheep", nil, nil, nil} -- ( 102 )
mobList[zone][103].info = {"Nightmare", "Nightmare_Sheep", nil, nil, nil} -- ( 103 ) Nightmare Sheep (×2)
mobList[zone][234].info = {"Nightmare", "Nightmare_Sheep", nil, nil, nil} -- ( 103 )
mobList[zone][104].info = {"Nightmare", "Nightmare_Sheep", nil, nil, nil} -- ( 104 ) Nightmare Sheep (×2)
mobList[zone][235].info = {"Nightmare", "Nightmare_Sheep", nil, nil, nil} -- ( 104 )
mobList[zone][105].info = {"Nightmare", "Nightmare_Sheep", nil, nil, nil} -- ( 105 ) Nightmare Sheep (×2)
mobList[zone][236].info = {"Nightmare", "Nightmare_Sheep", nil, nil, nil} -- ( 105 )
mobList[zone][106].info = {"Nightmare", "Nightmare_Sheep", nil, nil, nil} -- ( 106 ) Nightmare Sheep (×2)
mobList[zone][237].info = {"Nightmare", "Nightmare_Sheep", nil, nil, nil} -- ( 106 )
mobList[zone][107].info = {"Nightmare", "Nightmare_Sheep", nil, nil, nil} -- ( 107 ) Nightmare Sheep (×3)
mobList[zone][238].info = {"Nightmare", "Nightmare_Sheep", nil, nil, nil} -- ( 107 )
mobList[zone][239].info = {"Nightmare", "Nightmare_Sheep", nil, nil, nil} -- ( 107 )
mobList[zone][108].info = {"Nightmare", "Nightmare_Sheep", nil, nil, nil} -- ( 108 ) Nightmare Sheep (×3)
mobList[zone][240].info = {"Nightmare", "Nightmare_Sheep", nil, nil, nil} -- ( 108 )
mobList[zone][241].info = {"Nightmare", "Nightmare_Sheep", nil, nil, nil} -- ( 108 )
mobList[zone][109].info = {"Nightmare", "Nightmare_Sheep", nil, nil, nil} -- ( 109 ) Nightmare Sheep (×3)
mobList[zone][242].info = {"Nightmare", "Nightmare_Sheep", nil, nil, nil} -- ( 109 )
mobList[zone][243].info = {"Nightmare", "Nightmare_Sheep", nil, nil, nil} -- ( 109 )

-- Wave 4 Hippogryph Sands and Flytrap NM Area
-- Nightmare Mobs + NMs Based on https://enedin.be/dyna/html/zone/frame_val2.htm
-- Nightmare Mobs
-- Hippogryph Sands
mobList[zone][59 ].info = {"Nightmare", "Nightmare_Hippogryph", nil, nil, nil} -- ( 059 ) Nightmare Hippogryph (×3)
mobList[zone][156].info = {"Nightmare", "Nightmare_Hippogryph", nil, nil, nil} -- ( 059 )
mobList[zone][157].info = {"Nightmare", "Nightmare_Hippogryph", nil, nil, nil} -- ( 059 )
mobList[zone][60 ].info = {"Nightmare", "Nightmare_Hippogryph", nil, nil, nil} -- ( 060 ) Nightmare Hippogryph (×3)
mobList[zone][158].info = {"Nightmare", "Nightmare_Hippogryph", nil, nil, nil} -- ( 060 )
mobList[zone][159].info = {"Nightmare", "Nightmare_Hippogryph", nil, nil, nil} -- ( 060 )
mobList[zone][61 ].info = {"Nightmare", "Nightmare_Hippogryph", nil, nil, nil} -- ( 061 ) Nightmare Hippogryph (×3)
mobList[zone][160].info = {"Nightmare", "Nightmare_Hippogryph", nil, nil, nil} -- ( 061 )
mobList[zone][161].info = {"Nightmare", "Nightmare_Hippogryph", nil, nil, nil} -- ( 061 )
mobList[zone][62 ].info = {"Nightmare", "Nightmare_Hippogryph", nil, nil, nil} -- ( 062 ) Nightmare Hippogryph (×3)
mobList[zone][162].info = {"Nightmare", "Nightmare_Hippogryph", nil, nil, nil} -- ( 062 )
mobList[zone][163].info = {"Nightmare", "Nightmare_Hippogryph", nil, nil, nil} -- ( 062 )
mobList[zone][63 ].info = {"Nightmare", "Nightmare_Hippogryph", nil, nil, nil} -- ( 063 ) Nightmare Hippogryph (×3)
mobList[zone][164].info = {"Nightmare", "Nightmare_Hippogryph", nil, nil, nil} -- ( 063 )
mobList[zone][165].info = {"Nightmare", "Nightmare_Hippogryph", nil, nil, nil} -- ( 063 )
mobList[zone][64 ].info = {"Nightmare", "Nightmare_Hippogryph", nil, nil, nil} -- ( 064 ) Nightmare Hippogryph (×3)
mobList[zone][166].info = {"Nightmare", "Nightmare_Hippogryph", nil, nil, nil} -- ( 064 )
mobList[zone][167].info = {"Nightmare", "Nightmare_Hippogryph", nil, nil, nil} -- ( 064 )
mobList[zone][65 ].info = {"Nightmare", "Nightmare_Hippogryph", nil, nil, nil} -- ( 065 ) Nightmare Hippogryph (×3)
mobList[zone][168].info = {"Nightmare", "Nightmare_Hippogryph", nil, nil, nil} -- ( 065 )
mobList[zone][169].info = {"Nightmare", "Nightmare_Hippogryph", nil, nil, nil} -- ( 065 )
mobList[zone][66 ].info = {"Nightmare", "Nightmare_Hippogryph", nil, nil, nil} -- ( 066 ) Nightmare Hippogryph (×3)
mobList[zone][170].info = {"Nightmare", "Nightmare_Hippogryph", nil, nil, nil} -- ( 066 )
mobList[zone][171].info = {"Nightmare", "Nightmare_Hippogryph", nil, nil, nil} -- ( 066 )
mobList[zone][67 ].info = {"Nightmare", "Nightmare_Hippogryph", nil, nil, nil} -- ( 067 ) Nightmare Hippogryph (×3)
mobList[zone][172].info = {"Nightmare", "Nightmare_Hippogryph", nil, nil, nil} -- ( 067 )
mobList[zone][173].info = {"Nightmare", "Nightmare_Hippogryph", nil, nil, nil} -- ( 067 )
mobList[zone][68 ].info = {"Nightmare", "Nightmare_Hippogryph", nil, nil, nil} -- ( 068 ) Nightmare Hippogryph (×3)
mobList[zone][174].info = {"Nightmare", "Nightmare_Hippogryph", nil, nil, nil} -- ( 068 )
mobList[zone][175].info = {"Nightmare", "Nightmare_Hippogryph", nil, nil, nil} -- ( 068 )
mobList[zone][69 ].info = {"Nightmare", "Nightmare_Hippogryph", nil, nil, nil} -- ( 069 ) Nightmare Hippogryph (×3)
mobList[zone][176].info = {"Nightmare", "Nightmare_Hippogryph", nil, nil, nil} -- ( 069 )
mobList[zone][177].info = {"Nightmare", "Nightmare_Hippogryph", nil, nil, nil} -- ( 069 )
mobList[zone][70 ].info = {"Nightmare", "Nightmare_Hippogryph", nil, nil, nil} -- ( 070 ) Nightmare Hippogryph (×3)
mobList[zone][178].info = {"Nightmare", "Nightmare_Hippogryph", nil, nil, nil} -- ( 070 )
mobList[zone][179].info = {"Nightmare", "Nightmare_Hippogryph", nil, nil, nil} -- ( 070 )
mobList[zone][71 ].info = {"Nightmare", "Nightmare_Hippogryph", nil, nil, nil} -- ( 071 ) Nightmare Hippogryph (×3)
mobList[zone][180].info = {"Nightmare", "Nightmare_Hippogryph", nil, nil, nil} -- ( 071 )
mobList[zone][181].info = {"Nightmare", "Nightmare_Hippogryph", nil, nil, nil} -- ( 071 )
mobList[zone][72 ].info = {"Nightmare", "Nightmare_Hippogryph", nil, nil, nil} -- ( 072 ) Nightmare Hippogryph (×3)
mobList[zone][182].info = {"Nightmare", "Nightmare_Hippogryph", nil, nil, nil} -- ( 072 )
mobList[zone][183].info = {"Nightmare", "Nightmare_Hippogryph", nil, nil, nil} -- ( 072 )
mobList[zone][73 ].info = {"Nightmare", "Nightmare_Hippogryph", nil, nil, nil} -- ( 073 ) Nightmare Hippogryph (×3)
mobList[zone][184].info = {"Nightmare", "Nightmare_Hippogryph", nil, nil, nil} -- ( 073 )
mobList[zone][185].info = {"Nightmare", "Nightmare_Hippogryph", nil, nil, nil} -- ( 073 )
mobList[zone][74 ].info = {"Nightmare", "Nightmare_Sabotender", nil, nil, nil} -- ( 074 ) Nightmare Sabotender (×3)
mobList[zone][186].info = {"Nightmare", "Nightmare_Sabotender", nil, nil, nil} -- ( 074 )
mobList[zone][187].info = {"Nightmare", "Nightmare_Sabotender", nil, nil, nil} -- ( 074 )
mobList[zone][75 ].info = {"Nightmare", "Nightmare_Sabotender", nil, nil, nil} -- ( 075 ) Nightmare Sabotender (×3)
mobList[zone][188].info = {"Nightmare", "Nightmare_Sabotender", nil, nil, nil} -- ( 075 )
mobList[zone][189].info = {"Nightmare", "Nightmare_Sabotender", nil, nil, nil} -- ( 075 )
mobList[zone][76 ].info = {"Nightmare", "Nightmare_Sabotender", nil, nil, nil} -- ( 076 ) Nightmare Sabotender (×3)
mobList[zone][190].info = {"Nightmare", "Nightmare_Sabotender", nil, nil, nil} -- ( 076 )
mobList[zone][191].info = {"Nightmare", "Nightmare_Sabotender", nil, nil, nil} -- ( 076 )
mobList[zone][77 ].info = {"Nightmare", "Nightmare_Sabotender", nil, nil, nil} -- ( 077 ) Nightmare Sabotender (×3)
mobList[zone][192].info = {"Nightmare", "Nightmare_Sabotender", nil, nil, nil} -- ( 077 )
mobList[zone][193].info = {"Nightmare", "Nightmare_Sabotender", nil, nil, nil} -- ( 077 )
mobList[zone][78 ].info = {"Nightmare", "Nightmare_Sabotender", nil, nil, nil} -- ( 078 ) Nightmare Sabotender (×3)
mobList[zone][194].info = {"Nightmare", "Nightmare_Sabotender", nil, nil, nil} -- ( 078 )
mobList[zone][195].info = {"Nightmare", "Nightmare_Sabotender", nil, nil, nil} -- ( 078 )
mobList[zone][79 ].info = {"Nightmare", "Nightmare_Sabotender", nil, nil, nil} -- ( 079 ) Nightmare Sabotender (×3)
mobList[zone][196].info = {"Nightmare", "Nightmare_Sabotender", nil, nil, nil} -- ( 079 )
mobList[zone][197].info = {"Nightmare", "Nightmare_Sabotender", nil, nil, nil} -- ( 079 )
mobList[zone][80 ].info = {"Nightmare", "Nightmare_Sabotender", nil, nil, nil} -- ( 080 ) Nightmare Sabotender (×3)
mobList[zone][198].info = {"Nightmare", "Nightmare_Sabotender", nil, nil, nil} -- ( 080 )
mobList[zone][199].info = {"Nightmare", "Nightmare_Sabotender", nil, nil, nil} -- ( 080 )
mobList[zone][81 ].info = {"Nightmare", "Nightmare_Sabotender", nil, nil, nil} -- ( 081 ) Nightmare Sabotender (×3)
mobList[zone][200].info = {"Nightmare", "Nightmare_Sabotender", nil, nil, nil} -- ( 081 )
mobList[zone][201].info = {"Nightmare", "Nightmare_Sabotender", nil, nil, nil} -- ( 081 )
mobList[zone][82 ].info = {"Nightmare", "Nightmare_Sabotender", nil, nil, nil} -- ( 082 ) Nightmare Sabotender (×3)
mobList[zone][202].info = {"Nightmare", "Nightmare_Sabotender", nil, nil, nil} -- ( 082 )
mobList[zone][203].info = {"Nightmare", "Nightmare_Sabotender", nil, nil, nil} -- ( 082 )
-- Flytrap NM Area
mobList[zone][8 3].info = {"Nightmare", "Nightmare_Sabotender", nil, nil, nil} -- ( 083 ) Nightmare Sabotender (×3)
mobList[zone][204].info = {"Nightmare", "Nightmare_Sabotender", nil, nil, nil} -- ( 083 )
mobList[zone][205].info = {"Nightmare", "Nightmare_Sabotender", nil, nil, nil} -- ( 083 )
mobList[zone][84 ].info = {"Nightmare", "Nightmare_Hippogryph", nil, nil, nil} -- ( 084 ) Nightmare Hippogryph (×3)
mobList[zone][206].info = {"Nightmare", "Nightmare_Hippogryph", nil, nil, nil} -- ( 084 )
mobList[zone][207].info = {"Nightmare", "Nightmare_Hippogryph", nil, nil, nil} -- ( 084 )
mobList[zone][85 ].info = {"Nightmare", "Nightmare_Hippogryph", nil, nil, nil} -- ( 085 ) Nightmare Hippogryph (×3)
mobList[zone][208].info = {"Nightmare", "Nightmare_Hippogryph", nil, nil, nil} -- ( 085 )
mobList[zone][209].info = {"Nightmare", "Nightmare_Hippogryph", nil, nil, nil} -- ( 085 )
mobList[zone][86 ].info = {"Nightmare", "Nightmare_Hippogryph", nil, nil, nil} -- ( 086 ) Nightmare Hippogryph (×3)
mobList[zone][210].info = {"Nightmare", "Nightmare_Hippogryph", nil, nil, nil} -- ( 086 )
mobList[zone][211].info = {"Nightmare", "Nightmare_Hippogryph", nil, nil, nil} -- ( 086 )

-- Wave 5 Statues based on https://enedin.be/dyna/html/zone/frame_val2.htm
-- Outpost Area
mobList[zone][33 ].info = {"Statue", "Manifest_Icon",       "Yagudo", nil, nil}   -- (033-Y)
mobList[zone][34 ].info = {"Statue", "Manifest_Icon",       "Yagudo", nil, nil}   -- (034-Y)
mobList[zone][35 ].info = {"Statue", "Manifest_Icon",       "Yagudo", nil, nil}   -- (035-Y)
mobList[zone][36 ].info = {"Statue", "Manifest_Icon",       "Yagudo", nil, nil}   -- (036-Y)
mobList[zone][37 ].info = {"Statue", "Manifest_Icon",       "Yagudo", nil, nil}   -- (037-Y)
mobList[zone][38 ].info = {"Statue", "Goblin_Replica",      "Goblin", nil, nil}   -- (038-G)
mobList[zone][39 ].info = {"Statue", "Goblin_Replica",      "Goblin", nil, nil}   -- (039-G)
mobList[zone][40 ].info = {"Statue", "Goblin_Replica",      "Goblin", nil, nil}   -- (040-G)
mobList[zone][41 ].info = {"Statue", "Goblin_Replica",      "Goblin", nil, nil}   -- (041-G)
mobList[zone][42 ].info = {"Statue", "Goblin_Replica",      "Goblin", nil, nil}   -- (042-G)
mobList[zone][43 ].info = {"Statue", "Sergeant_Tombstone",  "Orc",    nil, nil}   -- (043-O)
mobList[zone][44 ].info = {"Statue", "Sergeant_Tombstone",  "Orc",    nil, nil}   -- (044-O)
mobList[zone][45 ].info = {"Statue", "Sergeant_Tombstone",  "Orc",    nil, nil}   -- (045-O)
mobList[zone][46 ].info = {"Statue", "Sergeant_Tombstone",  "Orc",    nil, nil}   -- (046-O)
mobList[zone][47 ].info = {"Statue", "Sergeant_Tombstone",  "Orc",    nil, nil}   -- (047-O)
mobList[zone][48 ].info = {"Statue", "Adamanking_Effigy",   "Quadav", nil, nil}   -- (048-Q)
mobList[zone][49 ].info = {"Statue", "Adamanking_Effigy",   "Quadav", nil, nil}   -- (049-Q)
mobList[zone][50 ].info = {"Statue", "Adamanking_Effigy",   "Quadav", nil, nil}   -- (050-Q)
mobList[zone][51 ].info = {"Statue", "Adamanking_Effigy",   "Quadav", nil, nil}   -- (051-Q)
mobList[zone][52 ].info = {"Statue", "Adamanking_Effigy",   "Quadav", nil, nil}   -- (052-Q)

-- Wave 5 Outpost Area
-- Nightmare Mobs based on https://enedin.be/dyna/html/zone/frame_val2.htm
-- Nightmare Mobs
mobList[zone][53 ].info = {"Nightmare", "Nightmare_Sabotender", nil, nil, nil} -- ( 053 ) Nightmare Sabotender (×3)
mobList[zone][144].info = {"Nightmare", "Nightmare_Sabotender", nil, nil, nil} -- ( 053 )
mobList[zone][145].info = {"Nightmare", "Nightmare_Sabotender", nil, nil, nil} -- ( 053 )
mobList[zone][54 ].info = {"Nightmare", "Nightmare_Sabotender", nil, nil, nil} -- ( 054 ) Nightmare Sabotender (×3)
mobList[zone][146].info = {"Nightmare", "Nightmare_Sabotender", nil, nil, nil} -- ( 054 )
mobList[zone][147].info = {"Nightmare", "Nightmare_Sabotender", nil, nil, nil} -- ( 054 )
mobList[zone][55 ].info = {"Nightmare", "Nightmare_Sabotender", nil, nil, nil} -- ( 055 ) Nightmare Sabotender (×3)
mobList[zone][148].info = {"Nightmare", "Nightmare_Sabotender", nil, nil, nil} -- ( 055 )
mobList[zone][149].info = {"Nightmare", "Nightmare_Sabotender", nil, nil, nil} -- ( 055 )
mobList[zone][56 ].info = {"Nightmare", "Nightmare_Sabotender", nil, nil, nil} -- ( 056 ) Nightmare Sabotender (×3)
mobList[zone][150].info = {"Nightmare", "Nightmare_Sabotender", nil, nil, nil} -- ( 056 )
mobList[zone][151].info = {"Nightmare", "Nightmare_Sabotender", nil, nil, nil} -- ( 056 )
mobList[zone][57 ].info = {"Nightmare", "Nightmare_Sabotender", nil, nil, nil} -- ( 057 ) Nightmare Sabotender (×3)
mobList[zone][152].info = {"Nightmare", "Nightmare_Sabotender", nil, nil, nil} -- ( 057 )
mobList[zone][153].info = {"Nightmare", "Nightmare_Sabotender", nil, nil, nil} -- ( 057 )
mobList[zone][58 ].info = {"Nightmare", "Nightmare_Sabotender", nil, nil, nil} -- ( 058 ) Nightmare Sabotender (×3)
mobList[zone][154].info = {"Nightmare", "Nightmare_Sabotender", nil, nil, nil} -- ( 058 )
mobList[zone][155].info = {"Nightmare", "Nightmare_Sabotender", nil, nil, nil} -- ( 058 )

----------------------------------------------------------------------------------------------------
--                                    Setup of Wave Spawning                                      --
----------------------------------------------------------------------------------------------------

---------------------------------------------
--           Wave Defeat Reqs.          --
--------------------------------------------
--mobList[zone].waveDefeatRequirements[2] = {zone:getLocalVar("MegaBoss_Killed") == 1}

mobList[zone].waveDefeatRequirements[2] = { zone:getLocalVar("MegaBoss_Killed") == 1 } -- Spawns Nightmare Mobs

------------------------------------------
--            Wave Spawning             --
-- Note: Wave 1 spawns at start.        --
------------------------------------------
--mobList[zone].wave# = { MobIndex#1, MobIndex#2, MobIndex#3 }

mobList[zone].wave1 = {
    21 , -- ( 021 ) Recover subjobs
    22 , -- ( 022 ) Recover subjobs
    23 , -- ( 023 ) Recover subjobs
    5  , -- ( 005 ) Fairy Ring
    10 , -- ( 010 ) Flytrap NMs
    15 , -- ( 015 ) Stcemqestcint
    20 , -- ( 020 ) Nant'ina
    24 , -- ( 024 ) Cirrate Christelle
    25 , -- (025-G)
    26 , -- (026-Y)
    27 , -- (027-Q)
    28 , -- (028-O)
    29 , -- ( 029 ) Nightmare Manticore (×3)
    30 , -- ( 030 ) Nightmare Hippogryph (×3)
    31 , -- ( 031 ) Nightmare Sabotender (×3)
    1  , -- (001-Y)
    2  , -- (002-Y)
    3  , -- (003-Y)
    4  , -- (004-Y)
    6  , -- (006-G)
    7  , -- (007-G)
    8  , -- (008-G)
    9  , -- (009-G)
    11 , -- (011-O)
    12 , -- (012-O)
    13 , -- (013-O)
    14 , -- (014-O)
    16 , -- (016-Q)
    17 , -- (017-Q)
    18 , -- (018-Q)
    19 , -- (019-Q)
    110, -- ( 110 ) Nightmare Manticore (×3)
    111, -- ( 111 ) Nightmare Manticore (×3)
    112, -- ( 112 ) Nightmare Manticore (×3)
    113, -- ( 113 ) Nightmare Manticore (×3)
    114, -- ( 114 ) Nightmare Manticore (×3)
    115, -- ( 115 ) Nightmare Manticore (×3)
    116, -- ( 116 ) Nightmare Manticore (×3)
    117, -- ( 117 ) Nightmare Manticore (×3)
    118, -- ( 118 ) Nightmare Manticore (×3)
    119, -- ( 119 ) Nightmare Manticore (×4)
    120, -- ( 120 ) Nightmare Manticore (×3)
    121, -- ( 121 ) Nightmare Manticore (×3)
    122, -- ( 122 ) Nightmare Manticore (×3)
    123, -- ( 123 ) Nightmare Manticore (×4)
    124, -- ( 124 ) Nightmare Manticore (×4)
    125, -- ( 125 ) Nightmare Manticore (×3)
    126, -- ( 126 ) Nightmare Manticore (×3)
    127, -- ( 127 ) Nightmare Manticore (×3)
    128, -- ( 128 ) Nightmare Sabotender (×3)
    129, -- ( 129 ) Nightmare Sabotender (×3)
    87 , -- ( 087 ) Nightmare Sheep (×3)
    88 , -- ( 088 ) Nightmare Sheep (×3)
    89 , -- ( 089 ) Nightmare Sheep (×3)
    90 , -- ( 090 ) Nightmare Sheep (×3)
    91 , -- ( 091 ) Nightmare Sheep (×3)
    92 , -- ( 092 ) Nightmare Sheep (×3)
    93 , -- ( 093 ) Nightmare Sheep (×2)
    94 , -- ( 094 ) Nightmare Sheep (×2)
    95 , -- ( 095 ) Nightmare Sheep (×2)
    96 , -- ( 096 ) Nightmare Sheep (×2)
    97 , -- ( 097 ) Nightmare Sheep (×2)
    98 , -- ( 098 ) Nightmare Sheep (×2)
    99 , -- ( 099 ) Nightmare Sheep (×2)
    100, -- ( 100 ) Nightmare Sheep (×2)
    101, -- ( 101 ) Nightmare Sheep (×2)
    102, -- ( 102 ) Nightmare Sheep (×2)
    103, -- ( 103 ) Nightmare Sheep (×2)
    104, -- ( 104 ) Nightmare Sheep (×2)
    105, -- ( 105 ) Nightmare Sheep (×2)
    106, -- ( 106 ) Nightmare Sheep (×2)
    107, -- ( 107 ) Nightmare Sheep (×3)
    108, -- ( 108 ) Nightmare Sheep (×3)
    109, -- ( 109 ) Nightmare Sheep (×3)
    59 , -- ( 059 ) Nightmare Hippogryph (×3)
    60 , -- ( 060 ) Nightmare Hippogryph (×3)
    61 , -- ( 061 ) Nightmare Hippogryph (×3)
    62 , -- ( 062 ) Nightmare Hippogryph (×3)
    63 , -- ( 063 ) Nightmare Hippogryph (×3)
    64 , -- ( 064 ) Nightmare Hippogryph (×3)
    65 , -- ( 065 ) Nightmare Hippogryph (×3)
    66 , -- ( 066 ) Nightmare Hippogryph (×3)
    67 , -- ( 067 ) Nightmare Hippogryph (×3)
    68 , -- ( 068 ) Nightmare Hippogryph (×3)
    69 , -- ( 069 ) Nightmare Hippogryph (×3)
    70 , -- ( 070 ) Nightmare Hippogryph (×3)
    71 , -- ( 071 ) Nightmare Hippogryph (×3)
    72 , -- ( 072 ) Nightmare Hippogryph (×3)
    73 , -- ( 073 ) Nightmare Hippogryph (×3)
    74 , -- ( 074 ) Nightmare Sabotender (×3)
    75 , -- ( 075 ) Nightmare Sabotender (×3)
    76 , -- ( 076 ) Nightmare Sabotender (×3)
    77 , -- ( 077 ) Nightmare Sabotender (×3)
    78 , -- ( 078 ) Nightmare Sabotender (×3)
    79 , -- ( 079 ) Nightmare Sabotender (×3)
    80 , -- ( 080 ) Nightmare Sabotender (×3)
    81 , -- ( 081 ) Nightmare Sabotender (×3)
    82 , -- ( 082 ) Nightmare Sabotender (×3)
    83 , -- ( 083 ) Nightmare Sabotender (×3)
    84 , -- ( 084 ) Nightmare Hippogryph (×3)
    85 , -- ( 085 ) Nightmare Hippogryph (×3)
    86 , -- ( 086 ) Nightmare Hippogryph (×3)
}

mobList[zone].wave2 = {
    76 , --  ( 076 ) Nightmare Weapon (×3)
    77 , --  ( 077 ) Nightmare Weapon (×3)
    78 , --  ( 078 ) Nightmare Weapon (×3)
    79 , --  ( 079 ) Nightmare Weapon (×3)
    80 , --  ( 080 ) Nightmare Weapon (×3)
    81 , --  ( 081 ) Nightmare Weapon (×3)
    82 , --  ( 082 ) Nightmare Weapon (×3)
    83 , --  ( 083 ) Nightmare Weapon (×3)
    84 , --  ( 084 ) Nightmare Weapon (×3)
    85 , --  ( 085 ) Nightmare Weapon (×3)
    86 , --  ( 086 ) Nightmare Kraken (×2)
    87 , --  ( 087 ) Nightmare Kraken (×2)
    88 , --  ( 088 ) Nightmare Kraken (×2)
    89 , --  ( 089 ) Nightmare Kraken (×2)
    90 , --  ( 090 ) Nightmare Kraken (×2)
    91 , --  ( 091 ) Nightmare Kraken (×2)
    92 , --  ( 092 ) Nightmare Kraken (×2)
    93 , --  ( 093 ) Nightmare Kraken (×2)
    94 , --  ( 094 ) Nightmare Kraken (×2)
    95 , --  ( 095 ) Nightmare Kraken (×2)
    96 , --  ( 096 ) Nightmare Kraken (×2)
    97 , --  ( 097 ) Nightmare Kraken (×2)
    98 , --  ( 098 ) Nightmare Kraken (×3)
    99 , --  ( 099 ) Nightmare Tiger (×4)
    100, --  ( 100 ) Nightmare Tiger (×4)
    101, --  ( 101 ) Nightmare Tiger (×4)
    102, --  ( 102 ) Nightmare Tiger (×5)
    103, --  ( 103 ) Nightmare Tiger (×5)
    104, --  ( 104 ) Nightmare Tiger (×5)
    105, --  ( 105 ) Nightmare Tiger (×5)
    106, --  ( 106 ) Nightmare Raptor (×2)
    107, --  ( 107 ) Nightmare Raptor (×2)
    108, --  ( 108 ) Nightmare Raptor (×2)
    109, --  ( 109 ) Nightmare Raptor (×2)
    110, --  ( 110 ) Nightmare Raptor (×2)
    111, --  ( 111 ) Nightmare Raptor (×2)
    112, --  ( 112 ) Nightmare Raptor (×2)
    113, --  ( 113 ) Nightmare Raptor (×2)
    114, --  ( 114 ) Nightmare Raptor (×2)
    115, --  ( 115 ) Nightmare Raptor (×2)
    116, --  ( 116 ) Nightmare Raptor (×2)
    117, --  ( 117 ) Nightmare Raptor (×2)
    118, --  ( 118 ) Nightmare Diremite (×2)
    119, --  ( 119 ) Nightmare Diremite (×2)
    120, --  ( 120 ) Nightmare Diremite (×2)
    121, --  ( 121 ) Nightmare Diremite (×2)
    122, --  ( 122 ) Nightmare Diremite (×2)
    123, --  ( 123 ) Nightmare Diremite (×2)
    124, --  ( 124 ) Nightmare Diremite (×2)
    125, --  ( 125 ) Nightmare Diremite (×2)
    126, --  ( 126 ) Nightmare Diremite (×2)
    127, --  ( 127 ) Nightmare Diremite (×2)
    128, --  ( 128 ) Nightmare Diremite (×2)
    129, --  ( 129 ) Nightmare Diremite (×2)
    130, --  ( 130 ) Nightmare Diremite (×2)
    131, --  ( 131 ) Nightmare Gaylas (×3)
    132, --  ( 132 ) Nightmare Gaylas (×3)
    133, --  ( 133 ) Nightmare Gaylas (×3)
    134, --  ( 134 ) Nightmare Gaylas (×4)
    135, --  ( 135 ) Nightmare Gaylas (×4)
    136, --  ( 136 ) Nightmare Gaylas (×4)
    137, --  ( 137 ) Nightmare Gaylas (×4)
    138, --  ( 138 ) Nightmare Gaylas (×4)
    65 , --  (065-G) Goblin Replica
    66 , --  (066-G) Goblin Replica
    67 , --  (067-G) Goblin Replica
    68 , --  (068-G) Goblin Replica
    69 , --  (069-G) Goblin Replica
    70 , --  (070-G) Goblin Replica
    71 , --  (071-G) Goblin Replica
    72 , --  (072-G) Goblin Replica
    73 , --  (073-G) Goblin Replica
    74 , --  (074-G) Goblin Replica
    75   --  (075-G) Goblin Replica
}

----------------------------------------------------------------------------------------------------
--                                  Setup of Children Spawning                                    --
----------------------------------------------------------------------------------------------------
------------------------------------------
--          Normal Child Spawn          --
------------------------------------------
-- mobList[zone][MobIndex].mobchildren = {#WAR, #MNK, #WHM, #BLM, #RDM, #THF, #PLD, #DRK, #BST, #BRD, #RNG, #SAM, #NIN, #DRG, #SMN}

-- Boss Area
mobList[zone][25 ].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil,   1,   1  } -- THF, DRG, SMN (025-G)
mobList[zone][26 ].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil,   1,   1  } -- THF, DRG, SMN (026-Y)
mobList[zone][27 ].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil,   1,   1  } -- THF, DRG, SMN (027-Q)
mobList[zone][28 ].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil,   1,   1  } -- THF, DRG, SMN (028-O)
mobList[zone][1  ].mobchildren = { nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  } -- WHM, NIN, MNK (001-Y)
mobList[zone][2  ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1,   1,   1, nil, nil, nil, nil, nil  } -- BRD, BST, DRK (002-Y)
mobList[zone][3  ].mobchildren = { nil, nil, nil,   1, nil, nil,   1, nil, nil, nil, nil,   1, nil, nil, nil  } -- PLD, BLM, SAM (003-Y)
mobList[zone][4  ].mobchildren = {   1, nil, nil, nil,   1, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil  } -- WAR, RNG, RDM (004-Y)
mobList[zone][6  ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1,   1,   1, nil, nil, nil, nil, nil  } -- BRD, BST, DRK (006-G)
mobList[zone][7  ].mobchildren = { nil, nil, nil,   1, nil, nil,   1, nil, nil, nil, nil,   1, nil, nil, nil  } -- PLD, BLM, SAM (007-G)
mobList[zone][8  ].mobchildren = { nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  } -- WHM, NIN, MNK (008-G)
mobList[zone][9  ].mobchildren = {   1, nil, nil, nil,   1, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil  } -- WAR, RNG, RDM (009-G)
mobList[zone][11 ].mobchildren = { nil, nil, nil,   1, nil, nil,   1, nil, nil, nil, nil,   1, nil, nil, nil  } -- PLD, BLM, SAM (011-O)
mobList[zone][12 ].mobchildren = {   1, nil, nil, nil,   1, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil  } -- WAR, RNG, RDM (012-O)
mobList[zone][13 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1,   1,   1, nil, nil, nil, nil, nil  } -- BST, BRD, DRK (013-O)
mobList[zone][14 ].mobchildren = { nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  } -- WHM, NIN, MNK (014-O)
mobList[zone][16 ].mobchildren = { nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  } -- WHM, NIN, MNK (016-Q)
mobList[zone][17 ].mobchildren = {   1, nil, nil, nil,   1, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil  } -- WAR, RNG, RDM (017-Q)
mobList[zone][18 ].mobchildren = { nil, nil, nil,   1, nil, nil,   1, nil, nil, nil, nil,   1, nil, nil, nil  } -- PLD, BLM, SAM (018-Q)
mobList[zone][19 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1,   1,   1, nil, nil, nil, nil, nil  } -- BRD, BST, DRK (019-Q)
mobList[zone][33 ].mobchildren = {   1, nil, nil, nil,   1, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil  } -- WAR, RNG, RDM (033-Y)
mobList[zone][34 ].mobchildren = { nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  } -- WHM, NIN, MNK (034-Y)
mobList[zone][35 ].mobchildren = { nil, nil, nil,   1, nil, nil,   1, nil, nil, nil, nil,   1, nil, nil, nil  } -- PLD, BLM, SAM (035-Y)
mobList[zone][36 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1,   1,   1, nil, nil, nil, nil, nil  } -- BRD, BST, DRK (036-Y)
mobList[zone][37 ].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil,   1,   1  } -- THF, DRG, SMN (037-Y)
mobList[zone][38 ].mobchildren = {   1, nil, nil, nil,   1, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil  } -- WAR, RNG, RDM (038-G)
mobList[zone][39 ].mobchildren = { nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  } -- WHM, NIN, MNK (039-G)
mobList[zone][40 ].mobchildren = { nil, nil, nil,   1, nil, nil,   1, nil, nil, nil, nil,   1, nil, nil, nil  } -- PLD, BLM, SAM (040-G)
mobList[zone][41 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1,   1,   1, nil, nil, nil, nil, nil  } -- BRD, BST, DRK (041-G)
mobList[zone][42 ].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil,   1,   1  } -- THF, DRG, SMN (042-G)
mobList[zone][43 ].mobchildren = {   1, nil, nil, nil,   1, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil  } -- WAR, RNG, RDM (043-O)
mobList[zone][44 ].mobchildren = { nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  } -- WHM, NIN, MNK (044-O)
mobList[zone][45 ].mobchildren = { nil, nil, nil,   1, nil, nil,   1, nil, nil, nil, nil,   1, nil, nil, nil  } -- PLD, BLM, SAM (045-O)
mobList[zone][46 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1,   1,   1, nil, nil, nil, nil, nil  } -- BRD, BST, DRK (046-O)
mobList[zone][47 ].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil,   1,   1  } -- THF, DRG, SMN (047-O)
mobList[zone][48 ].mobchildren = {   1, nil, nil, nil,   1, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil  } -- WAR, RNG, RDM (048-Q)
mobList[zone][49 ].mobchildren = { nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  } -- WHM, NIN, MNK (049-Q)
mobList[zone][50 ].mobchildren = { nil, nil, nil,   1, nil, nil,   1, nil, nil, nil, nil,   1, nil, nil, nil  } -- PLD, BLM, SAM (050-Q)
mobList[zone][51 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1,   1,   1, nil, nil, nil, nil, nil  } -- BRD, BST, DRK (051-Q)
mobList[zone][52 ].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil,   1,   1  } -- THF, DRG, SMN (052-Q)

------------------------------------------
--            NM Child Spawn            --
------------------------------------------
-- mobList[zone][MobIndex].NMchildren = {MobIndex(NM1), MobIndex(NM2), MobIndex(NM3)}
-- boolean value = forceLink true/false

-- Wave 1
-- Boss Arera
mobList[zone][29 ].NMchildren = { true, 136, 137            } -- ( 029 ) Nightmare Manticore (×3)
mobList[zone][30 ].NMchildren = { true, 138, 139            } -- ( 030 ) Nightmare Hippogryph (×3)
mobList[zone][31 ].NMchildren = { true, 140, 141            } -- ( 031 ) Nightmare Sabotender (×3)
mobList[zone][32 ].NMchildren = { true, 142, 143            } -- ( 032 ) Nightmare Sheep (×3)
-- Nightmare Mobs
mobList[zone][53 ].NMchildren = { true, 144, 145            } -- ( 053 ) Nightmare Sabotender (×3)
mobList[zone][54 ].NMchildren = { true, 146, 147            } -- ( 054 ) Nightmare Sabotender (×3)
mobList[zone][55 ].NMchildren = { true, 148, 149            } -- ( 055 ) Nightmare Sabotender (×3)
mobList[zone][56 ].NMchildren = { true, 150, 151            } -- ( 056 ) Nightmare Sabotender (×3)
mobList[zone][57 ].NMchildren = { true, 152, 153            } -- ( 057 ) Nightmare Sabotender (×3)
mobList[zone][58 ].NMchildren = { true, 154, 155            } -- ( 058 ) Nightmare Sabotender (×3)
mobList[zone][59 ].NMchildren = { true, 156, 157            } -- ( 059 ) Nightmare Hippogryph (×3)
mobList[zone][60 ].NMchildren = { true, 158, 159            } -- ( 060 ) Nightmare Hippogryph (×3)
mobList[zone][61 ].NMchildren = { true, 160, 161            } -- ( 061 ) Nightmare Hippogryph (×3)
mobList[zone][62 ].NMchildren = { true, 162, 163            } -- ( 062 ) Nightmare Hippogryph (×3)
mobList[zone][63 ].NMchildren = { true, 164, 165            } -- ( 063 ) Nightmare Hippogryph (×3)
mobList[zone][64 ].NMchildren = { true, 166, 167            } -- ( 064 ) Nightmare Hippogryph (×3)
mobList[zone][65 ].NMchildren = { true, 168, 169            } -- ( 065 ) Nightmare Hippogryph (×3)
mobList[zone][66 ].NMchildren = { true, 170, 171            } -- ( 066 ) Nightmare Hippogryph (×3)
mobList[zone][67 ].NMchildren = { true, 272, 173            } -- ( 067 ) Nightmare Hippogryph (×3)
mobList[zone][68 ].NMchildren = { true, 174, 175            } -- ( 068 ) Nightmare Hippogryph (×3)
mobList[zone][69 ].NMchildren = { true, 176, 177            } -- ( 069 ) Nightmare Hippogryph (×3)
mobList[zone][70 ].NMchildren = { true, 178, 179            } -- ( 070 ) Nightmare Hippogryph (×3)
mobList[zone][71 ].NMchildren = { true, 180, 181            } -- ( 071 ) Nightmare Hippogryph (×3)
mobList[zone][72 ].NMchildren = { true, 182, 183            } -- ( 072 ) Nightmare Hippogryph (×3)
mobList[zone][73 ].NMchildren = { true, 184, 185            } -- ( 073 ) Nightmare Hippogryph (×3)
mobList[zone][74 ].NMchildren = { true, 186, 187            } -- ( 074 ) Nightmare Sabotender (×3)
mobList[zone][75 ].NMchildren = { true, 188, 189            } -- ( 075 ) Nightmare Sabotender (×3)
mobList[zone][76 ].NMchildren = { true, 190, 191            } -- ( 076 ) Nightmare Sabotender (×3)
mobList[zone][77 ].NMchildren = { true, 192, 193            } -- ( 077 ) Nightmare Sabotender (×3)
mobList[zone][78 ].NMchildren = { true, 194, 195            } -- ( 078 ) Nightmare Sabotender (×3)
mobList[zone][79 ].NMchildren = { true, 196, 197            } -- ( 079 ) Nightmare Sabotender (×3)
mobList[zone][80 ].NMchildren = { true, 198, 199            } -- ( 080 ) Nightmare Sabotender (×3)
mobList[zone][81 ].NMchildren = { true, 200, 201            } -- ( 081 ) Nightmare Sabotender (×3)
mobList[zone][82 ].NMchildren = { true, 202, 203            } -- ( 082 ) Nightmare Sabotender (×3)
mobList[zone][83 ].NMchildren = { true, 204, 205            } -- ( 083 ) Nightmare Sabotender (×3)
mobList[zone][84 ].NMchildren = { true, 206, 207            } -- ( 084 ) Nightmare Hippogryph (×3)
mobList[zone][85 ].NMchildren = { true, 208, 209            } -- ( 085 ) Nightmare Hippogryph (×3)
mobList[zone][86 ].NMchildren = { true, 210, 211            } -- ( 086 ) Nightmare Hippogryph (×3)
mobList[zone][87 ].NMchildren = { true, 212, 213            } -- ( 087 ) Nightmare Sheep (×3)
mobList[zone][88 ].NMchildren = { true, 214, 215            } -- ( 088 ) Nightmare Sheep (×3)
mobList[zone][89 ].NMchildren = { true, 216, 217            } -- ( 089 ) Nightmare Sheep (×3)
mobList[zone][90 ].NMchildren = { true, 218, 219            } -- ( 090 ) Nightmare Sheep (×3)
mobList[zone][91 ].NMchildren = { true, 220, 221            } -- ( 091 ) Nightmare Sheep (×3)
mobList[zone][92 ].NMchildren = { true, 222, 223            } -- ( 092 ) Nightmare Sheep (×3)
mobList[zone][93 ].NMchildren = { true, 224,                } -- ( 093 ) Nightmare Sheep (×2)
mobList[zone][94 ].NMchildren = { true, 225,                } -- ( 094 ) Nightmare Sheep (×2)
mobList[zone][95 ].NMchildren = { true, 226,                } -- ( 095 ) Nightmare Sheep (×2)
mobList[zone][96 ].NMchildren = { true, 227,                } -- ( 096 ) Nightmare Sheep (×2)
mobList[zone][97 ].NMchildren = { true, 228,                } -- ( 097 ) Nightmare Sheep (×2)
mobList[zone][98 ].NMchildren = { true, 229,                } -- ( 098 ) Nightmare Sheep (×2)
mobList[zone][99 ].NMchildren = { true, 230,                } -- ( 099 ) Nightmare Sheep (×2)
mobList[zone][100].NMchildren = { true, 231,                } -- ( 100 ) Nightmare Sheep (×2)
mobList[zone][101].NMchildren = { true, 232,                } -- ( 101 ) Nightmare Sheep (×2)
mobList[zone][102].NMchildren = { true, 233,                } -- ( 102 ) Nightmare Sheep (×2)
mobList[zone][103].NMchildren = { true, 234,                } -- ( 103 ) Nightmare Sheep (×2)
mobList[zone][104].NMchildren = { true, 235,                } -- ( 104 ) Nightmare Sheep (×2)
mobList[zone][105].NMchildren = { true, 236,                } -- ( 105 ) Nightmare Sheep (×2)
mobList[zone][106].NMchildren = { true, 237,                } -- ( 106 ) Nightmare Sheep (×2)
mobList[zone][107].NMchildren = { true, 238, 239            } -- ( 107 ) Nightmare Sheep (×3)
mobList[zone][108].NMchildren = { true, 240, 241            } -- ( 108 ) Nightmare Sheep (×3)
mobList[zone][109].NMchildren = { true, 242, 243            } -- ( 109 ) Nightmare Sheep (×3)
mobList[zone][110].NMchildren = { true, 244, 245            } -- ( 110 ) Nightmare Manticore (×3)
mobList[zone][111].NMchildren = { true, 246, 247            } -- ( 111 ) Nightmare Manticore (×3)
mobList[zone][112].NMchildren = { true, 248, 249            } -- ( 112 ) Nightmare Manticore (×3)
mobList[zone][113].NMchildren = { true, 250, 251            } -- ( 113 ) Nightmare Manticore (×3)
mobList[zone][114].NMchildren = { true, 252, 253            } -- ( 114 ) Nightmare Manticore (×3)
mobList[zone][115].NMchildren = { true, 254, 255            } -- ( 115 ) Nightmare Manticore (×3)
mobList[zone][116].NMchildren = { true, 256, 257            } -- ( 116 ) Nightmare Manticore (×3)
mobList[zone][117].NMchildren = { true, 258, 259            } -- ( 117 ) Nightmare Manticore (×3)
mobList[zone][118].NMchildren = { true, 260, 261            } -- ( 118 ) Nightmare Manticore (×3)
mobList[zone][119].NMchildren = { true, 262, 263, 264       } -- ( 119 ) Nightmare Manticore (×4)
mobList[zone][120].NMchildren = { true, 265, 266            } -- ( 120 ) Nightmare Manticore (×3)
mobList[zone][121].NMchildren = { true, 267, 268            } -- ( 121 ) Nightmare Manticore (×3)
mobList[zone][122].NMchildren = { true, 269, 270            } -- ( 122 ) Nightmare Manticore (×3)
mobList[zone][123].NMchildren = { true, 271, 272, 273       } -- ( 123 ) Nightmare Manticore (×4)
mobList[zone][124].NMchildren = { true, 274, 275, 276       } -- ( 124 ) Nightmare Manticore (×4)
mobList[zone][125].NMchildren = { true, 277, 278            } -- ( 125 ) Nightmare Manticore (×3)
mobList[zone][126].NMchildren = { true, 279, 280            } -- ( 126 ) Nightmare Manticore (×3)
mobList[zone][127].NMchildren = { true, 281, 282            } -- ( 127 ) Nightmare Manticore (×3)
mobList[zone][128].NMchildren = { true, 283, 284            } -- ( 128 ) Nightmare Sabotender (×3)
mobList[zone][129].NMchildren = { true, 285, 286            } -- ( 129 ) Nightmare Sabotender (×3)


------------------------------------------
--          Mob Position Info           --
-- Note: Must be setup for parent mobs, --
-- but is optional for children.        --
------------------------------------------
-- mobList[zone][MobIndex].pos = {xpos, ypos, zpos, rot}

-- Wave 1
-- Boss Area
mobList[zone][24 ].pos = { 63.648, 1.031, -76.541, 180     } -- ( 024 ) Cirrate Christelle - Spawns 025-052
mobList[zone][25 ].pos = { 29.358, 0.045, -24.815, 45      } -- (025-G)
mobList[zone][26 ].pos = { 41.943, 0.814, -23.702, 67      } -- (026-Y)
mobList[zone][27 ].pos = { 56.671, 0.562, -25.307, 67      } -- (027-Q)
mobList[zone][28 ].pos = { 84.413, 0.024, -29.546, 59      } -- (028-O)
mobList[zone][29 ].pos = { 37.877, 0.000, -38.515, 60      } -- ( 029 ) 029-Nightmare Manticore (×3)
mobList[zone][30 ].pos = { 85.392, 0.709, -56.579, 78      } -- ( 030 ) 030-Nightmare Hippogryph (×3)
mobList[zone][31 ].pos = { 111.675, 0.053, -46.130, 110    } -- ( 031 ) 031-Nightmare Sabotender (×3)
mobList[zone][32 ].pos = { 106.273, 0.463, -35.941, 100    } -- ( 032 ) 032-Nightmare Sheep (×3)
-- NMs
mobList[zone][5  ].pos = { -308.519, 0.095, -148.257, 29   } -- ( 005 ) Fairy Ring
mobList[zone][10 ].pos = { -679.979, -8.000, 158.754, 139  } -- ( 010 ) Flytrap NMs (Dragontrap ×3)
mobList[zone][15 ].pos = { 769.009, -7.530, 379.675, 54    } -- ( 015 ) Stcemqestcint - Inhibits Cirrate Christelle's 'Vampiric Lash' effect
mobList[zone][20 ].pos = { 956.335, 0.475, -332.799, 190   } -- ( 020 )
-- Initial Statues
mobList[zone][1  ].pos = { -227.075, 4.043, -136.874, 198  } -- (001-Y)
mobList[zone][2  ].pos = { -231.037, 4.300, -156.459, 181  } -- (002-Y)
mobList[zone][3  ].pos = { -248.461, 4.300, -155.360, 241  } -- (003-Y)
mobList[zone][4  ].pos = { -238.301, 3.994, -135.911, 188  } -- (004-Y)
mobList[zone][6  ].pos = { -541.404, -15.080, 355.848, 249 } -- (006-G)
mobList[zone][7  ].pos = { -565.817, -16.120, 354.162, 255 } -- (007-G)
mobList[zone][8  ].pos = { -550.128, -16.683, 323.770, 130 } -- (008-G)
mobList[zone][9  ].pos = { -568.867, -16.445, 325.818, 8   } -- (009-G)
mobList[zone][11 ].pos = { 800.240, -7.456, 254.332, 105   } -- (011-O)
mobList[zone][12 ].pos = { 796.763, -7.631, 268.595, 64    } -- (012-O)
mobList[zone][13 ].pos = { 792.154, -8.291, 321.301, 52    } -- (013-O)
mobList[zone][14 ].pos = { 805.659, -7.797, 340.507, 80    } -- (014-O)
mobList[zone][16 ].pos = { 648.224, -0.554, -166.534, 176  } -- (016-Q)
mobList[zone][17 ].pos = { 627.996, -1.738, -163.301, 225  } -- (017-Q)
mobList[zone][18 ].pos = { 702.606, -5.689, -180.082, 98   } -- (018-Q)
mobList[zone][19 ].pos = { 718.906, -8.000, -178.972, 123  } -- (019-Q)
mobList[zone][33 ].pos = { 15.751, -7.298, 79.127, 65      } -- (033-Y)
mobList[zone][34 ].pos = { 2.127, -7.719, 70.444, 65       } -- (034-Y)
mobList[zone][35 ].pos = { 15.570, -7.075, 68.542, 64      } -- (035-Y)
mobList[zone][36 ].pos = { 29.655, -8.313, 67.841, 61      } -- (036-Y)
mobList[zone][37 ].pos = { 16.975, -6.399, 53.539, 60      } -- (037-Y)
mobList[zone][38 ].pos = { -6.098, -7.882, 76.867, 120     } -- (038-G)
mobList[zone][39 ].pos = { -18.538, -7.656, 87.493, 126    } -- (039-G)
mobList[zone][40 ].pos = { -4.878, -7.742, 87.812, 127     } -- (040-G)
mobList[zone][41 ].pos = { 6.479, -7.928, 87.953, 130      } -- (041-G)
mobList[zone][42 ].pos = { -4.693, -7.204, 102.477, 124    } -- (042-G)
mobList[zone][43 ].pos = { 20.768, -7.224, 125.433, 199    } -- (043-O)
mobList[zone][44 ].pos = { 3.822, -7.841, 112.598, 204     } -- (044-O)
mobList[zone][45 ].pos = { 17.844, -8.016, 108.887, 198    } -- (045-O)
mobList[zone][46 ].pos = { 31.170, -7.792, 106.365, 195    } -- (046-O)
mobList[zone][47 ].pos = { 15.876, -7.875, 96.537, 191     } -- (047-O)
mobList[zone][48 ].pos = { 42.235, -7.096, 101.898, 2      } -- (048-Q)
mobList[zone][49 ].pos = { 28.787, -7.788, 86.305, 2       } -- (049-Q)
mobList[zone][50 ].pos = { 40.759, -7.855, 86.931, 253     } -- (050-Q)
mobList[zone][51 ].pos = { 54.684, -7.896, 87.993, 252     } -- (051-Q)
mobList[zone][52 ].pos = { 41.105, -7.913, 74.242, 255     } -- (052-Q)
-- Nightmare Mobs
mobList[zone][21 ].pos = { -199.637, 0.752, 15.476, 243    } -- ( 021 ) Recover subjobs
mobList[zone][22 ].pos = { 497.477, -15.127, 237.200, 77   } -- ( 022 ) Recover subjobs
mobList[zone][23 ].pos = { 351.001, -2.324, -21.541, 159   } -- ( 023 ) Recover subjobs
mobList[zone][53 ].pos = { 270.350, -7.845, 88.144, 11     } -- ( 053 ) Nightmare Sabotender (×3)
mobList[zone][54 ].pos = { 269.572, -7.850, 110.006, 212   } -- ( 054 ) Nightmare Sabotender (×3)
mobList[zone][55 ].pos = { 232.008, -8.007, 114.407, 116   } -- ( 055 ) Nightmare Sabotender (×3)
mobList[zone][56 ].pos = { 227.459, -7.580, 81.794, 109    } -- ( 056 ) Nightmare Sabotender (×3)
mobList[zone][57 ].pos = { 203.136, -7.688, 103.600, 130   } -- ( 057 ) Nightmare Sabotender (×3)
mobList[zone][58 ].pos = { 204.115, -7.446, 133.583, 112   } -- ( 058 ) Nightmare Sabotender (×3)
mobList[zone][59 ].pos = { -201.351, -0.157, -72.847, 191  } -- ( 059 ) Nightmare Hippogryph (×3)
mobList[zone][60 ].pos = { -182.171, -2.491, -41.078, 211  } -- ( 060 ) Nightmare Hippogryph (×3)
mobList[zone][61 ].pos = { -207.936, -3.404, -18.120, 169  } -- ( 061 ) Nightmare Hippogryph (×3)
mobList[zone][62 ].pos = { -211.957, -0.079, -48.985, 246  } -- ( 062 ) Nightmare Hippogryph (×3)
mobList[zone][63 ].pos = { -242.782, -0.176, -39.340, 131  } -- ( 063 ) Nightmare Hippogryph (×3)
mobList[zone][64 ].pos = { -337.618, -7.120, 116.906, 27   } -- ( 064 ) Nightmare Hippogryph (×3)
mobList[zone][65 ].pos = { -368.481, -7.446, 104.491, 3    } -- ( 065 ) Nightmare Hippogryph (×3)
mobList[zone][66 ].pos = { -431.067, -7.755, 83.780, 17    } -- ( 066 ) Nightmare Hippogryph (×3)
mobList[zone][67 ].pos = { -439.514, -7.563, 147.256, 66   } -- ( 067 ) Nightmare Hippogryph (×3)
mobList[zone][68 ].pos = { -411.644, -7.61, 200.437, 235   } -- ( 068 ) Nightmare Hippogryph (×3)
mobList[zone][69 ].pos = { -363.394, -8.000, 199.008, 245  } -- ( 069 ) Nightmare Hippogryph (×3)
mobList[zone][70 ].pos = { -337.741, -9.782, 180.387, 21   } -- ( 070 ) Nightmare Hippogryph (×3)
mobList[zone][71 ].pos = { -323.574, -7.976, 155.486, 27   } -- ( 071 ) Nightmare Hippogryph (×3)
mobList[zone][72 ].pos = { -321.165, -7.748, 129.066, 16   } -- ( 072 ) Nightmare Hippogryph (×3)
mobList[zone][73 ].pos = { -307.629, -7.568, 161.307, 21   } -- ( 073 ) Nightmare Hippogryph (×3)
mobList[zone][74 ].pos = { -528.345, -9.070, 112.368, 235  } -- ( 074 ) Nightmare Sabotender (×3)
mobList[zone][75 ].pos = { -525.822, -7.596, 134.059, 26   } -- ( 075 ) Nightmare Sabotender (×3)
mobList[zone][76 ].pos = { -525.602, -8.154, 161.502, 57   } -- ( 076 ) Nightmare Sabotender (×3)
mobList[zone][77 ].pos = { -504.772, -8.829, 166.651, 10   } -- ( 077 ) Nightmare Sabotender (×3)
mobList[zone][78 ].pos = { -506.119, -7.978, 141.795, 55   } -- ( 078 ) Nightmare Sabotender (×3)
mobList[zone][79 ].pos = { -495.775, -7.227, 116.713, 12   } -- ( 079 ) Nightmare Sabotender (×3)
mobList[zone][80 ].pos = { -477.706, -7.630, 131.416, 248  } -- ( 080 ) Nightmare Sabotender (×3)
mobList[zone][81 ].pos = { -476.029, -8.003, 161.425, 237  } -- ( 081 ) Nightmare Sabotender (×3)
mobList[zone][82 ].pos = { -496.854, -7.158, 123.142, 221  } -- ( 082 ) Nightmare Sabotender (×3)
mobList[zone][83 ].pos = { -675.863, -8.309, 206.097, 69   } -- ( 083 ) Nightmare Sabotender (×3)
mobList[zone][84 ].pos = { -704.722, -7.277, 203.703, 3    } -- ( 084 ) Nightmare Hippogryph (×3)
mobList[zone][85 ].pos = { -722.532, -8.000, 238.819, 49   } -- ( 085 ) Nightmare Hippogryph (×3)
mobList[zone][86 ].pos = { -747.801, -4.455, 196.307, 11   } -- ( 086 ) Nightmare Hippogryph (×3)
mobList[zone][87 ].pos = { 448.005, -15.775, 233.921, 42   } -- ( 087 ) Nightmare Sheep (×3)
mobList[zone][88 ].pos = { 449.724, -16.110, 209.823, 94   } -- ( 088 ) Nightmare Sheep (×3)
mobList[zone][89 ].pos = { 471.173, -16.142, 218.323, 235  } -- ( 089 ) Nightmare Sheep (×3)
mobList[zone][90 ].pos = { 463.897, -15.196, 239.508, 50   } -- ( 090 ) Nightmare Sheep (×3)
mobList[zone][91 ].pos = { 486.988, -15.702, 251.184, 49   } -- ( 091 ) Nightmare Sheep (×3)
mobList[zone][92 ].pos = { 500.990, -16.375, 219.804, 148  } -- ( 092 ) Nightmare Sheep (×3)
mobList[zone][93 ].pos = { 440.603, -8.000, 80.841, 179    } -- ( 093 ) Nightmare Sheep (×2)
mobList[zone][94 ].pos = { 453.174, -7.956, 99.440, 198    } -- ( 094 ) Nightmare Sheep (×2)
mobList[zone][95 ].pos = { 430.282, -8.061, 106.429, 154   } -- ( 095 ) Nightmare Sheep (×2)
mobList[zone][96 ].pos = { 414.866, -7.318, 80.183, 110    } -- ( 096 ) Nightmare Sheep (×2)
mobList[zone][97 ].pos = { 407.319, -7.451, 58.923, 138    } -- ( 097 ) Nightmare Sheep (×2)
mobList[zone][98 ].pos = { 428.845, -2.609, 48.355, 15     } -- ( 098 ) Nightmare Sheep (×2)
mobList[zone][99 ].pos = { 419.554, -3.957, 32.476, 89     } -- ( 099 ) Nightmare Sheep (×2)
mobList[zone][100].pos = { 398.680, -7.547, 32.037, 121    } -- ( 100 ) Nightmare Sheep (×2)
mobList[zone][101].pos = { 398.680, -7.547, 32.037, 121    } -- ( 101 ) Nightmare Sheep (×2)
mobList[zone][102].pos = { 374.559, -7.349, 77.603, 144    } -- ( 102 ) Nightmare Sheep (×2)
mobList[zone][103].pos = { 354.904, -7.569, 69.202, 122    } -- ( 103 ) Nightmare Sheep (×2)
mobList[zone][104].pos = { 350.501, -7.809, 48.913, 84     } -- ( 104 ) Nightmare Sheep (×2)
mobList[zone][105].pos = { 350.501, -7.809, 48.913, 84     } -- ( 105 ) Nightmare Sheep (×2)
mobList[zone][106].pos = { 390.835, -1.071, 11.709, 1      } -- ( 106 ) Nightmare Sheep (×2)
mobList[zone][107].pos = { 713.279, -7.865, 198.806, 145   } -- ( 107 ) Nightmare Sheep (×3)
mobList[zone][108].pos = { 716.741, -6.853, 221.077, 139   } -- ( 108 ) Nightmare Sheep (×3)
mobList[zone][109].pos = { 693.905, -14.598, 247.086, 69   } -- ( 109 ) Nightmare Sheep (×3)
mobList[zone][110].pos = { 313.455, -0.126, 4.949, 49      } -- ( 110 ) Nightmare Manticore (×3)
mobList[zone][111].pos = { 281.517, 0.000, 3.977, 135      } -- ( 111 ) Nightmare Manticore (×3)
mobList[zone][112].pos = { 257.308, -1.385, -25.174, 98    } -- ( 112 ) Nightmare Manticore (×3)
mobList[zone][113].pos = { 266.672, -2.356, -59.410, 147   } -- ( 113 ) Nightmare Manticore (×3)
mobList[zone][114].pos = { 301.975, -0.297, -50.620, 237   } -- ( 114 ) Nightmare Manticore (×3)
mobList[zone][115].pos = { 335.514, -0.512, -34.323, 247   } -- ( 115 ) Nightmare Manticore (×3)
mobList[zone][116].pos = { 248.361, 4.000, -157.225, 217   } -- ( 116 ) Nightmare Manticore (×3)
mobList[zone][117].pos = { 277.378, 3.340, -147.096, 245   } -- ( 117 ) Nightmare Manticore (×3)
mobList[zone][118].pos = { 306.276, 4.000, -164.827, 192   } -- ( 118 ) Nightmare Manticore (×3)
mobList[zone][119].pos = { 331.719, 0.533, -125.410, 202   } -- ( 119 ) Nightmare Manticore (×4)
mobList[zone][120].pos = { 627.957, -0.003, -29.334, 81    } -- ( 120 ) Nightmare Manticore (×3)
mobList[zone][121].pos = { 650.911, -0.059, -31.493, 84    } -- ( 121 ) Nightmare Manticore (×3)
mobList[zone][122].pos = { 657.631, 0.766, -4.862, 56      } -- ( 122 ) Nightmare Manticore (×3)
mobList[zone][123].pos = { 632.846, -0.239, 3.933, 41      } -- ( 123 ) Nightmare Manticore (×4)
mobList[zone][124].pos = { 679.221, 0.227, -8.568, 107     } -- ( 124 ) Nightmare Manticore (×4)
mobList[zone][125].pos = { 921.803, 0.809, -223.797, 141   } -- ( 125 ) Nightmare Manticore (×3)
mobList[zone][126].pos = { 896.764, 0.749, -205.139, 139   } -- ( 126 ) Nightmare Manticore (×3)
mobList[zone][127].pos = { 892.210, 0.249, -244.012, 91    } -- ( 127 ) Nightmare Manticore (×3)
mobList[zone][128].pos = { 911.322, -0.561, -323.268, 237  } -- ( 128 ) Nightmare Sabotender (×3)
mobList[zone][129].pos = { 968.520, -0.415, -278.791, 99   } -- ( 129 ) Nightmare Sabotender (×3)

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

mobList[zone][6  ].eyes = dynamisEyesEra.BLUE
mobList[zone][7  ].eyes = dynamisEyesEra.GREEN
mobList[zone][16 ].eyes = dynamisEyesEra.BLUE

------------------------------------------
--        Time Extension Values         --
------------------------------------------
-- mobList[zone][MobIndex].timeExtension = 15

mobList[zone][24].timeExtension = 60
