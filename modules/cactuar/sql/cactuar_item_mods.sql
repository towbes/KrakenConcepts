LOCK TABLES `item_mods` WRITE,
            `item_equipment` WRITE,
            `item_weapon` WRITE,
            `item_mods_pet` WRITE,
            `item_latents` WRITE;

REPLACE INTO `item_equipment` (`itemId`, `name`, `level`, `ilevel`, `jobs`, `MId`, `shieldSize`, `scriptType`, `slot`, `rslot`, `su_level`) VALUES

(17042,'bronze_hammer',5,0,1048644,113,0,0,3,0,0), 
(17144,'bronze_hammer_+1',5,0,1048644,113,0,0,3,0,0),
(17043,'brass_hammer',12,0,1048644,114,0,0,3,0,0),
(17149,'brass_hammer_+1',12,0,1048644,114,0,0,3,0,0),
(17048,'decurions_hammer',18,0,1048644,115,0,0,3,0,0),
(17044,'warhammer',20,0,1048644,115,0,0,3,0,0),
(17115,'warhammer_+1',20,0,1048644,115,0,0,3,0,0),
(17452,'bastokan_hammer',23,0,1048644,115,0,0,3,0,0),
(17453,'republic_hammer',23,0,1048644,115,0,0,3,0,0),
(17083,'time_hammer',47,0,1048644,115,0,0,3,0,0),
(17045,'maul',31,0,1048644,116,0,0,3,0,0),
(17121,'maul_+1',31,0,1048644,116,0,0,3,0,0),
(17080,'holy_maul',38,0,1048644,116,0,0,3,0,0),
(17114,'holy_maul_+1',38,0,1048644,116,0,0,3,0,0),
(18392,'sacred_maul',38,0,1048644,116,0,0,3,0,0),
(18853,'spirit_maul',38,0,1048644,116,0,0,3,0,0),
(17046,'darksteel_maul',65,0,1048644,112,0,0,3,0,0),
(17432,'darksteel_maul_+1',65,0,1048644,112,0,0,3,0,0),
(18320,'relic_maul',75,0,68,114,0,0,3,0,0),
(18321,'battering_maul',75,0,68,114,0,0,3,0,0),
(18322,'dynamis_maul',75,0,68,114,0,0,3,0,0),
(18870,'dweomer_maul',75,0,68,112,0,0,3,0,0),
(17462,'platoon_mace',20,0,1589324,104,0,0,3,0,0),
(17450,'healing_mace',52,0,68,104,0,0,3,0,0),
(17429,'dominion_mace',59,0,68,105,0,0,3,0,0),
(17471,'horrent_mace',70,0,2097345,103,0,0,3,0,0),
(17464,'purgatory_mace',70,0,68,103,0,0,3,0,0),
(17458,'rsv.cpt._mace',71,0,1590111,105,0,0,3,0,0),
(18854,'fourth_mace',71,0,1590111,105,0,0,3,0,0),

(18260,'relic_knuckles',75,0,131074,135,0,0,1,0,0), -- Add PUP
(18261,'militant_knuckles',75,0,131074,135,0,0,1,0,0),
(18262,'dynamis_knuckles',75,0,131074,135,0,0,1,0,0),
(18263,'caestus',75,0,131074,135,0,1,1,0,0),
(18264,'spharai',75,0,131074,511,0,1,1,0,0),

(18266,'relic_dagger',75,0,262704,163,0,0,3,0,0), -- Add DNC
(18267,'malefic_dagger',75,0,262704,163,0,0,3,0,0),
(18268,'dynamis_dagger',75,0,262704,163,0,0,3,0,0),
(18269,'batardeau',75,0,262704,163,0,1,3,0,0),
(18270,'mandau',75,0,262704,334,0,1,3,0,0),

(18272,'relic_sword',75,0,32848,269,0,0,3,0,0), -- Add BLU
(18273,'glyptic_sword',75,0,32848,269,0,0,3,0,0),
(18274,'dynamis_sword',75,0,32848,269,0,0,3,0,0),
(18275,'caliburn',75,0,32848,269,0,1,3,0,0),
(18276,'excalibur',75,0,32848,320,0,1,3,0,0),

(18278,'relic_blade',75,0,2097345,72,0,0,1,0,0), -- Add RUN
(18279,'gilded_blade',75,0,2097345,72,0,0,1,0,0),
(18280,'dynamis_blade',75,0,2097345,72,0,0,1,0,0),
(18281,'valhalla',75,0,2097345,64,0,1,1,0,0),
(18282,'ragnarok',75,0,2097345,319,0,1,1,0,0),

