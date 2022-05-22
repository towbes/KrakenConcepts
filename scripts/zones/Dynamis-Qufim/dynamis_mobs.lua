----------------------------------------------------------------------------------------------------
--                                      Dynamis-Qufim                                             --
--              Primary Source of Information: https://enedin.be/dyna/html/zone/quf.htm           --
--           Secondary Source of Information: http://www.dynamisbums.com/strategy/quf.html        --
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
local zone = xi.zone.DYNAMIS_QUFIM
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

-- Sea Monk NM Area
mobList[zone][1  ].info = {"Statue", "Adamantking Effigy", "Quadav", nil, nil}   -- (001-Q)
mobList[zone][2  ].info = {"Statue", "Adamantking Effigy", "Quadav", nil, nil}   -- (002-Q)
-- Southwest AreaStatue"Quadav"
mobList[zone][3  ].info = {"Statue", "Adamantking Effigy", "Quadav", nil, nil}   -- (003-Q)
mobList[zone][4  ].info = {"Statue", "Adamantking Effigy", "Quadav", nil, nil}   -- (004-Q)
mobList[zone][5  ].info = {"Statue", "Adamantking Effigy", "Quadav", nil, nil}   -- (005-Q)
mobList[zone][6  ].info = {"Statue", "Adamantking Effigy", "Quadav", nil, nil}   -- (006-Q)
mobList[zone][7  ].info = {"Statue", "Adamantking Effigy", "Quadav", nil, nil}   -- (007-Q)
mobList[zone][8  ].info = {"Statue", "Manifest Icon", "Yagudo", nil, nil}        -- (008-Y)
mobList[zone][9  ].info = {"Statue", "Manifest Icon", "Yagudo", nil, nil}        -- (009-Y)
mobList[zone][10 ].info = {"Statue", "Manifest Icon", "Yagudo", nil, nil}        -- (010-Y)
mobList[zone][11 ].info = {"Statue", "Manifest Icon", "Yagudo", nil, nil}        -- (011-Y)
mobList[zone][12 ].info = {"Statue", "Manifest Icon", "Yagudo", nil, nil}        -- (012-Y)
mobList[zone][13 ].info = {"Statue", "Manifest Icon", "Yagudo", nil, nil}        -- (013-Y)
mobList[zone][14 ].info = {"Statue", "Manifest Icon", "Yagudo", nil, nil}        -- (014-Y)
mobList[zone][15 ].info = {"Statue", "Manifest Icon", "Yagudo", nil, nil}        -- (015-Y)
-- Northeast Area
mobList[zone][16 ].info = {"Statue", "Serjeant Tombstone", "Orc", nil, nil}   -- (016-O)
mobList[zone][17 ].info = {"Statue", "Serjeant Tombstone", "Orc", nil, nil}   -- (017-O)
mobList[zone][18 ].info = {"Statue", "Serjeant Tombstone", "Orc", nil, nil}   -- (018-O)
mobList[zone][19 ].info = {"Statue", "Serjeant Tombstone", "Orc", nil, nil}   -- (019-O)
mobList[zone][20 ].info = {"Statue", "Serjeant Tombstone", "Orc", nil, nil}   -- (020-O)
mobList[zone][21 ].info = {"Statue", "Serjeant Tombstone", "Orc", nil, nil}   -- (021-O)
mobList[zone][22 ].info = {"Statue", "Serjeant Tombstone", "Orc", nil, nil}   -- (022-O)
mobList[zone][23 ].info = {"Statue", "Serjeant Tombstone", "Orc", nil, nil}   -- (023-O)
mobList[zone][24 ].info = {"Statue", "Serjeant Tombstone", "Orc", nil, nil}   -- (024-O)
mobList[zone][25 ].info = {"Statue", "Goblin Replica", "Goblin", nil, nil}       -- (025-G)
mobList[zone][26 ].info = {"Statue", "Goblin Replica", "Goblin", nil, nil}       -- (026-G)
-- Boss Area
mobList[zone][27 ].info = {"Statue", "Goblin Replica", "Goblin", nil, nil}       -- (027-G)
mobList[zone][28 ].info = {"Statue", "Goblin Replica", "Goblin", nil, nil}       -- (028-G)
mobList[zone][29 ].info = {"Statue", "Goblin Replica", "Goblin", nil, nil}       -- (029-G)
mobList[zone][30 ].info = {"Statue", "Goblin Replica", "Goblin", nil, nil}       -- (030-G)
mobList[zone][31 ].info = {"Statue", "Goblin Replica", "Goblin", nil, nil}       -- (031-G)
-- Golem NM Area
mobList[zone][32 ].info = {"Statue", "Goblin Replica", "Goblin", nil, nil}       -- (032-G)
mobList[zone][33 ].info = {"Statue", "Goblin Replica", "Goblin", nil, nil}       -- (033-G)
mobList[zone][34 ].info = {"Statue", "Goblin Replica", "Goblin", nil, nil}       -- (034-G)
mobList[zone][35 ].info = {"Statue", "Goblin Replica", "Goblin", nil, nil}       -- (035-G)
-- Giant Bat NM Area
mobList[zone][36 ].info = {"Statue", "Goblin Replica", "Goblin", nil, nil}       -- (036-G)
mobList[zone][37 ].info = {"Statue", "Goblin Replica", "Goblin", nil, nil}       -- (037-G)
mobList[zone][38 ].info = {"Statue", "Goblin Replica", "Goblin", nil, nil}       -- (038-G)
mobList[zone][39 ].info = {"Statue", "Goblin Replica", "Goblin", nil, nil}       -- (039-G)
-- Sea Monk NM Area
mobList[zone][43 ].info = {nil, "Water Elemental", nil, nil, nil}           -- (043) (Reduces Antaeus' resistance to water)
mobList[zone][40 ].info = {"NM", "Scolopendra", nil, nil, nil}              -- (040) (Reduces Antaeus' HP regeneration rate)
-- Southwest Area
mobList[zone][44 ].info = {nil, "Fire Elemental", nil, nil, nil}            -- (044) (Reduces Antaeus' resistance to fire)
-- Giant Bat Area
mobList[zone][45 ].info = {nil, "Thunder Elemental", nil, nil, nil}         -- (045) (Reduces Antaeus' resistance to thunder)
mobList[zone][41 ].info = {"NM", "Stringes", nil, nil, nil}                 -- (041) (Reduces Antaeus' physical attack damage)
-- Northeast Area
mobList[zone][46 ].info = {nil, "Air Elemental", nil, nil, nil}             -- (046) (Reduces Antaeus' resistance to wind)
mobList[zone][47 ].info = {nil, "Light Elemental", nil, nil, nil}           -- (047) (Reduces Antaeus' resistance to light)
-- Boss Area
mobList[zone][48 ].info = {nil, "Ice Elemental", nil, nil, nil}             -- (048) (Reduces Antaeus' resistance to ice)
mobList[zone][64 ].info = {"NM", "Antaeus", nil, nil, "MegaBoss_Killed"}    -- (064) (Spawns 065-138)
-- Golem NM Area
mobList[zone][49 ].info = {nil, "Earth Elemental", nil, nil, nil}           -- (049) (Reduces Antaeus' resistance to earth)
mobList[zone][50 ].info = {nil, "Dark Elemental", nil, nil, nil}            -- (050) (Reduces Antaeus' resistance to dark)
mobList[zone][42 ].info = {"NM", "Suttung", nil, nil, nil}                  -- (042) (Reduces Antaeus' magic damage resistance)
-- Nightmare Stirge
mobList[zone][51 ].info = {"Nightmare", "Nightmare Stirge", nil, nil, nil}  -- 051-Nightmare Stirge (×4)
mobList[zone][244].info = {"Nightmare", "Nightmare Stirge", nil, nil, nil}  --
mobList[zone][245].info = {"Nightmare", "Nightmare Stirge", nil, nil, nil}  --
mobList[zone][246].info = {"Nightmare", "Nightmare Stirge", nil, nil, nil}  --
mobList[zone][52 ].info = {"Nightmare", "Nightmare Stirge", nil, nil, nil}  -- 052-Nightmare Stirge (×4)
mobList[zone][247].info = {"Nightmare", "Nightmare Stirge", nil, nil, nil}  --
mobList[zone][248].info = {"Nightmare", "Nightmare Stirge", nil, nil, nil}  --
mobList[zone][249].info = {"Nightmare", "Nightmare Stirge", nil, nil, nil}  --
mobList[zone][53 ].info = {"Nightmare", "Nightmare Stirge", nil, nil, nil}  -- 053-Nightmare Stirge (×4)
mobList[zone][250].info = {"Nightmare", "Nightmare Stirge", nil, nil, nil}  --
mobList[zone][251].info = {"Nightmare", "Nightmare Stirge", nil, nil, nil}  --
mobList[zone][252].info = {"Nightmare", "Nightmare Stirge", nil, nil, nil}  --
mobList[zone][62 ].info = {"Nightmare", "Nightmare Stirge", nil, nil, nil}  -- 062-Nightmare Stirge (×3)
mobList[zone][253].info = {"Nightmare", "Nightmare Stirge", nil, nil, nil}  --
mobList[zone][254].info = {"Nightmare", "Nightmare Stirge", nil, nil, nil}  --
mobList[zone][63 ].info = {"Nightmare", "Nightmare Stirge", nil, nil, nil}  -- 063-Nightmare Stirge (×4)
mobList[zone][255].info = {"Nightmare", "Nightmare Stirge", nil, nil, nil}  --
mobList[zone][256].info = {"Nightmare", "Nightmare Stirge", nil, nil, nil}  --
mobList[zone][257].info = {"Nightmare", "Nightmare Stirge", nil, nil, nil}  --
-- Nightmare Roc
mobList[zone][58 ].info = {"Nightmare", "Nightmare Roc", nil, nil, nil}     -- 058-Nightmare Roc (×3)
mobList[zone][258].info = {"Nightmare", "Nightmare Roc", nil, nil, nil}     --
mobList[zone][259].info = {"Nightmare", "Nightmare Roc", nil, nil, nil}     --
mobList[zone][61 ].info = {"Nightmare", "Nightmare Roc", nil, nil, nil}     -- 061-Nightmare Roc (×3)
mobList[zone][260].info = {"Nightmare", "Nightmare Roc", nil, nil, nil}     --
mobList[zone][261].info = {"Nightmare", "Nightmare Roc", nil, nil, nil}     --
-- Nightmare Snoll
mobList[zone][54 ].info = {"Nightmare", "Nightmare Snoll", nil, nil, nil}   -- 054-Nightmare Snoll (×4)
mobList[zone][262].info = {"Nightmare", "Nightmare Snoll", nil, nil, nil}   --
mobList[zone][263].info = {"Nightmare", "Nightmare Snoll", nil, nil, nil}   --
mobList[zone][264].info = {"Nightmare", "Nightmare Snoll", nil, nil, nil}   --
mobList[zone][55 ].info = {"Nightmare", "Nightmare Snoll", nil, nil, nil}   -- 055-Nightmare Snoll (×4)
mobList[zone][265].info = {"Nightmare", "Nightmare Snoll", nil, nil, nil}   --
mobList[zone][266].info = {"Nightmare", "Nightmare Snoll", nil, nil, nil}   --
mobList[zone][267].info = {"Nightmare", "Nightmare Snoll", nil, nil, nil}   --
mobList[zone][56 ].info = {"Nightmare", "Nightmare Snoll", nil, nil, nil}   -- 056-Nightmare Snoll (×4)
mobList[zone][268].info = {"Nightmare", "Nightmare Snoll", nil, nil, nil}   --
mobList[zone][269].info = {"Nightmare", "Nightmare Snoll", nil, nil, nil}   --
mobList[zone][270].info = {"Nightmare", "Nightmare Snoll", nil, nil, nil}   --
mobList[zone][57 ].info = {"Nightmare", "Nightmare Snoll", nil, nil, nil}   -- 057-Nightmare Snoll (×4)
mobList[zone][271].info = {"Nightmare", "Nightmare Snoll", nil, nil, nil}   --
mobList[zone][272].info = {"Nightmare", "Nightmare Snoll", nil, nil, nil}   --
mobList[zone][273].info = {"Nightmare", "Nightmare Snoll", nil, nil, nil}   --
mobList[zone][59 ].info = {"Nightmare", "Nightmare Snoll", nil, nil, nil}   -- 059-Nightmare Snoll (×4)
mobList[zone][274].info = {"Nightmare", "Nightmare Snoll", nil, nil, nil}   --
mobList[zone][275].info = {"Nightmare", "Nightmare Snoll", nil, nil, nil}   --
mobList[zone][276].info = {"Nightmare", "Nightmare Snoll", nil, nil, nil}   --
mobList[zone][60 ].info = {"Nightmare", "Nightmare Snoll", nil, nil, nil}   -- 060-Nightmare Snoll (×4)
mobList[zone][277].info = {"Nightmare", "Nightmare Snoll", nil, nil, nil}   --
mobList[zone][278].info = {"Nightmare", "Nightmare Snoll", nil, nil, nil}   --
mobList[zone][279].info = {"Nightmare", "Nightmare Snoll", nil, nil, nil}   --
-- Southwest Area
mobList[zone][65].info = {"Statue", "Goblin Replica", "Goblin", nil, nil}        -- (065-G)
mobList[zone][66].info = {"Statue", "Goblin Replica", "Goblin", nil, nil}        -- (066-G)
mobList[zone][67].info = {"Statue", "Goblin Replica", "Goblin", nil, nil}        -- (067-G)
mobList[zone][68].info = {"Statue", "Goblin Replica", "Goblin", nil, nil}        -- (068-G)
-- Northeast Area
mobList[zone][69].info = {"Statue", "Goblin Replica", "Goblin", nil, nil}        -- (069-G)
mobList[zone][70].info = {"Statue", "Goblin Replica", "Goblin", nil, nil}        -- (070-G)
-- Central Area
mobList[zone][71].info = {"Statue", "Goblin Replica", "Goblin", nil, nil}        -- (071-G)
mobList[zone][72].info = {"Statue", "Goblin Replica", "Goblin", nil, nil}        -- (072-G)
mobList[zone][73].info = {"Statue", "Goblin Replica", "Goblin", nil, nil}        -- (073-G)
mobList[zone][74].info = {"Statue", "Goblin Replica", "Goblin", nil, nil}        -- (074-G)
mobList[zone][75].info = {"Statue", "Goblin Replica", "Goblin", nil, nil}        -- (075-G)
-- Nightmare Weapon
mobList[zone][76 ].info = {"Nightmare", "Nightmare Weapon", nil, nil, nil}  -- 076-Nightmare Weapon (×3)
mobList[zone][139].info = {"Nightmare", "Nightmare Weapon", nil, nil, nil}  --
mobList[zone][140].info = {"Nightmare", "Nightmare Weapon", nil, nil, nil}  --
mobList[zone][77 ].info = {"Nightmare", "Nightmare Weapon", nil, nil, nil}  -- 077-Nightmare Weapon (×3)
mobList[zone][141].info = {"Nightmare", "Nightmare Weapon", nil, nil, nil}  --
mobList[zone][142].info = {"Nightmare", "Nightmare Weapon", nil, nil, nil}  --
mobList[zone][78 ].info = {"Nightmare", "Nightmare Weapon", nil, nil, nil}  -- 078-Nightmare Weapon (×3)
mobList[zone][143].info = {"Nightmare", "Nightmare Weapon", nil, nil, nil}  --
mobList[zone][144].info = {"Nightmare", "Nightmare Weapon", nil, nil, nil}  --
mobList[zone][79 ].info = {"Nightmare", "Nightmare Weapon", nil, nil, nil}  -- 079-Nightmare Weapon (×3)
mobList[zone][145].info = {"Nightmare", "Nightmare Weapon", nil, nil, nil}  --
mobList[zone][146].info = {"Nightmare", "Nightmare Weapon", nil, nil, nil}  --
mobList[zone][80 ].info = {"Nightmare", "Nightmare Weapon", nil, nil, nil}  -- 080-Nightmare Weapon (×3)
mobList[zone][147].info = {"Nightmare", "Nightmare Weapon", nil, nil, nil}  --
mobList[zone][148].info = {"Nightmare", "Nightmare Weapon", nil, nil, nil}  --
mobList[zone][81 ].info = {"Nightmare", "Nightmare Weapon", nil, nil, nil}  -- 081-Nightmare Weapon (×3)
mobList[zone][149].info = {"Nightmare", "Nightmare Weapon", nil, nil, nil}  --
mobList[zone][150].info = {"Nightmare", "Nightmare Weapon", nil, nil, nil}  --
mobList[zone][82 ].info = {"Nightmare", "Nightmare Weapon", nil, nil, nil}  -- 082-Nightmare Weapon (×3)
mobList[zone][151].info = {"Nightmare", "Nightmare Weapon", nil, nil, nil}  --
mobList[zone][152].info = {"Nightmare", "Nightmare Weapon", nil, nil, nil}  --
mobList[zone][83 ].info = {"Nightmare", "Nightmare Weapon", nil, nil, nil}  -- 083-Nightmare Weapon (×3)
mobList[zone][153].info = {"Nightmare", "Nightmare Weapon", nil, nil, nil}  --
mobList[zone][154].info = {"Nightmare", "Nightmare Weapon", nil, nil, nil}  --
mobList[zone][84 ].info = {"Nightmare", "Nightmare Weapon", nil, nil, nil}  -- 084-Nightmare Weapon (×3)
mobList[zone][155].info = {"Nightmare", "Nightmare Weapon", nil, nil, nil}  --
mobList[zone][156].info = {"Nightmare", "Nightmare Weapon", nil, nil, nil}  --
mobList[zone][85 ].info = {"Nightmare", "Nightmare Weapon", nil, nil, nil}  -- 085-Nightmare Weapon (×3)
mobList[zone][157].info = {"Nightmare", "Nightmare Weapon", nil, nil, nil}  --
mobList[zone][158].info = {"Nightmare", "Nightmare Weapon", nil, nil, nil}  --
-- Nightmare Kraken
mobList[zone][86 ].info = {"Nightmare", "Nightmare Kraken", nil, nil, nil}  -- 086-Nightmare Kraken (×2)
mobList[zone][159].info = {"Nightmare", "Nightmare Kraken", nil, nil, nil}  --
mobList[zone][87 ].info = {"Nightmare", "Nightmare Kraken", nil, nil, nil}  -- 087-Nightmare Kraken (×2)
mobList[zone][160].info = {"Nightmare", "Nightmare Kraken", nil, nil, nil}  --
mobList[zone][88 ].info = {"Nightmare", "Nightmare Kraken", nil, nil, nil}  -- 088-Nightmare Kraken (×2)
mobList[zone][161].info = {"Nightmare", "Nightmare Kraken", nil, nil, nil}  --
mobList[zone][89 ].info = {"Nightmare", "Nightmare Kraken", nil, nil, nil}  -- 089-Nightmare Kraken (×2)
mobList[zone][162].info = {"Nightmare", "Nightmare Kraken", nil, nil, nil}  --
mobList[zone][90 ].info = {"Nightmare", "Nightmare Kraken", nil, nil, nil}  -- 090-Nightmare Kraken (×2)
mobList[zone][163].info = {"Nightmare", "Nightmare Kraken", nil, nil, nil}  --
mobList[zone][91 ].info = {"Nightmare", "Nightmare Kraken", nil, nil, nil}  -- 091-Nightmare Kraken (×2)
mobList[zone][164].info = {"Nightmare", "Nightmare Kraken", nil, nil, nil}  --
mobList[zone][92 ].info = {"Nightmare", "Nightmare Kraken", nil, nil, nil}  -- 092-Nightmare Kraken (×2)
mobList[zone][165].info = {"Nightmare", "Nightmare Kraken", nil, nil, nil}  --
mobList[zone][93 ].info = {"Nightmare", "Nightmare Kraken", nil, nil, nil}  -- 093-Nightmare Kraken (×2)
mobList[zone][166].info = {"Nightmare", "Nightmare Kraken", nil, nil, nil}  --
mobList[zone][94 ].info = {"Nightmare", "Nightmare Kraken", nil, nil, nil}  -- 094-Nightmare Kraken (×2)
mobList[zone][167].info = {"Nightmare", "Nightmare Kraken", nil, nil, nil}  --
mobList[zone][95 ].info = {"Nightmare", "Nightmare Kraken", nil, nil, nil}  -- 095-Nightmare Kraken (×2)
mobList[zone][168].info = {"Nightmare", "Nightmare Kraken", nil, nil, nil}  --
mobList[zone][96 ].info = {"Nightmare", "Nightmare Kraken", nil, nil, nil}  -- 096-Nightmare Kraken (×2)
mobList[zone][169].info = {"Nightmare", "Nightmare Kraken", nil, nil, nil}  --
mobList[zone][97 ].info = {"Nightmare", "Nightmare Kraken", nil, nil, nil}  -- 097-Nightmare Kraken (×2)
mobList[zone][170].info = {"Nightmare", "Nightmare Kraken", nil, nil, nil}  --
mobList[zone][98 ].info = {"Nightmare", "Nightmare Kraken", nil, nil, nil}  -- 098-Nightmare Kraken (×3)
mobList[zone][171].info = {"Nightmare", "Nightmare Kraken", nil, nil, nil}  --
mobList[zone][172].info = {"Nightmare", "Nightmare Kraken", nil, nil, nil}  --
-- Nightmare Tiger
mobList[zone][99 ].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   -- 099-Nightmare Tiger (×4)
mobList[zone][173].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   --
mobList[zone][174].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   --
mobList[zone][175].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   --
mobList[zone][100].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   -- 100-Nightmare Tiger (×4)
mobList[zone][176].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   --
mobList[zone][177].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   --
mobList[zone][178].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   --
mobList[zone][101].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   -- 101-Nightmare Tiger (×4)
mobList[zone][179].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   --
mobList[zone][180].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   --
mobList[zone][181].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   --
mobList[zone][102].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   -- 102-Nightmare Tiger (×5)
mobList[zone][182].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   --
mobList[zone][183].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   --
mobList[zone][184].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   --
mobList[zone][185].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   --
mobList[zone][103].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   -- 103-Nightmare Tiger (×5)
mobList[zone][186].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   --
mobList[zone][187].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   --
mobList[zone][188].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   --
mobList[zone][189].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   --
mobList[zone][104].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   -- 104-Nightmare Tiger (×5)
mobList[zone][190].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   --
mobList[zone][191].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   --
mobList[zone][192].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   --
mobList[zone][193].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   --
mobList[zone][105].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   -- 105-Nightmare Tiger (×5)
mobList[zone][194].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   --
mobList[zone][195].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   --
mobList[zone][196].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   --
mobList[zone][197].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   --
-- Nightmare Raptor
mobList[zone][106].info = {"Nightmare", "Nightmare Raptor", nil, nil, nil}  -- 106-Nightmare Raptor (×2)
mobList[zone][198].info = {"Nightmare", "Nightmare Raptor", nil, nil, nil}  --
mobList[zone][107].info = {"Nightmare", "Nightmare Raptor", nil, nil, nil}  -- 107-Nightmare Raptor (×2)
mobList[zone][199].info = {"Nightmare", "Nightmare Raptor", nil, nil, nil}  --
mobList[zone][108].info = {"Nightmare", "Nightmare Raptor", nil, nil, nil}  -- 108-Nightmare Raptor (×2)
mobList[zone][200].info = {"Nightmare", "Nightmare Raptor", nil, nil, nil}  --
mobList[zone][109].info = {"Nightmare", "Nightmare Raptor", nil, nil, nil}  -- 109-Nightmare Raptor (×2)
mobList[zone][201].info = {"Nightmare", "Nightmare Raptor", nil, nil, nil}  --
mobList[zone][110].info = {"Nightmare", "Nightmare Raptor", nil, nil, nil}  -- 110-Nightmare Raptor (×2)
mobList[zone][202].info = {"Nightmare", "Nightmare Raptor", nil, nil, nil}  --
mobList[zone][111].info = {"Nightmare", "Nightmare Raptor", nil, nil, nil}  -- 111-Nightmare Raptor (×2)
mobList[zone][203].info = {"Nightmare", "Nightmare Raptor", nil, nil, nil}  --
mobList[zone][112].info = {"Nightmare", "Nightmare Raptor", nil, nil, nil}  -- 112-Nightmare Raptor (×2)
mobList[zone][204].info = {"Nightmare", "Nightmare Raptor", nil, nil, nil}  --
mobList[zone][113].info = {"Nightmare", "Nightmare Raptor", nil, nil, nil}  -- 113-Nightmare Raptor (×2)
mobList[zone][205].info = {"Nightmare", "Nightmare Raptor", nil, nil, nil}  --
mobList[zone][114].info = {"Nightmare", "Nightmare Raptor", nil, nil, nil}  -- 114-Nightmare Raptor (×2)
mobList[zone][206].info = {"Nightmare", "Nightmare Raptor", nil, nil, nil}  --
mobList[zone][115].info = {"Nightmare", "Nightmare Raptor", nil, nil, nil}  -- 115-Nightmare Raptor (×2)
mobList[zone][207].info = {"Nightmare", "Nightmare Raptor", nil, nil, nil}  --
mobList[zone][116].info = {"Nightmare", "Nightmare Raptor", nil, nil, nil}  -- 116-Nightmare Raptor (×2)
mobList[zone][208].info = {"Nightmare", "Nightmare Raptor", nil, nil, nil}  --
mobList[zone][117].info = {"Nightmare", "Nightmare Raptor", nil, nil, nil}  -- 117-Nightmare Raptor (×2)
mobList[zone][209].info = {"Nightmare", "Nightmare Raptor", nil, nil, nil}  --
--Nightmare Diremite
mobList[zone][118].info = {"Nightmare", "Nightmare Diremite", nil, nil, nil} -- 118-Nightmare Diremite (×2)
mobList[zone][210].info = {"Nightmare", "Nightmare Diremite", nil, nil, nil} --
mobList[zone][119].info = {"Nightmare", "Nightmare Diremite", nil, nil, nil} -- 119-Nightmare Diremite (×2)
mobList[zone][211].info = {"Nightmare", "Nightmare Diremite", nil, nil, nil} --
mobList[zone][120].info = {"Nightmare", "Nightmare Diremite", nil, nil, nil} -- 120-Nightmare Diremite (×2)
mobList[zone][212].info = {"Nightmare", "Nightmare Diremite", nil, nil, nil} --
mobList[zone][121].info = {"Nightmare", "Nightmare Diremite", nil, nil, nil} -- 121-Nightmare Diremite (×2)
mobList[zone][213].info = {"Nightmare", "Nightmare Diremite", nil, nil, nil} --
mobList[zone][122].info = {"Nightmare", "Nightmare Diremite", nil, nil, nil} -- 122-Nightmare Diremite (×2)
mobList[zone][214].info = {"Nightmare", "Nightmare Diremite", nil, nil, nil} --
mobList[zone][123].info = {"Nightmare", "Nightmare Diremite", nil, nil, nil} -- 123-Nightmare Diremite (×2)
mobList[zone][215].info = {"Nightmare", "Nightmare Diremite", nil, nil, nil} --
mobList[zone][124].info = {"Nightmare", "Nightmare Diremite", nil, nil, nil} -- 124-Nightmare Diremite (×2)
mobList[zone][216].info = {"Nightmare", "Nightmare Diremite", nil, nil, nil} --
mobList[zone][125].info = {"Nightmare", "Nightmare Diremite", nil, nil, nil} -- 125-Nightmare Diremite (×2)
mobList[zone][217].info = {"Nightmare", "Nightmare Diremite", nil, nil, nil} --
mobList[zone][126].info = {"Nightmare", "Nightmare Diremite", nil, nil, nil} -- 126-Nightmare Diremite (×2)
mobList[zone][218].info = {"Nightmare", "Nightmare Diremite", nil, nil, nil} --
mobList[zone][127].info = {"Nightmare", "Nightmare Diremite", nil, nil, nil} -- 127-Nightmare Diremite (×2)
mobList[zone][219].info = {"Nightmare", "Nightmare Diremite", nil, nil, nil} --
mobList[zone][128].info = {"Nightmare", "Nightmare Diremite", nil, nil, nil} -- 128-Nightmare Diremite (×2)
mobList[zone][220].info = {"Nightmare", "Nightmare Diremite", nil, nil, nil} --
mobList[zone][129].info = {"Nightmare", "Nightmare Diremite", nil, nil, nil} -- 129-Nightmare Diremite (×2)
mobList[zone][221].info = {"Nightmare", "Nightmare Diremite", nil, nil, nil} --
mobList[zone][130].info = {"Nightmare", "Nightmare Diremite", nil, nil, nil} -- 130-Nightmare Diremite (×2)
mobList[zone][222].info = {"Nightmare", "Nightmare Diremite", nil, nil, nil} --
-- Nightmare Gaylas
mobList[zone][131].info = {"Nightmare", "Nightmare Gaylas", nil, nil, nil}  -- 131-Nightmare Gaylas (×3)
mobList[zone][223].info = {"Nightmare", "Nightmare Gaylas", nil, nil, nil}  --
mobList[zone][224].info = {"Nightmare", "Nightmare Gaylas", nil, nil, nil}  --
mobList[zone][132].info = {"Nightmare", "Nightmare Gaylas", nil, nil, nil}  -- 132-Nightmare Gaylas (×3)
mobList[zone][225].info = {"Nightmare", "Nightmare Gaylas", nil, nil, nil}  --
mobList[zone][226].info = {"Nightmare", "Nightmare Gaylas", nil, nil, nil}  --
mobList[zone][133].info = {"Nightmare", "Nightmare Gaylas", nil, nil, nil}  -- 133-Nightmare Gaylas (×3)
mobList[zone][227].info = {"Nightmare", "Nightmare Gaylas", nil, nil, nil}  --
mobList[zone][228].info = {"Nightmare", "Nightmare Gaylas", nil, nil, nil}  --
mobList[zone][134].info = {"Nightmare", "Nightmare Gaylas", nil, nil, nil}  -- 134-Nightmare Gaylas (×4)
mobList[zone][229].info = {"Nightmare", "Nightmare Gaylas", nil, nil, nil}  --
mobList[zone][230].info = {"Nightmare", "Nightmare Gaylas", nil, nil, nil}  --
mobList[zone][231].info = {"Nightmare", "Nightmare Gaylas", nil, nil, nil}  --
mobList[zone][135].info = {"Nightmare", "Nightmare Gaylas", nil, nil, nil}  -- 135-Nightmare Gaylas (×4)
mobList[zone][232].info = {"Nightmare", "Nightmare Gaylas", nil, nil, nil}  --
mobList[zone][233].info = {"Nightmare", "Nightmare Gaylas", nil, nil, nil}  --
mobList[zone][234].info = {"Nightmare", "Nightmare Gaylas", nil, nil, nil}  --
mobList[zone][136].info = {"Nightmare", "Nightmare Gaylas", nil, nil, nil}  -- 136-Nightmare Gaylas (×4)
mobList[zone][235].info = {"Nightmare", "Nightmare Gaylas", nil, nil, nil}  --
mobList[zone][236].info = {"Nightmare", "Nightmare Gaylas", nil, nil, nil}  --
mobList[zone][237].info = {"Nightmare", "Nightmare Gaylas", nil, nil, nil}  --
mobList[zone][137].info = {"Nightmare", "Nightmare Gaylas", nil, nil, nil}  -- 137-Nightmare Gaylas (×4)
mobList[zone][238].info = {"Nightmare", "Nightmare Gaylas", nil, nil, nil}  --
mobList[zone][239].info = {"Nightmare", "Nightmare Gaylas", nil, nil, nil}  --
mobList[zone][240].info = {"Nightmare", "Nightmare Gaylas", nil, nil, nil}  --
mobList[zone][138].info = {"Nightmare", "Nightmare Gaylas", nil, nil, nil}  -- 138-Nightmare Gaylas (×4)
mobList[zone][241].info = {"Nightmare", "Nightmare Gaylas", nil, nil, nil}  --
mobList[zone][242].info = {"Nightmare", "Nightmare Gaylas", nil, nil, nil}  --
mobList[zone][243].info = {"Nightmare", "Nightmare Gaylas", nil, nil, nil}  --

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
    1 , -- Adamantking Effigy        (001-Q)
    2 , -- Adamantking Effigy        (002-Q)
    3 , -- Adamantking Effigy        (003-Q)
    4 , -- Adamantking Effigy        (004-Q)
    5 , -- Adamantking Effigy        (005-Q)
    6 , -- Adamantking Effigy        (006-Q)
    7 , -- Adamantking Effigy        (007-Q)
    8 , -- Manifest Icon             (008-Y)
    9 , -- Manifest Icon             (009-Y)
    10, -- Manifest Icon             (010-Y)
    11, -- Manifest Icon             (011-Y)
    12, -- Manifest Icon             (012-Y)
    13, -- Manifest Icon             (013-Y)
    14, -- Manifest Icon             (014-Y)
    15, -- Manifest Icon             (015-Y)
    16, -- Serjeant Tombstone        (016-O)
    17, -- Serjeant Tombstone        (017-O)
    18, -- Serjeant Tombstone        (018-O)
    19, -- Serjeant Tombstone        (019-O)
    20, -- Serjeant Tombstone        (020-O)
    21, -- Serjeant Tombstone        (021-O)
    22, -- Serjeant Tombstone        (022-O)
    23, -- Serjeant Tombstone        (023-O)
    24, -- Serjeant Tombstone        (024-O)
    25, -- Goblin Replica            (025-G)
    26, -- Goblin Replica            (026-G)
    27, -- Goblin Replica            (027-G)
    32, -- Goblin Replica            (032-G)
    33, -- Goblin Replica            (033-G)
    34, -- Goblin Replica            (034-G)
    35, -- Goblin Replica            (035-G)
    36, -- Goblin Replica            (036-G)
    37, -- Goblin Replica            (037-G)
    38, -- Goblin Replica            (038-G)
    39, -- Goblin Replica            (039-G)
    -- Wave 1 Nightmare Mobs
    51, -- Nightmare Stirge          051-Nightmare Stirge (×4)
    52, -- Nightmare Stirge          052-Nightmare Stirge (×4)
    53, -- Nightmare Stirge          053-Nightmare Stirge (×4)
    62, -- Nightmare Stirge          062-Nightmare Stirge (×3)
    63, -- Nightmare Stirge          063-Nightmare Stirge (×4)
    58, -- Nightmare Roc             058-Nightmare Roc (×3)
    61, -- Nightmare Roc             061-Nightmare Roc (×3)
    54, -- Nightmare Snoll           054-Nightmare Snoll (×4)
    55, -- Nightmare Snoll           055-Nightmare Snoll (×4)
    56, -- Nightmare Snoll           056-Nightmare Snoll (×4)
    57, -- Nightmare Snoll           057-Nightmare Snoll (×4)
    59, -- Nightmare Snoll           059-Nightmare Snoll (×4)
    60, -- Nightmare Snoll           060-Nightmare Snoll (×4)
    -- Wave 1 Elementals and NMs
    43, -- Water Elemental           (043)
    40, -- Scolopendra               (040)
    44, -- Fire Elemental            (044)
    45, -- Thunder Elemental         (045)
    41, -- Stringes                  (041)
    46, -- Air Elemental             (046)
    47, -- Light Elemental           (047)
    48, -- Ice Elemental             (048)
    64, -- Antaeus                   (064)
    49, -- Earth Elemental           (049)
    50, -- Dark Elemental            (050)
    42  -- Suttung                   (042)
}

mobList[zone].wave2 = {
    76 , --  076-Nightmare Weapon (×3)
    77 , --  077-Nightmare Weapon (×3)
    78 , --  078-Nightmare Weapon (×3)
    79 , --  079-Nightmare Weapon (×3)
    80 , --  080-Nightmare Weapon (×3)
    81 , --  081-Nightmare Weapon (×3)
    82 , --  082-Nightmare Weapon (×3)
    83 , --  083-Nightmare Weapon (×3)
    84 , --  084-Nightmare Weapon (×3)
    85 , --  085-Nightmare Weapon (×3)
    86 , --  086-Nightmare Kraken (×2)
    87 , --  087-Nightmare Kraken (×2)
    88 , --  088-Nightmare Kraken (×2)
    89 , --  089-Nightmare Kraken (×2)
    90 , --  090-Nightmare Kraken (×2)
    91 , --  091-Nightmare Kraken (×2)
    92 , --  092-Nightmare Kraken (×2)
    93 , --  093-Nightmare Kraken (×2)
    94 , --  094-Nightmare Kraken (×2)
    95 , --  095-Nightmare Kraken (×2)
    96 , --  096-Nightmare Kraken (×2)
    97 , --  097-Nightmare Kraken (×2)
    98 , --  098-Nightmare Kraken (×3)
    99 , --  099-Nightmare Tiger (×4)
    100, --  100-Nightmare Tiger (×4)
    101, --  101-Nightmare Tiger (×4)
    102, --  102-Nightmare Tiger (×5)
    103, --  103-Nightmare Tiger (×5)
    104, --  104-Nightmare Tiger (×5)
    105, --  105-Nightmare Tiger (×5)
    106, --  106-Nightmare Raptor (×2)
    107, --  107-Nightmare Raptor (×2)
    108, --  108-Nightmare Raptor (×2)
    109, --  109-Nightmare Raptor (×2)
    110, --  110-Nightmare Raptor (×2)
    111, --  111-Nightmare Raptor (×2)
    112, --  112-Nightmare Raptor (×2)
    113, --  113-Nightmare Raptor (×2)
    114, --  114-Nightmare Raptor (×2)
    115, --  115-Nightmare Raptor (×2)
    116, --  116-Nightmare Raptor (×2)
    117, --  117-Nightmare Raptor (×2)
    118, --  118-Nightmare Diremite (×2)
    119, --  119-Nightmare Diremite (×2)
    120, --  120-Nightmare Diremite (×2)
    121, --  121-Nightmare Diremite (×2)
    122, --  122-Nightmare Diremite (×2)
    123, --  123-Nightmare Diremite (×2)
    124, --  124-Nightmare Diremite (×2)
    125, --  125-Nightmare Diremite (×2)
    126, --  126-Nightmare Diremite (×2)
    127, --  127-Nightmare Diremite (×2)
    128, --  128-Nightmare Diremite (×2)
    129, --  129-Nightmare Diremite (×2)
    130, --  130-Nightmare Diremite (×2)
    131, --  131-Nightmare Gaylas (×3)
    132, --  132-Nightmare Gaylas (×3)
    133, --  133-Nightmare Gaylas (×3)
    134, --  134-Nightmare Gaylas (×4)
    135, --  135-Nightmare Gaylas (×4)
    136, --  136-Nightmare Gaylas (×4)
    137, --  137-Nightmare Gaylas (×4)
    138, --  138-Nightmare Gaylas (×4)
    65 , --  Goblin Replica     (065-G)
    66 , --  Goblin Replica     (066-G)
    67 , --  Goblin Replica     (067-G)
    68 , --  Goblin Replica     (068-G)
    69 , --  Goblin Replica     (069-G)
    70 , --  Goblin Replica     (070-G)
    71 , --  Goblin Replica     (071-G)
    72 , --  Goblin Replica     (072-G)
    73 , --  Goblin Replica     (073-G)
    74 , --  Goblin Replica     (074-G)
    75   --  Goblin Replica     (075-G)
}

----------------------------------------------------------------------------------------------------
--                                  Setup of Children Spawning                                    --
----------------------------------------------------------------------------------------------------
------------------------------------------
--          Normal Child Spawn          --
------------------------------------------
-- mobList[zone][MobIndex].mobchildren = {#WAR, #MNK, #WHM, #BLM, #RDM, #THF, #PLD, #DRK, #BST, #BRD, #RNG, #SAM, #NIN, #DRG, #SMN}

-- Boss Area
mobList[zone][27 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil  }    -- 1 BST
mobList[zone][28 ].mobchildren = {   1, nil, nil,   1,   1, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil  }    -- 1 WAR  1 BLM  1 RDM  1 PLD
mobList[zone][29 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil  }    -- 1 DRG
mobList[zone][30 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1  }    -- 1 SMN
mobList[zone][31 ].mobchildren = { nil, nil,   1, nil, nil, nil, nil,   1, nil, nil,   1,   1, nil, nil, nil  }    -- 1 WHM  1 DRK  1 RNG  1 SAM
-- Northeast
mobList[zone][16 ].mobchildren = { nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  }    -- 1 MNK  1 WHM  1 NIN
mobList[zone][17 ].mobchildren = { nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil  }    -- 1 PLD
mobList[zone][18 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil,   1, nil  }    -- 1 BRD  1 DRG
mobList[zone][19 ].mobchildren = { nil, nil, nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }    -- 1 BLM  1 RDM
mobList[zone][20 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil  }    -- 1 DRK
mobList[zone][21 ].mobchildren = { nil,   1, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil,   1  }    -- 1 MNK  1 THF  1 SMN
mobList[zone][22 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil  }    -- 1 DRK
mobList[zone][24 ].mobchildren = {   1, nil, nil, nil, nil, nil, nil, nil,   1, nil,   1,   1, nil, nil, nil  }    -- 1 WAR  1 BST  1 RNG  1 SAM
mobList[zone][25 ].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil,   1, nil, nil, nil, nil,   1  }    -- 1 THF  1 BRD  1 SMN
mobList[zone][26 ].mobchildren = { nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1,   1, nil  }    -- 1 MNK  1 NIN  1 DRG
-- Sea Monk NM Area
mobList[zone][1  ].mobchildren = { nil,   1, nil,   1, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil  }    -- 1 MNK  1 BLM  1 THF
mobList[zone][2  ].mobchildren = {   1, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  }    -- 1 WAR  1 RDM  1 NIN
-- Southwest
mobList[zone][3  ].mobchildren = { nil, nil,   1, nil, nil, nil,   1, nil, nil, nil, nil,   1, nil, nil, nil  }    -- 1 WHM  1 PLD  1 SAM
mobList[zone][4  ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   1, nil,   1, nil, nil, nil, nil  }    -- 1 BST  1 RNG
mobList[zone][5  ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil,   1,   1, nil  }    -- 1 DRK  1 NIN  1 DRG
mobList[zone][6  ].mobchildren = { nil, nil, nil, nil,   1, nil,   1, nil,   1,   1,   1, nil, nil, nil, nil  }    -- 1 RDM  1 PLD  1 BST  1 BRD  1 RNG
mobList[zone][7  ].mobchildren = {   1, nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1  }    -- 1 WAR  1 WHM  1 BLM  1 SMN
mobList[zone][8  ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil,   1, nil, nil, nil  }    -- 1 DRK  1 SAM
mobList[zone][9  ].mobchildren = {   1, nil, nil, nil,   1, nil, nil, nil, nil,   1,   1, nil, nil, nil, nil  }    -- 1 WAR  1 RDM  1 BRD  1 RNG
mobList[zone][10 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1  }    -- 1 SMN
mobList[zone][11 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil,   1, nil, nil  }    -- 1 BST  1 NIN
mobList[zone][13 ].mobchildren = { nil,   1,   1, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil  }    -- 1 MNK  1 WHM  1 THF
mobList[zone][14 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil  }    -- 1 DRG
mobList[zone][15 ].mobchildren = { nil, nil, nil,   1, nil, nil,   1, nil, nil, nil, nil,   1, nil, nil, nil  }    -- 1 BLM  1 PLD  1 SAM
-- Golem NM Area
mobList[zone][32 ].mobchildren = { nil, nil, nil, nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil,   1  }    -- 1 RDM  1 THF  1 SMN
mobList[zone][33 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil,   1,   1, nil  }    -- 1 BRD  1 NIN  1 DRG
-- Giant Bat NM Area
mobList[zone][36 ].mobchildren = {   1, nil, nil,   1, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil  }    -- 1 WAR  1 BLM  1 BST
mobList[zone][37 ].mobchildren = { nil, nil,   1, nil, nil, nil, nil,   1, nil, nil,   1, nil, nil, nil, nil  }    -- 1 WHM  1 DRK  1 RNG
-- Wave 2 based on https://enedin.be/dyna/html/zone/frame_quf2.htm
-- Southwest
mobList[zone][65 ].mobchildren = { nil,   1, nil, nil, nil,   1, nil, nil, nil,   1,   1, nil, nil, nil, nil  }    -- 1 MNK  1 THF  1 BRD  1 RNG
mobList[zone][66 ].mobchildren = { nil,   1,   1, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil,   1  }    -- 1 MNK  1 WHM  1 PLD  1 SMN
mobList[zone][67 ].mobchildren = {   1,   1, nil,   1,   1, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil  }    -- 1 WAR  1 MNK  1 BLM  1 RDM  1 SAM
mobList[zone][68 ].mobchildren = { nil, nil,   1, nil, nil, nil,   1,   1,   1, nil, nil, nil, nil, nil, nil  }    -- 1 WHM  1 PLD  1 DRK  1 BST
-- Northeast
mobList[zone][69 ].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil,   1, nil,   1, nil,   1, nil  }    -- 1 THF  1 BRD  1 SAM  1 DRG
mobList[zone][70 ].mobchildren = {   1, nil, nil,   1,   1, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  }    -- 1 WAR  1 BLM  1 RDM  1 NIN

------------------------------------------
--            NM Child Spawn            --
------------------------------------------
-- mobList[zone][MobIndex].NMchildren = {MobIndex(NM1), MobIndex(NM2), MobIndex(NM3)}
-- boolean value = forceLink true/false

-- Nightmares
-- Wave 1
mobList[zone][51 ].NMchildren = { true, 244, 245, 246         } -- 051-Nightmare Stirge (×4)
mobList[zone][52 ].NMchildren = { true, 247, 248, 249         } -- 052-Nightmare Stirge (×4)
mobList[zone][53 ].NMchildren = { true, 250, 251, 252         } -- 053-Nightmare Stirge (×4)
mobList[zone][62 ].NMchildren = { true, 253, 254              } -- 062-Nightmare Stirge (×3)
mobList[zone][63 ].NMchildren = { true, 255, 256, 257         } -- 063-Nightmare Stirge (×4)
mobList[zone][61 ].NMchildren = { true, 260, 261              } -- 061-Nightmare Roc (×3)
mobList[zone][58 ].NMchildren = { true, 258, 259              } -- 058-Nightmare Roc (×3)
mobList[zone][54 ].NMchildren = { true, 262, 263, 264         } -- 054-Nightmare Snoll (×4)
mobList[zone][55 ].NMchildren = { true, 265, 266, 267         } -- 055-Nightmare Snoll (×4)
mobList[zone][56 ].NMchildren = { true, 268, 269, 270         } -- 056-Nightmare Snoll (×4)
mobList[zone][57 ].NMchildren = { true, 271, 272, 273         } -- 057-Nightmare Snoll (×4)
mobList[zone][59 ].NMchildren = { true, 274, 275, 276         } -- 059-Nightmare Snoll (×4)
mobList[zone][60 ].NMchildren = { true, 277, 278, 279         } -- 060-Nightmare Snoll (×4)

-- Wave 2NMchildren
mobList[zone][76 ].NMchildren = { true, 139, 140              } -- 076-Nightmare Weapon (×3)
mobList[zone][77 ].NMchildren = { true, 141, 142              } -- 077-Nightmare Weapon (×3)
mobList[zone][78 ].NMchildren = { true, 143, 144              } -- 078-Nightmare Weapon (×3)
mobList[zone][79 ].NMchildren = { true, 145, 146              } -- 079-Nightmare Weapon (×3)
mobList[zone][80 ].NMchildren = { true, 147, 148              } -- 080-Nightmare Weapon (×3)
mobList[zone][81 ].NMchildren = { true, 149, 150              } -- 081-Nightmare Weapon (×3)
mobList[zone][82 ].NMchildren = { true, 151, 152              } -- 082-Nightmare Weapon (×3)
mobList[zone][83 ].NMchildren = { true, 153, 154              } -- 083-Nightmare Weapon (×3)
mobList[zone][84 ].NMchildren = { true, 155, 156              } -- 084-Nightmare Weapon (×3)
mobList[zone][85 ].NMchildren = { true, 157, 158              } -- 085-Nightmare Weapon (×3)
mobList[zone][86 ].NMchildren = { true, 159                   } -- 086-Nightmare Kraken (×2)
mobList[zone][87 ].NMchildren = { true, 160                   } -- 087-Nightmare Kraken (×2)
mobList[zone][88 ].NMchildren = { true, 161                   } -- 088-Nightmare Kraken (×2)
mobList[zone][89 ].NMchildren = { true, 162                   } -- 089-Nightmare Kraken (×2)
mobList[zone][90 ].NMchildren = { true, 163                   } -- 090-Nightmare Kraken (×2)
mobList[zone][91 ].NMchildren = { true, 164                   } -- 091-Nightmare Kraken (×2)
mobList[zone][92 ].NMchildren = { true, 165                   } -- 092-Nightmare Kraken (×2)
mobList[zone][93 ].NMchildren = { true, 166                   } -- 093-Nightmare Kraken (×2)
mobList[zone][94 ].NMchildren = { true, 167                   } -- 094-Nightmare Kraken (×2)
mobList[zone][95 ].NMchildren = { true, 168                   } -- 095-Nightmare Kraken (×2)
mobList[zone][96 ].NMchildren = { true, 169                   } -- 096-Nightmare Kraken (×2)
mobList[zone][97 ].NMchildren = { true, 170                   } -- 097-Nightmare Kraken (×2)
mobList[zone][98 ].NMchildren = { true, 171, 172              } -- 098-Nightmare Kraken (×3)
mobList[zone][99 ].NMchildren = { true, 173, 174, 175         } -- 099-Nightmare Tiger (×4)
mobList[zone][100].NMchildren = { true, 176, 177, 178         } -- 100-Nightmare Tiger (×4)
mobList[zone][101].NMchildren = { true, 179, 180, 181         } -- 101-Nightmare Tiger (×4)
mobList[zone][102].NMchildren = { true, 182, 183, 184, 185    } -- 102-Nightmare Tiger (×5)
mobList[zone][103].NMchildren = { true, 186, 187, 188, 189    } -- 103-Nightmare Tiger (×5)
mobList[zone][104].NMchildren = { true, 190, 191, 192, 193    } -- 104-Nightmare Tiger (×5)
mobList[zone][105].NMchildren = { true, 194, 195, 196, 197    } -- 105-Nightmare Tiger (×5)
mobList[zone][106].NMchildren = { true, 198                   } -- 106-Nightmare Raptor (×2)
mobList[zone][107].NMchildren = { true, 199                   } -- 107-Nightmare Raptor (×2)
mobList[zone][108].NMchildren = { true, 200                   } -- 108-Nightmare Raptor (×2)
mobList[zone][109].NMchildren = { true, 201                   } -- 109-Nightmare Raptor (×2)
mobList[zone][110].NMchildren = { true, 202                   } -- 110-Nightmare Raptor (×2)
mobList[zone][111].NMchildren = { true, 203                   } -- 111-Nightmare Raptor (×2)
mobList[zone][112].NMchildren = { true, 204                   } -- 112-Nightmare Raptor (×2)
mobList[zone][113].NMchildren = { true, 205                   } -- 113-Nightmare Raptor (×2)
mobList[zone][114].NMchildren = { true, 206                   } -- 114-Nightmare Raptor (×2)
mobList[zone][115].NMchildren = { true, 207                   } -- 115-Nightmare Raptor (×2)
mobList[zone][116].NMchildren = { true, 208                   } -- 116-Nightmare Raptor (×2)
mobList[zone][117].NMchildren = { true, 209                   } -- 117-Nightmare Raptor (×2)
mobList[zone][118].NMchildren = { true, 210                   } -- 118-Nightmare Diremite (×2)
mobList[zone][119].NMchildren = { true, 211                   } -- 119-Nightmare Diremite (×2)
mobList[zone][120].NMchildren = { true, 212                   } -- 120-Nightmare Diremite (×2)
mobList[zone][121].NMchildren = { true, 213                   } -- 121-Nightmare Diremite (×2)
mobList[zone][122].NMchildren = { true, 214                   } -- 122-Nightmare Diremite (×2)
mobList[zone][123].NMchildren = { true, 215                   } -- 123-Nightmare Diremite (×2)
mobList[zone][124].NMchildren = { true, 216                   } -- 124-Nightmare Diremite (×2)
mobList[zone][125].NMchildren = { true, 217                   } -- 125-Nightmare Diremite (×2)
mobList[zone][126].NMchildren = { true, 218                   } -- 126-Nightmare Diremite (×2)
mobList[zone][127].NMchildren = { true, 219                   } -- 127-Nightmare Diremite (×2)
mobList[zone][128].NMchildren = { true, 220                   } -- 128-Nightmare Diremite (×2)
mobList[zone][129].NMchildren = { true, 221                   } -- 129-Nightmare Diremite (×2)
mobList[zone][130].NMchildren = { true, 222                   } -- 130-Nightmare Diremite (×2)
mobList[zone][131].NMchildren = { true, 223, 224              } -- 131-Nightmare Gaylas (×3)
mobList[zone][132].NMchildren = { true, 225, 226              } -- 132-Nightmare Gaylas (×3)
mobList[zone][133].NMchildren = { true, 227, 228              } -- 133-Nightmare Gaylas (×3)
mobList[zone][134].NMchildren = { true, 229, 230, 231         } -- 134-Nightmare Gaylas (×4)
mobList[zone][135].NMchildren = { true, 232, 233, 234         } -- 135-Nightmare Gaylas (×4)
mobList[zone][136].NMchildren = { true, 235, 236, 237         } -- 136-Nightmare Gaylas (×4)
mobList[zone][137].NMchildren = { true, 238, 239, 240         } -- 137-Nightmare Gaylas (×4)
mobList[zone][138].NMchildren = { true, 241, 242, 243         } -- 138-Nightmare Gaylas (×4)

------------------------------------------
--          Mob Position Info           --
-- Note: Must be setup for parent mobs, --
-- but is optional for children.        --
------------------------------------------
-- mobList[zone][MobIndex].pos = {xpos, ypos, zpos, rot}

-- Statues Wave 1 and Wave 2
mobList[zone][1  ].pos = { -260.608, -19.032, 43.783, 6    } -- Adamantking Effigy      (001-Q)
mobList[zone][2  ].pos = { -249.283, -19.988, 45.831, 6    } -- Adamantking Effigy      (002-Q)
mobList[zone][3  ].pos = { -207.631, -19.944, 106.263, 28  } -- Adamantking Effigy      (003-Q)
mobList[zone][4  ].pos = { -193.663, -19.635, 131.329, 68  } -- Adamantking Effigy      (004-Q)
mobList[zone][5  ].pos = { -205.758, -20.089, 162.879, 203 } -- Adamantking Effigy      (005-Q)
mobList[zone][6  ].pos = { -118.681, 20.019, 195.651, 27   } -- Adamantking Effigy      (006-Q)
mobList[zone][7  ].pos = { -116.667, -19.829, 207.454, 48  } -- Adamantking Effigy      (007-Q)
mobList[zone][8  ].pos = { -1.307, -19.138, -17.269, 129   } -- Manifest Icon           (008-Y)
mobList[zone][9  ].pos = { 13.437, -20.824, -21.301, 128   } -- Manifest Icon           (009-Y)
mobList[zone][10 ].pos = { 37.826, -19.383, -14.216, 237   } -- Manifest Icon           (010-Y)
mobList[zone][11 ].pos = { 60.955, -19.612, 11.245, 81     } -- Manifest Icon           (011-Y)
mobList[zone][12 ].pos = { 81.461, -19.891, 6.198, 107     } -- Manifest Icon           (012-Y)
mobList[zone][13 ].pos = { 93.956, -20.051, -14.926, 137   } -- Manifest Icon           (013-Y)
mobList[zone][14 ].pos = { 109.566, -19.994, -6.029, 113   } -- Manifest Icon           (014-Y)
mobList[zone][15 ].pos = { 121.584, -20.000, 0.963, 180    } -- Manifest Icon           (015-Y)
mobList[zone][16 ].pos = { 140.120, -19.025, 75.671, 154   } -- Serjeant Tombstone      (016-O)
mobList[zone][17 ].pos = { 138.601, -19.895, 65.463, 165   } -- Serjeant Tombstone      (017-O)
mobList[zone][18 ].pos = { 151.705, -19.830, 68.108, 146   } -- Serjeant Tombstone      (018-O)
mobList[zone][19 ].pos = { 101.349, -20.176, 150.119, 38   } -- Serjeant Tombstone      (019-O)
mobList[zone][20 ].pos = { 111.338, -19.739, 150.965, 48   } -- Serjeant Tombstone      (020-O)
mobList[zone][21 ].pos = { 55.335, -19.323, 234.979, 79    } -- Serjeant Tombstone      (021-O)
mobList[zone][22 ].pos = { 56.364, -20.275, 249.147, 44    } -- Serjeant Tombstone      (022-O)
mobList[zone][23 ].pos = { 0.556, -20.427, 242.431, 50     } -- Serjeant Tombstone      (023-O)
mobList[zone][24 ].pos = { 1.133, -19.029, 260.556, 129    } -- Serjeant Tombstone      (024-O)
mobList[zone][25 ].pos = { -91.348, -19.634, 242.081, 171  } -- Goblin Replica          (025-G)
mobList[zone][26 ].pos = { -85.062, -19.723, 267.683, 91   } -- Goblin Replica          (026-G)
mobList[zone][27 ].pos = { -216.469, -19.178, 319.638, 255 } -- Goblin Replica          (027-G)
mobList[zone][28 ].pos = { -254.048, -20.000, 300.553, 224 } -- Goblin Replica          (028-G)
mobList[zone][29 ].pos = { -256.694, -20.000, 313.411, 231 } -- Goblin Replica          (029-G)
mobList[zone][30 ].pos = { -253.725, -20.000, 329.286, 9   } -- Goblin Replica          (030-G)
mobList[zone][31 ].pos = { -250.551, -19.933, 341.246, 43  } -- Goblin Replica          (031-G)
mobList[zone][32 ].pos = { -288.097, -11.721, 475.140, 225 } -- Goblin Replica          (032-G)
mobList[zone][33 ].pos = { -312.791, -11.762, 483.752, 247 } -- Goblin Replica          (033-G)
mobList[zone][34 ].pos = { -546.876, -8.836, 416.088, 8    } -- Goblin Replica          (034-G)
mobList[zone][35 ].pos = { -550.221, -7.494, 422.123, 13   } -- Goblin Replica          (035-G)
mobList[zone][36 ].pos = { 174.031, 20.747, -202.030, 204  } -- Goblin Replica          (036-G)
mobList[zone][37 ].pos = { 163.990, 20.081, -208.679, 232  } -- Goblin Replica          (037-G)
mobList[zone][38 ].pos = { 140.386, 17.982, -431.949, 214  } -- Goblin Replica          (038-G)
mobList[zone][39 ].pos = { 142.936, 18.121, -436.945, 196  } -- Goblin Replica          (039-G)
mobList[zone][65 ].pos = { -108.072, -20.30, 191.006, 154  } -- Goblin Replica          (065-G)
mobList[zone][66 ].pos = { -112.225, -20.560, 188.736, 160 } -- Goblin Replica          (066-G)
mobList[zone][67 ].pos = { -77.407, -19.770, 19.093, 134   } -- Goblin Replica          (067-G)
mobList[zone][68 ].pos = { -59.591, -19.733, -2.097, 34    } -- Goblin Replica          (068-G)
mobList[zone][69 ].pos = { 21.350, -19.769, 187.950, 155   } -- Goblin Replica          (069-G)
mobList[zone][70 ].pos = { -2.647, -20.584, 191.007, 239   } -- Goblin Replica          (070-G)
mobList[zone][71 ].pos = { -44.788, -20.040, 122.724, 162  } -- Goblin Replica          (071-G)
mobList[zone][72 ].pos = { -45.871, -20.082, 75.716, 94    } -- Goblin Replica          (072-G)
mobList[zone][73 ].pos = { 5.245, -20.007, 125.149, 223    } -- Goblin Replica          (073-G)
mobList[zone][74 ].pos = { -7.265, -18.019, 101.000, 9     } -- Goblin Replica          (074-G)
mobList[zone][75 ].pos = { -18.812, -17.300, 104.154, 9    } -- Goblin Replica          (075-G)
-- Wave 1 Nightmare Mobs + NMs + Elementals Based on https://enedin.be/dyna/html/zone/frame_quf1.htm
mobList[zone][51 ].pos = { -61.614, -19.824, 36.806, 64    } -- 051-Nightmare Stirge (×4)
mobList[zone][52 ].pos = { 21.479, -19.832, 153.201, 79    } -- 052-Nightmare Stirge (×4)
mobList[zone][53 ].pos = { -60.969, -19.775, 153.545, 54   } -- 053-Nightmare Stirge (×4)
mobList[zone][62 ].pos = { 143.273, 21.394, -348.023, 144  } -- 062-Nightmare Stirge (×3)
mobList[zone][63 ].pos = { 153.181, 20.601, -370.837, 193  } -- 063-Nightmare Stirge (×4)
mobList[zone][61 ].pos = { 153.580, -19.718, -20.217, 128  } -- 061-Nightmare Roc (×3)
mobList[zone][48 ].pos = { -221.369, -19.805, 437.399, 56  } -- Ice Elemental           (048)
mobList[zone][54 ].pos = { -136.073, -20.377, 344.4214, 102} -- 054-Nightmare Snoll (×4)
mobList[zone][55 ].pos = { -132.776, -19.527, 320.005, 118 } -- 055-Nightmare Snoll (×4)
mobList[zone][56 ].pos = { -156.819, -20.000, 362.471, 98  } -- 056-Nightmare Snoll (×4)
mobList[zone][57 ].pos = { -157.837, -19.317, 334.877, 115 } -- 057-Nightmare Snoll (×4)
mobList[zone][59 ].pos = { -475.226, -11.232, 385.530, 207 } -- 059-Nightmare Snoll (×4)
mobList[zone][60 ].pos = { -496.717, -12.481, 379.136, 236 } -- 060-Nightmare Snoll (×4)
mobList[zone][40 ].pos = { -264.477, -3.417, 24.961, 60    } -- Scolopendra             ( 040 )
mobList[zone][41 ].pos = { 149.787, 21.221, -409.158, 185  } -- Stringes                ( 041 )
mobList[zone][64 ].pos = { -257.040, -20.000, 319.628, 254 } -- Antaeus                 ( 064 )
mobList[zone][42 ].pos = { -535.544, -13.042, 386.895, 51  } -- Suttung                 ( 042 )
mobList[zone][43 ].pos = { -278.296, -19.902, 74.020, 57   } -- Water Elemental         ( 043 )
mobList[zone][44 ].pos = { 19.150, -19.260, -86.259, 193   } -- Fire Elemental          ( 044 )
mobList[zone][45 ].pos = { 158.148, 20.219, -230.048, 184  } -- Thunder Elemental       ( 045 )
mobList[zone][46 ].pos = { 163.632, -19.481, 133.232, 94   } -- Air Elemental           ( 046 )
mobList[zone][47 ].pos = { 29.825, -19.906, 288.771, 77    } -- Light Elemental         ( 047 )
mobList[zone][48 ].pos = { -214.001, -19.742, 392.671, 60  } -- Ice Elemental           ( 048 )
mobList[zone][49 ].pos = { -338.197, -12.949, 531.737, 70  } -- Earth Elemental         ( 049 )
mobList[zone][50 ].pos = { -428.031, -12.956, 337.849, 136 } -- Dark Elemental          ( 050 )
-- Wave 2 Nightmare Mobs Based on https://enedin.be/dyna/html/zone/frame_quf2.htm
mobList[zone][76 ].pos = { -121.628, -19.756, 208.912, 96  } -- 076-Nightmare Weapon (×3)
mobList[zone][77 ].pos = { -134.926, -19.311, 196.783, 161 } -- 077-Nightmare Weapon (×3)
mobList[zone][78 ].pos = { -146.120, -20.016, 210.193, 132 } -- 078-Nightmare Weapon (×3)
mobList[zone][79 ].pos = { -130.309, -19.514, 223.921, 94  } -- 079-Nightmare Weapon (×3)
mobList[zone][80 ].pos = { -152.466, -19.784, 228.106, 80  } -- 080-Nightmare Weapon (×3)
mobList[zone][81 ].pos = { -180.295, -19.421, 234.489, 124 } -- 081-Nightmare Weapon (×3)
mobList[zone][82 ].pos = { -179.492, -19.027, 202.111, 128 } -- 082-Nightmare Weapon (×3)
mobList[zone][83 ].pos = { -204.581, -19.972, 196.347, 177 } -- 083-Nightmare Weapon (×3)
mobList[zone][84 ].pos = { -232.019, -19.347, 217.225, 225 } -- 084-Nightmare Weapon (×3)
mobList[zone][85 ].pos = { -223.150, -19.996, 252.186, 131 } -- 085-Nightmare Weapon (×3)
mobList[zone][86 ].pos = { -218.359, -19.083, 38.272, 239  } -- 086-Nightmare Kraken (×2)
mobList[zone][87 ].pos = { -243.159, -20.207, 27.225, 198  } -- 087-Nightmare Kraken (×2)
mobList[zone][88 ].pos = { -250.003, -20.170, 47.660, 69   } -- 088-Nightmare Kraken (×2)
mobList[zone][89 ].pos = { -265.529, -19.342, 39.694, 8    } -- 089-Nightmare Kraken (×2)
mobList[zone][90 ].pos = { -276.600, -19.065, 61.284, 83   } -- 090-Nightmare Kraken (×2)
mobList[zone][91 ].pos = { -294.936, -20.308, 50.588, 29   } -- 091-Nightmare Kraken (×2)
mobList[zone][92 ].pos = { -282.784, -19.906, 23.687, 238  } -- 092-Nightmare Kraken (×2)
mobList[zone][93 ].pos = { -277.102, -20.299, 87.588, 87   } -- 093-Nightmare Kraken (×2)
mobList[zone][94 ].pos = { -311.925, -19.710, 58.419, 10   } -- 094-Nightmare Kraken (×2)
mobList[zone][95 ].pos = { -332.640, -20.770, 56.555, 26   } -- 095-Nightmare Kraken (×2)
mobList[zone][96 ].pos = { -341.548, -20.000, 40.281, 235  } -- 096-Nightmare Kraken (×2)
mobList[zone][97 ].pos = { -304.406, -13.677, 26.310, 162  } -- 097-Nightmare Kraken (×2)
mobList[zone][98 ].pos = { -287.617, -6.243, 14.683, 150   } -- 098-Nightmare Kraken (×3)
mobList[zone][99 ].pos = { -5.263, -19.257, -17.494, 134   } -- 099-Nightmare Tiger (×4)
mobList[zone][100].pos = { 9.803, -19.711, 2.171, 83       } -- 100-Nightmare Tiger (×4)
mobList[zone][101].pos = { 16.809, -19.160, -37.493, 160   } -- 101-Nightmare Tiger (×4)
mobList[zone][102].pos = { 31.847, -19.619, -23.678, 129   } -- 102-Nightmare Tiger (×5)
mobList[zone][103].pos = { 26.496, -19.454, 2.021, 98      } -- 103-Nightmare Tiger (×5)
mobList[zone][104].pos = { 42.812, -19.072, -18.570, 125   } -- 104-Nightmare Tiger (×5)
mobList[zone][105].pos = { 42.515, -20.000, -43.731, 152   } -- 105-Nightmare Tiger (×5)
mobList[zone][106].pos = { 130.669, -19.668, 82.273, 117   } -- 106-Nightmare Raptor (×2)
mobList[zone][107].pos = { 148.374, -19.620, 76.792, 122   } -- 107-Nightmare Raptor (×2)
mobList[zone][108].pos = { 160.662, -19.133, 97.363, 111   } -- 108-Nightmare Raptor (×2)
mobList[zone][109].pos = { 145.314, -19.913, 105.753, 129  } -- 109-Nightmare Raptor (×2)
mobList[zone][110].pos = { 123.742, -19.506, 107.013, 90   } -- 110-Nightmare Raptor (×2)
mobList[zone][111].pos = { 119.467, -20.012, 123.786, 77   } -- 111-Nightmare Raptor (×2)
mobList[zone][112].pos = { 139.221, -19.040, 121.758, 128  } -- 112-Nightmare Raptor (×2)
mobList[zone][113].pos = { 157.073, -20.000, 120.170, 126  } -- 113-Nightmare Raptor (×2)
mobList[zone][114].pos = { 162.310, -19.547, 147.419, 96   } -- 114-Nightmare Raptor (×2)
mobList[zone][115].pos = { 146.681, -19.473, 160.135, 96   } -- 115-Nightmare Raptor (×2)
mobList[zone][116].pos = { 123.247, -19.623, 148.440, 78   } -- 116-Nightmare Raptor (×2)
mobList[zone][117].pos = { 196.789, -20.000, 119.545, 127  } -- 117-Nightmare Raptor (×2)
mobList[zone][118].pos = { -270.470, -10.747, 487.465, 231 } -- 118-Nightmare Diremite (×2)
mobList[zone][119].pos = { -275.038, -11.989, 471.655, 162 } -- 119-Nightmare Diremite (×2)
mobList[zone][120].pos = { -284.911, -12.086, 484.757, 245 } -- 120-Nightmare Diremite (×2)
mobList[zone][121].pos = { -296.533, -11.751, 491.319, 54  } -- 121-Nightmare Diremite (×2)
mobList[zone][122].pos = { -300.984, -11.000, 478.629, 248 } -- 122-Nightmare Diremite (×2)
mobList[zone][123].pos = { -298.767, -12.114, 463.578, 218 } -- 123-Nightmare Diremite (×2)
mobList[zone][124].pos = { -308.469, -12.394, 456.989, 202 } -- 124-Nightmare Diremite (×2)
mobList[zone][125].pos = { -320.408, -12.000, 472.749, 7   } -- 125-Nightmare Diremite (×2)
mobList[zone][126].pos = { -332.928, -12.946, 467.776, 207 } -- 126-Nightmare Diremite (×2)
mobList[zone][127].pos = { -316.672, -11.611, 450.671, 221 } -- 127-Nightmare Diremite (×2)
mobList[zone][128].pos = { -318.770, -11.912, 428.749, 215 } -- 128-Nightmare Diremite (×2)
mobList[zone][129].pos = { -332.708, -11.348, 443.779, 234 } -- 129-Nightmare Diremite (×2)
mobList[zone][130].pos = { -358.722, -12.000, 442.357, 2   } -- 130-Nightmare Diremite (×2)
mobList[zone][131].pos = { 255.054, -9.825, -20.566, 157   } -- 131-Nightmare Gaylas (×3)
mobList[zone][132].pos = { 209.686, 21.250, -150.013, 232  } -- 132-Nightmare Gaylas (×3)
mobList[zone][133].pos = { 191.926, 20.154, -154.146, 32   } -- 133-Nightmare Gaylas (×3)
mobList[zone][134].pos = { 198.768, 20.933, -175.515, 216  } -- 134-Nightmare Gaylas (×4)
mobList[zone][135].pos = { 185.369, 20.750, -195.772, 193  } -- 135-Nightmare Gaylas (×4)
mobList[zone][136].pos = { 162.382, 20.186, -194.457, 241  } -- 136-Nightmare Gaylas (×4)
mobList[zone][137].pos = { 153.565, 20.512, -214.524, 219  } -- 137-Nightmare Gaylas (×4)
mobList[zone][138].pos = { 165.904, 20.263, -235.467, 209  } -- 138-Nightmare Gaylas (×4)

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

mobList[zone][25 ].eyes = dynamisEyesEra.BLUE
mobList[zone][26 ].eyes = dynamisEyesEra.GREEN
mobList[zone][27 ].eyes = dynamisEyesEra.BLUE
mobList[zone][34 ].eyes = dynamisEyesEra.BLUE
mobList[zone][35 ].eyes = dynamisEyesEra.GREEN
mobList[zone][72 ].eyes = dynamisEyesEra.BLUE

------------------------------------------
--        Time Extension Values         --
------------------------------------------
-- mobList[zone][MobIndex].timeExtension = 15

mobList[zone][64].timeExtension = 60
