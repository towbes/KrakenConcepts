-- ---------------------------------------------------------------------------
--  Notes: CactuarXI Dynamic Mob Groups
-- Format: (groupid,poolid,zoneid,name,respawntime,spawntype,dropid,HP,MP,minLevel,maxLevel,allegiance)
-- ---------------------------------------------------------------------------

-- ------------------------------------------------------------
-- Add content_tag to zones
-- ------------------------------------------------------------

LOCK TABLE `mob_groups` WRITE;

ALTER TABLE `mob_groups`
    ADD COLUMN IF NOT EXISTS `content_tag` varchar(14) DEFAULT NULL AFTER `allegiance`;


INSERT INTO `mob_groups` (`groupid`, `poolid`, `zoneid`, `name`, `respawntime`, `spawntype`, `dropid`, `HP`, `MP`, `minLevel`, `maxLevel`, `allegiance`) VALUES
(100,4791,100,'Wild_Boar',10,0,0,0,0,1,1,0);        -- These are in prep for complete zone revamps

UNLOCK TABLES;