(18320,'relic_maul',75,0,1048644,114,0,0,3,0,0), -- Add PLD/GEO
(18321,'battering_maul',75,0,1048644,114,0,0,3,0,0),
(18322,'dynamis_maul',75,0,1048644,114,0,0,3,0,0),
(18323,'gullintani',75,0,1048644,114,0,1,3,0,0),
(18324,'mjollnir',75,0,1048644,307,0,1,3,0,0),

(18326,'relic_staff',75,0,540680,295,0,0,1,0,0), -- Add SCH
(18327,'sages_staff',75,0,540680,295,0,0,1,0,0),
(18328,'dynamis_staff',75,0,540680,295,0,0,1,0,0),
(18329,'thyrus',75,0,540680,295,0,1,1,0,0),
(18330,'claustrum',75,0,540680,342,0,1,1,0,0),

(18332,'relic_gun',75,0,66560,58,0,0,4,0,0), -- Add COR
(18333,'marksman_gun',75,0,66560,58,0,0,4,0,0),
(18334,'dynamis_gun',75,0,66560,58,0,0,4,0,0),
(18335,'ferdinand',75,0,66560,58,0,1,4,0,0),
(18336,'annihilator',75,0,66560,85,0,1,4,0,0),

(16555,'ridill',70,0,36257,259,0,0,3,0,0), -- Add BLU

-- Lv 75+ Treasure Casket Items
(10924,'chocobo_torque',70,0,4194303,0,0,0,512,0,0),     -- Lv 81 -> Lv 70
(10925,'fishers_torque',70,0,4194303,0,0,0,512,0,0),     -- Lv 81 -> Lv 70
(10926,'field_torque',70,0,4194303,0,0,0,512,0,0),       -- Lv 81 -> Lv 70
(11767,'chocobo_rope',70,0,4194303,0,0,0,1024,0,0),      -- Lv 81 -> Lv 70
(11768,'fishers_rope',70,0,4194303,0,0,0,1024,0,0),      -- Lv 81 -> Lv 70
(11769,'field_rope',70,0,4194303,0,0,0,1024,0,0),        -- Lv 81 -> Lv 70
(11920,'melaco_mittens',75,0,2472947,14,0,0,64,0,0),     -- Lv 90 -> Lv 75
(11038,'dragonkin_earring',75,0,8641,0,0,0,6144,0,0),    -- Lv 95 -> Lv 75
(11823,'cocoon_band',72,0,4194303,0,0,0,16,0,0),         -- Lv 88 -> Lv 72
(10991,'rancorous_mantle',75,0,4194303,0,0,0,32768,0,0), -- Lv 98 -> Lv 75
(18812,'ossa_grip',75,0,4194303,0,0,0,2,0,0),            -- Lv 88 -> Lv 75
(16202,'dagdas_shield',75,0,193,26,3,0,2,0,0),           -- Lv 90 -> Lv 75
(18784,'metasoma_katars',75,0,131219,118,0,0,1,0,0),     -- Lv 88 -> Lv 75
(11041,'liminus_earring',70,0,4194303,0,0,0,6144,0,0),   -- Lv 91 -> Lv 70
(18624,'numen_staff',72,0,1590047,291,0,0,1,0,0),        -- Lv 79 -> Lv 72
(11039,'brachyura_earring',72,0,4194303,0,0,0,6144,0,0), -- Lv 91 -> Lv 72
(18816,'wizzan_grip',72,0,4194303,0,0,0,2,0,0),          -- Lv 91 -> Lv 72
(18817,'furtive_grip',72,0,4194303,0,0,0,2,0,0),         -- Lv 93 -> Lv 72
(11575,'grapevine_cape',72,0,1753628,0,0,0,32768,0,0),   -- Lv 86 -> Lv 72
(19780,'mana_ampulla',72,0,1589788,0,0,0,8,0,0),         -- Lv 97 -> Lv 72
(11040,'terminus_earring',70,0,4194303,0,0,0,6144,0,0),  -- Lv 91 -> Lv 70
(11576,'bond_cape',70,0,1753628,0,0,0,32768,0,0),        -- Lv 90 -> Lv 70
(19779,'potestas_bomblet',75,0,2500642,0,0,0,8,0,0),     -- Lv 96 -> Lv 75
(11677,'prouesse_ring',70,0,4194303,0,0,0,24576,0,0),    -- Lv 77 -> Lv 70

(17902,'lucky_broth',75,0,256,0,0,0,8,0,0);              -- Lv 86 -> Lv 75

REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES
-- Melaco Mittens
(11920,1,19),     -- DEF: 19
(11920,13,3),     -- MND: 3
(11920,161,-300), -- DMGPHYS: -300
(11920,225,5),    -- BIRD_KILLER: 5

-- Dragonkin Earring
(11038,23,5), -- ATT: 5

-- Cocoon Band
(11823,1,20),   -- DEF: 20
(11823,17,-10), -- WIND_RES: -10

