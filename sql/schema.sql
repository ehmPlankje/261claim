-- MySQL dump 10.13  Distrib 5.5.41, for debian-linux-gnu (i686)
--
-- Host: localhost    Database: 261claim
-- ------------------------------------------------------
-- Server version	5.5.41-0+wheezy1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `airline`
--

DROP TABLE IF EXISTS `airline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `airline` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `iata` char(2) NOT NULL,
  `icao` char(3) NOT NULL,
  `name` varchar(32) NOT NULL,
  `callsign` varchar(32) NOT NULL,
  `country` char(2) DEFAULT NULL,
  `comments` varchar(255) NOT NULL,
  `active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `icao` (`icao`),
  UNIQUE KEY `name` (`name`),
  KEY `iata` (`iata`),
  KEY `active` (`active`),
  KEY `country` (`country`),
  CONSTRAINT `airline_ibfk_1` FOREIGN KEY (`country`) REFERENCES `country` (`alpha2`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1017 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `airport`
--

DROP TABLE IF EXISTS `airport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `airport` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `iata` char(3) NOT NULL,
  `icao` char(4) DEFAULT NULL,
  `name` varchar(64) NOT NULL,
  `alt_name` varchar(255) DEFAULT NULL,
  `city` varchar(64) DEFAULT NULL,
  `country` char(2) DEFAULT NULL,
  `timezone` varchar(32) NOT NULL,
  `lat` float NOT NULL,
  `lng` float NOT NULL,
  `wiki` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `iata` (`iata`),
  UNIQUE KEY `icao` (`icao`),
  KEY `name` (`name`),
  KEY `city` (`city`),
  KEY `country` (`country`),
  KEY `alt_name` (`alt_name`),
  CONSTRAINT `airport_ibfk_1` FOREIGN KEY (`country`) REFERENCES `country` (`alpha2`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3311 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `country` (
  `id` smallint(5) unsigned NOT NULL,
  `alpha2` char(2) NOT NULL,
  `alpha3` char(3) NOT NULL,
  `name` varchar(64) NOT NULL,
  `alt_name` varchar(64) DEFAULT NULL,
  `eu261` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `alpha2` (`alpha2`),
  UNIQUE KEY `alpha3` (`alpha3`),
  UNIQUE KEY `name` (`name`),
  KEY `eu261` (`eu261`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `flight`
--

DROP TABLE IF EXISTS `flight`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flight` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fxml_id` varchar(32) DEFAULT NULL,
  `departure` datetime DEFAULT NULL,
  `arrival` datetime DEFAULT NULL,
  `actualDeparture` datetime DEFAULT NULL,
  `actualArrival` datetime DEFAULT NULL,
  `origin` char(4) DEFAULT NULL,
  `destination` char(4) DEFAULT NULL,
  `distance` int(11) DEFAULT NULL,
  `airline` char(3) DEFAULT NULL,
  `aircraft` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `fxml_id` (`fxml_id`),
  KEY `origin` (`origin`),
  KEY `destination` (`destination`),
  KEY `departure` (`departure`),
  KEY `arrival` (`arrival`),
  KEY `actualDeparture` (`actualDeparture`),
  KEY `actualArrival` (`actualArrival`),
  KEY `airline` (`airline`),
  CONSTRAINT `flight_ibfk_3` FOREIGN KEY (`origin`) REFERENCES `airport` (`icao`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `flight_ibfk_4` FOREIGN KEY (`destination`) REFERENCES `airport` (`icao`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `flight_ibfk_5` FOREIGN KEY (`airline`) REFERENCES `airline` (`icao`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `password` (`password`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_claim`
--

DROP TABLE IF EXISTS `user_claim`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_claim` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `agency` varchar(64) DEFAULT NULL,
  `reference` varchar(16) DEFAULT NULL,
  `traveller` varchar(64) DEFAULT NULL,
  `price` float DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `user_claim_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_claim_flight`
--

DROP TABLE IF EXISTS `user_claim_flight`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_claim_flight` (
  `user_itinerary_id` int(10) unsigned NOT NULL,
  `flight_id` int(10) unsigned NOT NULL,
  UNIQUE KEY `user_itinerary_id` (`user_itinerary_id`,`flight_id`),
  KEY `user_itinerary_id_2` (`user_itinerary_id`),
  KEY `flight_id` (`flight_id`),
  CONSTRAINT `user_claim_flight_ibfk_2` FOREIGN KEY (`flight_id`) REFERENCES `flight` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_claim_flight_ibfk_1` FOREIGN KEY (`user_itinerary_id`) REFERENCES `user_claim` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-01-22 12:56:06
