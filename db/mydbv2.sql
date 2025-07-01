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
-- Table structure for table `characters`
--

DROP TABLE IF EXISTS `characters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `characters` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `surname` varchar(45) DEFAULT NULL,
  `job` varchar(45) DEFAULT NULL,
  `description` mediumtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `characters`
--

LOCK TABLES `characters` WRITE;
/*!40000 ALTER TABLE `characters` DISABLE KEYS */;
INSERT INTO `characters` VALUES (1,'Homer','Simpson','Safety inspector ',NULL),(2,'Marge','Simpson','housewife',NULL),(3,'Bart','Simpson','4th-grade student',''),(4,'Lisa','Simpson','2nd grade student',''),(5,'Maggie','Simpson','baby',NULL),(6,'Abe ','Simpson','World War II veteran',NULL),(7,'Carl','Carlson','Springfield Nuclear Power Plant employee',NULL),(8,'Nelson','Muntz','4th-grade bully student',NULL);
/*!40000 ALTER TABLE `characters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `episodes`
--

DROP TABLE IF EXISTS `episodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `episodes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(45) DEFAULT NULL,
  `episode_number` int DEFAULT NULL,
  `season` int DEFAULT NULL,
  `emission_date` date DEFAULT NULL,
  `synopsis` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `episodes`
--

LOCK TABLES `episodes` WRITE;
/*!40000 ALTER TABLE `episodes` DISABLE KEYS */;
INSERT INTO `episodes` VALUES (1,'Good Night',1,1,'1987-04-19','Homer and Marge say goodnight to their children, but all does not go according to plan. Bart tries to ask about the mind, but is left contemplating it as he does not get a proper answer. Lisa fears that bed bugs will eat her after hearing Marge say \"Don\'t let the bed bugs bite\". Maggie is terrified by the lyrics of \"Rock-a-bye Baby\". Ultimately, all three children decide to sleep in their parents\' bed.'),(2,'Grandpa and the Kids',19,2,'1988-01-10','Homer shoves Bart, Lisa, and Maggie in a room with their Grandpa. Grandpa tells the kids about stories from \"the good old days\". After he finishes talking, Bart asks Grandpa if his Grandpa was a liar, too. '),(3,'Bart the General',5,1,'1990-02-04','After defending Lisa from school bully Nelson Muntz, Bart becomes Nelson\'s latest school bullying target. Having become sick and tired of the harassment and torment, Bart, Grampa Simpson, and Herman (a slightly deranged military antique store dealer with a missing arm) rallies the town\'s children into fighting back against Nelson and his cronies with a couple hundred water balloons.');
/*!40000 ALTER TABLE `episodes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `episodes_has_characters`
--

DROP TABLE IF EXISTS `episodes_has_characters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `episodes_has_characters` (
  `episodes_id` int NOT NULL,
  `characters_id` int NOT NULL,
  PRIMARY KEY (`episodes_id`,`characters_id`),
  KEY `fk_episodes_has_characters_characters1_idx` (`characters_id`),
  KEY `fk_episodes_has_characters_episodes1_idx` (`episodes_id`),
  CONSTRAINT `fk_episodes_has_characters_characters1` FOREIGN KEY (`characters_id`) REFERENCES `characters` (`id`),
  CONSTRAINT `fk_episodes_has_characters_episodes1` FOREIGN KEY (`episodes_id`) REFERENCES `episodes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `episodes_has_characters`
--

LOCK TABLES `episodes_has_characters` WRITE;
/*!40000 ALTER TABLE `episodes_has_characters` DISABLE KEYS */;
INSERT INTO `episodes_has_characters` VALUES (1,1),(2,1),(1,2),(1,3),(2,3),(3,3),(1,4),(2,4),(3,4),(1,5),(2,5),(2,6),(3,8);
/*!40000 ALTER TABLE `episodes_has_characters` ENABLE KEYS */;
UNLOCK TABLES;

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

-- Dump completed on 2025-07-01 11:09:28
