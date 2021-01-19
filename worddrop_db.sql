-- MySQL dump 10.13  Distrib 8.0.22, for Linux (x86_64)
--
-- Host: localhost    Database: project_db
-- ------------------------------------------------------
-- Server version	8.0.22

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
-- Table structure for table `list`
--

DROP TABLE IF EXISTS `list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `list` (
  `list_id` int NOT NULL AUTO_INCREMENT,
  `listname` varchar(40) NOT NULL,
  `lang1` varchar(40) NOT NULL,
  `lang2` varchar(40) NOT NULL,
  `tag` varchar(40) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`list_id`,`user_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `list_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `list`
--

LOCK TABLES `list` WRITE;
/*!40000 ALTER TABLE `list` DISABLE KEYS */;
INSERT INTO `list` VALUES (1,'animals_new','English','Greek','nature',1),(2,'electrical devices','English','Greek','house',1),(3,'vegetables','English','Greek','food',1),(4,' camera','Italian','Greek','δωμάτιο',3),(5,'Sciences','Greek','English','Lessons',4),(6,'Movie Genres','English','Greek','Movies',5),(7,'Arts','English','Greek','Arts',5),(8,'Family','Spanish','English','People',2),(9,'Furniture','English','Greek','Home',5),(10,'Food','Swedish','English','Lifestyle',6),(12,'first travel list','Greek','English','travel',7),(13,'Sports','English','Greek','Activities',6),(14,'Clothes','Swedish','English','Lifestyle',6),(15,'Sports','Swedish','English','Activities',6),(16,'Colours','Swedish','English','Basics',6),(18,'net','English','French','net',8),(19,'Jobs','Swedish','English','Lifestyle',6),(20,'fruits','English','Greek','food',1),(21,'casa','Italian','Greek','house',1),(22,'repas journaliers','French','Greek','food',1),(23,'Learnig Bulgarian is a challenge!!!','Bulgarian','Greek','Languages',9),(24,'Occupation','Spanish','English','People',2),(25,'Countries','Spanish','English','The World',2),(26,'House','Spanish','English','Home',2),(27,'Electrical Appliances','German','English','In the House(GER)',2),(28,'Clothes','German','English','In the House(GER)',2),(29,'Animals','Spanish','English','The World',2),(30,'Nature','German','English','The World',2),(32,'nature','English','Greek','nature',1),(33,'sentiments','French','Greek','sentiments',3),(34,'profession','French','Greek','profession',3),(35,'Animals in Greek','English','Greek','Basic Greek',2),(36,'products','English','Greek','food',1),(37,'sciences','Greek','English','lessons',1);
/*!40000 ALTER TABLE `list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(40) NOT NULL,
  `password` varchar(40) NOT NULL,
  `email` varchar(40) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'marialena','neura','marialena@gmail.com'),(2,'gkouts','youshallNOTpass;)','gkouts@gmail.com'),(3,'olga.','oneira17','olgavmichailidou@yahoo.gr'),(4,'eirinichatz','kwstas125','eirinichatzigianni@gmail.com'),(5,'BillKara','12341234','billkara1964@hotmail.com'),(6,'BonJovas','GeorgeIsSatan666','aquafortes@hotmail.com'),(7,'irenel','heyiamirene99','irelialogotheti@gmail.com'),(8,'vassilina','vassilina','vassilinapapadouli@gmail.com'),(9,'maria','123456789','mariaperifanou123@gmail.com'),(10,'leithianor ','pol2857','kwstasvol@yahoo.gr');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `word`
--

