CREATE DATABASE  IF NOT EXISTS `assignment3` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `assignment3`;
-- MySQL dump 10.13  Distrib 5.5.46, for debian-linux-gnu (x86_64)
--
-- Host: 127.0.0.1    Database: assignment3
-- ------------------------------------------------------
-- Server version	5.5.46-0ubuntu0.14.04.2

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
-- Table structure for table `Booking`
--

DROP TABLE IF EXISTS `Booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Booking` (
  `dateTaken` date NOT NULL,
  `droneID` int(11) NOT NULL,
  `clientID` int(11) NOT NULL,
  `dateDue` date NOT NULL,
  `daysDelayed` int(11) DEFAULT '0',
  `conditionOnCheckout` text NOT NULL,
  `finesDue` date DEFAULT NULL,
  `finesPaid` binary(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`dateTaken`),
  UNIQUE KEY `index4` (`dateTaken`,`droneID`,`clientID`),
  KEY `fk_Booking_1_idx` (`droneID`),
  KEY `fk_Booking_2_idx` (`clientID`),
  CONSTRAINT `fk_Booking_1` FOREIGN KEY (`droneID`) REFERENCES `Drone` (`droneID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Booking_2` FOREIGN KEY (`clientID`) REFERENCES `Client` (`clientID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Booking`
--

LOCK TABLES `Booking` WRITE;
/*!40000 ALTER TABLE `Booking` DISABLE KEYS */;
/*!40000 ALTER TABLE `Booking` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `Booking_Availability` 
	BEFORE INSERT ON `Booking` FOR EACH ROW
	begin
		IF (SELECT COUNT(dateTaken) FROM Booking
			WHERE dateTaken >= NEW.dateTaken
			AND endDate <= NEW.dateTaken
			AND clientID = NEW.clientID
			AND droneID = NEW.droneID) > 0 OR
			(SELECT COUNT(recordID) FROM MaintenanceRecord
			WHERE startDate >= NEW.dateTaken
			AND endDate <= NEW.dateTaken
			AND droneID = NEW.droneID) > 0
		THEN 
			SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Cannot add or update row. Dates conflict';
		END IF;
	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Client`
--

DROP TABLE IF EXISTS `Client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Client` (
  `clientID` int(11) NOT NULL AUTO_INCREMENT,
  `clientName` text NOT NULL,
  `clientAddress` mediumtext NOT NULL,
  `finesOutstanding` float NOT NULL,
  PRIMARY KEY (`clientID`),
  UNIQUE KEY `clientID_UNIQUE` (`clientID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Client`
--

LOCK TABLES `Client` WRITE;
/*!40000 ALTER TABLE `Client` DISABLE KEYS */;
INSERT INTO `Client` VALUES (4,'Sophie Cheong','123 Some Street, City, ON Canada A1B2C3',0),(5,'Mr Paninos','106 University Ave W #1, Waterloo, ON N2L 3E9',9),(6,'Feridun','200 University Ave W, Waterloo, ON N2L 3G1',5000000),(7,'University of Waterloo','200 University Ave W, Waterloo, ON N2L 3G1',8000),(8,'Chens','Chens Restaurant waterloo, ON Canada',1),(9,'Someone','225 Main Rd, Mississauga, ON Canada',0),(10,'My Name','123 Address Drive, City, ON Canada',0),(11,'Drone Client 1','Drone Client 1 Address',0);
/*!40000 ALTER TABLE `Client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Drone`
--

DROP TABLE IF EXISTS `Drone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Drone` (
  `droneID` int(11) NOT NULL AUTO_INCREMENT,
  `droneType` varchar(3) DEFAULT NULL,
  `manufacturer` varchar(50) DEFAULT NULL,
  `batteryType` varchar(50) DEFAULT NULL,
  `range` text,
  `yearBought` int(11) DEFAULT NULL,
  `description` text,
  `available` char(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`droneID`),
  UNIQUE KEY `droneID_UNIQUE` (`droneID`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Drone`
--

LOCK TABLES `Drone` WRITE;
/*!40000 ALTER TABLE `Drone` DISABLE KEYS */;
INSERT INTO `Drone` VALUES (1,'UAV','Dajiang Innovation','Lithium','long',2010,NULL,'1'),(2,'UAS','GoPro','Mercury','long',2015,'Some random description of the drone.','1'),(3,'RPV','Parrot EPA','Lithium','short',2012,NULL,'1'),(4,'RPS','Dajiang Innovation','Lithium','long',2010,NULL,'1'),(5,'UAV','Airware','Magnesium','long',2010,NULL,'1'),(6,'UAS','Airware','Mercury','short',2011,'This is in a pretty pink color.','1'),(7,'UAS','Parrot EPA','Magnesium','short',2013,NULL,'1'),(8,'RPV','Dajiang Innovation','Lithium','long',2013,NULL,'1'),(9,'RPV','GoPro','Lithium','short',2014,'This is a good description of the drone.','1'),(10,'RPS','Parrot EPA','Mercury','long',2015,'I can see you from up here.','1'),(11,'RPS','Dajiang Innovation','Lithium','long',2014,NULL,'1'),(12,'UAS','Dajiang Innovation','Lithium','short',2012,'Camera has 50x zoom.','1'),(13,'RPV','Dajiang Innovation','Magnesium','long',2010,NULL,'1'),(14,'RPV','Dajiang Innovation','Magnesium','short',2011,NULL,'1'),(15,'UAS','Parrot EPA','Magnesium','short',2013,'I believe I can fly.','1'),(16,'RPS','Parrot EPA','Mercury','short',2012,NULL,'1'),(17,'UAV','Parrot EPA','Lithium','short',2011,NULL,'1'),(18,'UAS','Airware','Lithium','short',2010,NULL,'1'),(19,'RPV','GoPro','Mercury','long',2010,NULL,'1'),(20,'RPS','GoPro','Magnesium','long',2015,NULL,'1');
/*!40000 ALTER TABLE `Drone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MaintenanceRecord`
--

DROP TABLE IF EXISTS `MaintenanceRecord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MaintenanceRecord` (
  `recordID` int(11) NOT NULL,
  `droneID` int(11) NOT NULL,
  `type` varchar(45) NOT NULL,
  `startDate` date NOT NULL,
  `endDate` date NOT NULL,
  `details` text,
  PRIMARY KEY (`recordID`),
  UNIQUE KEY `recordID_UNIQUE` (`recordID`),
  KEY `fk_MaintenanceRecord_1_idx` (`droneID`),
  CONSTRAINT `fk_MaintenanceRecord_1` FOREIGN KEY (`droneID`) REFERENCES `Drone` (`droneID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MaintenanceRecord`
--

LOCK TABLES `MaintenanceRecord` WRITE;
/*!40000 ALTER TABLE `MaintenanceRecord` DISABLE KEYS */;
/*!40000 ALTER TABLE `MaintenanceRecord` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `MaintenanceRecord_BINS` 
	BEFORE INSERT ON `MaintenanceRecord` FOR EACH ROW
	begin
		IF (SELECT COUNT(dateTaken) FROM Booking
			WHERE dateTaken >= NEW.startDate
			AND endDate <= NEW.startDate
			AND droneID = NEW.droneID) > 0 OR
			(SELECT COUNT(recordID) FROM MaintenanceRecord
			WHERE startDate >= NEW.startDate
			AND endDate <= NEW.startDate
			AND droneID = NEW.droneID) > 0
		THEN 
			SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Cannot add or update row. Dates conflict';
		END IF;
	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping routines for database 'assignment3'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-03-15 18:47:03