-- Rancorous Mantle
(10991,1,8),   -- DEF: 8
(10991,23,10), -- ATT: 10

-- Potestas Bomblet
(19779,23,10), -- ATT: 10
(19779,8,1),   -- STR: 1

-- Grapevine Cape
(11575,1,7),     -- DEF: 5
(11575,12,2),    -- INT: 2
(11575,13,2),    -- MND: 2
(11575,2026,30), -- Refresh Duration +30s

-- Sniping Bow
(17188,11,4),  -- AGI +4
(17188,27,-1), -- Enmity -1
(17188,26,10), -- RACC +10
(17188,24,5),  -- RATT +5

-- Razor Axe
(16678,8,2),   -- STR +2
(16678,288,2), -- Double Attack +2

-- Beat Cesti
(17478,9,2),   -- DEX +2
(17478,10,2),  -- VIT +2
(17478,25,3),  -- ACC +3
(17478,291,2), -- Counter +2

-- Blessed Hammer
(17422,5,10),   -- MP +10
(17422,13,2),   -- MND +2
(17422,374,5),  -- Cure Potency +5% 
(18391,431,1),  -- ITEM_ADDEFFECT_TYPE: 1
(18391,499,7),  -- ITEM_SUBEFFECT: 7
(18391,500,10), -- ITEM_ADDEFFECT_DMG: 21
(18391,501,10), -- ITEM_ADDEFFECT_CHANCE: 20
(18391,950,7),  -- ITEM_ADDEFFECT_ELEMENT: 7

-- Casting Wand
(17423,5,20),  -- MP +20
(17423,12,2),  -- INT +2
(17423,28,3),  -- MATT +3
(17423,487,5), -- Magic Burst Potency +5%

-- Marauder's Knife
(16764,9,2),   -- DEX +2
(16764,11,2),  -- AGI +2
(16764,298,3), -- Steal +1
(16764,68,2),  -- EVA +2

-- Honor Sword
(17643,10,2),   -- VIT +2
(17643,13,2),   -- MND +2
(17643,27,1),   -- Enmity +1
(17643,387,-2), -- Physical damage taken -2%

-- Raven Scythe
(16798,8,2),    -- STR +2
(16798,12,2),   -- INT +2
(16798,25,1),   -- ACC +1
(16798,23,2),   -- ATT +2
(16798,315,10), -- DRAIN/ASPIR +10%

-- Barbaroi Axe
(16680,8,2),  -- STR +2
(16680,14,2), -- CHR +2

-- Paper Knife
(16766,11,2),  -- AGI +2
(16766,14,2),  -- CHR +2
(16766,454,5), -- Song Effect Duration +5%

-- Sniping Bow
(17188,11,4),  -- AGI +4 Sniping Bow Cactuar Edit 
(17188,27,-1), -- Enmity -1
(17188,26,10), -- RACC +10
(17188,24,5),  -- RATT +5

-- Anju
(17771,8,-1), -- STR -1
(17771,9,2),  -- DEX +2
(17771,68,2), -- EVA +2

-- Zushio
(17772,8,2),  -- STR +2
(17772,9,-1), -- DEX -1
(17772,23,3), -- ATT +3

-- Magoroku
(17812,8,2),  -- STR +2
(17812,11,2), -- AGI +2
(17812,73,3), -- StoreTP +3

-- Immortals Scimitar
(17717,5,10), -- MP +10
(17717,8,1),  -- STR +1
(17717,12,1), -- INT +1
(17717,25,2), -- ACC +2
(17717,28,2), -- MATT +2

-- Trump Gun
(18702,11,2), -- AGI +2
(18702,26,3), -- RACC +3
(18702,30,1), -- MACC +1
(18702,28,1), -- MATT +1

-- War Hoop
(19203,14,3),  -- CHR +3
(19203,491,5), -- Waltz Potency +3

-- Murasame
(16961,3,-5),   -- HPP: -5
(16961,15,16),  -- FIRE_RES: 16
(16961,431,1),  -- ITEM_ADDEFFECT_TYPE: 1
(16961,499,6),  -- ITEM_SUBEFFECT: 6
(16961,500,9),  -- ITEM_ADDEFFECT_DMG: 30
(16961,501,10), -- ITEM_ADDEFFECT_CHANCE: 25
(16961,950,6),  -- ITEM_ADDEFFECT_ELEMENT: 6
(16961,421,5), -- Crit DMG +5%

-- Reaver Grip
(19046,5,10), -- MP: 10
(19046,11,1), -- AGI: 1
(19046,315,5), -- ENH_DRAIN_ASPIR: 5

-- Reaver Grip +1
(19047,5,12), -- MP: 12
(19047,11,2), -- AGI: 2
(19047,315,7), -- ENH_DRAIN_ASPIR: 7

