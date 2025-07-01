-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: mydb
-- ------------------------------------------------------
-- Server version	8.0.32

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `quotes`
--

DROP TABLE IF EXISTS `quotes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quotes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `text` varchar(200) NOT NULL,
  `mark_time` time DEFAULT NULL,
  `description` mediumtext,
  `characters_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Quotes_characters1_idx` (`characters_id`),
  CONSTRAINT `fk_Quotes_characters1` FOREIGN KEY (`characters_id`) REFERENCES `characters` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quotes`
--

LOCK TABLES `quotes` WRITE;
/*!40000 ALTER TABLE `quotes` DISABLE KEYS */;
INSERT INTO `quotes` VALUES (1,'D\'oh',NULL,NULL,1),(2,'Woo Hoo!',NULL,NULL,1),(3,'Mmm, donuts.',NULL,'Occasionally replaces \"donuts\" with other types of food',1),(4,'You have no idea what it\'s like, being married to you',NULL,NULL,2),(5,'Oh, Homie',NULL,'Used when Homer romantically flatters her',2),(6,'¡Ay, caramba!',NULL,'',3),(7,'Eat My Shorts!',NULL,NULL,3),(8,'I Didn\'t Do It',NULL,'often followed by \"Nobody saw me do it. You can\'t prove anything!\"',3),(9,'Stupid Flanders.',NULL,NULL,1),(10,'If anyone wants me, I\'ll be in my room',NULL,'Lisa doesn’t really have any catchphrases, and this is shown as a joke when many Springfieldians use their catchphrases while Lisa dryly says, \"If anyone wants me, I\'ll be in my room.\"',4),(11,'(Pacifier Suck)',NULL,NULL,5),(12,'Hot Diggity Dog!”',NULL,NULL,6),(13,'Ha Ha!',NULL,'Nelson laughs at peoples’ misfortune',8);
/*!40000 ALTER TABLE `quotes` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-01  9:02:28
