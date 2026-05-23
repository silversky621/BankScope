-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: bank
-- ------------------------------------------------------
-- Server version	8.0.45

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
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account` (
  `account_id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `product_id` int unsigned DEFAULT NULL,
  `account_number` varchar(40) NOT NULL,
  `account_type` varchar(20) NOT NULL,
  `balance` bigint NOT NULL DEFAULT '0',
  `account_password` varchar(255) NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'ACTIVE',
  `password_fail_count` int DEFAULT '0',
  `account_alias` varchar(20) DEFAULT NULL,
  `interest_rate` decimal(5,2) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `last_transaction_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `maturity_date` datetime DEFAULT NULL,
  PRIMARY KEY (`account_id`),
  UNIQUE KEY `account_number` (`account_number`),
  KEY `user_id` (`user_id`),
  KEY `fk_account_product` (`product_id`),
  CONSTRAINT `account_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_account_product` FOREIGN KEY (`product_id`) REFERENCES `financial_product` (`product_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=116 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES (89,2732,NULL,'110-EXP-0001','CHECKING',2500000,'$2b$10$979E1K7B1kTS7h.V.Q03QukCcSdYGhTWRwQgiQ6hvNh82cUjyoYkS','ACTIVE',0,NULL,NULL,'2026-05-08 11:40:22','2026-05-08 11:40:22',NULL),(90,2733,NULL,'110-EXP-0002','CHECKING',800000,'$2b$10$979E1K7B1kTS7h.V.Q03QukCcSdYGhTWRwQgiQ6hvNh82cUjyoYkS','ACTIVE',0,NULL,NULL,'2026-05-08 11:40:22','2026-05-08 11:40:22',NULL),(91,2734,NULL,'110-EXP-0003','CHECKING',3000000,'$2b$10$979E1K7B1kTS7h.V.Q03QukCcSdYGhTWRwQgiQ6hvNh82cUjyoYkS','ACTIVE',0,NULL,NULL,'2026-05-08 11:40:22','2026-05-08 11:40:22',NULL),(92,2735,NULL,'110-EXP-0004','CHECKING',1200000,'$2b$10$979E1K7B1kTS7h.V.Q03QukCcSdYGhTWRwQgiQ6hvNh82cUjyoYkS','ACTIVE',0,NULL,NULL,'2026-05-08 11:40:22','2026-05-08 11:40:22',NULL),(93,2736,NULL,'110-EXP-0005','CHECKING',2000000,'$2b$10$979E1K7B1kTS7h.V.Q03QukCcSdYGhTWRwQgiQ6hvNh82cUjyoYkS','ACTIVE',0,NULL,NULL,'2026-05-08 11:40:22','2026-05-08 11:40:22',NULL),(94,2737,NULL,'110-EXP-0006','CHECKING',15000000,'$2b$10$979E1K7B1kTS7h.V.Q03QukCcSdYGhTWRwQgiQ6hvNh82cUjyoYkS','ACTIVE',0,NULL,NULL,'2026-05-08 11:40:22','2026-05-08 11:40:22',NULL),(95,2738,NULL,'110-EXP-0007','CHECKING',32000000,'$2b$10$979E1K7B1kTS7h.V.Q03QukCcSdYGhTWRwQgiQ6hvNh82cUjyoYkS','ACTIVE',0,NULL,NULL,'2026-05-08 11:40:22','2026-05-08 11:40:22',NULL),(96,2739,NULL,'110-EXP-0008','CHECKING',25000000,'$2b$10$979E1K7B1kTS7h.V.Q03QukCcSdYGhTWRwQgiQ6hvNh82cUjyoYkS','ACTIVE',0,NULL,NULL,'2026-05-08 11:40:22','2026-05-08 11:40:22',NULL),(97,2740,NULL,'110-EXP-0009','CHECKING',18000000,'$2b$10$979E1K7B1kTS7h.V.Q03QukCcSdYGhTWRwQgiQ6hvNh82cUjyoYkS','ACTIVE',0,NULL,NULL,'2026-05-08 11:40:22','2026-05-08 11:40:22',NULL),(98,2741,NULL,'110-EXP-0010','CHECKING',10000000,'$2b$10$979E1K7B1kTS7h.V.Q03QukCcSdYGhTWRwQgiQ6hvNh82cUjyoYkS','ACTIVE',0,NULL,NULL,'2026-05-08 11:40:22','2026-05-08 11:40:22',NULL),(99,2742,NULL,'110-EXP-0011','CHECKING',80000000,'$2b$10$979E1K7B1kTS7h.V.Q03QukCcSdYGhTWRwQgiQ6hvNh82cUjyoYkS','ACTIVE',0,NULL,NULL,'2026-05-08 11:40:22','2026-05-08 11:40:22',NULL),(100,2743,NULL,'110-EXP-0012','CHECKING',120000000,'$2b$10$979E1K7B1kTS7h.V.Q03QukCcSdYGhTWRwQgiQ6hvNh82cUjyoYkS','ACTIVE',0,NULL,NULL,'2026-05-08 11:40:22','2026-05-08 11:40:22',NULL),(101,2744,NULL,'110-EXP-0013','CHECKING',55000000,'$2b$10$979E1K7B1kTS7h.V.Q03QukCcSdYGhTWRwQgiQ6hvNh82cUjyoYkS','ACTIVE',0,NULL,NULL,'2026-05-08 11:40:22','2026-05-08 11:40:22',NULL),(102,2745,NULL,'110-EXP-0014','CHECKING',150000000,'$2b$10$979E1K7B1kTS7h.V.Q03QukCcSdYGhTWRwQgiQ6hvNh82cUjyoYkS','ACTIVE',0,NULL,NULL,'2026-05-08 11:40:22','2026-05-08 11:40:22',NULL),(103,2746,NULL,'110-EXP-0015','CHECKING',95000000,'$2b$10$979E1K7B1kTS7h.V.Q03QukCcSdYGhTWRwQgiQ6hvNh82cUjyoYkS','ACTIVE',0,NULL,NULL,'2026-05-08 11:40:22','2026-05-08 11:40:22',NULL),(104,2747,NULL,'110-EXP-0016','CHECKING',300000000,'$2b$10$979E1K7B1kTS7h.V.Q03QukCcSdYGhTWRwQgiQ6hvNh82cUjyoYkS','ACTIVE',0,NULL,NULL,'2026-05-08 11:40:22','2026-05-08 11:40:22',NULL),(105,2748,NULL,'110-EXP-0017','CHECKING',150000000,'$2b$10$979E1K7B1kTS7h.V.Q03QukCcSdYGhTWRwQgiQ6hvNh82cUjyoYkS','ACTIVE',0,NULL,NULL,'2026-05-08 11:40:22','2026-05-08 11:40:22',NULL),(106,2749,NULL,'110-EXP-0018','CHECKING',800000000,'$2b$10$979E1K7B1kTS7h.V.Q03QukCcSdYGhTWRwQgiQ6hvNh82cUjyoYkS','ACTIVE',0,NULL,NULL,'2026-05-08 11:40:22','2026-05-08 11:40:22',NULL),(107,2751,NULL,'110-EXP-0019','CHECKING',500000000,'$2b$10$979E1K7B1kTS7h.V.Q03QukCcSdYGhTWRwQgiQ6hvNh82cUjyoYkS','ACTIVE',0,NULL,NULL,'2026-05-08 11:40:22','2026-05-08 11:40:22',NULL),(108,2752,NULL,'110-EXP-0020','CHECKING',1000000000,'$2b$10$979E1K7B1kTS7h.V.Q03QukCcSdYGhTWRwQgiQ6hvNh82cUjyoYkS','ACTIVE',0,NULL,NULL,'2026-05-08 11:40:22','2026-05-08 11:40:22',NULL),(109,2754,NULL,'110-9999-0001','CHECKING',10000,'$2b$10$979E1K7B1kTS7h.V.Q03QukCcSdYGhTWRwQgiQ6hvNh82cUjyoYkS','ACTIVE',0,NULL,NULL,'2026-05-19 23:17:48','2026-05-19 23:17:48',NULL),(114,2757,NULL,'110-9001-0001','CHECKING',4700000,'$2b$10$979E1K7B1kTS7h.V.Q03QukCcSdYGhTWRwQgiQ6hvNh82cUjyoYkS','ACTIVE',0,NULL,NULL,'2026-05-20 17:42:10','2026-05-23 13:39:18',NULL),(115,2757,100,'340-9001-0001','SAVINGS',2100000,'$2b$10$979E1K7B1kTS7h.V.Q03QukCcSdYGhTWRwQgiQ6hvNh82cUjyoYkS','ACTIVE',0,NULL,3.80,'2026-05-20 17:42:15','2026-05-23 13:39:18','2026-11-20 00:00:00');
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `board`
--

