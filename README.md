# LiteraryHeaven-server

LiteraryHeaven服务器开发（Swift + perfect）[:对应客户端项目LiteraryHeaven（Swift）](https://github.com/SanWCoder/LiteraryHeaven)

不足之处，还望海涵，有问题可以随时交流哦😯 [:mail_SanW@163.com](http://mail.163.com/)

# 更新记录

2017.9.26--添加token生成规则，添加修改用户名跟简介，头像，性别接口  

2017.9.21--添加登录注册接口,连接MySQL建立了tb_user表

# 数据库设计规范

该规范用于规范MySQL数据库的表设计，目的是希望规范数据库设计，尽量提前避免由于数据库设计不当而产生的麻烦。

#### 1>. 设计原则
* 用MySQL自增ID作为表的主键，类型选择INT类型 id INT NOT NULL AUTO_INCREMENT
* 减少表关联，对于常用的字段，以冗余的方式解决。例如：userid, username， 将用户名冗余存储到其他表
* 避免使用外键，由程序来控制表关联
* 字符规范：  
- 采用26个英文字符小写，0-9自然数，_下划线，不能出现其他字符（注释除外）
- 避免使用保留词作为表名，字段名
#### 2>. 数据库表命名规范
- 使用统一前缀： tb: 基础；td: 字典；to：业务
- 采用英文单词进行命名，单词用_下划线进行分割，例如：tb_user, tb_user_detail，要求见名知意
- 备份表，使用bak前缀和日期后缀，如：bak_user_20160128
- 临时表，使用tmp前缀和日期后缀，如：tmp_user_20160128
- 视图，使用v前缀，如：v_user_full_info
- 索引名，使用idx前缀，唯一索引使用uni前缀，如：idx_create_time; uni_username
#### 3>. 字段命名与类型规范
字段名命名，基本与表名要求相同，需要注意以下几点：

- 是/否(true/false) 字段，采用bit(1)类型, 1表示是；0表示否
- 枚举类型，可选值比较少的用tinyint 类型，支持-127~127, 如果需要，也可以使用tinyint unsigned无符号tinyint作为类型，支持0~256个枚举值。还不够的话，再用int类型
- varchar类型，长度是2的平方，如16, 32, 64, 128, 256 …; 长度不要设的太长，应选择满足需求的最短长度，如手机号：+8613838389438, varcha(16)就够用了
- 统一列命名

|  字段名	|  字段类型  |  描述  |
| :------ | :------- | :------: |
| id	| int	|自增主键|
| is_xxxx |	bit(1) | 表示true/false 值 |
| descs	| varchar | 描述信息 |
| remark	|varchar|备注信息|
| status |	tinyint | 状态 |
| order_no | int	| 排序 |
| create_time |	datetime |	创建时间 |
| creater | varchar | 创建人 |
| last_modify_time |	datetime | 最后修改时间 |
| last_modifier	| varchar | 最后修改人|

# 数据库表设计sql-- tb_user

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

Date: 09/26/2017 17:20:19 PM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `tb_user`
-- ----------------------------
DROP TABLE IF EXISTS `tb_user`;
CREATE TABLE `tb_user` (
`userid` int(6) NOT NULL AUTO_INCREMENT,
`password` varchar(64) DEFAULT NULL,
`nickname` varchar(16) DEFAULT NULL,
`phone` varchar(16) DEFAULT NULL,
`head` varchar(256) DEFAULT NULL,
`sex` tinyint(1) NOT NULL DEFAULT '0',
`grade` int(3) DEFAULT '0',
`info` varchar(16) DEFAULT NULL,
`create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
`uuid` varchar(32) DEFAULT NULL,
`token` varchar(64) NOT NULL DEFAULT '0',
`signout_time` datetime DEFAULT NULL,
`signin_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `tb_user`
-- ----------------------------
BEGIN;
INSERT INTO `tb_user` VALUES ('13', '14e1b600b1fd579f47433b88e8d85291', 'SanW', '18501020496', 'http://a.png', '1', '0', '我也不知道自己是谁', '2017-09-26 00:53:59', '4AF6F657E5F341CEAFA0B66D5C4EF8D7', '0471a3be97f1dafb578d1b3a487b981e', null, '2017-09-26 08:53:59');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;

```
