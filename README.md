# LiteraryHeaven-server简介
LiteraryHeaven服务端开发（Swift + perfect）

对应客户端项目:[LiteraryHeaven](https://github.com/SanWCoder/LiteraryHeaven)

数据抓取项目:[LiteraryHeaven-crawler](https://github.com/SanWCoder/LiteraryHeaven-crawler)

不足之处，还望海涵，如有问题请发送至:[mail_SanW@163.com](http://mail.163.com/)

# 使用

```
~ git clone https://github.com/SanWCoder/LiteraryHeaven-server.git

~ cd LiteraryHeaven-server

~ swift build

~ .build/debug/LiteratyHeavenServer

// 如果需要生成xcode项目可调式
~ swift package generate-xcodeproj

```

# 更新记录

2017.10.10--添加忘记密码接口

2017.9.29--添加退出接口，调整登录时生成token，退出时清空token

2017.9.27--创建tb_article和tb_aticleType表，编写首页接口

2017.9.26--添加token生成规则，添加修改用户名跟简介，头像，性别接口  

2017.9.21--添加登录注册接口,连接MySQL建立了tb_user表

# 一.准备阶段（SPM）
## 1>依存关系  
```
## swfit --version // swift版本必须在3.0以上才能编译
```  
## 2>克隆基础模板  
```
git clone https://github.com/PerfectlySoft/PerfectTemplate.git
```  
所有的SPM项目至少要包括一个 Sources 目录和一个 Package.swift 文件  
## 3>编译  
```
swift build // 编译
.build/debug/PerfectTemplate // 运行
swift build -c release // 编译一个用于发行的版本运行后可发行版本的可执行程序被放在了.build/release/目录下
swift build --clean // 清理所有编译临时文件并产生一个干净的版本 
swift build --clean=dist // .build目录和Packages目录都会被删除。并且能够重新下载所有依存关系以获得最新版本对项目的支持。
```
## 4>生成xcode项目
```
swift package generate-xcodeproj
```
# 二，下载mysql依赖包
## 1> 在Package.swift 中添加MYSQL并重新编译  
```
.Package(url:"https://github.com/PerfectlySoft/Perfect-MySQL.git",majorVersion : 2)
swift build // 重新编译
```
## 2>安装Homebrew 
### 2.1 perfect推荐使用Homebrew安装mysql如果按照homeBrow安装完则不用配置任何东西就可以运行
```
// 安装Homebrew，Homebrew安装在/user/local目录下，同时它会创建/user/local/Cellar目录用于存放通过Homebrew安装的程序，运行brew -v查看安装版本

// 1.
 `/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`
// 2.安装完成顺势更新
 brew update 
// 3.安装完成以后检查文件运行是否正常。注意警告，如果之前手动安装过node最好先删除node文件 local/lib , local/include
 brew doctor 
```
## 3>Homebrew常用命令
```
brew search * --搜索程序，例：brew search python
brew install * --安装程序，例：brew install python
brew uninstall * --卸载程序，例：brew uninstall python
brew list --列举通过Homebrew安装的程序
brew update --更新Homebrew
brew upgrade [*] --更新某个具体程序，或者更新所有程序
brew cleanup [*] --删除某个具体程序，或者删除所有老版程序
brew outdated --查看哪些程序需要更新
brew home * --用浏览器打开
brew info * --显示软件内容信息
brew deps * --显示包依赖
brew server * --启动web服务器，可以通过浏览器访问http://localhost:4567/ 来同网页来管理包
brew -h --查看帮助
```

## 4>删除Homebrew
```
cd `brew –prefix`
rm -rf Cellar
brew prune
rm -rf Library .git .gitignore bin/brew README.md share/man/man1/brew
rm -rf ~/Library/Caches/Homebrew
```
## 5>使用Homebrew安装mysql

```
// 1.安装mysql
brew install mysql
// 2.开启MySQL服务
mysql.server start // brew services start mysql
// 重新启动mysql服务
mysql.server restart
// 停止mysql服务
mysql.server stop // brew services stop mysql
// 3.初始化MySQL配置向导
mysql_secure_installation
// 4.连接mysql
mysql -u root -p

```
### 5.1>初始化MySQL配置向导mysql_secure_installation
```
// 启动mysql
➜  local mysql.server start        
Starting MySQL
. SUCCESS! 
// 运行配置
➜  local mysql_secure_installation

Securing the MySQL server deployment.
// validate_password为密码安全验证，如果不需要或者安全级别低 在/usr/local/etc/my.cnf文件中增加validate-password=OFF validate_password_policy=LOW
Connecting to MySQL using a blank password.
The 'validate_password' plugin is installed on the server.
The subsequent steps will run with the existing configuration
of the plugin.
Please set the password for root here.

New password: 

Re-enter new password: 

Estimated strength of the password: 0 
Do you wish to continue with the password provided?(Press y|Y for Yes, any other key for No) : y
By default, a MySQL installation has an anonymous user,
allowing anyone to log into MySQL without having to have
a user account created for them. This is intended only for
testing, and to make the installation go a bit smoother.
You should remove them before moving into a production
environment.
// 删除默认无密码用户
Remove anonymous users? (Press y|Y for Yes, any other key for No) : y
Success.


Normally, root should only be allowed to connect from
'localhost'. This ensures that someone cannot guess at
the root password from the network.
// 禁止远程root登录
Disallow root login remotely? (Press y|Y for Yes, any other key for No) : y
Success.

By default, MySQL comes with a database named 'test' that
anyone can access. This is also intended only for testing,
and should be removed before moving into a production
environment.

// 删除默认自带的test数据库
Remove test database and access to it? (Press y|Y for Yes, any other key for No) : y
 - Dropping test database...
Success.

 - Removing privileges on test database...
Success.

Reloading the privilege tables will ensure that all changes
made so far will take effect immediately.

Reload privilege tables now? (Press y|Y for Yes, any other key for No) : y
Success.

All done! 

```
### 5.2>mysql测试
```
CREATE DATABASE  `unitedtrade` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
// 创建用户
CREATE USER 'trade'@'%' IDENTIFIED BY  'trade';
// 设置用户：
GRANT USAGE ON * . * TO  'trade'@'%' IDENTIFIED BY  'trade' WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0 ;
// 用户赋权：
GRANT ALL PRIVILEGES ON  `unitedtrade` . * TO  'trade'@'%' WITH GRANT OPTION ;
// 刷新权限：
flush privileges;
```
### 5.3>MySQL其他操作
```
// 终端退出mysql编辑
\q
// 关闭mysql:
mysql stop
// 安全模式启动MySQL
mysqld_safe --skip-grant-tables
```
### 5.4>perfect连接mysql配置
```
// 将mysqlclient.pc文件设置为可读写后删除-fno-omit-frame-pointer内容。
// 文件路径:  
/usr/local/lib/pkgconfig/mysqlclient.pc/
```
## 6>彻底移除mysql
```
// 通过HomeBrew安装从头开始
brew remove mysql  
brew cleanup  
launchctl unload -w ~/Library/LaunchAgents/com.mysql.mysqld.plist  // 设置了开机自动开启
rm ~/Library/LaunchAgents/com.mysql.mysqld.plist // 设置了开机自动开启
// 通过下载包直接安装下面开始
sudo rm /usr/local(/var)/mysql
sudo rm -rf /usr/local(/var)/mysql*
sudo rm -rf /Library/StartupItems/MySQLCOM // 设置了启动项
sudo rm -rf /Library/PreferencePanes/My* // 设置了启动项
(编辑 /etc/hostconfig) sudo vi /etc/hostconfig (删除行 MYSQLCOM=-YES)
sudo rm -rf /Library/Receipts/mysql*
sudo rm -rf /Library/Receipts/MySQL*
sudo rm -rf /var/db/receipts/com.mysql.*
```
# 三.使用自己手动安装完成后需要在finder中找到相应的mysql文件
 * 遇到error :Header '/usr/local/include/mysql/mysql.h'时找到mysql文件并替换/usr/local/mysql-5.7.15-osx10.11-x86_64/include/mysql.h
 * 遇到找不到lmysqlclient文件时，在Target中找到MySQL，找到Library Search Paths中加上/usr/local/mysql-5.7.15-osx10.11-x86_64l/lib

# 四.数据库设计规范

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

# 五.数据库表设计

#### tb_user

```
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
`token` varchar(64) DEFAULT '0',
`signout_time` datetime DEFAULT NULL,
`signin_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `tb_user`
-- ----------------------------
BEGIN;
INSERT INTO `tb_user` VALUES ('13', '14e1b600b1fd579f47433b88e8d85291', 'SanW', '18501020496', 'http://a.png', '1', '0', '我也不知道自己是谁', '2017-09-26 00:53:59', '4AF6F657E5F341CEAFA0B66D5C4EF8D7', '69b8d2d83486388e08a53a259b92943d', null, '2017-09-26 08:53:59');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;

```

#### tb_article

```
SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `tb_article`
-- ----------------------------
DROP TABLE IF EXISTS `tb_article`;
CREATE TABLE `tb_article` (
`articleid` int(32) NOT NULL AUTO_INCREMENT,
`title` varchar(128) DEFAULT NULL,
`author` varchar(64) DEFAULT NULL,
`groupid` int(16) NOT NULL DEFAULT '0',
`image` varchar(128) DEFAULT NULL,
`content` text,
`create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
`webUrl` varchar(128) DEFAULT NULL,
`anthor_head` varchar(128) DEFAULT NULL,
PRIMARY KEY (`articleid`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `tb_article`
-- ----------------------------
BEGIN;
INSERT INTO `tb_article` VALUES ('16', '【婚礼纪录】婚鞋大作战　裸粉色铆钉款简直绝了', 'by：苏小花花花来自：我的备婚流程331', '0', 'http://qnm.hunliji.com/FpoIK8zY8zx_Z7hnNZKdV-3hlw3s?imageView2/1/w/100/h/100', '6月份的时候在大阪买哒，这个价格实在一般，但是日本的服务太好了，不买都觉得对不起服务的小姐，哈哈，买来当婚鞋哒，10cm真的很高，而且真的很少有人穿的铆钉结婚，本来是想买jimmy choo哒，大阪的jimmy choo款式实在一般，上脚的一瞬间就感觉就是它啦\n第一双是一个小众牌子，非常舒适，鞋型比较秀气，有种mb的感觉，mb真的山寨或者雷同设计太多，看到这个反而有耳目一新的感觉，设计师介绍鞋上的钻都是施华洛世奇哒，个人很喜欢', '2017-09-29 14:01:15', 'http://www.hunliji.com/community/detail_272771', null);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;

```
#### tb_artivleType

```
SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `tb_artivleType`
-- ----------------------------
DROP TABLE IF EXISTS `tb_artivleType`;
CREATE TABLE `tb_artivleType` (
`groupid` int(32) NOT NULL,
`groupTitle` varchar(64) DEFAULT NULL,
PRIMARY KEY (`groupid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `tb_artivleType`
-- ----------------------------
BEGIN;
INSERT INTO `tb_artivleType` VALUES ('1', '婚纱礼服'), ('2', '两性情感'), ('3', '婚纱拍照');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;

```