DROP TABLE IF EXISTS `board`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `board` (
  `board_id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `board_type` varchar(20) NOT NULL,
  `title` varchar(200) NOT NULL,
  `content` text NOT NULL,
  `view_count` int NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`board_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `board_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board`
--

LOCK TABLES `board` WRITE;
/*!40000 ALTER TABLE `board` DISABLE KEYS */;
/*!40000 ALTER TABLE `board` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `card`
--

DROP TABLE IF EXISTS `card`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `card` (
  `card_id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `account_id` bigint DEFAULT NULL,
  `card_name` varchar(50) DEFAULT NULL,
  `card_number` varchar(20) NOT NULL,
  `card_type` varchar(20) NOT NULL,
  `cvc` varchar(3) NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'ACTIVE',
  `valid_thru` varchar(5) NOT NULL,
  `issued_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `credit_limit` bigint DEFAULT NULL,
  `used_amount` bigint DEFAULT NULL,
  `payment_day` int DEFAULT NULL,
  `card_color` varchar(20) DEFAULT NULL,
  `is_activated` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`card_id`),
  UNIQUE KEY `card_number` (`card_number`),
  KEY `fk_card_user` (`user_id`),
  KEY `fk_card_account` (`account_id`),
  CONSTRAINT `fk_card_account` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_card_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `card`
--

LOCK TABLES `card` WRITE;
/*!40000 ALTER TABLE `card` DISABLE KEYS */;
INSERT INTO `card` VALUES (1,2732,89,'BankScope 신용카드','9945-5828-6951-4845','CREDIT','733','ISSUING','05/31','2026-05-19 17:34:02',NULL,NULL,14,'black',0),(2,2732,89,'민준체크카드','8579-4618-9074-9364','CHECK','276','ISSUING','05/31','2026-05-19 23:40:20',NULL,NULL,NULL,'green',0);
/*!40000 ALTER TABLE `card` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `corporate_management`
--

DROP TABLE IF EXISTS `corporate_management`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `corporate_management` (
  `corporate_manage_id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `loan_id` int NOT NULL,
  `risk_grade` varchar(20) NOT NULL,
  `default_date` date NOT NULL,
  `reason` varchar(100) NOT NULL,
  `description` text,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`corporate_manage_id`),
  KEY `fk_corp_user` (`user_id`),
  KEY `fk_corp_loan` (`loan_id`),
  CONSTRAINT `fk_corp_loan` FOREIGN KEY (`loan_id`) REFERENCES `loan` (`loan_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_corp_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corporate_management`
--

LOCK TABLES `corporate_management` WRITE;
/*!40000 ALTER TABLE `corporate_management` DISABLE KEYS */;
INSERT INTO `corporate_management` VALUES (1,2754,16,'고위험','2026-05-19','장기연체','기업대출 연체 180일 초과','2026-05-19 23:24:02');
/*!40000 ALTER TABLE `corporate_management` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deposit_account`
--

DROP TABLE IF EXISTS `deposit_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `deposit_account` (
  `account_id` bigint NOT NULL,
  `linked_account_id` bigint NOT NULL,
  `maturity_treatment` enum('AUTO_TERMINATE','AUTO_RENEW') NOT NULL DEFAULT 'AUTO_TERMINATE',
  PRIMARY KEY (`account_id`),
  KEY `linked_account_id` (`linked_account_id`),
  CONSTRAINT `deposit_account_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON DELETE CASCADE,
  CONSTRAINT `deposit_account_ibfk_2` FOREIGN KEY (`linked_account_id`) REFERENCES `account` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deposit_account`
--

LOCK TABLES `deposit_account` WRITE;
/*!40000 ALTER TABLE `deposit_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `deposit_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_tokens`
--

DROP TABLE IF EXISTS `email_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_tokens` (
  `email` varchar(50) NOT NULL,
  `code` varchar(12) NOT NULL,
  `is_verified` tinyint(1) DEFAULT '0',
  `is_used` tinyint(1) DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`email`,`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_tokens`
--

LOCK TABLES `email_tokens` WRITE;
/*!40000 ALTER TABLE `email_tokens` DISABLE KEYS */;
INSERT INTO `email_tokens` VALUES ('corp03@test.com','AWFFBBXaXl27',0,0,'2026-05-21 19:51:47','2026-05-21 19:54:47'),('silversky621@naver.com','0pENAq3JSok1',1,1,'2026-05-21 19:52:26','2026-05-21 19:55:26');
/*!40000 ALTER TABLE `email_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `financial_product`
--

DROP TABLE IF EXISTS `financial_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `financial_product` (
  `product_id` int unsigned NOT NULL AUTO_INCREMENT,
  `product_category` enum('CHECKING','DEPOSIT','SAVINGS','LOAN') NOT NULL,
  `product_name` varchar(100) NOT NULL,
  `base_interest_rate` decimal(5,2) NOT NULL,
  `max_interest_rate` decimal(5,2) DEFAULT NULL,
  `min_duration_months` int DEFAULT NULL,
  `max_duration_months` int DEFAULT NULL,
  `min_amount` bigint DEFAULT NULL,
  `max_amount` bigint DEFAULT NULL,
  `description` text,
  `is_active` tinyint(1) DEFAULT '1',
  `target_type` enum('INDIVIDUAL','CORPORATE','ALL') DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `financial_product`
--

LOCK TABLES `financial_product` WRITE;
/*!40000 ALTER TABLE `financial_product` DISABLE KEYS */;
INSERT INTO `financial_product` VALUES (97,'DEPOSIT','BankScope 정기예금',3.20,4.00,1,36,1000000,500000000,'안정적인 금리를 제공하는 개인 정기예금 상품입니다. 가입 기간이 길수록 우대금리가 적용됩니다.',1,'INDIVIDUAL','2026-05-12 21:52:30','2026-05-12 21:52:30'),(98,'DEPOSIT','BankScope 시니어 우대예금',3.50,4.50,12,24,1000000,300000000,'만 60세 이상 고객을 위한 우대금리 정기예금입니다. 자동이체 실적 시 추가 우대금리가 제공됩니다.',1,'INDIVIDUAL','2026-05-12 21:52:30','2026-05-12 21:52:30'),(99,'DEPOSIT','BankScope 기업 정기예금',3.00,3.80,1,24,10000000,2000000000,'법인 및 사업자를 위한 고액 정기예금 상품입니다. 거래 실적에 따라 우대금리가 적용됩니다.',1,'CORPORATE','2026-05-12 21:52:30','2026-05-12 21:52:30'),(100,'SAVINGS','BankScope 자유적금',3.80,5.00,6,36,10000,3000000,'매월 자유롭게 납입할 수 있는 적금 상품입니다. 급여이체 및 카드 실적에 따라 최고 5.00% 금리를 제공합니다.',1,'INDIVIDUAL','2026-05-12 21:52:30','2026-05-12 21:52:30'),(101,'SAVINGS','BankScope 청년 희망적금',4.50,6.00,12,24,10000,500000,'만 19세~34세 청년 고객 전용 적금입니다. 정부 지원 이자를 포함하여 최고 6.00% 혜택을 받을 수 있습니다.',1,'INDIVIDUAL','2026-05-12 21:52:30','2026-05-12 21:52:30'),(102,'SAVINGS','BankScope 주택 마련 적금',4.00,5.50,24,60,50000,1000000,'내 집 마련을 목표로 하는 장기 적금입니다. 청약저축 연계 시 추가 우대금리가 적용됩니다.',1,'INDIVIDUAL','2026-05-12 21:52:30','2026-05-12 21:52:30'),(103,'SAVINGS','BankScope 기업 정기적금',3.20,4.00,12,60,1000000,100000000,'소상공인 및 중소기업을 위한 정기적금입니다. 세금 우대 혜택이 적용됩니다.',1,'CORPORATE','2026-05-12 21:52:30','2026-05-12 21:52:30'),(104,'LOAN','BankScope 신용대출',5.50,15.00,1,60,1000000,50000000,'신용등급에 따라 최대 5천만 원까지 대출 가능한 개인 신용대출 상품입니다. 별도의 담보 없이 빠르게 신청하실 수 있습니다.',1,'INDIVIDUAL','2026-05-12 21:52:30','2026-05-12 21:52:30'),(105,'LOAN','BankScope 주택담보대출',3.80,6.50,12,360,30000000,1000000000,'주택을 담보로 장기 저금리로 이용할 수 있는 대출 상품입니다. LTV·DTI 기준 내에서 최대 10억 원까지 대출 가능합니다.',1,'INDIVIDUAL','2026-05-12 21:52:30','2026-05-12 21:52:30'),(106,'LOAN','BankScope 전세자금대출',3.20,5.00,6,24,10000000,300000000,'전세 계약자를 위한 보증 대출 상품입니다. HUG·HF 보증 연계로 최대 3억 원까지 지원합니다.',1,'INDIVIDUAL','2026-05-12 21:52:30','2026-05-12 21:52:30'),(107,'LOAN','BankScope 소상공인 대출',4.00,8.00,6,60,5000000,500000000,'소상공인 및 자영업자를 위한 운전자금·시설자금 대출입니다. 정책자금 연계 시 저금리 혜택을 받을 수 있습니다.',1,'ALL','2026-05-12 21:52:30','2026-05-12 21:52:30'),(108,'LOAN','BankScope 기업대출',4.50,9.00,12,120,10000000,3000000000,'중소·중견기업의 운영 및 시설 투자를 위한 기업금융 대출 상품입니다. 최대 30억 원까지 지원합니다.',1,'CORPORATE','2026-05-12 21:52:30','2026-05-12 21:52:30'),(109,'CHECKING','BankScope 개인 입출금 통장',0.10,0.50,NULL,NULL,0,NULL,'개인 고객을 위한 기본 입출금 통장입니다. 급여이체, 공과금 자동납부, 카드 결제 등 일상적인 금융 거래에 최적화되어 있습니다.',1,'INDIVIDUAL','2026-05-12 21:52:30','2026-05-12 21:52:30'),(110,'CHECKING','BankScope 자유입출금 통장',0.10,1.00,NULL,NULL,0,NULL,'개인과 법인 모두 이용 가능한 기본 입출금 통장입니다. 언제든지 자유롭게 입출금할 수 있으며 인터넷·모바일뱅킹을 통한 이체 서비스를 제공합니다.',1,'ALL','2026-05-12 21:52:30','2026-05-12 21:52:30'),(111,'DEPOSIT','BankScope 단기 정기예금',2.50,3.50,1,12,100000,NULL,'개인·법인 모두 가입 가능한 단기 정기예금입니다. 1개월 이상 단기 자금 운용에 적합하며 만기 시 자동 연장 옵션이 제공됩니다.',1,'ALL','2026-05-12 21:52:30','2026-05-12 21:52:30'),(112,'SAVINGS','BankScope 목표 적금',3.50,4.50,6,36,10000,2000000,'개인·법인 구분 없이 목표 금액을 정해두고 자유롭게 적립하는 적금입니다. 목표 달성 시 추가 우대금리가 적용됩니다.',1,'ALL','2026-05-12 21:52:30','2026-05-12 21:52:30');
/*!40000 ALTER TABLE `financial_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loan`
--

DROP TABLE IF EXISTS `loan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loan` (
  `loan_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `product_id` int unsigned NOT NULL,
  `linked_account_id` bigint NOT NULL,
  `principal_amount` bigint NOT NULL,
  `outstanding_amount` bigint NOT NULL,
  `interest_rate` decimal(5,2) NOT NULL,
  `payment_day` tinyint NOT NULL,
  `info` varchar(255) DEFAULT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'ACTIVE',
  `overdue_date` date DEFAULT NULL,
  `overdue_amount` bigint NOT NULL DEFAULT '0',
  `maturity_date` date NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`loan_id`),
  KEY `fk_loan_user` (`user_id`),
  KEY `fk_loan_product` (`product_id`),
  KEY `fk_loan_account` (`linked_account_id`),
  CONSTRAINT `fk_loan_account` FOREIGN KEY (`linked_account_id`) REFERENCES `account` (`account_id`),
  CONSTRAINT `fk_loan_product` FOREIGN KEY (`product_id`) REFERENCES `financial_product` (`product_id`),
  CONSTRAINT `fk_loan_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loan`
--

LOCK TABLES `loan` WRITE;
/*!40000 ALTER TABLE `loan` DISABLE KEYS */;
INSERT INTO `loan` VALUES (11,2737,1,94,20000000,18000000,6.50,15,NULL,'ACTIVE',NULL,0,'2027-05-01','2026-05-08 11:41:00','2026-05-08 11:41:00'),(12,2739,26,96,200000000,185000000,4.20,20,NULL,'ACTIVE',NULL,0,'2040-05-01','2026-05-08 11:41:00','2026-05-08 11:41:00'),(13,2740,27,97,150000000,140000000,3.80,10,NULL,'ACTIVE',NULL,0,'2026-12-01','2026-05-08 11:41:00','2026-05-08 11:41:00'),(14,2747,30,104,500000000,480000000,5.50,25,NULL,'ACTIVE',NULL,0,'2030-05-01','2026-05-08 11:41:00','2026-05-08 11:41:00'),(15,2749,29,106,100000000,90000000,5.00,15,NULL,'ACTIVE',NULL,0,'2028-05-01','2026-05-08 11:41:00','2026-05-08 11:41:00'),(16,2754,104,109,500000000,480000000,5.50,15,NULL,'OVERDUE','2026-05-19',20000000,'2030-12-31','2026-05-19 23:23:42','2026-05-19 23:23:42');
/*!40000 ALTER TABLE `loan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loan_schedule`
--

DROP TABLE IF EXISTS `loan_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loan_schedule` (
  `schedule_id` bigint NOT NULL AUTO_INCREMENT,
  `loan_id` int NOT NULL,
  `due_date` date NOT NULL,
  `repay_amount` decimal(15,2) NOT NULL,
  `status` varchar(20) DEFAULT 'SCHEDULED',
  `paid_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`schedule_id`),
  KEY `fk_loan_schedule_loan` (`loan_id`),
  CONSTRAINT `fk_loan_schedule_loan` FOREIGN KEY (`loan_id`) REFERENCES `loan` (`loan_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loan_schedule`
--

LOCK TABLES `loan_schedule` WRITE;
/*!40000 ALTER TABLE `loan_schedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `loan_schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(30) NOT NULL,
  `level` int unsigned DEFAULT '1',
  `auth` varchar(20) DEFAULT '사원',
  `team` varchar(50) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1',
  `counter_number` int DEFAULT NULL,
  `join_date` date DEFAULT (curdate()),
  `last_login` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member`
--

LOCK TABLES `member` WRITE;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` VALUES (1,'banker@naver.com','banker','행원1',1,'사원',NULL,1,1,'2026-03-27',NULL,'2026-03-27 03:08:27'),(2,'test123@naver.com','banker','행원2',2,'사원','영업팀',1,2,'2026-05-02','2026-05-02 14:47:13','2026-05-02 05:47:13'),(3,'test222@naver.com','banker','행원3',3,'사원',NULL,1,3,'2026-05-08',NULL,'2026-05-08 01:13:24'),(4,'test111@naver.com','banker','행원4',4,'사원',NULL,0,4,'2026-05-08',NULL,'2026-05-08 01:14:43'),(5,'test333@naver.com','banker','행원5',5,'사원',NULL,1,5,'2026-05-08',NULL,'2026-05-08 01:14:43');
/*!40000 ALTER TABLE `member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_subscription`
--

DROP TABLE IF EXISTS `product_subscription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_subscription` (
  `subscription_id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `product_id` int unsigned NOT NULL,
  `task_id` bigint DEFAULT NULL,
  `amount` bigint DEFAULT NULL,
  `duration_months` int DEFAULT NULL,
  `applied_interest_rate` decimal(5,2) DEFAULT NULL,
  `status` varchar(20) DEFAULT 'ACTIVE',
  `payment_day` int DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`subscription_id`),
  KEY `fk_sub_product` (`product_id`),
  KEY `fk_sub_user` (`user_id`),
  CONSTRAINT `fk_sub_product` FOREIGN KEY (`product_id`) REFERENCES `financial_product` (`product_id`),
  CONSTRAINT `fk_sub_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_subscription`
--

LOCK TABLES `product_subscription` WRITE;
/*!40000 ALTER TABLE `product_subscription` DISABLE KEYS */;
INSERT INTO `product_subscription` VALUES (10,2732,106,NULL,150000000,24,3.80,'ACTIVE',NULL,'2026-05-12 22:07:36'),(15,2747,107,NULL,30000000,36,5.50,'ACTIVE',NULL,'2026-05-12 22:07:36'),(16,2747,108,NULL,500000000,60,6.00,'ACTIVE',NULL,'2026-05-12 22:07:36'),(20,2757,100,NULL,300000,12,3.80,'ACTIVE',NULL,'2026-05-20 17:42:30');
/*!40000 ALTER TABLE `product_subscription` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `savings_account`
--

DROP TABLE IF EXISTS `savings_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `savings_account` (
  `account_id` bigint NOT NULL,
  `linked_account_id` bigint NOT NULL,
  `installment_amount` bigint NOT NULL,
  `term_months` int NOT NULL,
  `payment_day` int NOT NULL,
  `maturity_date` date NOT NULL,
  PRIMARY KEY (`account_id`),
  KEY `fk_savings_to_linked_account` (`linked_account_id`),
  CONSTRAINT `fk_savings_to_base_account` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_savings_to_linked_account` FOREIGN KEY (`linked_account_id`) REFERENCES `account` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `savings_account`
--

LOCK TABLES `savings_account` WRITE;
/*!40000 ALTER TABLE `savings_account` DISABLE KEYS */;
INSERT INTO `savings_account` VALUES (115,114,300000,12,20,'2026-11-20');
/*!40000 ALTER TABLE `savings_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `savings_schedule`
--

DROP TABLE IF EXISTS `savings_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `savings_schedule` (
  `schedule_id` bigint NOT NULL AUTO_INCREMENT,
  `account_id` bigint NOT NULL,
  `due_date` date NOT NULL,
  `installment_amount` decimal(15,2) NOT NULL,
  `status` varchar(20) DEFAULT 'PENDING',
  `paid_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`schedule_id`),
  KEY `account_id` (`account_id`),
  CONSTRAINT `savings_schedule_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `savings_schedule`
--

LOCK TABLES `savings_schedule` WRITE;
/*!40000 ALTER TABLE `savings_schedule` DISABLE KEYS */;
INSERT INTO `savings_schedule` VALUES (25,115,'2025-11-20',300000.00,'COMPLETED','2025-11-20 09:00:00','2026-05-20 17:42:25'),(26,115,'2025-12-20',300000.00,'COMPLETED','2025-12-20 09:00:00','2026-05-20 17:42:25'),(27,115,'2026-01-20',300000.00,'COMPLETED','2026-01-20 09:00:00','2026-05-20 17:42:25'),(28,115,'2026-02-20',300000.00,'COMPLETED','2026-02-20 09:00:00','2026-05-20 17:42:25'),(29,115,'2026-03-20',300000.00,'COMPLETED','2026-03-20 09:00:00','2026-05-20 17:42:25'),(30,115,'2026-04-20',300000.00,'COMPLETED','2026-04-20 09:00:00','2026-05-20 17:42:25'),(31,115,'2026-05-20',300000.00,'COMPLETED','2026-05-23 13:39:18','2026-05-20 17:42:25'),(32,115,'2026-06-20',300000.00,'PENDING',NULL,'2026-05-20 17:42:25'),(33,115,'2026-07-20',300000.00,'PENDING',NULL,'2026-05-20 17:42:25'),(34,115,'2026-08-20',300000.00,'PENDING',NULL,'2026-05-20 17:42:25'),(35,115,'2026-09-20',300000.00,'PENDING',NULL,'2026-05-20 17:42:25'),(36,115,'2026-10-20',300000.00,'PENDING',NULL,'2026-05-20 17:42:25');
/*!40000 ALTER TABLE `savings_schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sms_auth`
--

DROP TABLE IF EXISTS `sms_auth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sms_auth` (
  `phone_number` varchar(20) NOT NULL,
  `auth_code` varchar(6) NOT NULL,
  `is_verified` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `expires_at` datetime NOT NULL,
  PRIMARY KEY (`phone_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sms_auth`
--

LOCK TABLES `sms_auth` WRITE;
/*!40000 ALTER TABLE `sms_auth` DISABLE KEYS */;
/*!40000 ALTER TABLE `sms_auth` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task`
--

DROP TABLE IF EXISTS `task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task` (
  `task_id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `ticket_number` varchar(20) NOT NULL,
  `task_type` varchar(50) NOT NULL,
  `task_detail_type` varchar(50) NOT NULL,
  `assigned_level` varchar(20) DEFAULT NULL,
  `expected_waiting_time` int DEFAULT NULL,
  `status` varchar(20) DEFAULT 'WAITING',
  `member_id` int unsigned DEFAULT NULL,
  `ranking` int unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_ai` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`task_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `task_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task`
--

LOCK TABLES `task` WRITE;
/*!40000 ALTER TABLE `task` DISABLE KEYS */;
/*!40000 ALTER TABLE `task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_processing_log`
--

DROP TABLE IF EXISTS `task_processing_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task_processing_log` (
  `log_id` bigint NOT NULL AUTO_INCREMENT,
  `task_id` bigint NOT NULL,
  `member_id` int unsigned NOT NULL,
  `action_type` varchar(50) NOT NULL,
  `processing_note` text,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`log_id`),
  KEY `fk_log_task` (`task_id`),
  KEY `fk_log_member` (`member_id`),
  CONSTRAINT `fk_log_member` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`),
  CONSTRAINT `fk_log_task` FOREIGN KEY (`task_id`) REFERENCES `task` (`task_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_processing_log`
--

LOCK TABLES `task_processing_log` WRITE;
/*!40000 ALTER TABLE `task_processing_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_processing_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction_history`
--

DROP TABLE IF EXISTS `transaction_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction_history` (
  `transaction_id` bigint NOT NULL AUTO_INCREMENT,
  `account_id` bigint NOT NULL,
  `user_id` int unsigned DEFAULT NULL,
  `task_id` bigint DEFAULT NULL,
  `transaction_type` varchar(50) NOT NULL,
  `amount` bigint NOT NULL,
  `balance_after` bigint NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`transaction_id`),
  KEY `fk_tx_account` (`account_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `fk_tx_account` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `transaction_history_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=960 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction_history`
--

LOCK TABLES `transaction_history` WRITE;
/*!40000 ALTER TABLE `transaction_history` DISABLE KEYS */;
INSERT INTO `transaction_history` VALUES (495,93,NULL,NULL,'TRANSFER',50000,2000000,NULL,'2026-05-07 11:41:53','2026-05-08 11:41:53'),(496,92,NULL,NULL,'TRANSFER',50000,1200000,NULL,'2026-05-07 11:41:53','2026-05-08 11:41:53'),(497,91,NULL,NULL,'TRANSFER',50000,3000000,NULL,'2026-05-07 11:41:53','2026-05-08 11:41:53'),(498,90,NULL,NULL,'TRANSFER',50000,800000,NULL,'2026-05-07 11:41:53','2026-05-08 11:41:53'),(499,89,NULL,NULL,'TRANSFER',50000,2500000,NULL,'2026-05-07 11:41:53','2026-05-08 11:41:53'),(500,93,NULL,NULL,'TRANSFER',50000,2000000,NULL,'2026-05-06 11:41:53','2026-05-08 11:41:53'),(501,92,NULL,NULL,'TRANSFER',50000,1200000,NULL,'2026-05-06 11:41:53','2026-05-08 11:41:53'),(502,91,NULL,NULL,'TRANSFER',50000,3000000,NULL,'2026-05-06 11:41:53','2026-05-08 11:41:53'),(503,90,NULL,NULL,'TRANSFER',50000,800000,NULL,'2026-05-06 11:41:53','2026-05-08 11:41:53'),(504,89,NULL,NULL,'TRANSFER',50000,2500000,NULL,'2026-05-06 11:41:53','2026-05-08 11:41:53'),(505,93,NULL,NULL,'TRANSFER',50000,2000000,NULL,'2026-05-05 11:41:53','2026-05-08 11:41:53'),(506,92,NULL,NULL,'TRANSFER',50000,1200000,NULL,'2026-05-05 11:41:53','2026-05-08 11:41:53'),(507,91,NULL,NULL,'TRANSFER',50000,3000000,NULL,'2026-05-05 11:41:53','2026-05-08 11:41:53'),(508,90,NULL,NULL,'TRANSFER',50000,800000,NULL,'2026-05-05 11:41:53','2026-05-08 11:41:53'),(509,89,NULL,NULL,'TRANSFER',50000,2500000,NULL,'2026-05-05 11:41:53','2026-05-08 11:41:53'),(510,93,NULL,NULL,'TRANSFER',50000,2000000,NULL,'2026-05-04 11:41:53','2026-05-08 11:41:53'),(511,92,NULL,NULL,'TRANSFER',50000,1200000,NULL,'2026-05-04 11:41:53','2026-05-08 11:41:53'),(512,91,NULL,NULL,'TRANSFER',50000,3000000,NULL,'2026-05-04 11:41:53','2026-05-08 11:41:53'),(513,90,NULL,NULL,'TRANSFER',50000,800000,NULL,'2026-05-04 11:41:53','2026-05-08 11:41:53'),(514,89,NULL,NULL,'TRANSFER',50000,2500000,NULL,'2026-05-04 11:41:53','2026-05-08 11:41:53'),(515,93,NULL,NULL,'TRANSFER',50000,2000000,NULL,'2026-05-03 11:41:53','2026-05-08 11:41:53'),(516,92,NULL,NULL,'TRANSFER',50000,1200000,NULL,'2026-05-03 11:41:53','2026-05-08 11:41:53'),(517,91,NULL,NULL,'TRANSFER',50000,3000000,NULL,'2026-05-03 11:41:53','2026-05-08 11:41:53'),(518,90,NULL,NULL,'TRANSFER',50000,800000,NULL,'2026-05-03 11:41:53','2026-05-08 11:41:53'),(519,89,NULL,NULL,'TRANSFER',50000,2500000,NULL,'2026-05-03 11:41:53','2026-05-08 11:41:53'),(520,93,NULL,NULL,'TRANSFER',50000,2000000,NULL,'2026-05-02 11:41:53','2026-05-08 11:41:53'),(521,92,NULL,NULL,'TRANSFER',50000,1200000,NULL,'2026-05-02 11:41:53','2026-05-08 11:41:53'),(522,91,NULL,NULL,'TRANSFER',50000,3000000,NULL,'2026-05-02 11:41:53','2026-05-08 11:41:53'),(523,90,NULL,NULL,'TRANSFER',50000,800000,NULL,'2026-05-02 11:41:53','2026-05-08 11:41:53'),(524,89,NULL,NULL,'TRANSFER',50000,2500000,NULL,'2026-05-02 11:41:53','2026-05-08 11:41:53'),(525,93,NULL,NULL,'TRANSFER',50000,2000000,NULL,'2026-05-01 11:41:53','2026-05-08 11:41:53'),(526,92,NULL,NULL,'TRANSFER',50000,1200000,NULL,'2026-05-01 11:41:53','2026-05-08 11:41:53'),(527,91,NULL,NULL,'TRANSFER',50000,3000000,NULL,'2026-05-01 11:41:53','2026-05-08 11:41:53'),(528,90,NULL,NULL,'TRANSFER',50000,800000,NULL,'2026-05-01 11:41:53','2026-05-08 11:41:53'),(529,89,NULL,NULL,'TRANSFER',50000,2500000,NULL,'2026-05-01 11:41:53','2026-05-08 11:41:53'),(530,93,NULL,NULL,'TRANSFER',50000,2000000,NULL,'2026-04-30 11:41:53','2026-05-08 11:41:53'),(531,92,NULL,NULL,'TRANSFER',50000,1200000,NULL,'2026-04-30 11:41:53','2026-05-08 11:41:53'),(532,91,NULL,NULL,'TRANSFER',50000,3000000,NULL,'2026-04-30 11:41:53','2026-05-08 11:41:53'),(533,90,NULL,NULL,'TRANSFER',50000,800000,NULL,'2026-04-30 11:41:53','2026-05-08 11:41:53'),(534,89,NULL,NULL,'TRANSFER',50000,2500000,NULL,'2026-04-30 11:41:53','2026-05-08 11:41:53'),(535,93,NULL,NULL,'TRANSFER',50000,2000000,NULL,'2026-04-29 11:41:53','2026-05-08 11:41:53'),(536,92,NULL,NULL,'TRANSFER',50000,1200000,NULL,'2026-04-29 11:41:53','2026-05-08 11:41:53'),(537,91,NULL,NULL,'TRANSFER',50000,3000000,NULL,'2026-04-29 11:41:53','2026-05-08 11:41:53'),(538,90,NULL,NULL,'TRANSFER',50000,800000,NULL,'2026-04-29 11:41:53','2026-05-08 11:41:53'),(539,89,NULL,NULL,'TRANSFER',50000,2500000,NULL,'2026-04-29 11:41:53','2026-05-08 11:41:53'),(540,93,NULL,NULL,'TRANSFER',50000,2000000,NULL,'2026-04-28 11:41:53','2026-05-08 11:41:53'),(541,92,NULL,NULL,'TRANSFER',50000,1200000,NULL,'2026-04-28 11:41:53','2026-05-08 11:41:53'),(542,91,NULL,NULL,'TRANSFER',50000,3000000,NULL,'2026-04-28 11:41:53','2026-05-08 11:41:53'),(543,90,NULL,NULL,'TRANSFER',50000,800000,NULL,'2026-04-28 11:41:53','2026-05-08 11:41:53'),(544,89,NULL,NULL,'TRANSFER',50000,2500000,NULL,'2026-04-28 11:41:53','2026-05-08 11:41:53'),(545,93,NULL,NULL,'TRANSFER',50000,2000000,NULL,'2026-04-27 11:41:53','2026-05-08 11:41:53'),(546,92,NULL,NULL,'TRANSFER',50000,1200000,NULL,'2026-04-27 11:41:53','2026-05-08 11:41:53'),(547,91,NULL,NULL,'TRANSFER',50000,3000000,NULL,'2026-04-27 11:41:53','2026-05-08 11:41:53'),(548,90,NULL,NULL,'TRANSFER',50000,800000,NULL,'2026-04-27 11:41:53','2026-05-08 11:41:53'),(549,89,NULL,NULL,'TRANSFER',50000,2500000,NULL,'2026-04-27 11:41:53','2026-05-08 11:41:53'),(550,93,NULL,NULL,'TRANSFER',50000,2000000,NULL,'2026-04-26 11:41:53','2026-05-08 11:41:53'),(551,92,NULL,NULL,'TRANSFER',50000,1200000,NULL,'2026-04-26 11:41:53','2026-05-08 11:41:53'),(552,91,NULL,NULL,'TRANSFER',50000,3000000,NULL,'2026-04-26 11:41:53','2026-05-08 11:41:53'),(553,90,NULL,NULL,'TRANSFER',50000,800000,NULL,'2026-04-26 11:41:53','2026-05-08 11:41:53'),(554,89,NULL,NULL,'TRANSFER',50000,2500000,NULL,'2026-04-26 11:41:53','2026-05-08 11:41:53'),(555,93,NULL,NULL,'TRANSFER',50000,2000000,NULL,'2026-04-25 11:41:53','2026-05-08 11:41:53'),(556,92,NULL,NULL,'TRANSFER',50000,1200000,NULL,'2026-04-25 11:41:53','2026-05-08 11:41:53'),(557,91,NULL,NULL,'TRANSFER',50000,3000000,NULL,'2026-04-25 11:41:53','2026-05-08 11:41:53'),(558,90,NULL,NULL,'TRANSFER',50000,800000,NULL,'2026-04-25 11:41:53','2026-05-08 11:41:53'),(559,89,NULL,NULL,'TRANSFER',50000,2500000,NULL,'2026-04-25 11:41:53','2026-05-08 11:41:53'),(560,93,NULL,NULL,'TRANSFER',50000,2000000,NULL,'2026-04-24 11:41:53','2026-05-08 11:41:53'),(561,92,NULL,NULL,'TRANSFER',50000,1200000,NULL,'2026-04-24 11:41:53','2026-05-08 11:41:53'),(562,91,NULL,NULL,'TRANSFER',50000,3000000,NULL,'2026-04-24 11:41:53','2026-05-08 11:41:53'),(563,90,NULL,NULL,'TRANSFER',50000,800000,NULL,'2026-04-24 11:41:53','2026-05-08 11:41:53'),(564,89,NULL,NULL,'TRANSFER',50000,2500000,NULL,'2026-04-24 11:41:53','2026-05-08 11:41:53'),(565,93,NULL,NULL,'TRANSFER',50000,2000000,NULL,'2026-04-23 11:41:53','2026-05-08 11:41:53'),(566,92,NULL,NULL,'TRANSFER',50000,1200000,NULL,'2026-04-23 11:41:53','2026-05-08 11:41:53'),(567,91,NULL,NULL,'TRANSFER',50000,3000000,NULL,'2026-04-23 11:41:53','2026-05-08 11:41:53'),(568,90,NULL,NULL,'TRANSFER',50000,800000,NULL,'2026-04-23 11:41:53','2026-05-08 11:41:53'),(569,89,NULL,NULL,'TRANSFER',50000,2500000,NULL,'2026-04-23 11:41:53','2026-05-08 11:41:53'),(570,93,NULL,NULL,'TRANSFER',50000,2000000,NULL,'2026-04-22 11:41:53','2026-05-08 11:41:53'),(571,92,NULL,NULL,'TRANSFER',50000,1200000,NULL,'2026-04-22 11:41:53','2026-05-08 11:41:53'),(572,91,NULL,NULL,'TRANSFER',50000,3000000,NULL,'2026-04-22 11:41:53','2026-05-08 11:41:53'),(573,90,NULL,NULL,'TRANSFER',50000,800000,NULL,'2026-04-22 11:41:53','2026-05-08 11:41:53'),(574,89,NULL,NULL,'TRANSFER',50000,2500000,NULL,'2026-04-22 11:41:53','2026-05-08 11:41:53'),(575,93,NULL,NULL,'TRANSFER',50000,2000000,NULL,'2026-04-21 11:41:53','2026-05-08 11:41:53'),(576,92,NULL,NULL,'TRANSFER',50000,1200000,NULL,'2026-04-21 11:41:53','2026-05-08 11:41:53'),(577,91,NULL,NULL,'TRANSFER',50000,3000000,NULL,'2026-04-21 11:41:53','2026-05-08 11:41:53'),(578,90,NULL,NULL,'TRANSFER',50000,800000,NULL,'2026-04-21 11:41:53','2026-05-08 11:41:53'),(579,89,NULL,NULL,'TRANSFER',50000,2500000,NULL,'2026-04-21 11:41:53','2026-05-08 11:41:53'),(580,93,NULL,NULL,'TRANSFER',50000,2000000,NULL,'2026-04-20 11:41:53','2026-05-08 11:41:53'),(581,92,NULL,NULL,'TRANSFER',50000,1200000,NULL,'2026-04-20 11:41:53','2026-05-08 11:41:53'),(582,91,NULL,NULL,'TRANSFER',50000,3000000,NULL,'2026-04-20 11:41:53','2026-05-08 11:41:53'),(583,90,NULL,NULL,'TRANSFER',50000,800000,NULL,'2026-04-20 11:41:53','2026-05-08 11:41:53'),(584,89,NULL,NULL,'TRANSFER',50000,2500000,NULL,'2026-04-20 11:41:53','2026-05-08 11:41:53'),(585,93,NULL,NULL,'TRANSFER',50000,2000000,NULL,'2026-04-19 11:41:53','2026-05-08 11:41:53'),(586,92,NULL,NULL,'TRANSFER',50000,1200000,NULL,'2026-04-19 11:41:53','2026-05-08 11:41:53'),(587,91,NULL,NULL,'TRANSFER',50000,3000000,NULL,'2026-04-19 11:41:53','2026-05-08 11:41:53'),(588,90,NULL,NULL,'TRANSFER',50000,800000,NULL,'2026-04-19 11:41:53','2026-05-08 11:41:53'),(589,89,NULL,NULL,'TRANSFER',50000,2500000,NULL,'2026-04-19 11:41:53','2026-05-08 11:41:53'),(590,93,NULL,NULL,'TRANSFER',50000,2000000,NULL,'2026-04-18 11:41:53','2026-05-08 11:41:53'),(591,92,NULL,NULL,'TRANSFER',50000,1200000,NULL,'2026-04-18 11:41:53','2026-05-08 11:41:53'),(592,91,NULL,NULL,'TRANSFER',50000,3000000,NULL,'2026-04-18 11:41:53','2026-05-08 11:41:53'),(593,90,NULL,NULL,'TRANSFER',50000,800000,NULL,'2026-04-18 11:41:53','2026-05-08 11:41:53'),(594,89,NULL,NULL,'TRANSFER',50000,2500000,NULL,'2026-04-18 11:41:53','2026-05-08 11:41:53'),(595,93,NULL,NULL,'TRANSFER',50000,2000000,NULL,'2026-04-17 11:41:53','2026-05-08 11:41:53'),(596,92,NULL,NULL,'TRANSFER',50000,1200000,NULL,'2026-04-17 11:41:53','2026-05-08 11:41:53'),(597,91,NULL,NULL,'TRANSFER',50000,3000000,NULL,'2026-04-17 11:41:53','2026-05-08 11:41:53'),(598,90,NULL,NULL,'TRANSFER',50000,800000,NULL,'2026-04-17 11:41:53','2026-05-08 11:41:53'),(599,89,NULL,NULL,'TRANSFER',50000,2500000,NULL,'2026-04-17 11:41:53','2026-05-08 11:41:53'),(600,93,NULL,NULL,'TRANSFER',50000,2000000,NULL,'2026-04-16 11:41:53','2026-05-08 11:41:53'),(601,92,NULL,NULL,'TRANSFER',50000,1200000,NULL,'2026-04-16 11:41:53','2026-05-08 11:41:53'),(602,91,NULL,NULL,'TRANSFER',50000,3000000,NULL,'2026-04-16 11:41:53','2026-05-08 11:41:53'),(603,90,NULL,NULL,'TRANSFER',50000,800000,NULL,'2026-04-16 11:41:53','2026-05-08 11:41:53'),(604,89,NULL,NULL,'TRANSFER',50000,2500000,NULL,'2026-04-16 11:41:53','2026-05-08 11:41:53'),(605,93,NULL,NULL,'TRANSFER',50000,2000000,NULL,'2026-04-15 11:41:53','2026-05-08 11:41:53'),(606,92,NULL,NULL,'TRANSFER',50000,1200000,NULL,'2026-04-15 11:41:53','2026-05-08 11:41:53'),(607,91,NULL,NULL,'TRANSFER',50000,3000000,NULL,'2026-04-15 11:41:53','2026-05-08 11:41:53'),(608,90,NULL,NULL,'TRANSFER',50000,800000,NULL,'2026-04-15 11:41:53','2026-05-08 11:41:53'),(609,89,NULL,NULL,'TRANSFER',50000,2500000,NULL,'2026-04-15 11:41:53','2026-05-08 11:41:53'),(610,93,NULL,NULL,'TRANSFER',50000,2000000,NULL,'2026-04-14 11:41:53','2026-05-08 11:41:53'),(611,92,NULL,NULL,'TRANSFER',50000,1200000,NULL,'2026-04-14 11:41:53','2026-05-08 11:41:53'),(612,91,NULL,NULL,'TRANSFER',50000,3000000,NULL,'2026-04-14 11:41:53','2026-05-08 11:41:53'),(613,90,NULL,NULL,'TRANSFER',50000,800000,NULL,'2026-04-14 11:41:53','2026-05-08 11:41:53'),(614,89,NULL,NULL,'TRANSFER',50000,2500000,NULL,'2026-04-14 11:41:53','2026-05-08 11:41:53'),(615,93,NULL,NULL,'TRANSFER',50000,2000000,NULL,'2026-04-13 11:41:53','2026-05-08 11:41:53'),(616,92,NULL,NULL,'TRANSFER',50000,1200000,NULL,'2026-04-13 11:41:53','2026-05-08 11:41:53'),(617,91,NULL,NULL,'TRANSFER',50000,3000000,NULL,'2026-04-13 11:41:53','2026-05-08 11:41:53'),(618,90,NULL,NULL,'TRANSFER',50000,800000,NULL,'2026-04-13 11:41:53','2026-05-08 11:41:53'),(619,89,NULL,NULL,'TRANSFER',50000,2500000,NULL,'2026-04-13 11:41:53','2026-05-08 11:41:53'),(620,93,NULL,NULL,'TRANSFER',50000,2000000,NULL,'2026-04-12 11:41:53','2026-05-08 11:41:53'),(621,92,NULL,NULL,'TRANSFER',50000,1200000,NULL,'2026-04-12 11:41:53','2026-05-08 11:41:53'),(622,91,NULL,NULL,'TRANSFER',50000,3000000,NULL,'2026-04-12 11:41:53','2026-05-08 11:41:53'),(623,90,NULL,NULL,'TRANSFER',50000,800000,NULL,'2026-04-12 11:41:53','2026-05-08 11:41:53'),(624,89,NULL,NULL,'TRANSFER',50000,2500000,NULL,'2026-04-12 11:41:53','2026-05-08 11:41:53'),(625,93,NULL,NULL,'TRANSFER',50000,2000000,NULL,'2026-04-11 11:41:53','2026-05-08 11:41:53'),(626,92,NULL,NULL,'TRANSFER',50000,1200000,NULL,'2026-04-11 11:41:53','2026-05-08 11:41:53'),(627,91,NULL,NULL,'TRANSFER',50000,3000000,NULL,'2026-04-11 11:41:53','2026-05-08 11:41:53'),(628,90,NULL,NULL,'TRANSFER',50000,800000,NULL,'2026-04-11 11:41:53','2026-05-08 11:41:53'),(629,89,NULL,NULL,'TRANSFER',50000,2500000,NULL,'2026-04-11 11:41:53','2026-05-08 11:41:53'),(630,93,NULL,NULL,'TRANSFER',50000,2000000,NULL,'2026-04-10 11:41:53','2026-05-08 11:41:53'),(631,92,NULL,NULL,'TRANSFER',50000,1200000,NULL,'2026-04-10 11:41:53','2026-05-08 11:41:53'),(632,91,NULL,NULL,'TRANSFER',50000,3000000,NULL,'2026-04-10 11:41:53','2026-05-08 11:41:53'),(633,90,NULL,NULL,'TRANSFER',50000,800000,NULL,'2026-04-10 11:41:53','2026-05-08 11:41:53'),(634,89,NULL,NULL,'TRANSFER',50000,2500000,NULL,'2026-04-10 11:41:53','2026-05-08 11:41:53'),(635,93,NULL,NULL,'TRANSFER',50000,2000000,NULL,'2026-04-09 11:41:53','2026-05-08 11:41:53'),(636,92,NULL,NULL,'TRANSFER',50000,1200000,NULL,'2026-04-09 11:41:53','2026-05-08 11:41:53'),(637,91,NULL,NULL,'TRANSFER',50000,3000000,NULL,'2026-04-09 11:41:53','2026-05-08 11:41:53'),(638,90,NULL,NULL,'TRANSFER',50000,800000,NULL,'2026-04-09 11:41:53','2026-05-08 11:41:53'),(639,89,NULL,NULL,'TRANSFER',50000,2500000,NULL,'2026-04-09 11:41:53','2026-05-08 11:41:53'),(640,93,NULL,NULL,'TRANSFER',50000,2000000,NULL,'2026-04-08 11:41:53','2026-05-08 11:41:53'),(641,92,NULL,NULL,'TRANSFER',50000,1200000,NULL,'2026-04-08 11:41:53','2026-05-08 11:41:53'),(642,91,NULL,NULL,'TRANSFER',50000,3000000,NULL,'2026-04-08 11:41:53','2026-05-08 11:41:53'),(643,90,NULL,NULL,'TRANSFER',50000,800000,NULL,'2026-04-08 11:41:53','2026-05-08 11:41:53'),(644,89,NULL,NULL,'TRANSFER',50000,2500000,NULL,'2026-04-08 11:41:53','2026-05-08 11:41:53'),(750,98,NULL,NULL,'DEPOSIT',300000,10000000,NULL,'2026-05-07 11:41:57','2026-05-08 11:41:57'),(751,97,NULL,NULL,'DEPOSIT',300000,18000000,NULL,'2026-05-07 11:41:57','2026-05-08 11:41:57'),(752,96,NULL,NULL,'DEPOSIT',300000,25000000,NULL,'2026-05-07 11:41:57','2026-05-08 11:41:57'),(753,95,NULL,NULL,'DEPOSIT',300000,32000000,NULL,'2026-05-07 11:41:57','2026-05-08 11:41:57'),(754,94,NULL,NULL,'DEPOSIT',300000,15000000,NULL,'2026-05-07 11:41:57','2026-05-08 11:41:57'),(755,98,NULL,NULL,'DEPOSIT',300000,10000000,NULL,'2026-05-06 11:41:57','2026-05-08 11:41:57'),(756,97,NULL,NULL,'DEPOSIT',300000,18000000,NULL,'2026-05-06 11:41:57','2026-05-08 11:41:57'),(757,96,NULL,NULL,'DEPOSIT',300000,25000000,NULL,'2026-05-06 11:41:57','2026-05-08 11:41:57'),(758,95,NULL,NULL,'DEPOSIT',300000,32000000,NULL,'2026-05-06 11:41:57','2026-05-08 11:41:57'),(759,94,NULL,NULL,'DEPOSIT',300000,15000000,NULL,'2026-05-06 11:41:57','2026-05-08 11:41:57'),(760,98,NULL,NULL,'DEPOSIT',300000,10000000,NULL,'2026-05-05 11:41:57','2026-05-08 11:41:57'),(761,97,NULL,NULL,'DEPOSIT',300000,18000000,NULL,'2026-05-05 11:41:57','2026-05-08 11:41:57'),(762,96,NULL,NULL,'DEPOSIT',300000,25000000,NULL,'2026-05-05 11:41:57','2026-05-08 11:41:57'),(763,95,NULL,NULL,'DEPOSIT',300000,32000000,NULL,'2026-05-05 11:41:57','2026-05-08 11:41:57'),(764,94,NULL,NULL,'DEPOSIT',300000,15000000,NULL,'2026-05-05 11:41:57','2026-05-08 11:41:57'),(765,98,NULL,NULL,'DEPOSIT',300000,10000000,NULL,'2026-05-04 11:41:57','2026-05-08 11:41:57'),(766,97,NULL,NULL,'DEPOSIT',300000,18000000,NULL,'2026-05-04 11:41:57','2026-05-08 11:41:57'),(767,96,NULL,NULL,'DEPOSIT',300000,25000000,NULL,'2026-05-04 11:41:57','2026-05-08 11:41:57'),(768,95,NULL,NULL,'DEPOSIT',300000,32000000,NULL,'2026-05-04 11:41:57','2026-05-08 11:41:57'),(769,94,NULL,NULL,'DEPOSIT',300000,15000000,NULL,'2026-05-04 11:41:57','2026-05-08 11:41:57'),(770,98,NULL,NULL,'DEPOSIT',300000,10000000,NULL,'2026-05-03 11:41:57','2026-05-08 11:41:57'),(771,97,NULL,NULL,'DEPOSIT',300000,18000000,NULL,'2026-05-03 11:41:57','2026-05-08 11:41:57'),(772,96,NULL,NULL,'DEPOSIT',300000,25000000,NULL,'2026-05-03 11:41:57','2026-05-08 11:41:57'),(773,95,NULL,NULL,'DEPOSIT',300000,32000000,NULL,'2026-05-03 11:41:57','2026-05-08 11:41:57'),(774,94,NULL,NULL,'DEPOSIT',300000,15000000,NULL,'2026-05-03 11:41:57','2026-05-08 11:41:57'),(775,98,NULL,NULL,'DEPOSIT',300000,10000000,NULL,'2026-05-02 11:41:57','2026-05-08 11:41:57'),(776,97,NULL,NULL,'DEPOSIT',300000,18000000,NULL,'2026-05-02 11:41:57','2026-05-08 11:41:57'),(777,96,NULL,NULL,'DEPOSIT',300000,25000000,NULL,'2026-05-02 11:41:57','2026-05-08 11:41:57'),(778,95,NULL,NULL,'DEPOSIT',300000,32000000,NULL,'2026-05-02 11:41:57','2026-05-08 11:41:57'),(779,94,NULL,NULL,'DEPOSIT',300000,15000000,NULL,'2026-05-02 11:41:57','2026-05-08 11:41:57'),(780,98,NULL,NULL,'DEPOSIT',300000,10000000,NULL,'2026-05-01 11:41:57','2026-05-08 11:41:57'),(781,97,NULL,NULL,'DEPOSIT',300000,18000000,NULL,'2026-05-01 11:41:57','2026-05-08 11:41:57'),(782,96,NULL,NULL,'DEPOSIT',300000,25000000,NULL,'2026-05-01 11:41:57','2026-05-08 11:41:57'),(783,95,NULL,NULL,'DEPOSIT',300000,32000000,NULL,'2026-05-01 11:41:57','2026-05-08 11:41:57'),(784,94,NULL,NULL,'DEPOSIT',300000,15000000,NULL,'2026-05-01 11:41:57','2026-05-08 11:41:57'),(785,98,NULL,NULL,'DEPOSIT',300000,10000000,NULL,'2026-04-30 11:41:57','2026-05-08 11:41:57'),(786,97,NULL,NULL,'DEPOSIT',300000,18000000,NULL,'2026-04-30 11:41:57','2026-05-08 11:41:57'),(787,96,NULL,NULL,'DEPOSIT',300000,25000000,NULL,'2026-04-30 11:41:57','2026-05-08 11:41:57'),(788,95,NULL,NULL,'DEPOSIT',300000,32000000,NULL,'2026-04-30 11:41:57','2026-05-08 11:41:57'),(789,94,NULL,NULL,'DEPOSIT',300000,15000000,NULL,'2026-04-30 11:41:57','2026-05-08 11:41:57'),(790,98,NULL,NULL,'DEPOSIT',300000,10000000,NULL,'2026-04-29 11:41:57','2026-05-08 11:41:57'),(791,97,NULL,NULL,'DEPOSIT',300000,18000000,NULL,'2026-04-29 11:41:57','2026-05-08 11:41:57'),(792,96,NULL,NULL,'DEPOSIT',300000,25000000,NULL,'2026-04-29 11:41:57','2026-05-08 11:41:57'),(793,95,NULL,NULL,'DEPOSIT',300000,32000000,NULL,'2026-04-29 11:41:57','2026-05-08 11:41:57'),(794,94,NULL,NULL,'DEPOSIT',300000,15000000,NULL,'2026-04-29 11:41:57','2026-05-08 11:41:57'),(795,98,NULL,NULL,'DEPOSIT',300000,10000000,NULL,'2026-04-28 11:41:57','2026-05-08 11:41:57'),(796,97,NULL,NULL,'DEPOSIT',300000,18000000,NULL,'2026-04-28 11:41:57','2026-05-08 11:41:57'),(797,96,NULL,NULL,'DEPOSIT',300000,25000000,NULL,'2026-04-28 11:41:57','2026-05-08 11:41:57'),(798,95,NULL,NULL,'DEPOSIT',300000,32000000,NULL,'2026-04-28 11:41:57','2026-05-08 11:41:57'),(799,94,NULL,NULL,'DEPOSIT',300000,15000000,NULL,'2026-04-28 11:41:57','2026-05-08 11:41:57'),(800,98,NULL,NULL,'DEPOSIT',300000,10000000,NULL,'2026-04-27 11:41:57','2026-05-08 11:41:57'),(801,97,NULL,NULL,'DEPOSIT',300000,18000000,NULL,'2026-04-27 11:41:57','2026-05-08 11:41:57'),(802,96,NULL,NULL,'DEPOSIT',300000,25000000,NULL,'2026-04-27 11:41:57','2026-05-08 11:41:57'),(803,95,NULL,NULL,'DEPOSIT',300000,32000000,NULL,'2026-04-27 11:41:57','2026-05-08 11:41:57'),(804,94,NULL,NULL,'DEPOSIT',300000,15000000,NULL,'2026-04-27 11:41:57','2026-05-08 11:41:57'),(805,98,NULL,NULL,'DEPOSIT',300000,10000000,NULL,'2026-04-26 11:41:57','2026-05-08 11:41:57'),(806,97,NULL,NULL,'DEPOSIT',300000,18000000,NULL,'2026-04-26 11:41:57','2026-05-08 11:41:57'),(807,96,NULL,NULL,'DEPOSIT',300000,25000000,NULL,'2026-04-26 11:41:57','2026-05-08 11:41:57'),(808,95,NULL,NULL,'DEPOSIT',300000,32000000,NULL,'2026-04-26 11:41:57','2026-05-08 11:41:57'),(809,94,NULL,NULL,'DEPOSIT',300000,15000000,NULL,'2026-04-26 11:41:57','2026-05-08 11:41:57'),(810,98,NULL,NULL,'DEPOSIT',300000,10000000,NULL,'2026-04-25 11:41:57','2026-05-08 11:41:57'),(811,97,NULL,NULL,'DEPOSIT',300000,18000000,NULL,'2026-04-25 11:41:57','2026-05-08 11:41:57'),(812,96,NULL,NULL,'DEPOSIT',300000,25000000,NULL,'2026-04-25 11:41:57','2026-05-08 11:41:57'),(813,95,NULL,NULL,'DEPOSIT',300000,32000000,NULL,'2026-04-25 11:41:57','2026-05-08 11:41:57'),(814,94,NULL,NULL,'DEPOSIT',300000,15000000,NULL,'2026-04-25 11:41:57','2026-05-08 11:41:57'),(815,98,NULL,NULL,'DEPOSIT',300000,10000000,NULL,'2026-04-24 11:41:57','2026-05-08 11:41:57'),(816,97,NULL,NULL,'DEPOSIT',300000,18000000,NULL,'2026-04-24 11:41:57','2026-05-08 11:41:57'),(817,96,NULL,NULL,'DEPOSIT',300000,25000000,NULL,'2026-04-24 11:41:57','2026-05-08 11:41:57'),(818,95,NULL,NULL,'DEPOSIT',300000,32000000,NULL,'2026-04-24 11:41:57','2026-05-08 11:41:57'),(819,94,NULL,NULL,'DEPOSIT',300000,15000000,NULL,'2026-04-24 11:41:57','2026-05-08 11:41:57'),(820,98,NULL,NULL,'DEPOSIT',300000,10000000,NULL,'2026-04-23 11:41:57','2026-05-08 11:41:57'),(821,97,NULL,NULL,'DEPOSIT',300000,18000000,NULL,'2026-04-23 11:41:57','2026-05-08 11:41:57'),(822,96,NULL,NULL,'DEPOSIT',300000,25000000,NULL,'2026-04-23 11:41:57','2026-05-08 11:41:57'),(823,95,NULL,NULL,'DEPOSIT',300000,32000000,NULL,'2026-04-23 11:41:57','2026-05-08 11:41:57'),(824,94,NULL,NULL,'DEPOSIT',300000,15000000,NULL,'2026-04-23 11:41:57','2026-05-08 11:41:57'),(825,98,NULL,NULL,'DEPOSIT',300000,10000000,NULL,'2026-04-22 11:41:57','2026-05-08 11:41:57'),(826,97,NULL,NULL,'DEPOSIT',300000,18000000,NULL,'2026-04-22 11:41:57','2026-05-08 11:41:57'),(827,96,NULL,NULL,'DEPOSIT',300000,25000000,NULL,'2026-04-22 11:41:57','2026-05-08 11:41:57'),(828,95,NULL,NULL,'DEPOSIT',300000,32000000,NULL,'2026-04-22 11:41:57','2026-05-08 11:41:57'),(829,94,NULL,NULL,'DEPOSIT',300000,15000000,NULL,'2026-04-22 11:41:57','2026-05-08 11:41:57'),(830,98,NULL,NULL,'DEPOSIT',300000,10000000,NULL,'2026-04-21 11:41:57','2026-05-08 11:41:57'),(831,97,NULL,NULL,'DEPOSIT',300000,18000000,NULL,'2026-04-21 11:41:57','2026-05-08 11:41:57'),(832,96,NULL,NULL,'DEPOSIT',300000,25000000,NULL,'2026-04-21 11:41:57','2026-05-08 11:41:57'),(833,95,NULL,NULL,'DEPOSIT',300000,32000000,NULL,'2026-04-21 11:41:57','2026-05-08 11:41:57'),(834,94,NULL,NULL,'DEPOSIT',300000,15000000,NULL,'2026-04-21 11:41:57','2026-05-08 11:41:57'),(835,98,NULL,NULL,'DEPOSIT',300000,10000000,NULL,'2026-04-20 11:41:57','2026-05-08 11:41:57'),(836,97,NULL,NULL,'DEPOSIT',300000,18000000,NULL,'2026-04-20 11:41:57','2026-05-08 11:41:57'),(837,96,NULL,NULL,'DEPOSIT',300000,25000000,NULL,'2026-04-20 11:41:57','2026-05-08 11:41:57'),(838,95,NULL,NULL,'DEPOSIT',300000,32000000,NULL,'2026-04-20 11:41:57','2026-05-08 11:41:57'),(839,94,NULL,NULL,'DEPOSIT',300000,15000000,NULL,'2026-04-20 11:41:57','2026-05-08 11:41:57'),(840,98,NULL,NULL,'DEPOSIT',300000,10000000,NULL,'2026-04-19 11:41:57','2026-05-08 11:41:57'),(841,97,NULL,NULL,'DEPOSIT',300000,18000000,NULL,'2026-04-19 11:41:57','2026-05-08 11:41:57'),(842,96,NULL,NULL,'DEPOSIT',300000,25000000,NULL,'2026-04-19 11:41:57','2026-05-08 11:41:57'),(843,95,NULL,NULL,'DEPOSIT',300000,32000000,NULL,'2026-04-19 11:41:57','2026-05-08 11:41:57'),(844,94,NULL,NULL,'DEPOSIT',300000,15000000,NULL,'2026-04-19 11:41:57','2026-05-08 11:41:57'),(845,98,NULL,NULL,'DEPOSIT',300000,10000000,NULL,'2026-04-18 11:41:57','2026-05-08 11:41:57'),(846,97,NULL,NULL,'DEPOSIT',300000,18000000,NULL,'2026-04-18 11:41:57','2026-05-08 11:41:57'),(847,96,NULL,NULL,'DEPOSIT',300000,25000000,NULL,'2026-04-18 11:41:57','2026-05-08 11:41:57'),(848,95,NULL,NULL,'DEPOSIT',300000,32000000,NULL,'2026-04-18 11:41:57','2026-05-08 11:41:57'),(849,94,NULL,NULL,'DEPOSIT',300000,15000000,NULL,'2026-04-18 11:41:57','2026-05-08 11:41:57'),(877,103,NULL,NULL,'WITHDRAWAL',500000,95000000,NULL,'2026-05-07 11:42:00','2026-05-08 11:42:00'),(878,102,NULL,NULL,'WITHDRAWAL',500000,150000000,NULL,'2026-05-07 11:42:00','2026-05-08 11:42:00'),(879,101,NULL,NULL,'WITHDRAWAL',500000,55000000,NULL,'2026-05-07 11:42:00','2026-05-08 11:42:00'),(880,100,NULL,NULL,'WITHDRAWAL',500000,120000000,NULL,'2026-05-07 11:42:00','2026-05-08 11:42:00'),(881,99,NULL,NULL,'WITHDRAWAL',500000,80000000,NULL,'2026-05-07 11:42:00','2026-05-08 11:42:00'),(882,103,NULL,NULL,'WITHDRAWAL',500000,95000000,NULL,'2026-05-06 11:42:00','2026-05-08 11:42:00'),(883,102,NULL,NULL,'WITHDRAWAL',500000,150000000,NULL,'2026-05-06 11:42:00','2026-05-08 11:42:00'),(884,101,NULL,NULL,'WITHDRAWAL',500000,55000000,NULL,'2026-05-06 11:42:00','2026-05-08 11:42:00'),(885,100,NULL,NULL,'WITHDRAWAL',500000,120000000,NULL,'2026-05-06 11:42:00','2026-05-08 11:42:00'),(886,99,NULL,NULL,'WITHDRAWAL',500000,80000000,NULL,'2026-05-06 11:42:00','2026-05-08 11:42:00'),(887,103,NULL,NULL,'WITHDRAWAL',500000,95000000,NULL,'2026-05-05 11:42:00','2026-05-08 11:42:00'),(888,102,NULL,NULL,'WITHDRAWAL',500000,150000000,NULL,'2026-05-05 11:42:00','2026-05-08 11:42:00'),(889,101,NULL,NULL,'WITHDRAWAL',500000,55000000,NULL,'2026-05-05 11:42:00','2026-05-08 11:42:00'),(890,100,NULL,NULL,'WITHDRAWAL',500000,120000000,NULL,'2026-05-05 11:42:00','2026-05-08 11:42:00'),(891,99,NULL,NULL,'WITHDRAWAL',500000,80000000,NULL,'2026-05-05 11:42:00','2026-05-08 11:42:00'),(892,103,NULL,NULL,'WITHDRAWAL',500000,95000000,NULL,'2026-05-04 11:42:00','2026-05-08 11:42:00'),(893,102,NULL,NULL,'WITHDRAWAL',500000,150000000,NULL,'2026-05-04 11:42:00','2026-05-08 11:42:00'),(894,101,NULL,NULL,'WITHDRAWAL',500000,55000000,NULL,'2026-05-04 11:42:00','2026-05-08 11:42:00'),(895,100,NULL,NULL,'WITHDRAWAL',500000,120000000,NULL,'2026-05-04 11:42:00','2026-05-08 11:42:00'),(896,99,NULL,NULL,'WITHDRAWAL',500000,80000000,NULL,'2026-05-04 11:42:00','2026-05-08 11:42:00'),(897,103,NULL,NULL,'WITHDRAWAL',500000,95000000,NULL,'2026-05-03 11:42:00','2026-05-08 11:42:00'),(898,102,NULL,NULL,'WITHDRAWAL',500000,150000000,NULL,'2026-05-03 11:42:00','2026-05-08 11:42:00'),(899,101,NULL,NULL,'WITHDRAWAL',500000,55000000,NULL,'2026-05-03 11:42:00','2026-05-08 11:42:00'),(900,100,NULL,NULL,'WITHDRAWAL',500000,120000000,NULL,'2026-05-03 11:42:00','2026-05-08 11:42:00'),(901,99,NULL,NULL,'WITHDRAWAL',500000,80000000,NULL,'2026-05-03 11:42:00','2026-05-08 11:42:00'),(908,108,NULL,NULL,'TRANSFER',5000000,1000000000,NULL,'2026-05-07 11:42:03','2026-05-08 11:42:03'),(909,107,NULL,NULL,'TRANSFER',5000000,500000000,NULL,'2026-05-07 11:42:03','2026-05-08 11:42:03'),(910,106,NULL,NULL,'TRANSFER',5000000,800000000,NULL,'2026-05-07 11:42:03','2026-05-08 11:42:03'),(911,105,NULL,NULL,'TRANSFER',5000000,150000000,NULL,'2026-05-07 11:42:03','2026-05-08 11:42:03'),(912,104,NULL,NULL,'TRANSFER',5000000,300000000,NULL,'2026-05-07 11:42:03','2026-05-08 11:42:03'),(913,108,NULL,NULL,'TRANSFER',5000000,1000000000,NULL,'2026-05-06 11:42:03','2026-05-08 11:42:03'),(914,107,NULL,NULL,'TRANSFER',5000000,500000000,NULL,'2026-05-06 11:42:03','2026-05-08 11:42:03'),(915,106,NULL,NULL,'TRANSFER',5000000,800000000,NULL,'2026-05-06 11:42:03','2026-05-08 11:42:03'),(916,105,NULL,NULL,'TRANSFER',5000000,150000000,NULL,'2026-05-06 11:42:03','2026-05-08 11:42:03'),(917,104,NULL,NULL,'TRANSFER',5000000,300000000,NULL,'2026-05-06 11:42:03','2026-05-08 11:42:03'),(918,108,NULL,NULL,'TRANSFER',5000000,1000000000,NULL,'2026-05-05 11:42:03','2026-05-08 11:42:03'),(919,107,NULL,NULL,'TRANSFER',5000000,500000000,NULL,'2026-05-05 11:42:03','2026-05-08 11:42:03'),(920,106,NULL,NULL,'TRANSFER',5000000,800000000,NULL,'2026-05-05 11:42:03','2026-05-08 11:42:03'),(921,105,NULL,NULL,'TRANSFER',5000000,150000000,NULL,'2026-05-05 11:42:03','2026-05-08 11:42:03'),(922,104,NULL,NULL,'TRANSFER',5000000,300000000,NULL,'2026-05-05 11:42:03','2026-05-08 11:42:03'),(923,108,NULL,NULL,'TRANSFER',5000000,1000000000,NULL,'2026-05-04 11:42:03','2026-05-08 11:42:03'),(924,107,NULL,NULL,'TRANSFER',5000000,500000000,NULL,'2026-05-04 11:42:03','2026-05-08 11:42:03'),(925,106,NULL,NULL,'TRANSFER',5000000,800000000,NULL,'2026-05-04 11:42:03','2026-05-08 11:42:03'),(926,105,NULL,NULL,'TRANSFER',5000000,150000000,NULL,'2026-05-04 11:42:03','2026-05-08 11:42:03'),(927,104,NULL,NULL,'TRANSFER',5000000,300000000,NULL,'2026-05-04 11:42:03','2026-05-08 11:42:03'),(928,108,NULL,NULL,'TRANSFER',5000000,1000000000,NULL,'2026-05-03 11:42:03','2026-05-08 11:42:03'),(929,107,NULL,NULL,'TRANSFER',5000000,500000000,NULL,'2026-05-03 11:42:03','2026-05-08 11:42:03'),(930,106,NULL,NULL,'TRANSFER',5000000,800000000,NULL,'2026-05-03 11:42:03','2026-05-08 11:42:03'),(931,105,NULL,NULL,'TRANSFER',5000000,150000000,NULL,'2026-05-03 11:42:03','2026-05-08 11:42:03'),(932,104,NULL,NULL,'TRANSFER',5000000,300000000,NULL,'2026-05-03 11:42:03','2026-05-08 11:42:03'),(933,108,NULL,NULL,'TRANSFER',5000000,1000000000,NULL,'2026-05-02 11:42:03','2026-05-08 11:42:03'),(934,107,NULL,NULL,'TRANSFER',5000000,500000000,NULL,'2026-05-02 11:42:03','2026-05-08 11:42:03'),(935,106,NULL,NULL,'TRANSFER',5000000,800000000,NULL,'2026-05-02 11:42:03','2026-05-08 11:42:03'),(936,105,NULL,NULL,'TRANSFER',5000000,150000000,NULL,'2026-05-02 11:42:03','2026-05-08 11:42:03'),(937,104,NULL,NULL,'TRANSFER',5000000,300000000,NULL,'2026-05-02 11:42:03','2026-05-08 11:42:03'),(938,108,NULL,NULL,'TRANSFER',5000000,1000000000,NULL,'2026-05-01 11:42:03','2026-05-08 11:42:03'),(939,107,NULL,NULL,'TRANSFER',5000000,500000000,NULL,'2026-05-01 11:42:03','2026-05-08 11:42:03'),(940,106,NULL,NULL,'TRANSFER',5000000,800000000,NULL,'2026-05-01 11:42:03','2026-05-08 11:42:03'),(941,105,NULL,NULL,'TRANSFER',5000000,150000000,NULL,'2026-05-01 11:42:03','2026-05-08 11:42:03'),(942,104,NULL,NULL,'TRANSFER',5000000,300000000,NULL,'2026-05-01 11:42:03','2026-05-08 11:42:03'),(943,108,NULL,NULL,'TRANSFER',5000000,1000000000,NULL,'2026-04-30 11:42:03','2026-05-08 11:42:03'),(944,107,NULL,NULL,'TRANSFER',5000000,500000000,NULL,'2026-04-30 11:42:03','2026-05-08 11:42:03'),(945,106,NULL,NULL,'TRANSFER',5000000,800000000,NULL,'2026-04-30 11:42:03','2026-05-08 11:42:03'),(946,105,NULL,NULL,'TRANSFER',5000000,150000000,NULL,'2026-04-30 11:42:03','2026-05-08 11:42:03'),(947,104,NULL,NULL,'TRANSFER',5000000,300000000,NULL,'2026-04-30 11:42:03','2026-05-08 11:42:03'),(948,108,NULL,NULL,'TRANSFER',5000000,1000000000,NULL,'2026-04-29 11:42:03','2026-05-08 11:42:03'),(949,107,NULL,NULL,'TRANSFER',5000000,500000000,NULL,'2026-04-29 11:42:03','2026-05-08 11:42:03'),(950,106,NULL,NULL,'TRANSFER',5000000,800000000,NULL,'2026-04-29 11:42:03','2026-05-08 11:42:03'),(951,105,NULL,NULL,'TRANSFER',5000000,150000000,NULL,'2026-04-29 11:42:03','2026-05-08 11:42:03'),(952,104,NULL,NULL,'TRANSFER',5000000,300000000,NULL,'2026-04-29 11:42:03','2026-05-08 11:42:03'),(953,108,NULL,NULL,'TRANSFER',5000000,1000000000,NULL,'2026-04-28 11:42:03','2026-05-08 11:42:03'),(954,107,NULL,NULL,'TRANSFER',5000000,500000000,NULL,'2026-04-28 11:42:03','2026-05-08 11:42:03'),(955,106,NULL,NULL,'TRANSFER',5000000,800000000,NULL,'2026-04-28 11:42:03','2026-05-08 11:42:03'),(956,105,NULL,NULL,'TRANSFER',5000000,150000000,NULL,'2026-04-28 11:42:03','2026-05-08 11:42:03'),(957,104,NULL,NULL,'TRANSFER',5000000,300000000,NULL,'2026-04-28 11:42:03','2026-05-08 11:42:03'),(958,114,2757,NULL,'WITHDRAW_AUTO',300000,4700000,'적금 5월분 자동이체','2026-05-23 13:39:19','2026-05-23 13:39:19'),(959,115,2757,NULL,'DEPOSIT_AUTO',300000,2100000,'적금 5월분 자동이체','2026-05-23 13:39:19','2026-05-23 13:39:19');
/*!40000 ALTER TABLE `transaction_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_type` varchar(25) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `resident_number` varchar(100) NOT NULL,
  `identification_number` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `gender` enum('MALE','FEMALE') DEFAULT NULL,
  `age` varchar(20) DEFAULT NULL,
  `grade` varchar(20) DEFAULT NULL,
  `is_terms_agreed` tinyint(1) NOT NULL DEFAULT '0' COMMENT '필수 약관 전체 동의 여부',
  PRIMARY KEY (`id`),
  UNIQUE KEY `resident_number` (`resident_number`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `identification_number` (`identification_number`)
) ENGINE=InnoDB AUTO_INCREMENT=2760 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (9,'admin','관리자','admin@admin.com','xBrtX6gIt3V3xqyiXokbVg==',NULL,'01012345678','$2a$10$oCOZ1QXr3H29TJXh67cMG.26TvfulBcX0FddLzNWJbPdn0ovtWUwO','MALE','36',NULL,0),(2732,'customer','김민준','test01@test.com','xcVbSBGUweUbZm6uugvjrA==',NULL,'010-1001-0001','$2a$10$kK.m/7gRhBpdKqyb0mFOSOgSdUj0qu/EXJpLULcnqfh.rMq7ddDLO','MALE','26',NULL,0),(2733,'customer','이서연','test02@test.com','/wXsp7g73tfNzyUrIHLKxg==',NULL,'010-1001-0002','$2a$10$uRA3U9oAAhcHPt3Zm6eUKuA5YksmmVnYrbqsvRhcPq5Ex5pZAK9B6','FEMALE','24',NULL,0),(2734,'customer','박지호','test03@test.com','j1tvQGCLQLtmHGu7kWmwWQ==',NULL,'010-1001-0003','$2a$10$oWXc0Nqxq9jZhjVthFyoh.Hta3/4jVUbCYgBYXoypssdQrVNhu/IW','MALE','28',NULL,0),(2735,'customer','최수아','test04@test.com','rFgtq8jw18FeaXBQJKYa8w==',NULL,'010-1001-0004','$2a$10$Q6YNENeNhT9sFwnkRpCoHeZXk0LcDU/pAJUIGUJoIVkIQ9bI/iNbG','FEMALE','25',NULL,0),(2736,'customer','정태양','test05@test.com','uj0MsLNwc8TnXkt0DMx3vw==',NULL,'010-1001-0005','$2a$10$A3CAZHVjROgM395zv1ZTdeNcKb8UmONSNVlN3NDISsrbh9P/eFB1q','MALE','27',NULL,0),(2737,'customer','강동훈','test06@test.com','NHvza0c6/4T7eVrIYn8SEg==',NULL,'010-1001-0006','$2a$10$8I4E4J/fcrLDlS2PLFwGEeLN4dPOgadzMEXxkiLlzoES9OciquFda','MALE','36',NULL,0),(2738,'customer','윤미래','test07@test.com','fv9BF6VZ4yF/xc95usnxWw==',NULL,'010-1001-0007','$2a$10$yTY5YaBXw3z5FBY6xKZacuiXacgA9moahGTpXar2UkpEMGDUpJpBi','FEMALE','39',NULL,0),(2739,'customer','임성준','test08@test.com','FyACxwWwpf6K6NdNrWMk3A==',NULL,'010-1001-0008','$2a$10$g8jz0aOT4J1vy/rTdVMa/OKCA3E4hgnVYFlUXqCz4QQNOHE.0OEAq','MALE','43',NULL,0),(2740,'customer','한지은','test09@test.com','A36tVGmbMAimV83vBYp0gA==',NULL,'010-1001-0009','$2a$10$rgz5PVhDqIt/9Gmp49kRROTmbrN1T4pHtrLXo3K4p4DYyjOjghd1.','FEMALE','41',NULL,0),(2741,'customer','오준혁','test10@test.com','+3YusdxEZkCzvis/25mwMg==',NULL,'010-1001-0010','$2a$10$TBW/frqY8hJTvMsRmpzr0.GW.BpgIzkR5KgxVdXh/xo1SXcA2gRI6','MALE','37',NULL,0),(2742,'customer','신영호','test11@test.com','u9LSCdU0lGhXItCDHW+YYQ==',NULL,'010-1001-0011','$2a$10$t9f2ReZf7O0W.MgME1le3.WMB9u4Eo5wbYGWfQ29aBNHkl5yladlC','MALE','56',NULL,0),(2743,'customer','배미숙','test12@test.com','XuV7D3CkD5cHLXcMZHHwdg==',NULL,'010-1001-0012','$2a$10$TyLZiyQeCrC66gP1OZh2HepJY8WRxZP.eHlSoLayuq1ZVLOJBah7C','FEMALE','63',NULL,0),(2744,'customer','조현수','test13@test.com','ImLW7v1FKNEI+2DkbJG9Ew==',NULL,'010-1001-0013','$2a$10$44k6qhxxy0F/rQZaBnqRpuhcRfYs9R7lXNHq1F.d84Rha/Tu7mLPC','MALE','59',NULL,0),(2745,'customer','노은주','test14@test.com','z60qyG5mTmaBcl5Cmgi5UQ==',NULL,'010-1001-0014','$2a$10$YXxw5m/BdGUQ1BJe5u/teeE0pJ12OBjhe5FLAM/WMlpXc5pBVXZIi','FEMALE','66',NULL,0),(2746,'customer','문철수','test15@test.com','aypw5b/C1iJcosg2LfzlwA==',NULL,'010-1001-0015','$2a$10$NmaqqHE3taYsCrfT4RvfAuy79vLHDfZg7BtagutV1uGJwuFZRfrS6','MALE','71',NULL,0),(2747,'corporate','(주)한국테크','corp01@test.com','FAcvGzrybxp2x1qcHqgYvQ==','123-81-00001','02-9001-0001','$2a$10$aB5BuOBthNP9qAkfZPQZoeuDFraZWQZ.QCaZ8/AcP/HAiwoYPjpBG','MALE','45',NULL,0),(2748,'corporate','(주)서울상사','corp02@test.com','nuuO7RlYR3oYhhlqHo4apQ==','234-81-00002','02-9001-0002','$2a$10$xNtPZcH83p.4VEZ/RtSWx.xASLp6CGlx4bUvo5Gc.Gtcfoy4B3ex.','MALE','50',NULL,0),(2749,'corporate','(주)미래건설','corp03@test.com','zBVhctxvPipNp/W/3Z2kcw==','345-81-00003','02-9001-0003','$2a$10$dq.QQ1F/STZEVImvy2uzLemcghk4eNJg94XMTYi96w/WYtJMWLBDK','MALE','48',NULL,0),(2751,'corporate','(주)글로벌통상','corp04@test.com','UvZb6aYhlz3iG3yO7ebybA==','456-81-00004','02-9001-0004','$2a$10$6daYIP33dsSG4cFISBTG/uzLsWc7YmVArCogv7yBAejWTtGZN4fKK','MALE','52',NULL,0),(2752,'corporate','(주)동방기업','corp05@test.com','dpVMAsu3/xeOlsFvZFpMzg==','567-81-00005','02-9001-0005','$2a$10$5S.O7vkjT73MJ846NNCOQ.GuRYdb/WRpQx72MzVibHmmLXCA6pTim','MALE','60',NULL,0),(2754,'corporate','(주)테스트','corp06@test.com','tf77uhTZHHAS6URbt6xABw==','527-82-00004','02-9001-0213','$2a$10$gl5eYBT/R1NXRS/AVfKC..v4qNFtbgHDF7ZpZYWyAYhGTDcyDUb.e','MALE','56',NULL,1),(2757,'customer','김적금','savings01@test.com','neATosZlpTZaLQ269dwELQ==',NULL,'01000000010','$2a$10$Em8y/FVdiFTzTyGBLso/XuY9RMkboDkbp2wSnJcJdOdc2Sf2kHD06','FEMALE','29',NULL,1);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_pin`
--

DROP TABLE IF EXISTS `user_pin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_pin` (
  `pin_id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `pin_hash` varchar(255) NOT NULL,
  `fail_count` int NOT NULL DEFAULT '0',
  `locked_until` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`pin_id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `fk_pin_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_pin`
--

LOCK TABLES `user_pin` WRITE;
/*!40000 ALTER TABLE `user_pin` DISABLE KEYS */;
INSERT INTO `user_pin` VALUES (13,9,'$2b$10$B7BfLiYalBiU9VB4oVwx5.YoGutaUAY5DC7LDq63OJpsZNQLySAca',0,NULL,'2026-05-19 17:23:38'),(14,2747,'$2b$10$B7BfLiYalBiU9VB4oVwx5.YoGutaUAY5DC7LDq63OJpsZNQLySAca',0,NULL,'2026-05-19 17:23:38'),(15,2748,'$2b$10$B7BfLiYalBiU9VB4oVwx5.YoGutaUAY5DC7LDq63OJpsZNQLySAca',0,NULL,'2026-05-19 17:23:38'),(16,2749,'$2b$10$B7BfLiYalBiU9VB4oVwx5.YoGutaUAY5DC7LDq63OJpsZNQLySAca',0,NULL,'2026-05-19 17:23:38'),(17,2751,'$2b$10$B7BfLiYalBiU9VB4oVwx5.YoGutaUAY5DC7LDq63OJpsZNQLySAca',0,NULL,'2026-05-19 17:23:38'),(18,2752,'$2b$10$B7BfLiYalBiU9VB4oVwx5.YoGutaUAY5DC7LDq63OJpsZNQLySAca',0,NULL,'2026-05-19 17:23:38'),(19,2754,'$2b$10$B7BfLiYalBiU9VB4oVwx5.YoGutaUAY5DC7LDq63OJpsZNQLySAca',0,NULL,'2026-05-19 17:23:38'),(23,2732,'$2b$10$B7BfLiYalBiU9VB4oVwx5.YoGutaUAY5DC7LDq63OJpsZNQLySAca',0,NULL,'2026-05-19 17:23:38'),(24,2733,'$2b$10$B7BfLiYalBiU9VB4oVwx5.YoGutaUAY5DC7LDq63OJpsZNQLySAca',0,NULL,'2026-05-19 17:23:38'),(25,2734,'$2b$10$B7BfLiYalBiU9VB4oVwx5.YoGutaUAY5DC7LDq63OJpsZNQLySAca',0,NULL,'2026-05-19 17:23:38'),(26,2735,'$2b$10$B7BfLiYalBiU9VB4oVwx5.YoGutaUAY5DC7LDq63OJpsZNQLySAca',0,NULL,'2026-05-19 17:23:38'),(27,2736,'$2b$10$B7BfLiYalBiU9VB4oVwx5.YoGutaUAY5DC7LDq63OJpsZNQLySAca',0,NULL,'2026-05-19 17:23:38'),(28,2737,'$2b$10$B7BfLiYalBiU9VB4oVwx5.YoGutaUAY5DC7LDq63OJpsZNQLySAca',0,NULL,'2026-05-19 17:23:38'),(29,2738,'$2b$10$B7BfLiYalBiU9VB4oVwx5.YoGutaUAY5DC7LDq63OJpsZNQLySAca',0,NULL,'2026-05-19 17:23:38'),(30,2739,'$2b$10$B7BfLiYalBiU9VB4oVwx5.YoGutaUAY5DC7LDq63OJpsZNQLySAca',0,NULL,'2026-05-19 17:23:38'),(31,2740,'$2b$10$B7BfLiYalBiU9VB4oVwx5.YoGutaUAY5DC7LDq63OJpsZNQLySAca',0,NULL,'2026-05-19 17:23:38'),(33,2741,'$2b$10$B7BfLiYalBiU9VB4oVwx5.YoGutaUAY5DC7LDq63OJpsZNQLySAca',0,NULL,'2026-05-19 17:23:38'),(34,2742,'$2b$10$B7BfLiYalBiU9VB4oVwx5.YoGutaUAY5DC7LDq63OJpsZNQLySAca',0,NULL,'2026-05-19 17:23:38'),(35,2743,'$2b$10$B7BfLiYalBiU9VB4oVwx5.YoGutaUAY5DC7LDq63OJpsZNQLySAca',0,NULL,'2026-05-19 17:23:38'),(36,2744,'$2b$10$B7BfLiYalBiU9VB4oVwx5.YoGutaUAY5DC7LDq63OJpsZNQLySAca',0,NULL,'2026-05-19 17:23:38'),(37,2745,'$2b$10$B7BfLiYalBiU9VB4oVwx5.YoGutaUAY5DC7LDq63OJpsZNQLySAca',0,NULL,'2026-05-19 17:23:38'),(38,2746,'$2b$10$B7BfLiYalBiU9VB4oVwx5.YoGutaUAY5DC7LDq63OJpsZNQLySAca',0,NULL,'2026-05-19 17:23:38');
/*!40000 ALTER TABLE `user_pin` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-23 20:13:33
