-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.6.14-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             12.3.0.6589
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping structure for table xidb.accounts
CREATE TABLE IF NOT EXISTS `accounts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `login` varchar(16) NOT NULL DEFAULT '',
  `password` varchar(64) NOT NULL DEFAULT '',
  `salt` varchar(64) DEFAULT NULL,
  `current_email` varchar(64) NOT NULL DEFAULT '',
  `registration_email` varchar(64) NOT NULL DEFAULT '',
  `timecreate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `timelastmodify` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `content_ids` tinyint(2) unsigned NOT NULL DEFAULT 1,
  `expansions` smallint(4) unsigned NOT NULL DEFAULT 4094,
  `features` tinyint(2) unsigned NOT NULL DEFAULT 253,
  `status` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `priv` tinyint(3) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1022 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
