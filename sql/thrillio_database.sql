-- MySQL dump 10.13  Distrib 8.0.28, for Linux (x86_64)
--
-- Host: localhost    Database: jid_thrillio
-- ------------------------------------------------------
-- Server version	8.0.28-0ubuntu0.20.04.3

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
  `imageUrl` varchar(255) DEFAULT NULL,
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
INSERT INTO `movie` VALUES (1,'Citizen Kane','https://m.media-amazon.com/images/I/91zcYtPPMOL._AC_SY445_.jpg',1941,0,8.5,1,3,'2021-10-17 17:51:32'),(2,'The Grapes of Wrath','https://a.ltrbxd.com/resized/film-poster/5/1/5/2/5/51525-the-grapes-of-wrath-0-230-0-345-crop.jpg?k=05c9360b90',1940,0,8.2,1,3,'2021-10-17 17:51:33'),(3,'A Touch of Greatness','https://www.downtoearth.org/sites/default/files/styles/flyer-thumb/public/images/events/flyers/TouchOfGreatness_0.jpg?itok=RUcR-xRS',2004,24,7.3,1,3,'2021-10-17 17:51:33'),(4,'The Big Bang Theory','https://m.media-amazon.com/images/M/MV5BY2FmZTY5YTktOWRlYy00NmIyLWE0ZmQtZDg2YjlmMzczZDZiXkEyXkFqcGdeQXVyNjg4NzAyOTA@._V1_.jpg',2007,20,8.7,0,3,'2021-10-17 17:51:33'),(5,'Ikiru','https://s3.amazonaws.com/criterion-production/films/170a20632c3aaea17daab26fe62ae0b4/KEnmrGEhKGIUoIrMqG2vVjSk0nkr1h_large.jpg',1952,25,8.4,0,3,'2021-10-17 17:51:34');
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
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_book`
--

LOCK TABLES `user_book` WRITE;
/*!40000 ALTER TABLE `user_book` DISABLE KEYS */;
INSERT INTO `user_book` VALUES (20,5,4),(22,5,2),(25,5,1),(56,3,4);
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
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_movie`
--

LOCK TABLES `user_movie` WRITE;
/*!40000 ALTER TABLE `user_movie` DISABLE KEYS */;
INSERT INTO `user_movie` VALUES (1,1,3),(2,4,2),(3,4,2),(4,4,2),(5,4,1),(6,4,3),(7,4,4),(8,4,5),(9,4,5),(23,3,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_weblink`
--

LOCK TABLES `user_weblink` WRITE;
/*!40000 ALTER TABLE `user_weblink` DISABLE KEYS */;
INSERT INTO `user_weblink` VALUES (1,1,5),(2,4,5),(3,4,5),(4,4,5),(14,3,1);
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

-- Dump completed on 2022-02-11 16:09:39
