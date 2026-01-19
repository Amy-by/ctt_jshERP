-- MySQL dump 10.13  Distrib 8.0.44, for Linux (x86_64)
--
-- Host: localhost    Database: jsh_erp
-- ------------------------------------------------------
-- Server version	8.0.44-0ubuntu0.22.04.2

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
-- Table structure for table `jsh_account`
--

DROP TABLE IF EXISTS `jsh_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jsh_account` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '名称',
  `serial_no` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '编号',
  `initial_amount` decimal(24,6) DEFAULT NULL COMMENT '期初金额',
  `current_amount` decimal(24,6) DEFAULT NULL COMMENT '当前余额',
  `remark` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '备注',
  `enabled` bit(1) DEFAULT NULL COMMENT '启用',
  `sort` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '排序',
  `is_default` bit(1) DEFAULT NULL COMMENT '是否默认',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `delete_flag` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '0' COMMENT '删除标记，0未删除，1删除',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='账户信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jsh_account`
--

LOCK TABLES `jsh_account` WRITE;
/*!40000 ALTER TABLE `jsh_account` DISABLE KEYS */;
INSERT INTO `jsh_account` VALUES (17,'账户1','zzz111',100.000000,829.000000,'aabb',_binary '',NULL,_binary '',63,'0'),(18,'账户2','1234131324',200.000000,-1681.000000,'bbbb',_binary '',NULL,_binary '\0',63,'0'),(24,'银行存款','6222020100012345678',100000.000000,100000.000000,NULL,_binary '',NULL,_binary '',63,'0'),(25,'现金','CASH001',5000.000000,5000.000000,NULL,_binary '',NULL,_binary '\0',63,'0'),(26,'支付宝','ALIPAY001',20000.000000,20000.000000,NULL,_binary '',NULL,_binary '\0',63,'0'),(27,'账户3',NULL,0.000000,NULL,NULL,_binary '\0',NULL,_binary '\0',63,'1');
/*!40000 ALTER TABLE `jsh_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jsh_account_head`
--

DROP TABLE IF EXISTS `jsh_account_head`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jsh_account_head` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `type` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '类型(支出/收入/收款/付款/转账)',
  `organ_id` bigint DEFAULT NULL COMMENT '单位Id(收款/付款单位)',
  `hands_person_id` bigint DEFAULT NULL COMMENT '经手人id',
  `creator` bigint DEFAULT NULL COMMENT '操作员',
  `change_amount` decimal(24,6) DEFAULT NULL COMMENT '变动金额(优惠/收款/付款/实付)',
  `discount_money` decimal(24,6) DEFAULT NULL COMMENT '优惠金额',
  `total_price` decimal(24,6) DEFAULT NULL COMMENT '合计金额',
  `account_id` bigint DEFAULT NULL COMMENT '账户(收款/付款)',
  `bill_no` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '单据编号',
  `bill_time` datetime DEFAULT NULL COMMENT '单据日期',
  `remark` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '备注',
  `file_name` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '附件名称',
  `status` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '状态，0未审核、1已审核、9审核中',
  `source` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '0' COMMENT '单据来源，0-pc，1-手机',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `delete_flag` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '0' COMMENT '删除标记，0未删除，1删除',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK9F4C0D8DB610FC06` (`organ_id`) USING BTREE,
  KEY `FK9F4C0D8DAAE50527` (`account_id`) USING BTREE,
  KEY `FK9F4C0D8DC4170B37` (`hands_person_id`) USING BTREE,
  KEY `bill_no` (`bill_no`) USING BTREE,
  KEY `tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=133 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='财务主表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jsh_account_head`
--

LOCK TABLES `jsh_account_head` WRITE;
/*!40000 ALTER TABLE `jsh_account_head` DISABLE KEYS */;
INSERT INTO `jsh_account_head` VALUES (127,'收入',93,NULL,63,290.000000,NULL,290.000000,17,'SR00000000693','2026-01-19 08:46:01',NULL,NULL,'1','0',63,'0'),(128,'支出',NULL,NULL,63,-30.000000,NULL,-30.000000,17,'ZC00000000694','2026-01-19 08:46:21',NULL,NULL,'1','0',63,'0'),(129,'收款',94,NULL,63,0.000000,0.000000,0.000000,17,'SK00000000695','2026-01-19 08:46:32',NULL,NULL,'1','0',63,'0'),(130,'付款',93,NULL,63,0.000000,0.000000,0.000000,17,'FK00000000696','2026-01-19 08:46:56',NULL,NULL,'1','0',63,'0'),(131,'转账',NULL,NULL,63,-5000.000000,NULL,-5000.000000,17,'ZZ00000000697','2026-01-19 08:47:13',NULL,NULL,'1','0',63,'0'),(132,'收预付款',60,NULL,63,12.000000,NULL,12.000000,NULL,'SYF00000000698','2026-01-19 08:47:32',NULL,NULL,'1','0',63,'0');
/*!40000 ALTER TABLE `jsh_account_head` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jsh_account_item`
--

DROP TABLE IF EXISTS `jsh_account_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jsh_account_item` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `header_id` bigint NOT NULL COMMENT '表头Id',
  `account_id` bigint DEFAULT NULL COMMENT '账户Id',
  `in_out_item_id` bigint DEFAULT NULL COMMENT '收支项目Id',
  `bill_id` bigint DEFAULT NULL COMMENT '单据id',
  `need_debt` decimal(24,6) DEFAULT NULL COMMENT '应收欠款',
  `finish_debt` decimal(24,6) DEFAULT NULL COMMENT '已收欠款',
  `each_amount` decimal(24,6) DEFAULT NULL COMMENT '单项金额',
  `remark` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '单据备注',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `delete_flag` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '0' COMMENT '删除标记，0未删除，1删除',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK9F4CBAC0AAE50527` (`account_id`) USING BTREE,
  KEY `FK9F4CBAC0C5FE6007` (`header_id`) USING BTREE,
  KEY `FK9F4CBAC0D203EDC5` (`in_out_item_id`) USING BTREE,
  KEY `bill_id` (`bill_id`) USING BTREE,
  KEY `tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=159 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='财务子表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jsh_account_item`
--

LOCK TABLES `jsh_account_item` WRITE;
/*!40000 ALTER TABLE `jsh_account_item` DISABLE KEYS */;
INSERT INTO `jsh_account_item` VALUES (152,127,NULL,23,NULL,NULL,NULL,290.000000,'',63,'0'),(153,128,NULL,21,NULL,NULL,NULL,30.000000,'',63,'0'),(154,129,NULL,NULL,NULL,0.000000,0.000000,0.000000,'',63,'0'),(155,130,NULL,NULL,NULL,0.000000,0.000000,0.000000,'',63,'0'),(157,131,24,NULL,NULL,NULL,NULL,5000.000000,'',63,'0'),(158,132,25,NULL,NULL,NULL,NULL,12.000000,'',63,'0');
/*!40000 ALTER TABLE `jsh_account_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jsh_depot`
--

DROP TABLE IF EXISTS `jsh_depot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jsh_depot` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '仓库名称',
  `address` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '仓库地址',
  `warehousing` decimal(24,6) DEFAULT NULL COMMENT '仓储费',
  `truckage` decimal(24,6) DEFAULT NULL COMMENT '搬运费',
  `type` int DEFAULT NULL COMMENT '类型',
  `sort` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '排序',
  `remark` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '描述',
  `principal` bigint DEFAULT NULL COMMENT '负责人',
  `enabled` bit(1) DEFAULT NULL COMMENT '启用',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `delete_Flag` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '0' COMMENT '删除标记，0未删除，1删除',
  `is_default` bit(1) DEFAULT NULL COMMENT '是否默认',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='仓库表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jsh_depot`
--

LOCK TABLES `jsh_depot` WRITE;
/*!40000 ALTER TABLE `jsh_depot` DISABLE KEYS */;
INSERT INTO `jsh_depot` VALUES (1,'样本仓库','园区A栋1楼',NULL,NULL,NULL,'1','主要存储',NULL,_binary '',63,'0',NULL),(2,'备用仓库','园区B栋2楼',NULL,NULL,NULL,'2','备用存储',NULL,_binary '',63,'0',NULL),(3,'成品仓库','园区C栋3楼',NULL,NULL,NULL,'3','成品存储',NULL,_binary '',63,'0',NULL),(14,'仓库1','dizhi',12.000000,12.000000,0,'1','描述',131,_binary '',63,'0',_binary ''),(15,'仓库2','地址100',555.000000,666.000000,0,'2','dfdf',131,_binary '',63,'0',_binary '\0'),(17,'仓库3','123123',123.000000,123.000000,0,'3','123',131,_binary '',63,'1',_binary '\0'),(19,'主仓库','北京市朝阳区',NULL,NULL,1,'1',NULL,NULL,_binary '',63,'0',_binary ''),(20,'零售仓库','北京市海淀区',NULL,NULL,2,'2',NULL,NULL,_binary '',63,'0',_binary '\0'),(21,'样本仓库','北京市西城区',NULL,NULL,3,'3',NULL,NULL,_binary '\0',63,'0',_binary '\0'),(22,'测试仓库',NULL,NULL,NULL,0,NULL,NULL,NULL,_binary '',63,'0',_binary '\0'),(23,'44',NULL,NULL,NULL,0,NULL,NULL,NULL,_binary '',63,'0',_binary '\0');
/*!40000 ALTER TABLE `jsh_depot` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jsh_depot_head`
--

DROP TABLE IF EXISTS `jsh_depot_head`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jsh_depot_head` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `type` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '类型(出库/入库)',
  `sub_type` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '出入库分类',
  `default_number` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '初始票据号',
  `number` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '票据号',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `oper_time` datetime DEFAULT NULL COMMENT '出入库时间',
  `organ_id` bigint DEFAULT NULL COMMENT '供应商id',
  `creator` bigint DEFAULT NULL COMMENT '操作员',
  `account_id` bigint DEFAULT NULL COMMENT '账户id',
  `change_amount` decimal(24,6) DEFAULT NULL COMMENT '变动金额(收款/付款)',
  `back_amount` decimal(24,6) DEFAULT NULL COMMENT '找零金额',
  `total_price` decimal(24,6) DEFAULT NULL COMMENT '合计金额',
  `pay_type` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '付款类型(现金、记账等)',
  `bill_type` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '单据类型',
  `remark` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '备注',
  `file_name` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '附件名称',
  `sales_man` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '销售员（可以多个）',
  `account_id_list` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '多账户ID列表',
  `account_money_list` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '多账户金额列表',
  `discount` decimal(24,6) DEFAULT NULL COMMENT '优惠率',
  `discount_money` decimal(24,6) DEFAULT NULL COMMENT '优惠金额',
  `discount_last_money` decimal(24,6) DEFAULT NULL COMMENT '优惠后金额',
  `other_money` decimal(24,6) DEFAULT NULL COMMENT '销售或采购费用合计',
  `deposit` decimal(24,6) DEFAULT NULL COMMENT '订金',
  `status` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '状态，0未审核、1已审核、2完成采购|销售、3部分采购|销售、9审核中',
  `purchase_status` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '采购状态，0未采购、2完成采购、3部分采购',
  `source` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '0' COMMENT '单据来源，0-pc，1-手机',
  `link_number` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '关联订单号',
  `link_apply` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '关联请购单',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `delete_flag` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '0' COMMENT '删除标记，0未删除，1删除',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK2A80F214B610FC06` (`organ_id`) USING BTREE,
  KEY `FK2A80F214AAE50527` (`account_id`) USING BTREE,
  KEY `number` (`number`) USING BTREE,
  KEY `link_number` (`link_number`) USING BTREE,
  KEY `creator` (`creator`) USING BTREE,
  KEY `tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=326 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='单据主表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jsh_depot_head`
--

LOCK TABLES `jsh_depot_head` WRITE;
/*!40000 ALTER TABLE `jsh_depot_head` DISABLE KEYS */;
INSERT INTO `jsh_depot_head` VALUES (1,'采购入库',NULL,NULL,'CGRK20260116001','2026-01-15 22:21:42','2026-01-15 22:21:42',NULL,2,NULL,NULL,NULL,15000.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,'0',NULL,NULL,63,'0'),(2,'销售出库',NULL,NULL,'XSCK20260116001','2026-01-15 22:21:42','2026-01-15 22:21:42',NULL,3,NULL,NULL,NULL,25000.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,'0',NULL,NULL,63,'0'),(3,'生产入库',NULL,NULL,'SCRK20260116001','2026-01-15 22:21:42','2026-01-15 22:21:42',NULL,4,NULL,NULL,NULL,8000.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,'0',NULL,NULL,63,'0'),(4,'生产领料',NULL,NULL,'SCLL20260116001','2026-01-15 22:21:42','2026-01-15 22:21:42',NULL,4,NULL,NULL,NULL,3000.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,'0',NULL,NULL,63,'0'),(101,'出库','零售',NULL,'LS20260116001','2026-01-15 22:55:14','2026-01-15 22:55:14',NULL,63,NULL,NULL,NULL,15000.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,'0',NULL,NULL,63,'0'),(102,'出库','零售',NULL,'LS20260116002','2026-01-15 22:55:14','2026-01-15 22:55:14',NULL,63,NULL,NULL,NULL,25000.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,'0',NULL,NULL,63,'0'),(103,'出库','零售',NULL,'LS20260116003','2026-01-15 22:55:14','2026-01-15 22:55:14',NULL,63,NULL,NULL,NULL,8000.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,'0',NULL,NULL,63,'0'),(201,'采购入库','采购入库',NULL,'CG20260116001','2026-01-15 22:55:37','2026-01-15 22:55:37',NULL,63,NULL,NULL,NULL,10000.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,'0',NULL,NULL,63,'0'),(202,'采购入库','采购入库',NULL,'CG20260116002','2026-01-15 22:55:37','2026-01-15 22:55:37',NULL,63,NULL,NULL,NULL,15000.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,'0',NULL,NULL,63,'0'),(203,'采购入库','采购入库',NULL,'CG20260116003','2026-01-15 22:55:37','2026-01-15 22:55:37',NULL,63,NULL,NULL,NULL,20000.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,'0',NULL,NULL,63,'0'),(301,'销售出库','销售出库',NULL,'XS20260116001','2026-01-15 22:56:13','2026-01-15 22:56:13',NULL,63,NULL,NULL,NULL,25000.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,'0',NULL,NULL,63,'0'),(302,'销售出库','销售出库',NULL,'XS20260116002','2026-01-15 22:56:13','2026-01-15 22:56:13',NULL,63,NULL,NULL,NULL,30000.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,'0',NULL,NULL,63,'0'),(303,'销售出库','销售出库',NULL,'XS20260116003','2026-01-15 22:56:13','2026-01-15 22:56:13',NULL,63,NULL,NULL,NULL,40000.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,'0',NULL,NULL,63,'0'),(304,'采购入库','普通采购',NULL,'CG20260116001','2026-01-16 01:22:10','2026-01-16 01:22:10',NULL,63,NULL,NULL,NULL,50000.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,'0',NULL,NULL,63,'0'),(305,'销售出库','普通销售',NULL,'XS20260116001','2026-01-16 01:22:10','2026-01-16 01:22:10',NULL,63,NULL,NULL,NULL,30000.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,'0',NULL,NULL,63,'0'),(306,'出库','零售',NULL,'LS20260116001','2026-01-16 01:22:10','2026-01-16 01:22:10',NULL,63,NULL,NULL,NULL,12000.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,'0',NULL,NULL,63,'0'),(308,'其它','采购订单','CGDD00000000678','CGDD00000000678','2026-01-16 04:21:31','2026-01-16 17:20:11',93,63,17,0.000000,0.000000,-13.000000,'现付',NULL,NULL,'',NULL,'','',0.000000,0.000000,13.000000,NULL,0.000000,'1','0','0',NULL,NULL,63,'0'),(309,'其它','请购单','QGD00000000679','QGD00000000679','2026-01-16 04:25:29','2026-01-16 17:21:17',NULL,63,NULL,NULL,NULL,NULL,'现付',NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','0',NULL,NULL,63,'0'),(310,'入库','采购','CGRK00000000680','CGRK00000000680','2026-01-16 04:25:51','2026-01-16 17:25:34',93,63,17,-12.000000,0.000000,-12.000000,'现付',NULL,NULL,'',NULL,'','',0.000000,0.000000,12.000000,0.000000,0.000000,'1','0','0',NULL,NULL,63,'0'),(311,'出库','采购退货','CGTH00000000681','CGTH00000000681','2026-01-16 04:26:13','2026-01-16 17:26:00',93,63,17,12.000000,NULL,12.000000,'现付',NULL,NULL,'',NULL,'','',0.000000,0.000000,12.000000,0.000000,NULL,'1','0','0',NULL,NULL,63,'0'),(312,'其它','销售订单','XSDD00000000683','XSDD00000000683','2026-01-18 19:41:24','2026-01-19 08:40:42',94,63,17,0.000000,NULL,14.000000,'现付',NULL,NULL,'','','','',0.000000,0.000000,14.000000,NULL,NULL,'0','0','0',NULL,NULL,63,'0'),(313,'出库','销售','XSCK00000000684','XSCK00000000684','2026-01-18 19:41:44','2026-01-19 08:41:28',94,63,17,14.000000,NULL,14.000000,'现付',NULL,NULL,'','','','',0.000000,0.000000,14.000000,0.000000,NULL,'0','0','0',NULL,NULL,63,'0'),(314,'入库','销售退货','XSTH00000000685','XSTH00000000685','2026-01-18 19:42:16','2026-01-19 08:41:46',94,63,17,-14.000000,NULL,-14.000000,'现付',NULL,NULL,'','','','',0.000000,0.000000,14.000000,0.000000,NULL,'0','0','0',NULL,NULL,63,'0'),(315,'入库','其它','QTRK00000000686','QTRK00000000686','2026-01-18 19:42:49','2026-01-19 08:42:36',93,63,NULL,0.000000,0.000000,-12.000000,'现付',NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,0.000000,NULL,0.000000,'1','0','0',NULL,NULL,63,'0'),(316,'出库','其它','QTCK00000000687','QTCK00000000687','2026-01-18 19:43:11','2026-01-19 08:42:59',NULL,63,NULL,NULL,NULL,14.000000,'现付',NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','0',NULL,NULL,63,'0'),(319,'出库','调拨','DBCK00000000688','DBCK00000000688','2026-01-18 19:43:40','2026-01-19 08:43:13',NULL,63,NULL,NULL,NULL,12.000000,'现付',NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','0',NULL,NULL,63,'0'),(321,'其它','组装单','ZZD00000000689','ZZD00000000689','2026-01-18 19:44:30','2026-01-19 08:43:44',NULL,63,NULL,NULL,NULL,25.000000,'现付',NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','0','0',NULL,NULL,63,'0'),(322,'其它','拆卸单','CXD00000000690','CXD00000000690','2026-01-18 19:44:59','2026-01-19 08:44:36',NULL,63,NULL,NULL,NULL,24.000000,'现付',NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','0','0',NULL,NULL,63,'0'),(323,'出库','零售','LSCK00000000691','LSCK00000000691','2026-01-18 19:45:31','2026-01-19 08:45:19',NULL,63,17,14.000000,0.000000,14.000000,'现付',NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,0.000000,NULL,0.000000,'1','0','0',NULL,NULL,63,'0'),(324,'入库','零售退货','LSTH00000000692','LSTH00000000692','2026-01-18 19:45:50','2026-01-19 08:45:38',NULL,63,17,-14.000000,0.000000,-14.000000,'现付',NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','0',NULL,NULL,63,'0'),(325,'入库','采购','CGRK00000000699','CGRK00000000699','2026-01-18 21:48:57','2026-01-19 10:48:44',57,63,17,-13.000000,NULL,-13.000000,'现付',NULL,NULL,'',NULL,'','',0.000000,0.000000,13.000000,0.000000,NULL,'0','0','0',NULL,NULL,63,'0');
/*!40000 ALTER TABLE `jsh_depot_head` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jsh_depot_item`
--

DROP TABLE IF EXISTS `jsh_depot_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jsh_depot_item` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `header_id` bigint NOT NULL COMMENT '表头Id',
  `material_id` bigint NOT NULL COMMENT '商品Id',
  `material_extend_id` bigint DEFAULT NULL COMMENT '商品扩展id',
  `material_unit` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '商品单位',
  `sku` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '多属性',
  `oper_number` decimal(24,6) DEFAULT NULL COMMENT '数量',
  `basic_number` decimal(24,6) DEFAULT NULL COMMENT '基础数量，如kg、瓶',
  `unit_price` decimal(24,6) DEFAULT NULL COMMENT '单价',
  `purchase_unit_price` decimal(24,6) DEFAULT NULL COMMENT '采购单价',
  `tax_unit_price` decimal(24,6) DEFAULT NULL COMMENT '含税单价',
  `all_price` decimal(24,6) DEFAULT NULL COMMENT '金额',
  `remark` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '备注',
  `depot_id` bigint DEFAULT NULL COMMENT '仓库ID',
  `another_depot_id` bigint DEFAULT NULL COMMENT '调拨时，对方仓库Id',
  `tax_rate` decimal(24,6) DEFAULT NULL COMMENT '税率',
  `tax_money` decimal(24,6) DEFAULT NULL COMMENT '税额',
  `tax_last_money` decimal(24,6) DEFAULT NULL COMMENT '价税合计',
  `material_type` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '商品类型',
  `sn_list` varchar(2000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '序列号列表',
  `batch_number` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '批号',
  `expiration_date` datetime DEFAULT NULL COMMENT '有效日期',
  `link_id` bigint DEFAULT NULL COMMENT '关联明细id',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `delete_flag` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '0' COMMENT '删除标记，0未删除，1删除',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK2A819F475D61CCF7` (`material_id`) USING BTREE,
  KEY `FK2A819F474BB6190E` (`header_id`) USING BTREE,
  KEY `FK2A819F479485B3F5` (`depot_id`) USING BTREE,
  KEY `FK2A819F47729F5392` (`another_depot_id`) USING BTREE,
  KEY `material_extend_id` (`material_extend_id`) USING BTREE,
  KEY `tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=365 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='单据子表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jsh_depot_item`
--

LOCK TABLES `jsh_depot_item` WRITE;
/*!40000 ALTER TABLE `jsh_depot_item` DISABLE KEYS */;
INSERT INTO `jsh_depot_item` VALUES (1,1,1,NULL,'张',NULL,100.000000,NULL,100.000000,NULL,NULL,10000.000000,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,63,'0'),(2,1,2,NULL,'公斤',NULL,250.000000,NULL,20.000000,NULL,NULL,5000.000000,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,63,'0'),(3,2,5,NULL,'台',NULL,10.000000,NULL,1500.000000,NULL,NULL,15000.000000,NULL,3,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,63,'0'),(4,2,6,NULL,'台',NULL,1.000000,NULL,80000.000000,NULL,NULL,80000.000000,NULL,3,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,63,'0'),(5,3,3,NULL,'个',NULL,100.000000,NULL,50.000000,NULL,NULL,5000.000000,NULL,2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,63,'0'),(6,3,4,NULL,'台',NULL,15.000000,NULL,200.000000,NULL,NULL,3000.000000,NULL,2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,63,'0'),(7,4,1,NULL,'张',NULL,30.000000,NULL,100.000000,NULL,NULL,3000.000000,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,63,'0'),(101,101,5,NULL,'台',NULL,10.000000,NULL,1500.000000,NULL,NULL,15000.000000,NULL,3,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,63,'0'),(102,102,6,NULL,'台',NULL,1.000000,NULL,80000.000000,NULL,NULL,80000.000000,NULL,3,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,63,'0'),(103,102,5,NULL,'台',NULL,10.000000,NULL,1500.000000,NULL,NULL,15000.000000,NULL,3,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,63,'0'),(104,103,3,NULL,'个',NULL,100.000000,NULL,50.000000,NULL,NULL,5000.000000,NULL,2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,63,'0'),(105,103,4,NULL,'台',NULL,15.000000,NULL,200.000000,NULL,NULL,3000.000000,NULL,2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,63,'0'),(201,201,1,NULL,'张',NULL,50.000000,NULL,100.000000,NULL,NULL,5000.000000,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,63,'0'),(202,201,2,NULL,'公斤',NULL,250.000000,NULL,20.000000,NULL,NULL,5000.000000,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,63,'0'),(203,202,1,NULL,'张',NULL,100.000000,NULL,100.000000,NULL,NULL,10000.000000,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,63,'0'),(204,202,2,NULL,'公斤',NULL,250.000000,NULL,20.000000,NULL,NULL,5000.000000,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,63,'0'),(205,203,3,NULL,'个',NULL,200.000000,NULL,50.000000,NULL,NULL,10000.000000,NULL,2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,63,'0'),(206,203,4,NULL,'台',NULL,50.000000,NULL,200.000000,NULL,NULL,10000.000000,NULL,2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,63,'0'),(301,301,5,NULL,'台',NULL,10.000000,NULL,1500.000000,NULL,NULL,15000.000000,NULL,3,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,63,'0'),(302,301,6,NULL,'台',NULL,1.000000,NULL,80000.000000,NULL,NULL,80000.000000,NULL,3,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,63,'0'),(303,302,5,NULL,'台',NULL,20.000000,NULL,1500.000000,NULL,NULL,30000.000000,NULL,3,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,63,'0'),(304,303,6,NULL,'台',NULL,2.000000,NULL,80000.000000,NULL,NULL,160000.000000,NULL,3,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,63,'0'),(305,303,5,NULL,'台',NULL,10.000000,NULL,1500.000000,NULL,NULL,15000.000000,NULL,3,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,63,'0'),(334,304,620,NULL,'个',NULL,10.000000,NULL,5000.000000,NULL,NULL,50000.000000,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,63,'0'),(335,305,621,NULL,'个',NULL,5.000000,NULL,6000.000000,NULL,NULL,30000.000000,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,63,'0'),(336,306,622,NULL,'个',NULL,3.000000,NULL,4000.000000,NULL,NULL,12000.000000,NULL,2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,63,'0'),(337,304,623,NULL,'个',NULL,5.000000,NULL,2000.000000,NULL,NULL,10000.000000,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,63,'0'),(338,305,624,NULL,'个',NULL,2.000000,NULL,8000.000000,NULL,NULL,16000.000000,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,63,'0'),(339,306,625,NULL,'个',NULL,1.000000,NULL,3000.000000,NULL,NULL,3000.000000,NULL,2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,63,'0'),(340,304,626,NULL,'箱',NULL,20.000000,NULL,100.000000,NULL,NULL,2000.000000,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,63,'0'),(341,305,627,NULL,'盒',NULL,50.000000,NULL,20.000000,NULL,NULL,1000.000000,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,63,'0'),(342,306,628,NULL,'个',NULL,10.000000,NULL,50.000000,NULL,NULL,500.000000,NULL,2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,63,'0'),(344,308,626,55,'盒',NULL,1.000000,1.000000,13.000000,NULL,NULL,13.000000,NULL,NULL,NULL,0.000000,0.000000,13.000000,NULL,NULL,NULL,NULL,NULL,63,'0'),(345,309,627,54,'盒',NULL,1.000000,1.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,63,'0'),(346,309,626,55,'盒',NULL,1.000000,1.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,63,'0'),(348,310,627,54,'盒',NULL,1.000000,1.000000,12.000000,NULL,NULL,12.000000,NULL,14,NULL,0.000000,0.000000,12.000000,NULL,NULL,NULL,NULL,NULL,63,'0'),(349,311,627,54,'盒',NULL,1.000000,1.000000,12.000000,NULL,NULL,12.000000,NULL,14,NULL,0.000000,0.000000,12.000000,NULL,NULL,NULL,NULL,NULL,63,'0'),(350,312,627,54,'盒',NULL,1.000000,1.000000,14.000000,NULL,NULL,14.000000,NULL,NULL,NULL,0.000000,0.000000,14.000000,NULL,NULL,NULL,NULL,NULL,63,'0'),(351,313,627,54,'盒',NULL,1.000000,1.000000,14.000000,12.000000,NULL,14.000000,NULL,14,NULL,0.000000,0.000000,14.000000,NULL,NULL,NULL,NULL,NULL,63,'0'),(352,314,619,37,'件','橙色,L',1.000000,1.000000,14.000000,12.000000,NULL,14.000000,NULL,14,NULL,0.000000,0.000000,14.000000,NULL,NULL,NULL,NULL,NULL,63,'0'),(354,315,627,54,'盒',NULL,1.000000,1.000000,12.000000,NULL,NULL,12.000000,NULL,22,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,63,'0'),(355,316,626,55,'盒',NULL,1.000000,1.000000,14.000000,NULL,NULL,14.000000,NULL,22,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,63,'0'),(356,319,619,37,'件','橙色,L',1.000000,1.000000,12.000000,NULL,NULL,12.000000,NULL,22,14,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,63,'0'),(357,321,626,55,'盒',NULL,1.000000,1.000000,13.000000,NULL,NULL,13.000000,NULL,22,NULL,NULL,NULL,NULL,'组合件',NULL,NULL,NULL,NULL,63,'0'),(358,321,619,36,'件','橙色,M',1.000000,1.000000,12.000000,NULL,NULL,12.000000,NULL,14,NULL,NULL,NULL,NULL,'普通子件',NULL,NULL,NULL,NULL,63,'0'),(359,322,619,38,'件','绿色,M',1.000000,1.000000,12.000000,NULL,NULL,12.000000,NULL,14,NULL,NULL,NULL,NULL,'组合件',NULL,NULL,NULL,NULL,63,'0'),(360,322,619,39,'件','绿色,L',1.000000,1.000000,12.000000,NULL,NULL,12.000000,NULL,14,NULL,NULL,NULL,NULL,'普通子件',NULL,NULL,NULL,NULL,63,'0'),(362,323,627,54,'盒',NULL,1.000000,1.000000,14.000000,12.000000,NULL,14.000000,NULL,22,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,63,'0'),(363,324,626,55,'盒',NULL,1.000000,1.000000,14.000000,13.000000,NULL,14.000000,NULL,14,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,63,'0'),(364,325,626,55,'盒',NULL,1.000000,1.000000,13.000000,NULL,NULL,13.000000,NULL,14,NULL,0.000000,0.000000,13.000000,NULL,NULL,NULL,NULL,NULL,63,'0');
/*!40000 ALTER TABLE `jsh_depot_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jsh_function`
--

DROP TABLE IF EXISTS `jsh_function`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jsh_function` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `number` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '编号',
  `name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '名称',
  `parent_number` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '上级编号',
  `url` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '链接',
  `component` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '组件',
  `state` bit(1) DEFAULT NULL COMMENT '收缩',
  `sort` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '排序',
  `enabled` bit(1) DEFAULT NULL COMMENT '启用',
  `type` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '类型',
  `push_btn` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '功能按钮',
  `icon` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '图标',
  `delete_flag` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '0' COMMENT '删除标记，0未删除，1删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `url` (`url`) USING BTREE,
  UNIQUE KEY `uk_function_url` (`url`)
) ENGINE=InnoDB AUTO_INCREMENT=262 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='功能模块表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jsh_function`
--

LOCK TABLES `jsh_function` WRITE;
/*!40000 ALTER TABLE `jsh_function` DISABLE KEYS */;
INSERT INTO `jsh_function` VALUES (1,'0001','系统管理','0','/system','/layouts/TabLayout',_binary '','0910',_binary '','电脑版','','setting','0'),(13,'000102','角色管理','0001','/system/role','/system/RoleList',_binary '\0','0130',_binary '','电脑版','1','profile','0'),(14,'000103','用户管理','0001','/system/user','/system/UserList',_binary '\0','0140',_binary '','电脑版','1','profile','0'),(15,'000104','日志管理','0001','/system/log','/system/LogList',_binary '\0','0160',_binary '','电脑版','','profile','0'),(16,'000105','功能管理','0001','/system/function','/system/FunctionList',_binary '\0','0166',_binary '','电脑版','1','profile','0'),(18,'000109','租户管理','0001','/system/tenant','/system/TenantList',_binary '\0','0167',_binary '','电脑版','1','profile','0'),(21,'0101','商品管理','0','/material','/layouts/TabLayout',_binary '\0','0620',_binary '','电脑版',NULL,'shopping','0'),(22,'010101','商品类别','0101','/material/material_category','/material/MaterialCategoryList',_binary '\0','0230',_binary '','电脑版','1','profile','0'),(23,'010102','商品信息','0101','/material/material','/material/MaterialList',_binary '\0','0240',_binary '','电脑版','1,3','profile','0'),(24,'0102','基础资料','0','/systemA','/layouts/TabLayout',_binary '\0','0750',_binary '','电脑版',NULL,'appstore','0'),(25,'01020101','供应商信息','0102','/system/vendor','/system/VendorList',_binary '\0','0260',_binary '','电脑版','1,3','profile','0'),(26,'010202','仓库信息','0102','/system/depot','/system/DepotList',_binary '\0','0270',_binary '','电脑版','1','profile','0'),(31,'010206','经手人管理','0102','/system/person','/system/PersonList',_binary '\0','0284',_binary '','电脑版','1','profile','0'),(32,'0502','采购管理','0','/bill','/layouts/TabLayout',_binary '\0','0330',_binary '','电脑版','','retweet','0'),(33,'050201','采购入库','0502','/bill/purchase_in','/bill/PurchaseInList',_binary '\0','0340',_binary '','电脑版','1,2,3,7','profile','0'),(38,'0603','销售管理','0','/billB','/layouts/TabLayout',_binary '\0','0390',_binary '','电脑版','','shopping-cart','0'),(40,'080107','调拨出库','0801','/bill/allocation_out','/bill/AllocationOutList',_binary '\0','0807',_binary '','电脑版','1,2,3,7','profile','0'),(41,'060303','销售出库','0603','/bill/sale_out','/bill/SaleOutList',_binary '\0','0394',_binary '','电脑版','1,2,3,7','profile','0'),(44,'0704','财务管理','0','/financial','/layouts/TabLayout',_binary '\0','0450',_binary '','电脑版','','money-collect','0'),(59,'030101','进销存统计','0301','/report/in_out_stock_report','/report/InOutStockReport',_binary '\0','0658',_binary '','电脑版','','profile','0'),(194,'010204','收支项目','0102','/system/in_out_item','/system/InOutItemList',_binary '\0','0282',_binary '','电脑版','1','profile','0'),(195,'010205','结算账户','0102','/system/account','/system/AccountList',_binary '\0','0283',_binary '','电脑版','1','profile','0'),(197,'070402','收入单','0704','/financial/item_in','/financial/ItemInList',_binary '\0','0465',_binary '','电脑版','1,2,3,7','profile','0'),(198,'0301','报表查询','0','/report','/layouts/TabLayout',_binary '\0','0570',_binary '','电脑版',NULL,'pie-chart','0'),(199,'050204','采购退货','0502','/bill/purchase_back','/bill/PurchaseBackList',_binary '\0','0345',_binary '','电脑版','1,2,3,7','profile','0'),(200,'060305','销售退货','0603','/bill/sale_back','/bill/SaleBackList',_binary '\0','0396',_binary '','电脑版','1,2,3,7','profile','0'),(201,'080103','其它入库','0801','/bill/other_in','/bill/OtherInList',_binary '\0','0803',_binary '','电脑版','1,2,3,7','profile','0'),(202,'080105','其它出库','0801','/bill/other_out','/bill/OtherOutList',_binary '\0','0805',_binary '','电脑版','1,2,3,7','profile','0'),(203,'070403','支出单','0704','/financial/item_out','/financial/ItemOutList',_binary '\0','0470',_binary '','电脑版','1,2,3,7','profile','0'),(204,'070404','收款单','0704','/financial/money_in','/financial/MoneyInList',_binary '\0','0475',_binary '','电脑版','1,2,3,7','profile','0'),(205,'070405','付款单','0704','/financial/money_out','/financial/MoneyOutList',_binary '\0','0480',_binary '','电脑版','1,2,3,7','profile','0'),(206,'070406','转账单','0704','/financial/giro','/financial/GiroList',_binary '\0','0490',_binary '','电脑版','1,2,3,7','profile','0'),(207,'030102','账户统计','0301','/report/account_report','/report/AccountReport',_binary '\0','0610',_binary '','电脑版','','profile','0'),(208,'030103','采购统计','0301','/report/buy_in_report','/report/BuyInReport',_binary '\0','0620',_binary '','电脑版','','profile','0'),(209,'030104','销售统计','0301','/report/sale_out_report','/report/SaleOutReport',_binary '\0','0630',_binary '','电脑版','','profile','0'),(210,'040102','零售出库','0401','/bill/retail_out','/bill/RetailOutList',_binary '\0','0405',_binary '','电脑版','1,2,3,7','profile','0'),(211,'040104','零售退货','0401','/bill/retail_back','/bill/RetailBackList',_binary '\0','0407',_binary '','电脑版','1,2,3,7','profile','0'),(212,'070407','收预付款','0704','/financial/advance_in','/financial/AdvanceInList',_binary '\0','0495',_binary '','电脑版','1,2,3,7','profile','0'),(217,'01020102','客户信息','0102','/system/customer','/system/CustomerList',_binary '\0','0262',_binary '','电脑版','1,3','profile','0'),(218,'01020103','会员信息','0102','/system/member','/system/MemberList',_binary '\0','0263',_binary '','电脑版','1,3','profile','0'),(220,'010103','多单位','0101','/system/unit','/system/UnitList',_binary '\0','0245',_binary '','电脑版','1','profile','0'),(225,'0401','零售管理','0','/billC','/layouts/TabLayout',_binary '\0','0101',_binary '','电脑版','','gift','0'),(226,'030106','入库明细','0301','/report/in_detail','/report/InDetail',_binary '\0','0640',_binary '','电脑版','','profile','0'),(227,'030107','出库明细','0301','/report/out_detail','/report/OutDetail',_binary '\0','0645',_binary '','电脑版','','profile','0'),(228,'030108','入库汇总','0301','/report/in_material_count','/report/InMaterialCount',_binary '\0','0650',_binary '','电脑版','','profile','0'),(229,'030109','出库汇总','0301','/report/out_material_count','/report/OutMaterialCount',_binary '\0','0655',_binary '','电脑版','','profile','0'),(232,'080109','组装单','0801','/bill/assemble','/bill/AssembleList',_binary '\0','0809',_binary '','电脑版','1,2,3,7','profile','0'),(233,'080111','拆卸单','0801','/bill/disassemble','/bill/DisassembleList',_binary '\0','0811',_binary '','电脑版','1,2,3,7','profile','0'),(234,'000105','系统配置','0001','/system/system_config','/system/SystemConfigList',_binary '\0','0164',_binary '','电脑版','1','profile','0'),(235,'030110','客户对账','0301','/report/customer_account','/report/CustomerAccount',_binary '\0','0660',_binary '','电脑版','','profile','0'),(236,'000106','商品属性','0001','/material/material_property','/material/MaterialPropertyList',_binary '\0','0163',_binary '','电脑版','1','profile','0'),(237,'030111','供应商对账','0301','/report/vendor_account','/report/VendorAccount',_binary '\0','0665',_binary '','电脑版','','profile','0'),(239,'0801','仓库管理','0','/billD','/layouts/TabLayout',_binary '\0','0420',_binary '','电脑版','','hdd','0'),(241,'050202','采购订单','0502','/bill/purchase_order','/bill/PurchaseOrderList',_binary '\0','0335',_binary '','电脑版','1,2,3,7','profile','0'),(242,'060301','销售订单','0603','/bill/sale_order','/bill/SaleOrderList',_binary '\0','0392',_binary '','电脑版','1,2,3,7','profile','0'),(243,'000108','机构管理','0001','/system/organization','/system/OrganizationList',_binary '','0150',_binary '','电脑版','1','profile','0'),(244,'030112','库存预警','0301','/report/stock_warning_report','/report/StockWarningReport',_binary '\0','0670',_binary '','电脑版','','profile','0'),(245,'000107','插件管理','0001','/system/plugin','/system/PluginList',_binary '\0','0170',_binary '','电脑版','1','profile','0'),(246,'030113','商品库存','0301','/report/material_stock','/report/MaterialStock',_binary '\0','0605',_binary '','电脑版','','profile','0'),(247,'010105','多属性','0101','/material/material_attribute','/material/MaterialAttributeList',_binary '\0','0250',_binary '','电脑版','1','profile','0'),(248,'030150','调拨明细','0301','/report/allocation_detail','/report/AllocationDetail',_binary '\0','0646',_binary '','电脑版','','profile','0'),(258,'000112','平台配置','0001','/system/platform_config','/system/PlatformConfigList',_binary '\0','0175',_binary '','电脑版','','profile','0'),(259,'030105','零售统计','0301','/report/retail_out_report','/report/RetailOutReport',_binary '\0','0615',_binary '','电脑版','','profile','0'),(261,'050203','请购单','0502','/bill/purchase_apply','/bill/PurchaseApplyList',_binary '\0','0330',_binary '','电脑版','1,2,3,7','profile','0');
/*!40000 ALTER TABLE `jsh_function` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jsh_in_out_item`
--

DROP TABLE IF EXISTS `jsh_in_out_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jsh_in_out_item` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '名称',
  `type` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '类型',
  `remark` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '备注',
  `enabled` bit(1) DEFAULT NULL COMMENT '启用',
  `sort` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '排序',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `delete_flag` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '0' COMMENT '删除标记，0未删除，1删除',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='收支项目';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jsh_in_out_item`
--

LOCK TABLES `jsh_in_out_item` WRITE;
/*!40000 ALTER TABLE `jsh_in_out_item` DISABLE KEYS */;
INSERT INTO `jsh_in_out_item` VALUES (21,'快递费','支出','',_binary '',NULL,63,'0'),(22,'房租收入','收入','',_binary '',NULL,63,'0'),(23,'利息收入','收入','收入',_binary '',NULL,63,'0'),(28,'库房房租','支出',NULL,_binary '\0',NULL,63,'1');
/*!40000 ALTER TABLE `jsh_in_out_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jsh_log`
--

DROP TABLE IF EXISTS `jsh_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jsh_log` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint DEFAULT NULL COMMENT '用户id',
  `operation` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '操作模块名称',
  `client_ip` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '客户端IP',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `status` tinyint DEFAULT NULL COMMENT '操作状态 0==成功，1==失败',
  `content` varchar(5000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '详情',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FKF2696AA13E226853` (`user_id`) USING BTREE,
  KEY `create_time` (`create_time`) USING BTREE,
  KEY `tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7620 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='操作日志';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jsh_log`
--

LOCK TABLES `jsh_log` WRITE;
/*!40000 ALTER TABLE `jsh_log` DISABLE KEYS */;
INSERT INTO `jsh_log` VALUES (7608,120,'用户','127.0.0.1/127.0.0.1','2026-01-15 22:08:13',0,'登录admin',0),(7609,63,'用户','127.0.0.1/127.0.0.1','2026-01-15 22:52:49',0,'登录jsh',63),(7610,63,'用户','127.0.0.1','2026-01-16 01:28:22',0,'登录jsh',63),(7611,63,'用户','127.0.0.1','2026-01-16 01:32:28',0,'登录jsh',63),(7612,63,'用户','127.0.0.1','2026-01-16 01:34:46',0,'登录jsh',63),(7613,63,'用户','127.0.0.1/127.0.0.1','2026-01-18 21:37:19',0,'登录jsh',63),(7614,63,'用户','127.0.0.1','2026-01-18 21:58:13',0,'登录jsh',63),(7615,63,'用户','127.0.0.1','2026-01-18 22:06:06',0,'登录jsh',63),(7616,63,'用户','127.0.0.1','2026-01-18 22:10:58',0,'登录jsh',63),(7617,1,'用户','127.0.0.1/127.0.0.1','2026-01-19 01:22:54',0,'登录admin',63),(7618,63,'用户','127.0.0.1/127.0.0.1','2026-01-19 01:24:53',0,'登录jsh',63),(7619,120,'用户','127.0.0.1/127.0.0.1','2026-01-19 01:43:10',0,'登录admin',0);
/*!40000 ALTER TABLE `jsh_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jsh_material`
--

DROP TABLE IF EXISTS `jsh_material`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jsh_material` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `category_id` bigint DEFAULT NULL COMMENT '产品类型id',
  `name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '名称',
  `mfrs` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '制造商',
  `model` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '型号',
  `standard` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '规格',
  `brand` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '品牌',
  `mnemonic` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '助记码',
  `color` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '颜色',
  `unit` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '单位-单个',
  `remark` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '备注',
  `img_name` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '图片名称',
  `unit_id` bigint DEFAULT NULL COMMENT '单位Id',
  `expiry_num` int DEFAULT NULL COMMENT '保质期天数',
  `weight` decimal(24,6) DEFAULT NULL COMMENT '基础重量(kg)',
  `enabled` bit(1) DEFAULT NULL COMMENT '启用 0-禁用  1-启用',
  `other_field1` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '自定义1',
  `other_field2` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '自定义2',
  `other_field3` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '自定义3',
  `enable_serial_number` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '0' COMMENT '是否开启序列号，0否，1是',
  `enable_batch_number` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '0' COMMENT '是否开启批号，0否，1是',
  `position` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '仓位货架',
  `attribute` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '多属性信息',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `delete_flag` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '0' COMMENT '删除标记，0未删除，1删除',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK675951272AB6672C` (`category_id`) USING BTREE,
  KEY `UnitId` (`unit_id`) USING BTREE,
  KEY `tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=630 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='产品表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jsh_material`
--

LOCK TABLES `jsh_material` WRITE;
/*!40000 ALTER TABLE `jsh_material` DISABLE KEYS */;
INSERT INTO `jsh_material` VALUES (1,4,'不锈钢板',NULL,'1000*2000',NULL,NULL,NULL,NULL,'张',NULL,NULL,NULL,NULL,NULL,_binary '',NULL,NULL,NULL,'0','0',NULL,NULL,63,'0'),(2,5,'塑料颗粒',NULL,'PP-123',NULL,NULL,NULL,NULL,'公斤',NULL,NULL,NULL,NULL,NULL,_binary '',NULL,NULL,NULL,'0','0',NULL,NULL,63,'0'),(3,6,'电路板',NULL,'PCB-001',NULL,NULL,NULL,NULL,'个',NULL,NULL,NULL,NULL,NULL,_binary '',NULL,NULL,NULL,'0','0',NULL,NULL,63,'0'),(4,7,'电机',NULL,'MOT-001',NULL,NULL,NULL,NULL,'台',NULL,NULL,NULL,NULL,NULL,_binary '',NULL,NULL,NULL,'0','0',NULL,NULL,63,'0'),(5,8,'智能手机',NULL,'PHONE-001',NULL,NULL,NULL,NULL,'台',NULL,NULL,NULL,NULL,NULL,_binary '',NULL,NULL,NULL,'0','0',NULL,NULL,63,'0'),(6,9,'工业机器人',NULL,'ROBOT-001',NULL,NULL,NULL,NULL,'台',NULL,NULL,NULL,NULL,NULL,_binary '',NULL,NULL,NULL,'0','0',NULL,NULL,63,'0'),(568,17,'商品1','制1','sp1','',NULL,NULL,'','个','',NULL,NULL,NULL,NULL,_binary '','','','','0','0',NULL,NULL,63,'0'),(569,17,'商品2','','sp2','',NULL,NULL,'','只','',NULL,NULL,NULL,NULL,_binary '','','','','0','0',NULL,NULL,63,'0'),(570,17,'商品3','','sp3','',NULL,NULL,'','个','',NULL,NULL,NULL,NULL,_binary '','','','','0','0',NULL,NULL,63,'0'),(577,NULL,'商品8','','sp8','',NULL,NULL,'','','',NULL,15,NULL,NULL,_binary '','','','','0','0',NULL,NULL,63,'0'),(579,21,'商品17','','sp17','',NULL,NULL,'','','',NULL,15,NULL,NULL,_binary '','','','','0','0',NULL,NULL,63,'0'),(586,17,'序列号商品测试','','xlh123','',NULL,NULL,'','个','',NULL,NULL,NULL,NULL,_binary '','','','','1','0',NULL,NULL,63,'0'),(587,17,'商品test1','南通中远','','test1',NULL,NULL,'','个','',NULL,NULL,NULL,NULL,_binary '','','','','0','0',NULL,NULL,63,'0'),(588,21,'商品200','fafda','weqwe','300ml',NULL,NULL,'红色','个','aaaabbbbb',NULL,NULL,NULL,NULL,_binary '','','','','0','0',NULL,NULL,63,'0'),(619,NULL,'衣服',NULL,NULL,NULL,NULL,NULL,NULL,'件',NULL,'',NULL,NULL,NULL,_binary '',NULL,NULL,NULL,'0','0',NULL,NULL,63,'0'),(620,29,'智能手机','苹果','iPhone 15','128GB','Apple','SZN','黑色','个',NULL,NULL,15,NULL,NULL,_binary '',NULL,NULL,NULL,'0','0',NULL,NULL,63,'0'),(621,29,'笔记本电脑','联想','ThinkPad X1','16GB/512GB','Lenovo','BJBDN','银色','个',NULL,NULL,15,NULL,NULL,_binary '',NULL,NULL,NULL,'0','0',NULL,NULL,63,'0'),(622,29,'平板电脑','华为','MatePad Pro','8GB/128GB','Huawei','PBDN','灰色','个',NULL,NULL,15,NULL,NULL,_binary '',NULL,NULL,NULL,'0','0',NULL,NULL,63,'0'),(623,30,'洗衣机','海尔','EG10014B39GU1','10kg','Haier','XYJ','白色','个',NULL,NULL,15,NULL,NULL,_binary '',NULL,NULL,NULL,'0','0',NULL,NULL,63,'0'),(624,30,'冰箱','美的','BCD-545WKPZM(E)','545L','Midea','BX','金色','个',NULL,NULL,15,NULL,NULL,_binary '',NULL,NULL,NULL,'0','0',NULL,NULL,63,'0'),(625,30,'空调','格力','KFR-35GW/(35592)FNhAa-A1','1.5匹','Gree','KT','白色','个',NULL,NULL,15,NULL,NULL,_binary '',NULL,NULL,NULL,'0','0',NULL,NULL,63,'0'),(626,31,'A4纸张','得力','7401','70g','Deli','A4ZZ','白色','盒',NULL,'',NULL,NULL,NULL,_binary '',NULL,NULL,NULL,'0','0',NULL,'{}',63,'0'),(627,31,'中性笔','晨光','AGPB6701','0.5mm','M&G','ZXB','黑色','盒',NULL,'',NULL,NULL,NULL,_binary '',NULL,NULL,NULL,'0','0',NULL,'{}',63,'0'),(628,31,'订书机','得力','0414','12#','Deli','DSJ','蓝色','个',NULL,NULL,15,NULL,NULL,_binary '',NULL,NULL,NULL,'0','0',NULL,NULL,63,'0'),(629,31,'测试商品','测试制造商','RX-01','100*100','测试品牌','CSDP','红色','个',NULL,NULL,NULL,NULL,NULL,_binary '',NULL,NULL,NULL,'0','0',NULL,NULL,63,'0');
/*!40000 ALTER TABLE `jsh_material` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jsh_material_attribute`
--

DROP TABLE IF EXISTS `jsh_material_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jsh_material_attribute` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `attribute_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '属性名',
  `attribute_value` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '属性值',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `delete_flag` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '0' COMMENT '删除标记，0未删除，1删除',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='产品属性表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jsh_material_attribute`
--

LOCK TABLES `jsh_material_attribute` WRITE;
/*!40000 ALTER TABLE `jsh_material_attribute` DISABLE KEYS */;
INSERT INTO `jsh_material_attribute` VALUES (1,'多颜色','红色|橙色|黄色|绿色|蓝色|紫色',63,'0'),(2,'多尺寸','S|M|L|XL|XXL|XXXL',63,'0'),(3,'自定义1','小米|华为',63,'0'),(4,'自定义2',NULL,63,'0'),(5,'自定义3',NULL,63,'0'),(6,'颜色','红色|蓝色|绿色|黄色|黑色',63,'0');
/*!40000 ALTER TABLE `jsh_material_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jsh_material_category`
--

DROP TABLE IF EXISTS `jsh_material_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jsh_material_category` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '名称',
  `category_level` smallint DEFAULT NULL COMMENT '等级',
  `parent_id` bigint DEFAULT NULL COMMENT '上级id',
  `sort` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '显示顺序',
  `serial_no` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '编号',
  `remark` varchar(1024) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `delete_flag` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '0' COMMENT '删除标记，0未删除，1删除',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK3EE7F725237A77D8` (`parent_id`) USING BTREE,
  KEY `tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='产品类型表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jsh_material_category`
--

LOCK TABLES `jsh_material_category` WRITE;
/*!40000 ALTER TABLE `jsh_material_category` DISABLE KEYS */;
INSERT INTO `jsh_material_category` VALUES (1,'原材料',1,0,'1','MAT001','基础原材料','2026-01-15 22:14:17',NULL,63,'0'),(2,'半成品',1,0,'2','MAT002','加工半成品','2026-01-15 22:14:17',NULL,63,'0'),(3,'成品',1,0,'3','MAT003','最终产品','2026-01-15 22:14:17',NULL,63,'0'),(4,'金属材料',2,1,'1','MAT00101','金属原材料','2026-01-15 22:14:17',NULL,63,'0'),(5,'塑料材料',2,1,'2','MAT00102','塑料原材料','2026-01-15 22:14:17',NULL,63,'0'),(6,'电子组件',2,2,'1','MAT00201','电子半成品','2026-01-15 22:14:17',NULL,63,'0'),(7,'机械组件',2,2,'2','MAT00202','机械半成品','2026-01-15 22:14:17',NULL,63,'0'),(8,'电子产品',2,3,'1','MAT00301','消费电子产品','2026-01-15 22:14:17',NULL,63,'0'),(9,'机械设备',2,3,'2','MAT00302','工业机械设备','2026-01-15 22:14:17',NULL,63,'0'),(17,'目录1',NULL,NULL,'11','wae12','eee','2019-04-10 22:18:12','2021-02-17 15:11:35',63,'0'),(21,'目录2',NULL,17,'22','ada112','ddd','2020-07-20 23:08:44','2020-07-20 23:08:44',63,'0'),(29,'电子产品',1,0,'1','D001','电子产品大类','2026-01-16 01:19:57','2026-01-16 01:19:57',63,'0'),(30,'家用电器',1,0,'2','D002','家用电器大类','2026-01-16 01:19:57','2026-01-16 01:19:57',63,'0'),(31,'办公用品',1,0,'3','D003','办公用品大类','2026-01-16 01:19:57','2026-01-16 01:19:57',63,'0'),(32,'手机',2,29,'1','D001001','手机子类','2026-01-16 01:20:18','2026-01-16 01:20:18',63,'0'),(33,'笔记本电脑',2,29,'2','D001002','笔记本电脑子类','2026-01-16 01:20:18','2026-01-16 01:20:18',63,'0'),(34,'平板电脑',2,29,'3','D001003','平板电脑子类','2026-01-16 01:20:18','2026-01-16 01:20:18',63,'0'),(35,'洗衣机',2,30,'1','D002001','洗衣机子类','2026-01-16 01:20:18','2026-01-16 01:20:18',63,'0'),(36,'冰箱',2,30,'2','D002002','冰箱子类','2026-01-16 01:20:18','2026-01-16 01:20:18',63,'0'),(37,'空调',2,30,'3','D002003','空调子类','2026-01-16 01:20:18','2026-01-16 01:20:18',63,'0'),(38,'纸张',2,31,'1','D003001','纸张子类','2026-01-16 01:20:18','2026-01-16 01:20:18',63,'0'),(39,'文具',2,31,'2','D003002','文具子类','2026-01-16 01:20:18','2026-01-16 01:20:18',63,'0'),(40,'办公设备',2,31,'3','D003003','办公设备子类','2026-01-16 01:20:18','2026-01-16 01:20:18',63,'0'),(41,'零食',NULL,NULL,NULL,'1',NULL,'2026-01-16 03:27:09','2026-01-16 03:37:45',63,'1'),(42,'生产原材料',NULL,NULL,NULL,'M001','测试分类','2026-01-16 03:36:45','2026-01-16 03:37:37',63,'1'),(43,'测试类别',NULL,NULL,NULL,'M001',NULL,'2026-01-16 03:51:28','2026-01-16 03:51:28',63,'0');
/*!40000 ALTER TABLE `jsh_material_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jsh_material_current_stock`
--

DROP TABLE IF EXISTS `jsh_material_current_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jsh_material_current_stock` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `material_id` bigint DEFAULT NULL COMMENT '产品id',
  `depot_id` bigint DEFAULT NULL COMMENT '仓库id',
  `current_number` decimal(24,6) DEFAULT NULL COMMENT '当前库存数量',
  `current_unit_price` decimal(24,6) DEFAULT NULL COMMENT '当前单价',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `delete_flag` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '0' COMMENT '删除标记，0未删除，1删除',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `material_id` (`material_id`) USING BTREE,
  KEY `depot_id` (`depot_id`) USING BTREE,
  KEY `tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=92 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=COMPACT COMMENT='产品当前库存';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jsh_material_current_stock`
--

LOCK TABLES `jsh_material_current_stock` WRITE;
/*!40000 ALTER TABLE `jsh_material_current_stock` DISABLE KEYS */;
INSERT INTO `jsh_material_current_stock` VALUES (1,1,1,100.000000,100.000000,63,'0'),(2,2,1,500.000000,20.000000,63,'0'),(3,3,2,200.000000,50.000000,63,'0'),(4,4,2,150.000000,200.000000,63,'0'),(5,5,3,50.000000,1000.000000,63,'0'),(6,6,3,20.000000,50000.000000,63,'0'),(19,588,14,7.000000,NULL,63,'0'),(20,568,14,2.000000,NULL,63,'0'),(21,568,15,1.000000,NULL,63,'0'),(22,570,14,8.000000,NULL,63,'0'),(23,619,14,1.000000,0.000000,63,'0'),(24,619,15,0.000000,0.000000,63,'0'),(25,619,17,0.000000,0.000000,63,'1'),(71,627,19,0.000000,12.000000,63,'0'),(72,627,14,-1.000000,12.000000,63,'0'),(73,627,1,0.000000,12.000000,63,'0'),(74,627,20,0.000000,12.000000,63,'0'),(75,627,15,0.000000,12.000000,63,'0'),(76,627,2,0.000000,12.000000,63,'0'),(77,627,21,0.000000,12.000000,63,'0'),(78,627,17,0.000000,12.000000,63,'1'),(79,627,3,0.000000,12.000000,63,'0'),(80,626,19,0.000000,6.500000,63,'0'),(81,626,14,2.000000,6.500000,63,'0'),(82,626,1,0.000000,6.500000,63,'0'),(83,626,20,0.000000,6.500000,63,'0'),(84,626,15,0.000000,6.500000,63,'0'),(85,626,2,0.000000,6.500000,63,'0'),(86,626,21,0.000000,6.500000,63,'0'),(87,626,17,0.000000,6.500000,63,'1'),(88,626,3,0.000000,6.500000,63,'0'),(89,627,22,0.000000,12.000000,63,'0'),(90,626,22,0.000000,6.500000,63,'0'),(91,619,22,-1.000000,0.000000,63,'0');
/*!40000 ALTER TABLE `jsh_material_current_stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jsh_material_extend`
--

DROP TABLE IF EXISTS `jsh_material_extend`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jsh_material_extend` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `material_id` bigint DEFAULT NULL COMMENT '商品id',
  `bar_code` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '商品条码',
  `commodity_unit` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '商品单位',
  `sku` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '多属性',
  `purchase_decimal` decimal(24,6) DEFAULT NULL COMMENT '采购价格',
  `commodity_decimal` decimal(24,6) DEFAULT NULL COMMENT '零售价格',
  `wholesale_decimal` decimal(24,6) DEFAULT NULL COMMENT '销售价格',
  `low_decimal` decimal(24,6) DEFAULT NULL COMMENT '最低售价',
  `default_flag` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '1' COMMENT '是否为默认单位，1是，0否',
  `create_time` datetime DEFAULT NULL COMMENT '创建日期',
  `create_serial` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '创建人编码',
  `update_serial` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '更新人编码',
  `update_time` bigint DEFAULT NULL COMMENT '更新时间戳',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `delete_Flag` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '0' COMMENT '删除标记，0未删除，1删除',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `material_id` (`material_id`) USING BTREE,
  KEY `bar_code` (`bar_code`) USING BTREE,
  KEY `tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=COMPACT COMMENT='产品价格扩展';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jsh_material_extend`
--

LOCK TABLES `jsh_material_extend` WRITE;
/*!40000 ALTER TABLE `jsh_material_extend` DISABLE KEYS */;
INSERT INTO `jsh_material_extend` VALUES (1,587,'1000','个',NULL,11.000000,22.000000,22.000000,22.000000,'1','2020-02-20 23:22:03','jsh','jsh',1595263657135,63,'0'),(2,568,'1001','个',NULL,11.000000,15.000000,15.000000,15.000000,'1','2020-02-20 23:44:57','jsh','jsh',1595265439418,63,'0'),(3,569,'1002','只',NULL,10.000000,15.000000,15.000000,13.000000,'1','2020-02-20 23:45:15','jsh','jsh',1582213514731,63,'0'),(4,570,'1003','个',NULL,8.000000,15.000000,14.000000,13.000000,'1','2020-02-20 23:45:37','jsh','jsh',1587657604430,63,'0'),(5,577,'1004','个',NULL,10.000000,20.000000,20.000000,20.000000,'1','2020-02-20 23:46:36','jsh','jsh',1582213596494,63,'0'),(6,577,'1005','箱',NULL,120.000000,240.000000,240.000000,240.000000,'0','2020-02-20 23:46:36','jsh','jsh',1582213596497,63,'0'),(7,579,'1006','个',NULL,20.000000,30.000000,30.000000,30.000000,'1','2020-02-20 23:47:04','jsh','jsh',1595264270458,63,'0'),(8,579,'1007','箱',NULL,240.000000,360.000000,360.000000,360.000000,'0','2020-02-20 23:47:04','jsh','jsh',1595264270466,63,'0'),(9,586,'1008','个',NULL,12.000000,15.000000,15.000000,15.000000,'1','2020-02-20 23:47:23','jsh','jsh',1595254981896,63,'0'),(10,588,'1009','个',NULL,11.000000,22.000000,22.000000,22.000000,'1','2020-07-21 00:58:15','jsh','jsh',1614699799073,63,'0'),(36,619,'1014','件','橙色,M',12.000000,15.000000,14.000000,NULL,'1','2021-07-28 01:00:20','jsh','jsh',1768783470078,63,'0'),(37,619,'1015','件','橙色,L',12.000000,15.000000,14.000000,NULL,'0','2021-07-28 01:00:20','jsh','jsh',1768783419968,63,'0'),(38,619,'1016','件','绿色,M',12.000000,15.000000,14.000000,NULL,'0','2021-07-28 01:00:20','jsh','jsh',1768783498859,63,'0'),(39,619,'1017','件','绿色,L',12.000000,15.000000,14.000000,NULL,'0','2021-07-28 01:00:20','jsh','jsh',1768783498966,63,'0'),(45,629,'MAT002','个',NULL,10.000000,15.000000,18.000000,12.000000,'1','2026-01-16 04:06:45',NULL,NULL,1768554405,63,'0'),(54,627,'1018','盒','',12.000000,14.000000,14.000000,14.000000,'1','2026-01-16 04:17:58','jsh','jsh',1768783536564,63,'0'),(55,626,'1019','盒','',13.000000,14.000000,14.000000,14.000000,'1','2026-01-16 04:19:43','jsh','jsh',1768790937724,63,'0');
/*!40000 ALTER TABLE `jsh_material_extend` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jsh_material_initial_stock`
--

DROP TABLE IF EXISTS `jsh_material_initial_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jsh_material_initial_stock` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `material_id` bigint DEFAULT NULL COMMENT '产品id',
  `depot_id` bigint DEFAULT NULL COMMENT '仓库id',
  `number` decimal(24,6) DEFAULT NULL COMMENT '初始库存数量',
  `low_safe_stock` decimal(24,6) DEFAULT NULL COMMENT '最低库存数量',
  `high_safe_stock` decimal(24,6) DEFAULT NULL COMMENT '最高库存数量',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `delete_flag` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '0' COMMENT '删除标记，0未删除，1删除',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `material_id` (`material_id`) USING BTREE,
  KEY `depot_id` (`depot_id`) USING BTREE,
  KEY `tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=277 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=COMPACT COMMENT='产品初始库存';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jsh_material_initial_stock`
--

LOCK TABLES `jsh_material_initial_stock` WRITE;
/*!40000 ALTER TABLE `jsh_material_initial_stock` DISABLE KEYS */;
INSERT INTO `jsh_material_initial_stock` VALUES (259,627,19,0.000000,NULL,NULL,63,'0'),(260,627,14,0.000000,NULL,NULL,63,'0'),(261,627,1,0.000000,NULL,NULL,63,'0'),(262,627,20,0.000000,NULL,NULL,63,'0'),(263,627,15,0.000000,NULL,NULL,63,'0'),(264,627,2,0.000000,NULL,NULL,63,'0'),(265,627,21,0.000000,NULL,NULL,63,'0'),(266,627,17,0.000000,NULL,NULL,63,'1'),(267,627,3,0.000000,NULL,NULL,63,'0'),(268,626,19,0.000000,NULL,NULL,63,'0'),(269,626,14,0.000000,NULL,NULL,63,'0'),(270,626,1,0.000000,NULL,NULL,63,'0'),(271,626,20,0.000000,NULL,NULL,63,'0'),(272,626,15,0.000000,NULL,NULL,63,'0'),(273,626,2,0.000000,NULL,NULL,63,'0'),(274,626,21,0.000000,NULL,NULL,63,'0'),(275,626,17,0.000000,NULL,NULL,63,'1'),(276,626,3,0.000000,NULL,NULL,63,'0');
/*!40000 ALTER TABLE `jsh_material_initial_stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jsh_material_property`
--

DROP TABLE IF EXISTS `jsh_material_property`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jsh_material_property` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `native_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '原始名称',
  `enabled` bit(1) DEFAULT NULL COMMENT '是否启用',
  `sort` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '排序',
  `another_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '别名',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `delete_flag` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '0' COMMENT '删除标记，0未删除，1删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='产品扩展字段表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jsh_material_property`
--

LOCK TABLES `jsh_material_property` WRITE;
/*!40000 ALTER TABLE `jsh_material_property` DISABLE KEYS */;
/*!40000 ALTER TABLE `jsh_material_property` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jsh_msg`
--

DROP TABLE IF EXISTS `jsh_msg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jsh_msg` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `msg_title` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '消息标题',
  `msg_content` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '消息内容',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `type` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '消息类型',
  `user_id` bigint DEFAULT NULL COMMENT '接收人id',
  `status` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '状态，1未读 2已读',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `delete_Flag` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '0' COMMENT '删除标记，0未删除，1删除',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=COMPACT COMMENT='消息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jsh_msg`
--

LOCK TABLES `jsh_msg` WRITE;
/*!40000 ALTER TABLE `jsh_msg` DISABLE KEYS */;
INSERT INTO `jsh_msg` VALUES (2,'标题1','内容1','2019-09-10 00:11:39','类型1',63,'2',63,'0');
/*!40000 ALTER TABLE `jsh_msg` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jsh_orga_user_rel`
--

DROP TABLE IF EXISTS `jsh_orga_user_rel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jsh_orga_user_rel` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `orga_id` bigint NOT NULL COMMENT '机构id',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `user_blng_orga_dspl_seq` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '用户在所属机构中显示顺序',
  `delete_flag` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '0' COMMENT '删除标记，0未删除，1删除',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `creator` bigint DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `updater` bigint DEFAULT NULL COMMENT '更新人',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `orga_id` (`orga_id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE,
  KEY `creator` (`creator`) USING BTREE,
  KEY `tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='机构用户关系表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jsh_orga_user_rel`
--

LOCK TABLES `jsh_orga_user_rel` WRITE;
/*!40000 ALTER TABLE `jsh_orga_user_rel` DISABLE KEYS */;
INSERT INTO `jsh_orga_user_rel` VALUES (10,13,131,'2','0','2019-12-28 12:13:15',63,'2021-03-18 22:33:19',63,63),(11,12,63,'15','0','2020-09-13 18:42:45',63,'2021-03-19 00:11:40',63,63),(12,13,135,'9','0','2021-03-18 22:24:25',63,'2021-03-19 00:09:23',63,63),(13,13,134,'1','0','2021-03-18 22:31:39',63,'2021-03-18 23:59:55',63,63),(14,22,133,'22','0','2021-03-18 22:31:44',63,'2021-03-18 22:32:04',63,63),(15,12,144,NULL,'0','2021-03-19 00:00:40',63,'2021-03-19 00:08:07',63,63),(16,12,145,NULL,'0','2021-03-19 00:03:44',63,'2021-03-19 00:03:44',63,63);
/*!40000 ALTER TABLE `jsh_orga_user_rel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jsh_organization`
--

DROP TABLE IF EXISTS `jsh_organization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jsh_organization` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `org_no` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '机构编号',
  `org_abr` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '机构简称',
  `parent_id` bigint DEFAULT NULL COMMENT '父机构id',
  `sort` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '机构显示顺序',
  `remark` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `delete_flag` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '0' COMMENT '删除标记，0未删除，1删除',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='机构表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jsh_organization`
--

LOCK TABLES `jsh_organization` WRITE;
/*!40000 ALTER TABLE `jsh_organization` DISABLE KEYS */;
INSERT INTO `jsh_organization` VALUES (12,'001','测试机构',NULL,'2','aaaa2','2019-12-28 12:13:01','2019-12-28 12:13:01',63,'0'),(13,'jg1','机构1',12,'3','','2020-07-21 00:09:57','2020-07-21 00:10:22',63,'0'),(14,'12','机构2',13,'4','','2020-07-21 22:45:42','2021-02-15 22:18:30',63,'0'),(24,'ORG001','总公司',0,'1','公司总部','2026-01-16 01:24:36','2026-01-16 01:24:36',63,'0'),(25,'ORG002','销售部',53,'1','负责产品销售','2026-01-16 01:24:36','2026-01-16 01:24:36',63,'0'),(26,'ORG003','采购部',53,'2','负责物料采购','2026-01-16 01:24:36','2026-01-16 01:24:36',63,'0'),(27,'ORG004','仓库部',53,'3','负责仓库管理','2026-01-16 01:24:36','2026-01-16 01:24:36',63,'0');
/*!40000 ALTER TABLE `jsh_organization` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jsh_permission_audit`
--

DROP TABLE IF EXISTS `jsh_permission_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jsh_permission_audit` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint DEFAULT NULL,
  `role_id` bigint DEFAULT NULL,
  `function_id` bigint DEFAULT NULL,
  `action` varchar(50) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `tenant_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jsh_permission_audit`
--

LOCK TABLES `jsh_permission_audit` WRITE;
/*!40000 ALTER TABLE `jsh_permission_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `jsh_permission_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jsh_person`
--

DROP TABLE IF EXISTS `jsh_person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jsh_person` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `type` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '类型',
  `name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '姓名',
  `enabled` bit(1) DEFAULT NULL COMMENT '启用',
  `sort` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '排序',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `delete_flag` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '0' COMMENT '删除标记，0未删除，1删除',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='经手人表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jsh_person`
--

LOCK TABLES `jsh_person` WRITE;
/*!40000 ALTER TABLE `jsh_person` DISABLE KEYS */;
INSERT INTO `jsh_person` VALUES (14,'销售员','小李',_binary '',NULL,63,'0'),(15,'仓管员','小军',_binary '',NULL,63,'0'),(16,'财务员','小夏',_binary '',NULL,63,'0'),(17,'财务员','小曹',_binary '',NULL,63,'0'),(18,'客户','北京科技有限公司',_binary '','1',63,'0'),(19,'客户','上海贸易公司',_binary '','2',63,'0'),(20,'客户','广州制造企业',_binary '','3',63,'0'),(21,'联系人','张三',_binary '','1',63,'0'),(22,'联系人','李四',_binary '','2',63,'0'),(23,'联系人','王五',_binary '','3',63,'0'),(24,'销售员','小齐',_binary '',NULL,63,'0');
/*!40000 ALTER TABLE `jsh_person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jsh_platform_config`
--

DROP TABLE IF EXISTS `jsh_platform_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jsh_platform_config` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `platform_key` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '关键词',
  `platform_key_info` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '关键词名称',
  `platform_value` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '值',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='平台参数';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jsh_platform_config`
--

LOCK TABLES `jsh_platform_config` WRITE;
/*!40000 ALTER TABLE `jsh_platform_config` DISABLE KEYS */;
INSERT INTO `jsh_platform_config` VALUES (1,'platform_name','平台名称','管伊佳ERP'),(2,'activation_code','激活码',''),(3,'platform_url','官方网站','http://www.gyjerp.com/'),(4,'bill_print_flag','三联打印启用标记','0'),(5,'bill_print_url','三联打印地址',''),(6,'pay_fee_url','租户续费地址',''),(7,'register_flag','注册启用标记','1'),(8,'app_activation_code','手机端激活码',''),(9,'send_workflow_url','发起流程地址',''),(10,'weixinUrl','微信url',''),(11,'weixinAppid','微信appid',''),(12,'weixinSecret','微信secret',''),(13,'aliOss_endpoint','阿里OSS-endpoint',''),(14,'aliOss_accessKeyId','阿里OSS-accessKeyId',''),(15,'aliOss_accessKeySecret','阿里OSS-accessKeySecret',''),(16,'aliOss_bucketName','阿里OSS-bucketName',''),(17,'aliOss_linkUrl','阿里OSS-linkUrl',''),(18,'bill_excel_url','单据Excel地址',''),(19,'email_from','邮件发送端-发件人',''),(20,'email_auth_code','邮件发送端-授权码',''),(21,'email_smtp_host','邮件发送端-SMTP服务器',''),(22,'checkcode_flag','验证码启用标记','1');
/*!40000 ALTER TABLE `jsh_platform_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jsh_role`
--

DROP TABLE IF EXISTS `jsh_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jsh_role` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '名称',
  `type` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '类型',
  `price_limit` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '价格屏蔽 1-屏蔽采购价 2-屏蔽零售价 3-屏蔽销售价',
  `value` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '值',
  `description` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '描述',
  `enabled` bit(1) DEFAULT NULL COMMENT '启用',
  `sort` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '排序',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `delete_flag` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '0' COMMENT '删除标记，0未删除，1删除',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `tenant_id` (`tenant_id`) USING BTREE,
  CONSTRAINT `fk_role_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `jsh_tenant` (`tenant_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='角色表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jsh_role`
--

LOCK TABLES `jsh_role` WRITE;
/*!40000 ALTER TABLE `jsh_role` DISABLE KEYS */;
INSERT INTO `jsh_role` VALUES (4,'管理员','全部数据',NULL,NULL,NULL,_binary '',NULL,NULL,'0'),(10,'租户','全部数据',NULL,NULL,'',_binary '',NULL,NULL,'0'),(16,'销售经理','全部数据',NULL,NULL,'ddd',_binary '',NULL,63,'0'),(17,'销售代表','个人数据',NULL,NULL,'rrr',_binary '',NULL,63,'0');
/*!40000 ALTER TABLE `jsh_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jsh_sequence`
--

DROP TABLE IF EXISTS `jsh_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jsh_sequence` (
  `seq_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '序列名称',
  `min_value` bigint NOT NULL COMMENT '最小值',
  `max_value` bigint NOT NULL COMMENT '最大值',
  `current_val` bigint NOT NULL COMMENT '当前值',
  `increment_val` int NOT NULL DEFAULT '1' COMMENT '增长步数',
  `remark` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`seq_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='单据编号表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jsh_sequence`
--

LOCK TABLES `jsh_sequence` WRITE;
/*!40000 ALTER TABLE `jsh_sequence` DISABLE KEYS */;
INSERT INTO `jsh_sequence` VALUES ('depot_number_seq',1,999999999999999999,699,1,'单据编号sequence');
/*!40000 ALTER TABLE `jsh_sequence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jsh_serial_number`
--

DROP TABLE IF EXISTS `jsh_serial_number`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jsh_serial_number` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `material_id` bigint DEFAULT NULL COMMENT '产品表id',
  `depot_id` bigint DEFAULT NULL COMMENT '仓库id',
  `serial_number` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '序列号',
  `is_sell` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '0' COMMENT '是否卖出，0未卖出，1卖出',
  `in_price` decimal(24,6) DEFAULT NULL COMMENT '入库单价',
  `remark` varchar(1024) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `creator` bigint DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `updater` bigint DEFAULT NULL COMMENT '更新人',
  `in_bill_no` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '入库单号',
  `out_bill_no` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '出库单号',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `delete_flag` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '0' COMMENT '删除标记，0未删除，1删除',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `material_id` (`material_id`) USING BTREE,
  KEY `depot_id` (`depot_id`) USING BTREE,
  KEY `tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='序列号表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jsh_serial_number`
--

LOCK TABLES `jsh_serial_number` WRITE;
/*!40000 ALTER TABLE `jsh_serial_number` DISABLE KEYS */;
/*!40000 ALTER TABLE `jsh_serial_number` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jsh_supplier`
--

DROP TABLE IF EXISTS `jsh_supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jsh_supplier` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `supplier` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '供应商名称',
  `contacts` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '联系人',
  `phone_num` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '电子邮箱',
  `description` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '备注',
  `isystem` tinyint DEFAULT NULL COMMENT '是否系统自带 0==系统 1==非系统',
  `type` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '类型',
  `enabled` bit(1) DEFAULT NULL COMMENT '启用',
  `advance_in` decimal(24,6) DEFAULT '0.000000' COMMENT '预收款',
  `begin_need_get` decimal(24,6) DEFAULT NULL COMMENT '期初应收',
  `begin_need_pay` decimal(24,6) DEFAULT NULL COMMENT '期初应付',
  `all_need_get` decimal(24,6) DEFAULT NULL COMMENT '累计应收',
  `all_need_pay` decimal(24,6) DEFAULT NULL COMMENT '累计应付',
  `fax` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '传真',
  `telephone` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '手机',
  `address` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '地址',
  `tax_num` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '纳税人识别号',
  `bank_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '开户行',
  `account_number` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '账号',
  `tax_rate` decimal(24,6) DEFAULT NULL COMMENT '税率',
  `sort` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '排序',
  `creator` bigint DEFAULT NULL COMMENT '操作员',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `delete_flag` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '0' COMMENT '删除标记，0未删除，1删除',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `type` (`type`) USING BTREE,
  KEY `tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='供应商/客户信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jsh_supplier`
--

LOCK TABLES `jsh_supplier` WRITE;
/*!40000 ALTER TABLE `jsh_supplier` DISABLE KEYS */;
INSERT INTO `jsh_supplier` VALUES (1,'阿里巴巴供应商','张三','13800138000','zhang@alibaba.com',NULL,NULL,'1',_binary '',0.000000,NULL,NULL,NULL,NULL,NULL,NULL,'浙江省杭州市',NULL,NULL,NULL,NULL,NULL,NULL,63,'0'),(2,'腾讯供应商','李四','13900139000','li@tencent.com',NULL,NULL,'1',_binary '',0.000000,NULL,NULL,NULL,NULL,NULL,NULL,'广东省深圳市',NULL,NULL,NULL,NULL,NULL,NULL,63,'0'),(3,'百度供应商','王五','13700137000','wang@baidu.com',NULL,NULL,'1',_binary '',0.000000,NULL,NULL,NULL,NULL,NULL,NULL,'北京市海淀区',NULL,NULL,NULL,NULL,NULL,NULL,63,'0'),(57,'供应商1','小军','12345678','','',NULL,'供应商',_binary '',0.000000,0.000000,0.000000,0.000000,4.000000,'','15000000000','地址1','','','',12.000000,NULL,63,63,'0'),(58,'客户1','小李','12345678','','',NULL,'客户',_binary '',0.000000,0.000000,0.000000,-100.000000,NULL,'','','','','','',12.000000,NULL,63,63,'0'),(59,'客户2','小陈','','','',NULL,'客户',_binary '',0.000000,0.000000,0.000000,0.000000,NULL,'','','','','','',NULL,NULL,63,63,'0'),(60,'12312666','小曹','','','',NULL,'会员',_binary '',12.000000,0.000000,0.000000,NULL,NULL,'','13000000000','','','','',NULL,NULL,63,63,'0'),(68,'供应商3','晓丽','12345678','','fasdfadf',NULL,'供应商',_binary '',0.000000,0.000000,0.000000,0.000000,-35.000000,'','13000000000','aaaa','1341324','','',13.000000,NULL,63,63,'0'),(71,'客户3','小周','','','',NULL,'客户',_binary '',0.000000,0.000000,0.000000,0.000000,NULL,'','','','','','',NULL,NULL,63,63,'0'),(74,'供应商5','小季','77779999','','',NULL,'供应商',_binary '',0.000000,0.000000,5.000000,0.000000,5.000000,'','15806283912','','','','',3.000000,NULL,63,63,'0'),(90,'北京电子供应商','张经理','13800138001','zhangsan@example.com',NULL,NULL,'电子产品',_binary '',0.000000,NULL,NULL,NULL,NULL,NULL,NULL,'北京市朝阳区',NULL,NULL,NULL,NULL,NULL,NULL,63,'0'),(91,'上海家电供应商','李经理','13900139001','lisi@example.com',NULL,NULL,'家用电器',_binary '',0.000000,NULL,NULL,NULL,NULL,NULL,NULL,'上海市浦东新区',NULL,NULL,NULL,NULL,NULL,NULL,63,'0'),(92,'广州办公用品供应商','王经理','13700137001','wangwu@example.com',NULL,NULL,'办公用品',_binary '',0.000000,NULL,NULL,NULL,NULL,NULL,NULL,'广州市天河区',NULL,NULL,NULL,NULL,NULL,NULL,63,'0'),(93,'测试供应商',NULL,NULL,NULL,NULL,NULL,'供应商',_binary '',0.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,63,63,'0'),(94,'测试用户',NULL,NULL,NULL,NULL,NULL,'客户',_binary '',0.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,63,63,'0'),(95,'仓库0',NULL,NULL,NULL,NULL,NULL,'供应商',_binary '',0.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,63,63,'0'),(96,'1234',NULL,NULL,NULL,NULL,NULL,'会员',_binary '',0.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,63,63,'0'),(97,'你好',NULL,NULL,NULL,NULL,NULL,'客户',_binary '',0.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,63,63,'0'),(98,'99',NULL,NULL,NULL,NULL,NULL,'供应商',_binary '',0.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,63,63,'0');
/*!40000 ALTER TABLE `jsh_supplier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jsh_system_config`
--

DROP TABLE IF EXISTS `jsh_system_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jsh_system_config` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `company_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '公司名称',
  `company_contacts` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '公司联系人',
  `company_address` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '公司地址',
  `company_tel` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '公司电话',
  `company_fax` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '公司传真',
  `company_post_code` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '公司邮编',
  `sale_agreement` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '销售协议',
  `depot_flag` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '0' COMMENT '仓库启用标记，0未启用，1启用',
  `customer_flag` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '0' COMMENT '客户启用标记，0未启用，1启用',
  `minus_stock_flag` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '0' COMMENT '负库存启用标记，0未启用，1启用',
  `purchase_by_sale_flag` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '0' COMMENT '以销定购启用标记，0未启用，1启用',
  `multi_level_approval_flag` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '0' COMMENT '多级审核启用标记，0未启用，1启用',
  `multi_bill_type` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '流程类型，可多选',
  `force_approval_flag` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '0' COMMENT '强审核启用标记，0未启用，1启用',
  `update_unit_price_flag` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '1' COMMENT '更新单价启用标记，0未启用，1启用',
  `over_link_bill_flag` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '0' COMMENT '超出关联单据启用标记，0未启用，1启用',
  `in_out_manage_flag` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '0' COMMENT '出入库管理启用标记，0未启用，1启用',
  `multi_account_flag` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '0' COMMENT '多账户启用标记，0未启用，1启用',
  `move_avg_price_flag` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '0' COMMENT '移动平均价启用标记，0未启用，1启用',
  `audit_print_flag` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '0' COMMENT '先审核后打印启用标记，0未启用，1启用',
  `zero_change_amount_flag` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '0' COMMENT '零收付款启用标记，0未启用，1启用',
  `customer_static_price_flag` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '0' COMMENT '客户静态单价启用标记，0未启用，1启用',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `delete_flag` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '0' COMMENT '删除标记，0未删除，1删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=COMPACT COMMENT='系统参数';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jsh_system_config`
--

LOCK TABLES `jsh_system_config` WRITE;
/*!40000 ALTER TABLE `jsh_system_config` DISABLE KEYS */;
INSERT INTO `jsh_system_config` VALUES (11,'公司test','小李','地址1','12345678',NULL,NULL,'注：本单为我公司与客户约定账期内结款的依据，由客户或其单位员工签字生效，并承担法律责任。','0','0','1','0','0','','0','1','0','0','0','0','0','0','0',63,'0');
/*!40000 ALTER TABLE `jsh_system_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jsh_tenant`
--

DROP TABLE IF EXISTS `jsh_tenant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jsh_tenant` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `tenant_id` bigint DEFAULT NULL COMMENT '用户id',
  `login_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '登录名',
  `user_num_limit` int DEFAULT NULL COMMENT '用户数量限制',
  `type` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '0' COMMENT '租户类型，0免费租户，1付费租户',
  `enabled` bit(1) DEFAULT b'1' COMMENT '启用 0-禁用  1-启用',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `expire_time` datetime DEFAULT NULL COMMENT '到期时间',
  `remark` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '备注',
  `delete_flag` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '0' COMMENT '删除标记，0未删除，1删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_tenant_id` (`tenant_id`),
  KEY `create_time` (`create_time`) USING BTREE,
  KEY `tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='租户';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jsh_tenant`
--

LOCK TABLES `jsh_tenant` WRITE;
/*!40000 ALTER TABLE `jsh_tenant` DISABLE KEYS */;
INSERT INTO `jsh_tenant` VALUES (13,63,'jsh',2000,'1',_binary '','2021-02-17 23:19:17','2099-02-17 23:19:17',NULL,'0');
/*!40000 ALTER TABLE `jsh_tenant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jsh_unit`
--

DROP TABLE IF EXISTS `jsh_unit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jsh_unit` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '名称，支持多单位',
  `basic_unit` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '基础单位',
  `other_unit` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '副单位',
  `other_unit_two` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '副单位2',
  `other_unit_three` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '副单位3',
  `ratio` decimal(24,3) DEFAULT NULL COMMENT '比例',
  `ratio_two` decimal(24,3) DEFAULT NULL COMMENT '比例2',
  `ratio_three` decimal(24,3) DEFAULT NULL COMMENT '比例3',
  `enabled` bit(1) DEFAULT NULL COMMENT '启用',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `delete_flag` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '0' COMMENT '删除标记，0未删除，1删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='多单位表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jsh_unit`
--

LOCK TABLES `jsh_unit` WRITE;
/*!40000 ALTER TABLE `jsh_unit` DISABLE KEYS */;
INSERT INTO `jsh_unit` VALUES (15,'个/(箱=12个)','个','箱',NULL,NULL,12.000,NULL,NULL,_binary '',63,'0'),(19,'个/(盒=15个)','个','盒',NULL,NULL,15.000,NULL,NULL,_binary '',63,'0'),(20,'盒/(箱=8盒)','盒','箱',NULL,NULL,8.000,NULL,NULL,_binary '',63,'0'),(21,'瓶/(箱=12瓶)','瓶','箱',NULL,NULL,12.000,NULL,NULL,_binary '',63,'0');
/*!40000 ALTER TABLE `jsh_unit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jsh_user`
--

DROP TABLE IF EXISTS `jsh_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jsh_user` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '用户姓名--例如张三',
  `login_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '登录用户名',
  `password` varchar(255) DEFAULT NULL,
  `leader_flag` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '0' COMMENT '是否经理，0否，1是',
  `position` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '职位',
  `department` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '所属部门',
  `email` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '电子邮箱',
  `phonenum` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '手机号码',
  `ismanager` tinyint NOT NULL DEFAULT '1' COMMENT '是否为管理者 0==管理者 1==员工',
  `isystem` tinyint NOT NULL DEFAULT '0' COMMENT '是否系统自带数据 ',
  `status` tinyint DEFAULT '0' COMMENT '状态，0正常，2封禁',
  `description` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '用户描述信息',
  `remark` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '备注',
  `weixin_open_id` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '微信绑定',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `delete_flag` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '0' COMMENT '删除标记，0未删除，1删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_user_login_name` (`login_name`),
  KEY `idx_user_tenant` (`tenant_id`),
  CONSTRAINT `fk_user_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `jsh_tenant` (`tenant_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=147 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jsh_user`
--

LOCK TABLES `jsh_user` WRITE;
/*!40000 ALTER TABLE `jsh_user` DISABLE KEYS */;
INSERT INTO `jsh_user` VALUES (2,'采购人员','buyer','e10adc3949ba59abbe56e057f20f883e','0',NULL,NULL,'buyer@jsh.com','13900139000',1,0,0,NULL,NULL,NULL,63,'0'),(3,'销售人员','seller','e10adc3949ba59abbe56e057f20f883e','0',NULL,NULL,'seller@jsh.com','13700137000',1,0,0,NULL,NULL,NULL,63,'0'),(4,'仓库人员','stock','e10adc3949ba59abbe56e057f20f883e','0',NULL,NULL,'stock@jsh.com','13600136000',1,0,0,NULL,NULL,NULL,63,'0'),(63,'测试用户','jsh','e10adc3949ba59abbe56e057f20f883e','0','主管',NULL,'666666@qq.com','1123123123132',1,1,0,'',NULL,NULL,63,'0'),(120,'管理员','admin','e10adc3949ba59abbe56e057f20f883e','0',NULL,NULL,NULL,NULL,1,0,0,NULL,NULL,NULL,0,'0'),(131,'test123','test123','e10adc3949ba59abbe56e057f20f883e','0','总监',NULL,'7777777@qq.com','',1,0,0,'',NULL,NULL,63,'0'),(146,'77','77','$2a$10$0kX.IFB8MzgN/mw3QZiACOZd8/U1j4DGxNhjX3bP5BwbjWylooncG','0',NULL,NULL,NULL,NULL,1,0,0,NULL,NULL,NULL,63,'0');
/*!40000 ALTER TABLE `jsh_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jsh_user_business`
--

DROP TABLE IF EXISTS `jsh_user_business`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jsh_user_business` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `type` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '类别',
  `key_id` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '主id',
  `value` varchar(10000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '值',
  `btn_str` varchar(2000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '按钮权限',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `delete_flag` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '0' COMMENT '删除标记，0未删除，1删除',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `type` (`type`) USING BTREE,
  KEY `key_id` (`key_id`) USING BTREE,
  KEY `tenant_id` (`tenant_id`) USING BTREE,
  CONSTRAINT `fk_ub_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `jsh_tenant` (`tenant_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='用户/角色/模块关系表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jsh_user_business`
--

LOCK TABLES `jsh_user_business` WRITE;
/*!40000 ALTER TABLE `jsh_user_business` DISABLE KEYS */;
INSERT INTO `jsh_user_business` VALUES (5,'RoleFunctions','4','[210][225][211][241][33][199][242][38][41][200][201][239][202][40][232][233][197][44][203][204][205][206][212][246][198][207][259][208][209][226][227][248][228][229][59][235][237][244][22][21][23][220][247][25][24][217][218][26][194][195][31][13][1][14][243][15][234][16][18][236][245][258][261][32]','[{\"funId\":13,\"btnStr\":\"1\"},{\"funId\":14,\"btnStr\":\"1\"},{\"funId\":243,\"btnStr\":\"1\"},{\"funId\":234,\"btnStr\":\"1\"},{\"funId\":16,\"btnStr\":\"1\"},{\"funId\":18,\"btnStr\":\"1\"},{\"funId\":236,\"btnStr\":\"1\"},{\"funId\":245,\"btnStr\":\"1\"},{\"funId\":22,\"btnStr\":\"1\"},{\"funId\":23,\"btnStr\":\"1,3\"},{\"funId\":220,\"btnStr\":\"1\"},{\"funId\":247,\"btnStr\":\"1\"},{\"funId\":25,\"btnStr\":\"1,3\"},{\"funId\":217,\"btnStr\":\"1,3\"},{\"funId\":218,\"btnStr\":\"1,3\"},{\"funId\":26,\"btnStr\":\"1\"},{\"funId\":194,\"btnStr\":\"1\"},{\"funId\":195,\"btnStr\":\"1\"},{\"funId\":31,\"btnStr\":\"1\"},{\"funId\":261,\"btnStr\":\"1,2,7,3\"},{\"funId\":241,\"btnStr\":\"1,2,7,3\"},{\"funId\":33,\"btnStr\":\"1,2,7,3\"},{\"funId\":199,\"btnStr\":\"1,2,7,3\"},{\"funId\":242,\"btnStr\":\"1,2,7,3\"},{\"funId\":41,\"btnStr\":\"1,2,7,3\"},{\"funId\":200,\"btnStr\":\"1,2,7,3\"},{\"funId\":210,\"btnStr\":\"1,2,7,3\"},{\"funId\":211,\"btnStr\":\"1,2,7,3\"},{\"funId\":197,\"btnStr\":\"1,7,2,3\"},{\"funId\":203,\"btnStr\":\"1,7,2,3\"},{\"funId\":204,\"btnStr\":\"1,7,2,3\"},{\"funId\":205,\"btnStr\":\"1,7,2,3\"},{\"funId\":206,\"btnStr\":\"1,2,7,3\"},{\"funId\":212,\"btnStr\":\"1,7,2,3\"},{\"funId\":201,\"btnStr\":\"1,2,7,3\"},{\"funId\":202,\"btnStr\":\"1,2,7,3\"},{\"funId\":40,\"btnStr\":\"1,2,7,3\"},{\"funId\":232,\"btnStr\":\"1,2,7,3\"},{\"funId\":233,\"btnStr\":\"1,2,7,3\"}]',NULL,'0'),(13,'UserRole','2','[6][7]',NULL,NULL,'0'),(14,'UserDepot','2','[1][2][6][7]',NULL,NULL,'0'),(15,'UserDepot','1','[1][2][5][6][7][10][12][14][15][17]',NULL,NULL,'0'),(16,'UserRole','63','[10]',NULL,63,'0'),(18,'UserDepot','63','[14][15][22][23]',NULL,63,'0'),(19,'UserDepot','5','[6][45][46][50]',NULL,NULL,'0'),(22,'UserDepot','64','[1]',NULL,NULL,'0'),(24,'UserDepot','65','[1]',NULL,NULL,'0'),(25,'UserCustomer','64','[5][2]',NULL,NULL,'0'),(26,'UserCustomer','65','[6]',NULL,NULL,'0'),(27,'UserCustomer','63','[58][94][97]',NULL,63,'0'),(28,'UserDepot','96','[7]',NULL,NULL,'0'),(32,'RoleFunctions','10','[210][225][211][261][32][241][33][199][242][38][41][200][201][239][202][40][232][233][197][44][203][204][205][206][212][246][198][207][259][208][209][226][227][248][228][229][59][235][237][244][22][21][23][220][247][25][24][217][218][26][194][195][31]','[{\"funId\":13,\"btnStr\":\"1\"},{\"funId\":14,\"btnStr\":\"1\"},{\"funId\":243,\"btnStr\":\"1\"},{\"funId\":234,\"btnStr\":\"1\"},{\"funId\":236,\"btnStr\":\"1\"},{\"funId\":22,\"btnStr\":\"1\"},{\"funId\":23,\"btnStr\":\"1,3\"},{\"funId\":220,\"btnStr\":\"1\"},{\"funId\":247,\"btnStr\":\"1\"},{\"funId\":25,\"btnStr\":\"1,3\"},{\"funId\":217,\"btnStr\":\"1,3\"},{\"funId\":218,\"btnStr\":\"1,3\"},{\"funId\":26,\"btnStr\":\"1\"},{\"funId\":194,\"btnStr\":\"1\"},{\"funId\":195,\"btnStr\":\"1\"},{\"funId\":31,\"btnStr\":\"1\"},{\"funId\":261,\"btnStr\":\"1,2,7,3\"},{\"funId\":241,\"btnStr\":\"1,2,7,3\"},{\"funId\":33,\"btnStr\":\"1,2,7,3\"},{\"funId\":199,\"btnStr\":\"1,7,2,3\"},{\"funId\":242,\"btnStr\":\"1,2,7,3\"},{\"funId\":41,\"btnStr\":\"1,2,7,3\"},{\"funId\":200,\"btnStr\":\"1,2,7,3\"},{\"funId\":210,\"btnStr\":\"1,2,7,3\"},{\"funId\":211,\"btnStr\":\"1,2,7,3\"},{\"funId\":197,\"btnStr\":\"1,2,7,3\"},{\"funId\":203,\"btnStr\":\"1,7,2,3\"},{\"funId\":204,\"btnStr\":\"1,7,2,3\"},{\"funId\":205,\"btnStr\":\"1,2,7,3\"},{\"funId\":206,\"btnStr\":\"1,7,2,3\"},{\"funId\":212,\"btnStr\":\"1,2,7,3\"},{\"funId\":201,\"btnStr\":\"1,2,7,3\"},{\"funId\":202,\"btnStr\":\"1,2,7,3\"},{\"funId\":40,\"btnStr\":\"1,2,7,3\"},{\"funId\":232,\"btnStr\":\"1,2,7,3\"},{\"funId\":233,\"btnStr\":\"1,2,7,3\"}]',NULL,'0'),(36,'UserDepot','117','[8][9]',NULL,NULL,'0'),(37,'UserCustomer','117','[52]',NULL,NULL,'0'),(38,'UserRole','120','[4]',NULL,NULL,'0'),(52,'UserDepot','121','[13]',NULL,NULL,'0'),(54,'UserDepot','115','[13]',NULL,NULL,'0'),(56,'UserCustomer','115','[56]',NULL,NULL,'0'),(57,'UserCustomer','121','[56]',NULL,NULL,'0'),(67,'UserRole','131','[17]',NULL,63,'0'),(68,'RoleFunctions','16','[210]',NULL,63,'0'),(69,'RoleFunctions','17','[210][225][211][241][32][33][199][242][38][41][200][201][239][202][40][232][233][197][44][203][204][205][206][212]','[{\"funId\":\"241\",\"btnStr\":\"1,2\"},{\"funId\":\"33\",\"btnStr\":\"1,2\"},{\"funId\":\"199\",\"btnStr\":\"1,2\"},{\"funId\":\"242\",\"btnStr\":\"1,2\"},{\"funId\":\"41\",\"btnStr\":\"1,2\"},{\"funId\":\"200\",\"btnStr\":\"1,2\"},{\"funId\":\"210\",\"btnStr\":\"1,2\"},{\"funId\":\"211\",\"btnStr\":\"1,2\"},{\"funId\":\"197\",\"btnStr\":\"1\"},{\"funId\":\"203\",\"btnStr\":\"1\"},{\"funId\":\"204\",\"btnStr\":\"1\"},{\"funId\":\"205\",\"btnStr\":\"1\"},{\"funId\":\"206\",\"btnStr\":\"1\"},{\"funId\":\"212\",\"btnStr\":\"1\"},{\"funId\":\"201\",\"btnStr\":\"1,2\"},{\"funId\":\"202\",\"btnStr\":\"1,2\"},{\"funId\":\"40\",\"btnStr\":\"1,2\"},{\"funId\":\"232\",\"btnStr\":\"1,2\"},{\"funId\":\"233\",\"btnStr\":\"1,2\"}]',63,'0'),(83,'UserRole','146','[17]',NULL,63,'0');
/*!40000 ALTER TABLE `jsh_user_business` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-01-19  1:49:30
