-- MySQL dump 10.13  Distrib 8.0.26, for Win64 (x86_64)
--
-- Host: localhost    Database: jid_thrillio
-- ------------------------------------------------------
-- Server version	8.0.26

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `actor`
--

DROP TABLE IF EXISTS `actor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `actor` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actor`
--

LOCK TABLES `actor` WRITE;
/*!40000 ALTER TABLE `actor` DISABLE KEYS */;
INSERT INTO `actor` VALUES (1,'Orson Welles'),(2,'Joseph Cotten'),(3,'Henry Fonda'),(4,'Jane \nDarwell'),(5,'Albert Cullum'),(6,'Kaley Cuoco'),(7,'Jim\nParsons'),(8,'Takashi Shimura'),(9,'Minoru Chiaki'),(10,'Orson Welles'),(11,'Joseph Cotten'),(12,'Henry Fonda'),(13,'Jane \nDarwell'),(14,'Albert Cullum'),(15,'Kaley Cuoco'),(16,'Jim\nParsons'),(17,'Takashi Shimura'),(18,'Minoru Chiaki'),(19,'Orson Welles'),(20,'Joseph Cotten'),(21,'Henry Fonda'),(22,'Jane \nDarwell'),(23,'Albert Cullum'),(24,'Kaley Cuoco'),(25,'Jim\nParsons'),(26,'Takashi Shimura'),(27,'Minoru Chiaki');
/*!40000 ALTER TABLE `actor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `author`
--

DROP TABLE IF EXISTS `author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `author` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `author`
--

LOCK TABLES `author` WRITE;
/*!40000 ALTER TABLE `author` DISABLE KEYS */;
INSERT INTO `author` VALUES (1,'Henry David Thoreau'),(2,'Ralph Waldo Emerson'),(3,'Lillian Eichler Watson'),(4,'Eric Freeman'),(5,'Bert Bates'),(6,'Kathy Sierra'),(7,'Elisabeth Robson'),(8,'Joshua Bloch');
/*!40000 ALTER TABLE `author` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book`
--

DROP TABLE IF EXISTS `book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(500) NOT NULL,
  `image_url` varchar(500) DEFAULT NULL,
  `publication_year` int DEFAULT NULL,
  `publisher_id` bigint DEFAULT NULL,
  `book_genre_id` tinyint DEFAULT NULL,
  `amazon_rating` double DEFAULT NULL,
  `kid_friendly_status` tinyint DEFAULT NULL,
  `kid_friendly_marked_by` bigint DEFAULT NULL,
  `shared_by` bigint DEFAULT NULL,
  `created_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`(250),`publication_year`,`publisher_id`),
  KEY `publisher_id` (`publisher_id`),
  KEY `kid_friendly_marked_by` (`kid_friendly_marked_by`),
  KEY `shared_by` (`shared_by`),
  CONSTRAINT `book_ibfk_1` FOREIGN KEY (`publisher_id`) REFERENCES `publisher` (`id`),
  CONSTRAINT `book_ibfk_2` FOREIGN KEY (`kid_friendly_marked_by`) REFERENCES `user` (`id`),
  CONSTRAINT `book_ibfk_3` FOREIGN KEY (`shared_by`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book`
--

LOCK TABLES `book` WRITE;
/*!40000 ALTER TABLE `book` DISABLE KEYS */;
INSERT INTO `book` VALUES (1,'Walden','https://images.gr-assets.com/books/1465675526l/16902.jpg',1854,1,6,4.3,1,3,NULL,'2021-10-12 00:26:08'),(2,'Self-Reliance and Other Essays','https://images.gr-assets.com/books/1520778510l/123845.jpg',1993,2,6,4.5,1,3,NULL,'2021-10-12 00:26:08'),(3,'Light \nFrom Many Lamps','https://images.gr-assets.com/books/1347739312l/1270698.jpg',1988,3,6,5,1,5,NULL,'2021-10-12 00:26:08'),(4,'Head \nFirst Design Patterns','https://images.gr-assets.com/books/1408309444l/58128.jpg',2004,4,10,4.5,1,3,5,'2021-10-12 00:26:08'),(5,'Effective Java Programming Language Guide','https://images.gr-assets.com/books/1433511045l/105099.jpg',2007,5,10,4.9,1,3,4,'2021-10-12 00:26:08');
/*!40000 ALTER TABLE `book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book_author`
--

DROP TABLE IF EXISTS `book_author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book_author` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `book_id` bigint NOT NULL,
  `author_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `book_id` (`book_id`,`author_id`),
  KEY `author_id` (`author_id`),
  CONSTRAINT `book_author_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `book` (`id`),
  CONSTRAINT `book_author_ibfk_2` FOREIGN KEY (`author_id`) REFERENCES `author` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book_author`
--

LOCK TABLES `book_author` WRITE;
/*!40000 ALTER TABLE `book_author` DISABLE KEYS */;
INSERT INTO `book_author` VALUES (1,1,1),(2,2,2),(3,3,3),(4,4,4),(5,4,5),(6,4,6),(7,4,7),(17,5,8);
/*!40000 ALTER TABLE `book_author` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `director`
--

DROP TABLE IF EXISTS `director`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `director` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `director`
--

LOCK TABLES `director` WRITE;
/*!40000 ALTER TABLE `director` DISABLE KEYS */;
INSERT INTO `director` VALUES (1,'Orson Welles'),(2,'John Ford'),(3,'Leslie Sullivan'),(4,'Chuck Lorre'),(5,'Bill Prady'),(6,'Akira Kurosawa'),(7,'Orson Welles'),(8,'John Ford'),(9,'Leslie Sullivan'),(10,'Chuck Lorre'),(11,'Bill Prady'),(12,'Akira Kurosawa'),(13,'Orson Welles'),(14,'John Ford'),(15,'Leslie Sullivan'),(16,'Chuck Lorre'),(17,'Bill Prady'),(18,'Akira Kurosawa');
/*!40000 ALTER TABLE `director` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movie`
--

DROP TABLE IF EXISTS `movie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movie` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(500) NOT NULL,
  `release_year` int DEFAULT NULL,
  `movie_genre_id` tinyint DEFAULT NULL,
  `imdb_rating` double DEFAULT NULL,
  `kid_friendly_status` tinyint DEFAULT NULL,
  `kid_friendly_marked_by` bigint DEFAULT NULL,
  `created_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`(100),`release_year`),
  KEY `kid_friendly_marked_by` (`kid_friendly_marked_by`),
  CONSTRAINT `movie_ibfk_1` FOREIGN KEY (`kid_friendly_marked_by`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movie`
--

LOCK TABLES `movie` WRITE;
/*!40000 ALTER TABLE `movie` DISABLE KEYS */;
INSERT INTO `movie` VALUES (1,'Citizen Kane',1941,0,8.5,1,3,'2021-10-17 17:51:32'),(2,'The Grapes of Wrath',1940,0,8.2,1,3,'2021-10-17 17:51:33'),(3,'A Touch of Greatness',2004,24,7.3,1,3,'2021-10-17 17:51:33'),(4,'The Big Bang Theory',2007,20,8.7,0,3,'2021-10-17 17:51:33'),(5,'Ikiru',1952,25,8.4,0,3,'2021-10-17 17:51:34');
/*!40000 ALTER TABLE `movie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movie_actor`
--

DROP TABLE IF EXISTS `movie_actor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movie_actor` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `movie_id` bigint NOT NULL,
  `actor_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `movie_id` (`movie_id`,`actor_id`),
  KEY `actor_id` (`actor_id`),
  CONSTRAINT `movie_actor_ibfk_1` FOREIGN KEY (`movie_id`) REFERENCES `movie` (`id`),
  CONSTRAINT `movie_actor_ibfk_2` FOREIGN KEY (`actor_id`) REFERENCES `actor` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movie_actor`
--

LOCK TABLES `movie_actor` WRITE;
/*!40000 ALTER TABLE `movie_actor` DISABLE KEYS */;
INSERT INTO `movie_actor` VALUES (1,1,1),(2,1,2),(3,2,3),(4,2,4),(5,3,5),(6,4,6),(7,4,7),(8,5,8),(9,5,9);
/*!40000 ALTER TABLE `movie_actor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movie_director`
--

DROP TABLE IF EXISTS `movie_director`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movie_director` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `movie_id` bigint NOT NULL,
  `director_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `movie_id` (`movie_id`,`director_id`),
  KEY `director_id` (`director_id`),
  CONSTRAINT `movie_director_ibfk_1` FOREIGN KEY (`movie_id`) REFERENCES `movie` (`id`),
  CONSTRAINT `movie_director_ibfk_2` FOREIGN KEY (`director_id`) REFERENCES `director` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movie_director`
--

LOCK TABLES `movie_director` WRITE;
/*!40000 ALTER TABLE `movie_director` DISABLE KEYS */;
INSERT INTO `movie_director` VALUES (1,1,1),(2,2,2),(3,3,3),(4,4,4),(5,4,5),(6,5,6);
/*!40000 ALTER TABLE `movie_director` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publisher`
--

DROP TABLE IF EXISTS `publisher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `publisher` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publisher`
--

LOCK TABLES `publisher` WRITE;
/*!40000 ALTER TABLE `publisher` DISABLE KEYS */;
INSERT INTO `publisher` VALUES (1,'Wilder Publications'),(2,'Dover Publications'),(3,'Touchstone'),(4,'O\'Reilly Media'),(5,'Prentice Hall');
/*!40000 ALTER TABLE `publisher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `email` varchar(100) NOT NULL,
  `password` varchar(50) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `gender_id` tinyint DEFAULT NULL,
  `user_type_id` tinyint DEFAULT NULL,
  `created_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'user0@semanticsquare.com','a94a8fe5ccb19ba61c4c0873d391e987982fbbd3','John','M',0,0,'2021-10-12 00:35:47'),(2,'user1@semanticsquare.com','a94a8fe5ccb19ba61c4c0873d391e987982fbbd3','Sam','M',0,0,'2021-10-12 00:35:47'),(3,'user2@semanticsquare.com','a94a8fe5ccb19ba61c4c0873d391e987982fbbd3','Anita','M',1,1,'2021-10-12 00:35:47'),(4,'user3@semanticsquare.com','a94a8fe5ccb19ba61c4c0873d391e987982fbbd3','Sara','M',1,1,'2021-10-12 00:35:47'),(5,'user4@semanticsquare.com','a94a8fe5ccb19ba61c4c0873d391e987982fbbd3','Dheeru','M',0,2,'2021-10-12 00:35:48');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_book`
--

DROP TABLE IF EXISTS `user_book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_book` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `book_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `book_id` (`book_id`),
  CONSTRAINT `user_book_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `user_book_ibfk_2` FOREIGN KEY (`book_id`) REFERENCES `book` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_book`
--

LOCK TABLES `user_book` WRITE;
/*!40000 ALTER TABLE `user_book` DISABLE KEYS */;
INSERT INTO `user_book` VALUES (20,5,4),(22,5,2),(25,5,1);
/*!40000 ALTER TABLE `user_book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_movie`
--

DROP TABLE IF EXISTS `user_movie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_movie` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `movie_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `movie_id` (`movie_id`),
  CONSTRAINT `user_movie_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `user_movie_ibfk_2` FOREIGN KEY (`movie_id`) REFERENCES `movie` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=530 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_movie`
--

LOCK TABLES `user_movie` WRITE;
/*!40000 ALTER TABLE `user_movie` DISABLE KEYS */;
INSERT INTO `user_movie` VALUES (1,1,3),(2,1,4),(3,1,5),(4,2,1),(5,2,2),(6,2,3),(7,3,1),(8,3,3),(9,3,4),(10,4,1),(11,4,4),(12,5,4),(13,1,2),(14,1,3),(15,2,1),(16,2,5),(17,3,2),(18,3,4),(19,3,5),(20,4,2),(21,4,4),(22,5,3),(23,5,4),(24,1,2),(25,1,5),(26,2,2),(27,2,3),(28,2,5),(29,3,3),(30,3,5),(31,4,4),(32,5,3),(33,1,1),(34,1,4),(35,1,5),(36,2,1),(37,2,4),(38,3,2),(39,3,4),(40,3,5),(41,4,1),(42,4,2),(43,4,4),(44,4,5),(45,5,2),(46,1,1),(47,1,3),(48,2,3),(49,3,1),(50,3,2),(51,3,3),(52,4,2),(53,4,4),(54,5,3),(55,5,4),(56,2,3),(57,2,4),(58,2,5),(59,3,1),(60,3,4),(61,4,3),(62,4,4),(63,4,5),(64,5,1),(65,5,2),(66,1,3),(67,1,5),(68,2,1),(69,2,2),(70,2,3),(71,2,5),(72,3,2),(73,4,3),(74,4,5),(75,5,4),(76,5,5),(77,1,2),(78,1,3),(79,2,1),(80,2,2),(81,2,3),(82,3,4),(83,3,5),(84,4,1),(85,4,2),(86,4,4),(87,4,5),(88,5,2),(89,5,4),(90,1,2),(91,1,3),(92,1,4),(93,2,3),(94,2,5),(95,4,1),(96,5,1),(97,5,3),(98,5,4),(99,1,1),(100,1,3),(101,1,4),(102,2,1),(103,2,3),(104,2,5),(105,3,1),(106,4,1),(107,4,4),(108,4,5),(109,5,5),(110,1,2),(111,1,5),(112,2,5),(113,3,3),(114,3,5),(115,4,1),(116,4,2),(117,4,3),(118,4,5),(119,5,3),(120,1,1),(121,1,2),(122,1,3),(123,2,1),(124,2,3),(125,2,4),(126,2,5),(127,3,1),(128,3,2),(129,3,3),(130,4,2),(131,4,3),(132,4,5),(133,5,2),(134,1,1),(135,1,2),(136,1,3),(137,1,5),(138,2,1),(139,2,3),(140,2,5),(141,4,2),(142,4,3),(143,4,4),(144,4,5),(145,5,2),(146,1,3),(147,1,4),(148,2,1),(149,2,3),(150,3,2),(151,3,5),(152,4,1),(153,4,2),(154,4,3),(155,4,4),(156,1,1),(157,1,2),(158,1,3),(159,1,4),(160,2,5),(161,3,3),(162,3,4),(163,4,2),(164,4,3),(165,4,4),(166,4,5),(167,5,3),(168,1,1),(169,1,2),(170,1,3),(171,1,4),(172,1,5),(173,2,2),(174,2,3),(175,3,2),(176,3,3),(177,4,2),(178,4,4),(179,5,3),(180,5,4),(181,1,1),(182,1,5),(183,2,2),(184,1,2),(185,1,5),(186,2,1),(187,2,2),(188,2,3),(189,1,1),(190,1,2),(191,1,3),(192,1,5),(193,2,3),(194,1,1),(195,1,2),(196,1,3),(197,1,5),(198,2,3),(199,2,4),(200,2,5),(201,1,2),(202,1,3),(203,1,4),(204,1,5),(205,2,3),(206,2,4),(207,1,1),(208,1,5),(209,2,1),(210,2,4),(211,2,5),(212,1,1),(213,1,2),(214,1,3),(215,1,5),(216,2,1),(217,2,2),(218,2,3),(219,2,4),(220,1,3),(221,1,4),(222,2,2),(223,2,4),(224,3,3),(225,3,5),(226,4,4),(227,5,1),(228,5,2),(229,5,3),(230,5,4),(231,1,2),(232,1,3),(233,1,4),(234,2,2),(235,2,4),(236,2,5),(237,3,4),(238,4,2),(239,4,4),(240,4,5),(241,5,1),(242,5,2),(243,5,5),(244,1,3),(245,1,5),(246,2,1),(247,2,3),(248,2,4),(249,3,2),(250,3,4),(251,3,5),(252,4,4),(253,5,2),(254,5,3),(255,5,4),(256,1,1),(257,1,2),(258,1,3),(259,1,5),(260,2,1),(261,2,2),(262,2,5),(263,4,1),(264,4,2),(265,4,3),(266,4,4),(267,5,1),(268,5,2),(269,2,1),(270,2,3),(271,2,5),(272,3,4),(273,3,5),(274,4,1),(275,4,3),(276,4,4),(277,5,2),(278,5,3),(279,5,5),(280,1,1),(281,1,3),(282,2,2),(283,2,3),(284,3,1),(285,3,3),(286,3,5),(287,4,1),(288,4,2),(289,4,3),(290,4,5),(291,5,1),(292,5,2),(293,5,3),(294,5,4),(295,1,1),(296,1,2),(297,1,5),(298,2,1),(299,2,2),(300,2,3),(301,2,5),(302,3,2),(303,3,3),(304,4,1),(305,4,3),(306,4,4),(307,5,1),(308,5,2),(309,5,3),(310,1,2),(311,1,3),(312,2,5),(313,3,3),(314,3,4),(315,4,1),(316,4,3),(317,4,5),(318,5,1),(319,5,3),(320,5,5),(321,1,4),(322,1,5),(323,2,3),(324,2,4),(325,3,5),(326,4,1),(327,5,1),(328,5,2),(329,5,3),(330,5,4),(331,5,5),(332,1,1),(333,1,2),(334,2,1),(335,2,2),(336,2,5),(337,3,1),(338,3,3),(339,3,4),(340,3,5),(341,4,5),(342,5,1),(343,5,5),(344,1,3),(345,2,1),(346,2,2),(347,2,3),(348,2,5),(349,3,1),(350,3,3),(351,3,4),(352,3,5),(353,4,5),(354,5,3),(355,1,4),(356,1,5),(357,2,1),(358,2,3),(359,2,5),(360,3,1),(361,3,3),(362,4,1),(363,4,2),(364,4,3),(365,4,4),(366,4,5),(367,5,5),(368,1,1),(369,1,4),(370,2,2),(371,2,4),(372,2,5),(373,3,2),(374,3,3),(375,3,4),(376,3,5),(377,4,1),(378,4,3),(379,4,5),(380,5,1),(381,5,2),(382,5,4),(383,5,5),(384,1,1),(385,1,2),(386,1,4),(387,1,5),(388,2,1),(389,2,2),(390,2,3),(391,2,4),(392,3,1),(393,3,2),(394,3,3),(395,3,4),(396,4,1),(397,4,2),(398,4,4),(399,4,5),(400,5,1),(401,5,2),(402,5,3),(403,1,3),(404,1,4),(405,2,2),(406,2,3),(407,3,3),(408,3,5),(409,4,2),(410,4,5),(411,5,2),(412,5,5),(413,1,3),(414,1,5),(415,3,3),(416,3,5),(417,4,2),(418,5,1),(419,5,2),(420,5,5),(421,1,1),(422,1,2),(423,1,3),(424,1,4),(425,2,2),(426,2,3),(427,2,4),(428,2,5),(429,3,1),(430,3,2),(431,3,4),(432,3,5),(433,5,3),(434,5,4),(435,5,5),(436,1,1),(437,1,5),(438,2,1),(439,2,2),(440,2,4),(441,3,2),(442,3,5),(443,4,1),(444,4,3),(445,4,4),(446,5,1),(447,5,2),(448,5,5),(449,1,2),(450,1,3),(451,1,4),(452,1,5),(453,2,3),(454,2,4),(455,3,2),(456,4,2),(457,4,3),(458,4,4),(459,5,1),(460,5,2),(461,5,5),(462,1,2),(463,2,1),(464,2,2),(465,3,3),(466,3,4),(467,4,1),(468,4,2),(469,4,5),(470,5,1),(471,5,2),(472,5,3),(473,5,5),(474,1,2),(475,1,3),(476,1,5),(477,2,1),(478,2,2),(479,2,3),(480,2,5),(481,3,1),(482,3,2),(483,3,3),(484,3,4),(485,3,5),(486,4,1),(487,4,4),(488,4,5),(489,5,1),(490,5,3),(491,5,5),(492,1,4),(493,1,5),(494,2,2),(495,2,3),(496,2,4),(497,2,5),(498,3,4),(499,4,1),(500,4,2),(501,4,5),(502,5,4),(503,1,1),(504,1,2),(505,1,3),(506,1,4),(507,2,1),(508,2,3),(509,2,4),(510,2,5),(511,3,3),(512,3,5),(513,5,2),(514,5,3),(515,1,1),(516,1,2),(517,1,3),(518,2,1),(519,2,2),(520,2,3),(521,2,4),(522,3,1),(523,3,3),(524,3,4),(525,3,5),(526,4,3),(527,4,4),(528,5,1),(529,5,3);
/*!40000 ALTER TABLE `user_movie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_weblink`
--

DROP TABLE IF EXISTS `user_weblink`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_weblink` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `weblink_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `weblink_id` (`weblink_id`),
  CONSTRAINT `user_weblink_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `user_weblink_ibfk_2` FOREIGN KEY (`weblink_id`) REFERENCES `weblink` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=662 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_weblink`
--

LOCK TABLES `user_weblink` WRITE;
/*!40000 ALTER TABLE `user_weblink` DISABLE KEYS */;
INSERT INTO `user_weblink` VALUES (44,1,1),(45,1,5),(46,2,2),(47,3,1),(48,3,5),(49,4,4),(50,5,3),(51,5,5),(52,1,1),(53,1,2),(54,1,3),(55,1,4),(56,1,5),(57,2,1),(58,2,2),(59,2,5),(60,3,4),(61,3,5),(62,4,2),(63,4,3),(64,4,5),(65,5,2),(66,1,1),(67,1,3),(68,1,5),(69,2,4),(70,3,2),(71,3,4),(72,4,1),(73,4,2),(74,4,3),(75,4,5),(76,5,1),(77,5,2),(78,1,1),(79,1,3),(80,1,4),(81,1,5),(82,2,1),(83,2,2),(84,2,4),(85,3,1),(86,3,2),(87,3,4),(88,3,5),(89,4,1),(90,4,2),(91,5,3),(92,1,2),(93,1,3),(94,1,4),(95,2,3),(96,3,5),(97,4,1),(98,4,3),(99,4,5),(100,5,2),(101,5,5),(102,1,1),(103,1,2),(104,1,3),(105,2,1),(106,2,2),(107,2,3),(108,2,4),(109,2,5),(110,3,1),(111,3,3),(112,4,1),(113,4,2),(114,4,3),(115,4,4),(116,5,5),(117,1,2),(118,1,4),(119,1,5),(120,2,1),(121,2,2),(122,2,4),(123,2,5),(124,3,1),(125,3,3),(126,3,4),(127,4,1),(128,4,3),(129,5,5),(130,1,2),(131,1,3),(132,2,1),(133,2,3),(134,2,4),(135,3,4),(136,3,5),(137,4,2),(138,4,3),(139,4,4),(140,4,5),(141,5,2),(142,5,3),(143,1,1),(144,1,5),(145,2,3),(146,2,4),(147,3,1),(148,3,2),(149,3,4),(150,3,5),(151,4,2),(152,4,3),(153,4,4),(154,5,1),(155,5,2),(156,5,3),(157,5,4),(158,1,2),(159,1,3),(160,2,2),(161,2,3),(162,2,4),(163,2,5),(164,3,3),(165,3,5),(166,4,1),(167,4,2),(168,4,3),(169,5,1),(170,5,2),(171,5,3),(172,5,4),(173,1,2),(174,1,5),(175,2,1),(176,2,3),(177,2,4),(178,3,1),(179,3,3),(180,3,4),(181,4,1),(182,4,2),(183,4,4),(184,5,2),(185,5,5),(186,1,2),(187,1,3),(188,1,4),(189,2,4),(190,3,1),(191,3,3),(192,4,2),(193,4,3),(194,4,4),(195,5,1),(196,5,3),(197,1,1),(198,1,2),(199,1,5),(200,2,2),(201,2,3),(202,2,4),(203,3,1),(204,3,2),(205,4,5),(206,5,1),(207,1,3),(208,1,5),(209,2,5),(210,3,1),(211,3,3),(212,3,5),(213,4,1),(214,4,2),(215,4,4),(216,4,5),(217,5,1),(218,1,1),(219,1,2),(220,1,4),(221,2,2),(222,2,4),(223,3,1),(224,3,3),(225,3,4),(226,3,5),(227,4,1),(228,4,5),(229,5,2),(230,5,3),(231,1,1),(232,1,2),(233,1,4),(234,1,5),(235,2,3),(236,2,5),(237,3,3),(238,3,4),(239,3,5),(240,5,4),(241,1,5),(242,2,1),(243,2,2),(244,2,4),(245,3,1),(246,3,3),(247,4,5),(248,5,2),(249,1,1),(250,1,4),(251,1,5),(252,3,3),(253,4,5),(254,5,2),(255,5,3),(256,5,4),(257,5,5),(258,1,2),(259,1,3),(260,1,4),(261,2,2),(262,2,4),(263,2,5),(264,3,2),(265,3,4),(266,3,5),(267,4,2),(268,4,5),(269,5,3),(270,1,2),(271,2,1),(272,2,2),(273,2,4),(274,2,5),(275,3,1),(276,3,2),(277,3,4),(278,4,2),(279,4,3),(280,4,4),(281,5,2),(282,5,3),(283,5,4),(284,1,3),(285,1,4),(286,1,5),(287,2,1),(288,2,3),(289,2,4),(290,3,1),(291,3,2),(292,3,3),(293,5,1),(294,5,2),(295,5,4),(296,5,5),(297,1,1),(298,1,3),(299,1,4),(300,3,2),(301,3,5),(302,4,1),(303,4,2),(304,4,3),(305,5,1),(306,5,2),(307,5,4),(308,5,5),(309,1,5),(310,2,2),(311,3,1),(312,3,2),(313,4,1),(314,4,3),(315,4,5),(316,5,1),(317,5,3),(318,5,4),(319,1,2),(320,1,3),(321,1,5),(322,2,3),(323,3,5),(324,4,2),(325,4,4),(326,4,5),(327,5,1),(328,1,2),(329,1,5),(330,2,2),(331,2,3),(332,2,4),(333,2,5),(334,3,1),(335,3,2),(336,3,5),(337,1,1),(338,1,2),(339,2,1),(340,2,2),(341,2,3),(342,2,4),(343,2,5),(344,3,1),(345,3,3),(346,3,4),(347,1,1),(348,1,2),(349,1,3),(350,2,3),(351,2,5),(352,3,1),(353,1,4),(354,1,5),(355,2,3),(356,2,4),(357,3,1),(358,3,3),(359,1,1),(360,2,1),(361,2,2),(362,2,5),(363,3,1),(364,1,1),(365,1,3),(366,1,4),(367,1,5),(368,2,3),(369,3,1),(370,3,4),(371,3,5),(372,1,5),(373,2,1),(374,2,2),(375,2,3),(376,3,2),(377,3,3),(378,3,5),(379,1,3),(380,1,4),(381,2,1),(382,2,3),(383,2,4),(384,3,1),(385,3,2),(386,3,3),(387,3,5),(388,4,2),(389,4,5),(390,5,3),(391,5,4),(392,5,5),(393,1,1),(394,1,2),(395,1,5),(396,3,2),(397,3,3),(398,4,2),(399,4,3),(400,5,3),(401,5,4),(402,1,2),(403,1,5),(404,2,4),(405,2,5),(406,3,4),(407,4,3),(408,5,1),(409,5,2),(410,5,3),(411,5,4),(412,1,1),(413,1,2),(414,1,3),(415,1,4),(416,1,5),(417,2,1),(418,2,2),(419,2,5),(420,3,2),(421,3,3),(422,3,4),(423,4,2),(424,4,4),(425,5,2),(426,5,3),(427,1,1),(428,1,2),(429,1,3),(430,2,1),(431,2,2),(432,2,4),(433,2,5),(434,3,2),(435,5,2),(436,5,3),(437,1,1),(438,1,2),(439,1,5),(440,2,1),(441,2,2),(442,2,3),(443,2,4),(444,3,2),(445,3,3),(446,3,4),(447,3,5),(448,4,2),(449,5,4),(450,1,2),(451,1,3),(452,2,3),(453,3,1),(454,3,4),(455,4,1),(456,4,2),(457,4,4),(458,5,1),(459,5,2),(460,5,4),(461,5,5),(462,1,1),(463,1,3),(464,2,1),(465,2,2),(466,2,4),(467,3,5),(468,4,1),(469,5,1),(470,5,3),(471,5,5),(472,1,1),(473,4,1),(474,4,4),(475,5,3),(476,5,4),(477,1,1),(478,1,2),(479,1,3),(480,1,4),(481,1,5),(482,2,1),(483,2,4),(484,2,5),(485,3,1),(486,3,2),(487,3,3),(488,4,2),(489,4,3),(490,5,2),(491,5,4),(492,1,1),(493,1,5),(494,2,1),(495,2,2),(496,3,1),(497,3,3),(498,3,5),(499,4,1),(500,4,4),(501,5,1),(502,5,2),(503,5,3),(504,5,5),(505,1,2),(506,2,1),(507,2,2),(508,2,4),(509,3,1),(510,3,3),(511,3,4),(512,4,1),(513,4,2),(514,4,3),(515,5,2),(516,5,3),(517,5,4),(518,1,1),(519,1,3),(520,2,1),(521,2,2),(522,3,5),(523,4,2),(524,4,4),(525,4,5),(526,5,1),(527,5,2),(528,5,3),(529,5,4),(530,5,5),(531,1,1),(532,1,4),(533,2,3),(534,2,4),(535,2,5),(536,3,2),(537,3,5),(538,4,2),(539,4,5),(540,5,2),(541,5,3),(542,5,4),(543,1,1),(544,1,3),(545,1,4),(546,1,5),(547,3,1),(548,3,2),(549,4,1),(550,4,2),(551,4,3),(552,4,4),(553,5,4),(554,1,1),(555,1,2),(556,1,4),(557,1,5),(558,2,1),(559,2,5),(560,3,3),(561,3,4),(562,3,5),(563,4,1),(564,4,2),(565,4,3),(566,4,5),(567,5,1),(568,1,1),(569,1,5),(570,2,2),(571,3,1),(572,3,5),(573,4,1),(574,4,3),(575,4,4),(576,4,5),(577,5,2),(578,5,4),(579,1,1),(580,1,2),(581,1,3),(582,2,2),(583,2,3),(584,2,4),(585,2,5),(586,3,1),(587,3,2),(588,4,1),(589,4,2),(590,4,3),(591,4,5),(592,5,1),(593,5,2),(594,5,3),(595,1,2),(596,1,3),(597,2,3),(598,2,4),(599,2,5),(600,3,2),(601,3,3),(602,3,5),(603,4,1),(604,4,3),(605,5,4),(606,5,5),(607,1,2),(608,1,3),(609,1,4),(610,2,1),(611,2,4),(612,2,5),(613,4,4),(614,5,2),(615,5,3),(616,5,5),(617,1,1),(618,1,2),(619,1,5),(620,2,5),(621,3,1),(622,3,2),(623,3,3),(624,3,4),(625,4,1),(626,4,2),(627,1,1),(628,1,2),(629,1,3),(630,1,5),(631,2,2),(632,2,3),(633,2,5),(634,3,1),(635,3,2),(636,4,2),(637,4,5),(638,5,2),(639,5,4),(640,2,3),(641,3,1),(642,3,4),(643,4,1),(644,4,2),(645,4,4),(646,4,5),(647,5,1),(648,5,2),(649,1,2),(650,1,4),(651,1,5),(652,2,1),(653,3,2),(654,3,3),(655,3,5),(656,4,1),(657,4,2),(658,4,4),(659,4,5),(660,5,1),(661,5,2);
/*!40000 ALTER TABLE `user_weblink` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `weblink`
--

DROP TABLE IF EXISTS `weblink`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `weblink` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(500) NOT NULL,
  `url` varchar(250) NOT NULL,
  `host` varchar(250) NOT NULL,
  `kid_friendly_status` tinyint DEFAULT NULL,
  `kid_friendly_marked_by` bigint DEFAULT NULL,
  `shared_by` bigint DEFAULT NULL,
  `created_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `url` (`url`(200)),
  KEY `kid_friendly_marked_by` (`kid_friendly_marked_by`),
  KEY `shared_by` (`shared_by`),
  CONSTRAINT `weblink_ibfk_1` FOREIGN KEY (`kid_friendly_marked_by`) REFERENCES `user` (`id`),
  CONSTRAINT `weblink_ibfk_2` FOREIGN KEY (`shared_by`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `weblink`
--

LOCK TABLES `weblink` WRITE;
/*!40000 ALTER TABLE `weblink` DISABLE KEYS */;
INSERT INTO `weblink` VALUES (1,'Use \nFinal Liberally','http://www.javapractices.com/topic/TopicAction.do?I\nd=23','http://www.javapractices.com',1,3,5,'2021-10-12 00:35:13'),(2,'How do I\nimport a pre-existing Java project into Eclipse and\nget up and running?','https://stackoverflow.com/questions/142863/how-do-i\n-import-a-pre-existing-java-project-into-eclipse-and\n-get-up-and-running','http://stackoverflow.com',1,3,5,'2021-10-12 00:35:14'),(3,'Interface vs Abstract Class','http://mindprod.com/jgloss/interfacevsabstract.html\n','http://mindprod.com',0,3,4,'2021-10-12 00:35:14'),(4,'NIO \ntutorial by Greg Travis','http://cs.brown.edu/courses/cs161/papers/j-nio-ltr.\npdf','http://cs.brown.edu',0,3,5,'2021-10-12 00:35:14'),(5,'Virtual\nHosting and Tomcat','http://tomcat.apache.org/tomcat-6.0-doc/virtual-hos\nting-howto.html','http://tomcat.apache.org',0,3,5,'2021-10-12 00:35:16');
/*!40000 ALTER TABLE `weblink` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-01-27 19:23:02
