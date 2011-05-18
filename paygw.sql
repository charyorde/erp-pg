-- MySQL dump 10.13  Distrib 5.1.41, for debian-linux-gnu (i486)
--
-- Host: localhost    Database: paygw
-- ------------------------------------------------------
-- Server version	5.1.41-3ubuntu12.8

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
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
INSERT INTO `auth_group` VALUES (1,'Teller'),(2,'Supervisor');
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`,`permission_id`),
  KEY `auth_group_permissions_425ae3c4` (`group_id`),
  KEY `auth_group_permissions_1e014c8f` (`permission_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
INSERT INTO `auth_group_permissions` VALUES (1,1,35),(2,2,9),(3,2,8),(4,2,7),(5,2,35);
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_message`
--

DROP TABLE IF EXISTS `auth_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `message` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `auth_message_403f60f` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_message`
--

LOCK TABLES `auth_message` WRITE;
/*!40000 ALTER TABLE `auth_message` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_type_id` (`content_type_id`,`codename`),
  KEY `auth_permission_1bb8f392` (`content_type_id`)
) ENGINE=MyISAM AUTO_INCREMENT=43 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add permission',1,'add_permission'),(2,'Can change permission',1,'change_permission'),(3,'Can delete permission',1,'delete_permission'),(4,'Can add group',2,'add_group'),(5,'Can change group',2,'change_group'),(6,'Can delete group',2,'delete_group'),(7,'Can add user',3,'add_user'),(8,'Can change user',3,'change_user'),(9,'Can delete user',3,'delete_user'),(10,'Can add message',4,'add_message'),(11,'Can change message',4,'change_message'),(12,'Can delete message',4,'delete_message'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'Can add site',7,'add_site'),(20,'Can change site',7,'change_site'),(21,'Can delete site',7,'delete_site'),(22,'Can add log entry',8,'add_logentry'),(23,'Can change log entry',8,'change_logentry'),(24,'Can delete log entry',8,'delete_logentry'),(25,'Can add access attempt',9,'add_accessattempt'),(26,'Can change access attempt',9,'change_accessattempt'),(27,'Can delete access attempt',9,'delete_accessattempt'),(28,'Can add institution',10,'add_institution'),(29,'Can change institution',10,'change_institution'),(30,'Can delete institution',10,'delete_institution'),(31,'Can add transaction audit log entry',11,'add_transactionauditlogentry'),(32,'Can change transaction audit log entry',11,'change_transactionauditlogentry'),(33,'Can delete transaction audit log entry',11,'delete_transactionauditlogentry'),(34,'Can add transaction',12,'add_transaction'),(35,'Can change transaction',12,'change_transaction'),(36,'Can delete transaction',12,'delete_transaction'),(37,'Can add financial institution',13,'add_financialinstitution'),(38,'Can change financial institution',13,'change_financialinstitution'),(39,'Can delete financial institution',13,'delete_financialinstitution'),(40,'Can add user profile',14,'add_userprofile'),(41,'Can change user profile',14,'change_userprofile'),(42,'Can delete user profile',14,'delete_userprofile');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(75) NOT NULL,
  `password` varchar(128) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `last_login` datetime NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'webapp','','','takinbo@gmail.com','sha1$01074$4ce3193ec57d6a3e21d4d4844ad645e6657e9f47',1,1,1,'2011-04-21 16:49:04','2011-02-09 13:53:25'),(2,'demo','Demo','User','demo@datasphir.com','sha1$890fa$e3cb6cee727496572cf0a3dc4435377d522cde5b',0,1,0,'2011-04-26 17:46:32','2011-02-10 12:45:38'),(3,'dami','dami','pereira','dami@datasphir.com','sha1$7a4f3$9bc75fae26948318a3e5c1bb6e87442c8e047f37',0,1,0,'2011-04-21 17:09:09','2011-02-10 12:53:27'),(4,'banker','Test','Banker','banker@demo.com','sha1$8f906$6161ddfa102ea80433ef2381855c352b69f47a39',0,1,0,'2011-05-16 12:49:32','2011-02-11 13:54:07'),(5,'testteller','Test','Teller','adeliyi.victor@intercontinentalbankplc.com','sha1$41e21$b286c53b67282e2dbed34348a4790ea42d408e78',0,1,0,'2011-03-08 08:03:15','2011-03-08 08:03:15');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`group_id`),
  KEY `auth_user_groups_403f60f` (`user_id`),
  KEY `auth_user_groups_425ae3c4` (`group_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
INSERT INTO `auth_user_groups` VALUES (2,2,2);
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`permission_id`),
  KEY `auth_user_user_permissions_403f60f` (`user_id`),
  KEY `auth_user_user_permissions_1e014c8f` (`permission_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `axes_accessattempt`
--

DROP TABLE IF EXISTS `axes_accessattempt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `axes_accessattempt` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_agent` varchar(255) NOT NULL,
  `ip_address` char(15) NOT NULL,
  `get_data` longtext NOT NULL,
  `post_data` longtext NOT NULL,
  `http_accept` varchar(255) NOT NULL,
  `path_info` varchar(255) NOT NULL,
  `failures_since_start` int(10) unsigned NOT NULL,
  `attempt_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `axes_accessattempt`
--

LOCK TABLES `axes_accessattempt` WRITE;
/*!40000 ALTER TABLE `axes_accessattempt` DISABLE KEYS */;
INSERT INTO `axes_accessattempt` VALUES (3,'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.0; Trident/4.0; SLCC1; .NET CLR 2.0.50727; .NET CLR 1.1.4322; .NET CLR 3.5.30729; .NET CLR 3.0.30618)','202.45.119.26','','username=\ncsrfmiddlewaretoken=d8e32a822cb4429ff66ef876dfcbca7a','image/gif, image/jpeg, image/pjpeg, application/x-ms-application, application/vnd.ms-xpsdocument, application/xaml+xml, application/x-ms-xbap, application/x-shockwave-flash, application/vnd.ms-excel, application/vnd.ms-powerpoint, application/msword, appl','/login',1,'2011-03-10 23:09:33'),(4,'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.0; Trident/4.0; SLCC1; .NET CLR 2.0.50727; .NET CLR 1.1.4322; .NET CLR 3.5.30729; .NET CLR 3.0.30618)','202.45.119.10','','username=\ncsrfmiddlewaretoken=d8e32a822cb4429ff66ef876dfcbca7a','image/gif, image/jpeg, image/pjpeg, application/x-ms-application, application/vnd.ms-xpsdocument, application/xaml+xml, application/x-ms-xbap, application/x-shockwave-flash, application/vnd.ms-excel, application/vnd.ms-powerpoint, application/msword, appl','/login',1,'2011-03-10 23:12:33'),(5,'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; .NET CLR 1.1.4322; .NET CLR 2.0.50727; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729)','202.45.119.12','\n---------\n','username=08876131\ncsrfmiddlewaretoken=221b66454260554b9a5a6db33a06d418\n---------\nusername=08876131\ncsrfmiddlewaretoken=221b66454260554b9a5a6db33a06d418','image/gif, image/jpeg, image/pjpeg, image/pjpeg, application/vnd.ms-excel, application/vnd.ms-powerpoint, application/msword, application/x-ms-application, application/x-ms-xbap, application/vnd.ms-xpsdocument, application/xaml+xml, */*','/login',2,'2011-03-15 00:31:08'),(7,'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.12) Gecko/20101026 Firefox/3.6.12','58.161.122.249','\n---------\n\n---------\n\n---------\n\n---------\n\n---------\n','username=08762553\ncsrfmiddlewaretoken=8412ef102891813eaf7bf4e812f682b7\n---------\nusername=08762553\ncsrfmiddlewaretoken=8412ef102891813eaf7bf4e812f682b7\n---------\nusername=08762553\ncsrfmiddlewaretoken=8412ef102891813eaf7bf4e812f682b7\n---------\nusername=08762553\ncsrfmiddlewaretoken=8412ef102891813eaf7bf4e812f682b7\n---------\nusername=08762553\ncsrfmiddlewaretoken=8412ef102891813eaf7bf4e812f682b7\n---------\nusername=08762553\ncsrfmiddlewaretoken=8412ef102891813eaf7bf4e812f682b7','text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8','/login',6,'2011-03-23 11:13:55'),(8,'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; Trident/4.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; InfoPath.3; .NET CLR 1.1.4322; .NET4.0C; .NET4.0E)','202.45.119.28','','username=09023460\ncsrfmiddlewaretoken=8f466ab6eedb99f48a46e15bb66f0ccb','image/jpeg, application/x-ms-application, image/gif, application/xaml+xml, image/pjpeg, application/x-ms-xbap, application/vnd.ms-excel, application/vnd.ms-powerpoint, application/msword, */*','/login',1,'2011-04-04 00:36:54'),(9,'Mozilla/5.0 (Windows; U; Windows NT 5.2; en-US; rv:1.9.1.18) Gecko/20110319 Firefox/3.5.18 GTB7.1','41.155.30.87','','username=\ncsrfmiddlewaretoken=96a49c716c4ead27b7110925c2b9806a','text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8','/login',1,'2011-04-21 10:31:32'),(12,'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.0; Trident/4.0; FunWebProducts; GTB6.6; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 1.1.4322; .NET CLR 3.5.30729; .NET CLR 3.0.30729; .NET4.0C; BRI/2)','124.180.150.110','\n---------\n\n---------\n\n---------\n','username=\ncsrfmiddlewaretoken=e33c9aed697452ac42d19ad73cbb1627\n---------\nusername=08306230\ncsrfmiddlewaretoken=e33c9aed697452ac42d19ad73cbb1627\n---------\nusername=07\ncsrfmiddlewaretoken=e33c9aed697452ac42d19ad73cbb1627\n---------\nusername=08306230\ncsrfmiddlewaretoken=e33c9aed697452ac42d19ad73cbb1627','image/gif, image/jpeg, image/pjpeg, application/x-ms-application, application/vnd.ms-xpsdocument, application/xaml+xml, application/x-ms-xbap, application/x-shockwave-flash, application/x-silverlight, */*','/login',4,'2011-04-24 23:33:29');
/*!40000 ALTER TABLE `axes_accessattempt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_403f60f` (`user_id`),
  KEY `django_admin_log_1bb8f392` (`content_type_id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2011-02-10 12:42:42',1,13,'1','Intercontinental Bank',1,''),(2,'2011-02-10 12:44:57',1,10,'1','UNIVERSITY A',1,''),(3,'2011-02-10 12:45:06',1,10,'2','UNIVERSITY B',1,''),(4,'2011-02-10 12:45:38',1,3,'2','demo',1,''),(5,'2011-02-10 12:46:03',1,3,'2','demo',2,'Changed first_name, last_name, email and groups.'),(6,'2011-02-10 12:46:34',1,14,'2','demo',2,'Changed financial_institution.'),(7,'2011-02-10 13:01:33',1,3,'2','demo',2,'No fields changed.'),(8,'2011-02-11 13:02:57',1,12,'1','ac0e95f6cd994cc39807d986f7a10d4d',1,''),(9,'2011-02-11 13:03:19',1,12,'2','7067361871fd459faa144988ffa22c7c',1,''),(10,'2011-02-11 13:03:37',1,12,'3','d257e6838f094689a57db31d65aaea6c',1,''),(11,'2011-02-11 13:04:06',1,12,'4','134e5ab4b0a74b5a985ff53e31370818',1,''),(12,'2011-02-11 13:04:23',1,12,'5','ef451670efad4995bff755621c162807',1,'');
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_label` (`app_label`,`model`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'permission','auth','permission'),(2,'group','auth','group'),(3,'user','auth','user'),(4,'message','auth','message'),(5,'content type','contenttypes','contenttype'),(6,'session','sessions','session'),(7,'site','sites','site'),(8,'log entry','admin','logentry'),(9,'access attempt','axes','accessattempt'),(10,'institution','webapp','institution'),(11,'transaction audit log entry','webapp','transactionauditlogentry'),(12,'transaction','webapp','transaction'),(13,'financial institution','webapp','financialinstitution'),(14,'user profile','webapp','userprofile');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('3764de06f886a965fb42c834f71a711c','gAJ9cQFVCnRlc3Rjb29raWVxAlUGd29ya2VkcQNzLjRiYmM0M2I1YjdjMzEwMDhlZmVmNGRlZGEy\nODE3YzA3\n','2011-03-04 03:04:16'),('d606c52bbeb15034dddf2752255e753d','gAJ9cQFVCnRlc3Rjb29raWVxAlUGd29ya2VkcQNzLjRiYmM0M2I1YjdjMzEwMDhlZmVmNGRlZGEy\nODE3YzA3\n','2011-02-28 04:37:07'),('6f9b36b26d2b4c8e9013fa1837773e16','gAJ9cQFVCnRlc3Rjb29raWVxAlUGd29ya2VkcQNzLjRiYmM0M2I1YjdjMzEwMDhlZmVmNGRlZGEy\nODE3YzA3\n','2011-02-23 19:43:38'),('071d6119bb11bc04ff393d873a8ad47f','gAJ9cQFVCnRlc3Rjb29raWVxAlUGd29ya2VkcQNzLjRiYmM0M2I1YjdjMzEwMDhlZmVmNGRlZGEy\nODE3YzA3\n','2011-03-05 03:09:50'),('4b64840bba2ffe846ca8740cf51fa26c','gAJ9cQFVCnRlc3Rjb29raWVxAlUGd29ya2VkcQNzLjRiYmM0M2I1YjdjMzEwMDhlZmVmNGRlZGEy\nODE3YzA3\n','2011-02-24 07:50:23'),('935201640ee126acdfef990b1b27199d','gAJ9cQFVCnRlc3Rjb29raWVxAlUGd29ya2VkcQNzLjRiYmM0M2I1YjdjMzEwMDhlZmVmNGRlZGEy\nODE3YzA3\n','2011-03-09 17:12:08'),('a8a69d9274cb1ab69e6e1821a4a3c987','gAJ9cQFVCnRlc3Rjb29raWVxAlUGd29ya2VkcQNzLjRiYmM0M2I1YjdjMzEwMDhlZmVmNGRlZGEy\nODE3YzA3\n','2011-03-02 03:27:05'),('49067c4c57a425545de5cf30c1c526a6','gAJ9cQFVCnRlc3Rjb29raWVxAlUGd29ya2VkcQNzLjRiYmM0M2I1YjdjMzEwMDhlZmVmNGRlZGEy\nODE3YzA3\n','2011-02-28 06:44:10'),('35857f6a3888ded406b114cca3f8d04c','gAJ9cQFVCnRlc3Rjb29raWVxAlUGd29ya2VkcQNzLjRiYmM0M2I1YjdjMzEwMDhlZmVmNGRlZGEy\nODE3YzA3\n','2011-02-25 05:31:07'),('8883f12309a52789ec801a5ab94fe73a','gAJ9cQFVCnRlc3Rjb29raWVxAlUGd29ya2VkcQNzLjRiYmM0M2I1YjdjMzEwMDhlZmVmNGRlZGEy\nODE3YzA3\n','2011-02-25 14:08:49'),('2d37ec7e314495bbb10049044cbdbec2','gAJ9cQEoVRJfYXV0aF91c2VyX2JhY2tlbmRxAlUpZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5k\ncy5Nb2RlbEJhY2tlbmRxA1UNX2F1dGhfdXNlcl9pZHEEigEBdS5kYTc3YzMyOTYxMzRjYjI1YWU3\nMDI4NDVmYjE4OTI3Zg==\n','2011-03-08 13:38:07'),('53cef9ccc01041d3329757ea6883de4d','gAJ9cQFVCnRlc3Rjb29raWVxAlUGd29ya2VkcQNzLjRiYmM0M2I1YjdjMzEwMDhlZmVmNGRlZGEy\nODE3YzA3\n','2011-02-26 05:33:51'),('1a2dce5f3b9f952813aff3a629b92585','gAJ9cQFVCnRlc3Rjb29raWVxAlUGd29ya2VkcQNzLjRiYmM0M2I1YjdjMzEwMDhlZmVmNGRlZGEy\nODE3YzA3\n','2011-02-27 05:13:57'),('0296bee870f4a5954886fa6d41aa4d6d','gAJ9cQEoVRJfYXV0aF91c2VyX2JhY2tlbmRxAlUpZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5k\ncy5Nb2RlbEJhY2tlbmRxA1UNX2F1dGhfdXNlcl9pZHEEigEBdS5kYTc3YzMyOTYxMzRjYjI1YWU3\nMDI4NDVmYjE4OTI3Zg==\n','2011-03-07 07:59:24'),('033541576296e888546280a23e25304f','gAJ9cQFVCnRlc3Rjb29raWVxAlUGd29ya2VkcQNzLjRiYmM0M2I1YjdjMzEwMDhlZmVmNGRlZGEy\nODE3YzA3\n','2011-03-11 09:01:08'),('8fa0853db41edba731aaed45d5d12171','gAJ9cQFVCnRlc3Rjb29raWVxAlUGd29ya2VkcQNzLjRiYmM0M2I1YjdjMzEwMDhlZmVmNGRlZGEy\nODE3YzA3\n','2011-03-29 00:31:13'),('71ba673ee1eeba2276a64ca3cf076417','gAJ9cQEuYzM0Mjc4YWI1ZDhmNDdlNzQwYzhlZGEyNWNkOGFmZWM=\n','2011-04-06 11:15:32'),('e0c5d53c7138004ad835ab1c50756516','gAJ9cQFVCnRlc3Rjb29raWVxAlUGd29ya2VkcQNzLjRiYmM0M2I1YjdjMzEwMDhlZmVmNGRlZGEy\nODE3YzA3\n','2011-04-08 12:27:15'),('b14a2d5e193a638feba28535c2cf73d2','gAJ9cQFVCnRlc3Rjb29raWVxAlUGd29ya2VkcQNzLjRiYmM0M2I1YjdjMzEwMDhlZmVmNGRlZGEy\nODE3YzA3\n','2011-04-04 21:55:35'),('94005dc9434dd05dcba8d16ef750798c','gAJ9cQFVCnRlc3Rjb29raWVxAlUGd29ya2VkcQNzLjRiYmM0M2I1YjdjMzEwMDhlZmVmNGRlZGEy\nODE3YzA3\n','2011-03-09 17:56:39'),('d1755e73130d22ca96ed87b9df457ffd','gAJ9cQFVCnRlc3Rjb29raWVxAlUGd29ya2VkcQNzLjRiYmM0M2I1YjdjMzEwMDhlZmVmNGRlZGEy\nODE3YzA3\n','2011-03-15 23:04:56'),('fc0286a8bd685ffa5aaa682553e93658','gAJ9cQFVCnRlc3Rjb29raWVxAlUGd29ya2VkcQNzLjRiYmM0M2I1YjdjMzEwMDhlZmVmNGRlZGEy\nODE3YzA3\n','2011-03-23 10:06:23'),('23b9d47b5539dfe74752a507c1791182','gAJ9cQFVCnRlc3Rjb29raWVxAlUGd29ya2VkcQNzLjRiYmM0M2I1YjdjMzEwMDhlZmVmNGRlZGEy\nODE3YzA3\n','2011-03-24 23:12:45'),('e2d84f5830bc946bb12950861c7a1dc8','gAJ9cQFVCnRlc3Rjb29raWVxAlUGd29ya2VkcQNzLjRiYmM0M2I1YjdjMzEwMDhlZmVmNGRlZGEy\nODE3YzA3\n','2011-04-18 00:36:58'),('349d0e0fc625b7e19ec8aba91482e7db','gAJ9cQFVCnRlc3Rjb29raWVxAlUGd29ya2VkcQNzLjRiYmM0M2I1YjdjMzEwMDhlZmVmNGRlZGEy\nODE3YzA3\n','2011-04-24 14:17:32'),('eb7cb983cb618c57aeaec73ed7a119dc','gAJ9cQFVCnRlc3Rjb29raWVxAlUGd29ya2VkcQNzLjRiYmM0M2I1YjdjMzEwMDhlZmVmNGRlZGEy\nODE3YzA3\n','2011-04-26 14:14:03'),('ccd9b037edc856b76b6746d5e04d9012','gAJ9cQFVCnRlc3Rjb29raWVxAlUGd29ya2VkcQNzLjRiYmM0M2I1YjdjMzEwMDhlZmVmNGRlZGEy\nODE3YzA3\n','2011-04-26 14:15:48'),('260e39dc3a4686d1658def53effbf3ff','gAJ9cQFVCnRlc3Rjb29raWVxAlUGd29ya2VkcQNzLjRiYmM0M2I1YjdjMzEwMDhlZmVmNGRlZGEy\nODE3YzA3\n','2011-05-04 05:18:34'),('412124aa224f48965eb1cad2af59066b','gAJ9cQFVCnRlc3Rjb29raWVxAlUGd29ya2VkcQNzLjRiYmM0M2I1YjdjMzEwMDhlZmVmNGRlZGEy\nODE3YzA3\n','2011-05-31 01:13:20'),('59c654a9ced2e711c1e1957064135906','gAJ9cQFVCnRlc3Rjb29raWVxAlUGd29ya2VkcQNzLjRiYmM0M2I1YjdjMzEwMDhlZmVmNGRlZGEy\nODE3YzA3\n','2011-05-10 18:20:18'),('bbb14d8fe472ccbb8993781e1c417393','gAJ9cQFVCnRlc3Rjb29raWVxAlUGd29ya2VkcQNzLjRiYmM0M2I1YjdjMzEwMDhlZmVmNGRlZGEy\nODE3YzA3\n','2011-05-11 06:23:43'),('cc9235230a26afd812475e991eff48fa','gAJ9cQFVCnRlc3Rjb29raWVxAlUGd29ya2VkcQNzLjRiYmM0M2I1YjdjMzEwMDhlZmVmNGRlZGEy\nODE3YzA3\n','2011-05-09 01:32:22'),('bf686e5a424574be899870aacf5cbaaf','gAJ9cQFVCnRlc3Rjb29raWVxAlUGd29ya2VkcQNzLjRiYmM0M2I1YjdjMzEwMDhlZmVmNGRlZGEy\nODE3YzA3\n','2011-05-08 23:33:29'),('0040cfe00e3b75c2891f4d8b6f036706','gAJ9cQEoVRJfYXV0aF91c2VyX2JhY2tlbmRxAlUpZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5k\ncy5Nb2RlbEJhY2tlbmRxA1UNX2F1dGhfdXNlcl9pZHEEigECdS5hNjNkMjA1MGYzYzFlNTAwZDcx\nNzI3YzY3OWFiY2VhYw==\n','2011-05-05 18:58:03'),('f534f19d9392944baaeb8c4fe0fe9200','gAJ9cQFVCnRlc3Rjb29raWVxAlUGd29ya2VkcQNzLjRiYmM0M2I1YjdjMzEwMDhlZmVmNGRlZGEy\nODE3YzA3\n','2011-05-19 12:53:23'),('803fd3e85f78505502642cc79c08dbb1','gAJ9cQFVCnRlc3Rjb29raWVxAlUGd29ya2VkcQNzLjRiYmM0M2I1YjdjMzEwMDhlZmVmNGRlZGEy\nODE3YzA3\n','2011-05-15 09:58:14'),('09100974cb7a54c7fc855c7091d513d3','gAJ9cQFVCnRlc3Rjb29raWVxAlUGd29ya2VkcQNzLjRiYmM0M2I1YjdjMzEwMDhlZmVmNGRlZGEy\nODE3YzA3\n','2011-05-16 06:21:00'),('edf878a81ae3d5f1488ab5276f8c0f11','gAJ9cQFVCnRlc3Rjb29raWVxAlUGd29ya2VkcQNzLjRiYmM0M2I1YjdjMzEwMDhlZmVmNGRlZGEy\nODE3YzA3\n','2011-05-15 07:01:14'),('552763c004a487249c324380fe7b66ef','gAJ9cQEoVRJfYXV0aF91c2VyX2JhY2tlbmRxAlUpZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5k\ncy5Nb2RlbEJhY2tlbmRxA1UNX2F1dGhfdXNlcl9pZHEEigEEdS43NTA4OWE3ZWU2OTNjODkxZGFl\nNjE5NmQ3ZjJkZTFmYQ==\n','2011-05-13 00:53:34'),('301f95fbbccdae2ccf3b7b2abf8894c5','gAJ9cQFVCnRlc3Rjb29raWVxAlUGd29ya2VkcQNzLjRiYmM0M2I1YjdjMzEwMDhlZmVmNGRlZGEy\nODE3YzA3\n','2011-05-14 06:58:34'),('7710d8d23529e2dbaae8eb8958212037','gAJ9cQFVCnRlc3Rjb29raWVxAlUGd29ya2VkcQNzLjRiYmM0M2I1YjdjMzEwMDhlZmVmNGRlZGEy\nODE3YzA3\n','2011-05-20 06:51:12'),('0aad4c4087c0f25b690f4db1573b7965','gAJ9cQFVCnRlc3Rjb29raWVxAlUGd29ya2VkcQNzLjRiYmM0M2I1YjdjMzEwMDhlZmVmNGRlZGEy\nODE3YzA3\n','2011-05-23 12:04:59'),('6c43df5ad43cc5575a71785fabad7891','gAJ9cQEoVRJfYXV0aF91c2VyX2JhY2tlbmRxAlUpZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5k\ncy5Nb2RlbEJhY2tlbmRxA1UNX2F1dGhfdXNlcl9pZHEEigEEdS43NTA4OWE3ZWU2OTNjODkxZGFl\nNjE5NmQ3ZjJkZTFmYQ==\n','2011-05-30 12:49:32');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_site`
--

DROP TABLE IF EXISTS `django_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_site` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_site`
--

LOCK TABLES `django_site` WRITE;
/*!40000 ALTER TABLE `django_site` DISABLE KEYS */;
INSERT INTO `django_site` VALUES (1,'example.com','example.com');
/*!40000 ALTER TABLE `django_site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `webapp_financialinstitution`
--

DROP TABLE IF EXISTS `webapp_financialinstitution`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `webapp_financialinstitution` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `webapp_financialinstitution`
--

LOCK TABLES `webapp_financialinstitution` WRITE;
/*!40000 ALTER TABLE `webapp_financialinstitution` DISABLE KEYS */;
INSERT INTO `webapp_financialinstitution` VALUES (1,'Intercontinental Bank');
/*!40000 ALTER TABLE `webapp_financialinstitution` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `webapp_institution`
--

DROP TABLE IF EXISTS `webapp_institution`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `webapp_institution` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `code` varchar(32) NOT NULL,
  `secret` varchar(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `webapp_institution`
--

LOCK TABLES `webapp_institution` WRITE;
/*!40000 ALTER TABLE `webapp_institution` DISABLE KEYS */;
INSERT INTO `webapp_institution` VALUES (1,'UNIVERSITY A','UNIA','2fd0bba6b1774ed391c1ff8467f52a5d'),(2,'UNIVERSITY B','UNIB','ffaedcdf6cc045cfbb220299720a79d6');
/*!40000 ALTER TABLE `webapp_institution` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `webapp_transaction`
--

DROP TABLE IF EXISTS `webapp_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `webapp_transaction` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tpin` varchar(32) NOT NULL,
  `amount` decimal(14,2) NOT NULL,
  `identifier` varchar(100) NOT NULL,
  `institution_id` int(11) NOT NULL,
  `paid` tinyint(1) NOT NULL,
  `teller_no` varchar(20) NOT NULL,
  `financial_institution_id` int(11) DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `webapp_transaction_5e29f20d` (`institution_id`),
  KEY `webapp_transaction_7612d9a3` (`financial_institution_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `webapp_transaction`
--

LOCK TABLES `webapp_transaction` WRITE;
/*!40000 ALTER TABLE `webapp_transaction` DISABLE KEYS */;
INSERT INTO `webapp_transaction` VALUES (1,'ac0e95f6cd994cc39807d986f7a10d4d','10000.00','ABCDEF',1,1,'01201023',1,'2011-02-11 13:02:57','2011-02-25 14:05:10'),(2,'7067361871fd459faa144988ffa22c7c','50000.00','GHIJKL',2,1,'52101007',1,'2011-02-11 13:03:19','2011-02-22 06:50:21'),(3,'d257e6838f094689a57db31d65aaea6c','35000.00','MNOPQR',1,0,'',NULL,'2011-02-11 13:03:37','2011-02-11 13:03:37'),(4,'134e5ab4b0a74b5a985ff53e31370818','20000.00','STUVWX',2,1,'109876',1,'2011-02-11 13:04:06','2011-04-27 10:31:30'),(5,'ef451670efad4995bff755621c162807','40000.00','12345',1,1,'',1,'2011-02-11 13:04:23','2011-04-29 00:40:34');
/*!40000 ALTER TABLE `webapp_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `webapp_transactionauditlogentry`
--

DROP TABLE IF EXISTS `webapp_transactionauditlogentry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `webapp_transactionauditlogentry` (
  `id` int(11) NOT NULL,
  `tpin` varchar(32) NOT NULL,
  `amount` decimal(14,2) NOT NULL,
  `identifier` varchar(100) NOT NULL,
  `institution_id` int(11) NOT NULL,
  `paid` tinyint(1) NOT NULL,
  `teller_no` varchar(20) NOT NULL,
  `financial_institution_id` int(11) DEFAULT NULL,
  `action_id` int(11) NOT NULL AUTO_INCREMENT,
  `action_date` datetime NOT NULL,
  `action_user_id` int(11) DEFAULT NULL,
  `action_type` varchar(1) NOT NULL,
  PRIMARY KEY (`action_id`),
  KEY `webapp_transactionauditlogentry_4a5fc416` (`id`),
  KEY `webapp_transactionauditlogentry_5e29f20d` (`institution_id`),
  KEY `webapp_transactionauditlogentry_7612d9a3` (`financial_institution_id`),
  KEY `webapp_transactionauditlogentry_26679921` (`action_user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `webapp_transactionauditlogentry`
--

LOCK TABLES `webapp_transactionauditlogentry` WRITE;
/*!40000 ALTER TABLE `webapp_transactionauditlogentry` DISABLE KEYS */;
INSERT INTO `webapp_transactionauditlogentry` VALUES (1,'863f01fbd51842a5beeda3bdfa967f35','10000.00','ABCDEF',1,0,'',NULL,1,'2011-02-11 13:02:57',1,'I'),(2,'03c1206f5ed04eb39f7374a2933f32dd','50000.00','GHIJKL',2,0,'',NULL,2,'2011-02-11 13:03:19',1,'I'),(3,'7997e7901efb4fd1a1d754393113bd9e','35000.00','MNOPQR',1,0,'',NULL,3,'2011-02-11 13:03:37',1,'I'),(4,'966182c7ba26420e8b1f1a8c93f7871c','20000.00','STUVWX',2,0,'',NULL,4,'2011-02-11 13:04:06',1,'I'),(5,'f4388d14cc9c41309060d28b1b940df4','40000.00','12345',1,0,'',NULL,5,'2011-02-11 13:04:23',1,'I'),(1,'0e711c7e35b744e9a4dc09449b678bbd','10000.00','ABCDEF',1,1,'01201023',NULL,6,'2011-02-22 06:48:52',2,'U'),(1,'03a1f653cf7f437f8b048aa7dacb3503','10000.00','ABCDEF',1,1,'01201023',1,7,'2011-02-22 06:48:52',2,'U'),(2,'70f3d4f66f63459eb975fad430789fc5','50000.00','GHIJKL',2,1,'52101007',NULL,8,'2011-02-22 06:50:21',2,'U'),(2,'2604c45d11c84f1d84acf838a7c7262c','50000.00','GHIJKL',2,1,'52101007',1,9,'2011-02-22 06:50:21',2,'U'),(1,'2097d5a61345476288d3274b6502228c','10000.00','ABCDEF',1,1,'01201023',1,10,'2011-02-25 08:15:32',2,'U'),(1,'0cdfbc38e77246919d5fe37dd27c81cb','10000.00','ABCDEF',1,1,'01201023',1,11,'2011-02-25 08:15:32',2,'U'),(1,'a328982d5a44471a95a4e540136c7725','10000.00','ABCDEF',1,1,'01201023',1,12,'2011-02-25 14:05:10',2,'U'),(1,'8c96b41431d246b69b8d5921e8c9d81e','10000.00','ABCDEF',1,1,'01201023',1,13,'2011-02-25 14:05:10',2,'U'),(4,'2ac109488ffc4845a2337e4c71a00789','20000.00','STUVWX',2,1,'',NULL,14,'2011-02-25 14:08:01',2,'U'),(4,'b4ee2488820340f7bcc9d95fa29f82dd','20000.00','STUVWX',2,1,'',1,15,'2011-02-25 14:08:01',2,'U'),(4,'457208894b5f4767a651630ed2470ebf','20000.00','STUVWX',2,0,'',1,16,'2011-04-27 10:31:13',4,'U'),(4,'e07ef19047a64a09aab597e63e9ea755','20000.00','STUVWX',2,0,'',1,17,'2011-04-27 10:31:13',4,'U'),(4,'2c01b0405c8743c5abde755ce3bc20d3','20000.00','STUVWX',2,1,'109876',1,18,'2011-04-27 10:31:30',4,'U'),(4,'cd010d0a79834054a4ed576e36b78160','20000.00','STUVWX',2,1,'109876',1,19,'2011-04-27 10:31:30',4,'U'),(5,'b5efed09b9e948bd8ae412b777287002','40000.00','12345',1,1,'',NULL,20,'2011-04-29 00:40:34',4,'U'),(5,'b7b422f4667647908d0a7e6217beaae8','40000.00','12345',1,1,'',1,21,'2011-04-29 00:40:34',4,'U');
/*!40000 ALTER TABLE `webapp_transactionauditlogentry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `webapp_userprofile`
--

DROP TABLE IF EXISTS `webapp_userprofile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `webapp_userprofile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `supervisor_id` int(11) DEFAULT NULL,
  `financial_institution_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `webapp_userprofile_561f4514` (`supervisor_id`),
  KEY `webapp_userprofile_7612d9a3` (`financial_institution_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `webapp_userprofile`
--

LOCK TABLES `webapp_userprofile` WRITE;
/*!40000 ALTER TABLE `webapp_userprofile` DISABLE KEYS */;
INSERT INTO `webapp_userprofile` VALUES (1,1,NULL,NULL),(2,2,NULL,1),(3,3,1,NULL),(4,4,2,1),(5,5,2,1);
/*!40000 ALTER TABLE `webapp_userprofile` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2011-05-18  0:20:51
