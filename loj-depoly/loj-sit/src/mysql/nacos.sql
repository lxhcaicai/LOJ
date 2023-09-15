/*
 Navicat Premium Data Transfer

 Source Server         : loj-mysql
 Source Server Type    : MySQL
 Source Server Version : 80100 (8.1.0)
 Source Host           : localhost:3307
 Source Schema         : nacos

 Target Server Type    : MySQL
 Target Server Version : 80100 (8.1.0)
 File Encoding         : 65001

 Date: 16/09/2023 01:05:32
*/

CREATE DATABASE `nacos` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

use `nacos`;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for config_info
-- ----------------------------
DROP TABLE IF EXISTS `config_info`;
CREATE TABLE `config_info`  (
                                `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
                                `data_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'data_id',
                                `group_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                `content` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'content',
                                `md5` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT 'md5',
                                `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
                                `src_user` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL COMMENT 'source user',
                                `src_ip` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT 'source ip',
                                `app_name` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                `tenant_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '' COMMENT '租户字段',
                                `c_desc` varchar(256) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                `c_use` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                `effect` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                `type` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                `c_schema` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL,
                                PRIMARY KEY (`id`) USING BTREE,
                                UNIQUE INDEX `uk_configinfo_datagrouptenant`(`data_id` ASC, `group_id` ASC, `tenant_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 155 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = 'config_info' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of config_info
-- ----------------------------
INSERT INTO `config_info` VALUES (1, 'hoj-prod.yml', 'DEFAULT_GROUP', 'hoj:\n  jwt:\n    # 加密秘钥\n    secret: hoj-secret-init\n    # token有效时长，1天，单位秒\n    expire: 86400\n    checkRefreshExpire: 43200\n    header: token\n  judge:\n    # 调用判题服务器的token\n    token: 2c3ae8e081184f45980110679c18f62c\n  db:\n    host: 172.20.0.3\n    port: 3306\n    public-host: 172.20.0.3\n    public-port: 3306\n    name: hoj\n    username: root\n    password: hoj123456\n  redis:\n    host: 172.20.0.2\n    port: 6379\n    password: hoj123456', '19bca3b9489de3db99bfd1ace0337b70', '2021-05-18 11:29:38', '2023-06-29 11:37:09', 'root', '172.20.0.1', '', '', NULL, NULL, NULL, 'yaml', NULL);
INSERT INTO `config_info` VALUES (2, 'hoj-dev.yml', 'DEFAULT_GROUP', 'hoj:\n  jwt:\n    # 加密秘钥\n    secret: hoj-secret-init\n    # token有效时长，1天，单位秒\n    expire: 86400\n    checkRefreshExpire: 43200\n    header: token\n  judge:\n    # 调用判题服务器的token\n    token: 0635a2a611194415bd80fb12ac5d1cd3\n  db:\n    host: 127.0.0.1\n    port: 3307\n    public-host: 127.0.0.1\n    public-port: 3307\n    name: hoj\n    username: root\n    password: 123456\n  redis:\n    host: 127.0.0.1\n    port: 6379\n    password: 123456', '04fdf534bbe8377d2b3f71ef67881a2f', '2022-06-06 03:35:55', '2023-09-14 09:21:01', 'root', '172.20.0.1', '', '', NULL, NULL, NULL, 'yaml', NULL);
INSERT INTO `config_info` VALUES (6, 'hoj-web.yml', 'DEFAULT_GROUP', 'baseUrl: http://192.168.31.236\ndescription: null\nemailBGImg: https://cdn.jsdelivr.net/gh/HimitZH/CDN/images/HCODE.png\nemailHost: smtp.qq.com\nemailPassword: ozheifdngoejddab\nemailPort: 465\nemailSsl: true\nemailUsername: 2778763221@qq.com\nname: Hcode Online Judge\nprojectName: HOJ\nprojectUrl: https://gitee.com/himitzh0730/hoj\nrecordName: null\nrecordUrl: null\nregister: true\nshortName: HOJ\n', 'c470b5e198027cb430d6d03179ee5fbd', '2023-04-06 13:14:26', '2023-05-12 07:45:31', NULL, '172.17.0.1', '', '', NULL, NULL, NULL, 'yaml', NULL);
INSERT INTO `config_info` VALUES (13, 'loj-sit.yml', 'DEFAULT_GROUP', 'loj:\n    db:\n        name: loj\n        host: 127.0.0.1\n        port: 3307\n        public-host: 127.0.0.1\n        public-port: 3307\n        username: root\n        password: 123456\n    jwt:\n        # 加密秘钥\n        secret: loj-secret-hinit\n        # token默认为24小时 86400s\n        expire: 86400\n        checkRefreshExpire: 43200\n        header: token\n    judge:\n    # 调用判题服务器的token\n        token: 74ec7088edd240e0be953632ed3c17f7\n    redis:\n        host: 127.0.0.1\n        port: 6379\n        password: 123456', '3af32703ea9599a85710709cb82a6744', '2023-04-12 11:04:43', '2023-09-14 09:08:20', 'root', '172.20.0.1', '', '', '', '', '', 'yaml', '');
INSERT INTO `config_info` VALUES (46, 'hoj-switch.yml', 'DEFAULT_GROUP', 'atcoderPasswordList:\n- dgut2834\natcoderUsernameList:\n- lxhcaicai\ncfPasswordList:\n- dgut2834\ncfUsernameList:\n- 2778763221@qq.com\ndefaultCreateCommentACInitValue: 10\ndefaultCreateDiscussionACInitValue: 10\ndefaultCreateDiscussionDailyLimit: 5\ndefaultCreateGroupACInitValue: 20\ndefaultCreateGroupDailyLimit: 2\ndefaultCreateGroupLimit: 5\ndefaultSubmitInterval: 8\nhduPasswordList:\n- dgut2834\nhduUsernameList:\n- lxhcaicai\nhideNonContestSubmissionCode: false\nopenContestComment: true\nopenContestJudge: true\nopenGroupDiscussion: true\nopenGroupJudge: true\nopenPublicDiscussion: true\nopenPublicJudge: true\npojPasswordList:\n- dgut2834\npojUsernameList:\n- lxhcaicai\nspojPasswordList: []\nspojUsernameList: []\n', 'c9e38091b943b2010fe5dadbd6db2b06', '2023-04-27 10:45:52', '2023-04-30 21:21:19', NULL, '172.17.0.1', '', '', NULL, NULL, NULL, 'yaml', NULL);
INSERT INTO `config_info` VALUES (85, 'loj-switch.yml', 'DEFAULT_GROUP', 'atcoderPasswordList:\n- dgut2834\natcoderUsernameList:\n- lxhcaicai\ncfPasswordList:\n- dgut2834\ncfUsernameList:\n- 2778763221@qq.com\ndefaultCreateCommentACInitValue: 10\ndefaultCreateDiscussionACInitValue: 10\ndefaultCreateDiscussionDailyLimit: 5\ndefaultCreateGroupACInitValue: 20\ndefaultCreateGroupDailyLimit: 2\ndefaultCreateGroupLimit: 5\ndefaultSubmitInterval: 8\nhduPasswordList:\n- dgut2834\nhduUsernameList:\n- lxhcaicai\nhideNonContestSubmissionCode: false\nopenContestComment: true\nopenContestJudge: true\nopenGroupDiscussion: true\nopenGroupJudge: true\nopenPublicDiscussion: true\nopenPublicJudge: true\npojPasswordList:\n- dgut2834\npojUsernameList:\n- lxhcaicai\nspojPasswordList: []\nspojUsernameList: []\n', 'c9e38091b943b2010fe5dadbd6db2b06', '2023-05-11 14:09:39', '2023-05-11 14:09:39', NULL, '172.17.0.1', '', '', NULL, NULL, NULL, 'yaml', NULL);
INSERT INTO `config_info` VALUES (93, 'loj-web.yml', 'DEFAULT_GROUP', 'baseUrl: http://192.168.31.236\ndescription: null\nemailBGImg: https://img.tukuppt.com/bg_grid/00/19/38/DTSiKBHtOB.jpg%21/fh/350\nemailHost: smtp.qq.com\nemailPassword: ozheifdngoejddab\nemailPort: 465\nemailSsl: true\nemailUsername: 2778763221@qq.com\nname: Lxhcaicai Online Judge\nprojectName: LOJ\nprojectUrl: https://github.com/lxhcaicai/LOJ\nrecordName: null\nrecordUrl: null\nregister: true\nshortName: LOJ\n', 'af8b8e022d7103b3a390500a49306bd6', '2023-05-12 12:18:53', '2023-05-12 13:00:18', NULL, '172.17.0.1', '', '', '', '', '', 'yaml', '');
INSERT INTO `config_info` VALUES (147, 'loj-pro.yml', 'DEFAULT_GROUP', 'loj:\n    db:\n        name: loj\n        host: 172.20.0.3\n        port: 3306\n        public-host: 172.20.0.3\n        public-port: 3306\n        username: root\n        password: 123456\n    jwt:\n        # 加密秘钥\n        secret: loj-secret-hinit\n        # token默认为24小时 86400s\n        expire: 86400\n        checkRefreshExpire: 43200\n        header: token\n    judge:\n    # 调用判题服务器的token\n        token: 74ec7088edd240e0be953632ed3c17f7\n    redis:\n        host: 172.20.0.2\n        port: 6379\n        password: 123456', '1af3f2c6552f28e1b93f4646fde34300', '2023-09-14 09:38:08', '2023-09-15 11:31:14', 'root', '172.20.0.1', '', '', '', '', '', 'yaml', '');

-- ----------------------------
-- Table structure for config_info_aggr
-- ----------------------------
DROP TABLE IF EXISTS `config_info_aggr`;
CREATE TABLE `config_info_aggr`  (
                                     `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
                                     `data_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'data_id',
                                     `group_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'group_id',
                                     `datum_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'datum_id',
                                     `content` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '内容',
                                     `gmt_modified` datetime NOT NULL COMMENT '修改时间',
                                     `app_name` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                     `tenant_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '' COMMENT '租户字段',
                                     PRIMARY KEY (`id`) USING BTREE,
                                     UNIQUE INDEX `uk_configinfoaggr_datagrouptenantdatum`(`data_id` ASC, `group_id` ASC, `tenant_id` ASC, `datum_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = '增加租户字段' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of config_info_aggr
-- ----------------------------

-- ----------------------------
-- Table structure for config_info_beta
-- ----------------------------
DROP TABLE IF EXISTS `config_info_beta`;
CREATE TABLE `config_info_beta`  (
                                     `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
                                     `data_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'data_id',
                                     `group_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'group_id',
                                     `app_name` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT 'app_name',
                                     `content` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'content',
                                     `beta_ips` varchar(1024) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT 'betaIps',
                                     `md5` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT 'md5',
                                     `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                     `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
                                     `src_user` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL COMMENT 'source user',
                                     `src_ip` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT 'source ip',
                                     `tenant_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '' COMMENT '租户字段',
                                     PRIMARY KEY (`id`) USING BTREE,
                                     UNIQUE INDEX `uk_configinfobeta_datagrouptenant`(`data_id` ASC, `group_id` ASC, `tenant_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = 'config_info_beta' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of config_info_beta
-- ----------------------------

-- ----------------------------
-- Table structure for config_info_tag
-- ----------------------------
DROP TABLE IF EXISTS `config_info_tag`;
CREATE TABLE `config_info_tag`  (
                                    `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
                                    `data_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'data_id',
                                    `group_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'group_id',
                                    `tenant_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '' COMMENT 'tenant_id',
                                    `tag_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'tag_id',
                                    `app_name` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT 'app_name',
                                    `content` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'content',
                                    `md5` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT 'md5',
                                    `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                    `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
                                    `src_user` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL COMMENT 'source user',
                                    `src_ip` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT 'source ip',
                                    PRIMARY KEY (`id`) USING BTREE,
                                    UNIQUE INDEX `uk_configinfotag_datagrouptenanttag`(`data_id` ASC, `group_id` ASC, `tenant_id` ASC, `tag_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = 'config_info_tag' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of config_info_tag
-- ----------------------------

-- ----------------------------
-- Table structure for config_tags_relation
-- ----------------------------
DROP TABLE IF EXISTS `config_tags_relation`;
CREATE TABLE `config_tags_relation`  (
                                         `id` bigint NOT NULL COMMENT 'id',
                                         `tag_name` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'tag_name',
                                         `tag_type` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT 'tag_type',
                                         `data_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'data_id',
                                         `group_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'group_id',
                                         `tenant_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '' COMMENT 'tenant_id',
                                         `nid` bigint NOT NULL AUTO_INCREMENT,
                                         PRIMARY KEY (`nid`) USING BTREE,
                                         UNIQUE INDEX `uk_configtagrelation_configidtag`(`id` ASC, `tag_name` ASC, `tag_type` ASC) USING BTREE,
                                         INDEX `idx_tenant_id`(`tenant_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = 'config_tag_relation' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of config_tags_relation
-- ----------------------------

-- ----------------------------
-- Table structure for group_capacity
-- ----------------------------
DROP TABLE IF EXISTS `group_capacity`;
CREATE TABLE `group_capacity`  (
                                   `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
                                   `group_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL DEFAULT '' COMMENT 'Group ID，空字符表示整个集群',
                                   `quota` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '配额，0表示使用默认值',
                                   `usage` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '使用量',
                                   `max_size` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
                                   `max_aggr_count` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '聚合子配置最大个数，，0表示使用默认值',
                                   `max_aggr_size` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
                                   `max_history_count` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '最大变更历史数量',
                                   `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                   `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
                                   PRIMARY KEY (`id`) USING BTREE,
                                   UNIQUE INDEX `uk_group_id`(`group_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = '集群、各Group容量信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of group_capacity
-- ----------------------------

-- ----------------------------
-- Table structure for his_config_info
-- ----------------------------
DROP TABLE IF EXISTS `his_config_info`;
CREATE TABLE `his_config_info`  (
                                    `id` bigint UNSIGNED NOT NULL,
                                    `nid` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
                                    `data_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                    `group_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                    `app_name` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT 'app_name',
                                    `content` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                    `md5` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                    `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                    `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                    `src_user` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL,
                                    `src_ip` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                    `op_type` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                    `tenant_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '' COMMENT '租户字段',
                                    PRIMARY KEY (`nid`) USING BTREE,
                                    INDEX `idx_gmt_create`(`gmt_create` ASC) USING BTREE,
                                    INDEX `idx_gmt_modified`(`gmt_modified` ASC) USING BTREE,
                                    INDEX `idx_did`(`data_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 155 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = '多租户改造' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of his_config_info
-- ----------------------------
INSERT INTO `his_config_info` VALUES (2, 127, 'hoj-dev.yml', 'DEFAULT_GROUP', '', 'hoj:\n  jwt:\n    # 加密秘钥\n    secret: hoj-secret-init\n    # token有效时长，1天，单位秒\n    expire: 86400\n    checkRefreshExpire: 43200\n    header: token\n  judge:\n    # 调用判题服务器的token\n    token: 5bf20d712fbb4038813935a490da050f\n  db:\n    host: 127.0.0.1\n    port: 3307\n    public-host: 127.0.0.1\n    public-port: 3307\n    name: hoj\n    username: root\n    password: 123456\n  redis:\n    host: 127.0.0.1\n    port: 6379\n    password: 123456', 'f46b228fda281139dc0826d321e3dd4c', '2023-09-05 21:44:25', '2023-09-05 08:44:25', 'root', '172.20.0.1', 'U', '');
INSERT INTO `his_config_info` VALUES (2, 128, 'hoj-dev.yml', 'DEFAULT_GROUP', '', 'hoj:\n  jwt:\n    # 加密秘钥\n    secret: hoj-secret-init\n    # token有效时长，1天，单位秒\n    expire: 86400\n    checkRefreshExpire: 43200\n    header: token\n  judge:\n    # 调用判题服务器的token\n    token: 130c1ae23a2a403886062877c88a0e98\n  db:\n    host: 127.0.0.1\n    port: 3307\n    public-host: 127.0.0.1\n    public-port: 3307\n    name: hoj\n    username: root\n    password: 123456\n  redis:\n    host: 127.0.0.1\n    port: 6379\n    password: 123456', 'a41c4c690f7dcf57ba3569a0e9d2d36f', '2023-09-05 21:55:25', '2023-09-05 08:55:26', 'root', '172.20.0.1', 'U', '');
INSERT INTO `his_config_info` VALUES (2, 129, 'hoj-dev.yml', 'DEFAULT_GROUP', '', 'hoj:\n  jwt:\n    # 加密秘钥\n    secret: hoj-secret-init\n    # token有效时长，1天，单位秒\n    expire: 86400\n    checkRefreshExpire: 43200\n    header: token\n  judge:\n    # 调用判题服务器的token\n    token: c646195ae55d47739d76a2a1f5038081\n  db:\n    host: 127.0.0.1\n    port: 3307\n    public-host: 127.0.0.1\n    public-port: 3307\n    name: hoj\n    username: root\n    password: 123456\n  redis:\n    host: 127.0.0.1\n    port: 6379\n    password: 123456', 'b55d37f0de4e8510c761f0f5654967a1', '2023-09-06 01:40:53', '2023-09-05 12:40:53', 'root', '172.20.0.1', 'U', '');
INSERT INTO `his_config_info` VALUES (2, 130, 'hoj-dev.yml', 'DEFAULT_GROUP', '', 'hoj:\n  jwt:\n    # 加密秘钥\n    secret: hoj-secret-init\n    # token有效时长，1天，单位秒\n    expire: 86400\n    checkRefreshExpire: 43200\n    header: token\n  judge:\n    # 调用判题服务器的token\n    token: ee2c6471788c4c539e296d435bfd8c8c\n  db:\n    host: 127.0.0.1\n    port: 3307\n    public-host: 127.0.0.1\n    public-port: 3307\n    name: hoj\n    username: root\n    password: 123456\n  redis:\n    host: 127.0.0.1\n    port: 6379\n    password: 123456', '6fd0329bc20cd50dc0aa84ee578a211e', '2023-09-10 16:51:20', '2023-09-10 03:51:21', 'root', '172.20.0.1', 'U', '');
INSERT INTO `his_config_info` VALUES (2, 131, 'hoj-dev.yml', 'DEFAULT_GROUP', '', 'hoj:\n  jwt:\n    # 加密秘钥\n    secret: hoj-secret-init\n    # token有效时长，1天，单位秒\n    expire: 86400\n    checkRefreshExpire: 43200\n    header: token\n  judge:\n    # 调用判题服务器的token\n    token: b4d76620bf4e44a6b6de46ba064d074f\n  db:\n    host: 127.0.0.1\n    port: 3307\n    public-host: 127.0.0.1\n    public-port: 3307\n    name: hoj\n    username: root\n    password: 123456\n  redis:\n    host: 127.0.0.1\n    port: 6379\n    password: 123456', '021626e3fb93a7009ae8dafa74d5ed4a', '2023-09-10 18:42:16', '2023-09-10 05:42:17', 'root', '172.20.0.1', 'U', '');
INSERT INTO `his_config_info` VALUES (2, 132, 'hoj-dev.yml', 'DEFAULT_GROUP', '', 'hoj:\n  jwt:\n    # 加密秘钥\n    secret: hoj-secret-init\n    # token有效时长，1天，单位秒\n    expire: 86400\n    checkRefreshExpire: 43200\n    header: token\n  judge:\n    # 调用判题服务器的token\n    token: 6dbc51b1e527483fabea469e1f34519d\n  db:\n    host: 127.0.0.1\n    port: 3307\n    public-host: 127.0.0.1\n    public-port: 3307\n    name: hoj\n    username: root\n    password: 123456\n  redis:\n    host: 127.0.0.1\n    port: 6379\n    password: 123456', '01d8e6f64754e2757068523bf878afa8', '2023-09-10 21:53:04', '2023-09-10 08:53:05', 'root', '172.20.0.1', 'U', '');
INSERT INTO `his_config_info` VALUES (2, 133, 'hoj-dev.yml', 'DEFAULT_GROUP', '', 'hoj:\n  jwt:\n    # 加密秘钥\n    secret: hoj-secret-init\n    # token有效时长，1天，单位秒\n    expire: 86400\n    checkRefreshExpire: 43200\n    header: token\n  judge:\n    # 调用判题服务器的token\n    token: a69f06eef813442babdb03f5d88e9cb9\n  db:\n    host: 127.0.0.1\n    port: 3307\n    public-host: 127.0.0.1\n    public-port: 3307\n    name: hoj\n    username: root\n    password: 123456\n  redis:\n    host: 127.0.0.1\n    port: 6379\n    password: 123456', 'fc372d74a919fdcadd94d0d73f81f204', '2023-09-10 22:00:17', '2023-09-10 09:00:17', 'root', '172.20.0.1', 'U', '');
INSERT INTO `his_config_info` VALUES (2, 134, 'hoj-dev.yml', 'DEFAULT_GROUP', '', 'hoj:\n  jwt:\n    # 加密秘钥\n    secret: hoj-secret-init\n    # token有效时长，1天，单位秒\n    expire: 86400\n    checkRefreshExpire: 43200\n    header: token\n  judge:\n    # 调用判题服务器的token\n    token: f0c208003c9348b0bc76fa4efdf05cc1\n  db:\n    host: 127.0.0.1\n    port: 3307\n    public-host: 127.0.0.1\n    public-port: 3307\n    name: hoj\n    username: root\n    password: 123456\n  redis:\n    host: 127.0.0.1\n    port: 6379\n    password: 123456', 'f79bcc6cc90eb3a05486263914233c94', '2023-09-12 22:15:29', '2023-09-12 09:15:30', 'root', '172.20.0.1', 'U', '');
INSERT INTO `his_config_info` VALUES (2, 135, 'hoj-dev.yml', 'DEFAULT_GROUP', '', 'hoj:\n  jwt:\n    # 加密秘钥\n    secret: hoj-secret-init\n    # token有效时长，1天，单位秒\n    expire: 86400\n    checkRefreshExpire: 43200\n    header: token\n  judge:\n    # 调用判题服务器的token\n    token: f543fc0458c84a158027b9d7426aa69d\n  db:\n    host: 127.0.0.1\n    port: 3307\n    public-host: 127.0.0.1\n    public-port: 3307\n    name: hoj\n    username: root\n    password: 123456\n  redis:\n    host: 127.0.0.1\n    port: 6379\n    password: 123456', 'e2d3314086b2733a05295cf9610ca084', '2023-09-13 22:32:31', '2023-09-13 09:32:31', 'root', '172.20.0.1', 'U', '');
INSERT INTO `his_config_info` VALUES (2, 136, 'hoj-dev.yml', 'DEFAULT_GROUP', '', 'hoj:\n  jwt:\n    # 加密秘钥\n    secret: hoj-secret-init\n    # token有效时长，1天，单位秒\n    expire: 86400\n    checkRefreshExpire: 43200\n    header: token\n  judge:\n    # 调用判题服务器的token\n    token: c82871aaa2344e61ad57e122048b58af\n  db:\n    host: 127.0.0.1\n    port: 3307\n    public-host: 127.0.0.1\n    public-port: 3307\n    name: hoj\n    username: root\n    password: 123456\n  redis:\n    host: 127.0.0.1\n    port: 6379\n    password: 123456', '7ef8ba9a5d2ccf1693e36982d3ae4f9f', '2023-09-13 23:50:01', '2023-09-13 10:50:01', 'root', '172.20.0.1', 'U', '');
INSERT INTO `his_config_info` VALUES (13, 137, 'loj-sit.yml', 'DEFAULT_GROUP', '', 'loj:\n    db:\n        name: hoj\n        host: 127.0.0.1\n        port: 3307\n        public-host: 127.0.0.1\n        public-port: 3307\n        username: root\n        password: 123456\n    jwt:\n        # 加密秘钥\n        secret: loj-secret-hinit\n        # token默认为24小时 86400s\n        expire: 86400\n        checkRefreshExpire: 43200\n        header: token\n    judge:\n    # 调用判题服务器的token\n        token: 74ec7088edd240e0be953632ed3c17f7\n    redis:\n        host: 127.0.0.1\n        port: 6379\n        password: 123456', '686f3d995d2478b91c7cd2329a6b0c4b', '2023-09-14 03:36:11', '2023-09-13 14:36:12', 'root', '172.20.0.1', 'U', '');
INSERT INTO `his_config_info` VALUES (13, 138, 'loj-sit.yml', 'DEFAULT_GROUP', '', 'loj:\n    db:\n        name: hoj\n        host: 172.20.0.3\n        port: 3306\n        public-host: 127.0.0.1\n        public-port: 3307\n        username: root\n        password: 123456\n    jwt:\n        # 加密秘钥\n        secret: loj-secret-hinit\n        # token默认为24小时 86400s\n        expire: 86400\n        checkRefreshExpire: 43200\n        header: token\n    judge:\n    # 调用判题服务器的token\n        token: 74ec7088edd240e0be953632ed3c17f7\n    redis:\n        host: 127.0.0.1\n        port: 6379\n        password: 123456', '54812376363ba18079b993e90e1c356b', '2023-09-14 21:44:11', '2023-09-14 08:44:11', 'root', '172.20.0.1', 'U', '');
INSERT INTO `his_config_info` VALUES (13, 139, 'loj-sit.yml', 'DEFAULT_GROUP', '', 'loj:\n    db:\n        name: hoj\n        host: 127.0.0.1\n        port: 3306\n        public-host: 127.0.0.1\n        public-port: 3307\n        username: root\n        password: 123456\n    jwt:\n        # 加密秘钥\n        secret: loj-secret-hinit\n        # token默认为24小时 86400s\n        expire: 86400\n        checkRefreshExpire: 43200\n        header: token\n    judge:\n    # 调用判题服务器的token\n        token: 74ec7088edd240e0be953632ed3c17f7\n    redis:\n        host: 127.0.0.1\n        port: 6379\n        password: 123456', '726b783a248d6a422be0be9735ec8dea', '2023-09-14 21:44:59', '2023-09-14 08:45:00', 'root', '172.20.0.1', 'U', '');
INSERT INTO `his_config_info` VALUES (13, 140, 'loj-sit.yml', 'DEFAULT_GROUP', '', 'loj:\n    db:\n        name: hoj\n        host: 127.0.0.1\n        port: 3306\n        public-host: 127.0.0.1\n        public-port: 3307\n        username: root\n        password: 123456\n    jwt:\n        # 加密秘钥\n        secret: loj-secret-hinit\n        # token默认为24小时 86400s\n        expire: 86400\n        checkRefreshExpire: 43200\n        header: token\n    judge:\n    # 调用判题服务器的token\n        token: 74ec7088edd240e0be953632ed3c17f7\n    redis:\n        host: 127.0.0.1\n        port: 6379\n        password: 123456', '726b783a248d6a422be0be9735ec8dea', '2023-09-14 21:45:43', '2023-09-14 08:45:44', 'root', '172.20.0.1', 'U', '');
INSERT INTO `his_config_info` VALUES (13, 141, 'loj-sit.yml', 'DEFAULT_GROUP', '', 'loj:\n    db:\n        name: hoj\n        host: 127.0.0.1\n        port: 3307\n        public-host: 127.0.0.1\n        public-port: 3307\n        username: root\n        password: 123456\n    jwt:\n        # 加密秘钥\n        secret: loj-secret-hinit\n        # token默认为24小时 86400s\n        expire: 86400\n        checkRefreshExpire: 43200\n        header: token\n    judge:\n    # 调用判题服务器的token\n        token: 74ec7088edd240e0be953632ed3c17f7\n    redis:\n        host: 127.0.0.1\n        port: 6379\n        password: 123456', '686f3d995d2478b91c7cd2329a6b0c4b', '2023-09-14 21:47:26', '2023-09-14 08:47:26', 'root', '172.20.0.1', 'U', '');
INSERT INTO `his_config_info` VALUES (13, 142, 'loj-sit.yml', 'DEFAULT_GROUP', '', 'loj:\n    db:\n        name: hoj\n        host: 172.20.0.3\n        port: 3306\n        public-host: 127.0.0.1\n        public-port: 3307\n        username: root\n        password: 123456\n    jwt:\n        # 加密秘钥\n        secret: loj-secret-hinit\n        # token默认为24小时 86400s\n        expire: 86400\n        checkRefreshExpire: 43200\n        header: token\n    judge:\n    # 调用判题服务器的token\n        token: 74ec7088edd240e0be953632ed3c17f7\n    redis:\n        host: 172.20.0.2\n        port: 6379\n        password: 123456', 'df6bb839d223f350f323649a42aada69', '2023-09-14 22:05:13', '2023-09-14 09:05:13', 'root', '172.20.0.1', 'U', '');
INSERT INTO `his_config_info` VALUES (13, 143, 'loj-sit.yml', 'DEFAULT_GROUP', '', 'loj:\n    db:\n        name: hoj\n        host: 127.0.0.1\n        port: 3307\n        public-host: 127.0.0.1\n        public-port: 3307\n        username: root\n        password: 123456\n    jwt:\n        # 加密秘钥\n        secret: loj-secret-hinit\n        # token默认为24小时 86400s\n        expire: 86400\n        checkRefreshExpire: 43200\n        header: token\n    judge:\n    # 调用判题服务器的token\n        token: 74ec7088edd240e0be953632ed3c17f7\n    redis:\n        host: 172.20.0.2\n        port: 6379\n        password: 123456', '84cfae5e93774ec7f2d0582a78038c7e', '2023-09-14 22:06:27', '2023-09-14 09:06:28', 'root', '172.20.0.1', 'U', '');
INSERT INTO `his_config_info` VALUES (13, 144, 'loj-sit.yml', 'DEFAULT_GROUP', '', 'loj:\n    db:\n        name: hoj\n        host: 127.0.0.1\n        port: 3307\n        public-host: 127.0.0.1\n        public-port: 3307\n        username: root\n        password: 123456\n    jwt:\n        # 加密秘钥\n        secret: loj-secret-hinit\n        # token默认为24小时 86400s\n        expire: 86400\n        checkRefreshExpire: 43200\n        header: token\n    judge:\n    # 调用判题服务器的token\n        token: 74ec7088edd240e0be953632ed3c17f7\n    redis:\n        host: 127.0.0.1\n        port: 6379\n        password: 123456', '686f3d995d2478b91c7cd2329a6b0c4b', '2023-09-14 22:08:20', '2023-09-14 09:08:20', 'root', '172.20.0.1', 'U', '');
INSERT INTO `his_config_info` VALUES (2, 145, 'hoj-dev.yml', 'DEFAULT_GROUP', '', 'hoj:\n  jwt:\n    # 加密秘钥\n    secret: hoj-secret-init\n    # token有效时长，1天，单位秒\n    expire: 86400\n    checkRefreshExpire: 43200\n    header: token\n  judge:\n    # 调用判题服务器的token\n    token: b82bebd1122b435c8cd4285da5647be0\n  db:\n    host: 127.0.0.1\n    port: 3307\n    public-host: 127.0.0.1\n    public-port: 3307\n    name: hoj\n    username: root\n    password: 123456\n  redis:\n    host: 127.0.0.1\n    port: 6379\n    password: 123456', 'abc6ed3966614791f9c27ab2b70e6f64', '2023-09-14 22:20:18', '2023-09-14 09:20:19', 'root', '172.20.0.1', 'U', '');
INSERT INTO `his_config_info` VALUES (2, 146, 'hoj-dev.yml', 'DEFAULT_GROUP', '', 'hoj:\n  jwt:\n    # 加密秘钥\n    secret: hoj-secret-init\n    # token有效时长，1天，单位秒\n    expire: 86400\n    checkRefreshExpire: 43200\n    header: token\n  judge:\n    # 调用判题服务器的token\n    token: 7cc70cc6753140a5bca601c873910622\n  db:\n    host: 127.0.0.1\n    port: 3307\n    public-host: 127.0.0.1\n    public-port: 3307\n    name: hoj\n    username: root\n    password: 123456\n  redis:\n    host: 127.0.0.1\n    port: 6379\n    password: 123456', '84606e822e7e5d9f85becbef16d04b64', '2023-09-14 22:21:00', '2023-09-14 09:21:01', 'root', '172.20.0.1', 'U', '');
INSERT INTO `his_config_info` VALUES (0, 147, 'loj-pro.yml', 'DEFAULT_GROUP', '', 'loj:\r\n    db:\r\n        name: loj\r\n        host: 127.0.0.1\r\n        port: 3307\r\n        public-host: 127.0.0.1\r\n        public-port: 3307\r\n        username: root\r\n        password: 123456\r\n    jwt:\r\n        # 加密秘钥\r\n        secret: loj-secret-hinit\r\n        # token默认为24小时 86400s\r\n        expire: 86400\r\n        checkRefreshExpire: 43200\r\n        header: token\r\n    judge:\r\n    # 调用判题服务器的token\r\n        token: 74ec7088edd240e0be953632ed3c17f7\r\n    redis:\r\n        host: 127.0.0.1\r\n        port: 6379\r\n        password: 123456', 'ee435472a90c5307a0052c1f7da924ea', '2023-09-14 22:38:08', '2023-09-14 09:38:08', 'root', '172.20.0.1', 'I', '');
INSERT INTO `his_config_info` VALUES (147, 148, 'loj-pro.yml', 'DEFAULT_GROUP', '', 'loj:\r\n    db:\r\n        name: loj\r\n        host: 127.0.0.1\r\n        port: 3307\r\n        public-host: 127.0.0.1\r\n        public-port: 3307\r\n        username: root\r\n        password: 123456\r\n    jwt:\r\n        # 加密秘钥\r\n        secret: loj-secret-hinit\r\n        # token默认为24小时 86400s\r\n        expire: 86400\r\n        checkRefreshExpire: 43200\r\n        header: token\r\n    judge:\r\n    # 调用判题服务器的token\r\n        token: 74ec7088edd240e0be953632ed3c17f7\r\n    redis:\r\n        host: 127.0.0.1\r\n        port: 6379\r\n        password: 123456', 'ee435472a90c5307a0052c1f7da924ea', '2023-09-14 22:47:19', '2023-09-14 09:47:19', 'root', '172.20.0.1', 'U', '');
INSERT INTO `his_config_info` VALUES (147, 149, 'loj-pro.yml', 'DEFAULT_GROUP', '', 'loj:\n    db:\n        name: loj\n        host: 127.0.0.1\n        port: 3307\n        public-host: 127.0.0.1\n        public-port: 3307\n        username: root\n        password: 123456\n    jwt:\n        # 加密秘钥\n        secret: loj-secret-hinit\n        # token默认为24小时 86400s\n        expire: 86400\n        checkRefreshExpire: 43200\n        header: token\n    judge:\n    # 调用判题服务器的token\n        token: 74ec7088edd240e0be953632ed3c17f7\n    redis:\n        host: 127.0.0.1\n        port: 6379\n        password: 123456', '3af32703ea9599a85710709cb82a6744', '2023-09-14 23:03:28', '2023-09-14 10:03:28', 'root', '172.20.0.1', 'U', '');
INSERT INTO `his_config_info` VALUES (147, 150, 'loj-pro.yml', 'DEFAULT_GROUP', '', 'loj:\n    db:\n        name: hoj\n        host: 172.20.0.3\n        port: 3306\n        public-host: 172.20.0.3\n        public-port: 3306\n        username: root\n        password: 123456\n    jwt:\n        # 加密秘钥\n        secret: loj-secret-hinit\n        # token默认为24小时 86400s\n        expire: 86400\n        checkRefreshExpire: 43200\n        header: token\n    judge:\n    # 调用判题服务器的token\n        token: 74ec7088edd240e0be953632ed3c17f7\n    redis:\n        host: 172.20.0.2\n        port: 6379\n        password: 123456', '5d6620df957ca8f992139e164f626993', '2023-09-15 01:27:35', '2023-09-14 12:27:35', 'root', '172.20.0.1', 'U', '');
INSERT INTO `his_config_info` VALUES (147, 151, 'loj-pro.yml', 'DEFAULT_GROUP', '', 'loj:\n    db:\n        name: loj\n        host: 127.0.0.1\n        port: 3307\n        public-host: 127.0.0.1\n        public-port: 3307\n        username: root\n        password: 123456\n    jwt:\n        # 加密秘钥\n        secret: loj-secret-hinit\n        # token默认为24小时 86400s\n        expire: 86400\n        checkRefreshExpire: 43200\n        header: token\n    judge:\n    # 调用判题服务器的token\n        token: 74ec7088edd240e0be953632ed3c17f7\n    redis:\n        host: 127.0.0.1\n        port: 6379\n        password: 123456', '3af32703ea9599a85710709cb82a6744', '2023-09-15 01:28:21', '2023-09-14 12:28:22', 'root', '172.20.0.1', 'U', '');
INSERT INTO `his_config_info` VALUES (147, 152, 'loj-pro.yml', 'DEFAULT_GROUP', '', 'loj:\n    db:\n        name: loj\n        host: 127.0.0.1\n        port: 3307\n        public-host: 127.0.0.1\n        public-port: 3307\n        username: root\n        password: 123456\n    jwt:\n        # 加密秘钥\n        secret: loj-secret-hinit\n        # token默认为24小时 86400s\n        expire: 86400\n        checkRefreshExpire: 43200\n        header: token\n    judge:\n    # 调用判题服务器的token\n        token: 74ec7088edd240e0be953632ed3c17f7\n    redis:\n        host: 127.0.0.1\n        port: 6379\n        password: 123456', '3af32703ea9599a85710709cb82a6744', '2023-09-15 01:28:44', '2023-09-14 12:28:44', 'root', '172.20.0.1', 'U', '');
INSERT INTO `his_config_info` VALUES (147, 153, 'loj-pro.yml', 'DEFAULT_GROUP', '', 'loj:\n    db:\n        name: loj\n        host: 127.0.0.1\n        port: 3307\n        public-host: 127.0.0.1\n        public-port: 3307\n        username: root\n        password: 123456\n    jwt:\n        # 加密秘钥\n        secret: loj-secret-hinit\n        # token默认为24小时 86400s\n        expire: 86400\n        checkRefreshExpire: 43200\n        header: token\n    judge:\n    # 调用判题服务器的token\n        token: 74ec7088edd240e0be953632ed3c17f7\n    redis:\n        host: 127.0.0.1\n        port: 6379\n        password: 123456', '3af32703ea9599a85710709cb82a6744', '2023-09-15 01:32:55', '2023-09-14 12:32:56', 'root', '172.20.0.1', 'U', '');
INSERT INTO `his_config_info` VALUES (147, 154, 'loj-pro.yml', 'DEFAULT_GROUP', '', 'loj:\n    db:\n        name: hoj\n        host: 172.20.0.3\n        port: 3306\n        public-host: 172.20.0.3\n        public-port: 3306\n        username: root\n        password: 123456\n    jwt:\n        # 加密秘钥\n        secret: loj-secret-hinit\n        # token默认为24小时 86400s\n        expire: 86400\n        checkRefreshExpire: 43200\n        header: token\n    judge:\n    # 调用判题服务器的token\n        token: 74ec7088edd240e0be953632ed3c17f7\n    redis:\n        host: 172.20.0.2\n        port: 6379\n        password: 123456', '5d6620df957ca8f992139e164f626993', '2023-09-16 00:31:13', '2023-09-15 11:31:14', 'root', '172.20.0.1', 'U', '');

-- ----------------------------
-- Table structure for permissions
-- ----------------------------
DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions`  (
                                `role` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
                                `resource` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
                                `action` varchar(8) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
                                UNIQUE INDEX `uk_role_permission`(`role` ASC, `resource` ASC, `action` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of permissions
-- ----------------------------

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
                          `username` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
                          `role` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
                          UNIQUE INDEX `idx_user_role`(`username` ASC, `role` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES ('root', 'ROLE_ADMIN');

-- ----------------------------
-- Table structure for tenant_capacity
-- ----------------------------
DROP TABLE IF EXISTS `tenant_capacity`;
CREATE TABLE `tenant_capacity`  (
                                    `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
                                    `tenant_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL DEFAULT '' COMMENT 'Tenant ID',
                                    `quota` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '配额，0表示使用默认值',
                                    `usage` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '使用量',
                                    `max_size` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
                                    `max_aggr_count` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '聚合子配置最大个数',
                                    `max_aggr_size` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
                                    `max_history_count` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '最大变更历史数量',
                                    `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                    `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
                                    PRIMARY KEY (`id`) USING BTREE,
                                    UNIQUE INDEX `uk_tenant_id`(`tenant_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = '租户容量信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tenant_capacity
-- ----------------------------

-- ----------------------------
-- Table structure for tenant_info
-- ----------------------------
DROP TABLE IF EXISTS `tenant_info`;
CREATE TABLE `tenant_info`  (
                                `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
                                `kp` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'kp',
                                `tenant_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '' COMMENT 'tenant_id',
                                `tenant_name` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '' COMMENT 'tenant_name',
                                `tenant_desc` varchar(256) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT 'tenant_desc',
                                `create_source` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT 'create_source',
                                `gmt_create` bigint NOT NULL COMMENT '创建时间',
                                `gmt_modified` bigint NOT NULL COMMENT '修改时间',
                                PRIMARY KEY (`id`) USING BTREE,
                                UNIQUE INDEX `uk_tenant_info_kptenantid`(`kp` ASC, `tenant_id` ASC) USING BTREE,
                                INDEX `idx_tenant_id`(`tenant_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = 'tenant_info' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tenant_info
-- ----------------------------

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
                          `username` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
                          `password` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
                          `enabled` tinyint(1) NOT NULL,
                          PRIMARY KEY (`username`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('nacos', '$2a$10$qV.x3xp3ObM1vL1/xLDq.uhsajf0L/mc1.mdHeyQaqDA8b4LW.mYW', 1);
INSERT INTO `users` VALUES ('root', '$2a$04$ux1QaAGezQ5qiyIm0OYepuN1XBCQKYv2A4da6Zf7OzZ/F9NB6a.N.', 1);

SET FOREIGN_KEY_CHECKS = 1;
