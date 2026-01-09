CREATE DATABASE  IF NOT EXISTS `cinema` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `cinema`;
-- MySQL dump 10.13  Distrib 8.0.44, for macos15 (arm64)
--
-- Host: 127.0.0.1    Database: cinema
-- ------------------------------------------------------
-- Server version	9.5.0

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
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '2e0c71b6-d78d-11f0-93c9-4c90edf3fb0e:1-305';

--
-- Table structure for table `attori`
--

DROP TABLE IF EXISTS `attori`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attori` (
  `CodAttore` int NOT NULL AUTO_INCREMENT,
  `Nome` varchar(45) NOT NULL,
  `AnnoNascita` int NOT NULL,
  `Nazionalita` varchar(45) DEFAULT NULL,
  `identificativo` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`CodAttore`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attori`
--

LOCK TABLES `attori` WRITE;
/*!40000 ALTER TABLE `attori` DISABLE KEYS */;
INSERT INTO `attori` VALUES (1,'M. Mastroianni',1924,'Italia','Attore'),(2,'S. Loren',1934,'Italia','Attore'),(3,'R.Williams',1951,'Usa','Attore'),(4,'L. DiCaprio',1974,'Usa','Attore'),(5,'B. Pitt',1963,'Usa','Attore'),(6,'A. Delon',1935,'Francia','Attore'),(7,'M. Robbie',1990,'Australia','Attore'),(8,'L. Perry',1966,'Inghilterra','Attore'),(9,'D. Fanning',1994,'Usa','Attore'),(10,'E. Hirsch',1985,'Usa','Attore'),(11,'Al Pacino',1940,'Usa','Attore'),(13,'S. Bullock',1970,'USA','Attore'),(17,'Lino Banfi',1930,'Italia',NULL);
/*!40000 ALTER TABLE `attori` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `film`
--

DROP TABLE IF EXISTS `film`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `film` (
  `CodFilm` int NOT NULL AUTO_INCREMENT,
  `Titolo` varchar(45) NOT NULL,
  `AnnoProduzione` int NOT NULL,
  `Nazionalita` varchar(45) DEFAULT NULL,
  `Regista` int NOT NULL,
  `Genere` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`CodFilm`),
  KEY `registi_idx` (`Regista`),
  CONSTRAINT `registi` FOREIGN KEY (`Regista`) REFERENCES `registi` (`CodRegista`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `film`
--

LOCK TABLES `film` WRITE;
/*!40000 ALTER TABLE `film` DISABLE KEYS */;
INSERT INTO `film` VALUES (1,'The Wolf of Wall Street',2013,'Usa',1,'Autobiografico'),(2,'Shutter Island',2010,'Usa',1,'Psycho'),(3,'Inception',2010,'Usa',2,'Fantasy'),(4,'C era una volta a Hollywood',2019,'Usa',3,'Storico'),(5,'Patch Adams',1998,'Usa',4,'Drammatico'),(6,'Will Hunting',1997,'Usa',5,'Drammatico'),(7,'La Ciociara',1960,'Italia',6,'Drammatico'),(8,'Matrimonio all italiana',1964,'Italia',6,'Commedia'),(9,'La vita davanti a se',2020,'Italia',7,'Drammatico'),(10,'Divorzio all italiana',1961,'Italia',8,'Commedia'),(11,'Il Casanova',1976,'Italia',9,'Commedia'),(12,'Zorro',1975,'Italia',10,'Avventura'),(13,'Il Tulipano Nero',1964,'Francia',11,'Commedia'),(14,'La Grande Scommessa',2015,'Usa',12,'Autobiografico'),(15,'La Strada',1954,'Italia',9,'Commedia'),(19,'Avatar',2009,'USA',16,'Fantasy');
/*!40000 ALTER TABLE `film` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proiezioni`
--

DROP TABLE IF EXISTS `proiezioni`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proiezioni` (
  `CodProiezioni` int NOT NULL AUTO_INCREMENT,
  `idFilm` int DEFAULT NULL,
  `CodSala` int NOT NULL,
  `Incasso` double DEFAULT NULL,
  `DataProiezione` date DEFAULT NULL,
  PRIMARY KEY (`CodProiezioni`),
  KEY `CodSala_idx` (`CodSala`),
  KEY `CodFilm_idx` (`idFilm`),
  CONSTRAINT `CodSala` FOREIGN KEY (`CodSala`) REFERENCES `sale` (`CodSala`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `idFilm` FOREIGN KEY (`idFilm`) REFERENCES `film` (`CodFilm`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=137 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proiezioni`
--

LOCK TABLES `proiezioni` WRITE;
/*!40000 ALTER TABLE `proiezioni` DISABLE KEYS */;
INSERT INTO `proiezioni` VALUES (100,1,1,2500,'2022-12-24'),(101,1,2,3680,'2022-12-24'),(102,1,3,5410,'2022-12-25'),(103,1,4,900,'2022-11-10'),(104,1,5,1693,'2022-12-17'),(105,1,6,845,'2021-11-30'),(106,1,7,9874,'2021-09-23'),(107,1,8,13,'2021-09-23'),(108,2,8,4120.5,'2022-12-25'),(109,2,8,36.5,'2022-06-06'),(110,1,5,842.3,'2022-11-10'),(111,3,1,3200,'2022-12-25'),(112,3,6,6542.8,'2021-11-30'),(113,3,6,95.2,'2021-11-30'),(114,4,7,21.3,'2021-09-23'),(115,5,2,324.1,'2021-09-23'),(116,6,3,36,'2021-09-23'),(117,6,4,69,'2022-06-06'),(118,6,7,754,'2022-06-06'),(119,7,5,320,'2022-06-06'),(120,7,6,965.2,'2022-06-06'),(121,8,1,35,'2022-12-25'),(122,8,5,12,'2022-12-25'),(123,8,8,69,'2022-11-10'),(124,8,8,321,'2022-07-14'),(125,9,3,33,'2022-07-14'),(126,9,3,14,'2022-07-15'),(127,9,3,863,'2022-07-15'),(128,10,1,8503,'2022-04-17'),(129,10,7,412,'2022-04-17'),(130,11,2,500,'2022-04-23'),(131,11,2,500,'2022-04-23'),(132,11,5,316,'2022-04-28'),(133,12,4,15,'2022-12-25'),(134,13,2,896,'2022-07-14'),(135,14,6,742,'2022-07-14'),(136,14,8,812,'2022-11-10');
/*!40000 ALTER TABLE `proiezioni` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recita`
--

DROP TABLE IF EXISTS `recita`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recita` (
  `CodAttore` int NOT NULL,
  `IdFilm` int NOT NULL,
  PRIMARY KEY (`CodAttore`,`IdFilm`),
  KEY `CodFilm_idx` (`IdFilm`),
  CONSTRAINT `CodAttore` FOREIGN KEY (`CodAttore`) REFERENCES `attori` (`CodAttore`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `CodFilm` FOREIGN KEY (`IdFilm`) REFERENCES `film` (`CodFilm`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recita`
--

LOCK TABLES `recita` WRITE;
/*!40000 ALTER TABLE `recita` DISABLE KEYS */;
INSERT INTO `recita` VALUES (4,1),(4,2),(4,3),(4,4),(5,4),(7,4),(8,4),(9,4),(10,4),(11,4),(3,5),(3,6),(2,7),(1,8),(2,8),(1,9),(2,9),(1,10),(1,11),(6,12),(6,13),(5,14);
/*!40000 ALTER TABLE `recita` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registi`
--

DROP TABLE IF EXISTS `registi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `registi` (
  `CodRegista` int NOT NULL AUTO_INCREMENT,
  `Nome` varchar(45) NOT NULL,
  `AnnoNascita` int NOT NULL,
  `Nazionalita` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`CodRegista`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registi`
--

LOCK TABLES `registi` WRITE;
/*!40000 ALTER TABLE `registi` DISABLE KEYS */;
INSERT INTO `registi` VALUES (1,'Martin Scorsese',1942,'USA'),(2,'Christopher Nolan',1970,'Inghilterra'),(3,'Quentin Tarantino',1963,'USA'),(4,'Tom Shadyac',1958,'USA'),(5,'Gus Van Sant',1952,'USA'),(6,'Vittorio De Sica',1901,'Italia'),(7,'Edoardo Ponti',1973,'Svizzera'),(8,'Pietro Germi',1914,'Italia'),(9,'Federico Fellini',1920,'Italia'),(10,'Duccio Tessari',1926,'Italia'),(11,'Christian-Jacque',1904,'Francia'),(12,'Adam McKay',1968,'USA'),(16,'James Cameron',1954,'Canada');
/*!40000 ALTER TABLE `registi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sale`
--

DROP TABLE IF EXISTS `sale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sale` (
  `CodSala` int NOT NULL AUTO_INCREMENT,
  `Posti` int NOT NULL,
  `Nome` varchar(45) NOT NULL,
  `Citta` varchar(45) NOT NULL,
  PRIMARY KEY (`CodSala`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sale`
--

LOCK TABLES `sale` WRITE;
/*!40000 ALTER TABLE `sale` DISABLE KEYS */;
INSERT INTO `sale` VALUES (1,346,'Multisala Eliseo','Milano'),(2,71,'Eden Film Center','Roma'),(3,610,'Cinema Greenwich','Roma'),(4,340,'UCI Cinemas Roma Est','Roma'),(5,180,'Multisala Barberini','Roma'),(6,1020,'Multisala Isola Verde','Pisa'),(7,750,'Multisala Odeon','Pisa'),(8,450,'Cinema Arno','Pisa');
/*!40000 ALTER TABLE `sale` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-01-09 13:37:26