DROP TABLE IF EXISTS `word`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `word` (
  `word_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `word1` varchar(40) NOT NULL,
  `word2` varchar(40) NOT NULL,
  `im_path` varchar(40) DEFAULT NULL,
  `list_id` int NOT NULL,
  PRIMARY KEY (`word1`,`list_id`),
  UNIQUE KEY `word_id` (`word_id`),
  UNIQUE KEY `im_path` (`im_path`),
  KEY `list_id` (`list_id`),
  CONSTRAINT `word_ibfk_1` FOREIGN KEY (`list_id`) REFERENCES `list` (`list_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=266 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `word`
--

LOCK TABLES `word` WRITE;
/*!40000 ALTER TABLE `word` DISABLE KEYS */;
INSERT INTO `word` VALUES (246,'acteur','ηθοποιός','246.jpeg',34),(231,'affame','πεινασμένος','231.empty',33),(130,'ailes de poulet','φτερούγες κοτόπουλου','130.jpeg',22),(71,'airport','αεροδρόμιο','71.jpeg',12),(163,'Alemania','Germany','163.png',25),(114,'appartamento','διαμέρισμα','114.empty',21),(100,'apple','μήλο','100.jpeg',20),(109,'apricot','βερίκοκο','109.jpeg',20),(72,'arrival','άφιξη','72.png',12),(123,'asconsore','ασανσερ','123.jpeg',21),(13,'asparagus','σπαράγγι','13.jpeg',3),(232,'assoiffe','διψασμένος','232.empty',33),(223,'automn','φθινόπωρο','223.jpeg',32),(106,'banana','μπανάνα','106.jpeg',20),(78,'basketball','Καλαθοσφαίριση','78.jpeg',13),(14,'bean','φασόλι','14.jpeg',3),(60,'Bed','Κρεβάτι','60.jpeg',9),(45,'Biopic','Βιογραφία','45.png',6),(26,'bird','πουλί','26.jpeg',1),(248,'bird','πουλί','248jpeg',35),(94,'blå','blue','94.jpeg',16),(62,'Bookshelf','Βιβλιοθήκη','62.jpeg',9),(90,'boxning','boxing','90.jpeg',15),(15,'broccoli','μπρόκολο','15.jpeg',3),(135,'brochette','σουβλάκι','135.jpeg',22),(83,'byxor','trousers','83.jpeg',14),(16,'cabbage','λάχανο','16.jpeg',3),(116,'camera da letto','κρεβατοκάμαρα','116.jpeg',21),(122,'campanello','κουδούνι','122.jpeg',21),(17,'carot','καρότο','17.jpeg',3),(112,'casa','σπίτι','112.jpeg',21),(1,'cat','γάτα','1.png',1),(249,'cat','γάτα','249png',35),(18,'cauliflower','κουνουπίδι','18.jpeg',3),(19,'celery','σέλινο','19.jpeg',3),(50,'Ceramics','Κεραμική','50.jpeg',7),(57,'chair','Καρέκλα','57.jpeg',9),(243,'chauffeur','οδηγός','243.png',34),(108,'cherry','κεράσι','108.jpeg',20),(159,'Chipre','Cyprus','159.png',25),(12,'coffeemaker','καφετιέρα','12.jpeg',2),(43,'Comedy','Κωμωδία','43.jpeg',6),(97,'communication','la communication','97.empty',18),(21,'cucumber','αγγούρι','21.jpeg',3),(244,'cuisinier','μάγειρας','244.jpeg',34),(48,'Dance','Χορός','48.jpeg',7),(175,'das Bügeleisen','iron','175.png',27),(190,'das Hemd','shirt','190.jpeg',28),(191,'das Kleid','dress','191.jpeg',28),(211,'das Meer','sea','211.jpeg',30),(215,'das Tal','valley','215.png',30),(179,'das Telefon','telephone','179.jpeg',27),(75,'declare',' δηλώνω','75.empty',12),(126,'dejeuner','μεσημεριανό','126.empty',22),(73,'departure','αναχώρηση','73.png',12),(180,'der Backofen','oven','180.png',27),(185,'der Badeanzug','swimsuit','185.jpeg',28),(207,'der Berg','mountain','207.png',30),(178,'der Fernseher','television','178.png',27),(209,'der Fluss','river','209.jpeg',30),(212,'der Himmel','sky','212.jpeg',30),(176,'der Kühlschrank','refrigerator','176.jpeg',27),(188,'der Mantel','coat','188.jpeg',28),(182,'der Pulli','pullover','182.jpeg',28),(189,'der Rock','skirt','189.png',28),(208,'der See','lake','208.jpeg',30),(181,'der Staubsauger','vacuum cleaner','181.gif',27),(210,'der Wald','forest','210.jpeg',30),(186,'die Hose','pants','186.jpeg',28),(183,'die Krawatte','tie','183.jpeg',28),(184,'die Socke','sock','184.png',28),(177,'die Spülmaschine','dishwasher','177.png',27),(187,'die Tasche','bag','187.jpeg',28),(213,'die Wüste','desert','213.jpeg',30),(160,'Dinamarca','Denmark','160.png',25),(127,'diner','βραδινό','127.empty',22),(77,'directions','κατευθύνσεις','77.jpeg',12),(2,'dog','σκύλος','2.jpeg',1),(250,'dog','σκύλος','250jpeg',35),(61,'Drawer','Συρταριέρα','61.jpeg',9),(234,'effraye','φοβισμένος','234.empty',33),(20,'eggplant','μελιτζάνα','20.jpeg',3),(147,'el abuelo','grandfather','147.jpeg',8),(154,'el actor','actor','154.png',24),(157,'el artista','artist','157.gif',24),(174,'el baño','bathroom','174.jpeg',26),(195,'el caballo','horse','195.jpeg',29),(156,'el camarero','waiter','156.jpeg',24),(153,'el cocinero','cook','153.jpeg',24),(204,'el conejo','rabbit','204.jpeg',29),(206,'el gato ','cat','206.png',29),(146,'el hermano','brother','146.jpeg',8),(144,'el padre','father','144.jpeg',8),(192,'el pájaro','bird','192.png',29),(205,'el perro','dog','205.png',29),(201,'el pez','fish','201.png',29),(203,'el ratón','mouse','203.jpeg',29),(173,'el salón','living room','173.jpeg',26),(24,'elephant','ελέφαντας','24.jpeg',1),(251,'elephant','ελέφαντας','251jpeg',35),(64,'en apelsin','an orange','64.jpeg',10),(236,'en bonne sante','υγιής','236.empty',33),(84,'en halsduk','a scarf ','84.jpeg',14),(110,'en journalist','a journalist','110.jpeg',19),(67,'en potatis','a potato','67.jpeg',10),(111,'en präst','a priest','111.jpeg',19),(107,'en programledare','a show host','107.jpeg',19),(101,'en sångare','a singer','101.jpeg',19),(103,'en skådespelerska','an actress','103.jpeg',19),(80,'en skjorta','a shirt','80.jpeg',14),(115,'entrata','χολ','115.empty',21),(168,'Estados Unidos','U.S.A.','168.png',25),(65,'ett ägg','an egg','65.jpeg',10),(63,'ett äpple','an apple','63.jpeg',10),(239,'fache','θυμωμένος','239.empty',33),(238,'fatigue','κουρασμένος','238.empty',33),(31,'federa','μαξιλαροθήκη','31.jpeg',4),(121,'finestra','παράθυρο','121.jpeg',21),(161,'Finlandia','Finland','161.png',25),(89,'fotboll','football','89.jpeg',15),(162,'Francia','France','162.png',25),(133,'frites','πατάτες τηγανιτές','133.jpeg',22),(3,'frog','βάτραχος','3.jpeg',1),(252,'frog','βάτραχος','252jpeg',35),(23,'giraffe','καμηλοπάρδαλη','23.jpeg',1),(253,'giraffe','καμηλοπάρδαλη','253jpeg',35),(68,'goodmorning','καλημέρα','68.empty',12),(229,'gout','γεύση','229.empty',33),(164,'Grecia','Greece','164.png',25),(91,'grön','green','91.jpeg',16),(27,'gruccia','κρεμάστρα','27.jpeg',4),(93,'gul','yellow','93.jpeg',16),(87,'handboll','handball','87.jpeg',15),(82,'handskar','gloves','82.jpeg',14),(233,'heureux','ευτυχισμένος','233.empty',33),(69,'highway',' αυτοκινητόδρομος','69.jpeg',12),(25,'hippo','ιπποπόταμος','25.jpeg',1),(254,'hippo','ιπποπόταμος','254jpeg',35),(10,'hood','απορροφητήρας','10.jpeg',2),(41,'Horror','Τρόμου','41.jpeg',6),(22,'horse','άλογο','22.jpeg',1),(255,'horse','άλογο','255jpeg',35),(5,'iron','σίδερο','5.jpeg',2),(86,'ishockey','ice hockey','86.jpeg',15),(165,'Japón','Japan','165.png',25),(66,'kaffe','coffee','66.jpeg',10),(158,'la abogada','lawyer','158.png',24),(148,'la abuela','grandmother','148.png',8),(169,'la casa','house','169.png',26),(155,'la científica','scientist','155.jpeg',24),(171,'la cocina','the kitchen','171.jpeg',26),(142,'la familia','family','142.jpeg',8),(170,'la habitación','room','170.jpeg',26),(145,'la hermana','sister','145.jpeg',8),(143,'la madre','mother','143.jpeg',8),(152,'la maestra','teacher','152.png',24),(196,'la oveja','sheep','196.jpeg',29),(172,'la recámara','bedroom','172.jpeg',26),(220,'lake','λίμνη','220.jpeg',32),(52,'Literature','Λογοτεχνία','52.jpeg',7),(235,'malade','άρρωστος','235.empty',33),(256,'milk','γάλα','256.jpeg',36),(218,'mountain','βουνό','218.jpeg',32),(46,'Music','Μουσική','46.png',7),(98,'network','le réseau','98.empty',18),(166,'Noruega','Norway','166.png',25),(228,'odorat','οσμή','228.empty',33),(128,'omelette','ομελέτα','128.jpeg',22),(227,'ouie','ακοή','227.empty',33),(9,'oven','φούρνος','9.jpeg',2),(49,'Painting','Ζωγραφική','49.jpeg',7),(118,'parete','τοίχος','118.jpeg',21),(119,'pavimento','πάτωμα','119.empty',21),(99,'peach','ροδάκινο','99.jpeg',20),(104,'pear','αχλάδι','104.jpeg',20),(125,'petit dejeuner','πρωινό','125.jpeg',22),(245,'photographe','φωτογράφος','245.jpeg',34),(113,'piano','όροφος','113.empty',21),(219,'plain','πεδιάδα','219.jpeg',32),(134,'pommes vapeur','πατάτες βραστές','134.jpeg',22),(70,'port','λιμάνι','70.jpeg',12),(120,'porta','πόρτα','120.gif',21),(124,'presa','πρίζα','124.jpeg',21),(240,'professeur','δάσκαλος','240.jpeg',34),(242,'programmeur','προγραμματιστής','242.jpeg',34),(136,'pudding au chocolat','πουτίγκα σοκολάτα','136.jpeg',22),(6,'refrigerator','ψυγείο','6.jpeg',2),(132,'riz','ρύζι','132.jpeg',22),(92,'röd','red','92.jpeg',16),(44,'Romance','Ρομαντικές','44.jpeg',6),(129,'salade','σαλάτα','129.jpeg',22),(42,'Science Fiction','Επιστημονική Φαντασία','42.jpeg',6),(217,'sea','θάλασσα','217.jpeg',32),(241,'secretaire','γραμματέας','241.jpeg',34),(85,'segling','sailing','85.jpeg',15),(81,'skor','shoes','81.jpeg',14),(225,'snow','χιόνι','225.jpeg',32),(59,'Sofa','Καναπές','59.jpeg',9),(131,'soupe','σούπα','131.jpeg',22),(32,'specchio','καθρέφτης','32.jpeg',4),(224,'spring','άνοιξη','224.jpeg',32),(117,'stanza','δωμάτιο','117.empty',21),(8,'stove','κουζίνα','8.empty',2),(105,'strawberry','φράουλα','105.jpeg',20),(167,'Suecia','Sweden','167.png',25),(222,'summer','καλοκαίρι','222.jpeg',32),(216,'sun','ήλιος','216.jpeg',32),(95,'svart','black','95.jpeg',16),(58,'Table','Τραπέζι','58.jpeg',9),(29,'tappeto','χαλί','29.jpeg',4),(28,'telefono','τηλέφωνο','28.jpeg',4),(30,'tenda','κουρτίνα','30.jpeg',4),(74,'Tennis','Αντισφαίριση','74.jpeg',13),(47,'Theatre','Θέατρο','47.jpeg',7),(4,'toast','τοστιέρα','4.empty',2),(230,'toucher','αφή','230.empty',33),(237,'triste','λυπημένος','237.empty',33),(79,'upfront','εκ των προτέρων','79.empty',12),(11,'vacuum cleaner','ηλεκτρική σκούπα','11.jpeg',2),(247,'veterinaire','κτηνίατρος','247.jpeg',34),(51,'Video Games','Βιντεοπαιχνίδια','51.jpeg',7),(76,'Volleyball','Πετοσφαίριση','76.jpeg',13),(226,'vue','όραση','226.empty',33),(7,'washing machine','πλυντήριο','7.jpeg',2),(102,'watermelon','καρπούζι','102.png',20),(221,'winter','χειμώνας','221.jpeg',32),(96,'work','le travail','96.empty',18),(37,'Γεωργία','Agriculture','37.jpeg',5),(258,'Γεωργία','Agriculture','258jpeg',37),(36,'Επιστήμες υγείας','Health sciences','36.webp',5),(259,'Επιστήμες υγείας','Health sciences','259webp',37),(34,'Θεολογία','Theology','34.jpeg',5),(260,'Θεολογία','Theology','260jpeg',37),(39,'Καλές Τέχνες','Fine arts','39.jpeg',5),(261,'Καλές Τέχνες','Fine arts','261jpeg',37),(38,'Μηχανική','Engineering','38.jpeg',5),(262,'Μηχανική','Engineering','262jpeg',37),(35,'Νομική','Law','35.jpeg',5),(263,'Νομική','Law','263jpeg',37),(40,'Οικονομικά','Economics','40.jpeg',5),(264,'Οικονομικά','Economics','264jpeg',37),(33,'Φιλοσοφία','Philosophy','33.jpeg',5),(265,'Φιλοσοφία','Philosophy','265jpeg',37),(141,'аз учам електроинженер','εγω σπουδαζω ηλεκτρολογος μηχανικος','141.empty',23),(137,'добър ден','καλημερα','137.empty',23),(138,'зравей!','γεια!','138.empty',23),(139,'как се казваш?','πώς σε λένε?','139.empty',23),(140,'ти си много красива!','εισαι πολυ ομορφη!','140.empty',23);
/*!40000 ALTER TABLE `word` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-01-20  0:09:56
