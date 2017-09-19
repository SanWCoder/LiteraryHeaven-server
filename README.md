# LiteraryHeaven-server
LiteraryHeaven服务器开发（Swift）
> mysql语句
```
/*
Navicat Premium Data Transfer

Source Server         : LiteraryDB
Source Server Type    : MySQL
Source Server Version : 50719
Source Host           : localhost
Source Database       : LiteraryDB

Target Server Type    : MySQL
Target Server Version : 50719
File Encoding         : utf-8

Date: 09/19/2017 17:55:21 PM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `tb_user`
-- ----------------------------
DROP TABLE IF EXISTS `tb_user`;
CREATE TABLE `tb_user` (
`user_id` int(10) NOT NULL,
`user_pws` varchar(10) DEFAULT NULL,
`user_name` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `tb_user`
-- ----------------------------
BEGIN;
INSERT INTO `tb_user` VALUES ('1', '123456', 'SanW'), ('2', '111111', '用户');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
```