-- Pachamac's Collar
(13172,1,2),  -- DEF: 2
(13172,71,1), -- MPHEAL: 1
(13172,72,1), -- HPHEAL: 1
(13172,860,1),  -- CURE2MP_PERCENT: 1

-- Flagellant's Crossbow
(17234,17,3), -- WIND_RES: 3

-- Lightning Mantle
(13617,1,7),  -- DEF: 7
(13617,19,6), -- THUNDER_RES: 6
(13617,471,5), -- Lightning Null: 15%

-- Sukesada
(16980,23,7),  -- ATT: 7
(16980,430,1), -- QUAD_ATTACK: 1

-- Shadow Mask
(13912,1,20),   -- DEF: 20
(13912,5,10),   -- MP: 10
(13912,8,2),    -- STR: 2
(13912,10,-2),  -- VIT: -2
(13912,21,-20), -- LIGHT_RES: -20
(13912,22,20), -- DARK_RES: 20

-- Fowlers Mantle
(11535,1,7),   -- DEF: 7
(11535,11,2),  -- AGI: 2
(11535,24,12), -- RATT: 12
(11535,359,3), -- RAPID_SHOT +3

-- Fowlers Mantle +1
(11541,1,8),   -- DEF: 8
(11541,11,3),  -- AGI: 3
(11541,24,15), -- RATT: 15
(11541,359,5), -- RAPID_SHOT +5

-- Lyricists Gonnelle
(11533,14,3), -- CHR: 3
(11533,23,6), -- ATT: 6
(11533,119,2), -- SINGING: 2

-- Sinister Mask
(15219,1,12),  -- DEF: 12
(15219,8,2),   -- STR: 2
(15219,10,-2), -- VIT: -2
(15219,12,2),  -- INT: 2
(15219,13,-2), -- MND: -2
(15219,315,7), -- ENH_DRAIN_ASPIR: 7

-- Darksteel Codpiece
(15371,1,27),     -- DEF: 27
(15371,14,3),     -- CHR: 3
(15371,166,-2),   -- ENEMYCRITRATE: -2
(15371,161,-100), -- DMGPHYS: -100

-- Acid Bolt
(18148,431,2),   -- ITEM_ADDEFFECT_TYPE: 2
(18148,499,18),  -- ITEM_SUBEFFECT: 18
(18148,501,35),  -- ITEM_ADDEFFECT_CHANCE: 35
(18148,951,149), -- ITEM_ADDEFFECT_STATUS: 149
(18148,952,12),  -- ITEM_ADDEFFECT_POWER: 12
(18148,953,60);  -- ITEM_ADDEFFECT_DURATION: 60

REPLACE INTO `item_mods_pet` (`itemId`, `modId`, `value`, `petType`) VALUES

-- Barbaroi Axe
(16680,25,2,0), -- ACC +2
(16680,23,3,0), -- ATT +3

-- Peregrine
(16887,2,15,2), -- HP +15
(16887,25,1,2), -- ACC +1
(16887,23,3,2), -- ATT +3

-- Kukulcan's Staff
(17532,25,3,1),  -- ACC +2
(17532,384,3,1); -- Haste +2%

REPLACE INTO `item_weapon` (`itemId`, `name`, `skill`, `subskill`, `ilvl_skill`, `ilvl_parry`, `ilvl_macc`, `dmgType`, `hit`, `delay`, `dmg`, `unlock_points`) VALUES

(18784,'metasoma_katars',1,0,0,0,0,4,1,564,17,0),
(17188,'sniping_bow',25,0,0,0,0,1,1,540,56,0);

REPLACE INTO `item_latents` (`itemId`, `modId`, `value`, `latentId`, `latentParam`) VALUES
-- Cocoon Band
(11823,1,45,13,13), -- Slow: DEF +45

-- Murasame
(16961,165,5,52,6), -- Rain Weather: Crit rate +5%

-- Gae Bolg
(16885,421,10,52,6), -- Rain Weather: Crit DMG +10%

-- Flagellant's Crossbow
(13248,365,10,13,4), -- Paralysis: Snapshot +10

-- Living Rod
(16885,370,2,52,6), -- Rain Weather: Regen +2

-- Lohar
(17927,129,1,40,0), -- MAINHAND: Smithing +1

-- Sunlight Pole
(17529,370,5,52,1), -- Rain Weather: Regen +5

(11576,30,1,16,3), -- MACC +1~4,party size 3+. Effect strengthens with more members
(11576,30,1,16,4), -- MACC +1~4,party size 3+. Effect strengthens with more members
(11576,30,1,16,5), -- MACC +1~4,party size 3+. Effect strengthens with more members
(11576,30,1,16,6); -- MACC +1~4,party size 3+. Effect strengthens with more members

UNLOCK TABLES;
