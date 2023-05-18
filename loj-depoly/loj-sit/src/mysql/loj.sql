/*
 Navicat Premium Data Transfer

 Source Server         : HOJ
 Source Server Type    : MySQL
 Source Server Version : 80026
 Source Host           : localhost:3307
 Source Schema         : hoj

 Target Server Type    : MySQL
 Target Server Version : 80026
 File Encoding         : 65001

 Date: 18/05/2023 22:15:07
*/

CREATE DATABASE IF NOT EXISTS`hoj` DEFAULT CHARACTER SET utf8;

USE `hoj`;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin_sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `admin_sys_notice`;
CREATE TABLE `admin_sys_notice`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '发给哪些用户类型',
  `state` tinyint(1) NULL DEFAULT 0 COMMENT '是否已拉取给用户',
  `recipient_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '接受通知的用户id',
  `admin_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '发送通知的管理员id',
  `gmt_create` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `recipient_id`(`recipient_id`) USING BTREE,
  INDEX `admin_id`(`admin_id`) USING BTREE,
  CONSTRAINT `admin_sys_notice_ibfk_1` FOREIGN KEY (`recipient_id`) REFERENCES `user_info` (`uuid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `admin_sys_notice_ibfk_2` FOREIGN KEY (`admin_id`) REFERENCES `user_info` (`uuid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_sys_notice
-- ----------------------------
INSERT INTO `admin_sys_notice` VALUES (1, '账号异地登录通知(Account Remote Login Notice)', '亲爱的用户，您好！您的账号于2023-04-25 21:43:57在【 本机地址】登录，登录IP为：【127.0.0.1】，若非本人操作，请立即修改密码。\n\nHello! Dear user, Your account was logged in in 【 本机地址】 on 2023-04-25 21:43:57. If you do not operate by yourself, please change your password immediately.', 'Single', 1, '1', '1', '2023-04-25 21:43:58', '2023-04-25 21:43:58');
INSERT INTO `admin_sys_notice` VALUES (2, '账号异地登录通知(Account Remote Login Notice)', '亲爱的用户，您好！您的账号于2023-04-26 22:07:55在【广东省深圳市 电信】登录，登录IP为：【0:0:0:0:0:0:0:1】，若非本人操作，请立即修改密码。\n\nHello! Dear user, Your account was logged in in 【广东省深圳市 电信】 on 2023-04-26 22:07:55. If you do not operate by yourself, please change your password immediately.', 'Single', 1, '1', '1', '2023-04-26 22:07:56', '2023-04-26 22:07:57');
INSERT INTO `admin_sys_notice` VALUES (3, '账号异地登录通知(Account Remote Login Notice)', '亲爱的用户，您好！您的账号于2023-04-27 23:41:52在【 本机地址】登录，登录IP为：【127.0.0.1】，若非本人操作，请立即修改密码。\n\nHello! Dear user, Your account was logged in in 【 本机地址】 on 2023-04-27 23:41:52. If you do not operate by yourself, please change your password immediately.', 'Single', 1, '1', '1', '2023-04-27 23:41:53', '2023-04-27 23:41:53');
INSERT INTO `admin_sys_notice` VALUES (4, '账号异地登录通知(Account Remote Login Notice)', '亲爱的用户，您好！您的账号于2023-05-05 00:45:13在【广东省深圳市 电信】登录，登录IP为：【0:0:0:0:0:0:0:1】，若非本人操作，请立即修改密码。\n\nHello! Dear user, Your account was logged in in 【广东省深圳市 电信】 on 2023-05-05 00:45:13. If you do not operate by yourself, please change your password immediately.', 'Single', 1, '1', '1', '2023-05-05 00:45:14', '2023-05-05 00:45:14');
INSERT INTO `admin_sys_notice` VALUES (5, '账号异地登录通知(Account Remote Login Notice)', '亲爱的用户，您好！您的账号于2023-05-06 01:11:59在【 本机地址】登录，登录IP为：【127.0.0.1】，若非本人操作，请立即修改密码。\n\nHello! Dear user, Your account was logged in in 【 本机地址】 on 2023-05-06 01:11:59. If you do not operate by yourself, please change your password immediately.', 'Single', 1, '1', '1', '2023-05-06 01:12:00', '2023-05-06 01:12:00');
INSERT INTO `admin_sys_notice` VALUES (6, '账号异地登录通知(Account Remote Login Notice)', '亲爱的用户，您好！您的账号于2023-05-06 01:16:15在【广东省深圳市 电信】登录，登录IP为：【0:0:0:0:0:0:0:1】，若非本人操作，请立即修改密码。\n\nHello! Dear user, Your account was logged in in 【广东省深圳市 电信】 on 2023-05-06 01:16:15. If you do not operate by yourself, please change your password immediately.', 'Single', 1, '1', '1', '2023-05-06 01:16:16', '2023-05-06 01:16:16');
INSERT INTO `admin_sys_notice` VALUES (7, '权限变更通知(Authority Change Notice)', '您好，您的权限产生了变更，由【普通用户(默认)】变更为【普通管理员】。部分权限可能与之前有所不同，请您注意！\n\nHello, your permission has been changed from 【Normal User(Default)】 to 【General Administrator】. Some permissions may be different from before. Please note!', 'Single', 1, 'ffb14501ad9a41a2ad7c46105e23cbb7', '1', '2023-05-06 20:24:11', '2023-05-06 20:24:11');
INSERT INTO `admin_sys_notice` VALUES (8, '账号异地登录通知(Account Remote Login Notice)', '亲爱的用户，您好！您的账号于2023-05-06 21:44:55在【 本机地址】登录，登录IP为：【127.0.0.1】，若非本人操作，请立即修改密码。\n\nHello! Dear user, Your account was logged in in 【 本机地址】 on 2023-05-06 21:44:55. If you do not operate by yourself, please change your password immediately.', 'Single', 1, '1', '1', '2023-05-06 21:44:57', '2023-05-06 21:44:57');
INSERT INTO `admin_sys_notice` VALUES (9, '账号异地登录通知(Account Remote Login Notice)', '亲爱的用户，您好！您的账号于2023-05-06 21:54:07在【广东省深圳市 电信】登录，登录IP为：【0:0:0:0:0:0:0:1】，若非本人操作，请立即修改密码。\n\nHello! Dear user, Your account was logged in in 【广东省深圳市 电信】 on 2023-05-06 21:54:07. If you do not operate by yourself, please change your password immediately.', 'Single', 1, '1', '1', '2023-05-06 21:54:08', '2023-05-06 21:54:08');
INSERT INTO `admin_sys_notice` VALUES (10, '账号异地登录通知(Account Remote Login Notice)', '亲爱的用户，您好！您的账号于2023-05-09 01:27:43在【 本机地址】登录，登录IP为：【127.0.0.1】，若非本人操作，请立即修改密码。\n\nHello! Dear user, Your account was logged in in 【 本机地址】 on 2023-05-09 01:27:43. If you do not operate by yourself, please change your password immediately.', 'Single', 1, '1', '1', '2023-05-09 01:27:44', '2023-05-09 01:27:44');
INSERT INTO `admin_sys_notice` VALUES (11, '账号异地登录通知(Account Remote Login Notice)', '亲爱的用户，您好！您的账号于2023-05-09 20:00:52在【广东省深圳市 电信ADSL】登录，登录IP为：【0:0:0:0:0:0:0:1】，若非本人操作，请立即修改密码。\n\nHello! Dear user, Your account was logged in in 【广东省深圳市 电信ADSL】 on 2023-05-09 20:00:52. If you do not operate by yourself, please change your password immediately.', 'Single', 1, '1', '1', '2023-05-09 20:00:53', '2023-05-09 20:00:53');
INSERT INTO `admin_sys_notice` VALUES (12, '账号异地登录通知(Account Remote Login Notice)', '亲爱的用户，您好！您的账号于2023-05-10 22:24:14在【 本机地址】登录，登录IP为：【127.0.0.1】，若非本人操作，请立即修改密码。\n\nHello! Dear user, Your account was logged in in 【 本机地址】 on 2023-05-10 22:24:14. If you do not operate by yourself, please change your password immediately.', 'Single', 1, '1', '1', '2023-05-10 22:24:15', '2023-05-10 22:24:15');
INSERT INTO `admin_sys_notice` VALUES (13, '账号异地登录通知(Account Remote Login Notice)', '亲爱的用户，您好！您的账号于2023-05-10 22:33:49在【广东省深圳市 电信】登录，登录IP为：【0:0:0:0:0:0:0:1】，若非本人操作，请立即修改密码。\n\nHello! Dear user, Your account was logged in in 【广东省深圳市 电信】 on 2023-05-10 22:33:49. If you do not operate by yourself, please change your password immediately.', 'Single', 1, '1', '1', '2023-05-10 22:33:50', '2023-05-10 22:33:50');
INSERT INTO `admin_sys_notice` VALUES (14, '账号异地登录通知(Account Remote Login Notice)', '亲爱的用户，您好！您的账号于2023-05-12 03:23:15在【 本机地址】登录，登录IP为：【127.0.0.1】，若非本人操作，请立即修改密码。\n\nHello! Dear user, Your account was logged in in 【 本机地址】 on 2023-05-12 03:23:15. If you do not operate by yourself, please change your password immediately.', 'Single', 1, '1', '1', '2023-05-12 03:23:16', '2023-05-12 03:23:16');
INSERT INTO `admin_sys_notice` VALUES (15, '账号异地登录通知(Account Remote Login Notice)', '亲爱的用户，您好！您的账号于2023-05-12 23:11:41在【广东省深圳市 电信】登录，登录IP为：【0:0:0:0:0:0:0:1】，若非本人操作，请立即修改密码。\n\nHello! Dear user, Your account was logged in in 【广东省深圳市 电信】 on 2023-05-12 23:11:41. If you do not operate by yourself, please change your password immediately.', 'Single', 1, '1', '1', '2023-05-12 23:11:42', '2023-05-12 23:11:43');
INSERT INTO `admin_sys_notice` VALUES (16, '账号异地登录通知(Account Remote Login Notice)', '亲爱的用户，您好！您的账号于2023-05-12 23:18:47在【 本机地址】登录，登录IP为：【127.0.0.1】，若非本人操作，请立即修改密码。\n\nHello! Dear user, Your account was logged in in 【 本机地址】 on 2023-05-12 23:18:47. If you do not operate by yourself, please change your password immediately.', 'Single', 1, '1', '1', '2023-05-12 23:18:48', '2023-05-12 23:18:48');
INSERT INTO `admin_sys_notice` VALUES (17, '账号异地登录通知(Account Remote Login Notice)', '亲爱的用户，您好！您的账号于2023-05-12 23:42:41在【广东省深圳市 电信】登录，登录IP为：【0:0:0:0:0:0:0:1】，若非本人操作，请立即修改密码。\n\nHello! Dear user, Your account was logged in in 【广东省深圳市 电信】 on 2023-05-12 23:42:41. If you do not operate by yourself, please change your password immediately.', 'Single', 1, '1', '1', '2023-05-12 23:42:42', '2023-05-12 23:42:42');
INSERT INTO `admin_sys_notice` VALUES (18, '账号异地登录通知(Account Remote Login Notice)', '亲爱的用户，您好！您的账号于2023-05-14 11:15:16在【 本机地址】登录，登录IP为：【127.0.0.1】，若非本人操作，请立即修改密码。\n\nHello! Dear user, Your account was logged in in 【 本机地址】 on 2023-05-14 11:15:16. If you do not operate by yourself, please change your password immediately.', 'Single', 1, '1', '1', '2023-05-14 11:15:18', '2023-05-14 11:15:18');
INSERT INTO `admin_sys_notice` VALUES (19, '账号异地登录通知(Account Remote Login Notice)', '亲爱的用户，您好！您的账号于2023-05-14 18:40:58在【广东省深圳市 电信】登录，登录IP为：【0:0:0:0:0:0:0:1】，若非本人操作，请立即修改密码。\n\nHello! Dear user, Your account was logged in in 【广东省深圳市 电信】 on 2023-05-14 18:40:58. If you do not operate by yourself, please change your password immediately.', 'Single', 1, '1', '1', '2023-05-14 18:41:00', '2023-05-14 18:41:00');
INSERT INTO `admin_sys_notice` VALUES (20, '账号异地登录通知(Account Remote Login Notice)', '亲爱的用户，您好！您的账号于2023-05-15 19:40:21在【 本机地址】登录，登录IP为：【127.0.0.1】，若非本人操作，请立即修改密码。\n\nHello! Dear user, Your account was logged in in 【 本机地址】 on 2023-05-15 19:40:21. If you do not operate by yourself, please change your password immediately.', 'Single', 1, '1', '1', '2023-05-15 19:40:22', '2023-05-15 19:40:22');
INSERT INTO `admin_sys_notice` VALUES (21, '账号异地登录通知(Account Remote Login Notice)', '亲爱的用户，您好！您的账号于2023-05-15 22:19:08在【广东省深圳市 电信】登录，登录IP为：【0:0:0:0:0:0:0:1】，若非本人操作，请立即修改密码。\n\nHello! Dear user, Your account was logged in in 【广东省深圳市 电信】 on 2023-05-15 22:19:08. If you do not operate by yourself, please change your password immediately.', 'Single', 1, '1', '1', '2023-05-15 22:19:10', '2023-05-15 22:19:10');
INSERT INTO `admin_sys_notice` VALUES (22, '账号异地登录通知(Account Remote Login Notice)', '亲爱的用户，您好！您的账号于2023-05-16 21:39:22在【 本机地址】登录，登录IP为：【127.0.0.1】，若非本人操作，请立即修改密码。\n\nHello! Dear user, Your account was logged in in 【 本机地址】 on 2023-05-16 21:39:22. If you do not operate by yourself, please change your password immediately.', 'Single', 1, '1', '1', '2023-05-16 21:39:24', '2023-05-16 21:39:24');
INSERT INTO `admin_sys_notice` VALUES (23, '账号异地登录通知(Account Remote Login Notice)', '亲爱的用户，您好！您的账号于2023-05-16 22:40:39在【广东省深圳市宝安区 电信】登录，登录IP为：【0:0:0:0:0:0:0:1】，若非本人操作，请立即修改密码。\n\nHello! Dear user, Your account was logged in in 【广东省深圳市宝安区 电信】 on 2023-05-16 22:40:39. If you do not operate by yourself, please change your password immediately.', 'Single', 1, '1', '1', '2023-05-16 22:40:40', '2023-05-16 22:40:40');
INSERT INTO `admin_sys_notice` VALUES (24, '账号异地登录通知(Account Remote Login Notice)', '亲爱的用户，您好！您的账号于2023-05-17 22:45:05在【 本机地址】登录，登录IP为：【127.0.0.1】，若非本人操作，请立即修改密码。\n\nHello! Dear user, Your account was logged in in 【 本机地址】 on 2023-05-17 22:45:05. If you do not operate by yourself, please change your password immediately.', 'Single', 1, '1', '1', '2023-05-17 22:45:06', '2023-05-17 22:45:06');
INSERT INTO `admin_sys_notice` VALUES (25, '账号异地登录通知(Account Remote Login Notice)', '亲爱的用户，您好！您的账号于2023-05-17 23:12:23在【广东省深圳市宝安区 电信】登录，登录IP为：【0:0:0:0:0:0:0:1】，若非本人操作，请立即修改密码。\n\nHello! Dear user, Your account was logged in in 【广东省深圳市宝安区 电信】 on 2023-05-17 23:12:23. If you do not operate by yourself, please change your password immediately.', 'Single', 1, '1', '1', '2023-05-17 23:12:24', '2023-05-17 23:12:24');
INSERT INTO `admin_sys_notice` VALUES (26, '账号异地登录通知(Account Remote Login Notice)', '亲爱的用户，您好！您的账号于2023-05-18 22:01:43在【 本机地址】登录，登录IP为：【127.0.0.1】，若非本人操作，请立即修改密码。\n\nHello! Dear user, Your account was logged in in 【 本机地址】 on 2023-05-18 22:01:43. If you do not operate by yourself, please change your password immediately.', 'Single', 1, '1', '1', '2023-05-18 22:01:44', '2023-05-18 22:01:44');

-- ----------------------------
-- Table structure for announcement
-- ----------------------------
DROP TABLE IF EXISTS `announcement`;
CREATE TABLE `announcement`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `uid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` int(0) NULL DEFAULT 0 COMMENT '0可见，1不可见',
  `gid` bigint(0) UNSIGNED NULL DEFAULT NULL,
  `gmt_create` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `gmt_modified` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  INDEX `announcement_ibfk_2`(`gid`) USING BTREE,
  CONSTRAINT `announcement_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `user_info` (`uuid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `announcement_ibfk_2` FOREIGN KEY (`gid`) REFERENCES `group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of announcement
-- ----------------------------
INSERT INTO `announcement` VALUES (1, '这是一个公告', '这是一个公告！！！', '1', 0, NULL, '2023-05-17 23:34:40', '2023-05-17 23:34:40');

-- ----------------------------
-- Table structure for auth
-- ----------------------------
DROP TABLE IF EXISTS `auth`;
CREATE TABLE `auth`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '权限名称',
  `permission` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '权限字符串',
  `status` tinyint(0) NOT NULL DEFAULT 0 COMMENT '0可用，1不可用',
  `gmt_create` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `gmt_modified` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth
-- ----------------------------
INSERT INTO `auth` VALUES (1, 'problem', 'problem_admin', 0, '2020-10-25 00:17:17', '2021-05-15 06:51:23');
INSERT INTO `auth` VALUES (2, 'submit', 'submit', 0, '2020-10-25 00:17:22', '2021-05-15 06:41:59');
INSERT INTO `auth` VALUES (3, 'contest', 'contest_admin', 0, '2020-10-25 00:17:33', '2021-05-15 06:51:28');
INSERT INTO `auth` VALUES (4, 'rejudge', 'rejudge', 0, '2020-10-25 00:17:49', '2021-05-15 06:50:55');
INSERT INTO `auth` VALUES (5, 'announcement', 'announcement_admin', 0, '2021-05-15 06:54:28', '2021-05-15 06:54:31');
INSERT INTO `auth` VALUES (6, 'user', 'user_admin', 0, '2021-05-15 06:54:30', '2021-05-15 06:55:04');
INSERT INTO `auth` VALUES (7, 'system_info', 'system_info_admin', 0, '2021-05-15 06:57:34', '2021-05-15 06:57:41');
INSERT INTO `auth` VALUES (8, 'dicussion', 'discussion_add', 0, '2021-05-15 06:57:36', '2021-05-15 07:50:45');
INSERT INTO `auth` VALUES (9, 'dicussion', 'discussion_del', 0, '2021-05-15 07:01:02', '2021-05-15 07:51:31');
INSERT INTO `auth` VALUES (10, 'dicussion', 'discussion_edit', 0, '2021-05-15 07:02:15', '2021-05-15 07:51:34');
INSERT INTO `auth` VALUES (11, 'comment', 'comment_add', 0, '2021-05-15 07:03:48', '2021-05-15 07:03:48');
INSERT INTO `auth` VALUES (12, 'reply', 'reply_add', 0, '2021-05-15 07:04:55', '2021-05-15 07:04:55');
INSERT INTO `auth` VALUES (13, 'group', 'group_add', 0, '2022-03-11 13:36:55', '2022-03-11 13:36:55');
INSERT INTO `auth` VALUES (14, 'group', 'group_del', 0, '2022-03-11 13:36:55', '2022-03-11 13:36:55');

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `gmt_create` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `gmt_modified` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (1, '闲聊', '2021-05-06 11:25:24', '2021-05-06 16:43:42');
INSERT INTO `category` VALUES (2, '题解', '2021-05-06 11:25:36', '2021-05-06 16:43:47');
INSERT INTO `category` VALUES (3, '求助', '2021-05-06 11:25:40', '2021-05-06 11:25:40');
INSERT INTO `category` VALUES (4, '建议', '2021-05-06 11:25:56', '2021-05-06 11:25:56');
INSERT INTO `category` VALUES (5, '记录', '2021-05-06 11:26:02', '2021-05-06 16:43:51');

-- ----------------------------
-- Table structure for code_template
-- ----------------------------
DROP TABLE IF EXISTS `code_template`;
CREATE TABLE `code_template`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `pid` bigint(0) UNSIGNED NOT NULL,
  `lid` bigint(0) UNSIGNED NOT NULL,
  `code` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `status` tinyint(1) NULL DEFAULT 0,
  `gmt_create` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `gmt_modified` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE,
  INDEX `lid`(`lid`) USING BTREE,
  CONSTRAINT `code_template_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `problem` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `code_template_ibfk_2` FOREIGN KEY (`lid`) REFERENCES `language` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of code_template
-- ----------------------------
INSERT INTO `code_template` VALUES (1, 1013, 1, '//PREPEND BEGIN\r\n#include <stdio.h>\r\n//PREPEND END\r\n\r\n//TEMPLATE BEGIN\r\nint add(int a, int b) {\r\n  // Please fill this blank\r\n  return ___________;\r\n}\r\n//TEMPLATE END\r\n\r\n//APPEND BEGIN\r\nint main() {\r\n  printf(\"%d\", add(1, 2));\r\n  return 0;\r\n}\r\n//APPEND END', 1, '2023-05-15 21:01:54', '2023-05-15 21:01:54');

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `cid` bigint(0) UNSIGNED NULL DEFAULT NULL COMMENT 'null表示无引用比赛',
  `did` int(0) NULL DEFAULT NULL COMMENT 'null表示无引用讨论',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `from_uid` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '评论者id',
  `from_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '评论者用户名',
  `from_avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '评论组头像地址',
  `from_role` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '评论者角色',
  `like_num` int(0) NULL DEFAULT 0 COMMENT '点赞数量',
  `status` int(0) NULL DEFAULT 0 COMMENT '是否封禁或逻辑删除该评论',
  `gmt_create` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `gmt_modified` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `uid`(`from_uid`) USING BTREE,
  INDEX `from_avatar`(`from_avatar`) USING BTREE,
  INDEX `comment_ibfk_7`(`did`) USING BTREE,
  INDEX `cid`(`cid`) USING BTREE,
  CONSTRAINT `comment_ibfk_6` FOREIGN KEY (`from_avatar`) REFERENCES `user_info` (`avatar`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `comment_ibfk_7` FOREIGN KEY (`did`) REFERENCES `discussion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `comment_ibfk_8` FOREIGN KEY (`cid`) REFERENCES `contest` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for comment_like
-- ----------------------------
DROP TABLE IF EXISTS `comment_like`;
CREATE TABLE `comment_like`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `uid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `cid` int(0) NOT NULL,
  `gmt_create` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `gmt_modified` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  INDEX `cid`(`cid`) USING BTREE,
  CONSTRAINT `comment_like_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `user_info` (`uuid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `comment_like_ibfk_2` FOREIGN KEY (`cid`) REFERENCES `comment` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for contest
-- ----------------------------
DROP TABLE IF EXISTS `contest`;
CREATE TABLE `contest`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '比赛创建者id',
  `author` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '比赛创建者的用户名',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `type` int(0) NOT NULL DEFAULT 0 COMMENT '0为acm赛制，1为比分赛制',
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `source` int(0) NULL DEFAULT 0 COMMENT '比赛来源，原创为0，克隆赛为比赛id',
  `auth` int(0) NOT NULL COMMENT '0为公开赛，1为私有赛（访问有密码），2为保护赛（提交有密码）',
  `pwd` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '比赛密码',
  `start_time` datetime(0) NULL DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime(0) NULL DEFAULT NULL COMMENT '结束时间',
  `duration` bigint(0) NULL DEFAULT NULL COMMENT '比赛时长(s)',
  `seal_rank` tinyint(1) NULL DEFAULT 0 COMMENT '是否开启封榜',
  `seal_rank_time` datetime(0) NULL DEFAULT NULL COMMENT '封榜起始时间，一直到比赛结束，不刷新榜单',
  `auto_real_rank` tinyint(1) NULL DEFAULT 1 COMMENT '比赛结束是否自动解除封榜,自动转换成真实榜单',
  `status` int(0) NULL DEFAULT NULL COMMENT '-1为未开始，0为进行中，1为已结束',
  `visible` tinyint(1) NULL DEFAULT 1 COMMENT '是否可见',
  `open_print` tinyint(1) NULL DEFAULT 0 COMMENT '是否打开打印功能',
  `open_account_limit` tinyint(1) NULL DEFAULT 0 COMMENT '是否开启账号限制',
  `account_limit_rule` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '账号限制规则',
  `rank_show_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'username' COMMENT '排行榜显示（username、nickname、realname）',
  `open_rank` tinyint(1) NULL DEFAULT 0 COMMENT '是否开放比赛榜单',
  `star_account` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '打星用户列表',
  `oi_rank_score_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'Recent' COMMENT 'oi排行榜得分方式，Recent、Highest',
  `is_group` tinyint(1) NULL DEFAULT 0,
  `gid` bigint(0) UNSIGNED NULL DEFAULT NULL,
  `award_type` int(0) NULL DEFAULT 0 COMMENT '奖项类型：0(不设置),1(设置占比),2(设置人数)',
  `award_config` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '奖项配置 json',
  `gmt_create` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `gmt_modified` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`, `uid`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  INDEX `contest_ibfk_2`(`gid`) USING BTREE,
  CONSTRAINT `contest_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `user_info` (`uuid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `contest_ibfk_2` FOREIGN KEY (`gid`) REFERENCES `group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1001 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of contest
-- ----------------------------
INSERT INTO `contest` VALUES (1000, '1', 'root', 'this is contest', 0, 'this is contest', 0, 0, '', '2023-05-17 22:48:29', '2023-05-26 00:00:00', 695491, 1, '2023-05-25 23:00:00', 1, 0, 1, 0, 0, '', 'nickname', 0, '{\"star_account\":[]}', 'Recent', 0, NULL, 0, NULL, '2023-05-17 22:49:10', '2023-05-17 22:49:10');

-- ----------------------------
-- Table structure for contest_announcement
-- ----------------------------
DROP TABLE IF EXISTS `contest_announcement`;
CREATE TABLE `contest_announcement`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `aid` bigint(0) UNSIGNED NOT NULL COMMENT '公告id',
  `cid` bigint(0) UNSIGNED NOT NULL COMMENT '比赛id',
  `gmt_create` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `gmt_modified` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `contest_announcement_ibfk_1`(`cid`) USING BTREE,
  INDEX `contest_announcement_ibfk_2`(`aid`) USING BTREE,
  CONSTRAINT `contest_announcement_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `contest` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `contest_announcement_ibfk_2` FOREIGN KEY (`aid`) REFERENCES `announcement` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of contest_announcement
-- ----------------------------
INSERT INTO `contest_announcement` VALUES (1, 1, 1000, '2023-05-17 23:34:40', '2023-05-17 23:34:40');

-- ----------------------------
-- Table structure for contest_explanation
-- ----------------------------
DROP TABLE IF EXISTS `contest_explanation`;
CREATE TABLE `contest_explanation`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `cid` bigint(0) UNSIGNED NOT NULL,
  `uid` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '发布者（必须为比赛创建者或者超级管理员才能）',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `gmt_create` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `gmt_modified` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  INDEX `contest_explanation_ibfk_1`(`cid`) USING BTREE,
  CONSTRAINT `contest_explanation_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `contest` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `contest_explanation_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `user_info` (`uuid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for contest_print
-- ----------------------------
DROP TABLE IF EXISTS `contest_print`;
CREATE TABLE `contest_print`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `realname` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `cid` bigint(0) UNSIGNED NULL DEFAULT NULL,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `status` int(0) NULL DEFAULT 0,
  `gmt_create` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `gmt_modified` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `cid`(`cid`) USING BTREE,
  INDEX `username`(`username`) USING BTREE,
  CONSTRAINT `contest_print_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `contest` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `contest_print_ibfk_2` FOREIGN KEY (`username`) REFERENCES `user_info` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for contest_problem
-- ----------------------------
DROP TABLE IF EXISTS `contest_problem`;
CREATE TABLE `contest_problem`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `display_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '该题目在比赛中的顺序id',
  `cid` bigint(0) UNSIGNED NOT NULL COMMENT '比赛id',
  `pid` bigint(0) UNSIGNED NOT NULL COMMENT '题目id',
  `display_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `color` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '气球颜色',
  `gmt_create` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `gmt_modified` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`, `cid`, `pid`) USING BTREE,
  UNIQUE INDEX `display_id`(`display_id`, `cid`, `pid`) USING BTREE,
  INDEX `contest_problem_ibfk_1`(`cid`) USING BTREE,
  INDEX `contest_problem_ibfk_2`(`pid`) USING BTREE,
  CONSTRAINT `contest_problem_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `contest` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `contest_problem_ibfk_2` FOREIGN KEY (`pid`) REFERENCES `problem` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of contest_problem
-- ----------------------------
INSERT INTO `contest_problem` VALUES (1, '1', 1000, 1000, 'Sum Problem', NULL, '2023-05-17 22:50:14', '2023-05-17 22:50:14');
INSERT INTO `contest_problem` VALUES (2, '2', 1000, 1007, 'A+B Problem', NULL, '2023-05-17 22:50:17', '2023-05-17 22:50:17');
INSERT INTO `contest_problem` VALUES (3, '3', 1000, 1009, 'Deadly Laser', NULL, '2023-05-17 22:50:19', '2023-05-17 22:50:19');
INSERT INTO `contest_problem` VALUES (4, '4', 1000, 1013, 'test', NULL, '2023-05-17 23:30:15', '2023-05-17 23:30:15');

-- ----------------------------
-- Table structure for contest_record
-- ----------------------------
DROP TABLE IF EXISTS `contest_record`;
CREATE TABLE `contest_record`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `cid` bigint(0) UNSIGNED NULL DEFAULT NULL COMMENT '比赛id',
  `uid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户id',
  `pid` bigint(0) UNSIGNED NULL DEFAULT NULL COMMENT '题目id',
  `cpid` bigint(0) UNSIGNED NULL DEFAULT NULL COMMENT '比赛中的题目的id',
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `realname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '真实姓名',
  `display_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '比赛中展示的id',
  `submit_id` bigint(0) UNSIGNED NOT NULL COMMENT '提交id，用于可重判',
  `status` int(0) NULL DEFAULT NULL COMMENT '提交结果，0表示未AC通过不罚时，1表示AC通过，-1为未AC通过算罚时',
  `submit_time` datetime(0) NOT NULL COMMENT '具体提交时间',
  `time` bigint(0) UNSIGNED NULL DEFAULT NULL COMMENT '提交时间，为提交时间减去比赛时间',
  `score` int(0) NULL DEFAULT NULL COMMENT 'OI比赛的得分',
  `use_time` int(0) NULL DEFAULT NULL COMMENT '运行耗时',
  `first_blood` tinyint(1) NULL DEFAULT 0 COMMENT '是否为一血AC(废弃)',
  `checked` tinyint(1) NULL DEFAULT 0 COMMENT 'AC是否已校验',
  `gmt_create` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `gmt_modified` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`, `submit_id`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE,
  INDEX `cpid`(`cpid`) USING BTREE,
  INDEX `submit_id`(`submit_id`) USING BTREE,
  INDEX `index_cid`(`cid`) USING BTREE,
  INDEX `index_time`(`time`) USING BTREE,
  CONSTRAINT `contest_record_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `contest` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `contest_record_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `user_info` (`uuid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `contest_record_ibfk_3` FOREIGN KEY (`pid`) REFERENCES `problem` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `contest_record_ibfk_4` FOREIGN KEY (`cpid`) REFERENCES `contest_problem` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `contest_record_ibfk_5` FOREIGN KEY (`submit_id`) REFERENCES `judge` (`submit_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of contest_record
-- ----------------------------
INSERT INTO `contest_record` VALUES (1, 1000, '1', 1013, 4, 'root', NULL, '4', 145, 1, '2023-05-17 23:31:14', 2565, NULL, 5, 0, 0, '2023-05-17 23:31:14', '2023-05-17 23:31:14');

-- ----------------------------
-- Table structure for contest_register
-- ----------------------------
DROP TABLE IF EXISTS `contest_register`;
CREATE TABLE `contest_register`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `cid` bigint(0) UNSIGNED NOT NULL COMMENT '比赛id',
  `uid` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户id',
  `status` int(0) NULL DEFAULT 0 COMMENT '默认为0表示正常，1为失效。',
  `gmt_create` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `gmt_modified` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`, `cid`, `uid`) USING BTREE,
  UNIQUE INDEX `cid_uid_unique`(`cid`, `uid`) USING BTREE,
  INDEX `contest_register_ibfk_2`(`uid`) USING BTREE,
  CONSTRAINT `contest_register_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `contest` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `contest_register_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `user_info` (`uuid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for contest_score
-- ----------------------------
DROP TABLE IF EXISTS `contest_score`;
CREATE TABLE `contest_score`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `cid` bigint(0) UNSIGNED NOT NULL,
  `last` int(0) NULL DEFAULT NULL COMMENT '比赛前的score得分',
  `change` int(0) NULL DEFAULT NULL COMMENT 'Score比分变化',
  `now` int(0) NULL DEFAULT NULL COMMENT '现在的score',
  `gmt_create` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `gmt_modified` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`, `cid`) USING BTREE,
  INDEX `contest_score_ibfk_1`(`cid`) USING BTREE,
  CONSTRAINT `contest_score_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `contest` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for discussion
-- ----------------------------
DROP TABLE IF EXISTS `discussion`;
CREATE TABLE `discussion`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `category_id` int(0) NOT NULL COMMENT '分类id',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `pid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关联题目id',
  `uid` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '发表者id',
  `author` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '发表者用户名',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '发表讨论者头像',
  `role` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'user' COMMENT '发表者角色',
  `view_num` int(0) NULL DEFAULT 0 COMMENT '浏览数量',
  `like_num` int(0) NULL DEFAULT 0 COMMENT '点赞数量',
  `top_priority` tinyint(1) NULL DEFAULT 0 COMMENT '优先级，是否置顶',
  `comment_num` int(0) NULL DEFAULT 0 COMMENT '评论数量',
  `status` int(0) NULL DEFAULT 0 COMMENT '是否封禁该讨论',
  `gid` bigint(0) UNSIGNED NULL DEFAULT NULL,
  `gmt_create` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `gmt_modified` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `category_id`(`category_id`) USING BTREE,
  INDEX `discussion_ibfk_4`(`avatar`) USING BTREE,
  INDEX `discussion_ibfk_1`(`uid`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE,
  INDEX `discussion_ibfk_3`(`gid`) USING BTREE,
  CONSTRAINT `discussion_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `user_info` (`uuid`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `discussion_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `discussion_ibfk_3` FOREIGN KEY (`gid`) REFERENCES `group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `discussion_ibfk_4` FOREIGN KEY (`avatar`) REFERENCES `user_info` (`avatar`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `discussion_ibfk_6` FOREIGN KEY (`pid`) REFERENCES `problem` (`problem_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for discussion_like
-- ----------------------------
DROP TABLE IF EXISTS `discussion_like`;
CREATE TABLE `discussion_like`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `uid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `did` int(0) NOT NULL,
  `gmt_create` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `gmt_modified` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `did`(`did`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  CONSTRAINT `discussion_like_ibfk_1` FOREIGN KEY (`did`) REFERENCES `discussion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `discussion_like_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `user_info` (`uuid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for discussion_report
-- ----------------------------
DROP TABLE IF EXISTS `discussion_report`;
CREATE TABLE `discussion_report`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `did` int(0) NULL DEFAULT NULL COMMENT '讨论id',
  `reporter` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '举报者的用户名',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `status` tinyint(1) NULL DEFAULT 0 COMMENT '是否已读',
  `gmt_create` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `gmt_modified` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `did`(`did`) USING BTREE,
  INDEX `reporter`(`reporter`) USING BTREE,
  CONSTRAINT `discussion_report_ibfk_1` FOREIGN KEY (`did`) REFERENCES `discussion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `discussion_report_ibfk_2` FOREIGN KEY (`reporter`) REFERENCES `user_info` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for file
-- ----------------------------
DROP TABLE IF EXISTS `file`;
CREATE TABLE `file`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `uid` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文件名',
  `suffix` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文件后缀格式',
  `folder_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文件所在文件夹的路径',
  `file_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件绝对路径',
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件所属类型，例如avatar',
  `delete` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除',
  `gid` bigint(0) UNSIGNED NULL DEFAULT NULL,
  `gmt_create` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `gmt_modified` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  INDEX `file_ibfk_2`(`gid`) USING BTREE,
  CONSTRAINT `file_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `user_info` (`uuid`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `file_ibfk_2` FOREIGN KEY (`gid`) REFERENCES `group` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for group
-- ----------------------------
DROP TABLE IF EXISTS `group`;
CREATE TABLE `group`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像地址',
  `name` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '团队名称',
  `short_name` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '团队简称，创建题目时题号自动添加的前缀',
  `brief` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '团队简介',
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `owner` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '团队拥有者用户名',
  `uid` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '团队拥有者用户id',
  `auth` int(0) NOT NULL COMMENT '0为Public，1为Protected，2为Private',
  `visible` tinyint(1) NULL DEFAULT 1 COMMENT '是否可见',
  `status` tinyint(1) NULL DEFAULT 0 COMMENT '是否封禁',
  `code` varchar(6) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邀请码',
  `gmt_create` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `gmt_modified` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `NAME_UNIQUE`(`name`) USING BTREE,
  UNIQUE INDEX `short_name`(`short_name`) USING BTREE,
  INDEX `group_ibfk_1`(`uid`) USING BTREE,
  CONSTRAINT `group_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `user_info` (`uuid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for group_member
-- ----------------------------
DROP TABLE IF EXISTS `group_member`;
CREATE TABLE `group_member`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `gid` bigint(0) UNSIGNED NOT NULL COMMENT '团队id',
  `uid` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户id',
  `auth` int(0) NULL DEFAULT 1 COMMENT '1未审批，2拒绝，3普通成员，4团队管理员，5团队拥有者',
  `reason` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `gmt_create` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `gmt_modified` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `gid_uid_unique`(`gid`, `uid`) USING BTREE,
  INDEX `gid`(`gid`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  CONSTRAINT `group_member_ibfk_1` FOREIGN KEY (`gid`) REFERENCES `group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `group_member_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `user_info` (`uuid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for judge
-- ----------------------------
DROP TABLE IF EXISTS `judge`;
CREATE TABLE `judge`  (
  `submit_id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pid` bigint(0) UNSIGNED NOT NULL COMMENT '题目id',
  `display_pid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '题目展示id',
  `uid` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户id',
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `submit_time` datetime(0) NOT NULL COMMENT '提交的时间',
  `status` int(0) NULL DEFAULT NULL COMMENT '结果码具体参考文档',
  `share` tinyint(1) NULL DEFAULT 0 COMMENT '0为仅自己可见，1为全部人可见。',
  `error_message` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '错误提醒（编译错误，或者vj提醒）',
  `time` int(0) NULL DEFAULT NULL COMMENT '运行时间(ms)',
  `memory` int(0) NULL DEFAULT NULL COMMENT '运行内存（kb）',
  `score` int(0) NULL DEFAULT NULL COMMENT 'IO判题则不为空',
  `length` int(0) NULL DEFAULT NULL COMMENT '代码长度',
  `code` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `language` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '代码语言',
  `gid` bigint(0) UNSIGNED NULL DEFAULT NULL COMMENT '团队id，不为团队内提交则为null',
  `cid` bigint(0) UNSIGNED NOT NULL DEFAULT 0 COMMENT '比赛id，非比赛题目默认为0',
  `cpid` bigint(0) UNSIGNED NULL DEFAULT 0 COMMENT '比赛中题目排序id，非比赛题目默认为0',
  `judger` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '判题机ip',
  `ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '提交者所在ip',
  `version` int(0) NOT NULL DEFAULT 0 COMMENT '乐观锁',
  `oi_rank_score` int(0) NULL DEFAULT 0 COMMENT 'oi排行榜得分',
  `vjudge_submit_id` bigint(0) UNSIGNED NULL DEFAULT NULL COMMENT 'vjudge判题在其它oj的提交id',
  `vjudge_username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'vjudge判题在其它oj的提交用户名',
  `vjudge_password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'vjudge判题在其它oj的提交账号密码',
  `is_manual` tinyint(1) NULL DEFAULT 0 COMMENT '是否为人工评测',
  `gmt_create` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `gmt_modified` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  `oi_rank` int(0) NULL DEFAULT NULL COMMENT '该题在OI排行榜的分数',
  PRIMARY KEY (`submit_id`, `pid`, `display_pid`, `uid`, `cid`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  INDEX `username`(`username`) USING BTREE,
  INDEX `judge_ibfk_4`(`gid`) USING BTREE,
  CONSTRAINT `judge_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `problem` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `judge_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `user_info` (`uuid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `judge_ibfk_3` FOREIGN KEY (`username`) REFERENCES `user_info` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `judge_ibfk_4` FOREIGN KEY (`gid`) REFERENCES `group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 145 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of judge
-- ----------------------------
INSERT INTO `judge` VALUES (1, 1000, 'HDU-1001', '1', 'root', '2023-04-25 21:51:05', 4, 0, 'System Error! Cause: The System does not have [HDU] account configured. Please report the matter to the administrator!', NULL, NULL, NULL, 222, '#include<bits/stdc++.h>\n\nusing namespace std;\n\nint main() {\n    int n;\n    while(cin >> n) {\n        long sum = 0;\n        for(int i = 1; i <= n; i ++) {\n            sum += i;\n        }\n        cout << sum << endl;\n    }\n}', 'C++', NULL, 0, 0, NULL, '127.0.0.1', 0, 0, NULL, NULL, NULL, 0, '2023-04-25 21:51:05', '2023-04-25 21:51:05', NULL);
INSERT INTO `judge` VALUES (18, 1000, 'HDU-1001', '1', 'root', '2023-04-26 00:07:18', -2, 0, '0_0_38507459_2343.cpp\r\n0_0_38507459_2343.cpp(1) : fatal error C1083: 无法打开包括文件: “bits/stdc++.h”: No such file or directory\r\n', 0, 0, NULL, 222, '#include<bits/stdc++.h>\n\nusing namespace std;\n\nint main() {\n    int n;\n    while(cin >> n) {\n        long sum = 0;\n        for(int i = 1; i <= n; i ++) {\n            sum += i;\n        }\n        cout << sum << endl;\n    }\n}', 'C++', NULL, 0, 0, 'hoj-judger-1', '127.0.0.1', 1, NULL, 38507459, 'lxhcaicai', 'dgut2834', 0, '2023-04-26 00:07:18', '2023-05-01 10:22:24', NULL);
INSERT INTO `judge` VALUES (58, 1006, 'CF-CF1A', '1', 'root', '2023-04-27 23:46:29', 10, 0, 'Submission failed! Please resubmit this submission again!Cause: Waiting for account scheduling timeout.', NULL, NULL, NULL, 230, '#include<bits/stdc++.h>\nusing namespace std;\n\n#define ll long long\nint main(){\n    ll n,m,a;\n    cin>>n>>m>>a;\n    if(n%a==0) n/=a;\n    else n=n/a+1;\n    \n    if(m%a==0) m/=a;\n    else m=m/a+1;\n    cout<<n*m<<endl;\n    return 0;\n}', 'GNU G++14 6.4.0', NULL, 0, 0, '', '127.0.0.1', 1, NULL, NULL, NULL, NULL, 0, '2023-04-27 23:46:29', '2023-04-28 00:33:05', NULL);
INSERT INTO `judge` VALUES (62, 1006, 'CF-CF1A', '1', 'root', '2023-04-28 00:04:37', 10, 0, 'Submission failed! Please resubmit this submission again!Cause: Waiting for account scheduling timeout.', NULL, NULL, NULL, 230, '#include<bits/stdc++.h>\nusing namespace std;\n\n#define ll long long\nint main(){\n    ll n,m,a;\n    cin>>n>>m>>a;\n    if(n%a==0) n/=a;\n    else n=n/a+1;\n    \n    if(m%a==0) m/=a;\n    else m=m/a+1;\n    cout<<n*m<<endl;\n    return 0;\n}', 'GNU G++14 6.4.0', NULL, 0, 0, '', '127.0.0.1', 1, NULL, NULL, NULL, NULL, 0, '2023-04-28 00:04:37', '2023-04-28 00:33:02', NULL);
INSERT INTO `judge` VALUES (63, 1006, 'CF-CF1A', '1', 'root', '2023-04-28 00:06:07', 10, 0, 'Submission failed! Please resubmit this submission again!Cause: Waiting for account scheduling timeout.', NULL, NULL, NULL, 230, '#include<bits/stdc++.h>\nusing namespace std;\n\n#define ll long long\nint main(){\n    ll n,m,a;\n    cin>>n>>m>>a;\n    if(n%a==0) n/=a;\n    else n=n/a+1;\n    \n    if(m%a==0) m/=a;\n    else m=m/a+1;\n    cout<<n*m<<endl;\n    return 0;\n}', 'GNU G++14 6.4.0', NULL, 0, 0, '', '127.0.0.1', 1, NULL, NULL, NULL, NULL, 0, '2023-04-28 00:06:07', '2023-04-28 00:54:05', NULL);
INSERT INTO `judge` VALUES (64, 1006, 'CF-CF1A', '1', 'root', '2023-04-28 00:07:11', 10, 0, 'Submission failed! Please resubmit this submission again!Cause: Waiting for account scheduling timeout.', NULL, NULL, NULL, 230, '#include<bits/stdc++.h>\nusing namespace std;\n\n#define ll long long\nint main(){\n    ll n,m,a;\n    cin>>n>>m>>a;\n    if(n%a==0) n/=a;\n    else n=n/a+1;\n    \n    if(m%a==0) m/=a;\n    else m=m/a+1;\n    cout<<n*m<<endl;\n    return 0;\n}', 'GNU G++14 6.4.0', NULL, 0, 0, '', '127.0.0.1', 1, NULL, NULL, NULL, NULL, 0, '2023-04-28 00:07:11', '2023-04-28 00:54:11', NULL);
INSERT INTO `judge` VALUES (65, 1006, 'CF-CF1A', '1', 'root', '2023-04-28 00:09:22', 10, 0, 'Submission failed! Please resubmit this submission again!Cause: Waiting for account scheduling timeout.', NULL, NULL, NULL, 230, '#include<bits/stdc++.h>\nusing namespace std;\n\n#define ll long long\nint main(){\n    ll n,m,a;\n    cin>>n>>m>>a;\n    if(n%a==0) n/=a;\n    else n=n/a+1;\n    \n    if(m%a==0) m/=a;\n    else m=m/a+1;\n    cout<<n*m<<endl;\n    return 0;\n}', 'GNU G++14 6.4.0', NULL, 0, 0, '', '127.0.0.1', 1, NULL, NULL, NULL, NULL, 0, '2023-04-28 00:09:22', '2023-04-28 00:54:17', NULL);
INSERT INTO `judge` VALUES (66, 1006, 'CF-CF1A', '1', 'root', '2023-04-28 00:12:59', 10, 0, 'Submission failed! Please resubmit this submission again!Cause: Waiting for account scheduling timeout.', NULL, NULL, NULL, 230, '#include<bits/stdc++.h>\nusing namespace std;\n\n#define ll long long\nint main(){\n    ll n,m,a;\n    cin>>n>>m>>a;\n    if(n%a==0) n/=a;\n    else n=n/a+1;\n    \n    if(m%a==0) m/=a;\n    else m=m/a+1;\n    cout<<n*m<<endl;\n    return 0;\n}', 'GNU G++14 6.4.0', NULL, 0, 0, '', '127.0.0.1', 1, NULL, NULL, NULL, NULL, 0, '2023-04-28 00:13:44', '2023-04-28 00:54:20', NULL);
INSERT INTO `judge` VALUES (67, 1006, 'CF-CF1A', '1', 'root', '2023-04-28 00:20:48', 10, 0, 'Submission failed! Please resubmit this submission again!Cause: Waiting for account scheduling timeout.', NULL, NULL, NULL, 230, '#include<bits/stdc++.h>\nusing namespace std;\n\n#define ll long long\nint main(){\n    ll n,m,a;\n    cin>>n>>m>>a;\n    if(n%a==0) n/=a;\n    else n=n/a+1;\n    \n    if(m%a==0) m/=a;\n    else m=m/a+1;\n    cout<<n*m<<endl;\n    return 0;\n}', 'GNU G++14 6.4.0', NULL, 0, 0, NULL, '127.0.0.1', 0, 0, NULL, NULL, NULL, 0, '2023-04-28 00:20:48', '2023-04-28 00:33:35', NULL);
INSERT INTO `judge` VALUES (68, 1006, 'CF-CF1A', '1', 'root', '2023-04-28 00:23:26', 10, 0, 'Submission failed! Please resubmit this submission again!Cause: Waiting for account scheduling timeout.', NULL, NULL, NULL, 230, '#include<bits/stdc++.h>\nusing namespace std;\n\n#define ll long long\nint main(){\n    ll n,m,a;\n    cin>>n>>m>>a;\n    if(n%a==0) n/=a;\n    else n=n/a+1;\n    \n    if(m%a==0) m/=a;\n    else m=m/a+1;\n    cout<<n*m<<endl;\n    return 0;\n}', 'GNU G++14 6.4.0', NULL, 0, 0, NULL, '127.0.0.1', 0, 0, NULL, NULL, NULL, 0, '2023-04-28 00:23:28', '2023-04-28 00:39:15', NULL);
INSERT INTO `judge` VALUES (69, 1006, 'CF-CF1A', '1', 'root', '2023-04-28 00:25:24', 10, 0, 'Submission failed! Please resubmit this submission again!Cause: Waiting for account scheduling timeout.', NULL, NULL, NULL, 230, '#include<bits/stdc++.h>\nusing namespace std;\n\n#define ll long long\nint main(){\n    ll n,m,a;\n    cin>>n>>m>>a;\n    if(n%a==0) n/=a;\n    else n=n/a+1;\n    \n    if(m%a==0) m/=a;\n    else m=m/a+1;\n    cout<<n*m<<endl;\n    return 0;\n}', 'GNU G++14 6.4.0', NULL, 0, 0, '', '127.0.0.1', 1, NULL, NULL, NULL, NULL, 0, '2023-04-28 00:25:24', '2023-04-28 00:54:23', NULL);
INSERT INTO `judge` VALUES (70, 1006, 'CF-CF1A', '1', 'root', '2023-04-28 00:26:24', 10, 0, 'Submission failed! Please resubmit this submission again!Cause: Waiting for account scheduling timeout.', NULL, NULL, NULL, 230, '#include<bits/stdc++.h>\nusing namespace std;\n\n#define ll long long\nint main(){\n    ll n,m,a;\n    cin>>n>>m>>a;\n    if(n%a==0) n/=a;\n    else n=n/a+1;\n    \n    if(m%a==0) m/=a;\n    else m=m/a+1;\n    cout<<n*m<<endl;\n    return 0;\n}', 'GNU G++14 6.4.0', NULL, 0, 0, NULL, '127.0.0.1', 0, 0, NULL, NULL, NULL, 0, '2023-04-28 00:26:24', '2023-04-28 00:46:34', NULL);
INSERT INTO `judge` VALUES (71, 1006, 'CF-CF1A', '1', 'root', '2023-04-28 00:28:00', 10, 0, 'Submission failed! Please resubmit this submission again!Cause: Waiting for account scheduling timeout.', NULL, NULL, NULL, 230, '#include<bits/stdc++.h>\nusing namespace std;\n\n#define ll long long\nint main(){\n    ll n,m,a;\n    cin>>n>>m>>a;\n    if(n%a==0) n/=a;\n    else n=n/a+1;\n    \n    if(m%a==0) m/=a;\n    else m=m/a+1;\n    cout<<n*m<<endl;\n    return 0;\n}', 'GNU G++14 6.4.0', NULL, 0, 0, NULL, '127.0.0.1', 0, 0, NULL, NULL, NULL, 0, '2023-04-28 00:28:03', '2023-04-28 00:48:04', NULL);
INSERT INTO `judge` VALUES (73, 1006, 'CF-CF1A', '1', 'root', '2023-04-28 00:30:33', 10, 0, 'Submission failed! Please resubmit this submission again!Cause: Waiting for account scheduling timeout.', NULL, NULL, NULL, 230, '#include<bits/stdc++.h>\nusing namespace std;\n\n#define ll long long\nint main(){\n    ll n,m,a;\n    cin>>n>>m>>a;\n    if(n%a==0) n/=a;\n    else n=n/a+1;\n    \n    if(m%a==0) m/=a;\n    else m=m/a+1;\n    cout<<n*m<<endl;\n    return 0;\n}', 'GNU G++14 6.4.0', NULL, 0, 0, NULL, '127.0.0.1', 0, 0, NULL, NULL, NULL, 0, '2023-04-28 00:30:40', '2023-04-28 00:49:58', NULL);
INSERT INTO `judge` VALUES (74, 1006, 'CF-CF1A', '1', 'root', '2023-04-28 00:34:34', 10, 0, 'Submission failed! Please resubmit this submission again!Cause: Waiting for account scheduling timeout.', NULL, NULL, NULL, 230, '#include<bits/stdc++.h>\nusing namespace std;\n\n#define ll long long\nint main(){\n    ll n,m,a;\n    cin>>n>>m>>a;\n    if(n%a==0) n/=a;\n    else n=n/a+1;\n    \n    if(m%a==0) m/=a;\n    else m=m/a+1;\n    cout<<n*m<<endl;\n    return 0;\n}', 'GNU G++14 6.4.0', NULL, 0, 0, NULL, '127.0.0.1', 0, 0, NULL, NULL, NULL, 0, '2023-04-28 00:34:40', '2023-04-28 00:52:17', NULL);
INSERT INTO `judge` VALUES (75, 1006, 'CF-CF1A', '1', 'root', '2023-04-28 00:36:52', 10, 0, 'Submission failed! Please resubmit this submission again!Cause: Waiting for account scheduling timeout.', NULL, NULL, NULL, 230, '#include<bits/stdc++.h>\nusing namespace std;\n\n#define ll long long\nint main(){\n    ll n,m,a;\n    cin>>n>>m>>a;\n    if(n%a==0) n/=a;\n    else n=n/a+1;\n    \n    if(m%a==0) m/=a;\n    else m=m/a+1;\n    cout<<n*m<<endl;\n    return 0;\n}', 'GNU G++14 6.4.0', NULL, 0, 0, NULL, '127.0.0.1', 0, 0, NULL, NULL, NULL, 0, '2023-04-28 00:36:56', '2023-04-28 00:53:35', NULL);
INSERT INTO `judge` VALUES (76, 1006, 'CF-CF1A', '1', 'root', '2023-04-28 00:39:08', 10, 0, 'Submission failed! Please resubmit this submission again!Cause: Waiting for account scheduling timeout.', NULL, NULL, NULL, 230, '#include<bits/stdc++.h>\nusing namespace std;\n\n#define ll long long\nint main(){\n    ll n,m,a;\n    cin>>n>>m>>a;\n    if(n%a==0) n/=a;\n    else n=n/a+1;\n    \n    if(m%a==0) m/=a;\n    else m=m/a+1;\n    cout<<n*m<<endl;\n    return 0;\n}', 'GNU G++14 6.4.0', NULL, 0, 0, NULL, '127.0.0.1', 0, 0, NULL, NULL, NULL, 0, '2023-04-28 00:39:15', '2023-04-28 00:53:59', NULL);
INSERT INTO `judge` VALUES (77, 1006, 'CF-CF1A', '1', 'root', '2023-04-28 00:47:42', 0, 0, NULL, 15, 4, NULL, 230, '#include<bits/stdc++.h>\nusing namespace std;\n\n#define ll long long\nint main(){\n    ll n,m,a;\n    cin>>n>>m>>a;\n    if(n%a==0) n/=a;\n    else n=n/a+1;\n    \n    if(m%a==0) m/=a;\n    else m=m/a+1;\n    cout<<n*m<<endl;\n    return 0;\n}', 'GNU G++14 6.4.0', NULL, 0, 0, 'hoj-judger-1', '127.0.0.1', 1, NULL, 203717759, '2778763221@qq.com', 'dgut2834', 0, '2023-04-28 00:47:42', '2023-04-28 00:57:17', NULL);
INSERT INTO `judge` VALUES (78, 1006, 'CF-CF1A', '1', 'root', '2023-04-28 00:50:30', 0, 0, NULL, 15, 4, NULL, 230, '#include<bits/stdc++.h>\nusing namespace std;\n\n#define ll long long\nint main(){\n    ll n,m,a;\n    cin>>n>>m>>a;\n    if(n%a==0) n/=a;\n    else n=n/a+1;\n    \n    if(m%a==0) m/=a;\n    else m=m/a+1;\n    cout<<n*m<<endl;\n    return 0;\n}', 'GNU G++17 7.3.0', NULL, 0, 0, 'hoj-judger-1', '127.0.0.1', 1, NULL, 203718310, '2778763221@qq.com', 'dgut2834', 0, '2023-04-28 00:50:30', '2023-04-28 01:00:12', NULL);
INSERT INTO `judge` VALUES (79, 1006, 'CF-CF1A', '1', 'root', '2023-04-28 00:54:02', 0, 0, NULL, 15, 8, NULL, 230, '#include<bits/stdc++.h>\nusing namespace std;\n\n#define ll long long\nint main(){\n    ll n,m,a;\n    cin>>n>>m>>a;\n    if(n%a==0) n/=a;\n    else n=n/a+1;\n    \n    if(m%a==0) m/=a;\n    else m=m/a+1;\n    cout<<n*m<<endl;\n    return 0;\n}', 'GNU G++14 6.4.0', NULL, 0, 0, 'hoj-judger-1', '127.0.0.1', 1, NULL, 203717740, '2778763221@qq.com', 'dgut2834', 0, '2023-04-28 00:54:02', '2023-04-28 00:57:05', NULL);
INSERT INTO `judge` VALUES (80, 1006, 'CF-CF1A', '1', 'root', '2023-04-28 00:54:41', 0, 0, NULL, 15, 4, NULL, 230, '#include<bits/stdc++.h>\nusing namespace std;\n\n#define ll long long\nint main(){\n    ll n,m,a;\n    cin>>n>>m>>a;\n    if(n%a==0) n/=a;\n    else n=n/a+1;\n    \n    if(m%a==0) m/=a;\n    else m=m/a+1;\n    cout<<n*m<<endl;\n    return 0;\n}', 'GNU G++14 6.4.0', NULL, 0, 0, 'hoj-judger-1', '127.0.0.1', 1, NULL, 203717681, '2778763221@qq.com', 'dgut2834', 0, '2023-04-28 00:54:41', '2023-04-28 00:56:54', NULL);
INSERT INTO `judge` VALUES (81, 1006, 'CF-CF1A', '1', 'root', '2023-04-28 00:56:06', 0, 0, NULL, 15, 8, NULL, 230, '#include<bits/stdc++.h>\nusing namespace std;\n\n#define ll long long\nint main(){\n    ll n,m,a;\n    cin>>n>>m>>a;\n    if(n%a==0) n/=a;\n    else n=n/a+1;\n    \n    if(m%a==0) m/=a;\n    else m=m/a+1;\n    cout<<n*m<<endl;\n    return 0;\n}', 'GNU G++14 6.4.0', NULL, 0, 0, 'hoj-judger-1', '127.0.0.1', 0, NULL, 203717573, '2778763221@qq.com', 'dgut2834', 0, '2023-04-28 00:56:06', '2023-04-28 00:56:22', NULL);
INSERT INTO `judge` VALUES (83, 1006, 'CF-CF1A', '1', 'root', '2023-04-29 11:35:36', 0, 0, NULL, 0, 0, NULL, 230, '#include<bits/stdc++.h>\nusing namespace std;\n\n#define ll long long\nint main(){\n    ll n,m,a;\n    cin>>n>>m>>a;\n    if(n%a==0) n/=a;\n    else n=n/a+1;\n    \n    if(m%a==0) m/=a;\n    else m=m/a+1;\n    cout<<n*m<<endl;\n    return 0;\n}', 'GNU G++20 11.2.0 (64 bit, winlibs)', NULL, 0, 0, 'loj-judger-1', '127.0.0.1', 2, NULL, 204027394, '2778763221@qq.com', 'dgut2834', 0, '2023-04-29 11:35:36', '2023-04-30 23:53:43', NULL);
INSERT INTO `judge` VALUES (84, 1007, 'POJ-1000', '1', 'root', '2023-04-29 11:39:36', 0, 0, NULL, 610, 620, NULL, 478, 'import java.io.*;\nimport java.util.*;\n\npublic class Main\n{\n    public static void main (String args[]) throws Exception\n    {\n        BufferedReader stdin = \n            new BufferedReader(\n                new InputStreamReader(System.in));\n\n        String line = stdin.readLine();\n        StringTokenizer st = new StringTokenizer(line);\n        int a = Integer.parseInt(st.nextToken());\n        int b = Integer.parseInt(st.nextToken());\n        System.out.println(a+b);\n    }\n}', 'Java', NULL, 0, 0, 'hoj-judger-1', '127.0.0.1', 2, NULL, 24116207, 'lxhcaicai', 'dgut2834', 0, '2023-04-29 11:39:36', '2023-04-29 11:43:02', NULL);
INSERT INTO `judge` VALUES (86, 1007, 'POJ-1000', '1', 'root', '2023-04-29 20:01:26', 10, 0, 'Waiting for remote judge result exceeds the maximum number of times, please try submitting again!', NULL, NULL, NULL, 478, 'import java.io.*;\nimport java.util.*;\n\npublic class Main\n{\n    public static void main (String args[]) throws Exception\n    {\n        BufferedReader stdin = \n            new BufferedReader(\n                new InputStreamReader(System.in));\n\n        String line = stdin.readLine();\n        StringTokenizer st = new StringTokenizer(line);\n        int a = Integer.parseInt(st.nextToken());\n        int b = Integer.parseInt(st.nextToken());\n        System.out.println(a+b);\n    }\n}', 'Java', NULL, 0, 0, 'hoj-judger-1', '127.0.0.1', 0, NULL, 24117771, 'lxhcaicai', 'dgut2834', 0, '2023-04-29 20:01:26', '2023-04-30 17:48:12', NULL);
INSERT INTO `judge` VALUES (88, 1008, 'AC-abc001_2', '1', 'root', '2023-04-30 18:00:53', 10, 0, NULL, NULL, NULL, NULL, 268, '#include<bits/stdc++.h>\nusing namespace std;\nint main()\n{\n	int a;\n	cin>>a;\n	if(a<100)cout<<\"00\";\n	else if(a<1000)cout<<0<<a/100;\n	else if(a<=5000)cout<<a/100;\n	else if(a<=30000)cout<<a/1000+50;\n	else if(a<=70000)cout<<(a/1000-30)/5+80;\n	else cout<<\"89\";\n	cout<<endl;\n}', 'C++ (Clang 10.0.0)', NULL, 0, 0, 'hoj-judger-1', '127.0.0.1', 1, NULL, NULL, NULL, NULL, 0, '2023-04-30 18:00:53', '2023-05-01 10:13:59', NULL);
INSERT INTO `judge` VALUES (89, 1008, 'AC-abc001_2', '1', 'root', '2023-04-30 18:04:15', 10, 0, NULL, NULL, NULL, NULL, 268, '#include<bits/stdc++.h>\nusing namespace std;\nint main()\n{\n	int a;\n	cin>>a;\n	if(a<100)cout<<\"00\";\n	else if(a<1000)cout<<0<<a/100;\n	else if(a<=5000)cout<<a/100;\n	else if(a<=30000)cout<<a/1000+50;\n	else if(a<=70000)cout<<(a/1000-30)/5+80;\n	else cout<<\"89\";\n	cout<<endl;\n}', 'C++ (Clang 10.0.0)', NULL, 0, 0, 'hoj-judger-1', '127.0.0.1', 1, NULL, NULL, NULL, NULL, 0, '2023-04-30 18:04:15', '2023-05-01 10:13:15', NULL);
INSERT INTO `judge` VALUES (90, 1009, 'CF-CF1721B', '1', 'root', '2023-05-01 00:04:26', 0, 0, NULL, 93, 4004, NULL, 935, '#include <bits/stdc++.h>\n \nusing namespace std;\n \nconst int N = 1010;\n \nint n, m;\nint xx, yy;\nint d;\n \nint vis[N][N];\n \nbool isok(int x, int y) {\n	return 1 <= x && x <= n && 1 <= y && y <= m;\n}\n \nconst int dx[] = {0, 0, -1, 1};\nconst int dy[] = {1, -1, 0, 0};\nint t;\nbool dfs(int x, int y) {\n	\n	if(x == n && y ==m) return true;\n	vis[x][y] = t;\n//	cout << \"x:\" << x << \" y:\" << y << endl; \n	for(int i = 0; i < 4; i ++) {\n		int nx = x + dx[i];\n		int ny = y + dy[i];\n		if(!isok(nx, ny) ) continue;\n		if(vis[nx][ny] == t) continue; \n		if(abs(xx - nx) + abs(yy - ny) <= d) continue;\n		if(dfs(nx, ny)) return true;\n	}\n	\n	return false;\n}\n \nint main() {\n	int T;\n	cin >> T;\n	for( t = 1; t <=T; t ++) {\n		cin >> n >> m;\n		cin >> xx >> yy >> d;\n		if(abs(xx - 1) > d && abs(yy -m) > d) {\n			cout << n + m - 2 << endl;\n		}\n		else if(abs(xx - n) > d && abs(yy -1) > d) {\n			cout << n + m - 2 << endl;\n		}\n		else {\n			cout << - 1 << endl;\n		}\n		\n	}\n}', 'GNU G++17 7.3.0', NULL, 0, 0, 'loj-judger-1', '127.0.0.1', 0, NULL, 204094598, '2778763221@qq.com', 'dgut2834', 0, '2023-05-01 00:04:26', '2023-05-01 09:56:14', NULL);
INSERT INTO `judge` VALUES (94, 1000, 'HDU-1001', '1', 'root', '2023-05-01 10:21:38', -1, 0, NULL, 31, 1392, NULL, 140, '#include <bits/stdc++.h>\n\nusing namespace std;\n\nint main() {\n    int a, b;\n    while(cin >> a >> b) {\n        cout << a + b << endl;\n    }\n}', 'G++', NULL, 0, 0, 'hoj-judger-1', '127.0.0.1', 0, NULL, 38507457, 'lxhcaicai', 'dgut2834', 0, '2023-05-01 10:21:38', '2023-05-01 10:21:47', NULL);
INSERT INTO `judge` VALUES (95, 1000, 'HDU-1001', '1', 'root', '2023-05-01 10:27:20', 0, 0, NULL, 15, 1392, NULL, 230, '#include <iostream>\nusing namespace std;\nint main()\n{\n    int n,s;\n    while (cin >> n)\n    {\n        s = 0;\n        for (int i = 1; i < n + 1; i++)\n        {\n            s += i;\n        }\n        cout << s << endl<<endl;\n    }\n}\n', 'G++', NULL, 0, 0, 'loj-judger-1', '127.0.0.1', 0, NULL, 38507555, 'lxhcaicai', 'dgut2834', 0, '2023-05-01 10:27:20', '2023-05-01 11:52:44', NULL);
INSERT INTO `judge` VALUES (109, 1013, '1111', '1', 'root', '2023-05-06 21:49:43', 0, 0, NULL, 1, 412, NULL, 107, '#include<bits/stdc++.h>\n\nusing namespace std;\n\nint main() {\n    string ss;\n    cin >> ss;\n    cout << ss;\n}', 'C++', NULL, 0, 0, 'hoj-judger-1', '127.0.0.1', 0, NULL, NULL, NULL, NULL, 0, '2023-05-06 21:49:43', '2023-05-06 21:49:44', NULL);
INSERT INTO `judge` VALUES (110, 1013, '1111', '1', 'root', '2023-05-07 16:49:10', 0, 0, NULL, 3, 408, NULL, 107, '#include<bits/stdc++.h>\n\nusing namespace std;\n\nint main() {\n    string ss;\n    cin >> ss;\n    cout << ss;\n}', 'C++', NULL, 0, 0, 'hoj-judger-1', '127.0.0.1', 0, NULL, NULL, NULL, NULL, 0, '2023-05-07 16:49:10', '2023-05-07 16:49:12', NULL);
INSERT INTO `judge` VALUES (111, 1013, '1111', '1', 'root', '2023-05-07 16:50:51', 0, 0, NULL, 2, 412, NULL, 107, '#include<bits/stdc++.h>\n\nusing namespace std;\n\nint main() {\n    string ss;\n    cin >> ss;\n    cout << ss;\n}', 'C++', NULL, 0, 0, 'hoj-judger-1', '127.0.0.1', 0, NULL, NULL, NULL, NULL, 0, '2023-05-07 16:50:51', '2023-05-07 16:50:52', NULL);
INSERT INTO `judge` VALUES (112, 1013, '1111', '1', 'root', '2023-05-07 16:52:55', 0, 0, NULL, 1, 408, NULL, 107, '#include<bits/stdc++.h>\n\nusing namespace std;\n\nint main() {\n    string ss;\n    cin >> ss;\n    cout << ss;\n}', 'C++', NULL, 0, 0, 'hoj-judger-1', '0:0:0:0:0:0:0:1', 0, NULL, NULL, NULL, NULL, 0, '2023-05-07 16:52:55', '2023-05-07 16:52:56', NULL);
INSERT INTO `judge` VALUES (113, 1013, '1111', '1', 'root', '2023-05-08 20:13:45', 0, 0, NULL, 2, 412, NULL, 107, '#include<bits/stdc++.h>\n\nusing namespace std;\n\nint main() {\n    string ss;\n    cin >> ss;\n    cout << ss;\n}', 'C++', NULL, 0, 0, 'loj-judger-1', '0:0:0:0:0:0:0:1', 0, NULL, NULL, NULL, NULL, 0, '2023-05-08 20:13:45', '2023-05-08 20:13:46', NULL);
INSERT INTO `judge` VALUES (114, 1013, '1111', '1', 'root', '2023-05-08 20:14:20', 0, 0, NULL, 2, 412, NULL, 107, '#include<bits/stdc++.h>\n\nusing namespace std;\n\nint main() {\n    string ss;\n    cin >> ss;\n    cout << ss;\n}', 'C++', NULL, 0, 0, 'loj-judger-1', '0:0:0:0:0:0:0:1', 0, NULL, NULL, NULL, NULL, 0, '2023-05-08 20:14:20', '2023-05-08 20:18:12', NULL);
INSERT INTO `judge` VALUES (115, 1013, '1111', '1', 'root', '2023-05-08 23:18:36', 0, 0, NULL, 4, 1688, NULL, 107, '#include<bits/stdc++.h>\n\nusing namespace std;\n\nint main() {\n    string ss;\n    cin >> ss;\n    cout << ss;\n}', 'C++', NULL, 0, 0, 'loj-judger-1', '0:0:0:0:0:0:0:1', 0, NULL, NULL, NULL, NULL, 0, '2023-05-08 23:18:36', '2023-05-08 23:18:42', NULL);
INSERT INTO `judge` VALUES (116, 1013, '1111', '1', 'root', '2023-05-08 23:20:40', 0, 0, NULL, 2, 1048, NULL, 107, '#include<bits/stdc++.h>\n\nusing namespace std;\n\nint main() {\n    string ss;\n    cin >> ss;\n    cout << ss;\n}', 'C++', NULL, 0, 0, 'hoj-judger-1', '0:0:0:0:0:0:0:1', 0, NULL, NULL, NULL, NULL, 0, '2023-05-08 23:20:40', '2023-05-08 23:20:45', NULL);
INSERT INTO `judge` VALUES (117, 1013, '1111', '1', 'root', '2023-05-08 23:21:54', 0, 0, NULL, 3, 664, NULL, 107, '#include<bits/stdc++.h>\n\nusing namespace std;\n\nint main() {\n    string ss;\n    cin >> ss;\n    cout << ss;\n}', 'C++', NULL, 0, 0, 'loj-judger-1', '0:0:0:0:0:0:0:1', 0, NULL, NULL, NULL, NULL, 0, '2023-05-08 23:21:54', '2023-05-08 23:21:55', NULL);
INSERT INTO `judge` VALUES (118, 1013, '1111', '1', 'root', '2023-05-09 01:28:36', 10, 0, 'Failed to connect the judgeServer. Please resubmit this submission again!', NULL, NULL, NULL, 107, '#include<bits/stdc++.h>\n\nusing namespace std;\n\nint main() {\n    string ss;\n    cin >> ss;\n    cout << ss;\n}', 'C++', NULL, 0, 0, '', '0:0:0:0:0:0:0:1', 8, NULL, NULL, NULL, NULL, 0, '2023-05-09 01:28:36', '2023-05-09 21:09:08', NULL);
INSERT INTO `judge` VALUES (119, 1013, '1111', '1', 'root', '2023-05-09 01:29:08', 0, 1, NULL, 6, 1688, NULL, 107, '#include<bits/stdc++.h>\n\nusing namespace std;\n\nint main() {\n    string ss;\n    cin >> ss;\n    cout << ss;\n}', 'C++', NULL, 0, 0, 'hoj-judger-1', '0:0:0:0:0:0:0:1', 1, NULL, NULL, NULL, NULL, 0, '2023-05-09 01:29:08', '2023-05-09 20:14:05', NULL);
INSERT INTO `judge` VALUES (120, 1006, 'CF-CF1A', '1', 'root', '2023-05-10 22:28:04', 0, 0, NULL, 15, 4, NULL, 230, '#include<bits/stdc++.h>\nusing namespace std;\n\n#define ll long long\nint main(){\n    ll n,m,a;\n    cin>>n>>m>>a;\n    if(n%a==0) n/=a;\n    else n=n/a+1;\n    \n    if(m%a==0) m/=a;\n    else m=m/a+1;\n    cout<<n*m<<endl;\n    return 0;\n}', 'GNU G++14 6.4.0', NULL, 0, 0, 'hoj-judger-1', '127.0.0.1', 0, NULL, 205340036, '2778763221@qq.com', 'dgut2834', 0, '2023-05-10 22:30:06', '2023-05-10 22:33:20', NULL);
INSERT INTO `judge` VALUES (121, 1006, 'CF-CF1A', '1', 'root', '2023-05-10 22:33:54', 0, 0, NULL, 15, 4, NULL, 230, '#include<bits/stdc++.h>\nusing namespace std;\n\n#define ll long long\nint main(){\n    ll n,m,a;\n    cin>>n>>m>>a;\n    if(n%a==0) n/=a;\n    else n=n/a+1;\n    \n    if(m%a==0) m/=a;\n    else m=m/a+1;\n    cout<<n*m<<endl;\n    return 0;\n}', 'GNU G++14 6.4.0', NULL, 0, 0, 'hoj-judger-1', '0:0:0:0:0:0:0:1', 0, NULL, 205340118, '2778763221@qq.com', 'dgut2834', 0, '2023-05-10 22:33:54', '2023-05-10 22:34:07', NULL);
INSERT INTO `judge` VALUES (122, 1006, 'CF-CF1A', '1', 'root', '2023-05-11 23:59:42', 4, 0, 'System Error! Cause: The System does not have [CODEFORCES] account configured. Please report the matter to the administrator!', NULL, NULL, NULL, 230, '#include<bits/stdc++.h>\nusing namespace std;\n\n#define ll long long\nint main(){\n    ll n,m,a;\n    cin>>n>>m>>a;\n    if(n%a==0) n/=a;\n    else n=n/a+1;\n    \n    if(m%a==0) m/=a;\n    else m=m/a+1;\n    cout<<n*m<<endl;\n    return 0;\n}', 'GNU G++14 6.4.0', NULL, 0, 0, NULL, '0:0:0:0:0:0:0:1', 0, 0, NULL, NULL, NULL, 0, '2023-05-11 23:59:42', '2023-05-11 23:59:42', NULL);
INSERT INTO `judge` VALUES (123, 1006, 'CF-CF1A', '1', 'root', '2023-05-12 00:03:11', 4, 0, 'System Error! Cause: The System does not have [CODEFORCES] account configured. Please report the matter to the administrator!', NULL, NULL, NULL, 230, '#include<bits/stdc++.h>\nusing namespace std;\n\n#define ll long long\nint main(){\n    ll n,m,a;\n    cin>>n>>m>>a;\n    if(n%a==0) n/=a;\n    else n=n/a+1;\n    \n    if(m%a==0) m/=a;\n    else m=m/a+1;\n    cout<<n*m<<endl;\n    return 0;\n}', 'GNU G++14 6.4.0', NULL, 0, 0, NULL, '0:0:0:0:0:0:0:1', 0, 0, NULL, NULL, NULL, 0, '2023-05-12 00:03:11', '2023-05-12 00:03:11', NULL);
INSERT INTO `judge` VALUES (124, 1006, 'CF-CF1A', '1', 'root', '2023-05-12 00:06:20', 0, 0, NULL, 0, 8, NULL, 230, '#include<bits/stdc++.h>\nusing namespace std;\n\n#define ll long long\nint main(){\n    ll n,m,a;\n    cin>>n>>m>>a;\n    if(n%a==0) n/=a;\n    else n=n/a+1;\n    \n    if(m%a==0) m/=a;\n    else m=m/a+1;\n    cout<<n*m<<endl;\n    return 0;\n}', 'GNU G++14 6.4.0', NULL, 0, 0, 'hoj-judger-1', '0:0:0:0:0:0:0:1', 2, NULL, 205470278, '2778763221@qq.com', 'dgut2834', 0, '2023-05-12 00:06:20', '2023-05-12 03:23:54', NULL);
INSERT INTO `judge` VALUES (125, 1006, 'CF-CF1A', '1', 'root', '2023-05-12 03:01:10', 0, 0, NULL, 0, 4, NULL, 230, '#include<bits/stdc++.h>\nusing namespace std;\n\n#define ll long long\nint main(){\n    ll n,m,a;\n    cin>>n>>m>>a;\n    if(n%a==0) n/=a;\n    else n=n/a+1;\n    \n    if(m%a==0) m/=a;\n    else m=m/a+1;\n    cout<<n*m<<endl;\n    return 0;\n}', 'GNU G++14 6.4.0', NULL, 0, 0, 'hoj-judger-1', '0:0:0:0:0:0:0:1', 0, NULL, 205470763, '2778763221@qq.com', 'dgut2834', 0, '2023-05-12 03:01:10', '2023-05-12 03:06:29', NULL);
INSERT INTO `judge` VALUES (126, 1006, 'CF-CF1A', '1', 'root', '2023-05-12 03:04:38', 4, 0, 'System Error! Cause: The System does not have [CODEFORCES] account configured. Please report the matter to the administrator!', NULL, NULL, NULL, 230, '#include<bits/stdc++.h>\nusing namespace std;\n\n#define ll long long\nint main(){\n    ll n,m,a;\n    cin>>n>>m>>a;\n    if(n%a==0) n/=a;\n    else n=n/a+1;\n    \n    if(m%a==0) m/=a;\n    else m=m/a+1;\n    cout<<n*m<<endl;\n    return 0;\n}', 'GNU G++14 6.4.0', NULL, 0, 0, NULL, '0:0:0:0:0:0:0:1', 0, 0, NULL, NULL, NULL, 0, '2023-05-12 03:04:38', '2023-05-12 03:04:50', NULL);
INSERT INTO `judge` VALUES (127, 1006, 'CF-CF1A', '1', 'root', '2023-05-12 03:05:08', 4, 0, 'System Error! Cause: The System does not have [CODEFORCES] account configured. Please report the matter to the administrator!', NULL, NULL, NULL, 230, '#include<bits/stdc++.h>\nusing namespace std;\n\n#define ll long long\nint main(){\n    ll n,m,a;\n    cin>>n>>m>>a;\n    if(n%a==0) n/=a;\n    else n=n/a+1;\n    \n    if(m%a==0) m/=a;\n    else m=m/a+1;\n    cout<<n*m<<endl;\n    return 0;\n}', 'GNU G++14 6.4.0', NULL, 0, 0, NULL, '0:0:0:0:0:0:0:1', 0, 0, NULL, NULL, NULL, 0, '2023-05-12 03:05:08', '2023-05-12 03:06:23', NULL);
INSERT INTO `judge` VALUES (128, 1006, 'CF-CF1A', '1', 'root', '2023-05-12 03:06:27', 4, 0, 'System Error! Cause: The System does not have [CODEFORCES] account configured. Please report the matter to the administrator!', NULL, NULL, NULL, 230, '#include<bits/stdc++.h>\nusing namespace std;\n\n#define ll long long\nint main(){\n    ll n,m,a;\n    cin>>n>>m>>a;\n    if(n%a==0) n/=a;\n    else n=n/a+1;\n    \n    if(m%a==0) m/=a;\n    else m=m/a+1;\n    cout<<n*m<<endl;\n    return 0;\n}', 'GNU G++14 6.4.0', NULL, 0, 0, NULL, '0:0:0:0:0:0:0:1', 0, 0, NULL, NULL, NULL, 0, '2023-05-12 03:06:27', '2023-05-12 03:09:46', NULL);
INSERT INTO `judge` VALUES (129, 1006, 'CF-CF1A', '1', 'root', '2023-05-12 03:06:50', 0, 0, NULL, 15, 8, NULL, 230, '#include<bits/stdc++.h>\nusing namespace std;\n\n#define ll long long\nint main(){\n    ll n,m,a;\n    cin>>n>>m>>a;\n    if(n%a==0) n/=a;\n    else n=n/a+1;\n    \n    if(m%a==0) m/=a;\n    else m=m/a+1;\n    cout<<n*m<<endl;\n    return 0;\n}', 'GNU G++14 6.4.0', NULL, 0, 0, 'hoj-judger-1', '0:0:0:0:0:0:0:1', 1, NULL, 205472120, '2778763221@qq.com', 'dgut2834', 0, '2023-05-12 03:06:50', '2023-05-12 03:24:21', NULL);
INSERT INTO `judge` VALUES (130, 1006, 'CF-CF1A', '1', 'root', '2023-05-12 03:11:27', 0, 0, NULL, 15, 8, NULL, 230, '#include<bits/stdc++.h>\nusing namespace std;\n\n#define ll long long\nint main(){\n    ll n,m,a;\n    cin>>n>>m>>a;\n    if(n%a==0) n/=a;\n    else n=n/a+1;\n    \n    if(m%a==0) m/=a;\n    else m=m/a+1;\n    cout<<n*m<<endl;\n    return 0;\n}', 'GNU G++14 6.4.0', NULL, 0, 0, 'hoj-judger-1', '0:0:0:0:0:0:0:1', 1, NULL, 205472317, '2778763221@qq.com', 'dgut2834', 0, '2023-05-12 03:11:27', '2023-05-12 03:27:23', NULL);
INSERT INTO `judge` VALUES (131, 1006, 'CF-CF1A', '1', 'root', '2023-05-12 03:12:20', 0, 0, NULL, 0, 4, NULL, 230, '#include<bits/stdc++.h>\nusing namespace std;\n\n#define ll long long\nint main(){\n    ll n,m,a;\n    cin>>n>>m>>a;\n    if(n%a==0) n/=a;\n    else n=n/a+1;\n    \n    if(m%a==0) m/=a;\n    else m=m/a+1;\n    cout<<n*m<<endl;\n    return 0;\n}', 'GNU G++14 6.4.0', NULL, 0, 0, 'hoj-judger-1', '0:0:0:0:0:0:0:1', 1, NULL, 205472302, '2778763221@qq.com', 'dgut2834', 0, '2023-05-12 03:12:20', '2023-05-12 03:27:13', NULL);
INSERT INTO `judge` VALUES (132, 1006, 'CF-CF1A', '1', 'root', '2023-05-12 03:14:08', 0, 0, NULL, 15, 8, NULL, 230, '#include<bits/stdc++.h>\nusing namespace std;\n\n#define ll long long\nint main(){\n    ll n,m,a;\n    cin>>n>>m>>a;\n    if(n%a==0) n/=a;\n    else n=n/a+1;\n    \n    if(m%a==0) m/=a;\n    else m=m/a+1;\n    cout<<n*m<<endl;\n    return 0;\n}', 'GNU G++14 6.4.0', NULL, 0, 0, 'hoj-judger-1', '0:0:0:0:0:0:0:1', 1, NULL, 205472292, '2778763221@qq.com', 'dgut2834', 0, '2023-05-12 03:14:08', '2023-05-12 03:27:03', NULL);
INSERT INTO `judge` VALUES (133, 1006, 'CF-CF1A', '1', 'root', '2023-05-12 03:17:24', 0, 0, NULL, 15, 8, NULL, 230, '#include<bits/stdc++.h>\nusing namespace std;\n\n#define ll long long\nint main(){\n    ll n,m,a;\n    cin>>n>>m>>a;\n    if(n%a==0) n/=a;\n    else n=n/a+1;\n    \n    if(m%a==0) m/=a;\n    else m=m/a+1;\n    cout<<n*m<<endl;\n    return 0;\n}', 'GNU G++14 6.4.0', NULL, 0, 0, 'hoj-judger-1', '0:0:0:0:0:0:0:1', 1, NULL, 205472283, '2778763221@qq.com', 'dgut2834', 0, '2023-05-12 03:17:24', '2023-05-12 03:26:53', NULL);
INSERT INTO `judge` VALUES (134, 1006, 'CF-CF1A', '1', 'root', '2023-05-12 03:22:33', 0, 0, NULL, 15, 8, NULL, 230, '#include<bits/stdc++.h>\nusing namespace std;\n\n#define ll long long\nint main(){\n    ll n,m,a;\n    cin>>n>>m>>a;\n    if(n%a==0) n/=a;\n    else n=n/a+1;\n    \n    if(m%a==0) m/=a;\n    else m=m/a+1;\n    cout<<n*m<<endl;\n    return 0;\n}', 'GNU G++14 6.4.0', NULL, 0, 0, 'hoj-judger-1', '0:0:0:0:0:0:0:1', 0, NULL, 205472099, '2778763221@qq.com', 'dgut2834', 0, '2023-05-12 03:22:33', '2023-05-12 03:24:03', NULL);
INSERT INTO `judge` VALUES (135, 1006, 'CF-CF1A', '1', 'root', '2023-05-12 03:24:37', 0, 0, NULL, 15, 8, NULL, 230, '#include<bits/stdc++.h>\nusing namespace std;\n\n#define ll long long\nint main(){\n    ll n,m,a;\n    cin>>n>>m>>a;\n    if(n%a==0) n/=a;\n    else n=n/a+1;\n    \n    if(m%a==0) m/=a;\n    else m=m/a+1;\n    cout<<n*m<<endl;\n    return 0;\n}', 'GNU G++14 6.4.0', NULL, 0, 0, 'hoj-judger-1', '0:0:0:0:0:0:0:1', 0, NULL, 205472152, '2778763221@qq.com', 'dgut2834', 0, '2023-05-12 03:24:38', '2023-05-12 03:24:47', NULL);
INSERT INTO `judge` VALUES (136, 1006, 'CF-CF1A', '1', 'root', '2023-05-12 03:25:33', 0, 0, NULL, 15, 8, NULL, 230, '#include<bits/stdc++.h>\nusing namespace std;\n\n#define ll long long\nint main(){\n    ll n,m,a;\n    cin>>n>>m>>a;\n    if(n%a==0) n/=a;\n    else n=n/a+1;\n    \n    if(m%a==0) m/=a;\n    else m=m/a+1;\n    cout<<n*m<<endl;\n    return 0;\n}', 'GNU G++14 6.4.0', NULL, 0, 0, 'loj-judger-1', '0:0:0:0:0:0:0:1', 0, NULL, 205472205, '2778763221@qq.com', 'dgut2834', 0, '2023-05-12 03:25:33', '2023-05-12 03:25:44', NULL);
INSERT INTO `judge` VALUES (137, 1006, 'CF-CF1A', '1', 'root', '2023-05-12 03:27:14', 0, 0, NULL, 15, 8, NULL, 230, '#include<bits/stdc++.h>\nusing namespace std;\n\n#define ll long long\nint main(){\n    ll n,m,a;\n    cin>>n>>m>>a;\n    if(n%a==0) n/=a;\n    else n=n/a+1;\n    \n    if(m%a==0) m/=a;\n    else m=m/a+1;\n    cout<<n*m<<endl;\n    return 0;\n}', 'GNU G++14 6.4.0', NULL, 0, 0, 'loj-judger-1', '0:0:0:0:0:0:0:1', 0, NULL, 205472329, '2778763221@qq.com', 'dgut2834', 0, '2023-05-12 03:27:14', '2023-05-12 03:27:35', NULL);
INSERT INTO `judge` VALUES (138, 1006, 'CF-CF1A', '1', 'root', '2023-05-12 03:27:28', 0, 0, NULL, 15, 4, NULL, 230, '#include<bits/stdc++.h>\nusing namespace std;\n\n#define ll long long\nint main(){\n    ll n,m,a;\n    cin>>n>>m>>a;\n    if(n%a==0) n/=a;\n    else n=n/a+1;\n    \n    if(m%a==0) m/=a;\n    else m=m/a+1;\n    cout<<n*m<<endl;\n    return 0;\n}', 'GNU G++14 6.4.0', NULL, 0, 0, 'loj-judger-1', '0:0:0:0:0:0:0:1', 0, NULL, 205472341, '2778763221@qq.com', 'dgut2834', 0, '2023-05-12 03:27:28', '2023-05-12 03:27:46', NULL);
INSERT INTO `judge` VALUES (139, 1006, 'CF-CF1A', '1', 'root', '2023-05-12 03:27:37', 0, 0, NULL, 15, 8, NULL, 230, '#include<bits/stdc++.h>\nusing namespace std;\n\n#define ll long long\nint main(){\n    ll n,m,a;\n    cin>>n>>m>>a;\n    if(n%a==0) n/=a;\n    else n=n/a+1;\n    \n    if(m%a==0) m/=a;\n    else m=m/a+1;\n    cout<<n*m<<endl;\n    return 0;\n}', 'GNU G++14 6.4.0', NULL, 0, 0, 'loj-judger-1', '0:0:0:0:0:0:0:1', 0, NULL, 205472369, '2778763221@qq.com', 'dgut2834', 0, '2023-05-12 03:27:37', '2023-05-12 03:28:14', NULL);
INSERT INTO `judge` VALUES (140, 1006, 'CF-CF1A', '1', 'root', '2023-05-12 03:27:46', 0, 0, NULL, 15, 4, NULL, 230, '#include<bits/stdc++.h>\nusing namespace std;\n\n#define ll long long\nint main(){\n    ll n,m,a;\n    cin>>n>>m>>a;\n    if(n%a==0) n/=a;\n    else n=n/a+1;\n    \n    if(m%a==0) m/=a;\n    else m=m/a+1;\n    cout<<n*m<<endl;\n    return 0;\n}', 'GNU G++14 6.4.0', NULL, 0, 0, 'loj-judger-1', '0:0:0:0:0:0:0:1', 0, NULL, 205472345, '2778763221@qq.com', 'dgut2834', 0, '2023-05-12 03:27:46', '2023-05-12 03:27:55', NULL);
INSERT INTO `judge` VALUES (141, 1006, 'CF-CF1A', '1', 'root', '2023-05-12 03:27:55', 0, 0, NULL, 15, 8, NULL, 230, '#include<bits/stdc++.h>\nusing namespace std;\n\n#define ll long long\nint main(){\n    ll n,m,a;\n    cin>>n>>m>>a;\n    if(n%a==0) n/=a;\n    else n=n/a+1;\n    \n    if(m%a==0) m/=a;\n    else m=m/a+1;\n    cout<<n*m<<endl;\n    return 0;\n}', 'GNU G++14 6.4.0', NULL, 0, 0, 'loj-judger-1', '0:0:0:0:0:0:0:1', 0, NULL, 205472356, '2778763221@qq.com', 'dgut2834', 0, '2023-05-12 03:27:55', '2023-05-12 03:28:04', NULL);
INSERT INTO `judge` VALUES (142, 1006, 'CF-CF1A', '1', 'root', '2023-05-12 03:28:03', 0, 0, NULL, 15, 8, NULL, 230, '#include<bits/stdc++.h>\nusing namespace std;\n\n#define ll long long\nint main(){\n    ll n,m,a;\n    cin>>n>>m>>a;\n    if(n%a==0) n/=a;\n    else n=n/a+1;\n    \n    if(m%a==0) m/=a;\n    else m=m/a+1;\n    cout<<n*m<<endl;\n    return 0;\n}', 'GNU G++14 6.4.0', NULL, 0, 0, 'loj-judger-1', '0:0:0:0:0:0:0:1', 0, NULL, 205472378, '2778763221@qq.com', 'dgut2834', 0, '2023-05-12 03:28:03', '2023-05-12 03:28:24', NULL);
INSERT INTO `judge` VALUES (143, 1006, 'CF-CF1A', '1', 'root', '2023-05-12 03:28:16', 0, 0, NULL, 0, 8, NULL, 230, '#include<bits/stdc++.h>\nusing namespace std;\n\n#define ll long long\nint main(){\n    ll n,m,a;\n    cin>>n>>m>>a;\n    if(n%a==0) n/=a;\n    else n=n/a+1;\n    \n    if(m%a==0) m/=a;\n    else m=m/a+1;\n    cout<<n*m<<endl;\n    return 0;\n}', 'GNU G++14 6.4.0', NULL, 0, 0, 'loj-judger-1', '0:0:0:0:0:0:0:1', 0, NULL, 205472390, '2778763221@qq.com', 'dgut2834', 0, '2023-05-12 03:28:16', '2023-05-12 03:28:34', NULL);
INSERT INTO `judge` VALUES (144, 1006, 'CF-CF1A', '1', 'root', '2023-05-12 03:28:37', -2, 0, 'Can\'t compile file:\nprogram.cpp: In function \'int main()\':\r\nprogram.cpp:14:5: error: expected \';\' before \'return\'\r\n     return 0;\r\n     ^~~~~~\r\n', 0, 0, NULL, 229, '#include<bits/stdc++.h>\nusing namespace std;\n\n#define ll long long\nint main(){\n    ll n,m,a;\n    cin>>n>>m>>a;\n    if(n%a==0) n/=a;\n    else n=n/a+1;\n    \n    if(m%a==0) m/=a;\n    else m=m/a+1;\n    cout<<n*m<<endl\n    return 0;\n}', 'GNU G++14 6.4.0', NULL, 0, 0, 'loj-judger-1', '0:0:0:0:0:0:0:1', 0, NULL, 205472403, '2778763221@qq.com', 'dgut2834', 0, '2023-05-12 03:28:37', '2023-05-12 03:28:46', NULL);
INSERT INTO `judge` VALUES (145, 1013, '1111', '1', 'root', '2023-05-17 23:31:14', 0, 0, NULL, 5, 1688, NULL, 107, '#include<bits/stdc++.h>\n\nusing namespace std;\n\nint main() {\n    string ss;\n    cin >> ss;\n    cout << ss;\n}', 'C++', NULL, 1000, 4, 'hoj-judger-1', '127.0.0.1', 0, NULL, NULL, NULL, NULL, 0, '2023-05-17 23:31:14', '2023-05-17 23:31:23', NULL);

-- ----------------------------
-- Table structure for judge_case
-- ----------------------------
DROP TABLE IF EXISTS `judge_case`;
CREATE TABLE `judge_case`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `submit_id` bigint(0) UNSIGNED NOT NULL COMMENT '提交判题id',
  `uid` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户id',
  `pid` bigint(0) UNSIGNED NOT NULL COMMENT '题目id',
  `case_id` bigint(0) NULL DEFAULT NULL COMMENT '测试样例id',
  `status` int(0) NULL DEFAULT NULL COMMENT '具体看结果码',
  `time` int(0) NULL DEFAULT NULL COMMENT '测试该样例所用时间ms',
  `memory` int(0) NULL DEFAULT NULL COMMENT '测试该样例所用空间KB',
  `score` int(0) NULL DEFAULT NULL COMMENT 'IO得分',
  `group_num` int(0) NULL DEFAULT NULL COMMENT 'subtask分组的组号',
  `seq` int(0) NULL DEFAULT NULL COMMENT '排序',
  `mode` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'default' COMMENT 'default,subtask_lowest,subtask_average',
  `input_data` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '样例输入，比赛不可看',
  `output_data` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '样例输出，比赛不可看',
  `user_output` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '用户样例输出，比赛不可看',
  `gmt_create` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `gmt_modified` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`, `submit_id`, `uid`, `pid`) USING BTREE,
  INDEX `case_id`(`case_id`) USING BTREE,
  INDEX `judge_case_ibfk_1`(`uid`) USING BTREE,
  INDEX `judge_case_ibfk_2`(`pid`) USING BTREE,
  INDEX `judge_case_ibfk_3`(`submit_id`) USING BTREE,
  CONSTRAINT `judge_case_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `user_info` (`uuid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `judge_case_ibfk_2` FOREIGN KEY (`pid`) REFERENCES `problem` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `judge_case_ibfk_3` FOREIGN KEY (`submit_id`) REFERENCES `judge` (`submit_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 847 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of judge_case
-- ----------------------------
INSERT INTO `judge_case` VALUES (30, 81, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-04-28 00:56:22', '2023-04-28 00:56:22');
INSERT INTO `judge_case` VALUES (31, 81, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-04-28 00:56:22', '2023-04-28 00:56:22');
INSERT INTO `judge_case` VALUES (32, 81, '1', 1006, NULL, 0, 15, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"2\"\r\n', '2023-04-28 00:56:22', '2023-04-28 00:56:22');
INSERT INTO `judge_case` VALUES (33, 81, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"2\"\r\n', '2023-04-28 00:56:22', '2023-04-28 00:56:22');
INSERT INTO `judge_case` VALUES (34, 81, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-04-28 00:56:22', '2023-04-28 00:56:22');
INSERT INTO `judge_case` VALUES (35, 81, '1', 1006, NULL, 0, 15, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-04-28 00:56:22', '2023-04-28 00:56:22');
INSERT INTO `judge_case` VALUES (36, 81, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-04-28 00:56:22', '2023-04-28 00:56:22');
INSERT INTO `judge_case` VALUES (37, 81, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-04-28 00:56:22', '2023-04-28 00:56:22');
INSERT INTO `judge_case` VALUES (38, 81, '1', 1006, NULL, 0, 0, 8, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1000000000000000000\"\r\n', '2023-04-28 00:56:22', '2023-04-28 00:56:22');
INSERT INTO `judge_case` VALUES (39, 81, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"12\"\r\n', '2023-04-28 00:56:22', '2023-04-28 00:56:22');
INSERT INTO `judge_case` VALUES (40, 81, '1', 1006, NULL, 0, 15, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3015\"\r\n', '2023-04-28 00:56:22', '2023-04-28 00:56:22');
INSERT INTO `judge_case` VALUES (41, 81, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"10000\"\r\n', '2023-04-28 00:56:22', '2023-04-28 00:56:22');
INSERT INTO `judge_case` VALUES (42, 81, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"10100\"\r\n', '2023-04-28 00:56:22', '2023-04-28 00:56:22');
INSERT INTO `judge_case` VALUES (43, 81, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-04-28 00:56:22', '2023-04-28 00:56:22');
INSERT INTO `judge_case` VALUES (44, 81, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-04-28 00:56:22', '2023-04-28 00:56:22');
INSERT INTO `judge_case` VALUES (45, 81, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-04-28 00:56:22', '2023-04-28 00:56:22');
INSERT INTO `judge_case` VALUES (46, 81, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"27126743055556\"\r\n', '2023-04-28 00:56:22', '2023-04-28 00:56:22');
INSERT INTO `judge_case` VALUES (47, 81, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"987654321000000000\"\r\n', '2023-04-28 00:56:22', '2023-04-28 00:56:22');
INSERT INTO `judge_case` VALUES (48, 81, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"175618850864484\"\r\n', '2023-04-28 00:56:22', '2023-04-28 00:56:22');
INSERT INTO `judge_case` VALUES (49, 81, '1', 1006, NULL, 0, 0, 8, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3295710\"\r\n', '2023-04-28 00:56:22', '2023-04-28 00:56:22');
INSERT INTO `judge_case` VALUES (50, 80, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-04-28 00:56:54', '2023-04-28 00:56:54');
INSERT INTO `judge_case` VALUES (51, 80, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-04-28 00:56:54', '2023-04-28 00:56:54');
INSERT INTO `judge_case` VALUES (52, 80, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"2\"\r\n', '2023-04-28 00:56:54', '2023-04-28 00:56:54');
INSERT INTO `judge_case` VALUES (53, 80, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"2\"\r\n', '2023-04-28 00:56:54', '2023-04-28 00:56:54');
INSERT INTO `judge_case` VALUES (54, 80, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-04-28 00:56:54', '2023-04-28 00:56:54');
INSERT INTO `judge_case` VALUES (55, 80, '1', 1006, NULL, 0, 15, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-04-28 00:56:54', '2023-04-28 00:56:54');
INSERT INTO `judge_case` VALUES (56, 80, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-04-28 00:56:54', '2023-04-28 00:56:54');
INSERT INTO `judge_case` VALUES (57, 80, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-04-28 00:56:54', '2023-04-28 00:56:54');
INSERT INTO `judge_case` VALUES (58, 80, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1000000000000000000\"\r\n', '2023-04-28 00:56:54', '2023-04-28 00:56:54');
INSERT INTO `judge_case` VALUES (59, 80, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"12\"\r\n', '2023-04-28 00:56:54', '2023-04-28 00:56:54');
INSERT INTO `judge_case` VALUES (60, 80, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3015\"\r\n', '2023-04-28 00:56:54', '2023-04-28 00:56:54');
INSERT INTO `judge_case` VALUES (61, 80, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"10000\"\r\n', '2023-04-28 00:56:54', '2023-04-28 00:56:54');
INSERT INTO `judge_case` VALUES (62, 80, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"10100\"\r\n', '2023-04-28 00:56:54', '2023-04-28 00:56:54');
INSERT INTO `judge_case` VALUES (63, 80, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-04-28 00:56:54', '2023-04-28 00:56:54');
INSERT INTO `judge_case` VALUES (64, 80, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-04-28 00:56:54', '2023-04-28 00:56:54');
INSERT INTO `judge_case` VALUES (65, 80, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-04-28 00:56:54', '2023-04-28 00:56:54');
INSERT INTO `judge_case` VALUES (66, 80, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"27126743055556\"\r\n', '2023-04-28 00:56:54', '2023-04-28 00:56:54');
INSERT INTO `judge_case` VALUES (67, 80, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"987654321000000000\"\r\n', '2023-04-28 00:56:54', '2023-04-28 00:56:54');
INSERT INTO `judge_case` VALUES (68, 80, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"175618850864484\"\r\n', '2023-04-28 00:56:54', '2023-04-28 00:56:54');
INSERT INTO `judge_case` VALUES (69, 80, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3295710\"\r\n', '2023-04-28 00:56:54', '2023-04-28 00:56:54');
INSERT INTO `judge_case` VALUES (70, 79, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-04-28 00:57:05', '2023-04-28 00:57:05');
INSERT INTO `judge_case` VALUES (71, 79, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-04-28 00:57:05', '2023-04-28 00:57:05');
INSERT INTO `judge_case` VALUES (72, 79, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"2\"\r\n', '2023-04-28 00:57:05', '2023-04-28 00:57:05');
INSERT INTO `judge_case` VALUES (73, 79, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"2\"\r\n', '2023-04-28 00:57:05', '2023-04-28 00:57:05');
INSERT INTO `judge_case` VALUES (74, 79, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-04-28 00:57:05', '2023-04-28 00:57:05');
INSERT INTO `judge_case` VALUES (75, 79, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-04-28 00:57:05', '2023-04-28 00:57:05');
INSERT INTO `judge_case` VALUES (76, 79, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-04-28 00:57:05', '2023-04-28 00:57:05');
INSERT INTO `judge_case` VALUES (77, 79, '1', 1006, NULL, 0, 15, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-04-28 00:57:05', '2023-04-28 00:57:05');
INSERT INTO `judge_case` VALUES (78, 79, '1', 1006, NULL, 0, 15, 8, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1000000000000000000\"\r\n', '2023-04-28 00:57:05', '2023-04-28 00:57:05');
INSERT INTO `judge_case` VALUES (79, 79, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"12\"\r\n', '2023-04-28 00:57:05', '2023-04-28 00:57:05');
INSERT INTO `judge_case` VALUES (80, 79, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3015\"\r\n', '2023-04-28 00:57:05', '2023-04-28 00:57:05');
INSERT INTO `judge_case` VALUES (81, 79, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"10000\"\r\n', '2023-04-28 00:57:05', '2023-04-28 00:57:05');
INSERT INTO `judge_case` VALUES (82, 79, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"10100\"\r\n', '2023-04-28 00:57:05', '2023-04-28 00:57:05');
INSERT INTO `judge_case` VALUES (83, 79, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-04-28 00:57:05', '2023-04-28 00:57:05');
INSERT INTO `judge_case` VALUES (84, 79, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-04-28 00:57:05', '2023-04-28 00:57:05');
INSERT INTO `judge_case` VALUES (85, 79, '1', 1006, NULL, 0, 15, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-04-28 00:57:05', '2023-04-28 00:57:05');
INSERT INTO `judge_case` VALUES (86, 79, '1', 1006, NULL, 0, 15, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"27126743055556\"\r\n', '2023-04-28 00:57:05', '2023-04-28 00:57:05');
INSERT INTO `judge_case` VALUES (87, 79, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"987654321000000000\"\r\n', '2023-04-28 00:57:05', '2023-04-28 00:57:05');
INSERT INTO `judge_case` VALUES (88, 79, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"175618850864484\"\r\n', '2023-04-28 00:57:05', '2023-04-28 00:57:05');
INSERT INTO `judge_case` VALUES (89, 79, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3295710\"\r\n', '2023-04-28 00:57:05', '2023-04-28 00:57:05');
INSERT INTO `judge_case` VALUES (90, 77, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-04-28 00:57:17', '2023-04-28 00:57:17');
INSERT INTO `judge_case` VALUES (91, 77, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-04-28 00:57:17', '2023-04-28 00:57:17');
INSERT INTO `judge_case` VALUES (92, 77, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"2\"\r\n', '2023-04-28 00:57:17', '2023-04-28 00:57:17');
INSERT INTO `judge_case` VALUES (93, 77, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"2\"\r\n', '2023-04-28 00:57:17', '2023-04-28 00:57:17');
INSERT INTO `judge_case` VALUES (94, 77, '1', 1006, NULL, 0, 15, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-04-28 00:57:17', '2023-04-28 00:57:17');
INSERT INTO `judge_case` VALUES (95, 77, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-04-28 00:57:17', '2023-04-28 00:57:17');
INSERT INTO `judge_case` VALUES (96, 77, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-04-28 00:57:17', '2023-04-28 00:57:17');
INSERT INTO `judge_case` VALUES (97, 77, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-04-28 00:57:17', '2023-04-28 00:57:17');
INSERT INTO `judge_case` VALUES (98, 77, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1000000000000000000\"\r\n', '2023-04-28 00:57:17', '2023-04-28 00:57:17');
INSERT INTO `judge_case` VALUES (99, 77, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"12\"\r\n', '2023-04-28 00:57:17', '2023-04-28 00:57:17');
INSERT INTO `judge_case` VALUES (100, 77, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3015\"\r\n', '2023-04-28 00:57:17', '2023-04-28 00:57:17');
INSERT INTO `judge_case` VALUES (101, 77, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"10000\"\r\n', '2023-04-28 00:57:17', '2023-04-28 00:57:17');
INSERT INTO `judge_case` VALUES (102, 77, '1', 1006, NULL, 0, 15, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"10100\"\r\n', '2023-04-28 00:57:17', '2023-04-28 00:57:17');
INSERT INTO `judge_case` VALUES (103, 77, '1', 1006, NULL, 0, 15, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-04-28 00:57:17', '2023-04-28 00:57:17');
INSERT INTO `judge_case` VALUES (104, 77, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-04-28 00:57:17', '2023-04-28 00:57:17');
INSERT INTO `judge_case` VALUES (105, 77, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-04-28 00:57:17', '2023-04-28 00:57:17');
INSERT INTO `judge_case` VALUES (106, 77, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"27126743055556\"\r\n', '2023-04-28 00:57:17', '2023-04-28 00:57:17');
INSERT INTO `judge_case` VALUES (107, 77, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"987654321000000000\"\r\n', '2023-04-28 00:57:17', '2023-04-28 00:57:17');
INSERT INTO `judge_case` VALUES (108, 77, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"175618850864484\"\r\n', '2023-04-28 00:57:17', '2023-04-28 00:57:17');
INSERT INTO `judge_case` VALUES (109, 77, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3295710\"\r\n', '2023-04-28 00:57:17', '2023-04-28 00:57:17');
INSERT INTO `judge_case` VALUES (110, 78, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-04-28 00:57:28', '2023-04-28 00:57:28');
INSERT INTO `judge_case` VALUES (111, 78, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-04-28 00:57:28', '2023-04-28 00:57:28');
INSERT INTO `judge_case` VALUES (112, 78, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"2\"\r\n', '2023-04-28 00:57:28', '2023-04-28 00:57:28');
INSERT INTO `judge_case` VALUES (113, 78, '1', 1006, NULL, 0, 15, 8, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"2\"\r\n', '2023-04-28 00:57:28', '2023-04-28 00:57:28');
INSERT INTO `judge_case` VALUES (114, 78, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-04-28 00:57:28', '2023-04-28 00:57:28');
INSERT INTO `judge_case` VALUES (115, 78, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-04-28 00:57:28', '2023-04-28 00:57:28');
INSERT INTO `judge_case` VALUES (116, 78, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-04-28 00:57:28', '2023-04-28 00:57:28');
INSERT INTO `judge_case` VALUES (117, 78, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-04-28 00:57:28', '2023-04-28 00:57:28');
INSERT INTO `judge_case` VALUES (118, 78, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1000000000000000000\"\r\n', '2023-04-28 00:57:28', '2023-04-28 00:57:28');
INSERT INTO `judge_case` VALUES (119, 78, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"12\"\r\n', '2023-04-28 00:57:28', '2023-04-28 00:57:28');
INSERT INTO `judge_case` VALUES (120, 78, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3015\"\r\n', '2023-04-28 00:57:28', '2023-04-28 00:57:28');
INSERT INTO `judge_case` VALUES (121, 78, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"10000\"\r\n', '2023-04-28 00:57:28', '2023-04-28 00:57:28');
INSERT INTO `judge_case` VALUES (122, 78, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"10100\"\r\n', '2023-04-28 00:57:28', '2023-04-28 00:57:28');
INSERT INTO `judge_case` VALUES (123, 78, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-04-28 00:57:28', '2023-04-28 00:57:28');
INSERT INTO `judge_case` VALUES (124, 78, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-04-28 00:57:28', '2023-04-28 00:57:28');
INSERT INTO `judge_case` VALUES (125, 78, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-04-28 00:57:28', '2023-04-28 00:57:28');
INSERT INTO `judge_case` VALUES (126, 78, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"27126743055556\"\r\n', '2023-04-28 00:57:28', '2023-04-28 00:57:28');
INSERT INTO `judge_case` VALUES (127, 78, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"987654321000000000\"\r\n', '2023-04-28 00:57:28', '2023-04-28 00:57:28');
INSERT INTO `judge_case` VALUES (128, 78, '1', 1006, NULL, 0, 15, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"175618850864484\"\r\n', '2023-04-28 00:57:28', '2023-04-28 00:57:28');
INSERT INTO `judge_case` VALUES (129, 78, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3295710\"\r\n', '2023-04-28 00:57:28', '2023-04-28 00:57:28');
INSERT INTO `judge_case` VALUES (130, 78, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-04-28 01:00:12', '2023-04-28 01:00:12');
INSERT INTO `judge_case` VALUES (131, 78, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-04-28 01:00:12', '2023-04-28 01:00:12');
INSERT INTO `judge_case` VALUES (132, 78, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"2\"\r\n', '2023-04-28 01:00:12', '2023-04-28 01:00:12');
INSERT INTO `judge_case` VALUES (133, 78, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"2\"\r\n', '2023-04-28 01:00:12', '2023-04-28 01:00:12');
INSERT INTO `judge_case` VALUES (134, 78, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-04-28 01:00:12', '2023-04-28 01:00:12');
INSERT INTO `judge_case` VALUES (135, 78, '1', 1006, NULL, 0, 15, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-04-28 01:00:12', '2023-04-28 01:00:12');
INSERT INTO `judge_case` VALUES (136, 78, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-04-28 01:00:12', '2023-04-28 01:00:12');
INSERT INTO `judge_case` VALUES (137, 78, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-04-28 01:00:12', '2023-04-28 01:00:12');
INSERT INTO `judge_case` VALUES (138, 78, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1000000000000000000\"\r\n', '2023-04-28 01:00:12', '2023-04-28 01:00:12');
INSERT INTO `judge_case` VALUES (139, 78, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"12\"\r\n', '2023-04-28 01:00:12', '2023-04-28 01:00:12');
INSERT INTO `judge_case` VALUES (140, 78, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3015\"\r\n', '2023-04-28 01:00:12', '2023-04-28 01:00:12');
INSERT INTO `judge_case` VALUES (141, 78, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"10000\"\r\n', '2023-04-28 01:00:12', '2023-04-28 01:00:12');
INSERT INTO `judge_case` VALUES (142, 78, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"10100\"\r\n', '2023-04-28 01:00:12', '2023-04-28 01:00:12');
INSERT INTO `judge_case` VALUES (143, 78, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-04-28 01:00:12', '2023-04-28 01:00:12');
INSERT INTO `judge_case` VALUES (144, 78, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-04-28 01:00:12', '2023-04-28 01:00:12');
INSERT INTO `judge_case` VALUES (145, 78, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-04-28 01:00:12', '2023-04-28 01:00:12');
INSERT INTO `judge_case` VALUES (146, 78, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"27126743055556\"\r\n', '2023-04-28 01:00:12', '2023-04-28 01:00:12');
INSERT INTO `judge_case` VALUES (147, 78, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"987654321000000000\"\r\n', '2023-04-28 01:00:12', '2023-04-28 01:00:12');
INSERT INTO `judge_case` VALUES (148, 78, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"175618850864484\"\r\n', '2023-04-28 01:00:12', '2023-04-28 01:00:12');
INSERT INTO `judge_case` VALUES (149, 78, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3295710\"\r\n', '2023-04-28 01:00:12', '2023-04-28 01:00:12');
INSERT INTO `judge_case` VALUES (196, 83, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-04-30 23:53:32', '2023-04-30 23:53:32');
INSERT INTO `judge_case` VALUES (197, 83, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-04-30 23:53:32', '2023-04-30 23:53:32');
INSERT INTO `judge_case` VALUES (198, 83, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"2\"\r\n', '2023-04-30 23:53:32', '2023-04-30 23:53:32');
INSERT INTO `judge_case` VALUES (199, 83, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"2\"\r\n', '2023-04-30 23:53:32', '2023-04-30 23:53:32');
INSERT INTO `judge_case` VALUES (200, 83, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-04-30 23:53:32', '2023-04-30 23:53:32');
INSERT INTO `judge_case` VALUES (201, 83, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-04-30 23:53:32', '2023-04-30 23:53:32');
INSERT INTO `judge_case` VALUES (202, 83, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-04-30 23:53:32', '2023-04-30 23:53:32');
INSERT INTO `judge_case` VALUES (203, 83, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-04-30 23:53:32', '2023-04-30 23:53:32');
INSERT INTO `judge_case` VALUES (204, 83, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1000000000000000000\"\r\n', '2023-04-30 23:53:32', '2023-04-30 23:53:32');
INSERT INTO `judge_case` VALUES (205, 83, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"12\"\r\n', '2023-04-30 23:53:32', '2023-04-30 23:53:32');
INSERT INTO `judge_case` VALUES (206, 83, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3015\"\r\n', '2023-04-30 23:53:32', '2023-04-30 23:53:32');
INSERT INTO `judge_case` VALUES (207, 83, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"10000\"\r\n', '2023-04-30 23:53:32', '2023-04-30 23:53:32');
INSERT INTO `judge_case` VALUES (208, 83, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"10100\"\r\n', '2023-04-30 23:53:32', '2023-04-30 23:53:32');
INSERT INTO `judge_case` VALUES (209, 83, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-04-30 23:53:32', '2023-04-30 23:53:32');
INSERT INTO `judge_case` VALUES (210, 83, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-04-30 23:53:32', '2023-04-30 23:53:32');
INSERT INTO `judge_case` VALUES (211, 83, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-04-30 23:53:32', '2023-04-30 23:53:32');
INSERT INTO `judge_case` VALUES (212, 83, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"27126743055556\"\r\n', '2023-04-30 23:53:32', '2023-04-30 23:53:32');
INSERT INTO `judge_case` VALUES (213, 83, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"987654321000000000\"\r\n', '2023-04-30 23:53:32', '2023-04-30 23:53:32');
INSERT INTO `judge_case` VALUES (214, 83, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"175618850864484\"\r\n', '2023-04-30 23:53:32', '2023-04-30 23:53:32');
INSERT INTO `judge_case` VALUES (215, 83, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3295710\"\r\n', '2023-04-30 23:53:32', '2023-04-30 23:53:32');
INSERT INTO `judge_case` VALUES (216, 83, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-04-30 23:53:43', '2023-04-30 23:53:43');
INSERT INTO `judge_case` VALUES (217, 83, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-04-30 23:53:43', '2023-04-30 23:53:43');
INSERT INTO `judge_case` VALUES (218, 83, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"2\"\r\n', '2023-04-30 23:53:43', '2023-04-30 23:53:43');
INSERT INTO `judge_case` VALUES (219, 83, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"2\"\r\n', '2023-04-30 23:53:43', '2023-04-30 23:53:43');
INSERT INTO `judge_case` VALUES (220, 83, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-04-30 23:53:43', '2023-04-30 23:53:43');
INSERT INTO `judge_case` VALUES (221, 83, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-04-30 23:53:43', '2023-04-30 23:53:43');
INSERT INTO `judge_case` VALUES (222, 83, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-04-30 23:53:43', '2023-04-30 23:53:43');
INSERT INTO `judge_case` VALUES (223, 83, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-04-30 23:53:43', '2023-04-30 23:53:43');
INSERT INTO `judge_case` VALUES (224, 83, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1000000000000000000\"\r\n', '2023-04-30 23:53:43', '2023-04-30 23:53:43');
INSERT INTO `judge_case` VALUES (225, 83, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"12\"\r\n', '2023-04-30 23:53:43', '2023-04-30 23:53:43');
INSERT INTO `judge_case` VALUES (226, 83, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3015\"\r\n', '2023-04-30 23:53:43', '2023-04-30 23:53:43');
INSERT INTO `judge_case` VALUES (227, 83, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"10000\"\r\n', '2023-04-30 23:53:43', '2023-04-30 23:53:43');
INSERT INTO `judge_case` VALUES (228, 83, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"10100\"\r\n', '2023-04-30 23:53:43', '2023-04-30 23:53:43');
INSERT INTO `judge_case` VALUES (229, 83, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-04-30 23:53:43', '2023-04-30 23:53:43');
INSERT INTO `judge_case` VALUES (230, 83, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-04-30 23:53:43', '2023-04-30 23:53:43');
INSERT INTO `judge_case` VALUES (231, 83, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-04-30 23:53:43', '2023-04-30 23:53:43');
INSERT INTO `judge_case` VALUES (232, 83, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"27126743055556\"\r\n', '2023-04-30 23:53:43', '2023-04-30 23:53:43');
INSERT INTO `judge_case` VALUES (233, 83, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"987654321000000000\"\r\n', '2023-04-30 23:53:43', '2023-04-30 23:53:43');
INSERT INTO `judge_case` VALUES (234, 83, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"175618850864484\"\r\n', '2023-04-30 23:53:43', '2023-04-30 23:53:43');
INSERT INTO `judge_case` VALUES (235, 83, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3295710\"\r\n', '2023-04-30 23:53:43', '2023-04-30 23:53:43');
INSERT INTO `judge_case` VALUES (236, 90, '1', 1009, NULL, 0, 0, 4000, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 3 number(s): \"3 -1 8\"\r\n', '2023-05-01 00:04:36', '2023-05-01 00:04:36');
INSERT INTO `judge_case` VALUES (237, 90, '1', 1009, NULL, 0, 62, 3988, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 00:04:36', '2023-05-01 00:04:36');
INSERT INTO `judge_case` VALUES (238, 90, '1', 1009, NULL, 0, 93, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 00:04:36', '2023-05-01 00:04:36');
INSERT INTO `judge_case` VALUES (239, 90, '1', 1009, NULL, 0, 93, 3992, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 00:04:36', '2023-05-01 00:04:36');
INSERT INTO `judge_case` VALUES (240, 90, '1', 1009, NULL, 0, 62, 3992, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 00:04:36', '2023-05-01 00:04:36');
INSERT INTO `judge_case` VALUES (241, 90, '1', 1009, NULL, 0, 61, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 00:04:36', '2023-05-01 00:04:36');
INSERT INTO `judge_case` VALUES (242, 90, '1', 1009, NULL, 0, 0, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"897\"\r\n', '2023-05-01 00:04:36', '2023-05-01 00:04:36');
INSERT INTO `judge_case` VALUES (243, 90, '1', 1009, NULL, 0, 61, 3992, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 00:04:36', '2023-05-01 00:04:36');
INSERT INTO `judge_case` VALUES (244, 90, '1', 1009, NULL, 0, 61, 4004, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 00:04:36', '2023-05-01 00:04:36');
INSERT INTO `judge_case` VALUES (245, 90, '1', 1009, NULL, 0, 0, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1998\"\r\n', '2023-05-01 00:04:36', '2023-05-01 00:04:36');
INSERT INTO `judge_case` VALUES (246, 90, '1', 1009, NULL, 0, 0, 4000, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1998\"\r\n', '2023-05-01 00:04:36', '2023-05-01 00:04:36');
INSERT INTO `judge_case` VALUES (247, 90, '1', 1009, NULL, 0, 0, 4000, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1998\"\r\n', '2023-05-01 00:04:36', '2023-05-01 00:04:36');
INSERT INTO `judge_case` VALUES (248, 90, '1', 1009, NULL, 0, 62, 4004, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 00:04:36', '2023-05-01 00:04:36');
INSERT INTO `judge_case` VALUES (249, 90, '1', 1009, NULL, 0, 0, 4004, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3\"\r\n', '2023-05-01 00:04:36', '2023-05-01 00:04:36');
INSERT INTO `judge_case` VALUES (250, 90, '1', 1009, NULL, 0, 0, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 2 number(s): \"3 -1\"\r\n', '2023-05-01 00:04:36', '2023-05-01 00:04:36');
INSERT INTO `judge_case` VALUES (251, 90, '1', 1009, NULL, 0, 0, 3992, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"-1\"\r\n', '2023-05-01 00:04:36', '2023-05-01 00:04:36');
INSERT INTO `judge_case` VALUES (252, 90, '1', 1009, NULL, 0, 0, 3992, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 2 number(s): \"-1 8\"\r\n', '2023-05-01 00:04:36', '2023-05-01 00:04:36');
INSERT INTO `judge_case` VALUES (253, 90, '1', 1009, NULL, 0, 0, 3992, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1409\"\r\n', '2023-05-01 00:04:36', '2023-05-01 00:04:36');
INSERT INTO `judge_case` VALUES (254, 90, '1', 1009, NULL, 0, 0, 4000, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 2 number(s): \"-1 -1\"\r\n', '2023-05-01 00:04:36', '2023-05-01 00:04:36');
INSERT INTO `judge_case` VALUES (255, 90, '1', 1009, NULL, 0, 77, 4000, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 00:04:36', '2023-05-01 00:04:36');
INSERT INTO `judge_case` VALUES (258, 90, '1', 1009, NULL, 0, 0, 3988, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 3 number(s): \"3 -1 8\"\r\n', '2023-05-01 00:31:22', '2023-05-01 00:31:22');
INSERT INTO `judge_case` VALUES (259, 90, '1', 1009, NULL, 0, 61, 3992, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 00:31:22', '2023-05-01 00:31:22');
INSERT INTO `judge_case` VALUES (260, 90, '1', 1009, NULL, 0, 77, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 00:31:22', '2023-05-01 00:31:22');
INSERT INTO `judge_case` VALUES (261, 90, '1', 1009, NULL, 0, 77, 4004, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 00:31:22', '2023-05-01 00:31:22');
INSERT INTO `judge_case` VALUES (262, 90, '1', 1009, NULL, 0, 77, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 00:31:22', '2023-05-01 00:31:22');
INSERT INTO `judge_case` VALUES (263, 90, '1', 1009, NULL, 0, 77, 4000, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 00:31:22', '2023-05-01 00:31:22');
INSERT INTO `judge_case` VALUES (264, 90, '1', 1009, NULL, 0, 0, 3992, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"897\"\r\n', '2023-05-01 00:31:22', '2023-05-01 00:31:22');
INSERT INTO `judge_case` VALUES (265, 90, '1', 1009, NULL, 0, 62, 3988, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 00:31:22', '2023-05-01 00:31:22');
INSERT INTO `judge_case` VALUES (266, 90, '1', 1009, NULL, 0, 93, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 00:31:22', '2023-05-01 00:31:22');
INSERT INTO `judge_case` VALUES (267, 90, '1', 1009, NULL, 0, 0, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1998\"\r\n', '2023-05-01 00:31:22', '2023-05-01 00:31:22');
INSERT INTO `judge_case` VALUES (268, 90, '1', 1009, NULL, 0, 0, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1998\"\r\n', '2023-05-01 00:31:22', '2023-05-01 00:31:22');
INSERT INTO `judge_case` VALUES (269, 90, '1', 1009, NULL, 0, 0, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1998\"\r\n', '2023-05-01 00:31:22', '2023-05-01 00:31:22');
INSERT INTO `judge_case` VALUES (270, 90, '1', 1009, NULL, 0, 62, 4000, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 00:31:22', '2023-05-01 00:31:22');
INSERT INTO `judge_case` VALUES (271, 90, '1', 1009, NULL, 0, 0, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3\"\r\n', '2023-05-01 00:31:22', '2023-05-01 00:31:22');
INSERT INTO `judge_case` VALUES (272, 90, '1', 1009, NULL, 0, 0, 3992, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 2 number(s): \"3 -1\"\r\n', '2023-05-01 00:31:22', '2023-05-01 00:31:22');
INSERT INTO `judge_case` VALUES (273, 90, '1', 1009, NULL, 0, 0, 4000, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"-1\"\r\n', '2023-05-01 00:31:22', '2023-05-01 00:31:22');
INSERT INTO `judge_case` VALUES (274, 90, '1', 1009, NULL, 0, 0, 3992, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 2 number(s): \"-1 8\"\r\n', '2023-05-01 00:31:22', '2023-05-01 00:31:22');
INSERT INTO `judge_case` VALUES (275, 90, '1', 1009, NULL, 0, 0, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1409\"\r\n', '2023-05-01 00:31:22', '2023-05-01 00:31:22');
INSERT INTO `judge_case` VALUES (276, 90, '1', 1009, NULL, 0, 0, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 2 number(s): \"-1 -1\"\r\n', '2023-05-01 00:31:22', '2023-05-01 00:31:22');
INSERT INTO `judge_case` VALUES (277, 90, '1', 1009, NULL, 0, 77, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 00:31:22', '2023-05-01 00:31:22');
INSERT INTO `judge_case` VALUES (278, 90, '1', 1009, NULL, 0, 0, 3988, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 3 number(s): \"3 -1 8\"\r\n', '2023-05-01 00:34:55', '2023-05-01 00:34:55');
INSERT INTO `judge_case` VALUES (279, 90, '1', 1009, NULL, 0, 61, 3992, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 00:34:55', '2023-05-01 00:34:55');
INSERT INTO `judge_case` VALUES (280, 90, '1', 1009, NULL, 0, 77, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 00:34:55', '2023-05-01 00:34:55');
INSERT INTO `judge_case` VALUES (281, 90, '1', 1009, NULL, 0, 77, 4004, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 00:34:55', '2023-05-01 00:34:55');
INSERT INTO `judge_case` VALUES (282, 90, '1', 1009, NULL, 0, 77, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 00:34:55', '2023-05-01 00:34:55');
INSERT INTO `judge_case` VALUES (283, 90, '1', 1009, NULL, 0, 77, 4000, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 00:34:55', '2023-05-01 00:34:55');
INSERT INTO `judge_case` VALUES (284, 90, '1', 1009, NULL, 0, 0, 3992, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"897\"\r\n', '2023-05-01 00:34:55', '2023-05-01 00:34:55');
INSERT INTO `judge_case` VALUES (285, 90, '1', 1009, NULL, 0, 62, 3988, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 00:34:55', '2023-05-01 00:34:55');
INSERT INTO `judge_case` VALUES (286, 90, '1', 1009, NULL, 0, 93, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 00:34:55', '2023-05-01 00:34:55');
INSERT INTO `judge_case` VALUES (287, 90, '1', 1009, NULL, 0, 0, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1998\"\r\n', '2023-05-01 00:34:55', '2023-05-01 00:34:55');
INSERT INTO `judge_case` VALUES (288, 90, '1', 1009, NULL, 0, 0, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1998\"\r\n', '2023-05-01 00:34:55', '2023-05-01 00:34:55');
INSERT INTO `judge_case` VALUES (289, 90, '1', 1009, NULL, 0, 0, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1998\"\r\n', '2023-05-01 00:34:55', '2023-05-01 00:34:55');
INSERT INTO `judge_case` VALUES (290, 90, '1', 1009, NULL, 0, 62, 4000, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 00:34:55', '2023-05-01 00:34:55');
INSERT INTO `judge_case` VALUES (291, 90, '1', 1009, NULL, 0, 0, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3\"\r\n', '2023-05-01 00:34:55', '2023-05-01 00:34:55');
INSERT INTO `judge_case` VALUES (292, 90, '1', 1009, NULL, 0, 0, 3992, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 2 number(s): \"3 -1\"\r\n', '2023-05-01 00:34:55', '2023-05-01 00:34:55');
INSERT INTO `judge_case` VALUES (293, 90, '1', 1009, NULL, 0, 0, 4000, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"-1\"\r\n', '2023-05-01 00:34:55', '2023-05-01 00:34:55');
INSERT INTO `judge_case` VALUES (294, 90, '1', 1009, NULL, 0, 0, 3992, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 2 number(s): \"-1 8\"\r\n', '2023-05-01 00:34:55', '2023-05-01 00:34:55');
INSERT INTO `judge_case` VALUES (295, 90, '1', 1009, NULL, 0, 0, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1409\"\r\n', '2023-05-01 00:34:55', '2023-05-01 00:34:55');
INSERT INTO `judge_case` VALUES (296, 90, '1', 1009, NULL, 0, 0, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 2 number(s): \"-1 -1\"\r\n', '2023-05-01 00:34:55', '2023-05-01 00:34:55');
INSERT INTO `judge_case` VALUES (297, 90, '1', 1009, NULL, 0, 77, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 00:34:55', '2023-05-01 00:34:55');
INSERT INTO `judge_case` VALUES (298, 90, '1', 1009, NULL, 0, 0, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 3 number(s): \"3 -1 8\"\r\n', '2023-05-01 00:39:53', '2023-05-01 00:39:53');
INSERT INTO `judge_case` VALUES (299, 90, '1', 1009, NULL, 0, 61, 3992, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 00:39:53', '2023-05-01 00:39:53');
INSERT INTO `judge_case` VALUES (300, 90, '1', 1009, NULL, 0, 62, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 00:39:53', '2023-05-01 00:39:53');
INSERT INTO `judge_case` VALUES (301, 90, '1', 1009, NULL, 0, 77, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 00:39:53', '2023-05-01 00:39:53');
INSERT INTO `judge_case` VALUES (302, 90, '1', 1009, NULL, 0, 77, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 00:39:53', '2023-05-01 00:39:53');
INSERT INTO `judge_case` VALUES (303, 90, '1', 1009, NULL, 0, 77, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 00:39:53', '2023-05-01 00:39:53');
INSERT INTO `judge_case` VALUES (304, 90, '1', 1009, NULL, 0, 0, 4000, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"897\"\r\n', '2023-05-01 00:39:53', '2023-05-01 00:39:53');
INSERT INTO `judge_case` VALUES (305, 90, '1', 1009, NULL, 0, 77, 3992, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 00:39:53', '2023-05-01 00:39:53');
INSERT INTO `judge_case` VALUES (306, 90, '1', 1009, NULL, 0, 77, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 00:39:53', '2023-05-01 00:39:53');
INSERT INTO `judge_case` VALUES (307, 90, '1', 1009, NULL, 0, 15, 3988, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1998\"\r\n', '2023-05-01 00:39:53', '2023-05-01 00:39:53');
INSERT INTO `judge_case` VALUES (308, 90, '1', 1009, NULL, 0, 0, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1998\"\r\n', '2023-05-01 00:39:53', '2023-05-01 00:39:53');
INSERT INTO `judge_case` VALUES (309, 90, '1', 1009, NULL, 0, 0, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1998\"\r\n', '2023-05-01 00:39:53', '2023-05-01 00:39:53');
INSERT INTO `judge_case` VALUES (310, 90, '1', 1009, NULL, 0, 77, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 00:39:53', '2023-05-01 00:39:53');
INSERT INTO `judge_case` VALUES (311, 90, '1', 1009, NULL, 0, 0, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3\"\r\n', '2023-05-01 00:39:53', '2023-05-01 00:39:53');
INSERT INTO `judge_case` VALUES (312, 90, '1', 1009, NULL, 0, 0, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 2 number(s): \"3 -1\"\r\n', '2023-05-01 00:39:53', '2023-05-01 00:39:53');
INSERT INTO `judge_case` VALUES (313, 90, '1', 1009, NULL, 0, 0, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"-1\"\r\n', '2023-05-01 00:39:53', '2023-05-01 00:39:53');
INSERT INTO `judge_case` VALUES (314, 90, '1', 1009, NULL, 0, 0, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 2 number(s): \"-1 8\"\r\n', '2023-05-01 00:39:53', '2023-05-01 00:39:53');
INSERT INTO `judge_case` VALUES (315, 90, '1', 1009, NULL, 0, 0, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1409\"\r\n', '2023-05-01 00:39:53', '2023-05-01 00:39:53');
INSERT INTO `judge_case` VALUES (316, 90, '1', 1009, NULL, 0, 0, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 2 number(s): \"-1 -1\"\r\n', '2023-05-01 00:39:53', '2023-05-01 00:39:53');
INSERT INTO `judge_case` VALUES (317, 90, '1', 1009, NULL, 0, 62, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 00:39:53', '2023-05-01 00:39:53');
INSERT INTO `judge_case` VALUES (318, 90, '1', 1009, NULL, 0, 0, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 3 number(s): \"3 -1 8\"\r\n', '2023-05-01 00:41:50', '2023-05-01 00:41:50');
INSERT INTO `judge_case` VALUES (319, 90, '1', 1009, NULL, 0, 46, 4000, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 00:41:50', '2023-05-01 00:41:50');
INSERT INTO `judge_case` VALUES (320, 90, '1', 1009, NULL, 0, 62, 3992, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 00:41:50', '2023-05-01 00:41:50');
INSERT INTO `judge_case` VALUES (321, 90, '1', 1009, NULL, 0, 77, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 00:41:50', '2023-05-01 00:41:50');
INSERT INTO `judge_case` VALUES (322, 90, '1', 1009, NULL, 0, 77, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 00:41:50', '2023-05-01 00:41:50');
INSERT INTO `judge_case` VALUES (323, 90, '1', 1009, NULL, 0, 77, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 00:41:50', '2023-05-01 00:41:50');
INSERT INTO `judge_case` VALUES (324, 90, '1', 1009, NULL, 0, 0, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"897\"\r\n', '2023-05-01 00:41:50', '2023-05-01 00:41:50');
INSERT INTO `judge_case` VALUES (325, 90, '1', 1009, NULL, 0, 77, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 00:41:50', '2023-05-01 00:41:50');
INSERT INTO `judge_case` VALUES (326, 90, '1', 1009, NULL, 0, 62, 4000, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 00:41:50', '2023-05-01 00:41:50');
INSERT INTO `judge_case` VALUES (327, 90, '1', 1009, NULL, 0, 0, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1998\"\r\n', '2023-05-01 00:41:50', '2023-05-01 00:41:50');
INSERT INTO `judge_case` VALUES (328, 90, '1', 1009, NULL, 0, 0, 3992, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1998\"\r\n', '2023-05-01 00:41:50', '2023-05-01 00:41:50');
INSERT INTO `judge_case` VALUES (329, 90, '1', 1009, NULL, 0, 0, 3992, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1998\"\r\n', '2023-05-01 00:41:50', '2023-05-01 00:41:50');
INSERT INTO `judge_case` VALUES (330, 90, '1', 1009, NULL, 0, 62, 4000, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 00:41:50', '2023-05-01 00:41:50');
INSERT INTO `judge_case` VALUES (331, 90, '1', 1009, NULL, 0, 0, 3988, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3\"\r\n', '2023-05-01 00:41:50', '2023-05-01 00:41:50');
INSERT INTO `judge_case` VALUES (332, 90, '1', 1009, NULL, 0, 0, 3992, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 2 number(s): \"3 -1\"\r\n', '2023-05-01 00:41:50', '2023-05-01 00:41:50');
INSERT INTO `judge_case` VALUES (333, 90, '1', 1009, NULL, 0, 0, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"-1\"\r\n', '2023-05-01 00:41:50', '2023-05-01 00:41:50');
INSERT INTO `judge_case` VALUES (334, 90, '1', 1009, NULL, 0, 0, 3988, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 2 number(s): \"-1 8\"\r\n', '2023-05-01 00:41:50', '2023-05-01 00:41:50');
INSERT INTO `judge_case` VALUES (335, 90, '1', 1009, NULL, 0, 0, 4000, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1409\"\r\n', '2023-05-01 00:41:50', '2023-05-01 00:41:50');
INSERT INTO `judge_case` VALUES (336, 90, '1', 1009, NULL, 0, 0, 3992, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 2 number(s): \"-1 -1\"\r\n', '2023-05-01 00:41:50', '2023-05-01 00:41:50');
INSERT INTO `judge_case` VALUES (337, 90, '1', 1009, NULL, 0, 61, 3992, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 00:41:50', '2023-05-01 00:41:50');
INSERT INTO `judge_case` VALUES (338, 90, '1', 1009, NULL, 0, 0, 3992, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 3 number(s): \"3 -1 8\"\r\n', '2023-05-01 00:52:00', '2023-05-01 00:52:00');
INSERT INTO `judge_case` VALUES (339, 90, '1', 1009, NULL, 0, 61, 3992, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 00:52:00', '2023-05-01 00:52:00');
INSERT INTO `judge_case` VALUES (340, 90, '1', 1009, NULL, 0, 61, 3988, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 00:52:00', '2023-05-01 00:52:00');
INSERT INTO `judge_case` VALUES (341, 90, '1', 1009, NULL, 0, 77, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 00:52:00', '2023-05-01 00:52:00');
INSERT INTO `judge_case` VALUES (342, 90, '1', 1009, NULL, 0, 77, 3992, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 00:52:00', '2023-05-01 00:52:00');
INSERT INTO `judge_case` VALUES (343, 90, '1', 1009, NULL, 0, 77, 3992, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 00:52:00', '2023-05-01 00:52:00');
INSERT INTO `judge_case` VALUES (344, 90, '1', 1009, NULL, 0, 0, 3992, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"897\"\r\n', '2023-05-01 00:52:00', '2023-05-01 00:52:00');
INSERT INTO `judge_case` VALUES (345, 90, '1', 1009, NULL, 0, 77, 3992, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 00:52:00', '2023-05-01 00:52:00');
INSERT INTO `judge_case` VALUES (346, 90, '1', 1009, NULL, 0, 77, 4000, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 00:52:00', '2023-05-01 00:52:00');
INSERT INTO `judge_case` VALUES (347, 90, '1', 1009, NULL, 0, 0, 4000, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1998\"\r\n', '2023-05-01 00:52:00', '2023-05-01 00:52:00');
INSERT INTO `judge_case` VALUES (348, 90, '1', 1009, NULL, 0, 0, 3992, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1998\"\r\n', '2023-05-01 00:52:00', '2023-05-01 00:52:00');
INSERT INTO `judge_case` VALUES (349, 90, '1', 1009, NULL, 0, 0, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1998\"\r\n', '2023-05-01 00:52:00', '2023-05-01 00:52:00');
INSERT INTO `judge_case` VALUES (350, 90, '1', 1009, NULL, 0, 61, 3992, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 00:52:00', '2023-05-01 00:52:00');
INSERT INTO `judge_case` VALUES (351, 90, '1', 1009, NULL, 0, 0, 3984, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3\"\r\n', '2023-05-01 00:52:00', '2023-05-01 00:52:00');
INSERT INTO `judge_case` VALUES (352, 90, '1', 1009, NULL, 0, 0, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 2 number(s): \"3 -1\"\r\n', '2023-05-01 00:52:00', '2023-05-01 00:52:00');
INSERT INTO `judge_case` VALUES (353, 90, '1', 1009, NULL, 0, 0, 3992, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"-1\"\r\n', '2023-05-01 00:52:00', '2023-05-01 00:52:00');
INSERT INTO `judge_case` VALUES (354, 90, '1', 1009, NULL, 0, 0, 3992, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 2 number(s): \"-1 8\"\r\n', '2023-05-01 00:52:00', '2023-05-01 00:52:00');
INSERT INTO `judge_case` VALUES (355, 90, '1', 1009, NULL, 0, 0, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1409\"\r\n', '2023-05-01 00:52:00', '2023-05-01 00:52:00');
INSERT INTO `judge_case` VALUES (356, 90, '1', 1009, NULL, 0, 0, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 2 number(s): \"-1 -1\"\r\n', '2023-05-01 00:52:00', '2023-05-01 00:52:00');
INSERT INTO `judge_case` VALUES (357, 90, '1', 1009, NULL, 0, 77, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 00:52:00', '2023-05-01 00:52:00');
INSERT INTO `judge_case` VALUES (360, 90, '1', 1009, NULL, 0, 0, 4000, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 3 number(s): \"3 -1 8\"\r\n', '2023-05-01 09:56:08', '2023-05-01 09:56:08');
INSERT INTO `judge_case` VALUES (361, 90, '1', 1009, NULL, 0, 46, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 09:56:13', '2023-05-01 09:56:13');
INSERT INTO `judge_case` VALUES (362, 90, '1', 1009, NULL, 0, 62, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 09:56:13', '2023-05-01 09:56:13');
INSERT INTO `judge_case` VALUES (363, 90, '1', 1009, NULL, 0, 93, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 09:56:13', '2023-05-01 09:56:13');
INSERT INTO `judge_case` VALUES (364, 90, '1', 1009, NULL, 0, 77, 3992, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 09:56:13', '2023-05-01 09:56:13');
INSERT INTO `judge_case` VALUES (365, 90, '1', 1009, NULL, 0, 77, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 09:56:13', '2023-05-01 09:56:13');
INSERT INTO `judge_case` VALUES (366, 90, '1', 1009, NULL, 0, 0, 3992, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"897\"\r\n', '2023-05-01 09:56:13', '2023-05-01 09:56:13');
INSERT INTO `judge_case` VALUES (367, 90, '1', 1009, NULL, 0, 77, 3992, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 09:56:13', '2023-05-01 09:56:13');
INSERT INTO `judge_case` VALUES (368, 90, '1', 1009, NULL, 0, 78, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 09:56:13', '2023-05-01 09:56:13');
INSERT INTO `judge_case` VALUES (369, 90, '1', 1009, NULL, 0, 0, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1998\"\r\n', '2023-05-01 09:56:13', '2023-05-01 09:56:13');
INSERT INTO `judge_case` VALUES (370, 90, '1', 1009, NULL, 0, 0, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1998\"\r\n', '2023-05-01 09:56:13', '2023-05-01 09:56:13');
INSERT INTO `judge_case` VALUES (371, 90, '1', 1009, NULL, 0, 0, 4000, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1998\"\r\n', '2023-05-01 09:56:13', '2023-05-01 09:56:13');
INSERT INTO `judge_case` VALUES (372, 90, '1', 1009, NULL, 0, 78, 3992, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 09:56:13', '2023-05-01 09:56:13');
INSERT INTO `judge_case` VALUES (373, 90, '1', 1009, NULL, 0, 0, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3\"\r\n', '2023-05-01 09:56:13', '2023-05-01 09:56:13');
INSERT INTO `judge_case` VALUES (374, 90, '1', 1009, NULL, 0, 0, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 2 number(s): \"3 -1\"\r\n', '2023-05-01 09:56:13', '2023-05-01 09:56:13');
INSERT INTO `judge_case` VALUES (375, 90, '1', 1009, NULL, 0, 0, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"-1\"\r\n', '2023-05-01 09:56:13', '2023-05-01 09:56:13');
INSERT INTO `judge_case` VALUES (376, 90, '1', 1009, NULL, 0, 0, 3992, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 2 number(s): \"-1 8\"\r\n', '2023-05-01 09:56:13', '2023-05-01 09:56:13');
INSERT INTO `judge_case` VALUES (377, 90, '1', 1009, NULL, 0, 0, 3996, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1409\"\r\n', '2023-05-01 09:56:13', '2023-05-01 09:56:13');
INSERT INTO `judge_case` VALUES (378, 90, '1', 1009, NULL, 0, 0, 4004, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 2 number(s): \"-1 -1\"\r\n', '2023-05-01 09:56:13', '2023-05-01 09:56:13');
INSERT INTO `judge_case` VALUES (379, 90, '1', 1009, NULL, 0, 78, 3992, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 10000 numbers\r\n', '2023-05-01 09:56:13', '2023-05-01 09:56:13');
INSERT INTO `judge_case` VALUES (408, 109, '1', 1013, 19, 0, 1, 412, NULL, 1, 1, 'default', '1.in', '1.out', NULL, '2023-05-06 21:49:44', '2023-05-06 21:49:44');
INSERT INTO `judge_case` VALUES (409, 110, '1', 1013, 19, 0, 3, 408, NULL, 1, 1, 'default', '1.in', '1.out', NULL, '2023-05-07 16:49:12', '2023-05-07 16:49:12');
INSERT INTO `judge_case` VALUES (410, 111, '1', 1013, 19, 0, 2, 412, NULL, 1, 1, 'default', '1.in', '1.out', NULL, '2023-05-07 16:50:52', '2023-05-07 16:50:52');
INSERT INTO `judge_case` VALUES (411, 112, '1', 1013, 19, 0, 1, 408, NULL, 1, 1, 'default', '1.in', '1.out', NULL, '2023-05-07 16:52:56', '2023-05-07 16:52:56');
INSERT INTO `judge_case` VALUES (412, 113, '1', 1013, 19, 0, 2, 412, NULL, NULL, 1, 'default', '1.in', '1.in', NULL, '2023-05-08 20:13:46', '2023-05-08 20:13:46');
INSERT INTO `judge_case` VALUES (413, 114, '1', 1013, 19, 0, 2, 412, NULL, NULL, 1, 'default', '1.in', '1.in', NULL, '2023-05-08 20:18:12', '2023-05-08 20:18:12');
INSERT INTO `judge_case` VALUES (414, 115, '1', 1013, 19, 0, 4, 1688, NULL, NULL, 1, 'default', '1.in', '1.in', NULL, '2023-05-08 23:18:42', '2023-05-08 23:18:42');
INSERT INTO `judge_case` VALUES (415, 116, '1', 1013, 19, 0, 2, 1048, NULL, 1, 1, 'default', '1.in', '1.out', NULL, '2023-05-08 23:20:45', '2023-05-08 23:20:45');
INSERT INTO `judge_case` VALUES (416, 117, '1', 1013, 19, 0, 3, 664, NULL, NULL, 1, 'default', '1.in', '1.in', NULL, '2023-05-08 23:21:55', '2023-05-08 23:21:55');
INSERT INTO `judge_case` VALUES (423, 118, '1', 1013, 19, 0, 2, 412, NULL, 1, 1, 'default', '1.in', '1.out', NULL, '2023-05-09 01:34:41', '2023-05-09 01:34:41');
INSERT INTO `judge_case` VALUES (424, 119, '1', 1013, 19, 0, 6, 1688, NULL, 1, 1, 'default', '1.in', '1.out', NULL, '2023-05-09 20:14:05', '2023-05-09 20:14:05');
INSERT INTO `judge_case` VALUES (425, 118, '1', 1013, 19, 0, 2, 792, NULL, 1, 1, 'default', '1.in', '1.out', NULL, '2023-05-09 20:34:45', '2023-05-09 20:34:45');
INSERT INTO `judge_case` VALUES (426, 118, '1', 1013, 19, 0, 4, 1176, NULL, 1, 1, 'default', '1.in', '1.out', NULL, '2023-05-09 20:56:23', '2023-05-09 20:56:23');
INSERT INTO `judge_case` VALUES (427, 120, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-05-10 22:33:20', '2023-05-10 22:33:20');
INSERT INTO `judge_case` VALUES (428, 120, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-10 22:33:20', '2023-05-10 22:33:20');
INSERT INTO `judge_case` VALUES (429, 120, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"2\"\r\n', '2023-05-10 22:33:20', '2023-05-10 22:33:20');
INSERT INTO `judge_case` VALUES (430, 120, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"2\"\r\n', '2023-05-10 22:33:20', '2023-05-10 22:33:20');
INSERT INTO `judge_case` VALUES (431, 120, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-05-10 22:33:20', '2023-05-10 22:33:20');
INSERT INTO `judge_case` VALUES (432, 120, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-10 22:33:20', '2023-05-10 22:33:20');
INSERT INTO `judge_case` VALUES (433, 120, '1', 1006, NULL, 0, 15, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-10 22:33:20', '2023-05-10 22:33:20');
INSERT INTO `judge_case` VALUES (434, 120, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-10 22:33:20', '2023-05-10 22:33:20');
INSERT INTO `judge_case` VALUES (435, 120, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1000000000000000000\"\r\n', '2023-05-10 22:33:20', '2023-05-10 22:33:20');
INSERT INTO `judge_case` VALUES (436, 120, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"12\"\r\n', '2023-05-10 22:33:20', '2023-05-10 22:33:20');
INSERT INTO `judge_case` VALUES (437, 120, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3015\"\r\n', '2023-05-10 22:33:20', '2023-05-10 22:33:20');
INSERT INTO `judge_case` VALUES (438, 120, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"10000\"\r\n', '2023-05-10 22:33:20', '2023-05-10 22:33:20');
INSERT INTO `judge_case` VALUES (439, 120, '1', 1006, NULL, 0, 15, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"10100\"\r\n', '2023-05-10 22:33:20', '2023-05-10 22:33:20');
INSERT INTO `judge_case` VALUES (440, 120, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-10 22:33:20', '2023-05-10 22:33:20');
INSERT INTO `judge_case` VALUES (441, 120, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-10 22:33:20', '2023-05-10 22:33:20');
INSERT INTO `judge_case` VALUES (442, 120, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-05-10 22:33:20', '2023-05-10 22:33:20');
INSERT INTO `judge_case` VALUES (443, 120, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"27126743055556\"\r\n', '2023-05-10 22:33:20', '2023-05-10 22:33:20');
INSERT INTO `judge_case` VALUES (444, 120, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"987654321000000000\"\r\n', '2023-05-10 22:33:20', '2023-05-10 22:33:20');
INSERT INTO `judge_case` VALUES (445, 120, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"175618850864484\"\r\n', '2023-05-10 22:33:20', '2023-05-10 22:33:20');
INSERT INTO `judge_case` VALUES (446, 120, '1', 1006, NULL, 0, 15, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3295710\"\r\n', '2023-05-10 22:33:20', '2023-05-10 22:33:20');
INSERT INTO `judge_case` VALUES (447, 121, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-05-10 22:34:07', '2023-05-10 22:34:07');
INSERT INTO `judge_case` VALUES (448, 121, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-10 22:34:07', '2023-05-10 22:34:07');
INSERT INTO `judge_case` VALUES (449, 121, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"2\"\r\n', '2023-05-10 22:34:07', '2023-05-10 22:34:07');
INSERT INTO `judge_case` VALUES (450, 121, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"2\"\r\n', '2023-05-10 22:34:07', '2023-05-10 22:34:07');
INSERT INTO `judge_case` VALUES (451, 121, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-05-10 22:34:07', '2023-05-10 22:34:07');
INSERT INTO `judge_case` VALUES (452, 121, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-10 22:34:07', '2023-05-10 22:34:07');
INSERT INTO `judge_case` VALUES (453, 121, '1', 1006, NULL, 0, 15, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-10 22:34:07', '2023-05-10 22:34:07');
INSERT INTO `judge_case` VALUES (454, 121, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-10 22:34:07', '2023-05-10 22:34:07');
INSERT INTO `judge_case` VALUES (455, 121, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1000000000000000000\"\r\n', '2023-05-10 22:34:07', '2023-05-10 22:34:07');
INSERT INTO `judge_case` VALUES (456, 121, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"12\"\r\n', '2023-05-10 22:34:07', '2023-05-10 22:34:07');
INSERT INTO `judge_case` VALUES (457, 121, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3015\"\r\n', '2023-05-10 22:34:07', '2023-05-10 22:34:07');
INSERT INTO `judge_case` VALUES (458, 121, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"10000\"\r\n', '2023-05-10 22:34:07', '2023-05-10 22:34:07');
INSERT INTO `judge_case` VALUES (459, 121, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"10100\"\r\n', '2023-05-10 22:34:07', '2023-05-10 22:34:07');
INSERT INTO `judge_case` VALUES (460, 121, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-10 22:34:07', '2023-05-10 22:34:07');
INSERT INTO `judge_case` VALUES (461, 121, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-10 22:34:07', '2023-05-10 22:34:07');
INSERT INTO `judge_case` VALUES (462, 121, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-05-10 22:34:07', '2023-05-10 22:34:07');
INSERT INTO `judge_case` VALUES (463, 121, '1', 1006, NULL, 0, 15, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"27126743055556\"\r\n', '2023-05-10 22:34:07', '2023-05-10 22:34:07');
INSERT INTO `judge_case` VALUES (464, 121, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"987654321000000000\"\r\n', '2023-05-10 22:34:07', '2023-05-10 22:34:07');
INSERT INTO `judge_case` VALUES (465, 121, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"175618850864484\"\r\n', '2023-05-10 22:34:07', '2023-05-10 22:34:07');
INSERT INTO `judge_case` VALUES (466, 121, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3295710\"\r\n', '2023-05-10 22:34:07', '2023-05-10 22:34:07');
INSERT INTO `judge_case` VALUES (487, 125, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-05-12 03:06:29', '2023-05-12 03:06:29');
INSERT INTO `judge_case` VALUES (488, 125, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:06:29', '2023-05-12 03:06:29');
INSERT INTO `judge_case` VALUES (489, 125, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"2\"\r\n', '2023-05-12 03:06:29', '2023-05-12 03:06:29');
INSERT INTO `judge_case` VALUES (490, 125, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"2\"\r\n', '2023-05-12 03:06:29', '2023-05-12 03:06:29');
INSERT INTO `judge_case` VALUES (491, 125, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-05-12 03:06:29', '2023-05-12 03:06:29');
INSERT INTO `judge_case` VALUES (492, 125, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:06:29', '2023-05-12 03:06:29');
INSERT INTO `judge_case` VALUES (493, 125, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:06:29', '2023-05-12 03:06:29');
INSERT INTO `judge_case` VALUES (494, 125, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:06:29', '2023-05-12 03:06:29');
INSERT INTO `judge_case` VALUES (495, 125, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1000000000000000000\"\r\n', '2023-05-12 03:06:29', '2023-05-12 03:06:29');
INSERT INTO `judge_case` VALUES (496, 125, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"12\"\r\n', '2023-05-12 03:06:29', '2023-05-12 03:06:29');
INSERT INTO `judge_case` VALUES (497, 125, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3015\"\r\n', '2023-05-12 03:06:29', '2023-05-12 03:06:29');
INSERT INTO `judge_case` VALUES (498, 125, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"10000\"\r\n', '2023-05-12 03:06:29', '2023-05-12 03:06:29');
INSERT INTO `judge_case` VALUES (499, 125, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"10100\"\r\n', '2023-05-12 03:06:29', '2023-05-12 03:06:29');
INSERT INTO `judge_case` VALUES (500, 125, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:06:29', '2023-05-12 03:06:29');
INSERT INTO `judge_case` VALUES (501, 125, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:06:29', '2023-05-12 03:06:29');
INSERT INTO `judge_case` VALUES (502, 125, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-05-12 03:06:29', '2023-05-12 03:06:29');
INSERT INTO `judge_case` VALUES (503, 125, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"27126743055556\"\r\n', '2023-05-12 03:06:29', '2023-05-12 03:06:29');
INSERT INTO `judge_case` VALUES (504, 125, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"987654321000000000\"\r\n', '2023-05-12 03:06:29', '2023-05-12 03:06:29');
INSERT INTO `judge_case` VALUES (505, 125, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"175618850864484\"\r\n', '2023-05-12 03:06:29', '2023-05-12 03:06:29');
INSERT INTO `judge_case` VALUES (506, 125, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3295710\"\r\n', '2023-05-12 03:06:29', '2023-05-12 03:06:29');
INSERT INTO `judge_case` VALUES (507, 124, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-05-12 03:23:54', '2023-05-12 03:23:54');
INSERT INTO `judge_case` VALUES (508, 124, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:23:54', '2023-05-12 03:23:54');
INSERT INTO `judge_case` VALUES (509, 124, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"2\"\r\n', '2023-05-12 03:23:54', '2023-05-12 03:23:54');
INSERT INTO `judge_case` VALUES (510, 124, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"2\"\r\n', '2023-05-12 03:23:54', '2023-05-12 03:23:54');
INSERT INTO `judge_case` VALUES (511, 124, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-05-12 03:23:54', '2023-05-12 03:23:54');
INSERT INTO `judge_case` VALUES (512, 124, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:23:54', '2023-05-12 03:23:54');
INSERT INTO `judge_case` VALUES (513, 124, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:23:54', '2023-05-12 03:23:54');
INSERT INTO `judge_case` VALUES (514, 124, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:23:54', '2023-05-12 03:23:54');
INSERT INTO `judge_case` VALUES (515, 124, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1000000000000000000\"\r\n', '2023-05-12 03:23:54', '2023-05-12 03:23:54');
INSERT INTO `judge_case` VALUES (516, 124, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"12\"\r\n', '2023-05-12 03:23:54', '2023-05-12 03:23:54');
INSERT INTO `judge_case` VALUES (517, 124, '1', 1006, NULL, 0, 0, 8, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3015\"\r\n', '2023-05-12 03:23:54', '2023-05-12 03:23:54');
INSERT INTO `judge_case` VALUES (518, 124, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"10000\"\r\n', '2023-05-12 03:23:54', '2023-05-12 03:23:54');
INSERT INTO `judge_case` VALUES (519, 124, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"10100\"\r\n', '2023-05-12 03:23:54', '2023-05-12 03:23:54');
INSERT INTO `judge_case` VALUES (520, 124, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:23:54', '2023-05-12 03:23:54');
INSERT INTO `judge_case` VALUES (521, 124, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:23:54', '2023-05-12 03:23:54');
INSERT INTO `judge_case` VALUES (522, 124, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-05-12 03:23:54', '2023-05-12 03:23:54');
INSERT INTO `judge_case` VALUES (523, 124, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"27126743055556\"\r\n', '2023-05-12 03:23:54', '2023-05-12 03:23:54');
INSERT INTO `judge_case` VALUES (524, 124, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"987654321000000000\"\r\n', '2023-05-12 03:23:54', '2023-05-12 03:23:54');
INSERT INTO `judge_case` VALUES (525, 124, '1', 1006, NULL, 0, 0, 8, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"175618850864484\"\r\n', '2023-05-12 03:23:54', '2023-05-12 03:23:54');
INSERT INTO `judge_case` VALUES (526, 124, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3295710\"\r\n', '2023-05-12 03:23:54', '2023-05-12 03:23:54');
INSERT INTO `judge_case` VALUES (527, 134, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-05-12 03:24:03', '2023-05-12 03:24:03');
INSERT INTO `judge_case` VALUES (528, 134, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:24:03', '2023-05-12 03:24:03');
INSERT INTO `judge_case` VALUES (529, 134, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"2\"\r\n', '2023-05-12 03:24:03', '2023-05-12 03:24:03');
INSERT INTO `judge_case` VALUES (530, 134, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"2\"\r\n', '2023-05-12 03:24:03', '2023-05-12 03:24:03');
INSERT INTO `judge_case` VALUES (531, 134, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-05-12 03:24:03', '2023-05-12 03:24:03');
INSERT INTO `judge_case` VALUES (532, 134, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:24:03', '2023-05-12 03:24:03');
INSERT INTO `judge_case` VALUES (533, 134, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:24:03', '2023-05-12 03:24:03');
INSERT INTO `judge_case` VALUES (534, 134, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:24:03', '2023-05-12 03:24:03');
INSERT INTO `judge_case` VALUES (535, 134, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1000000000000000000\"\r\n', '2023-05-12 03:24:03', '2023-05-12 03:24:03');
INSERT INTO `judge_case` VALUES (536, 134, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"12\"\r\n', '2023-05-12 03:24:03', '2023-05-12 03:24:03');
INSERT INTO `judge_case` VALUES (537, 134, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3015\"\r\n', '2023-05-12 03:24:03', '2023-05-12 03:24:03');
INSERT INTO `judge_case` VALUES (538, 134, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"10000\"\r\n', '2023-05-12 03:24:03', '2023-05-12 03:24:03');
INSERT INTO `judge_case` VALUES (539, 134, '1', 1006, NULL, 0, 15, 8, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"10100\"\r\n', '2023-05-12 03:24:03', '2023-05-12 03:24:03');
INSERT INTO `judge_case` VALUES (540, 134, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:24:03', '2023-05-12 03:24:03');
INSERT INTO `judge_case` VALUES (541, 134, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:24:03', '2023-05-12 03:24:03');
INSERT INTO `judge_case` VALUES (542, 134, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-05-12 03:24:03', '2023-05-12 03:24:03');
INSERT INTO `judge_case` VALUES (543, 134, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"27126743055556\"\r\n', '2023-05-12 03:24:03', '2023-05-12 03:24:03');
INSERT INTO `judge_case` VALUES (544, 134, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"987654321000000000\"\r\n', '2023-05-12 03:24:03', '2023-05-12 03:24:03');
INSERT INTO `judge_case` VALUES (545, 134, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"175618850864484\"\r\n', '2023-05-12 03:24:03', '2023-05-12 03:24:03');
INSERT INTO `judge_case` VALUES (546, 134, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3295710\"\r\n', '2023-05-12 03:24:03', '2023-05-12 03:24:03');
INSERT INTO `judge_case` VALUES (547, 129, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-05-12 03:24:11', '2023-05-12 03:24:11');
INSERT INTO `judge_case` VALUES (548, 129, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:24:11', '2023-05-12 03:24:11');
INSERT INTO `judge_case` VALUES (549, 129, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"2\"\r\n', '2023-05-12 03:24:11', '2023-05-12 03:24:11');
INSERT INTO `judge_case` VALUES (550, 129, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"2\"\r\n', '2023-05-12 03:24:11', '2023-05-12 03:24:11');
INSERT INTO `judge_case` VALUES (551, 129, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-05-12 03:24:11', '2023-05-12 03:24:11');
INSERT INTO `judge_case` VALUES (552, 129, '1', 1006, NULL, 0, 15, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:24:11', '2023-05-12 03:24:11');
INSERT INTO `judge_case` VALUES (553, 129, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:24:11', '2023-05-12 03:24:11');
INSERT INTO `judge_case` VALUES (554, 129, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:24:11', '2023-05-12 03:24:11');
INSERT INTO `judge_case` VALUES (555, 129, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1000000000000000000\"\r\n', '2023-05-12 03:24:11', '2023-05-12 03:24:11');
INSERT INTO `judge_case` VALUES (556, 129, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"12\"\r\n', '2023-05-12 03:24:11', '2023-05-12 03:24:11');
INSERT INTO `judge_case` VALUES (557, 129, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3015\"\r\n', '2023-05-12 03:24:11', '2023-05-12 03:24:11');
INSERT INTO `judge_case` VALUES (558, 129, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"10000\"\r\n', '2023-05-12 03:24:11', '2023-05-12 03:24:11');
INSERT INTO `judge_case` VALUES (559, 129, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"10100\"\r\n', '2023-05-12 03:24:11', '2023-05-12 03:24:11');
INSERT INTO `judge_case` VALUES (560, 129, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:24:11', '2023-05-12 03:24:11');
INSERT INTO `judge_case` VALUES (561, 129, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:24:11', '2023-05-12 03:24:11');
INSERT INTO `judge_case` VALUES (562, 129, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-05-12 03:24:11', '2023-05-12 03:24:11');
INSERT INTO `judge_case` VALUES (563, 129, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"27126743055556\"\r\n', '2023-05-12 03:24:11', '2023-05-12 03:24:11');
INSERT INTO `judge_case` VALUES (564, 129, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"987654321000000000\"\r\n', '2023-05-12 03:24:11', '2023-05-12 03:24:11');
INSERT INTO `judge_case` VALUES (565, 129, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"175618850864484\"\r\n', '2023-05-12 03:24:11', '2023-05-12 03:24:11');
INSERT INTO `judge_case` VALUES (566, 129, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3295710\"\r\n', '2023-05-12 03:24:11', '2023-05-12 03:24:11');
INSERT INTO `judge_case` VALUES (567, 129, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-05-12 03:24:21', '2023-05-12 03:24:21');
INSERT INTO `judge_case` VALUES (568, 129, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:24:21', '2023-05-12 03:24:21');
INSERT INTO `judge_case` VALUES (569, 129, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"2\"\r\n', '2023-05-12 03:24:21', '2023-05-12 03:24:21');
INSERT INTO `judge_case` VALUES (570, 129, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"2\"\r\n', '2023-05-12 03:24:21', '2023-05-12 03:24:21');
INSERT INTO `judge_case` VALUES (571, 129, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-05-12 03:24:21', '2023-05-12 03:24:21');
INSERT INTO `judge_case` VALUES (572, 129, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:24:21', '2023-05-12 03:24:21');
INSERT INTO `judge_case` VALUES (573, 129, '1', 1006, NULL, 0, 15, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:24:21', '2023-05-12 03:24:21');
INSERT INTO `judge_case` VALUES (574, 129, '1', 1006, NULL, 0, 15, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:24:21', '2023-05-12 03:24:21');
INSERT INTO `judge_case` VALUES (575, 129, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1000000000000000000\"\r\n', '2023-05-12 03:24:21', '2023-05-12 03:24:21');
INSERT INTO `judge_case` VALUES (576, 129, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"12\"\r\n', '2023-05-12 03:24:21', '2023-05-12 03:24:21');
INSERT INTO `judge_case` VALUES (577, 129, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3015\"\r\n', '2023-05-12 03:24:21', '2023-05-12 03:24:21');
INSERT INTO `judge_case` VALUES (578, 129, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"10000\"\r\n', '2023-05-12 03:24:21', '2023-05-12 03:24:21');
INSERT INTO `judge_case` VALUES (579, 129, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"10100\"\r\n', '2023-05-12 03:24:21', '2023-05-12 03:24:21');
INSERT INTO `judge_case` VALUES (580, 129, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:24:21', '2023-05-12 03:24:21');
INSERT INTO `judge_case` VALUES (581, 129, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:24:21', '2023-05-12 03:24:21');
INSERT INTO `judge_case` VALUES (582, 129, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-05-12 03:24:21', '2023-05-12 03:24:21');
INSERT INTO `judge_case` VALUES (583, 129, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"27126743055556\"\r\n', '2023-05-12 03:24:21', '2023-05-12 03:24:21');
INSERT INTO `judge_case` VALUES (584, 129, '1', 1006, NULL, 0, 0, 8, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"987654321000000000\"\r\n', '2023-05-12 03:24:21', '2023-05-12 03:24:21');
INSERT INTO `judge_case` VALUES (585, 129, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"175618850864484\"\r\n', '2023-05-12 03:24:21', '2023-05-12 03:24:21');
INSERT INTO `judge_case` VALUES (586, 129, '1', 1006, NULL, 0, 0, 8, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3295710\"\r\n', '2023-05-12 03:24:21', '2023-05-12 03:24:21');
INSERT INTO `judge_case` VALUES (587, 135, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-05-12 03:24:47', '2023-05-12 03:24:47');
INSERT INTO `judge_case` VALUES (588, 135, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:24:47', '2023-05-12 03:24:47');
INSERT INTO `judge_case` VALUES (589, 135, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"2\"\r\n', '2023-05-12 03:24:47', '2023-05-12 03:24:47');
INSERT INTO `judge_case` VALUES (590, 135, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"2\"\r\n', '2023-05-12 03:24:47', '2023-05-12 03:24:47');
INSERT INTO `judge_case` VALUES (591, 135, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-05-12 03:24:47', '2023-05-12 03:24:47');
INSERT INTO `judge_case` VALUES (592, 135, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:24:47', '2023-05-12 03:24:47');
INSERT INTO `judge_case` VALUES (593, 135, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:24:47', '2023-05-12 03:24:47');
INSERT INTO `judge_case` VALUES (594, 135, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:24:47', '2023-05-12 03:24:47');
INSERT INTO `judge_case` VALUES (595, 135, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1000000000000000000\"\r\n', '2023-05-12 03:24:47', '2023-05-12 03:24:47');
INSERT INTO `judge_case` VALUES (596, 135, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"12\"\r\n', '2023-05-12 03:24:47', '2023-05-12 03:24:47');
INSERT INTO `judge_case` VALUES (597, 135, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3015\"\r\n', '2023-05-12 03:24:47', '2023-05-12 03:24:47');
INSERT INTO `judge_case` VALUES (598, 135, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"10000\"\r\n', '2023-05-12 03:24:47', '2023-05-12 03:24:47');
INSERT INTO `judge_case` VALUES (599, 135, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"10100\"\r\n', '2023-05-12 03:24:47', '2023-05-12 03:24:47');
INSERT INTO `judge_case` VALUES (600, 135, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:24:47', '2023-05-12 03:24:47');
INSERT INTO `judge_case` VALUES (601, 135, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:24:47', '2023-05-12 03:24:47');
INSERT INTO `judge_case` VALUES (602, 135, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-05-12 03:24:47', '2023-05-12 03:24:47');
INSERT INTO `judge_case` VALUES (603, 135, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"27126743055556\"\r\n', '2023-05-12 03:24:47', '2023-05-12 03:24:47');
INSERT INTO `judge_case` VALUES (604, 135, '1', 1006, NULL, 0, 15, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"987654321000000000\"\r\n', '2023-05-12 03:24:47', '2023-05-12 03:24:47');
INSERT INTO `judge_case` VALUES (605, 135, '1', 1006, NULL, 0, 0, 8, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"175618850864484\"\r\n', '2023-05-12 03:24:47', '2023-05-12 03:24:47');
INSERT INTO `judge_case` VALUES (606, 135, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3295710\"\r\n', '2023-05-12 03:24:47', '2023-05-12 03:24:47');
INSERT INTO `judge_case` VALUES (607, 136, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-05-12 03:25:44', '2023-05-12 03:25:44');
INSERT INTO `judge_case` VALUES (608, 136, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:25:44', '2023-05-12 03:25:44');
INSERT INTO `judge_case` VALUES (609, 136, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"2\"\r\n', '2023-05-12 03:25:44', '2023-05-12 03:25:44');
INSERT INTO `judge_case` VALUES (610, 136, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"2\"\r\n', '2023-05-12 03:25:44', '2023-05-12 03:25:44');
INSERT INTO `judge_case` VALUES (611, 136, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-05-12 03:25:44', '2023-05-12 03:25:44');
INSERT INTO `judge_case` VALUES (612, 136, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:25:44', '2023-05-12 03:25:44');
INSERT INTO `judge_case` VALUES (613, 136, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:25:44', '2023-05-12 03:25:44');
INSERT INTO `judge_case` VALUES (614, 136, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:25:44', '2023-05-12 03:25:44');
INSERT INTO `judge_case` VALUES (615, 136, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1000000000000000000\"\r\n', '2023-05-12 03:25:44', '2023-05-12 03:25:44');
INSERT INTO `judge_case` VALUES (616, 136, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"12\"\r\n', '2023-05-12 03:25:44', '2023-05-12 03:25:44');
INSERT INTO `judge_case` VALUES (617, 136, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3015\"\r\n', '2023-05-12 03:25:44', '2023-05-12 03:25:44');
INSERT INTO `judge_case` VALUES (618, 136, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"10000\"\r\n', '2023-05-12 03:25:44', '2023-05-12 03:25:44');
INSERT INTO `judge_case` VALUES (619, 136, '1', 1006, NULL, 0, 15, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"10100\"\r\n', '2023-05-12 03:25:44', '2023-05-12 03:25:44');
INSERT INTO `judge_case` VALUES (620, 136, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:25:44', '2023-05-12 03:25:44');
INSERT INTO `judge_case` VALUES (621, 136, '1', 1006, NULL, 0, 0, 8, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:25:44', '2023-05-12 03:25:44');
INSERT INTO `judge_case` VALUES (622, 136, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-05-12 03:25:44', '2023-05-12 03:25:44');
INSERT INTO `judge_case` VALUES (623, 136, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"27126743055556\"\r\n', '2023-05-12 03:25:44', '2023-05-12 03:25:44');
INSERT INTO `judge_case` VALUES (624, 136, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"987654321000000000\"\r\n', '2023-05-12 03:25:44', '2023-05-12 03:25:44');
INSERT INTO `judge_case` VALUES (625, 136, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"175618850864484\"\r\n', '2023-05-12 03:25:44', '2023-05-12 03:25:44');
INSERT INTO `judge_case` VALUES (626, 136, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3295710\"\r\n', '2023-05-12 03:25:44', '2023-05-12 03:25:44');
INSERT INTO `judge_case` VALUES (627, 133, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-05-12 03:26:53', '2023-05-12 03:26:53');
INSERT INTO `judge_case` VALUES (628, 133, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:26:53', '2023-05-12 03:26:53');
INSERT INTO `judge_case` VALUES (629, 133, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"2\"\r\n', '2023-05-12 03:26:53', '2023-05-12 03:26:53');
INSERT INTO `judge_case` VALUES (630, 133, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"2\"\r\n', '2023-05-12 03:26:53', '2023-05-12 03:26:53');
INSERT INTO `judge_case` VALUES (631, 133, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-05-12 03:26:53', '2023-05-12 03:26:53');
INSERT INTO `judge_case` VALUES (632, 133, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:26:53', '2023-05-12 03:26:53');
INSERT INTO `judge_case` VALUES (633, 133, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:26:53', '2023-05-12 03:26:53');
INSERT INTO `judge_case` VALUES (634, 133, '1', 1006, NULL, 0, 15, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:26:53', '2023-05-12 03:26:53');
INSERT INTO `judge_case` VALUES (635, 133, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1000000000000000000\"\r\n', '2023-05-12 03:26:53', '2023-05-12 03:26:53');
INSERT INTO `judge_case` VALUES (636, 133, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"12\"\r\n', '2023-05-12 03:26:53', '2023-05-12 03:26:53');
INSERT INTO `judge_case` VALUES (637, 133, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3015\"\r\n', '2023-05-12 03:26:53', '2023-05-12 03:26:53');
INSERT INTO `judge_case` VALUES (638, 133, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"10000\"\r\n', '2023-05-12 03:26:53', '2023-05-12 03:26:53');
INSERT INTO `judge_case` VALUES (639, 133, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"10100\"\r\n', '2023-05-12 03:26:53', '2023-05-12 03:26:53');
INSERT INTO `judge_case` VALUES (640, 133, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:26:53', '2023-05-12 03:26:53');
INSERT INTO `judge_case` VALUES (641, 133, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:26:53', '2023-05-12 03:26:53');
INSERT INTO `judge_case` VALUES (642, 133, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-05-12 03:26:53', '2023-05-12 03:26:53');
INSERT INTO `judge_case` VALUES (643, 133, '1', 1006, NULL, 0, 0, 8, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"27126743055556\"\r\n', '2023-05-12 03:26:53', '2023-05-12 03:26:53');
INSERT INTO `judge_case` VALUES (644, 133, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"987654321000000000\"\r\n', '2023-05-12 03:26:53', '2023-05-12 03:26:53');
INSERT INTO `judge_case` VALUES (645, 133, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"175618850864484\"\r\n', '2023-05-12 03:26:53', '2023-05-12 03:26:53');
INSERT INTO `judge_case` VALUES (646, 133, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3295710\"\r\n', '2023-05-12 03:26:53', '2023-05-12 03:26:53');
INSERT INTO `judge_case` VALUES (647, 132, '1', 1006, NULL, 0, 15, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-05-12 03:27:03', '2023-05-12 03:27:03');
INSERT INTO `judge_case` VALUES (648, 132, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:27:03', '2023-05-12 03:27:03');
INSERT INTO `judge_case` VALUES (649, 132, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"2\"\r\n', '2023-05-12 03:27:03', '2023-05-12 03:27:03');
INSERT INTO `judge_case` VALUES (650, 132, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"2\"\r\n', '2023-05-12 03:27:03', '2023-05-12 03:27:03');
INSERT INTO `judge_case` VALUES (651, 132, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-05-12 03:27:03', '2023-05-12 03:27:03');
INSERT INTO `judge_case` VALUES (652, 132, '1', 1006, NULL, 0, 15, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:27:03', '2023-05-12 03:27:03');
INSERT INTO `judge_case` VALUES (653, 132, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:27:03', '2023-05-12 03:27:03');
INSERT INTO `judge_case` VALUES (654, 132, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:27:03', '2023-05-12 03:27:03');
INSERT INTO `judge_case` VALUES (655, 132, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1000000000000000000\"\r\n', '2023-05-12 03:27:03', '2023-05-12 03:27:03');
INSERT INTO `judge_case` VALUES (656, 132, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"12\"\r\n', '2023-05-12 03:27:03', '2023-05-12 03:27:03');
INSERT INTO `judge_case` VALUES (657, 132, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3015\"\r\n', '2023-05-12 03:27:03', '2023-05-12 03:27:03');
INSERT INTO `judge_case` VALUES (658, 132, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"10000\"\r\n', '2023-05-12 03:27:03', '2023-05-12 03:27:03');
INSERT INTO `judge_case` VALUES (659, 132, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"10100\"\r\n', '2023-05-12 03:27:03', '2023-05-12 03:27:03');
INSERT INTO `judge_case` VALUES (660, 132, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:27:03', '2023-05-12 03:27:03');
INSERT INTO `judge_case` VALUES (661, 132, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:27:03', '2023-05-12 03:27:03');
INSERT INTO `judge_case` VALUES (662, 132, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-05-12 03:27:03', '2023-05-12 03:27:03');
INSERT INTO `judge_case` VALUES (663, 132, '1', 1006, NULL, 0, 15, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"27126743055556\"\r\n', '2023-05-12 03:27:03', '2023-05-12 03:27:03');
INSERT INTO `judge_case` VALUES (664, 132, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"987654321000000000\"\r\n', '2023-05-12 03:27:03', '2023-05-12 03:27:03');
INSERT INTO `judge_case` VALUES (665, 132, '1', 1006, NULL, 0, 0, 8, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"175618850864484\"\r\n', '2023-05-12 03:27:03', '2023-05-12 03:27:03');
INSERT INTO `judge_case` VALUES (666, 132, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3295710\"\r\n', '2023-05-12 03:27:03', '2023-05-12 03:27:03');
INSERT INTO `judge_case` VALUES (667, 131, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-05-12 03:27:13', '2023-05-12 03:27:13');
INSERT INTO `judge_case` VALUES (668, 131, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:27:13', '2023-05-12 03:27:13');
INSERT INTO `judge_case` VALUES (669, 131, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"2\"\r\n', '2023-05-12 03:27:13', '2023-05-12 03:27:13');
INSERT INTO `judge_case` VALUES (670, 131, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"2\"\r\n', '2023-05-12 03:27:13', '2023-05-12 03:27:13');
INSERT INTO `judge_case` VALUES (671, 131, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-05-12 03:27:13', '2023-05-12 03:27:13');
INSERT INTO `judge_case` VALUES (672, 131, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:27:13', '2023-05-12 03:27:13');
INSERT INTO `judge_case` VALUES (673, 131, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:27:13', '2023-05-12 03:27:13');
INSERT INTO `judge_case` VALUES (674, 131, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:27:13', '2023-05-12 03:27:13');
INSERT INTO `judge_case` VALUES (675, 131, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1000000000000000000\"\r\n', '2023-05-12 03:27:13', '2023-05-12 03:27:13');
INSERT INTO `judge_case` VALUES (676, 131, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"12\"\r\n', '2023-05-12 03:27:13', '2023-05-12 03:27:13');
INSERT INTO `judge_case` VALUES (677, 131, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3015\"\r\n', '2023-05-12 03:27:13', '2023-05-12 03:27:13');
INSERT INTO `judge_case` VALUES (678, 131, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"10000\"\r\n', '2023-05-12 03:27:13', '2023-05-12 03:27:13');
INSERT INTO `judge_case` VALUES (679, 131, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"10100\"\r\n', '2023-05-12 03:27:13', '2023-05-12 03:27:13');
INSERT INTO `judge_case` VALUES (680, 131, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:27:13', '2023-05-12 03:27:13');
INSERT INTO `judge_case` VALUES (681, 131, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:27:13', '2023-05-12 03:27:13');
INSERT INTO `judge_case` VALUES (682, 131, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-05-12 03:27:13', '2023-05-12 03:27:13');
INSERT INTO `judge_case` VALUES (683, 131, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"27126743055556\"\r\n', '2023-05-12 03:27:13', '2023-05-12 03:27:13');
INSERT INTO `judge_case` VALUES (684, 131, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"987654321000000000\"\r\n', '2023-05-12 03:27:13', '2023-05-12 03:27:13');
INSERT INTO `judge_case` VALUES (685, 131, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"175618850864484\"\r\n', '2023-05-12 03:27:13', '2023-05-12 03:27:13');
INSERT INTO `judge_case` VALUES (686, 131, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3295710\"\r\n', '2023-05-12 03:27:13', '2023-05-12 03:27:13');
INSERT INTO `judge_case` VALUES (687, 130, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-05-12 03:27:23', '2023-05-12 03:27:23');
INSERT INTO `judge_case` VALUES (688, 130, '1', 1006, NULL, 0, 15, 8, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:27:23', '2023-05-12 03:27:23');
INSERT INTO `judge_case` VALUES (689, 130, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"2\"\r\n', '2023-05-12 03:27:23', '2023-05-12 03:27:23');
INSERT INTO `judge_case` VALUES (690, 130, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"2\"\r\n', '2023-05-12 03:27:23', '2023-05-12 03:27:23');
INSERT INTO `judge_case` VALUES (691, 130, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-05-12 03:27:23', '2023-05-12 03:27:23');
INSERT INTO `judge_case` VALUES (692, 130, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:27:23', '2023-05-12 03:27:23');
INSERT INTO `judge_case` VALUES (693, 130, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:27:23', '2023-05-12 03:27:23');
INSERT INTO `judge_case` VALUES (694, 130, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:27:23', '2023-05-12 03:27:23');
INSERT INTO `judge_case` VALUES (695, 130, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1000000000000000000\"\r\n', '2023-05-12 03:27:23', '2023-05-12 03:27:23');
INSERT INTO `judge_case` VALUES (696, 130, '1', 1006, NULL, 0, 15, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"12\"\r\n', '2023-05-12 03:27:23', '2023-05-12 03:27:23');
INSERT INTO `judge_case` VALUES (697, 130, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3015\"\r\n', '2023-05-12 03:27:23', '2023-05-12 03:27:23');
INSERT INTO `judge_case` VALUES (698, 130, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"10000\"\r\n', '2023-05-12 03:27:23', '2023-05-12 03:27:23');
INSERT INTO `judge_case` VALUES (699, 130, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"10100\"\r\n', '2023-05-12 03:27:23', '2023-05-12 03:27:23');
INSERT INTO `judge_case` VALUES (700, 130, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:27:23', '2023-05-12 03:27:23');
INSERT INTO `judge_case` VALUES (701, 130, '1', 1006, NULL, 0, 15, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:27:23', '2023-05-12 03:27:23');
INSERT INTO `judge_case` VALUES (702, 130, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-05-12 03:27:23', '2023-05-12 03:27:23');
INSERT INTO `judge_case` VALUES (703, 130, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"27126743055556\"\r\n', '2023-05-12 03:27:23', '2023-05-12 03:27:23');
INSERT INTO `judge_case` VALUES (704, 130, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"987654321000000000\"\r\n', '2023-05-12 03:27:23', '2023-05-12 03:27:23');
INSERT INTO `judge_case` VALUES (705, 130, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"175618850864484\"\r\n', '2023-05-12 03:27:23', '2023-05-12 03:27:23');
INSERT INTO `judge_case` VALUES (706, 130, '1', 1006, NULL, 0, 0, 8, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3295710\"\r\n', '2023-05-12 03:27:23', '2023-05-12 03:27:23');
INSERT INTO `judge_case` VALUES (707, 137, '1', 1006, NULL, 0, 15, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-05-12 03:27:35', '2023-05-12 03:27:35');
INSERT INTO `judge_case` VALUES (708, 137, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:27:35', '2023-05-12 03:27:35');
INSERT INTO `judge_case` VALUES (709, 137, '1', 1006, NULL, 0, 15, 8, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"2\"\r\n', '2023-05-12 03:27:35', '2023-05-12 03:27:35');
INSERT INTO `judge_case` VALUES (710, 137, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"2\"\r\n', '2023-05-12 03:27:35', '2023-05-12 03:27:35');
INSERT INTO `judge_case` VALUES (711, 137, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-05-12 03:27:35', '2023-05-12 03:27:35');
INSERT INTO `judge_case` VALUES (712, 137, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:27:35', '2023-05-12 03:27:35');
INSERT INTO `judge_case` VALUES (713, 137, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:27:35', '2023-05-12 03:27:35');
INSERT INTO `judge_case` VALUES (714, 137, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:27:35', '2023-05-12 03:27:35');
INSERT INTO `judge_case` VALUES (715, 137, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1000000000000000000\"\r\n', '2023-05-12 03:27:35', '2023-05-12 03:27:35');
INSERT INTO `judge_case` VALUES (716, 137, '1', 1006, NULL, 0, 15, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"12\"\r\n', '2023-05-12 03:27:35', '2023-05-12 03:27:35');
INSERT INTO `judge_case` VALUES (717, 137, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3015\"\r\n', '2023-05-12 03:27:35', '2023-05-12 03:27:35');
INSERT INTO `judge_case` VALUES (718, 137, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"10000\"\r\n', '2023-05-12 03:27:35', '2023-05-12 03:27:35');
INSERT INTO `judge_case` VALUES (719, 137, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"10100\"\r\n', '2023-05-12 03:27:35', '2023-05-12 03:27:35');
INSERT INTO `judge_case` VALUES (720, 137, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:27:35', '2023-05-12 03:27:35');
INSERT INTO `judge_case` VALUES (721, 137, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:27:35', '2023-05-12 03:27:35');
INSERT INTO `judge_case` VALUES (722, 137, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-05-12 03:27:35', '2023-05-12 03:27:35');
INSERT INTO `judge_case` VALUES (723, 137, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"27126743055556\"\r\n', '2023-05-12 03:27:35', '2023-05-12 03:27:35');
INSERT INTO `judge_case` VALUES (724, 137, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"987654321000000000\"\r\n', '2023-05-12 03:27:35', '2023-05-12 03:27:35');
INSERT INTO `judge_case` VALUES (725, 137, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"175618850864484\"\r\n', '2023-05-12 03:27:35', '2023-05-12 03:27:35');
INSERT INTO `judge_case` VALUES (726, 137, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3295710\"\r\n', '2023-05-12 03:27:35', '2023-05-12 03:27:35');
INSERT INTO `judge_case` VALUES (727, 138, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-05-12 03:27:46', '2023-05-12 03:27:46');
INSERT INTO `judge_case` VALUES (728, 138, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:27:46', '2023-05-12 03:27:46');
INSERT INTO `judge_case` VALUES (729, 138, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"2\"\r\n', '2023-05-12 03:27:46', '2023-05-12 03:27:46');
INSERT INTO `judge_case` VALUES (730, 138, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"2\"\r\n', '2023-05-12 03:27:46', '2023-05-12 03:27:46');
INSERT INTO `judge_case` VALUES (731, 138, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-05-12 03:27:46', '2023-05-12 03:27:46');
INSERT INTO `judge_case` VALUES (732, 138, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:27:46', '2023-05-12 03:27:46');
INSERT INTO `judge_case` VALUES (733, 138, '1', 1006, NULL, 0, 15, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:27:46', '2023-05-12 03:27:46');
INSERT INTO `judge_case` VALUES (734, 138, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:27:46', '2023-05-12 03:27:46');
INSERT INTO `judge_case` VALUES (735, 138, '1', 1006, NULL, 0, 15, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1000000000000000000\"\r\n', '2023-05-12 03:27:46', '2023-05-12 03:27:46');
INSERT INTO `judge_case` VALUES (736, 138, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"12\"\r\n', '2023-05-12 03:27:46', '2023-05-12 03:27:46');
INSERT INTO `judge_case` VALUES (737, 138, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3015\"\r\n', '2023-05-12 03:27:46', '2023-05-12 03:27:46');
INSERT INTO `judge_case` VALUES (738, 138, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"10000\"\r\n', '2023-05-12 03:27:46', '2023-05-12 03:27:46');
INSERT INTO `judge_case` VALUES (739, 138, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"10100\"\r\n', '2023-05-12 03:27:46', '2023-05-12 03:27:46');
INSERT INTO `judge_case` VALUES (740, 138, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:27:46', '2023-05-12 03:27:46');
INSERT INTO `judge_case` VALUES (741, 138, '1', 1006, NULL, 0, 15, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:27:46', '2023-05-12 03:27:46');
INSERT INTO `judge_case` VALUES (742, 138, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-05-12 03:27:46', '2023-05-12 03:27:46');
INSERT INTO `judge_case` VALUES (743, 138, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"27126743055556\"\r\n', '2023-05-12 03:27:46', '2023-05-12 03:27:46');
INSERT INTO `judge_case` VALUES (744, 138, '1', 1006, NULL, 0, 15, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"987654321000000000\"\r\n', '2023-05-12 03:27:46', '2023-05-12 03:27:46');
INSERT INTO `judge_case` VALUES (745, 138, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"175618850864484\"\r\n', '2023-05-12 03:27:46', '2023-05-12 03:27:46');
INSERT INTO `judge_case` VALUES (746, 138, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3295710\"\r\n', '2023-05-12 03:27:46', '2023-05-12 03:27:46');
INSERT INTO `judge_case` VALUES (747, 140, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-05-12 03:27:55', '2023-05-12 03:27:55');
INSERT INTO `judge_case` VALUES (748, 140, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:27:55', '2023-05-12 03:27:55');
INSERT INTO `judge_case` VALUES (749, 140, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"2\"\r\n', '2023-05-12 03:27:55', '2023-05-12 03:27:55');
INSERT INTO `judge_case` VALUES (750, 140, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"2\"\r\n', '2023-05-12 03:27:55', '2023-05-12 03:27:55');
INSERT INTO `judge_case` VALUES (751, 140, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-05-12 03:27:55', '2023-05-12 03:27:55');
INSERT INTO `judge_case` VALUES (752, 140, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:27:55', '2023-05-12 03:27:55');
INSERT INTO `judge_case` VALUES (753, 140, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:27:55', '2023-05-12 03:27:55');
INSERT INTO `judge_case` VALUES (754, 140, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:27:55', '2023-05-12 03:27:55');
INSERT INTO `judge_case` VALUES (755, 140, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1000000000000000000\"\r\n', '2023-05-12 03:27:55', '2023-05-12 03:27:55');
INSERT INTO `judge_case` VALUES (756, 140, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"12\"\r\n', '2023-05-12 03:27:55', '2023-05-12 03:27:55');
INSERT INTO `judge_case` VALUES (757, 140, '1', 1006, NULL, 0, 15, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3015\"\r\n', '2023-05-12 03:27:55', '2023-05-12 03:27:55');
INSERT INTO `judge_case` VALUES (758, 140, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"10000\"\r\n', '2023-05-12 03:27:55', '2023-05-12 03:27:55');
INSERT INTO `judge_case` VALUES (759, 140, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"10100\"\r\n', '2023-05-12 03:27:55', '2023-05-12 03:27:55');
INSERT INTO `judge_case` VALUES (760, 140, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:27:55', '2023-05-12 03:27:55');
INSERT INTO `judge_case` VALUES (761, 140, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:27:55', '2023-05-12 03:27:55');
INSERT INTO `judge_case` VALUES (762, 140, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-05-12 03:27:55', '2023-05-12 03:27:55');
INSERT INTO `judge_case` VALUES (763, 140, '1', 1006, NULL, 0, 15, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"27126743055556\"\r\n', '2023-05-12 03:27:55', '2023-05-12 03:27:55');
INSERT INTO `judge_case` VALUES (764, 140, '1', 1006, NULL, 0, 15, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"987654321000000000\"\r\n', '2023-05-12 03:27:55', '2023-05-12 03:27:55');
INSERT INTO `judge_case` VALUES (765, 140, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"175618850864484\"\r\n', '2023-05-12 03:27:55', '2023-05-12 03:27:55');
INSERT INTO `judge_case` VALUES (766, 140, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3295710\"\r\n', '2023-05-12 03:27:55', '2023-05-12 03:27:55');
INSERT INTO `judge_case` VALUES (767, 141, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-05-12 03:28:04', '2023-05-12 03:28:04');
INSERT INTO `judge_case` VALUES (768, 141, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:28:04', '2023-05-12 03:28:04');
INSERT INTO `judge_case` VALUES (769, 141, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"2\"\r\n', '2023-05-12 03:28:04', '2023-05-12 03:28:04');
INSERT INTO `judge_case` VALUES (770, 141, '1', 1006, NULL, 0, 0, 8, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"2\"\r\n', '2023-05-12 03:28:04', '2023-05-12 03:28:04');
INSERT INTO `judge_case` VALUES (771, 141, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-05-12 03:28:04', '2023-05-12 03:28:04');
INSERT INTO `judge_case` VALUES (772, 141, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:28:04', '2023-05-12 03:28:04');
INSERT INTO `judge_case` VALUES (773, 141, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:28:04', '2023-05-12 03:28:04');
INSERT INTO `judge_case` VALUES (774, 141, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:28:04', '2023-05-12 03:28:04');
INSERT INTO `judge_case` VALUES (775, 141, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1000000000000000000\"\r\n', '2023-05-12 03:28:04', '2023-05-12 03:28:04');
INSERT INTO `judge_case` VALUES (776, 141, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"12\"\r\n', '2023-05-12 03:28:04', '2023-05-12 03:28:04');
INSERT INTO `judge_case` VALUES (777, 141, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3015\"\r\n', '2023-05-12 03:28:04', '2023-05-12 03:28:04');
INSERT INTO `judge_case` VALUES (778, 141, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"10000\"\r\n', '2023-05-12 03:28:04', '2023-05-12 03:28:04');
INSERT INTO `judge_case` VALUES (779, 141, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"10100\"\r\n', '2023-05-12 03:28:04', '2023-05-12 03:28:04');
INSERT INTO `judge_case` VALUES (780, 141, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:28:04', '2023-05-12 03:28:04');
INSERT INTO `judge_case` VALUES (781, 141, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:28:04', '2023-05-12 03:28:04');
INSERT INTO `judge_case` VALUES (782, 141, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-05-12 03:28:04', '2023-05-12 03:28:04');
INSERT INTO `judge_case` VALUES (783, 141, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"27126743055556\"\r\n', '2023-05-12 03:28:04', '2023-05-12 03:28:04');
INSERT INTO `judge_case` VALUES (784, 141, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"987654321000000000\"\r\n', '2023-05-12 03:28:04', '2023-05-12 03:28:04');
INSERT INTO `judge_case` VALUES (785, 141, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"175618850864484\"\r\n', '2023-05-12 03:28:04', '2023-05-12 03:28:04');
INSERT INTO `judge_case` VALUES (786, 141, '1', 1006, NULL, 0, 15, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3295710\"\r\n', '2023-05-12 03:28:04', '2023-05-12 03:28:04');
INSERT INTO `judge_case` VALUES (787, 139, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-05-12 03:28:14', '2023-05-12 03:28:14');
INSERT INTO `judge_case` VALUES (788, 139, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:28:14', '2023-05-12 03:28:14');
INSERT INTO `judge_case` VALUES (789, 139, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"2\"\r\n', '2023-05-12 03:28:14', '2023-05-12 03:28:14');
INSERT INTO `judge_case` VALUES (790, 139, '1', 1006, NULL, 0, 15, 8, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"2\"\r\n', '2023-05-12 03:28:14', '2023-05-12 03:28:14');
INSERT INTO `judge_case` VALUES (791, 139, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-05-12 03:28:14', '2023-05-12 03:28:14');
INSERT INTO `judge_case` VALUES (792, 139, '1', 1006, NULL, 0, 15, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:28:14', '2023-05-12 03:28:14');
INSERT INTO `judge_case` VALUES (793, 139, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:28:14', '2023-05-12 03:28:14');
INSERT INTO `judge_case` VALUES (794, 139, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:28:14', '2023-05-12 03:28:14');
INSERT INTO `judge_case` VALUES (795, 139, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1000000000000000000\"\r\n', '2023-05-12 03:28:14', '2023-05-12 03:28:14');
INSERT INTO `judge_case` VALUES (796, 139, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"12\"\r\n', '2023-05-12 03:28:14', '2023-05-12 03:28:14');
INSERT INTO `judge_case` VALUES (797, 139, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3015\"\r\n', '2023-05-12 03:28:14', '2023-05-12 03:28:14');
INSERT INTO `judge_case` VALUES (798, 139, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"10000\"\r\n', '2023-05-12 03:28:14', '2023-05-12 03:28:14');
INSERT INTO `judge_case` VALUES (799, 139, '1', 1006, NULL, 0, 15, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"10100\"\r\n', '2023-05-12 03:28:14', '2023-05-12 03:28:14');
INSERT INTO `judge_case` VALUES (800, 139, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:28:14', '2023-05-12 03:28:14');
INSERT INTO `judge_case` VALUES (801, 139, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:28:14', '2023-05-12 03:28:14');
INSERT INTO `judge_case` VALUES (802, 139, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-05-12 03:28:14', '2023-05-12 03:28:14');
INSERT INTO `judge_case` VALUES (803, 139, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"27126743055556\"\r\n', '2023-05-12 03:28:14', '2023-05-12 03:28:14');
INSERT INTO `judge_case` VALUES (804, 139, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"987654321000000000\"\r\n', '2023-05-12 03:28:14', '2023-05-12 03:28:14');
INSERT INTO `judge_case` VALUES (805, 139, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"175618850864484\"\r\n', '2023-05-12 03:28:14', '2023-05-12 03:28:14');
INSERT INTO `judge_case` VALUES (806, 139, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3295710\"\r\n', '2023-05-12 03:28:14', '2023-05-12 03:28:14');
INSERT INTO `judge_case` VALUES (807, 142, '1', 1006, NULL, 0, 15, 8, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-05-12 03:28:24', '2023-05-12 03:28:24');
INSERT INTO `judge_case` VALUES (808, 142, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:28:24', '2023-05-12 03:28:24');
INSERT INTO `judge_case` VALUES (809, 142, '1', 1006, NULL, 0, 0, 8, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"2\"\r\n', '2023-05-12 03:28:24', '2023-05-12 03:28:24');
INSERT INTO `judge_case` VALUES (810, 142, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"2\"\r\n', '2023-05-12 03:28:24', '2023-05-12 03:28:24');
INSERT INTO `judge_case` VALUES (811, 142, '1', 1006, NULL, 0, 0, 8, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-05-12 03:28:24', '2023-05-12 03:28:24');
INSERT INTO `judge_case` VALUES (812, 142, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:28:24', '2023-05-12 03:28:24');
INSERT INTO `judge_case` VALUES (813, 142, '1', 1006, NULL, 0, 0, 8, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:28:24', '2023-05-12 03:28:24');
INSERT INTO `judge_case` VALUES (814, 142, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:28:24', '2023-05-12 03:28:24');
INSERT INTO `judge_case` VALUES (815, 142, '1', 1006, NULL, 0, 15, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1000000000000000000\"\r\n', '2023-05-12 03:28:24', '2023-05-12 03:28:24');
INSERT INTO `judge_case` VALUES (816, 142, '1', 1006, NULL, 0, 0, 8, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"12\"\r\n', '2023-05-12 03:28:24', '2023-05-12 03:28:24');
INSERT INTO `judge_case` VALUES (817, 142, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3015\"\r\n', '2023-05-12 03:28:24', '2023-05-12 03:28:24');
INSERT INTO `judge_case` VALUES (818, 142, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"10000\"\r\n', '2023-05-12 03:28:24', '2023-05-12 03:28:24');
INSERT INTO `judge_case` VALUES (819, 142, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"10100\"\r\n', '2023-05-12 03:28:24', '2023-05-12 03:28:24');
INSERT INTO `judge_case` VALUES (820, 142, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:28:24', '2023-05-12 03:28:24');
INSERT INTO `judge_case` VALUES (821, 142, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:28:24', '2023-05-12 03:28:24');
INSERT INTO `judge_case` VALUES (822, 142, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-05-12 03:28:24', '2023-05-12 03:28:24');
INSERT INTO `judge_case` VALUES (823, 142, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"27126743055556\"\r\n', '2023-05-12 03:28:24', '2023-05-12 03:28:24');
INSERT INTO `judge_case` VALUES (824, 142, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"987654321000000000\"\r\n', '2023-05-12 03:28:24', '2023-05-12 03:28:24');
INSERT INTO `judge_case` VALUES (825, 142, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"175618850864484\"\r\n', '2023-05-12 03:28:24', '2023-05-12 03:28:24');
INSERT INTO `judge_case` VALUES (826, 142, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3295710\"\r\n', '2023-05-12 03:28:24', '2023-05-12 03:28:24');
INSERT INTO `judge_case` VALUES (827, 143, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-05-12 03:28:34', '2023-05-12 03:28:34');
INSERT INTO `judge_case` VALUES (828, 143, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:28:34', '2023-05-12 03:28:34');
INSERT INTO `judge_case` VALUES (829, 143, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"2\"\r\n', '2023-05-12 03:28:34', '2023-05-12 03:28:34');
INSERT INTO `judge_case` VALUES (830, 143, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"2\"\r\n', '2023-05-12 03:28:34', '2023-05-12 03:28:34');
INSERT INTO `judge_case` VALUES (831, 143, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-05-12 03:28:34', '2023-05-12 03:28:34');
INSERT INTO `judge_case` VALUES (832, 143, '1', 1006, NULL, 0, 0, 8, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:28:34', '2023-05-12 03:28:34');
INSERT INTO `judge_case` VALUES (833, 143, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:28:34', '2023-05-12 03:28:34');
INSERT INTO `judge_case` VALUES (834, 143, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:28:34', '2023-05-12 03:28:34');
INSERT INTO `judge_case` VALUES (835, 143, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1000000000000000000\"\r\n', '2023-05-12 03:28:34', '2023-05-12 03:28:34');
INSERT INTO `judge_case` VALUES (836, 143, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"12\"\r\n', '2023-05-12 03:28:34', '2023-05-12 03:28:34');
INSERT INTO `judge_case` VALUES (837, 143, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3015\"\r\n', '2023-05-12 03:28:34', '2023-05-12 03:28:34');
INSERT INTO `judge_case` VALUES (838, 143, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"10000\"\r\n', '2023-05-12 03:28:34', '2023-05-12 03:28:34');
INSERT INTO `judge_case` VALUES (839, 143, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"10100\"\r\n', '2023-05-12 03:28:34', '2023-05-12 03:28:34');
INSERT INTO `judge_case` VALUES (840, 143, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:28:34', '2023-05-12 03:28:34');
INSERT INTO `judge_case` VALUES (841, 143, '1', 1006, NULL, 0, 0, 8, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"1\"\r\n', '2023-05-12 03:28:34', '2023-05-12 03:28:34');
INSERT INTO `judge_case` VALUES (842, 143, '1', 1006, NULL, 0, 0, 4, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"4\"\r\n', '2023-05-12 03:28:34', '2023-05-12 03:28:34');
INSERT INTO `judge_case` VALUES (843, 143, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"27126743055556\"\r\n', '2023-05-12 03:28:34', '2023-05-12 03:28:34');
INSERT INTO `judge_case` VALUES (844, 143, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"987654321000000000\"\r\n', '2023-05-12 03:28:34', '2023-05-12 03:28:34');
INSERT INTO `judge_case` VALUES (845, 143, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"175618850864484\"\r\n', '2023-05-12 03:28:34', '2023-05-12 03:28:34');
INSERT INTO `judge_case` VALUES (846, 143, '1', 1006, NULL, 0, 0, 0, NULL, NULL, NULL, 'default', NULL, NULL, 'ok 1 number(s): \"3295710\"\r\n', '2023-05-12 03:28:34', '2023-05-12 03:28:34');
INSERT INTO `judge_case` VALUES (847, 145, '1', 1013, 19, 0, 5, 1688, NULL, 1, 1, 'default', '1.in', '1.out', NULL, '2023-05-17 23:31:23', '2023-05-17 23:31:23');

-- ----------------------------
-- Table structure for judge_server
-- ----------------------------
DROP TABLE IF EXISTS `judge_server`;
CREATE TABLE `judge_server`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '判题服务名字',
  `ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '判题机ip',
  `port` int(0) NOT NULL COMMENT '判题机端口号',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'ip:port',
  `cpu_core` int(0) NULL DEFAULT 0 COMMENT '判题机所在服务器cpu核心数',
  `task_number` int(0) NOT NULL DEFAULT 0 COMMENT '当前判题数',
  `max_task_number` int(0) NOT NULL COMMENT '判题并发最大数',
  `status` int(0) NULL DEFAULT 0 COMMENT '0可用，1不可用',
  `is_remote` tinyint(1) NULL DEFAULT NULL COMMENT '是否开启远程判题vj',
  `cf_submittable` tinyint(1) NULL DEFAULT 1 COMMENT '是否可提交CF',
  `gmt_create` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `gmt_modified` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_judge_remote`(`is_remote`) USING BTREE,
  INDEX `index_judge_url`(`url`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 194 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of judge_server
-- ----------------------------
INSERT INTO `judge_server` VALUES (197, 'loj-judger-1', '127.0.0.1', 5588, '127.0.0.1:5588', 16, 0, 6, 0, 0, 1, '2023-05-18 22:00:17', '2023-05-18 22:00:17');
INSERT INTO `judge_server` VALUES (198, 'loj-judger-1', '127.0.0.1', 5588, '127.0.0.1:5588', 16, 0, 33, 0, 1, 1, '2023-05-18 22:00:17', '2023-05-18 22:00:17');
INSERT INTO `judge_server` VALUES (199, 'hoj-judger-1', '127.0.0.1', 7788, '127.0.0.1:7788', 16, 0, 6, 0, 0, 1, '2023-05-18 22:00:36', '2023-05-18 22:00:36');
INSERT INTO `judge_server` VALUES (200, 'hoj-judger-1', '127.0.0.1', 7788, '127.0.0.1:7788', 16, 0, 33, 0, 1, 1, '2023-05-18 22:00:36', '2023-05-18 22:00:36');

-- ----------------------------
-- Table structure for language
-- ----------------------------
DROP TABLE IF EXISTS `language`;
CREATE TABLE `language`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `content_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '语言类型',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '语言名字',
  `compile_command` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '编译指令',
  `template` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '模板',
  `code_template` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '语言默认代码模板',
  `is_spj` tinyint(1) NULL DEFAULT 0 COMMENT '是否可作为特殊判题的一种语言',
  `oj` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '该语言属于哪个oj，自身oj用ME',
  `seq` int(0) NULL DEFAULT 0 COMMENT '语言排序',
  `gmt_create` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `gmt_modified` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 211 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of language
-- ----------------------------
INSERT INTO `language` VALUES (1, 'text/x-csrc', 'GCC 9.4.0', 'C', '/usr/bin/gcc -DONLINE_JUDGE -w -fmax-errors=3 -std=c11 {src_path} -lm -o {exe_path}', '#include <stdio.h>\r\nint main() {\r\n    int a,b;\r\n    scanf(\"%d %d\",&a,&b);\r\n    printf(\"%d\",a+b);\r\n    return 0;\r\n}', '//PREPEND BEGIN\r\n#include <stdio.h>\r\n//PREPEND END\r\n\r\n//TEMPLATE BEGIN\r\nint add(int a, int b) {\r\n  // Please fill this blank\r\n  return ___________;\r\n}\r\n//TEMPLATE END\r\n\r\n//APPEND BEGIN\r\nint main() {\r\n  printf(\"%d\", add(1, 2));\r\n  return 0;\r\n}\r\n//APPEND END', 1, 'ME', 0, '2020-12-12 23:11:44', '2021-06-14 21:40:28');
INSERT INTO `language` VALUES (2, 'text/x-csrc', 'GCC 9.4.0', 'C With O2', '/usr/bin/gcc -DONLINE_JUDGE -O2 -w -fmax-errors=3 -std=c11 {src_path} -lm -o {exe_path}', '#include <stdio.h>\r\nint main() {\r\n    int a,b;\r\n    scanf(\"%d %d\",&a,&b);\r\n    printf(\"%d\",a+b);\r\n    return 0;\r\n}', '//PREPEND BEGIN\r\n#include <stdio.h>\r\n//PREPEND END\r\n\r\n//TEMPLATE BEGIN\r\nint add(int a, int b) {\r\n  // Please fill this blank\r\n  return ___________;\r\n}\r\n//TEMPLATE END\r\n\r\n//APPEND BEGIN\r\nint main() {\r\n  printf(\"%d\", add(1, 2));\r\n  return 0;\r\n}\r\n//APPEND END', 0, 'ME', 0, '2021-06-14 21:05:57', '2021-06-14 21:20:08');
INSERT INTO `language` VALUES (3, 'text/x-c++src', 'G++ 9.4.0', 'C++', '/usr/bin/g++ -DONLINE_JUDGE -w -fmax-errors=3 -std=c++14 {src_path} -lm -o {exe_path}', '#include<iostream>\r\nusing namespace std;\r\nint main()\r\n{\r\n    int a,b;\r\n    cin >> a >> b;\r\n    cout << a + b;\r\n    return 0;\r\n}', '//PREPEND BEGIN\r\n#include <iostream>\r\nusing namespace std;\r\n//PREPEND END\r\n\r\n//TEMPLATE BEGIN\r\nint add(int a, int b) {\r\n  // Please fill this blank\r\n  return ___________;\r\n}\r\n//TEMPLATE END\r\n\r\n//APPEND BEGIN\r\nint main() {\r\n  cout << add(1, 2);\r\n  return 0;\r\n}\r\n//APPEND END', 1, 'ME', 0, '2020-12-12 23:12:44', '2021-06-14 21:40:36');
INSERT INTO `language` VALUES (4, 'text/x-c++src', 'G++ 9.4.0', 'C++ With O2', '/usr/bin/g++ -DONLINE_JUDGE -O2 -w -fmax-errors=3 -std=c++14 {src_path} -lm -o {exe_path}', '#include<iostream>\r\nusing namespace std;\r\nint main()\r\n{\r\n    int a,b;\r\n    cin >> a >> b;\r\n    cout << a + b;\r\n    return 0;\r\n}', '//PREPEND BEGIN\r\n#include <iostream>\r\nusing namespace std;\r\n//PREPEND END\r\n\r\n//TEMPLATE BEGIN\r\nint add(int a, int b) {\r\n  // Please fill this blank\r\n  return ___________;\r\n}\r\n//TEMPLATE END\r\n\r\n//APPEND BEGIN\r\nint main() {\r\n  cout << add(1, 2);\r\n  return 0;\r\n}\r\n//APPEND END', 0, 'ME', 0, '2021-06-14 21:09:35', '2021-06-14 21:20:19');
INSERT INTO `language` VALUES (5, 'text/x-c++src', 'G++ 9.4.0', 'C++ 17', '/usr/bin/g++ -DONLINE_JUDGE -w -fmax-errors=3 -std=c++17 {src_path} -lm -o {exe_path}', '#include<iostream>\r\nusing namespace std;\r\nint main()\r\n{\r\n    int a,b;\r\n    cin >> a >> b;\r\n    cout << a + b;\r\n    return 0;\r\n}', '//PREPEND BEGIN\r\n#include <iostream>\r\nusing namespace std;\r\n//PREPEND END\r\n\r\n//TEMPLATE BEGIN\r\nint add(int a, int b) {\r\n  // Please fill this blank\r\n  return ___________;\r\n}\r\n//TEMPLATE END\r\n\r\n//APPEND BEGIN\r\nint main() {\r\n  cout << add(1, 2);\r\n  return 0;\r\n}\r\n//APPEND END', 0, 'ME', 0, '2020-12-12 23:12:44', '2021-06-14 21:40:36');
INSERT INTO `language` VALUES (6, 'text/x-c++src', 'G++ 9.4.0', 'C++ 17 With O2', '/usr/bin/g++ -DONLINE_JUDGE -O2 -w -fmax-errors=3 -std=c++17 {src_path} -lm -o {exe_path}', '#include<iostream>\r\nusing namespace std;\r\nint main()\r\n{\r\n    int a,b;\r\n    cin >> a >> b;\r\n    cout << a + b;\r\n    return 0;\r\n}', '//PREPEND BEGIN\r\n#include <iostream>\r\nusing namespace std;\r\n//PREPEND END\r\n\r\n//TEMPLATE BEGIN\r\nint add(int a, int b) {\r\n  // Please fill this blank\r\n  return ___________;\r\n}\r\n//TEMPLATE END\r\n\r\n//APPEND BEGIN\r\nint main() {\r\n  cout << add(1, 2);\r\n  return 0;\r\n}\r\n//APPEND END', 0, 'ME', 0, '2021-06-14 21:09:35', '2021-06-14 21:20:19');
INSERT INTO `language` VALUES (7, 'text/x-c++src', 'G++ 9.4.0', 'C++ 20', '/usr/bin/g++ -DONLINE_JUDGE -w -fmax-errors=3 -std=c++20 {src_path} -lm -o {exe_path}', '#include<iostream>\r\nusing namespace std;\r\nint main()\r\n{\r\n    int a,b;\r\n    cin >> a >> b;\r\n    cout << a + b;\r\n    return 0;\r\n}', '//PREPEND BEGIN\r\n#include <iostream>\r\nusing namespace std;\r\n//PREPEND END\r\n\r\n//TEMPLATE BEGIN\r\nint add(int a, int b) {\r\n  // Please fill this blank\r\n  return ___________;\r\n}\r\n//TEMPLATE END\r\n\r\n//APPEND BEGIN\r\nint main() {\r\n  cout << add(1, 2);\r\n  return 0;\r\n}\r\n//APPEND END', 0, 'ME', 0, '2020-12-12 23:12:44', '2021-06-14 21:40:36');
INSERT INTO `language` VALUES (8, 'text/x-c++src', 'G++ 9.4.0', 'C++ 20 With O2', '/usr/bin/g++ -DONLINE_JUDGE -O2 -w -fmax-errors=3 -std=c++20 {src_path} -lm -o {exe_path}', '#include<iostream>\r\nusing namespace std;\r\nint main()\r\n{\r\n    int a,b;\r\n    cin >> a >> b;\r\n    cout << a + b;\r\n    return 0;\r\n}', '//PREPEND BEGIN\r\n#include <iostream>\r\nusing namespace std;\r\n//PREPEND END\r\n\r\n//TEMPLATE BEGIN\r\nint add(int a, int b) {\r\n  // Please fill this blank\r\n  return ___________;\r\n}\r\n//TEMPLATE END\r\n\r\n//APPEND BEGIN\r\nint main() {\r\n  cout << add(1, 2);\r\n  return 0;\r\n}\r\n//APPEND END', 0, 'ME', 0, '2021-06-14 21:09:35', '2021-06-14 21:20:19');
INSERT INTO `language` VALUES (9, 'text/x-java', 'OpenJDK 1.8', 'Java', '/usr/bin/javac {src_path} -d {exe_dir} -encoding UTF8', 'import java.util.Scanner;\r\npublic class Main{\r\n    public static void main(String[] args){\r\n        Scanner in=new Scanner(System.in);\r\n        int a=in.nextInt();\r\n        int b=in.nextInt();\r\n        System.out.println((a+b));\r\n    }\r\n}', '//PREPEND BEGIN\r\nimport java.util.Scanner;\r\n//PREPEND END\r\n\r\npublic class Main{\r\n    //TEMPLATE BEGIN\r\n    public static Integer add(int a,int b){\r\n        return _______;\r\n    }\r\n    //TEMPLATE END\r\n\r\n    //APPEND BEGIN\r\n    public static void main(String[] args){\r\n        System.out.println(add(a,b));\r\n    }\r\n    //APPEND END\r\n}\r\n', 0, 'ME', 0, '2020-12-12 23:12:51', '2021-06-14 21:19:52');
INSERT INTO `language` VALUES (10, 'text/x-python', 'Python 3.7.5', 'Python3', '/usr/bin/python3 -m py_compile {src_path}', 'a, b = map(int, input().split())\r\nprint(a + b)', '//PREPEND BEGIN\r\n//PREPEND END\r\n\r\n//TEMPLATE BEGIN\r\ndef add(a, b):\r\n    return a + b\r\n//TEMPLATE END\r\n\r\n\r\nif __name__ == \'__main__\':  \r\n    //APPEND BEGIN\r\n    a, b = 1, 1\r\n    print(add(a, b))\r\n    //APPEND END', 0, 'ME', 0, '2020-12-12 23:14:23', '2021-06-14 21:19:50');
INSERT INTO `language` VALUES (11, 'text/x-python', 'Python 2.7.17', 'Python2', '/usr/bin/python -m py_compile {src_path}', 'a, b = map(int, raw_input().split())\r\nprint a+b', '//PREPEND BEGIN\r\n//PREPEND END\r\n\r\n//TEMPLATE BEGIN\r\ndef add(a, b):\r\n    return a + b\r\n//TEMPLATE END\r\n\r\n\r\nif __name__ == \'__main__\':  \r\n    //APPEND BEGIN\r\n    a, b = 1, 1\r\n    print add(a, b)\r\n    //APPEND END', 0, 'ME', 0, '2021-01-26 11:11:44', '2021-06-14 21:19:45');
INSERT INTO `language` VALUES (12, 'text/x-go', 'Golang 1.19', 'Golang', '/usr/bin/go build -o {exe_path} {src_path}', 'package main\r\nimport \"fmt\"\r\n\r\nfunc main(){\r\n    var x int\r\n    var y int\r\n    fmt.Scanln(&x,&y)\r\n    fmt.Printf(\"%d\",x+y)  \r\n}\r\n', '\r\npackage main\r\n\r\n//PREPEND BEGIN\r\nimport \"fmt\"\r\n//PREPEND END\r\n\r\n\r\n//TEMPLATE BEGIN\r\nfunc add(a,b int)int{\r\n    return ______\r\n}\r\n//TEMPLATE END\r\n\r\n//APPEND BEGIN\r\nfunc main(){\r\n    var x int\r\n    var y int\r\n    fmt.Printf(\"%d\",add(x,y))  \r\n}\r\n//APPEND END\r\n', 0, 'ME', 0, '2021-03-28 23:15:54', '2021-06-14 21:20:26');
INSERT INTO `language` VALUES (13, 'text/x-csharp', 'C# Mono 4.6.2', 'C#', '/usr/bin/mcs -optimize+ -out:{exe_path} {src_path}', 'using System;\r\nusing System.Linq;\r\n\r\nclass Program {\r\n    public static void Main(string[] args) {\r\n        Console.WriteLine(Console.ReadLine().Split().Select(int.Parse).Sum());\r\n    }\r\n}', '//PREPEND BEGIN\r\nusing System;\r\nusing System.Collections.Generic;\r\nusing System.Text;\r\n//PREPEND END\r\n\r\nclass Solution\r\n{\r\n    //TEMPLATE BEGIN\r\n    static int add(int a,int b){\r\n        return _______;\r\n    }\r\n    //TEMPLATE END\r\n\r\n    //APPEND BEGIN\r\n    static void Main(string[] args)\r\n    {\r\n        int a ;\r\n        int b ;\r\n        Console.WriteLine(add(a,b));\r\n    }\r\n    //APPEND END\r\n}', 0, 'ME', 0, '2021-04-13 16:10:03', '2021-06-14 21:20:36');
INSERT INTO `language` VALUES (14, 'text/x-php', 'PHP 7.3.33', 'PHP', '/usr/bin/php {src_path}', '<?=array_sum(fscanf(STDIN, \"%d %d\"));', NULL, 0, 'ME', 0, '2022-02-25 20:55:30', '2022-09-20 21:43:01');
INSERT INTO `language` VALUES (15, 'text/x-python', 'PyPy 2.7.18 (7.3.8)', 'PyPy2', '/usr/bin/pypy -m py_compile {src_path}', 'print sum(int(x) for x in raw_input().split(\' \'))', '//PREPEND BEGIN\n//PREPEND END\n\n//TEMPLATE BEGIN\ndef add(a, b):\n    return a + b\n//TEMPLATE END\n\n\nif __name__ == \'__main__\':  \n    //APPEND BEGIN\n    a, b = 1, 1\n    print add(a, b)\n    //APPEND END', 0, 'ME', 0, '2022-02-25 20:55:30', '2022-09-20 21:43:03');
INSERT INTO `language` VALUES (16, 'text/x-python', 'PyPy 3.8.12 (7.3.8)', 'PyPy3', '/usr/bin/pypy3 -m py_compile {src_path}', 'print(sum(int(x) for x in input().split(\' \')))', '//PREPEND BEGIN\n//PREPEND END\n\n//TEMPLATE BEGIN\ndef add(a, b):\n    return a + b\n//TEMPLATE END\n\n\nif __name__ == \'__main__\':  \n    //APPEND BEGIN\n    a, b = 1, 1\n    print(add(a, b))\n    //APPEND END', 0, 'ME', 0, '2022-02-25 20:55:30', '2022-09-20 21:43:06');
INSERT INTO `language` VALUES (17, 'text/javascript', 'Node.js 14.19.0', 'JavaScript Node', '/usr/bin/node {src_path}', 'var readline = require(\'readline\');\nconst rl = readline.createInterface({\n        input: process.stdin,\n        output: process.stdout\n});\nrl.on(\'line\', function(line){\n   var tokens = line.split(\' \');\n    console.log(parseInt(tokens[0]) + parseInt(tokens[1]));\n});', NULL, 0, 'ME', 0, '2022-02-25 20:55:30', '2022-09-20 21:43:09');
INSERT INTO `language` VALUES (18, 'text/javascript', 'JavaScript V8 8.4.109', 'JavaScript V8', '/usr/bin/jsv8/d8 {src_path}', 'const [a, b] = readline().split(\' \').map(n => parseInt(n, 10));\nprint((a + b).toString());', NULL, 0, 'ME', 0, '2022-02-25 20:55:30', '2022-09-20 21:43:14');
INSERT INTO `language` VALUES (19, 'text/x-csrc', 'GCC', 'GCC', NULL, NULL, NULL, 0, 'HDU', 0, '2021-02-18 21:32:34', '2022-09-20 21:44:32');
INSERT INTO `language` VALUES (20, 'text/x-c++src', 'G++', 'G++', NULL, NULL, NULL, 0, 'HDU', 0, '2021-02-18 21:32:58', '2022-09-20 21:44:34');
INSERT INTO `language` VALUES (21, 'text/x-c++src', 'C++', 'C++', NULL, NULL, NULL, 0, 'HDU', 0, '2021-02-18 21:33:11', '2022-09-20 21:44:36');
INSERT INTO `language` VALUES (22, 'text/x-csrc', 'C', 'C', NULL, NULL, NULL, 0, 'HDU', 0, '2021-02-18 21:33:41', '2022-09-20 21:44:38');
INSERT INTO `language` VALUES (23, 'text/x-pascal', 'Pascal', 'Pascal', NULL, NULL, NULL, 0, 'HDU', 0, '2021-02-18 21:34:33', '2022-09-20 21:44:41');
INSERT INTO `language` VALUES (24, 'text/x-java', 'Java', 'Java', NULL, NULL, NULL, 0, 'HDU', 0, '2022-09-20 21:25:00', '2022-09-20 21:44:46');
INSERT INTO `language` VALUES (25, 'text/x-csharp', 'C#', 'C#', NULL, NULL, NULL, 0, 'HDU', 0, '2022-09-20 21:25:00', '2022-09-20 21:45:32');
INSERT INTO `language` VALUES (26, 'text/x-csrc', 'GNU GCC C11 5.1.0', 'GNU GCC C11 5.1.0', NULL, NULL, NULL, 0, 'CF', 0, '2021-03-03 19:46:24', '2022-09-20 21:46:04');
INSERT INTO `language` VALUES (27, 'text/x-c++src', 'Clang++17 Diagnostics', 'Clang++17 Diagnostics', NULL, NULL, NULL, 0, 'CF', 0, '2021-03-03 19:46:24', '2022-09-20 21:46:04');
INSERT INTO `language` VALUES (28, 'text/x-c++src', 'GNU G++14 6.4.0', 'GNU G++14 6.4.0', NULL, NULL, NULL, 0, 'CF', 0, '2021-03-03 19:46:24', '2022-09-20 21:46:04');
INSERT INTO `language` VALUES (29, 'text/x-c++src', 'GNU G++17 7.3.0', 'GNU G++17 7.3.0', NULL, NULL, NULL, 0, 'CF', 0, '2021-03-03 19:46:24', '2022-09-20 21:46:04');
INSERT INTO `language` VALUES (30, 'text/x-c++src', 'GNU G++20 11.2.0 (64 bit, winlibs)', 'GNU G++20 11.2.0 (64 bit, winlibs)', NULL, NULL, NULL, 0, 'CF', 0, '2021-03-03 19:46:24', '2022-09-20 21:46:04');
INSERT INTO `language` VALUES (31, 'text/x-c++src', 'Microsoft Visual C++ 2017', 'Microsoft Visual C++ 2017', NULL, NULL, NULL, 0, 'CF', 0, '2021-03-03 19:46:24', '2022-09-20 21:46:04');
INSERT INTO `language` VALUES (32, 'text/x-csharp', 'C# Mono 6.8', 'C# Mono 6.8', NULL, NULL, NULL, 0, 'CF', 0, '2021-03-03 19:46:24', '2022-09-20 21:46:04');
INSERT INTO `language` VALUES (33, 'text/x-d', 'D DMD32 v2.091.0', 'D DMD32 v2.091.0', NULL, NULL, NULL, 0, 'CF', 0, '2021-03-03 19:46:24', '2022-09-20 21:46:04');
INSERT INTO `language` VALUES (34, 'text/x-go', 'Go 1.15.6', 'Go 1.15.6', NULL, NULL, NULL, 0, 'CF', 0, '2021-03-03 19:46:24', '2022-09-20 21:46:04');
INSERT INTO `language` VALUES (35, 'text/x-haskell', 'Haskell GHC 8.10.1', 'Haskell GHC 8.10.1', NULL, NULL, NULL, 0, 'CF', 0, '2021-03-03 19:46:24', '2022-09-20 21:46:04');
INSERT INTO `language` VALUES (36, 'text/x-java', 'Java 1.8.0_241', 'Java 1.8.0_241', NULL, NULL, NULL, 0, 'CF', 0, '2021-03-03 19:46:24', '2022-09-20 21:46:04');
INSERT INTO `language` VALUES (37, 'text/x-java', 'Kotlin 1.4.0', 'Kotlin 1.4.0', NULL, NULL, NULL, 0, 'CF', 0, '2021-03-03 19:46:24', '2022-09-20 21:46:04');
INSERT INTO `language` VALUES (38, 'text/x-ocaml', 'OCaml 4.02.1', 'OCaml 4.02.1', NULL, NULL, NULL, 0, 'CF', 0, '2021-03-03 19:46:24', '2022-09-20 21:46:04');
INSERT INTO `language` VALUES (39, 'text/x-pascal', 'Delphi 7', 'Delphi 7', NULL, NULL, NULL, 0, 'CF', 0, '2021-03-03 19:46:24', '2022-09-20 21:46:04');
INSERT INTO `language` VALUES (40, 'text/x-pascal', 'Free Pascal 3.0.2', 'Free Pascal 3.0.2', NULL, NULL, NULL, 0, 'CF', 0, '2021-03-03 19:46:24', '2022-09-20 21:46:04');
INSERT INTO `language` VALUES (41, 'text/x-pascal', 'PascalABC.NET 3.4.2', 'PascalABC.NET 3.4.2', NULL, NULL, NULL, 0, 'CF', 0, '2021-03-03 19:46:24', '2022-09-20 21:46:04');
INSERT INTO `language` VALUES (42, 'text/x-perl', 'Perl 5.20.1', 'Perl 5.20.1', NULL, NULL, NULL, 0, 'CF', 0, '2021-03-03 19:46:24', '2022-09-20 21:46:04');
INSERT INTO `language` VALUES (43, 'text/x-php', 'PHP 7.2.13', 'PHP 7.2.13', NULL, NULL, NULL, 0, 'CF', 0, '2021-03-03 19:46:24', '2022-09-20 21:46:04');
INSERT INTO `language` VALUES (44, 'text/x-python', 'Python 2.7.18', 'Python 2.7.18', NULL, NULL, NULL, 0, 'CF', 0, '2021-03-03 19:46:24', '2022-09-20 21:46:04');
INSERT INTO `language` VALUES (45, 'text/x-python', 'Python 3.9.1', 'Python 3.9.1', NULL, NULL, NULL, 0, 'CF', 0, '2021-03-03 19:46:24', '2022-09-20 21:46:04');
INSERT INTO `language` VALUES (46, 'text/x-python', 'PyPy 2.7 (7.3.0)', 'PyPy 2.7 (7.3.0)', NULL, NULL, NULL, 0, 'CF', 0, '2021-03-03 19:46:24', '2022-09-20 21:46:04');
INSERT INTO `language` VALUES (47, 'text/x-python', 'PyPy 3.7 (7.3.0)', 'PyPy 3.7 (7.3.0)', NULL, NULL, NULL, 0, 'CF', 0, '2021-03-03 19:46:24', '2022-09-20 21:46:04');
INSERT INTO `language` VALUES (48, 'text/x-ruby', 'Ruby 3.0.0', 'Ruby 3.0.0', NULL, NULL, NULL, 0, 'CF', 0, '2021-03-03 19:46:24', '2022-09-20 21:46:04');
INSERT INTO `language` VALUES (49, 'text/x-rustsrc', 'Rust 1.49.0', 'Rust 1.49.0', NULL, NULL, NULL, 0, 'CF', 0, '2021-03-03 19:46:24', '2022-09-20 21:46:04');
INSERT INTO `language` VALUES (50, 'text/x-scala', 'Scala 2.12.8', 'Scala 2.12.8', NULL, NULL, NULL, 0, 'CF', 0, '2021-03-03 19:46:24', '2022-09-20 21:46:04');
INSERT INTO `language` VALUES (51, 'text/javascript', 'JavaScript V8 4.8.0', 'JavaScript V8 4.8.0', NULL, NULL, NULL, 0, 'CF', 0, '2021-03-03 19:46:24', '2022-09-20 21:46:04');
INSERT INTO `language` VALUES (52, 'text/javascript', 'Node.js 12.6.3', 'Node.js 12.6.3', NULL, NULL, NULL, 0, 'CF', 0, '2021-03-03 19:46:24', '2022-09-20 21:46:04');
INSERT INTO `language` VALUES (53, 'text/x-csharp', 'C# 8, .NET Core 3.1', 'C# 8, .NET Core 3.1', NULL, NULL, NULL, 0, 'CF', 0, '2021-03-25 21:17:39', '2022-09-20 21:46:04');
INSERT INTO `language` VALUES (54, 'text/x-java', 'Java 11.0.6', 'Java 11.0.6', NULL, NULL, NULL, 0, 'CF', 0, '2021-03-25 21:20:03', '2022-09-20 21:46:04');
INSERT INTO `language` VALUES (55, 'text/x-c++src', 'G++', 'G++', NULL, NULL, NULL, 0, 'POJ', 0, '2021-06-24 22:50:50', '2022-09-20 21:46:04');
INSERT INTO `language` VALUES (56, 'text/x-csrc', 'GCC', 'GCC', NULL, NULL, NULL, 0, 'POJ', 0, '2021-06-24 22:51:04', '2022-09-20 21:46:04');
INSERT INTO `language` VALUES (57, 'text/x-java', 'Java', 'Java', NULL, NULL, NULL, 0, 'POJ', 0, '2021-06-24 22:51:29', '2022-09-20 21:46:04');
INSERT INTO `language` VALUES (58, 'text/x-pascal', 'Pascal', 'Pascal', NULL, NULL, NULL, 0, 'POJ', 0, '2021-06-24 22:51:50', '2022-09-20 21:46:04');
INSERT INTO `language` VALUES (59, 'text/x-c++src', 'C++', 'C++', NULL, NULL, NULL, 0, 'POJ', 0, '2021-06-24 22:52:15', '2022-09-20 21:46:04');
INSERT INTO `language` VALUES (60, 'text/x-csrc', 'C', 'C', NULL, NULL, NULL, 0, 'POJ', 0, '2021-06-24 22:52:38', '2022-09-20 21:46:04');
INSERT INTO `language` VALUES (61, 'text/x-fortran', 'Fortran', 'Fortran', NULL, NULL, NULL, 0, 'POJ', 0, '2021-06-24 22:55:15', '2022-09-20 21:46:04');
INSERT INTO `language` VALUES (62, 'text/x-c++src', 'C++14 (gcc 8.3)', 'C++14 (gcc 8.3)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:26', '2023-04-07 02:14:26');
INSERT INTO `language` VALUES (63, 'text/x-csrc', 'Assembler 32 (gcc 8.3)', 'Assembler 32 (gcc 8.3)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:26', '2023-04-07 02:14:26');
INSERT INTO `language` VALUES (64, NULL, 'Sed (sed 4.7)', 'Sed (sed 4.7)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:26', '2023-04-07 02:14:26');
INSERT INTO `language` VALUES (65, NULL, 'Kotlin (kotlin 1.3.21)', 'Kotlin (kotlin 1.3.21)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:26', '2023-04-07 02:14:26');
INSERT INTO `language` VALUES (66, NULL, 'Dart (dart 2.3.0)', 'Dart (dart 2.3.0)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:26', '2023-04-07 02:14:26');
INSERT INTO `language` VALUES (67, 'text/x-csrc', 'BC (bc 1.07.1)', 'BC (bc 1.07.1)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:26', '2023-04-07 02:14:26');
INSERT INTO `language` VALUES (68, 'text/x-csrc', 'Clojure (clojure 1.10.0)', 'Clojure (clojure 1.10.0)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:26', '2023-04-07 02:14:26');
INSERT INTO `language` VALUES (69, 'text/x-csrc', 'JavaScript (SMonkey 60.2.3)', 'JavaScript (SMonkey 60.2.3)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:26', '2023-04-07 02:14:26');
INSERT INTO `language` VALUES (70, 'text/x-go', 'Go (go 1.12.1)', 'Go (go 1.12.1)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:26', '2023-04-07 02:14:26');
INSERT INTO `language` VALUES (71, NULL, 'Unlambda (unlambda 0.1.4.2)', 'Unlambda (unlambda 0.1.4.2)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:26', '2023-04-07 02:14:26');
INSERT INTO `language` VALUES (72, 'text/x-python', 'Python 3 (python  3.7.3)', 'Python 3 (python  3.7.3)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:26', '2023-04-07 02:14:26');
INSERT INTO `language` VALUES (73, NULL, 'R (R 3.5.2)', 'R (R 3.5.2)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:26', '2023-04-07 02:14:26');
INSERT INTO `language` VALUES (74, 'text/x-csrc', 'Cobol (gnucobol 2.2.0)', 'Cobol (gnucobol 2.2.0)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:26', '2023-04-07 02:14:26');
INSERT INTO `language` VALUES (75, 'text/x-csrc', 'CoffeeScript (coffee 2.4.1)', 'CoffeeScript (coffee 2.4.1)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:26', '2023-04-07 02:14:26');
INSERT INTO `language` VALUES (76, NULL, 'Fantom (fantom 1.0.72)', 'Fantom (fantom 1.0.72)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:26', '2023-04-07 02:14:26');
INSERT INTO `language` VALUES (77, 'text/x-rustsrc', 'Rust (rust 1.33.0)', 'Rust (rust 1.33.0)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:26', '2023-04-07 02:14:26');
INSERT INTO `language` VALUES (78, 'text/x-csrc', 'Pico Lisp (pico 18.12.27)', 'Pico Lisp (pico 18.12.27)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:26', '2023-04-07 02:14:26');
INSERT INTO `language` VALUES (79, NULL, 'VB.net (mono 4.7)', 'VB.net (mono 4.7)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:26', '2023-04-07 02:14:26');
INSERT INTO `language` VALUES (80, 'text/x-csrc', 'Racket (racket 7.0)', 'Racket (racket 7.0)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:26', '2023-04-07 02:14:26');
INSERT INTO `language` VALUES (81, NULL, 'Elixir (elixir 1.8.2)', 'Elixir (elixir 1.8.2)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:26', '2023-04-07 02:14:26');
INSERT INTO `language` VALUES (82, 'text/x-csrc', 'Scheme (chicken 4.13)', 'Scheme (chicken 4.13)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:26', '2023-04-07 02:14:26');
INSERT INTO `language` VALUES (83, 'text/x-go', 'Gosu (gosu 1.14.9)', 'Gosu (gosu 1.14.9)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:26', '2023-04-07 02:14:26');
INSERT INTO `language` VALUES (84, 'text/x-java', 'Java (HotSpot 12)', 'Java (HotSpot 12)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:26', '2023-04-07 02:14:26');
INSERT INTO `language` VALUES (85, 'text/x-perl', 'Perl (perl 2018.12)', 'Perl (perl 2018.12)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:26', '2023-04-07 02:14:26');
INSERT INTO `language` VALUES (86, 'text/x-csrc', 'C (gcc 8.3)', 'C (gcc 8.3)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:26', '2023-04-07 02:14:26');
INSERT INTO `language` VALUES (87, 'text/x-python', 'Python (PyPy 2.7.13)', 'Python (PyPy 2.7.13)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:26', '2023-04-07 02:14:26');
INSERT INTO `language` VALUES (88, NULL, 'Brainf**k (bff 1.0.6)', 'Brainf**k (bff 1.0.6)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:26', '2023-04-07 02:14:26');
INSERT INTO `language` VALUES (89, 'text/javascript', 'Node.js (node 11.12.0)', 'Node.js (node 11.12.0)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:26', '2023-04-07 02:14:26');
INSERT INTO `language` VALUES (90, NULL, 'Assembler 32 (nasm 2.14)', 'Assembler 32 (nasm 2.14)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:26', '2023-04-07 02:14:26');
INSERT INTO `language` VALUES (91, 'text/x-csrc', 'Clips (clips 6.30)', 'Clips (clips 6.30)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:26', '2023-04-07 02:14:26');
INSERT INTO `language` VALUES (92, NULL, 'Prolog (swi 7.6.4)', 'Prolog (swi 7.6.4)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:26', '2023-04-07 02:14:26');
INSERT INTO `language` VALUES (93, 'text/x-csrc', 'Icon (iconc 9.5.1)', 'Icon (iconc 9.5.1)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:26', '2023-04-07 02:14:26');
INSERT INTO `language` VALUES (94, 'text/x-ruby', 'Ruby (ruby 2.5.5)', 'Ruby (ruby 2.5.5)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:26', '2023-04-07 02:14:26');
INSERT INTO `language` VALUES (95, 'text/x-csrc', 'Scheme (stalin 0.11)', 'Scheme (stalin 0.11)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (96, NULL, 'Pike (pike 8.0)', 'Pike (pike 8.0)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (97, NULL, 'Groovy (groovy 2.5.6)', 'Groovy (groovy 2.5.6)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (98, 'text/x-c++src', 'C++ (gcc 8.3)', 'C++ (gcc 8.3)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (99, NULL, 'Nim (nim 0.19.4)', 'Nim (nim 0.19.4)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (100, 'text/x-csrc', 'Pascal (gpc 20070904)', 'Pascal (gpc 20070904)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (101, NULL, 'F# (mono 4.1)', 'F# (mono 4.1)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (102, 'text/x-perl', 'Perl (perl 5.28.1)', 'Perl (perl 5.28.1)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (103, 'text/x-csrc', 'Python (cpython 2.7.16)', 'Python (cpython 2.7.16)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (104, 'text/x-fortran', 'Fortran (gfortran 8.3)', 'Fortran (gfortran 8.3)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (105, 'text/x-csrc', 'Python 3 nbc (python 3.7.3)', 'Python 3 nbc (python 3.7.3)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (106, 'text/x-csrc', 'Octave (octave 4.4.1)', 'Octave (octave 4.4.1)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (107, 'text/x-csrc', 'Whitespace (wspace 0.3)', 'Whitespace (wspace 0.3)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (108, NULL, 'Ada95 (gnat 8.3)', 'Ada95 (gnat 8.3)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (109, 'text/x-csrc', 'Ocaml (ocamlopt 4.05.0)', 'Ocaml (ocamlopt 4.05.0)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (110, 'text/x-csrc', 'Intercal (ick 0.3)', 'Intercal (ick 0.3)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (111, NULL, 'Text (plain text)', 'Text (plain text)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (112, 'text/x-csrc', 'D (gdc 8.3)', 'D (gdc 8.3)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (113, 'text/x-csrc', 'Haskell (ghc 8.4.4)', 'Haskell (ghc 8.4.4)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (114, 'text/x-csrc', 'Pascal (fpc 3.0.4)', 'Pascal (fpc 3.0.4)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (115, NULL, 'Smalltalk (gst 3.2.5)', 'Smalltalk (gst 3.2.5)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (116, 'text/x-java', 'JAR (JavaSE 6)', 'JAR (JavaSE 6)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (117, 'text/x-csrc', 'Nice (nicec 0.9.13)', 'Nice (nicec 0.9.13)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (118, 'text/x-csrc', 'Lua (luac 5.3.3)', 'Lua (luac 5.3.3)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (119, 'text/x-csharp', 'C# (gmcs 5.20.1)', 'C# (gmcs 5.20.1)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (120, NULL, 'Bash (bash 5.0.3)', 'Bash (bash 5.0.3)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (121, 'text/x-php', 'PHP (php 7.3.5)', 'PHP (php 7.3.5)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (122, 'text/x-csrc', 'Nemerle (ncc 1.2.547)', 'Nemerle (ncc 1.2.547)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (123, 'text/x-csrc', 'Common Lisp (sbcl 1.4.16)', 'Common Lisp (sbcl 1.4.16)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (124, 'text/x-csrc', 'Common Lisp (clisp 2.49.92)', 'Common Lisp (clisp 2.49.92)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (125, 'text/x-csrc', 'Scheme (guile 2.2.4)', 'Scheme (guile 2.2.4)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (126, 'text/x-csrc', 'C99 (gcc 8.3)', 'C99 (gcc 8.3)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (127, 'text/x-csrc', 'JavaScript (rhino 1.7.9)', 'JavaScript (rhino 1.7.9)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (128, NULL, 'Erlang (erl 21.3.8)', 'Erlang (erl 21.3.8)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (129, 'text/x-csrc', 'TCL (tcl 8.6)', 'TCL (tcl 8.6)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (130, 'text/x-csrc', 'Scala (scala 2.12.8)', 'Scala (scala 2.12.8)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (131, NULL, 'D (dmd 2.085.0)', 'D (dmd 2.085.0)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (132, NULL, 'AWK (gawk 4.2.1)', 'AWK (gawk 4.2.1)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (133, NULL, 'AWK (mawk 1.3.3)', 'AWK (mawk 1.3.3)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (134, NULL, 'Forth (gforth 0.7.3)', 'Forth (gforth 0.7.3)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (135, 'text/x-csrc', 'C (clang 8.0)', 'C (clang 8.0)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (136, NULL, 'Prolog (gprolog 1.4.5)', 'Prolog (gprolog 1.4.5)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (137, 'text/x-c++src', 'C++14 (clang 8.0)', 'C++14 (clang 8.0)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (138, 'text/x-csrc', 'Objective-C (clang 8.0)', 'Objective-C (clang 8.0)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (139, 'text/x-csrc', 'D (ldc 1.12.0)', 'D (ldc 1.12.0)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (140, NULL, 'SQLite (sqlite 3.27.2)', 'SQLite (sqlite 3.27.2)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (141, 'text/x-c++src', 'C++ (g++ 4.3.2)', 'C++ (g++ 4.3.2)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (142, NULL, 'Swift (swift 4.2.2)', 'Swift (swift 4.2.2)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (143, NULL, 'Assembler 64 (nasm 2.14)', 'Assembler 64 (nasm 2.14)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (144, 'text/x-csrc', 'Objective-C (gcc 8.3)', 'Objective-C (gcc 8.3)', NULL, NULL, NULL, 0, 'SPOJ', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (145, 'text/x-scheme', 'Scheme (Gauche 0.9.9)', 'Scheme (Gauche 0.9.9)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (146, 'text/x-nim', 'Nim (1.0.6)', 'Nim (1.0.6)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (147, 'text/x-cobol', 'COBOL - Free (OpenCOBOL 1.1.0)', 'COBOL - Free (OpenCOBOL 1.1.0)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (148, 'text/x-python', 'PyPy3 (7.3.0)', 'PyPy3 (7.3.0)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (149, 'text/x-ada', 'Ada2012 (GNAT 9.2.1)', 'Ada2012 (GNAT 9.2.1)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (150, 'text/x-scala', 'Scala (2.13.1)', 'Scala (2.13.1)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (151, 'text/x-d', 'D (DMD 2.091.0)', 'D (DMD 2.091.0)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (152, 'text/x-rustsrc', 'Rust (1.42.0)', 'Rust (1.42.0)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (153, 'application/dart', 'Dart (2.7.2)', 'Dart (2.7.2)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (154, 'text/x-csrc', 'C (GCC 9.2.1)', 'C (GCC 9.2.1)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (155, 'text/x-java', 'Java (OpenJDK 1.8.0)', 'Java (OpenJDK 1.8.0)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (156, 'text/x-ruby', 'Ruby (2.7.1)', 'Ruby (2.7.1)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (157, 'text/x-racket', 'Racket (7.6)', 'Racket (7.6)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (158, 'text/x-objectivec', 'Objective-C (Clang 10.0.0)', 'Objective-C (Clang 10.0.0)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (159, 'text/x-haxe', 'Haxe (4.0.3); js', 'Haxe (4.0.3); js', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (160, 'text/x-kotlin', 'Kotlin (1.3.71)', 'Kotlin (1.3.71)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (161, 'text/x-sh', 'Bash (5.0.11)', 'Bash (5.0.11)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (162, 'text/x-python', 'Python (3.8.2)', 'Python (3.8.2)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (163, 'text/x-lua', 'Lua (Lua 5.3.5)', 'Lua (Lua 5.3.5)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (164, 'text/x-julia', 'Julia (1.4.0)', 'Julia (1.4.0)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (165, 'text/x-c++src', 'C++ (Clang 10.0.0)', 'C++ (Clang 10.0.0)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (166, 'text/x-crystal', 'Crystal (0.33.0)', 'Crystal (0.33.0)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (167, 'text/x-csharp', 'C# (.NET Core 3.1.201)', 'C# (.NET Core 3.1.201)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (168, 'text/x-sh', 'Awk (GNU Awk 4.1.4)', 'Awk (GNU Awk 4.1.4)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (169, 'text/x-haskell', 'Haskell (GHC 8.8.3)', 'Haskell (GHC 8.8.3)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (170, 'text/x-c++src', 'C++ (GCC 9.2.1)', 'C++ (GCC 9.2.1)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (171, 'elixir', 'Elixir (1.10.2)', 'Elixir (1.10.2)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (172, 'text/x-csharp', 'C# (Mono-mcs 6.8.0.105)', 'C# (Mono-mcs 6.8.0.105)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (173, 'text/x-unlambda', 'Unlambda (2.0.0)', 'Unlambda (2.0.0)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (174, 'text/x-dc', 'dc (1.4.1)', 'dc (1.4.1)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (175, 'text/x-haxe', 'Haxe (4.0.3); Java', 'Haxe (4.0.3); Java', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (176, 'text/x-csrc', 'C (Clang 10.0.0)', 'C (Clang 10.0.0)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (177, 'text/x-swift', 'Swift (5.2.1)', 'Swift (5.2.1)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (178, 'text/x-php', 'PHP (7.4.4)', 'PHP (7.4.4)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (179, 'text/x-erlang', 'Erlang (22.3)', 'Erlang (22.3)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (180, 'text/x-pascal', 'Pascal (FPC 3.0.4)', 'Pascal (FPC 3.0.4)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (181, 'text/typescript', 'TypeScript (3.8)', 'TypeScript (3.8)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (182, 'text/x-d', 'D (LDC 1.20.1)', 'D (LDC 1.20.1)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (183, 'text/x-forth', 'Forth (gforth 0.7.3)', 'Forth (gforth 0.7.3)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (184, 'text/x-python', 'Cython (0.29.16)', 'Cython (0.29.16)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (185, 'text/x-bc', 'bc (1.07.1)', 'bc (1.07.1)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (186, 'text/x-common-lisp', 'Common Lisp (SBCL 2.0.3)', 'Common Lisp (SBCL 2.0.3)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (187, 'text/x-sh', 'Dash (0.5.8)', 'Dash (0.5.8)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (188, 'text/x-perl', 'Perl (5.26.1)', 'Perl (5.26.1)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (189, 'text/x-ocaml', 'OCaml (4.10.0)', 'OCaml (4.10.0)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (190, 'text/x-prolog', 'Prolog (SWI-Prolog 8.0.3)', 'Prolog (SWI-Prolog 8.0.3)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (191, 'text/x-sml', 'Standard ML (MLton 20130715)', 'Standard ML (MLton 20130715)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (192, 'text/x-csharp', 'C# (Mono-csc 3.5.0)', 'C# (Mono-csc 3.5.0)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (193, 'text/javascript', 'JavaScript (Node.js 12.16.1)', 'JavaScript (Node.js 12.16.1)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (194, 'text/x-fsharp', 'F# (.NET Core 3.1.201)', 'F# (.NET Core 3.1.201)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (195, 'text/x-python', 'PyPy2 (7.3.0)', 'PyPy2 (7.3.0)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (196, 'text/x-vb', 'Visual Basic (.NET Core 3.1.101)', 'Visual Basic (.NET Core 3.1.101)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (197, 'text/x-sh', 'Zsh (5.4.2)', 'Zsh (5.4.2)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (198, 'text/x-vim', 'Vim (8.2.0460)', 'Vim (8.2.0460)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (199, 'text/x-fortran', 'Fortran (GNU Fortran 9.2.1)', 'Fortran (GNU Fortran 9.2.1)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (200, 'text/x-perl', 'Raku (Rakudo 2020.02.1)', 'Raku (Rakudo 2020.02.1)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (201, 'text/x-clojure', 'Clojure (1.10.1.536)', 'Clojure (1.10.1.536)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (202, 'text/x-octave', 'Octave (5.2.0)', 'Octave (5.2.0)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (203, 'text/x-d', 'D (GDC 9.2.1)', 'D (GDC 9.2.1)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (204, 'text/x-go', 'Go (1.14.1)', 'Go (1.14.1)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (205, 'text/x-fsharp', 'F# (Mono 10.2.3)', 'F# (Mono 10.2.3)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (206, 'text/plain', 'Text (cat 8.28)', 'Text (cat 8.28)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (207, 'text/x-sh', 'Sed (4.4)', 'Sed (4.4)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (208, 'text/x-lua', 'Lua (LuaJIT 2.1.0)', 'Lua (LuaJIT 2.1.0)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (209, 'text/x-cobol', 'COBOL - Fixed (OpenCOBOL 1.1.0)', 'COBOL - Fixed (OpenCOBOL 1.1.0)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (210, 'text/x-brainfuck', 'Brainfuck (bf 20041219)', 'Brainfuck (bf 20041219)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');
INSERT INTO `language` VALUES (211, 'text/x-java', 'Java (OpenJDK 11.0.6)', 'Java (OpenJDK 11.0.6)', NULL, NULL, NULL, 0, 'AC', 0, '2023-04-07 02:14:27', '2023-04-07 02:14:27');

-- ----------------------------
-- Table structure for mapping_training_category
-- ----------------------------
DROP TABLE IF EXISTS `mapping_training_category`;
CREATE TABLE `mapping_training_category`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `tid` bigint(0) UNSIGNED NOT NULL,
  `cid` bigint(0) UNSIGNED NOT NULL,
  `gmt_create` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `gmt_modified` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `tid`(`tid`) USING BTREE,
  INDEX `cid`(`cid`) USING BTREE,
  CONSTRAINT `mapping_training_category_ibfk_1` FOREIGN KEY (`tid`) REFERENCES `training` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `mapping_training_category_ibfk_2` FOREIGN KEY (`cid`) REFERENCES `training_category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mapping_training_category
-- ----------------------------
INSERT INTO `mapping_training_category` VALUES (1, 1, 1, '2023-05-16 21:40:56', '2023-05-16 21:40:56');

-- ----------------------------
-- Table structure for msg_remind
-- ----------------------------
DROP TABLE IF EXISTS `msg_remind`;
CREATE TABLE `msg_remind`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `action` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '动作类型，如点赞讨论帖Like_Post、点赞评论Like_Discuss、评论Discuss、回复Reply等',
  `source_id` int(0) UNSIGNED NULL DEFAULT NULL COMMENT '消息来源id，讨论id或比赛id',
  `source_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '事件源类型：\'Discussion\'、\'Contest\'等',
  `source_content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `quote_id` int(0) UNSIGNED NULL DEFAULT NULL COMMENT '事件引用上一级评论或回复id',
  `quote_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '事件引用上一级的类型：Comment、Reply',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '事件所发生的地点链接 url',
  `state` tinyint(1) NULL DEFAULT 0 COMMENT '是否已读',
  `sender_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作者的id',
  `recipient_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '接受消息的用户id',
  `gmt_create` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sender_id`(`sender_id`) USING BTREE,
  INDEX `recipient_id`(`recipient_id`) USING BTREE,
  CONSTRAINT `msg_remind_ibfk_1` FOREIGN KEY (`sender_id`) REFERENCES `user_info` (`uuid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `msg_remind_ibfk_2` FOREIGN KEY (`recipient_id`) REFERENCES `user_info` (`uuid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for problem
-- ----------------------------
DROP TABLE IF EXISTS `problem`;
CREATE TABLE `problem`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `problem_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '问题的自定义ID 例如（HOJ-1000）',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `author` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '未知' COMMENT '作者',
  `type` int(0) NOT NULL DEFAULT 0 COMMENT '0为ACM,1为OI',
  `time_limit` int(0) NULL DEFAULT 1000 COMMENT '单位ms',
  `memory_limit` int(0) NULL DEFAULT 65535 COMMENT '单位kb',
  `stack_limit` int(0) NULL DEFAULT 128 COMMENT '单位mb',
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `input` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `output` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `examples` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '题面样例',
  `is_remote` tinyint(1) NULL DEFAULT 0 COMMENT '是否为vj判题',
  `source` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `difficulty` int(0) NULL DEFAULT 0 COMMENT '题目难度,0简单，1中等，2困难',
  `hint` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `auth` int(0) NULL DEFAULT 1 COMMENT '默认为1公开，2为私有，3为比赛题目',
  `io_score` int(0) NULL DEFAULT 100 COMMENT '当该题目为io题目时的分数',
  `code_share` tinyint(1) NULL DEFAULT 1 COMMENT '该题目对应的相关提交代码，用户是否可用分享',
  `judge_mode` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'default' COMMENT '题目评测模式,default、spj、interactive',
  `judge_case_mode` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'default' COMMENT '题目样例评测模式,default,subtask_lowest,subtask_average',
  `user_extra_file` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '题目评测时用户程序的额外文件 json key:name value:content',
  `judge_extra_file` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '题目评测时交互或特殊程序的额外文件 json key:name value:content',
  `spj_code` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `spj_language` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '特判程序或交互程序代码的语言',
  `is_remove_end_blank` tinyint(1) NULL DEFAULT 1 COMMENT '是否默认去除用户代码的文末空格',
  `open_case_result` tinyint(1) NULL DEFAULT 1 COMMENT '是否默认开启该题目的测试样例结果查看',
  `is_upload_case` tinyint(1) NULL DEFAULT 1 COMMENT '题目测试数据是否是上传文件的',
  `case_version` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '题目测试数据的版本号',
  `modified_user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改题目的管理员用户名',
  `is_group` tinyint(1) NULL DEFAULT 0,
  `gid` bigint(0) UNSIGNED NULL DEFAULT NULL,
  `apply_public_progress` int(0) NULL DEFAULT NULL COMMENT '申请公开的进度：null为未申请，1为申请中，2为申请通过，3为申请拒绝',
  `gmt_create` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `gmt_modified` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `author`(`author`) USING BTREE,
  INDEX `problem_id`(`problem_id`) USING BTREE,
  INDEX `problem_ibfk_2`(`gid`) USING BTREE,
  CONSTRAINT `problem_ibfk_1` FOREIGN KEY (`author`) REFERENCES `user_info` (`username`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `problem_ibfk_2` FOREIGN KEY (`gid`) REFERENCES `group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1013 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of problem
-- ----------------------------
INSERT INTO `problem` VALUES (1000, 'HDU-1001', 'Sum Problem', 'root', 0, 500, 32, 128, 'Hey, welcome to HDOJ(Hangzhou Dianzi University Online Judge).<br><br>In this problem, your task is to calculate SUM(n) = 1 + 2 + 3 + ... + n.<br>', 'The input will consist of a series of integers n, one integer per line.<br>', 'For each case, output SUM(n) in one line, followed by a blank line. You may assume the result will be in the range of 32-bit signed integer.<br>', '<input>1\r\n100\r\n</input><output>1\r\n\r\n5050\r\n\r\n</output>', 1, '<a style=\'color:#1A5CC8\' href=\'https://acm.hdu.edu.cn/showproblem.php?pid=1001\'>HDU-1001</a>', 1, NULL, 3, 100, 1, 'default', 'default', NULL, NULL, NULL, NULL, 0, 0, 1, '0', NULL, 0, NULL, NULL, '2023-04-25 21:48:22', '2023-05-17 22:50:14');
INSERT INTO `problem` VALUES (1006, 'CF-CF1A', 'Theatre Square', 'root', 0, 1000, 256, 128, '<p>Theatre Square in the capital city of Berland has a rectangular shape with the size <span class=\"tex-span\"><i>n</i> × <i>m</i></span> meters. On the occasion of the city\'s anniversary, a decision was taken to pave the Square with square granite flagstones. Each flagstone is of the size <span class=\"tex-span\"><i>a</i> × <i>a</i></span>.</p><p>What is the least number of flagstones needed to pave the Square? It\'s allowed to cover the surface larger than the Theatre Square, but the Square has to be covered. It\'s not allowed to break the flagstones. The sides of flagstones should be parallel to the sides of the Square.</p>', '<p>The input contains three positive integer numbers in the first line: <span class=\"tex-span\"><i>n</i>,  <i>m</i></span> and <span class=\"tex-span\"><i>a</i></span> (<span class=\"tex-span\">1 ≤  <i>n</i>, <i>m</i>, <i>a</i> ≤ 10<sup class=\"upper-index\">9</sup></span>).</p>', '<p>Write the needed number of flagstones.</p>', '<input>6 6 4</input><output>4</output>', 1, '<p>Problem：<a style=\'color:#1A5CC8\' href=\'https://codeforces.com/problemset/problem/1/A\'>CF-CF1A</a></p><p>Contest：<a style=\"color: #009688;\" href=\"https://codeforces.com/contest/1\">Codeforces Beta Round 1</a></p>', 1, NULL, 1, 100, 1, 'default', 'default', NULL, NULL, NULL, NULL, 0, 1, 1, '0', NULL, 0, NULL, NULL, '2023-04-27 23:43:34', '2023-04-27 23:43:34');
INSERT INTO `problem` VALUES (1007, 'POJ-1000', 'A+B Problem', 'root', 0, 1000, 9, 128, 'Calculate a+b ', 'Two integer a,b (0&lt;=a,b&lt;=10)', 'Output a+b', '<input>1 2</input><output>3</output>', 1, '<a style=\'color:#1A5CC8\' href=\'http://poj.org/problem?id=1000\'>POJ-1000</a>', 1, 'Q: Where are the input and the output?\r\n\r\nA: Your program shall always <font color=\"red\">read input from stdin (Standard Input) and write output to stdout (Standard Output)</font>. For example, you can use \'scanf\' in C or \'cin\' in C++ to read from stdin, and use \'printf\' in C or \'cout\' in C++ to write to stdout.\r\n\r\nYou <font color=\"red\">shall not output any extra data</font> to standard output other than that required by the problem, otherwise you will get a \"Wrong Answer\".\r\n\r\nUser programs are not allowed to open and read from/write to files. You will get a \"Runtime Error\" or a \"Wrong Answer\"if you try to do so. \r\n\r\nHere is a sample solution to problem 1000 using C++/G++:\r\n<pre>#include &lt;iostream&gt;\n\nusing namespace std;\n\nint main()\n{\n    int a,b;\n    cin &gt;&gt; a &gt;&gt; b;\n    cout &lt;&lt; a+b &lt;&lt; endl;\n    return 0;\n}</pre>It\'s important that the return type of main() must be int when you use G++/GCC,or you may get compile error.\r\n\r\nHere is a sample solution to problem 1000 using C/GCC:\r\n<pre>#include &lt;stdio.h&gt;\n\nint main()\n{\n    int a,b;\n    scanf(\"%d %d\",&amp;a, &amp;b);\n    printf(\"%d\\n\",a+b);\n    return 0;\n}</pre>Here is a sample solution to problem 1000 using Pascal:\r\n<pre>program p1000(Input,Output);\n\nvar\n  a,b:Integer;\nbegin\n   Readln(a,b);\n   Writeln(a+b);\nend.</pre>Here is a sample solution to problem 1000 using Java:\r\n\r\nNow java compiler is jdk 1.5, next is program for 1000\r\n<pre>import java.io.*;\nimport java.util.*;\npublic class Main\n{\n            public static void main(String args[]) throws Exception\n            {\n                    Scanner cin=new Scanner(System.in);\n                    int a=cin.nextInt(),b=cin.nextInt();\n                    System.out.println(a+b);\n            }\n}</pre>Old program for jdk 1.4\r\n<pre>import java.io.*;\nimport java.util.*;\n\npublic class Main\n{\n    public static void main (String args[]) throws Exception\n    {\n        BufferedReader stdin = \n            new BufferedReader(\n                new InputStreamReader(System.in));\n\n        String line = stdin.readLine();\n        StringTokenizer st = new StringTokenizer(line);\n        int a = Integer.parseInt(st.nextToken());\n        int b = Integer.parseInt(st.nextToken());\n        System.out.println(a+b);\n    }\n}</pre>Here is a sample solution to problem 1000 using Fortran:\r\n<pre>	PROGRAM P1000\n		IMPLICIT NONE\n		INTEGER :: A, B\n		READ(*,*) A, B\n		WRITE(*, \"(I0)\") A + B\n	END PROGRAM P1000</pre>', 3, 100, 1, 'default', 'default', NULL, NULL, NULL, NULL, 0, 0, 1, '0', NULL, 0, NULL, NULL, '2023-04-29 11:37:57', '2023-05-17 22:50:17');
INSERT INTO `problem` VALUES (1008, 'AC-abc001_2', '視程の通報', 'root', 0, 2000, 64, 128, '<div class=\"part\"> \n <h4>注意</h4> \n <p><b>この問題は古い問題です。過去問練習をする場合は、新しいAtCoder Beginner Contestから取り組むことをお勧めしています。</b></p> \n <h3>問題文</h3> \n <section>\n   気象情報は、世界中に様々な形で流れています。そのひとつの地上実況気象通報式 (SYNOP) では、視程 (肉眼で物体がはっきりと確認できる最大の距離) を、次の規則に従って、VVという値 (通報式) に変換して報じます。 \n  <ol> \n   <li>$0.1{\\rm km}$ 未満： VVの値は $00$ とする。</li> \n   <li>$0.1{\\rm km}$ 以上 $5{\\rm km}$ 以下：距離 $({\\rm km})$ を $10$ 倍した値とする。$1$ 桁の場合は上位に $0$ を付す。</li> \n   <ul> \n    <li>例えば、$2,000{\\rm m}$ $=2.0{\\rm km}$ ならば、VVは $20$ である。同じく、$200{\\rm m}$の場合VVは $02$ である。</li> \n   </ul> \n   <li>$6{\\rm km}$ 以上 $30{\\rm km}$ 以下：距離 $({\\rm km})$ に $50$ を足した値とする。</li> \n   <ul> \n    <li>例えば、$15,000{\\rm m}$ $=15{\\rm km}$ ならば、VVは $65$ である。</li> \n   </ul> \n   <li>$35{\\rm km}$ 以上 $70{\\rm km}$ 以下：距離 $({\\rm km})$ から $30$ を引いて $5$ で割った後、$80$ を足した値とする。</li> \n   <ul> \n    <li>例えば、$40,000{\\rm m}$ $=40{\\rm km}$ ならば、VVは $82$ である。</li> \n   </ul> \n   <li>$70{\\rm km}$ より大きい：VVの値は $89$ とする。</li> \n  </ol> いま、あなたに視程の距離をメートルで与えるので、上記のルールに従って計算されるVVを出力するプログラムを作成してください。\n  <br> \n  <br> なお、VVは必ず（上位の $0$ を含めて）$2$桁の整数であり、上記のルールに従って計算した時に整数にならないような入力や、上記の範囲に入らない入力 (例：$5{\\rm km}$ より大きく $6{\\rm km}$ 未満) などはありません。 \n </section> \n</div> \n \n<div class=\"io-style\"> \n <div class=\"part\"> \n  <h3>入力</h3> \n  <section>\n    入力は以下の形式で標準入力から与えられる。 \n   <pre style=\"padding:9px!important;background-color: #f5f5f5!important\">\r\n$m$\r\n</pre> \n   <ol> \n    <li>$1$ 行目には、距離を表す整数 $m\\ (0≦m≦100,000)$ が与えられる。単位はメートル $({\\rm m})$ である。</li> \n   </ol> \n  </section> \n </div> \n <div class=\"part\"> \n  <h3>出力</h3> \n  <section>\n    VVの値を $1$ 行で出力せよ。\n   <br> また、出力の末尾には改行を入れること。 \n  </section> \n </div> \n</div> \n \n<div class=\"part\"> \n <h3>入力例 1</h3> \n <section> \n  <pre class=\"prettyprint linenums\">\r\n15000\r\n</pre> \n </section> \n</div> \n<div class=\"part\"> \n <h3>出力例 1</h3> \n <section> \n  <pre class=\"prettyprint linenums\">\r\n65\r\n</pre> \n  <ul> \n   <li>入力は$15,000{\\rm m}$ $=15{\\rm km}$ であり、$6{\\rm km}$ 以上 $30{\\rm km}$ 以下なので、「${\\rm km}$ での値に $50$ を足してVVとする。」というルールに従う。</li> \n   <li>そのため、$15+50=65$が正解である。</li> \n  </ul> \n </section> \n</div> \n \n<div class=\"part\"> \n <h3>入力例 2</h3> \n <section> \n  <pre class=\"prettyprint linenums\">\r\n75000\r\n</pre> \n </section> \n</div> \n<div class=\"part\"> \n <h3>出力例 2</h3> \n <section> \n  <pre class=\"prettyprint linenums\">\r\n89\r\n</pre> \n  <ul> \n   <li>$70{\\rm km}$ より大きい場合は、VVは $89$ である。</li> \n  </ul> \n </section> \n</div> \n \n<div class=\"part\"> \n <h3>入力例 3</h3> \n <section> \n  <pre class=\"prettyprint linenums\">\r\n200\r\n</pre> \n </section> \n</div> \n<div class=\"part\"> \n <h3>出力例 3</h3> \n <section> \n  <pre class=\"prettyprint linenums\">\r\n02\r\n</pre> \n  <ul> \n   <li>VVは $2$ 桁でなければならない。</li> \n  </ul> \n </section> \n</div>', NULL, NULL, NULL, 1, '<a style=\'color:#1A5CC8\' href=\'https://atcoder.jp/contests/abc001/tasks/abc001_2\'>AtCoder-abc001_2</a>', 1, NULL, 1, 100, 1, 'default', 'default', NULL, NULL, NULL, NULL, 0, 0, 1, '0', NULL, 0, NULL, NULL, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem` VALUES (1009, 'CF-CF1721B', 'Deadly Laser', 'root', 0, 2000, 256, 128, '<p>The robot is placed in the top left corner of a grid, consisting of $n$ rows and $m$ columns, in a cell $(1, 1)$.</p><p>In one step, it can move into a cell, adjacent by a side to the current one: </p><ul> <li> $(x, y) \\rightarrow (x, y + 1)$; </li><li> $(x, y) \\rightarrow (x + 1, y)$; </li><li> $(x, y) \\rightarrow (x, y - 1)$; </li><li> $(x, y) \\rightarrow (x - 1, y)$. </li></ul><p>The robot can\'t move outside the grid.</p><p>The cell $(s_x, s_y)$ contains a deadly laser. If the robot comes into some cell that has distance less than or equal to $d$ to the laser, it gets evaporated. The distance between two cells $(x_1, y_1)$ and $(x_2, y_2)$ is $|x_1 - x_2| + |y_1 - y_2|$.</p><p>Print the smallest number of steps that the robot can take to reach the cell $(n, m)$ without getting evaporated or moving outside the grid. If it\'s not possible to reach the cell $(n, m)$, print <span class=\"tex-font-style-tt\">-1</span>.</p><p>The laser is neither in the starting cell, nor in the ending cell. The starting cell always has distance greater than $d$ to the laser.</p>', '<p>The first line contains a single integer $t$ ($1 \\le t \\le 10^4$) — the number of testcases.</p><p>The only line of each testcase contains five integers $n, m, s_x, s_y, d$ ($2 \\le n, m \\le 1000$; $1 \\le s_x \\le n$; $1 \\le s_y \\le m$; $0 \\le d \\le n + m$) — the size of the grid, the cell that contains the laser and the evaporating distance of the laser.</p><p>The laser is neither in the starting cell, nor in the ending cell ($(s_x, s_y) \\neq (1, 1)$ and $(s_x, s_y) \\neq (n, m)$). The starting cell $(1, 1)$ always has distance greater than $d$ to the laser ($|s_x - 1| + |s_y - 1| &gt; d$).</p>', '<p>For each testcase, print a single integer. If it\'s possible to reach the cell $(n, m)$ from $(1, 1)$ without getting evaporated or moving outside the grid, then print the smallest amount of steps it can take the robot to reach it. Otherwise, print <span class=\"tex-font-style-tt\">-1</span>.</p>', '<input>3\n2 3 1 3 0\n2 3 1 3 1\n5 5 3 4 1</input><output>3\n-1\n8</output>', 1, '<p>Problem：<a style=\'color:#1A5CC8\' href=\'https://codeforces.com/problemset/problem/1721/B\'>CF-CF1721B</a></p><p>Contest：<a style=\"color: #009688;\" href=\"https://codeforces.com/contest/1721\">Educational Codeforces Round 134 (Rated for Div. 2)</a></p>', 1, NULL, 3, 100, 1, 'default', 'default', NULL, NULL, NULL, NULL, 0, 1, 1, '0', NULL, 0, NULL, NULL, '2023-05-01 00:03:16', '2023-05-17 22:50:19');
INSERT INTO `problem` VALUES (1013, '1111', 'test', 'root', 0, 1000, 256, 128, 'test', 'test', 'test', '<input>test</input><output>test</output>', 0, 'qwq', 0, 'test', 3, 100, 1, 'default', 'default', NULL, NULL, NULL, NULL, 1, 1, 0, '1684155713960', 'root', 0, NULL, NULL, '2023-05-06 21:48:04', '2023-05-17 23:30:15');

-- ----------------------------
-- Table structure for problem_case
-- ----------------------------
DROP TABLE IF EXISTS `problem_case`;
CREATE TABLE `problem_case`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `pid` bigint(0) UNSIGNED NOT NULL COMMENT '题目id',
  `input` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '测试样例的输入',
  `output` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '测试样例的输出',
  `score` int(0) NULL DEFAULT NULL COMMENT '该测试样例的IO得分',
  `status` int(0) NULL DEFAULT 0 COMMENT '0可用，1不可用',
  `group_num` int(0) NULL DEFAULT 1 COMMENT 'subtask分组的编号',
  `gmt_create` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `gmt_modified` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE,
  CONSTRAINT `problem_case_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `problem` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of problem_case
-- ----------------------------
INSERT INTO `problem_case` VALUES (19, 1013, 'test', 'test', NULL, 0, 1, '2023-05-06 21:48:04', '2023-05-06 21:48:04');

-- ----------------------------
-- Table structure for problem_language
-- ----------------------------
DROP TABLE IF EXISTS `problem_language`;
CREATE TABLE `problem_language`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pid` bigint(0) UNSIGNED NOT NULL,
  `lid` bigint(0) UNSIGNED NOT NULL,
  `gmt_create` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `gmt_modified` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE,
  INDEX `lid`(`lid`) USING BTREE,
  CONSTRAINT `problem_language_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `problem` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `problem_language_ibfk_2` FOREIGN KEY (`lid`) REFERENCES `language` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 301 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of problem_language
-- ----------------------------
INSERT INTO `problem_language` VALUES (1, 1000, 19, '2023-04-25 21:48:22', '2023-04-25 21:48:22');
INSERT INTO `problem_language` VALUES (2, 1000, 20, '2023-04-25 21:48:22', '2023-04-25 21:48:22');
INSERT INTO `problem_language` VALUES (3, 1000, 21, '2023-04-25 21:48:22', '2023-04-25 21:48:22');
INSERT INTO `problem_language` VALUES (4, 1000, 22, '2023-04-25 21:48:22', '2023-04-25 21:48:22');
INSERT INTO `problem_language` VALUES (5, 1000, 23, '2023-04-25 21:48:22', '2023-04-25 21:48:22');
INSERT INTO `problem_language` VALUES (6, 1000, 24, '2023-04-25 21:48:22', '2023-04-25 21:48:22');
INSERT INTO `problem_language` VALUES (7, 1000, 25, '2023-04-25 21:48:22', '2023-04-25 21:48:22');
INSERT INTO `problem_language` VALUES (98, 1006, 26, '2023-04-27 23:43:34', '2023-04-27 23:43:34');
INSERT INTO `problem_language` VALUES (99, 1006, 27, '2023-04-27 23:43:34', '2023-04-27 23:43:34');
INSERT INTO `problem_language` VALUES (100, 1006, 28, '2023-04-27 23:43:34', '2023-04-27 23:43:34');
INSERT INTO `problem_language` VALUES (101, 1006, 29, '2023-04-27 23:43:34', '2023-04-27 23:43:34');
INSERT INTO `problem_language` VALUES (102, 1006, 30, '2023-04-27 23:43:34', '2023-04-27 23:43:34');
INSERT INTO `problem_language` VALUES (103, 1006, 31, '2023-04-27 23:43:34', '2023-04-27 23:43:34');
INSERT INTO `problem_language` VALUES (104, 1006, 32, '2023-04-27 23:43:34', '2023-04-27 23:43:34');
INSERT INTO `problem_language` VALUES (105, 1006, 33, '2023-04-27 23:43:34', '2023-04-27 23:43:34');
INSERT INTO `problem_language` VALUES (106, 1006, 34, '2023-04-27 23:43:34', '2023-04-27 23:43:34');
INSERT INTO `problem_language` VALUES (107, 1006, 35, '2023-04-27 23:43:34', '2023-04-27 23:43:34');
INSERT INTO `problem_language` VALUES (108, 1006, 36, '2023-04-27 23:43:34', '2023-04-27 23:43:34');
INSERT INTO `problem_language` VALUES (109, 1006, 37, '2023-04-27 23:43:34', '2023-04-27 23:43:34');
INSERT INTO `problem_language` VALUES (110, 1006, 38, '2023-04-27 23:43:34', '2023-04-27 23:43:34');
INSERT INTO `problem_language` VALUES (111, 1006, 39, '2023-04-27 23:43:34', '2023-04-27 23:43:34');
INSERT INTO `problem_language` VALUES (112, 1006, 40, '2023-04-27 23:43:34', '2023-04-27 23:43:34');
INSERT INTO `problem_language` VALUES (113, 1006, 41, '2023-04-27 23:43:34', '2023-04-27 23:43:34');
INSERT INTO `problem_language` VALUES (114, 1006, 42, '2023-04-27 23:43:34', '2023-04-27 23:43:34');
INSERT INTO `problem_language` VALUES (115, 1006, 43, '2023-04-27 23:43:34', '2023-04-27 23:43:34');
INSERT INTO `problem_language` VALUES (116, 1006, 44, '2023-04-27 23:43:34', '2023-04-27 23:43:34');
INSERT INTO `problem_language` VALUES (117, 1006, 45, '2023-04-27 23:43:34', '2023-04-27 23:43:34');
INSERT INTO `problem_language` VALUES (118, 1006, 46, '2023-04-27 23:43:34', '2023-04-27 23:43:34');
INSERT INTO `problem_language` VALUES (119, 1006, 47, '2023-04-27 23:43:34', '2023-04-27 23:43:34');
INSERT INTO `problem_language` VALUES (120, 1006, 48, '2023-04-27 23:43:34', '2023-04-27 23:43:34');
INSERT INTO `problem_language` VALUES (121, 1006, 49, '2023-04-27 23:43:34', '2023-04-27 23:43:34');
INSERT INTO `problem_language` VALUES (122, 1006, 50, '2023-04-27 23:43:34', '2023-04-27 23:43:34');
INSERT INTO `problem_language` VALUES (123, 1006, 51, '2023-04-27 23:43:34', '2023-04-27 23:43:34');
INSERT INTO `problem_language` VALUES (124, 1006, 52, '2023-04-27 23:43:34', '2023-04-27 23:43:34');
INSERT INTO `problem_language` VALUES (125, 1006, 53, '2023-04-27 23:43:34', '2023-04-27 23:43:34');
INSERT INTO `problem_language` VALUES (126, 1006, 54, '2023-04-27 23:43:34', '2023-04-27 23:43:34');
INSERT INTO `problem_language` VALUES (127, 1007, 55, '2023-04-29 11:37:57', '2023-04-29 11:37:57');
INSERT INTO `problem_language` VALUES (128, 1007, 56, '2023-04-29 11:37:57', '2023-04-29 11:37:57');
INSERT INTO `problem_language` VALUES (129, 1007, 57, '2023-04-29 11:37:57', '2023-04-29 11:37:57');
INSERT INTO `problem_language` VALUES (130, 1007, 58, '2023-04-29 11:37:57', '2023-04-29 11:37:57');
INSERT INTO `problem_language` VALUES (131, 1007, 59, '2023-04-29 11:37:57', '2023-04-29 11:37:57');
INSERT INTO `problem_language` VALUES (132, 1007, 60, '2023-04-29 11:37:57', '2023-04-29 11:37:57');
INSERT INTO `problem_language` VALUES (133, 1007, 61, '2023-04-29 11:37:57', '2023-04-29 11:37:57');
INSERT INTO `problem_language` VALUES (134, 1008, 145, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (135, 1008, 146, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (136, 1008, 147, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (137, 1008, 148, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (138, 1008, 149, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (139, 1008, 150, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (140, 1008, 151, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (141, 1008, 152, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (142, 1008, 153, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (143, 1008, 154, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (144, 1008, 155, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (145, 1008, 156, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (146, 1008, 157, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (147, 1008, 158, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (148, 1008, 159, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (149, 1008, 160, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (150, 1008, 161, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (151, 1008, 162, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (152, 1008, 163, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (153, 1008, 164, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (154, 1008, 165, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (155, 1008, 166, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (156, 1008, 167, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (157, 1008, 168, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (158, 1008, 169, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (159, 1008, 170, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (160, 1008, 171, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (161, 1008, 172, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (162, 1008, 173, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (163, 1008, 174, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (164, 1008, 175, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (165, 1008, 176, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (166, 1008, 177, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (167, 1008, 178, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (168, 1008, 179, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (169, 1008, 180, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (170, 1008, 181, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (171, 1008, 182, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (172, 1008, 183, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (173, 1008, 184, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (174, 1008, 185, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (175, 1008, 186, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (176, 1008, 187, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (177, 1008, 188, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (178, 1008, 189, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (179, 1008, 190, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (180, 1008, 191, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (181, 1008, 192, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (182, 1008, 193, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (183, 1008, 194, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (184, 1008, 195, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (185, 1008, 196, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (186, 1008, 197, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (187, 1008, 198, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (188, 1008, 199, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (189, 1008, 200, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (190, 1008, 201, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (191, 1008, 202, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (192, 1008, 203, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (193, 1008, 204, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (194, 1008, 205, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (195, 1008, 206, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (196, 1008, 207, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (197, 1008, 208, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (198, 1008, 209, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (199, 1008, 210, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (200, 1008, 211, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_language` VALUES (201, 1009, 26, '2023-05-01 00:03:16', '2023-05-01 00:03:16');
INSERT INTO `problem_language` VALUES (202, 1009, 27, '2023-05-01 00:03:16', '2023-05-01 00:03:16');
INSERT INTO `problem_language` VALUES (203, 1009, 28, '2023-05-01 00:03:16', '2023-05-01 00:03:16');
INSERT INTO `problem_language` VALUES (204, 1009, 29, '2023-05-01 00:03:16', '2023-05-01 00:03:16');
INSERT INTO `problem_language` VALUES (205, 1009, 30, '2023-05-01 00:03:16', '2023-05-01 00:03:16');
INSERT INTO `problem_language` VALUES (206, 1009, 31, '2023-05-01 00:03:16', '2023-05-01 00:03:16');
INSERT INTO `problem_language` VALUES (207, 1009, 32, '2023-05-01 00:03:16', '2023-05-01 00:03:16');
INSERT INTO `problem_language` VALUES (208, 1009, 33, '2023-05-01 00:03:16', '2023-05-01 00:03:16');
INSERT INTO `problem_language` VALUES (209, 1009, 34, '2023-05-01 00:03:16', '2023-05-01 00:03:16');
INSERT INTO `problem_language` VALUES (210, 1009, 35, '2023-05-01 00:03:16', '2023-05-01 00:03:16');
INSERT INTO `problem_language` VALUES (211, 1009, 36, '2023-05-01 00:03:16', '2023-05-01 00:03:16');
INSERT INTO `problem_language` VALUES (212, 1009, 37, '2023-05-01 00:03:16', '2023-05-01 00:03:16');
INSERT INTO `problem_language` VALUES (213, 1009, 38, '2023-05-01 00:03:16', '2023-05-01 00:03:16');
INSERT INTO `problem_language` VALUES (214, 1009, 39, '2023-05-01 00:03:16', '2023-05-01 00:03:16');
INSERT INTO `problem_language` VALUES (215, 1009, 40, '2023-05-01 00:03:16', '2023-05-01 00:03:16');
INSERT INTO `problem_language` VALUES (216, 1009, 41, '2023-05-01 00:03:16', '2023-05-01 00:03:16');
INSERT INTO `problem_language` VALUES (217, 1009, 42, '2023-05-01 00:03:16', '2023-05-01 00:03:16');
INSERT INTO `problem_language` VALUES (218, 1009, 43, '2023-05-01 00:03:16', '2023-05-01 00:03:16');
INSERT INTO `problem_language` VALUES (219, 1009, 44, '2023-05-01 00:03:16', '2023-05-01 00:03:16');
INSERT INTO `problem_language` VALUES (220, 1009, 45, '2023-05-01 00:03:16', '2023-05-01 00:03:16');
INSERT INTO `problem_language` VALUES (221, 1009, 46, '2023-05-01 00:03:16', '2023-05-01 00:03:16');
INSERT INTO `problem_language` VALUES (222, 1009, 47, '2023-05-01 00:03:16', '2023-05-01 00:03:16');
INSERT INTO `problem_language` VALUES (223, 1009, 48, '2023-05-01 00:03:16', '2023-05-01 00:03:16');
INSERT INTO `problem_language` VALUES (224, 1009, 49, '2023-05-01 00:03:16', '2023-05-01 00:03:16');
INSERT INTO `problem_language` VALUES (225, 1009, 50, '2023-05-01 00:03:16', '2023-05-01 00:03:16');
INSERT INTO `problem_language` VALUES (226, 1009, 51, '2023-05-01 00:03:16', '2023-05-01 00:03:16');
INSERT INTO `problem_language` VALUES (227, 1009, 52, '2023-05-01 00:03:16', '2023-05-01 00:03:16');
INSERT INTO `problem_language` VALUES (228, 1009, 53, '2023-05-01 00:03:16', '2023-05-01 00:03:16');
INSERT INTO `problem_language` VALUES (229, 1009, 54, '2023-05-01 00:03:16', '2023-05-01 00:03:16');
INSERT INTO `problem_language` VALUES (284, 1013, 1, '2023-05-06 21:48:04', '2023-05-06 21:48:04');
INSERT INTO `problem_language` VALUES (285, 1013, 2, '2023-05-06 21:48:04', '2023-05-06 21:48:04');
INSERT INTO `problem_language` VALUES (286, 1013, 3, '2023-05-06 21:48:04', '2023-05-06 21:48:04');
INSERT INTO `problem_language` VALUES (287, 1013, 4, '2023-05-06 21:48:04', '2023-05-06 21:48:04');
INSERT INTO `problem_language` VALUES (288, 1013, 5, '2023-05-06 21:48:04', '2023-05-06 21:48:04');
INSERT INTO `problem_language` VALUES (289, 1013, 6, '2023-05-06 21:48:04', '2023-05-06 21:48:04');
INSERT INTO `problem_language` VALUES (290, 1013, 7, '2023-05-06 21:48:04', '2023-05-06 21:48:04');
INSERT INTO `problem_language` VALUES (291, 1013, 8, '2023-05-06 21:48:04', '2023-05-06 21:48:04');
INSERT INTO `problem_language` VALUES (292, 1013, 9, '2023-05-06 21:48:04', '2023-05-06 21:48:04');
INSERT INTO `problem_language` VALUES (293, 1013, 10, '2023-05-06 21:48:04', '2023-05-06 21:48:04');
INSERT INTO `problem_language` VALUES (294, 1013, 11, '2023-05-06 21:48:04', '2023-05-06 21:48:04');
INSERT INTO `problem_language` VALUES (295, 1013, 12, '2023-05-06 21:48:04', '2023-05-06 21:48:04');
INSERT INTO `problem_language` VALUES (296, 1013, 13, '2023-05-06 21:48:04', '2023-05-06 21:48:04');
INSERT INTO `problem_language` VALUES (297, 1013, 14, '2023-05-06 21:48:04', '2023-05-06 21:48:04');
INSERT INTO `problem_language` VALUES (298, 1013, 15, '2023-05-06 21:48:04', '2023-05-06 21:48:04');
INSERT INTO `problem_language` VALUES (299, 1013, 16, '2023-05-06 21:48:04', '2023-05-06 21:48:04');
INSERT INTO `problem_language` VALUES (300, 1013, 17, '2023-05-06 21:48:04', '2023-05-06 21:48:04');
INSERT INTO `problem_language` VALUES (301, 1013, 18, '2023-05-06 21:48:04', '2023-05-06 21:48:04');

-- ----------------------------
-- Table structure for problem_tag
-- ----------------------------
DROP TABLE IF EXISTS `problem_tag`;
CREATE TABLE `problem_tag`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pid` bigint(0) UNSIGNED NOT NULL,
  `tid` bigint(0) UNSIGNED NOT NULL,
  `gmt_create` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `gmt_modified` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE,
  INDEX `tid`(`tid`) USING BTREE,
  CONSTRAINT `problem_tag_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `problem` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `problem_tag_ibfk_2` FOREIGN KEY (`tid`) REFERENCES `tag` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of problem_tag
-- ----------------------------
INSERT INTO `problem_tag` VALUES (1, 1000, 1, '2023-04-25 21:48:22', '2023-04-25 21:48:22');
INSERT INTO `problem_tag` VALUES (2, 1006, 2, '2023-04-27 23:43:34', '2023-04-27 23:43:34');
INSERT INTO `problem_tag` VALUES (3, 1006, 3, '2023-04-27 23:43:34', '2023-04-27 23:43:34');
INSERT INTO `problem_tag` VALUES (4, 1007, 4, '2023-04-29 11:37:57', '2023-04-29 11:37:57');
INSERT INTO `problem_tag` VALUES (5, 1008, 5, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `problem_tag` VALUES (6, 1009, 6, '2023-05-01 00:03:16', '2023-05-01 00:03:16');
INSERT INTO `problem_tag` VALUES (7, 1009, 3, '2023-05-01 00:03:16', '2023-05-01 00:03:16');
INSERT INTO `problem_tag` VALUES (8, 1013, 7, '2023-05-15 21:01:54', '2023-05-15 21:01:54');
INSERT INTO `problem_tag` VALUES (9, 1013, 8, '2023-05-15 21:01:54', '2023-05-15 21:01:54');

-- ----------------------------
-- Table structure for remote_judge_account
-- ----------------------------
DROP TABLE IF EXISTS `remote_judge_account`;
CREATE TABLE `remote_judge_account`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `oj` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '远程oj名字',
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '账号',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否可用',
  `version` bigint(0) NULL DEFAULT 0 COMMENT '版本控制',
  `gmt_create` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `gmt_modified` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 159 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of remote_judge_account
-- ----------------------------
INSERT INTO `remote_judge_account` VALUES (160, 'HDU', 'lxhcaicai', 'dgut2834', 1, 0, '2023-05-18 22:00:42', '2023-05-18 22:00:42');
INSERT INTO `remote_judge_account` VALUES (161, 'POJ', 'lxhcaicai', 'dgut2834', 1, 0, '2023-05-18 22:00:42', '2023-05-18 22:00:42');
INSERT INTO `remote_judge_account` VALUES (162, 'CF', '2778763221@qq.com', 'dgut2834', 1, 0, '2023-05-18 22:00:42', '2023-05-18 22:00:42');
INSERT INTO `remote_judge_account` VALUES (163, 'AC', 'lxhcaicai', 'dgut2834', 1, 0, '2023-05-18 22:00:42', '2023-05-18 22:00:42');

-- ----------------------------
-- Table structure for reply
-- ----------------------------
DROP TABLE IF EXISTS `reply`;
CREATE TABLE `reply`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `comment_id` int(0) NOT NULL COMMENT '被回复的评论id',
  `from_uid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '发起回复的用户id',
  `from_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '发起回复的用户名',
  `from_avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '发起回复的用户头像地址',
  `from_role` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '发起回复的用户角色',
  `to_uid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '被回复的用户id',
  `to_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '被回复的用户名',
  `to_avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '被回复的用户头像地址',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `status` int(0) NULL DEFAULT 0 COMMENT '是否封禁或逻辑删除该回复',
  `gmt_create` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `gmt_modified` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `comment_id`(`comment_id`) USING BTREE,
  INDEX `from_avatar`(`from_avatar`) USING BTREE,
  INDEX `to_avatar`(`to_avatar`) USING BTREE,
  CONSTRAINT `reply_ibfk_1` FOREIGN KEY (`comment_id`) REFERENCES `comment` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reply_ibfk_2` FOREIGN KEY (`from_avatar`) REFERENCES `user_info` (`avatar`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reply_ibfk_3` FOREIGN KEY (`to_avatar`) REFERENCES `user_info` (`avatar`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `id` bigint(20) UNSIGNED ZEROFILL NOT NULL,
  `role` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色',
  `description` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `status` tinyint(0) NOT NULL DEFAULT 0 COMMENT '默认0可用，1不可用',
  `gmt_create` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (00000000000000001000, 'root', '超级管理员', 0, '2020-10-25 00:16:30', '2020-10-25 00:16:30');
INSERT INTO `role` VALUES (00000000000000001001, 'admin', '管理员', 0, '2020-10-25 00:16:41', '2020-10-25 00:16:41');
INSERT INTO `role` VALUES (00000000000000001002, 'default_user', '默认用户', 0, '2020-10-25 00:16:52', '2021-05-15 07:39:05');
INSERT INTO `role` VALUES (00000000000000001003, 'no_subimit_user', '禁止提交用户', 0, '2021-05-15 07:10:14', '2021-05-15 07:39:14');
INSERT INTO `role` VALUES (00000000000000001004, 'no_discuss_user', '禁止发贴讨论用户', 0, '2021-05-15 07:11:28', '2021-05-15 07:39:16');
INSERT INTO `role` VALUES (00000000000000001005, 'mute_user', '禁言包括回复讨论发帖用户', 0, '2021-05-15 07:12:51', '2021-05-15 07:39:19');
INSERT INTO `role` VALUES (00000000000000001006, 'no_submit_no_discuss_user', '禁止提交同时禁止发帖用户', 0, '2021-05-15 07:38:08', '2021-05-15 07:39:34');
INSERT INTO `role` VALUES (00000000000000001007, 'no_submit_mute_user', '禁言禁提交用户', 0, '2021-05-15 07:39:00', '2021-05-15 07:39:26');
INSERT INTO `role` VALUES (00000000000000001008, 'problem_admin', '题目管理员', 0, '2021-06-12 23:15:06', '2021-06-12 23:15:06');

-- ----------------------------
-- Table structure for role_auth
-- ----------------------------
DROP TABLE IF EXISTS `role_auth`;
CREATE TABLE `role_auth`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `auth_id` bigint(0) UNSIGNED NOT NULL,
  `role_id` bigint(0) UNSIGNED NOT NULL,
  `gmt_create` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `gmt_modified` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `auth_id`(`auth_id`) USING BTREE,
  INDEX `role_id`(`role_id`) USING BTREE,
  CONSTRAINT `role_auth_ibfk_1` FOREIGN KEY (`auth_id`) REFERENCES `auth` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `role_auth_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 61 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role_auth
-- ----------------------------
INSERT INTO `role_auth` VALUES (1, 1, 1000, '2020-10-25 00:18:17', '2020-10-25 00:18:17');
INSERT INTO `role_auth` VALUES (2, 2, 1000, '2020-10-25 00:18:38', '2021-05-15 07:17:35');
INSERT INTO `role_auth` VALUES (3, 3, 1000, '2020-10-25 00:18:48', '2021-05-15 07:17:44');
INSERT INTO `role_auth` VALUES (4, 4, 1000, '2021-05-15 07:17:56', '2021-05-15 07:17:56');
INSERT INTO `role_auth` VALUES (5, 5, 1000, '2021-05-15 07:18:20', '2021-05-15 07:18:20');
INSERT INTO `role_auth` VALUES (6, 6, 1000, '2021-05-15 07:18:29', '2021-05-15 07:18:29');
INSERT INTO `role_auth` VALUES (7, 7, 1000, '2021-05-15 07:18:42', '2021-05-15 07:18:42');
INSERT INTO `role_auth` VALUES (8, 8, 1000, '2021-05-15 07:18:59', '2021-05-15 07:18:59');
INSERT INTO `role_auth` VALUES (9, 9, 1000, '2021-05-15 07:19:07', '2021-05-15 07:19:07');
INSERT INTO `role_auth` VALUES (10, 10, 1000, '2021-05-15 07:19:10', '2021-05-15 07:19:10');
INSERT INTO `role_auth` VALUES (11, 11, 1000, '2021-05-15 07:19:13', '2021-05-15 07:19:13');
INSERT INTO `role_auth` VALUES (12, 12, 1000, '2021-05-15 07:19:18', '2021-05-15 07:19:30');
INSERT INTO `role_auth` VALUES (13, 1, 1001, '2021-05-15 07:19:29', '2021-05-15 07:20:02');
INSERT INTO `role_auth` VALUES (14, 2, 1001, '2021-05-15 07:20:25', '2021-05-15 07:20:25');
INSERT INTO `role_auth` VALUES (15, 3, 1001, '2021-05-15 07:20:33', '2021-05-15 07:20:33');
INSERT INTO `role_auth` VALUES (16, 8, 1001, '2021-05-15 07:21:56', '2021-05-15 07:21:56');
INSERT INTO `role_auth` VALUES (17, 9, 1001, '2021-05-15 07:22:03', '2021-05-15 07:22:03');
INSERT INTO `role_auth` VALUES (18, 10, 1001, '2021-05-15 07:22:10', '2021-05-15 07:22:10');
INSERT INTO `role_auth` VALUES (19, 11, 1001, '2021-05-15 07:22:17', '2021-05-15 07:22:17');
INSERT INTO `role_auth` VALUES (20, 12, 1001, '2021-05-15 07:22:21', '2021-05-15 07:22:21');
INSERT INTO `role_auth` VALUES (21, 2, 1002, '2021-05-15 07:22:40', '2021-05-15 07:22:40');
INSERT INTO `role_auth` VALUES (22, 8, 1002, '2021-05-15 07:23:49', '2021-05-15 07:23:49');
INSERT INTO `role_auth` VALUES (23, 9, 1002, '2021-05-15 07:24:10', '2021-05-15 07:24:10');
INSERT INTO `role_auth` VALUES (24, 10, 1002, '2021-05-15 07:24:14', '2021-05-15 07:24:14');
INSERT INTO `role_auth` VALUES (25, 11, 1002, '2021-05-15 07:24:19', '2021-05-15 07:24:19');
INSERT INTO `role_auth` VALUES (26, 12, 1002, '2021-05-15 07:24:23', '2021-05-15 07:24:23');
INSERT INTO `role_auth` VALUES (27, 8, 1003, '2021-05-15 07:32:56', '2021-05-15 07:32:56');
INSERT INTO `role_auth` VALUES (28, 9, 1003, '2021-05-15 07:33:01', '2021-05-15 07:33:01');
INSERT INTO `role_auth` VALUES (29, 10, 1003, '2021-05-15 07:33:05', '2021-05-15 07:33:05');
INSERT INTO `role_auth` VALUES (30, 11, 1003, '2021-05-15 07:33:09', '2021-05-15 07:33:09');
INSERT INTO `role_auth` VALUES (31, 12, 1003, '2021-05-15 07:33:22', '2021-05-15 07:33:22');
INSERT INTO `role_auth` VALUES (32, 2, 1004, '2021-05-15 07:33:38', '2021-05-15 07:33:38');
INSERT INTO `role_auth` VALUES (33, 9, 1004, '2021-05-15 07:34:27', '2021-05-15 07:34:27');
INSERT INTO `role_auth` VALUES (34, 10, 1004, '2021-05-15 07:34:31', '2021-05-15 07:34:31');
INSERT INTO `role_auth` VALUES (35, 11, 1004, '2021-05-15 07:34:42', '2021-05-15 07:34:42');
INSERT INTO `role_auth` VALUES (36, 12, 1004, '2021-05-15 07:34:47', '2021-05-15 07:34:47');
INSERT INTO `role_auth` VALUES (37, 2, 1005, '2021-05-15 07:35:11', '2021-05-15 07:35:11');
INSERT INTO `role_auth` VALUES (38, 9, 1005, '2021-05-15 07:35:46', '2021-05-15 07:35:46');
INSERT INTO `role_auth` VALUES (39, 10, 1005, '2021-05-15 07:36:01', '2021-05-15 07:36:01');
INSERT INTO `role_auth` VALUES (40, 9, 1006, '2021-05-15 07:40:09', '2021-05-15 07:40:09');
INSERT INTO `role_auth` VALUES (41, 10, 1006, '2021-05-15 07:40:16', '2021-05-15 07:40:16');
INSERT INTO `role_auth` VALUES (42, 11, 1006, '2021-05-15 07:40:30', '2021-05-15 07:40:30');
INSERT INTO `role_auth` VALUES (43, 12, 1006, '2021-05-15 07:40:37', '2021-05-15 07:40:37');
INSERT INTO `role_auth` VALUES (44, 9, 1007, '2021-05-15 07:40:54', '2021-05-15 07:40:54');
INSERT INTO `role_auth` VALUES (45, 10, 1007, '2021-05-15 07:41:04', '2021-05-15 07:41:04');
INSERT INTO `role_auth` VALUES (46, 1, 1008, '2021-06-12 23:16:10', '2021-06-12 23:16:10');
INSERT INTO `role_auth` VALUES (47, 2, 1008, '2021-06-12 23:16:15', '2021-06-12 23:16:15');
INSERT INTO `role_auth` VALUES (48, 3, 1008, '2021-06-12 23:16:19', '2021-06-12 23:16:19');
INSERT INTO `role_auth` VALUES (49, 8, 1008, '2021-06-12 23:16:24', '2021-06-12 23:16:24');
INSERT INTO `role_auth` VALUES (50, 9, 1008, '2021-06-12 23:16:45', '2021-06-12 23:16:45');
INSERT INTO `role_auth` VALUES (51, 10, 1008, '2021-06-12 23:16:48', '2021-06-12 23:16:48');
INSERT INTO `role_auth` VALUES (52, 11, 1008, '2021-06-12 23:16:52', '2021-06-12 23:16:52');
INSERT INTO `role_auth` VALUES (53, 12, 1008, '2021-06-12 23:16:58', '2021-06-12 23:16:58');
INSERT INTO `role_auth` VALUES (54, 13, 1000, '2021-06-12 23:16:58', '2021-06-12 23:16:58');
INSERT INTO `role_auth` VALUES (55, 13, 1001, '2021-06-12 23:16:58', '2021-06-12 23:16:58');
INSERT INTO `role_auth` VALUES (56, 13, 1002, '2021-06-12 23:16:58', '2021-06-12 23:16:58');
INSERT INTO `role_auth` VALUES (57, 13, 1008, '2021-06-12 23:16:58', '2021-06-12 23:16:58');
INSERT INTO `role_auth` VALUES (58, 14, 1000, '2021-06-12 23:16:58', '2021-06-12 23:16:58');
INSERT INTO `role_auth` VALUES (59, 14, 1001, '2021-06-12 23:16:58', '2021-06-12 23:16:58');
INSERT INTO `role_auth` VALUES (60, 14, 1002, '2021-06-12 23:16:58', '2021-06-12 23:16:58');
INSERT INTO `role_auth` VALUES (61, 14, 1008, '2021-06-12 23:16:58', '2021-06-12 23:16:58');

-- ----------------------------
-- Table structure for session
-- ----------------------------
DROP TABLE IF EXISTS `session`;
CREATE TABLE `session`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_agent` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `gmt_create` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `gmt_modified` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  CONSTRAINT `session_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `user_info` (`uuid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 73 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of session
-- ----------------------------
INSERT INTO `session` VALUES (1, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2023-04-19 23:13:54', '2023-04-19 23:13:54');
INSERT INTO `session` VALUES (2, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2023-04-25 01:41:45', '2023-04-25 01:41:45');
INSERT INTO `session` VALUES (3, '1', 'PostmanRuntime/7.32.2', '0:0:0:0:0:0:0:1', '2023-04-25 20:12:47', '2023-04-25 20:12:47');
INSERT INTO `session` VALUES (4, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36', '127.0.0.1', '2023-04-25 21:43:57', '2023-04-25 21:43:57');
INSERT INTO `session` VALUES (5, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36 Edg/112.0.1722.58', '127.0.0.1', '2023-04-26 02:31:53', '2023-04-26 02:31:53');
INSERT INTO `session` VALUES (6, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36', '127.0.0.1', '2023-04-26 19:55:17', '2023-04-26 19:55:17');
INSERT INTO `session` VALUES (7, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36', '127.0.0.1', '2023-04-26 20:00:35', '2023-04-26 20:00:35');
INSERT INTO `session` VALUES (8, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36', '127.0.0.1', '2023-04-26 20:03:25', '2023-04-26 20:03:25');
INSERT INTO `session` VALUES (9, '1', 'PostmanRuntime/7.32.2', '0:0:0:0:0:0:0:1', '2023-04-26 22:07:55', '2023-04-26 22:07:55');
INSERT INTO `session` VALUES (10, '1', 'PostmanRuntime/7.32.2', '0:0:0:0:0:0:0:1', '2023-04-26 22:13:10', '2023-04-26 22:13:10');
INSERT INTO `session` VALUES (11, '1', 'PostmanRuntime/7.32.2', '0:0:0:0:0:0:0:1', '2023-04-26 22:13:16', '2023-04-26 22:13:16');
INSERT INTO `session` VALUES (12, '1', 'PostmanRuntime/7.32.2', '0:0:0:0:0:0:0:1', '2023-04-26 22:18:50', '2023-04-26 22:18:50');
INSERT INTO `session` VALUES (13, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36', '127.0.0.1', '2023-04-27 23:41:52', '2023-04-27 23:41:52');
INSERT INTO `session` VALUES (14, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36', '127.0.0.1', '2023-04-29 11:32:27', '2023-04-29 11:32:27');
INSERT INTO `session` VALUES (15, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36', '127.0.0.1', '2023-04-30 08:17:48', '2023-04-30 08:17:48');
INSERT INTO `session` VALUES (16, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36', '127.0.0.1', '2023-05-03 20:16:50', '2023-05-03 20:16:50');
INSERT INTO `session` VALUES (17, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36', '127.0.0.1', '2023-05-05 00:34:12', '2023-05-05 00:34:12');
INSERT INTO `session` VALUES (18, '1', 'PostmanRuntime/7.32.2', '0:0:0:0:0:0:0:1', '2023-05-05 00:45:13', '2023-05-05 00:45:13');
INSERT INTO `session` VALUES (19, '1', 'PostmanRuntime/7.32.2', '0:0:0:0:0:0:0:1', '2023-05-05 01:06:54', '2023-05-05 01:06:54');
INSERT INTO `session` VALUES (20, '1', 'PostmanRuntime/7.32.2', '0:0:0:0:0:0:0:1', '2023-05-05 01:07:13', '2023-05-05 01:07:13');
INSERT INTO `session` VALUES (21, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36', '127.0.0.1', '2023-05-06 01:11:59', '2023-05-06 01:11:59');
INSERT INTO `session` VALUES (22, '1', 'PostmanRuntime/7.32.2', '0:0:0:0:0:0:0:1', '2023-05-06 01:16:15', '2023-05-06 01:16:15');
INSERT INTO `session` VALUES (23, '1', 'PostmanRuntime/7.32.2', '0:0:0:0:0:0:0:1', '2023-05-06 01:19:06', '2023-05-06 01:19:06');
INSERT INTO `session` VALUES (24, '1', 'PostmanRuntime/7.32.2', '0:0:0:0:0:0:0:1', '2023-05-06 19:57:56', '2023-05-06 19:57:56');
INSERT INTO `session` VALUES (25, '1', 'PostmanRuntime/7.32.2', '0:0:0:0:0:0:0:1', '2023-05-06 20:23:05', '2023-05-06 20:23:05');
INSERT INTO `session` VALUES (26, '1', 'PostmanRuntime/7.32.2', '0:0:0:0:0:0:0:1', '2023-05-06 20:48:34', '2023-05-06 20:48:34');
INSERT INTO `session` VALUES (27, '1', 'PostmanRuntime/7.32.2', '0:0:0:0:0:0:0:1', '2023-05-06 20:56:30', '2023-05-06 20:56:30');
INSERT INTO `session` VALUES (28, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36', '127.0.0.1', '2023-05-06 21:44:55', '2023-05-06 21:44:55');
INSERT INTO `session` VALUES (29, '1', 'PostmanRuntime/7.32.2', '0:0:0:0:0:0:0:1', '2023-05-06 21:54:07', '2023-05-06 21:54:07');
INSERT INTO `session` VALUES (30, '1', 'PostmanRuntime/7.32.2', '0:0:0:0:0:0:0:1', '2023-05-07 10:50:39', '2023-05-07 10:50:39');
INSERT INTO `session` VALUES (31, '1', 'PostmanRuntime/7.32.2', '0:0:0:0:0:0:0:1', '2023-05-07 11:35:33', '2023-05-07 11:35:33');
INSERT INTO `session` VALUES (32, '1', 'PostmanRuntime/7.32.2', '0:0:0:0:0:0:0:1', '2023-05-08 20:12:37', '2023-05-08 20:12:37');
INSERT INTO `session` VALUES (33, '1', 'PostmanRuntime/7.32.2', '0:0:0:0:0:0:0:1', '2023-05-08 23:20:34', '2023-05-08 23:20:34');
INSERT INTO `session` VALUES (34, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36', '127.0.0.1', '2023-05-09 01:27:43', '2023-05-09 01:27:43');
INSERT INTO `session` VALUES (35, '1', 'PostmanRuntime/7.32.2', '0:0:0:0:0:0:0:1', '2023-05-09 20:00:52', '2023-05-09 20:00:52');
INSERT INTO `session` VALUES (36, '1', 'PostmanRuntime/7.32.2', '0:0:0:0:0:0:0:1', '2023-05-09 20:30:30', '2023-05-09 20:30:30');
INSERT INTO `session` VALUES (37, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36', '127.0.0.1', '2023-05-10 22:24:14', '2023-05-10 22:24:14');
INSERT INTO `session` VALUES (38, '1', 'PostmanRuntime/7.32.2', '0:0:0:0:0:0:0:1', '2023-05-10 22:33:49', '2023-05-10 22:33:49');
INSERT INTO `session` VALUES (39, '1', 'PostmanRuntime/7.32.2', '0:0:0:0:0:0:0:1', '2023-05-11 23:59:29', '2023-05-11 23:59:29');
INSERT INTO `session` VALUES (40, '1', 'PostmanRuntime/7.32.2', '0:0:0:0:0:0:0:1', '2023-05-12 03:01:06', '2023-05-12 03:01:06');
INSERT INTO `session` VALUES (41, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36', '127.0.0.1', '2023-05-12 03:23:15', '2023-05-12 03:23:15');
INSERT INTO `session` VALUES (42, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36', '127.0.0.1', '2023-05-12 20:24:47', '2023-05-12 20:24:47');
INSERT INTO `session` VALUES (43, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36', '127.0.0.1', '2023-05-12 20:45:38', '2023-05-12 20:45:38');
INSERT INTO `session` VALUES (44, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36', '127.0.0.1', '2023-05-12 20:47:18', '2023-05-12 20:47:18');
INSERT INTO `session` VALUES (45, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36', '127.0.0.1', '2023-05-12 23:09:30', '2023-05-12 23:09:30');
INSERT INTO `session` VALUES (46, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36', '127.0.0.1', '2023-05-12 23:11:21', '2023-05-12 23:11:21');
INSERT INTO `session` VALUES (47, '1', 'PostmanRuntime/7.32.2', '0:0:0:0:0:0:0:1', '2023-05-12 23:11:41', '2023-05-12 23:11:41');
INSERT INTO `session` VALUES (48, '1', 'PostmanRuntime/7.32.2', '0:0:0:0:0:0:0:1', '2023-05-12 23:13:12', '2023-05-12 23:13:12');
INSERT INTO `session` VALUES (49, '1', 'PostmanRuntime/7.32.2', '0:0:0:0:0:0:0:1', '2023-05-12 23:14:12', '2023-05-12 23:14:12');
INSERT INTO `session` VALUES (50, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36', '127.0.0.1', '2023-05-12 23:18:47', '2023-05-12 23:18:47');
INSERT INTO `session` VALUES (51, '1', 'PostmanRuntime/7.32.2', '0:0:0:0:0:0:0:1', '2023-05-12 23:42:41', '2023-05-12 23:42:41');
INSERT INTO `session` VALUES (52, '1', 'PostmanRuntime/7.32.2', '0:0:0:0:0:0:0:1', '2023-05-12 23:42:45', '2023-05-12 23:42:45');
INSERT INTO `session` VALUES (53, '1', 'PostmanRuntime/7.32.2', '0:0:0:0:0:0:0:1', '2023-05-12 23:42:46', '2023-05-12 23:42:46');
INSERT INTO `session` VALUES (54, '1', 'PostmanRuntime/7.32.2', '0:0:0:0:0:0:0:1', '2023-05-12 23:48:54', '2023-05-12 23:48:54');
INSERT INTO `session` VALUES (55, '1', 'PostmanRuntime/7.32.2', '0:0:0:0:0:0:0:1', '2023-05-12 23:49:05', '2023-05-12 23:49:05');
INSERT INTO `session` VALUES (56, '1', 'PostmanRuntime/7.32.2', '0:0:0:0:0:0:0:1', '2023-05-12 23:49:07', '2023-05-12 23:49:07');
INSERT INTO `session` VALUES (57, '1', 'PostmanRuntime/7.32.2', '0:0:0:0:0:0:0:1', '2023-05-13 01:31:03', '2023-05-13 01:31:03');
INSERT INTO `session` VALUES (58, '1', 'PostmanRuntime/7.32.2', '0:0:0:0:0:0:0:1', '2023-05-13 20:23:39', '2023-05-13 20:23:39');
INSERT INTO `session` VALUES (59, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/113.0.0.0 Safari/537.36', '127.0.0.1', '2023-05-14 11:15:16', '2023-05-14 11:15:16');
INSERT INTO `session` VALUES (60, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/113.0.0.0 Safari/537.36', '127.0.0.1', '2023-05-14 11:19:28', '2023-05-14 11:19:28');
INSERT INTO `session` VALUES (62, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/113.0.0.0 Safari/537.36', '127.0.0.1', '2023-05-14 18:32:22', '2023-05-14 18:32:22');
INSERT INTO `session` VALUES (63, '1', 'PostmanRuntime/7.32.2', '0:0:0:0:0:0:0:1', '2023-05-14 18:40:58', '2023-05-14 18:40:58');
INSERT INTO `session` VALUES (64, '1', 'PostmanRuntime/7.32.2', '0:0:0:0:0:0:0:1', '2023-05-14 21:18:30', '2023-05-14 21:18:30');
INSERT INTO `session` VALUES (65, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/113.0.0.0 Safari/537.36', '127.0.0.1', '2023-05-15 19:40:21', '2023-05-15 19:40:21');
INSERT INTO `session` VALUES (66, '1', 'PostmanRuntime/7.32.2', '0:0:0:0:0:0:0:1', '2023-05-15 22:19:08', '2023-05-15 22:19:08');
INSERT INTO `session` VALUES (67, '1', 'PostmanRuntime/7.32.2', '0:0:0:0:0:0:0:1', '2023-05-15 22:48:19', '2023-05-15 22:48:19');
INSERT INTO `session` VALUES (68, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/113.0.0.0 Safari/537.36', '127.0.0.1', '2023-05-16 21:39:22', '2023-05-16 21:39:22');
INSERT INTO `session` VALUES (69, '1', 'PostmanRuntime/7.32.2', '0:0:0:0:0:0:0:1', '2023-05-16 22:40:39', '2023-05-16 22:40:39');
INSERT INTO `session` VALUES (70, '1', 'PostmanRuntime/7.32.2', '0:0:0:0:0:0:0:1', '2023-05-16 23:09:13', '2023-05-16 23:09:13');
INSERT INTO `session` VALUES (71, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/113.0.0.0 Safari/537.36', '127.0.0.1', '2023-05-17 22:45:05', '2023-05-17 22:45:05');
INSERT INTO `session` VALUES (72, '1', 'PostmanRuntime/7.32.2', '0:0:0:0:0:0:0:1', '2023-05-17 23:12:23', '2023-05-17 23:12:23');
INSERT INTO `session` VALUES (73, '1', 'PostmanRuntime/7.32.2', '0:0:0:0:0:0:0:1', '2023-05-17 23:26:32', '2023-05-17 23:26:32');
INSERT INTO `session` VALUES (74, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/113.0.0.0 Safari/537.36', '127.0.0.1', '2023-05-18 22:01:43', '2023-05-18 22:01:43');

-- ----------------------------
-- Table structure for tag
-- ----------------------------
DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标签名字',
  `color` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标签颜色',
  `oj` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'ME' COMMENT '标签所属oj',
  `gid` bigint(0) UNSIGNED NULL DEFAULT NULL,
  `tcid` bigint(0) UNSIGNED NULL DEFAULT NULL,
  `gmt_create` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `gmt_modified` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`, `oj`, `gid`) USING BTREE,
  INDEX `tag_ibfk_1`(`gid`) USING BTREE,
  INDEX `tag_ibfk_2`(`tcid`) USING BTREE,
  CONSTRAINT `tag_ibfk_1` FOREIGN KEY (`gid`) REFERENCES `group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tag_ibfk_2` FOREIGN KEY (`tcid`) REFERENCES `tag_classification` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tag
-- ----------------------------
INSERT INTO `tag` VALUES (1, 'HDU', NULL, 'HDU', NULL, NULL, '2023-04-25 21:48:22', '2023-04-25 21:48:22');
INSERT INTO `tag` VALUES (2, 'math', NULL, 'CF', NULL, NULL, '2023-04-27 23:43:34', '2023-04-27 23:43:34');
INSERT INTO `tag` VALUES (3, '*1000', NULL, 'CF', NULL, NULL, '2023-04-27 23:43:34', '2023-05-01 00:03:16');
INSERT INTO `tag` VALUES (4, 'POJ', NULL, 'POJ', NULL, NULL, '2023-04-29 11:37:57', '2023-04-29 11:37:57');
INSERT INTO `tag` VALUES (5, 'AC', NULL, 'AC', NULL, NULL, '2023-04-30 18:00:05', '2023-04-30 18:00:05');
INSERT INTO `tag` VALUES (6, 'implementation', NULL, 'CF', NULL, NULL, '2023-05-01 00:03:16', '2023-05-01 00:03:16');
INSERT INTO `tag` VALUES (7, 'qwq', NULL, 'ME', NULL, NULL, '2023-05-15 21:01:54', '2023-05-15 21:01:54');
INSERT INTO `tag` VALUES (8, 'test', NULL, 'ME', NULL, NULL, '2023-05-15 21:01:54', '2023-05-15 21:01:54');

-- ----------------------------
-- Table structure for tag_classification
-- ----------------------------
DROP TABLE IF EXISTS `tag_classification`;
CREATE TABLE `tag_classification`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '标签分类名称',
  `oj` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '标签分类所属oj',
  `gmt_create` datetime(0) NULL DEFAULT NULL,
  `gmt_modified` datetime(0) NULL DEFAULT NULL,
  `rank` int(10) UNSIGNED ZEROFILL NULL DEFAULT NULL COMMENT '标签分类优先级 越小越高',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for training
-- ----------------------------
DROP TABLE IF EXISTS `training`;
CREATE TABLE `training`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `author` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '训练题单创建者用户名',
  `auth` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '训练题单权限类型：Public、Private',
  `private_pwd` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '训练题单权限为Private时的密码',
  `rank` int(0) NULL DEFAULT 0 COMMENT '编号，升序',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '是否可用',
  `is_group` tinyint(1) NULL DEFAULT 0,
  `gid` bigint(0) UNSIGNED NULL DEFAULT NULL,
  `gmt_create` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `gmt_modified` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `training_ibfk_1`(`gid`) USING BTREE,
  CONSTRAINT `training_ibfk_1` FOREIGN KEY (`gid`) REFERENCES `group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of training
-- ----------------------------
INSERT INTO `training` VALUES (1, '这是一个训练', '这是一个训练', 'root', 'Public', '', 1000, 1, 0, NULL, '2023-05-16 21:40:56', '2023-05-16 21:41:29');

-- ----------------------------
-- Table structure for training_category
-- ----------------------------
DROP TABLE IF EXISTS `training_category`;
CREATE TABLE `training_category`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `color` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `gid` bigint(0) UNSIGNED NULL DEFAULT NULL,
  `gmt_create` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `gmt_modified` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `training_category_ibfk_1`(`gid`) USING BTREE,
  CONSTRAINT `training_category_ibfk_1` FOREIGN KEY (`gid`) REFERENCES `group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of training_category
-- ----------------------------
INSERT INTO `training_category` VALUES (1, 'test', '#409eff', NULL, '2023-05-16 21:40:33', '2023-05-16 21:40:33');

-- ----------------------------
-- Table structure for training_problem
-- ----------------------------
DROP TABLE IF EXISTS `training_problem`;
CREATE TABLE `training_problem`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `tid` bigint(0) UNSIGNED NOT NULL COMMENT '训练id',
  `pid` bigint(0) UNSIGNED NOT NULL COMMENT '题目id',
  `rank` int(0) NULL DEFAULT 0,
  `display_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `gmt_create` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `gmt_modified` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `tid`(`tid`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE,
  INDEX `display_id`(`display_id`) USING BTREE,
  CONSTRAINT `training_problem_ibfk_1` FOREIGN KEY (`tid`) REFERENCES `training` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `training_problem_ibfk_2` FOREIGN KEY (`pid`) REFERENCES `problem` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `training_problem_ibfk_3` FOREIGN KEY (`display_id`) REFERENCES `problem` (`problem_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of training_problem
-- ----------------------------
INSERT INTO `training_problem` VALUES (1, 1, 1000, 0, 'HDU-1001', '2023-05-16 21:41:26', '2023-05-16 21:41:26');
INSERT INTO `training_problem` VALUES (2, 1, 1007, 0, 'POJ-1000', '2023-05-16 21:41:27', '2023-05-16 21:41:27');
INSERT INTO `training_problem` VALUES (3, 1, 1013, 0, '1111', '2023-05-16 21:41:29', '2023-05-16 21:41:29');

-- ----------------------------
-- Table structure for training_record
-- ----------------------------
DROP TABLE IF EXISTS `training_record`;
CREATE TABLE `training_record`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `tid` bigint(0) UNSIGNED NOT NULL,
  `tpid` bigint(0) UNSIGNED NOT NULL,
  `pid` bigint(0) UNSIGNED NOT NULL,
  `uid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `submit_id` bigint(0) UNSIGNED NOT NULL,
  `gmt_create` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `gmt_modified` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `tid`(`tid`) USING BTREE,
  INDEX `tpid`(`tpid`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  INDEX `submit_id`(`submit_id`) USING BTREE,
  CONSTRAINT `training_record_ibfk_1` FOREIGN KEY (`tid`) REFERENCES `training` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `training_record_ibfk_2` FOREIGN KEY (`tpid`) REFERENCES `training_problem` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `training_record_ibfk_3` FOREIGN KEY (`pid`) REFERENCES `problem` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `training_record_ibfk_4` FOREIGN KEY (`uid`) REFERENCES `user_info` (`uuid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `training_record_ibfk_5` FOREIGN KEY (`submit_id`) REFERENCES `judge` (`submit_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for training_register
-- ----------------------------
DROP TABLE IF EXISTS `training_register`;
CREATE TABLE `training_register`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `tid` bigint(0) UNSIGNED NOT NULL COMMENT '训练id',
  `uid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户id',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '是否可用',
  `gmt_create` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `gmt_modified` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `tid`(`tid`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  CONSTRAINT `training_register_ibfk_1` FOREIGN KEY (`tid`) REFERENCES `training` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `training_register_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `user_info` (`uuid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user_acproblem
-- ----------------------------
DROP TABLE IF EXISTS `user_acproblem`;
CREATE TABLE `user_acproblem`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT,
  `uid` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户id',
  `pid` bigint(0) UNSIGNED NOT NULL COMMENT 'ac的题目id',
  `submit_id` bigint(0) UNSIGNED NOT NULL COMMENT '提交id',
  `gmt_create` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `gmt_modified` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `submit_id`(`submit_id`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE,
  CONSTRAINT `user_acproblem_ibfk_2` FOREIGN KEY (`pid`) REFERENCES `problem` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_acproblem_ibfk_3` FOREIGN KEY (`submit_id`) REFERENCES `judge` (`submit_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 97 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_acproblem
-- ----------------------------
INSERT INTO `user_acproblem` VALUES (10, '1', 1006, 81, '2023-04-28 00:56:22', '2023-04-28 00:56:22');
INSERT INTO `user_acproblem` VALUES (11, '1', 1006, 80, '2023-04-28 00:56:54', '2023-04-28 00:56:54');
INSERT INTO `user_acproblem` VALUES (12, '1', 1006, 79, '2023-04-28 00:57:05', '2023-04-28 00:57:05');
INSERT INTO `user_acproblem` VALUES (13, '1', 1006, 77, '2023-04-28 00:57:17', '2023-04-28 00:57:17');
INSERT INTO `user_acproblem` VALUES (14, '1', 1006, 78, '2023-04-28 00:57:28', '2023-04-28 00:57:28');
INSERT INTO `user_acproblem` VALUES (15, '1', 1006, 78, '2023-04-28 01:00:12', '2023-04-28 01:00:12');
INSERT INTO `user_acproblem` VALUES (19, '1', 1007, 84, '2023-04-29 11:43:02', '2023-04-29 11:43:02');
INSERT INTO `user_acproblem` VALUES (21, '1', 1007, 86, '2023-04-29 20:01:54', '2023-04-29 20:01:54');
INSERT INTO `user_acproblem` VALUES (22, '1', 1007, 86, '2023-04-29 20:02:48', '2023-04-29 20:02:48');
INSERT INTO `user_acproblem` VALUES (24, '1', 1007, 86, '2023-04-30 16:49:30', '2023-04-30 16:49:30');
INSERT INTO `user_acproblem` VALUES (26, '1', 1006, 83, '2023-04-30 23:53:32', '2023-04-30 23:53:32');
INSERT INTO `user_acproblem` VALUES (27, '1', 1006, 83, '2023-04-30 23:53:43', '2023-04-30 23:53:43');
INSERT INTO `user_acproblem` VALUES (28, '1', 1009, 90, '2023-05-01 00:04:36', '2023-05-01 00:04:36');
INSERT INTO `user_acproblem` VALUES (30, '1', 1009, 90, '2023-05-01 00:31:22', '2023-05-01 00:31:22');
INSERT INTO `user_acproblem` VALUES (31, '1', 1009, 90, '2023-05-01 00:34:55', '2023-05-01 00:34:55');
INSERT INTO `user_acproblem` VALUES (32, '1', 1009, 90, '2023-05-01 00:39:53', '2023-05-01 00:39:53');
INSERT INTO `user_acproblem` VALUES (33, '1', 1009, 90, '2023-05-01 00:41:50', '2023-05-01 00:41:50');
INSERT INTO `user_acproblem` VALUES (34, '1', 1009, 90, '2023-05-01 00:52:00', '2023-05-01 00:52:00');
INSERT INTO `user_acproblem` VALUES (36, '1', 1009, 90, '2023-05-01 09:56:14', '2023-05-01 09:56:14');
INSERT INTO `user_acproblem` VALUES (37, '1', 1000, 95, '2023-05-01 10:27:25', '2023-05-01 10:27:25');
INSERT INTO `user_acproblem` VALUES (38, '1', 1000, 95, '2023-05-01 10:31:28', '2023-05-01 10:31:28');
INSERT INTO `user_acproblem` VALUES (39, '1', 1000, 95, '2023-05-01 11:29:25', '2023-05-01 11:29:25');
INSERT INTO `user_acproblem` VALUES (40, '1', 1000, 95, '2023-05-01 11:31:45', '2023-05-01 11:31:45');
INSERT INTO `user_acproblem` VALUES (41, '1', 1000, 95, '2023-05-01 11:41:53', '2023-05-01 11:41:53');
INSERT INTO `user_acproblem` VALUES (42, '1', 1000, 95, '2023-05-01 11:52:44', '2023-05-01 11:52:44');
INSERT INTO `user_acproblem` VALUES (58, '1', 1013, 109, '2023-05-06 21:49:44', '2023-05-06 21:49:44');
INSERT INTO `user_acproblem` VALUES (59, '1', 1013, 110, '2023-05-07 16:49:12', '2023-05-07 16:49:12');
INSERT INTO `user_acproblem` VALUES (60, '1', 1013, 111, '2023-05-07 16:50:52', '2023-05-07 16:50:52');
INSERT INTO `user_acproblem` VALUES (61, '1', 1013, 112, '2023-05-07 16:52:56', '2023-05-07 16:52:56');
INSERT INTO `user_acproblem` VALUES (62, '1', 1013, 113, '2023-05-08 20:13:46', '2023-05-08 20:13:46');
INSERT INTO `user_acproblem` VALUES (63, '1', 1013, 114, '2023-05-08 20:18:12', '2023-05-08 20:18:12');
INSERT INTO `user_acproblem` VALUES (64, '1', 1013, 115, '2023-05-08 23:18:42', '2023-05-08 23:18:42');
INSERT INTO `user_acproblem` VALUES (65, '1', 1013, 116, '2023-05-08 23:20:45', '2023-05-08 23:20:45');
INSERT INTO `user_acproblem` VALUES (66, '1', 1013, 117, '2023-05-08 23:21:55', '2023-05-08 23:21:55');
INSERT INTO `user_acproblem` VALUES (74, '1', 1013, 119, '2023-05-09 20:14:05', '2023-05-09 20:14:05');
INSERT INTO `user_acproblem` VALUES (77, '1', 1006, 120, '2023-05-10 22:33:20', '2023-05-10 22:33:20');
INSERT INTO `user_acproblem` VALUES (78, '1', 1006, 121, '2023-05-10 22:34:07', '2023-05-10 22:34:07');
INSERT INTO `user_acproblem` VALUES (79, '1', 1006, 124, '2023-05-12 03:00:32', '2023-05-12 03:00:32');
INSERT INTO `user_acproblem` VALUES (80, '1', 1006, 125, '2023-05-12 03:06:29', '2023-05-12 03:06:29');
INSERT INTO `user_acproblem` VALUES (81, '1', 1006, 124, '2023-05-12 03:23:54', '2023-05-12 03:23:54');
INSERT INTO `user_acproblem` VALUES (82, '1', 1006, 134, '2023-05-12 03:24:03', '2023-05-12 03:24:03');
INSERT INTO `user_acproblem` VALUES (83, '1', 1006, 129, '2023-05-12 03:24:11', '2023-05-12 03:24:11');
INSERT INTO `user_acproblem` VALUES (84, '1', 1006, 129, '2023-05-12 03:24:21', '2023-05-12 03:24:21');
INSERT INTO `user_acproblem` VALUES (85, '1', 1006, 135, '2023-05-12 03:24:47', '2023-05-12 03:24:47');
INSERT INTO `user_acproblem` VALUES (86, '1', 1006, 136, '2023-05-12 03:25:44', '2023-05-12 03:25:44');
INSERT INTO `user_acproblem` VALUES (87, '1', 1006, 133, '2023-05-12 03:26:53', '2023-05-12 03:26:53');
INSERT INTO `user_acproblem` VALUES (88, '1', 1006, 132, '2023-05-12 03:27:03', '2023-05-12 03:27:03');
INSERT INTO `user_acproblem` VALUES (89, '1', 1006, 131, '2023-05-12 03:27:13', '2023-05-12 03:27:13');
INSERT INTO `user_acproblem` VALUES (90, '1', 1006, 130, '2023-05-12 03:27:23', '2023-05-12 03:27:23');
INSERT INTO `user_acproblem` VALUES (91, '1', 1006, 137, '2023-05-12 03:27:35', '2023-05-12 03:27:35');
INSERT INTO `user_acproblem` VALUES (92, '1', 1006, 138, '2023-05-12 03:27:46', '2023-05-12 03:27:46');
INSERT INTO `user_acproblem` VALUES (93, '1', 1006, 140, '2023-05-12 03:27:55', '2023-05-12 03:27:55');
INSERT INTO `user_acproblem` VALUES (94, '1', 1006, 141, '2023-05-12 03:28:04', '2023-05-12 03:28:04');
INSERT INTO `user_acproblem` VALUES (95, '1', 1006, 139, '2023-05-12 03:28:14', '2023-05-12 03:28:14');
INSERT INTO `user_acproblem` VALUES (96, '1', 1006, 142, '2023-05-12 03:28:24', '2023-05-12 03:28:24');
INSERT INTO `user_acproblem` VALUES (97, '1', 1006, 143, '2023-05-12 03:28:34', '2023-05-12 03:28:34');

-- ----------------------------
-- Table structure for user_info
-- ----------------------------
DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info`  (
  `uuid` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `username` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `nickname` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '昵称',
  `school` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '学校',
  `course` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '专业',
  `number` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '学号',
  `realname` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '真实姓名',
  `gender` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'secrecy' COMMENT '性别',
  `github` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'github地址',
  `blog` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '博客地址',
  `cf_username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'cf的username',
  `email` varchar(320) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像地址',
  `signature` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `title_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头衔、称号',
  `title_color` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头衔、称号的颜色',
  `status` int(0) NOT NULL DEFAULT 0 COMMENT '0可用，1不可用',
  `gmt_create` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`uuid`) USING BTREE,
  UNIQUE INDEX `USERNAME_UNIQUE`(`username`) USING BTREE,
  UNIQUE INDEX `EMAIL_UNIQUE`(`email`) USING BTREE,
  UNIQUE INDEX `avatar`(`avatar`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_info
-- ----------------------------
INSERT INTO `user_info` VALUES ('00cb64ad2f5143cca6064d4b3187b4ee', 'lxh31caicai', '9492ab4575ec3a363a5b8f5ce81adb0f', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('0273e0ac65d146fe88383ea3f33b6108', 'qw2q53sss', '480a84619123cd036ce839fc26009753', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('02cc9e77ed35441b839fef5f95cddf41', 'qw2q78sss', 'be03289e8fbaafb042bc29d8ff89cf71', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('050e69fa551245d8879d504d2efa1223', 'aaa41sss', '22d4bc1c54f064b86951c07b3784f46d', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('05e5342614734a7c92860a85c2858379', 'aaa83sss', '2cf05c2258153c897a7cec21e25e85a6', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('06cace76e41a4391b418cc010d453dda', 'lxh60caicai', 'ac8a6f46d54267ad51ec3f729b9dc9ae', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('07291b87c020480c9135fb1fb8ba1b4f', 'qwq56sss', '45d7fcfa3a58f233f6b8236aa7d7bdfb', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('07fd5ae95aae40b3b4358897b198577f', 'qw2q37sss', '1e4a2a6164ac2e91b70e4e40e7b90d7a', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('0841e27a7d364a788fbee7a87106039d', 'qw2q54sss', '8cc45c97acc4c2cd13e9fc9483d28900', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('09e1a321da654b6880cd0b61f40509d9', 'aaa28sss', '2213d1f8d7c0e6d793fd5bfacd896e36', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('0a2e447fb0a04631a366f212538f8b84', 'aaa8sss', 'cb50947afbcdf3ffe3f9b929a5352ea9', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('0aabf963bee9485780c3351123b58f8b', 'lxh51caicai', 'f313819d72d2b7a4b308d72d600a3ad3', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('0b657915618741399ac6e3c86173d9b7', 'qw2q81sss', '43c95a4dc70d5e51e353cab02f5b7ee1', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('0b715fae3ae04b84a3fb2f8f3d3e4077', 'qw2q70sss', '1ba1d93fed79248d0e6616292e13563b', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('0fd8af0e419f4eb9a505b642160fe465', 'aaa74sss', 'd7d7cc244ebbf5ad08e1e5dc2d350d9c', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('1', 'root', '1a5b0bf6f536e21215e3305ba0058092', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, '2778763221@qq.com', NULL, NULL, NULL, NULL, 0, '2023-04-07 01:27:53', '2023-05-12 20:49:47');
INSERT INTO `user_info` VALUES ('1059d20f95a749c7af75b3b874c9485c', 'lxh84caicai', '46c5bd0e071661147fa23d3d2e208d3b', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('111581629b024858a462ca41c9a37fe3', 'qw2q86sss', 'ed381d220d7a1f5bcd6991d73637d8fc', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('117d3f0eb9e147a7a572fd60b2e210b8', 'qwq78sss', '13fb97620d70ae9c5a0f537ac13a26c3', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('11a49c668ce94ed097aa7c5244bea9ca', 'aaa5sss', '1b4200718a56ebe7f44a74924c83ac70', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('11fc52bf40104214a2980b785c93e497', 'qwq40sss', '0f7ae30a5aa222bef9c6c403fe362731', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('122b56674d1f4844998a1650091dc830', 'lxh6caicai', 'bd9c73e40cef8e9786b839f99662c6ed', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('13106c57502c427dbc5489ab34196ae4', 'lxh71caicai', 'a95c151167250a86b0f2f05489573563', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('1374c0523c3942e286535407af39680b', 'aaa91sss', '1bc55b24dc5745b1e22256769ba2e8ed', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('145d1807a64b4395af32de2799e00ba3', 'lxh67caicai', '56d82575548d07a8a7e4676a9e109610', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('14da1c323706435c94f43a30c59f8ccb', 'qw2q90sss', 'f156afadcc0887e1d127db07636e819b', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('150522e5f6554d20b28b0c97a1a313b2', 'qwq10sss', '57c6d5b40c8a1c8392f12acb2f771501', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('156e5c230dc645df894645f46f98bd3e', 'lxh88caicai', '029acaa050cbbce5431794068188fc34', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('157026427da04336929f8fb7662f08bb', 'aaa62sss', '18e0b4f1c7c5bfc2900ab9a54726677b', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('15c535f043ff48beacefb16f5c3bd7b2', 'lxh82caicai', '0203d308cab693a7bfeafd63251988c5', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('15caa925bce844c5a15d089f944cb86f', '3', '4b29b56a563501bb1225080ecc869c89', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:15:42', '2023-05-06 01:15:42');
INSERT INTO `user_info` VALUES ('16a2b8ac4df345b3a81279f7f686b053', 'lxh14caicai', '9ade2f608602c1f3bc2b350e2aef2990', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('16b4f27bfb9d4f2cb1cd75b8057e2d16', 'lxh86caicai', 'afc57754619898f292bebcb56eb92aed', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('16e047acbf15451290408f9b77e303f5', 'lxh50caicai', '8f22461ee60d706c6049d43b3298f397', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('1835b594b0fd43b795fb1d28379b971a', 'qwq73sss', 'ab64e07aba2e76bbc7bfd82d07d05b95', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('184dcb0cb87b46f09e6d4518ca5a45af', 'aaa71sss', '39c34f59c731b620e478156bcb15e446', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('18cb3a9b3b124a469158d5381f73744a', 'lxh73caicai', '3c1e3ed02654f4156dcfc43382bec129', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('1b1559a734084fe1b8cedca8a873698e', 'qw2q4sss', 'a200a9c182bdcf39a2dc5b6b2be764f7', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('1d18e422a9fd4916b99bc928ef7783c5', 'aaa69sss', 'da362f204dfc4ac17d7da8d3db8dd70c', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('1d21781e91ec4bfd87edcd11efa97da2', 'aaa78sss', 'ff02229c2a66816e4d2c16faad74fe40', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('1e21e301209f465bba12c8c27dfb2753', 'abc6abc', '788f2b5e36f0f0f133ab99d1862b5d7b', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:08:39', '2023-05-09 21:08:39');
INSERT INTO `user_info` VALUES ('1e884535163240c896f1e72b06d58a19', 'qw2q38sss', '4c42d588902801f36cd7c4f6bb042159', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('1faee900b97d459ba387081d42e8a2be', 'qw2q61sss', '8d58d7432d4dc7582c1dbee988266b9b', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('1fbecc8d4b8e40838923479af95e0d3a', 'aaa85sss', '08d8e3e2d18297c9d2366645b67c02e5', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('2077144f6c2e4986937fe0924c24790f', 'qw2q83sss', '8724624b8aca02d4b02500bf09c6dcff', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('21225cdc22f3429fa0ded5256e4e809b', 'qwq97sss', '44d3c77fd8d5a3bba1a1494e4df0e1d0', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('21d1f1af9f404309aa344635082c3559', 'qw2q47sss', '0788a0c638a33757c7c8a9edaa03f6c3', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('220096cd878f40ce8809bd1ec049d7f3', 'aaa58sss', 'cd0756c47472133aff429e527711edc6', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('23de1837bfbf49ebafa670b585b0d220', 'qw2q9sss', 'dcfc373132b10e2c96832691f3acff1f', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('24579ed0c60e4159b3b830155b0dbcf3', 'lxh0caicai', '8d8461a83c093e5c0a2379ee1429715c', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('245e921ffad34de18099121aac72d4a0', 'aaa72sss', 'f317225c3716374caac9165eba3345c2', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('24edbb55f7cc44c2bd965a58de3d24fd', 'aaa57sss', 'fd290d1f88b5a8f6e801f8638c998c02', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('25a91161a9164ae9a638bf71097234ed', 'qw2q30sss', '8bde8712acad708ed61d6efa136582a6', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('26056682369f4dc28a061db3936073fc', 'qwq26sss', '1308eb633df71ad86fda4dda3e8cf9c4', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('264f1c32743f476f84b368405717158e', 'qwq41sss', '6ce1b839fd1943f0d15c96455bc5c353', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('2692a1a8d39e4b5ea2b09c50957f7c23', 'lxh39caicai', '1c8cfd60a3a0d14175253ce1fc810f3d', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('27794e12eb064f4e88c8c055e709cb9d', 'qwq11sss', 'b7bec3070f908fe50074d6a01b2364dd', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('28761360c7ed447592b70e4d3dd5201b', 'aaa42sss', 'e66842d4255ef4dcb3650c9c3bab9318', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('28c170755ad2428aae288e2703bbce03', 'aaa29sss', '3557688254b2e93cbd7f16d36c6969dc', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('2a8d32d1cceb48b2a562079d3f426dd4', 'qwq84sss', '8482ba5eacef37e226b5aa5e20f13798', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('2abe5fe68f4241839b6d613f56db52d1', 'lxh36caicai', 'a63fecba51359733251a632e2d3095be', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('2b3de663e587412f882d1cce83c706d7', '2', 'dd2aebd15dccc90037d4afcf171b13df', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:15:42', '2023-05-06 01:15:42');
INSERT INTO `user_info` VALUES ('2b8c38a1466b40a78b5d0afbabc4f3d5', 'lxh45caicai', 'b6b211a381f73bb030d0f884f49f6ecc', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('2c2dcd8aa8f349a9a849c1b3fe18d688', 'qwq37sss', 'f4c6b9b5df181c0ab533d50d6560c9bf', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('2c7ba4628d48415bbcd6732273e657de', 'aaa25sss', '7fa1451a694eddf39f73ba01eb00e949', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('2cd420e7dafc4efaa4e3879f2d1c3a42', 'qwq28sss', '587896ca194a9fa916e94a05824c1324', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('2d391e23eb1841188a75272522f6271e', 'qw2q77sss', 'b8fb21b405800ed9e6060b875ef4743a', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('2d97bdd084834f9aaf4712308da1a8fd', 'qwq44sss', '12671e905e744b7f6d95695e9c505437', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('2e483216acab485c80aeeeba7719e3ea', 'lxh56caicai', '71c1a58bca8eb0df2d11e44ab519c047', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('2e6ccc31d39842769040f394788612ff', 'qw2q51sss', 'ed2597e7cd01e4cc72bc08c74f4960d5', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('2f1a93d640e94b1ca84fd2e88000de49', 'lxh100caicai', '2ee65a1b4beb1f9bbaeca1aa499a537a', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('2f98628beb814e8dbf2e9e0409ea3fcc', 'lxh16caicai', '3a1211747d779a05090f225e4965db3f', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('2fac493ea0624690ba77cb851325771d', 'aaa93sss', '76e925acaa5501f8bbf44ffb021b949a', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('2fddf8abf2e94c2aa3c171855549bf98', 'aaa54sss', '9328907dedf05f1d1c1118fa45e18702', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('3102f8f8d3294821a7b09269896c918f', 'aaa33sss', '2c63ae074ab92a2e75d2420d621c513c', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('315c3ff6d0f648f78b7c2a05f939a637', 'kkk1qqq', '4f9fc58b3b052e7b77883c2eee20c59b', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-12 20:25:41', '2023-05-12 20:25:41');
INSERT INTO `user_info` VALUES ('31e32a03e55f4337b21e99981e9c0970', 'lxh77caicai', 'f314bc01481832e1bbdb6413bcb8bbdd', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('31eedf8ed0364038ac9cc1871e83a28d', 'abc2abc', '4a8da9bfd30754098530b9cab457e4d6', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:08:39', '2023-05-09 21:08:39');
INSERT INTO `user_info` VALUES ('31f1f36f649e48719e7aec74c04c84d8', 'qw2q35sss', '162ac9829a3b4de96d1b57b3d7fbb1f8', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('325349216c794dc3afc4024fffa7e0fb', 'lxh61caicai', '5180ad0dec790e2885786b0584d99e5e', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('326cbf2495f9449d840726e551b7ccfb', 'aaa100sss', 'fb48e941a451fe6ce80e58ed17918925', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('342f411e3ef94af59cd61ae36ee0612c', 'qwq13sss', '93123920e8e0ed30764f59e057a4078c', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('344e3dbcd2df4b588c20fd2835b80ccd', 'qw2q40sss', '238a439f58497a1c14011d40dbe8b6a2', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('353df3538e0a46cc961f5bb287f129ef', 'lxh35caicai', '1e9098969754c77d23c08febd9d33e7f', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('3578f118abe44946a2c874ed2c0083c4', '5', '401e5a3a20ab09bce7602c647fe02217', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:15:42', '2023-05-06 01:15:42');
INSERT INTO `user_info` VALUES ('35989086aa0b4b5e82ba2ac0f09dbdf5', 'lxh40caicai', '5d02a97d1b0298f4e3b2de9d751d80bb', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('3605de92ad8e4af4ac1ebbfc4fc8cb2e', 'kkk8qqq', 'a70d6a20ad27388bf982ab221222bb48', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-12 20:25:41', '2023-05-12 20:25:41');
INSERT INTO `user_info` VALUES ('36688c91ce12463a8c2ee0bf793bb322', 'lxh28caicai', '982e9c6fa6b56b8a961f5abca74c4695', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('36afedd8b2cb4168b1d6ffb537d00525', 'qw2q65sss', '242c92949cef8813d5014d724d0ae152', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('3701afd5c368442a86827aa6419e0995', 'aaa1sss', 'ab081f80d64f26631ce664cbff6a0655', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('3754d4d227c94656b63362a4ac4eb647', 'qwq47sss', '5cd664979d66972076668dc8b7a50966', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('3a20618e6e3d44ee815bd7855e200368', 'lxh76caicai', '0761831471429b93a1b95c851aa0382d', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('3a36ad8601a6477d8aa649ddc919e37e', 'qwq2sss', 'f0b753a35e1a7601ef43ce79ed720bd2', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('3c5e8ee696d24f0f82f2b054c3f6d7e6', 'aaa63sss', '9aa058696f26e304ca59c452a43439a9', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('3d55fea87aaa46a6acf8d843a1468226', 'qw2q15sss', 'e9e4ef8486c053575ea8cb04a6b99dc3', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('3d87ca7fe9f348b1bf6a4c491b94e059', 'lxh44caicai', '2f30f7ab1a9b1de17e06259ab8f03fb7', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('3e46cbc27f0b4a018c5207914fd9de8a', 'lxh83caicai', 'ebdc2293499f2b104e70be53ec601eb6', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('3eeb2d58a2ff42149fb005c1c6581320', 'qw2q66sss', '72f58f7067f288ef814351e4a2082f25', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('3f902b2315ba4c09a0b942ecb7e938a6', 'qwq24sss', '1444bbde59426e1b3d7d9baa6be025bd', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('40864eae5da341ef9a19effda50f3f5d', 'qwq92sss', 'ee46e7cc0b9918df93b88ec2367e59fe', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('40ca10c0f3644e0f936a2d7ae3faf05a', 'lxh37caicai', '79f859fd461d6df44912ce26e4f39b9e', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('412d2015a0024278850398ad4ba61132', 'qwq43sss', '95bce77670e3ac4bb1878748cb7efb78', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('41534b2b6fbe43cf8accd0960d21d5ac', 'aaa55sss', '2c9cfd7f256614a1ef60c757e1c5ff44', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('416f5e4ae2c54aaf8fb67668a5c67893', 'aaa10sss', 'c1c88c90f78b3fdefb23e0b2b78b2dc9', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('4197a7eba4df4ff2a3e61d37a06a0f3c', 'lxh41caicai', 'c92d3bf7e507410bcb8d966929c424d3', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('42acc786b6b843ef8b0ba87c710036be', 'qw2q1sss', '9e7b83e93d6ee6eceb1e41bbe2dcea00', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('43b912b8d0a44794a5a0d983ba216cc1', 'qwq100sss', '30907142929522f9a6e5a19a456e639c', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('452396b08cb04ef48f6d4618241b2508', 'kkk9qqq', '022c9d698bf23ef53a89170106130110', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-12 20:25:41', '2023-05-12 20:25:41');
INSERT INTO `user_info` VALUES ('455dbe5bce3f44d2903f26ceae9ad59f', 'aaa2sss', '379bdadd805d48c71227b138e4979ea6', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('45c191a84e6a4002a2a503e7f15ff079', 'aaa48sss', 'cbee9e49bb7778937da8f61c979fcf34', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('46563b9a2329498a8fc1f99f2db1db10', 'aaa26sss', '1df58baf5bd0980d9118cf3749ad7fd4', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('47db77484795460baa65f3d1d21fa4c8', 'lxh24caicai', 'a950999f12d6ec0505e27370a9a7e3a5', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('494f3410f72942689b052309dde1d010', 'aaa11sss', '723120388685f8a06800c9c61111ac44', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('49e10db996234ebdba7f241999710ba9', 'lxh54caicai', '3b37788752ff4b42a8f8942b1ae7a061', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('4a0f2198f58243a7a51f9cf4a7773b21', 'qw2q67sss', '6f6eb8ce8e6c5700097f180e089ad963', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('4aedd26f23954f65b1659ffa7800d1b7', 'qw2q100sss', '78a6dca43484102a863563a70cf35fd6', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('4aff9d2af7ed4230818a4dace6f8978e', 'qwq87sss', 'a002c75e31d1c8f38ae84f79ed02eda6', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('4b10a50c4ed84cc59789eaa0d42b6771', 'aaa17sss', '163d97b2b4915f477143c60c19e7c97a', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('4bd7a55994b747ec9f6a3f643ebda36d', 'aaa20sss', '150491c8e69637a7ebb727eeccc63c02', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('4c05b7e8d785482ab08e235c62416486', 'abc10abc', '53d87ad97bbb028c53b1800a9af46e94', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:08:39', '2023-05-09 21:08:39');
INSERT INTO `user_info` VALUES ('4c130f4a245d409997bca875effe23ae', 'qwq90sss', '04adb9e124148c428accd2f5262cfddf', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('4c2b67f11d634355b6135cdb70cd4b14', 'aaa0sss', '7846e964e0efa3bae1371bddb2b3bb5b', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('4c2d7feba05342dda668ea9202f2cf21', 'qw2q31sss', 'c69998dcf9ef968a82e8bdc706158547', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('4ce9912bdffd4f07abbdcdc814278a97', 'lxh27caicai', '071caa2a34f5c671ab557f59b30d6c39', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('4d2ce36554b74b29805dae33ecbae636', 'lxh42caicai', '3c3c4cc7e1eb75080bb4dcd285094c04', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('4e152da6b55a4b93ba72cca8b0a1e98f', 'lxh19caicai', '4d0cf0ed8ae5c986b6db12d6d3004512', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('4f2b561d93c04891aafbf20c91573e52', 'qw2q87sss', 'b6acf86c1d643c6f19f96699934dcff2', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('4f3efdd2fdec4164b85276abd07b09f9', 'qwq6sss', '2f52fc4b66fff37d11c63984ec3e572d', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('4f946f2a47de424f95d8e1e0e7b535d0', 'qw2q27sss', 'a898d3a79946a7cb474e549aaa0a2f88', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('4f97e9f5860140d0a9af7d0b93fd9e89', 'qwq45sss', '84a1a274a18a39bb6362e857a8ad6036', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('4fe98a210d0842c98713f140c525865f', 'lxh4caicai', 'c668ee093f6096fc5c8868cc066a5a48', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('50b8ecd6a62e4577a723e577ec61b2f7', 'lxh38caicai', '286ff09ae34be8f14e7c7d8928c561a2', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('50e5abe14aad4c459f08156f1d316772', 'qw2q69sss', 'cbed269bf654b276d1d936e5c0d3a5c3', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('512dc1a99c294405944276aaa3002a0a', 'aaa53sss', '18ef3e792a5b55f105acf34bc7e7f964', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('5209d551064e4bd49ecd30bc79097bce', 'aaa15sss', 'f47d47953573c65165134b605f6ef8ab', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('52a9ab971bb14a7e9de2dbd0b9b6dcd5', 'aaa98sss', 'ce32249e4419466ae142f9188a7fcd35', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('52c4176536184deb88656832dfdeccdc', 'kkk4qqq', '2d8b2ed762c9e081da6c95a42953df1d', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-12 20:25:41', '2023-05-12 20:25:41');
INSERT INTO `user_info` VALUES ('530a1e676cc3428aaa6f0dcacd530b58', 'qwq53sss', 'c35f6d1c58ddb2e20d95bb17121b4435', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('542f448bc2be4b1ca97808bbf50915ed', 'qwq29sss', 'dc0ec24fb6099cf8e785990d940569a8', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('547f9fe0ae68410f88f66068499a15ac', 'qwq81sss', '180b497c3970063c9b33b7c25a6a51ee', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('54acf4f404bf46038bfe75b5f00fbe73', 'qwq5sss', '45fb95a8c2720f0dcadf42c47f15afab', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('553507c55d3c4260afb767e67a3fa773', 'qwq72sss', 'a5c9103d8ba6d69717ea956ca8d5b06a', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('555d1bd8fead43cd84723b3c7053253e', 'qwq33sss', '6853ed5d88d9188b6bcb360a5455a9a1', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('5566979f8963485a94fa488594aa1e17', '0', 'a93c12aa78dece0032913064124aa3ce', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:15:42', '2023-05-06 01:15:42');
INSERT INTO `user_info` VALUES ('56ab1fd5cf9c44818f1f943078a8b710', 'qw2q72sss', '5b880e38af10756cba53e0ac14335489', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('57ab1c550ca344c9a454d315bac1dcb9', 'lxh91caicai', '378e310133b2e394643288ea6429ab2c', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('57fee3abff734fe291a0061b7de3c078', 'qw2q7sss', '681c2ef2bc242a8e2742ab24328bf3fc', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('58348e2e0758421e87b53d7af46bebb4', 'lxh66caicai', '2d9d7a7951fc07de9452bbd0702d12d1', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('58580ac4917f49bd8b5d712bb574eec8', 'qw2q88sss', '2052aaf75786b500f042024013132242', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('58aeef3d33c642adb24f556a1fc4f0bd', 'qw2q64sss', '8cb87fdb39df12366a1396df56b3cff4', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('59244b26e9e048daace89b409610c78f', 'qwq76sss', '7ef7af41cf51dd61da3d80349b51485e', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('5978594be7a94a35b9c1d28304613fb9', 'kkk2qqq', '7bf4f9cd25ccfae0fc068220dc7b20c3', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-12 20:25:41', '2023-05-12 20:25:41');
INSERT INTO `user_info` VALUES ('5afbe007bc6a4940ae2455c2a37ed971', 'qwq35sss', 'd4ba108273b52e1e13a86ce7b747bb44', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('5b178f92b8cf45f79ea919355484a0a0', 'lxh5caicai', '1391e3ba8072dbc44228d764847cc906', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('5cae094d92d34331899486b79f54e209', 'aaa60sss', 'ce58788f5057188841b9338991adcf1e', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('5d5847fd69084317b46d268b6e05f3b6', 'lxh70caicai', '7e8aef51f0f216d912b5bf33cfaad906', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('5dec0bb7c40643fdabb24f0095a08beb', 'lxh8caicai', '66436a61f7fb1521c0daf68d7ec33048', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('5e95259794994889a4b158cba8b39b89', 'aaa22sss', '2495dbbc7e8795061aa61c8e0dbe6ddb', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('5f3c392f493c4044a61c6ddbd9e4127a', 'qw2q85sss', 'dcb43f3857ae2c6b36fa2a1dfb11a95a', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('5f80cda0ea92463fb77a8659bbf0a56c', 'qwq79sss', '89c151189734a34101afa55129f6d204', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('5fea6ee4d4c64da2920ca592a491a547', 'aaa68sss', '83bd9ac61a27c595a8b224275c57874b', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('6017cb888e284adaac2a3b3c0994c5bc', 'qw2q89sss', 'c0f0c282f6d341b0a191ec34fa70b60a', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('602a9cecfc9c4c10999ca3176327e6ca', 'qw2q80sss', 'dfdbc4dda38b1d2e0a32006ae39fd607', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('6058681f3c1749cd857e8a0844f51577', 'qwq39sss', '9483ace2cbb5e5a9a95f70ebbf220b18', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('606ffb7607594857a2221fc77651a86b', 'aaa27sss', '85459122ec9d5eac07837a98aedbde37', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('616118362cea4ae18a736ccf898378d3', 'qwq57sss', '859609c711da2359fdf0249cb0b515de', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('624ea97125ed4c4f86278cf4e0f2f652', 'qw2q19sss', '4b761fb8d50f88301b59a3d046a691ba', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('62595c4ccc864be9bbd84d94ff21e0f4', 'qw2q63sss', '51f12755bc70806846b49e9341b05315', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('632fbba8a5a34f209538eb1f8f56d6b4', 'lxh21caicai', 'd40371dd3b1011dde53ac3be55807520', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('63925f6cf1a84b30a9ef5996d5e900ba', 'lxh75caicai', '54d18596ef5df127c35405e918513e2f', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('63a54b01e11f46b3a923cb423d72c5b3', 'aaa30sss', '511d19e53b2fcffbf69515c46a3aa09a', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('63f8c8a1bc0f41aeb07b5f4b9afb1e6d', 'lxh85caicai', 'f0bdd462762f3e37aa6c3eb709071394', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('64843d9eed804ac891b6a7caabc02876', '4', 'f6bb9706d09c7decb6ac15dfd4392efa', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:15:42', '2023-05-06 01:15:42');
INSERT INTO `user_info` VALUES ('64dd0808363e419392dc233677ecce20', 'qw2q23sss', '20db931cea1bbd685c39d47fe91a5fd6', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('64e4e6559624493ba0a7603f70eb8df2', 'aaa12sss', 'ed65cab86fa4af75d323a020391743ac', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('650446277f2b480b961b6acf830ad065', 'qw2q91sss', 'be8bbc5d837d75b4ee459f2dfc1af32c', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('652a06335f0a4daf8d1c810e91ef84eb', 'qwq52sss', '669a65c55d787f55bc465e25495cd401', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('652b4d46f7b34546b682fc58d7427e01', 'qwq38sss', '6296b97d98aba03bcc9c8fe9c6ae81bd', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('65637d34be8248d094fa9b375fabfb22', 'qw2q0sss', '7d2b05b6430d0c796b8d3703b1151f39', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('65bf4299877f4ba5a44cf721aafc0e32', 'aaa67sss', 'e9c882703dc473642881d03db97f19f7', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('65f0b60bd2994bc492c40b57ea872a72', 'qwq1sss', '50c36275c1320d3bf7b15e46fac3be73', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('664970c7c2e24f81951be92bd1891814', 'lxh57caicai', '67ff082b996e55931dc5a72b28eb7fed', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('66876a7543dd48ddbb4894d6df6114cc', 'lxh1caicai', '3bc62152064667e75e63e3c2150641ef', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('67977e5ef3c64cd8816835a3972f4c12', 'qwq85sss', 'b637cc9e5263072111409461c16550f1', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('684f5c75e46f4a55ac79c04f6d37152c', 'lxh79caicai', '1d26f4339f39a375a7143807737b0b52', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('68687098fe18428c9d35e4206ec0eb54', 'lxh9caicai', '492c40abbcb7364cc4d9c21e18396b65', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('6a48846f7e734a668800ac71baa010b9', 'lxh92caicai', '974c05625c23e02053132dc8774cf505', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('6b525ae5cc464a9f9a530083b5044494', 'qwq91sss', '8ebeafdda56ba37dbc3ba1de3b5eb306', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('6b9e8a5c12cc478f9347d1e79fa2a8e0', 'lxh18caicai', 'b7280ee9c5b4a43c2a8217849590543f', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('6bbbce3bc8c94ce2ba6840a25a3a37c6', 'qw2q73sss', '565c0618a2f4b93c4aca1ab6a8d5dd8c', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('6e1a40be34344c5db90624778d9f27a8', 'aaa36sss', '83542edeb3a155895396f44e73c67fb6', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('6e734aba229c479689db7b9f7074c8e1', 'lxh23caicai', '8d53ff22a7d0c613c76f3b61791e760b', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('6fee6ee82c1f47efb5baf6491477d2f5', 'qw2q71sss', 'ec5e9730e979b18fcdbe05e72da3a0f2', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('72b0fcfe41844a608b9d06a1d7b596a9', 'lxh12caicai', '04ac78c776f5158abae45830bba08e5b', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('7414aaeca87d463ca100c73f29798bf8', 'aaa47sss', '2bd6671b2babc3307c12e3aa4ee132f9', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('7464c64c54d7444a8aa0de350e9a25b5', 'qw2q10sss', 'c35445a8fc2de904ff16d4abcb1e8320', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('7731835d18d04d1087d2dffbb7e640bb', 'qw2q93sss', 'd9faefdc11b12167ddec2ace9ba4e98c', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('778f50a6e6804cf3bb61bee638bf4012', 'qwq4sss', 'c577514f8be22d13f7a13c0c84cff56d', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('77b7d1e6b3094348ac8a30c3523df550', 'qwq12sss', 'a5e128dc8c36435f0d952f83d3f090bb', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('7840179a40c3496cacfd94ad070bd3db', 'aaa50sss', 'e3033ee76e635ee6590acc2b7fa77542', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('78a8a7ecc8564ba0b773b14eaffd4615', 'qw2q56sss', 'd797562dbb4ae18318226f0c555767ee', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('79781b55854a4acf9354fa932ea2c028', 'qw2q2sss', '2db243396523da243143336e16f3e3e8', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('79970b3bad014f2e897610bcf0af3958', 'qw2q5sss', '0ed739696cd27346d3729ee852718d6d', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('7b73d77bc2ee4478868f6b0e6e475a0b', 'qwq99sss', 'e6e4ee5f3d2619e06c030494daaf27a6', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('7bf8f052e1ce4421908307159a2414f3', 'qwq67sss', '59728aa45365ca4f5a64972ffbe27f42', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('7c7ce6ae5e634e928263c3c1605d1da6', 'aaa16sss', '4488929904f9a8e07206107aed8b68eb', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('7e050dbd92714bd887dfe6b7b472441e', 'qw2q32sss', 'a45447da2726b44575842d8e0299d9ff', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('7ec6a1457f254089987a740709f109a0', 'qw2q82sss', '8e85dc9e2f570a36aec072fbf4fd711c', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('80bc874fb12b4e3eb775faf59dab1fdf', 'qwq96sss', 'dee619181309688a335aab645f674014', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('80d6d1df0e8e4afdbb232912af02ecd1', 'lxh65caicai', '262d0a7598032ce71bccf9f18f2681df', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('810f3254c97a41cfbc2de94af3991f82', 'lxh96caicai', '5abe5d1c492ba7457f15bbcae416c634', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('81329d68d21a45c196e99c79d650f69f', 'qwq66sss', '2002079e376e489ea557f72d0d8ab608', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('8143f1683ef64f54a0bf32055f6cde01', 'lxh11caicai', '8a89ba63abae0f4f35ce47b905929e92', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('819deedf39674a4480fd6b620f74ea6b', 'aaa65sss', '6ca2fe0e71a1ace6a5b13181345441ec', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('828558666e8a40b080206dddd17c51a4', 'aaa51sss', '73b53bf6bdcd759e6b9f82aeda12b230', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('83462148c30a4f908f56f91fa1976b61', 'qw2q96sss', '40f20887cd8f38c3351b947d2c8a13ab', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('8381fe679e25473d8bfcd5fe6ea59436', '8', '9838b273afd1d030c4a8735d3c75898d', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:15:42', '2023-05-06 01:15:42');
INSERT INTO `user_info` VALUES ('83d37ad0db3e4539acdb77053838179e', 'aaa94sss', '1f2343a73045ef9780e5b59a4660b0a8', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('8417be5a43694535bc24611490f06488', 'qw2q6sss', '6c042ebcaf34ff5b7b8819c3c0367639', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('8463e213ff72441bb18c134c3efb4445', 'aaa35sss', '7a1fb266b764449e4a5346a4cc8b5778', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('849e8d0dc7b74169a83d99d1edef9586', 'aaa21sss', '5f623d77d3ce6d0f30f332fb97791a30', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('858ae05bb3ed4dc9b460e92237ae0556', 'qwq86sss', '49f0661f20f8eb75b992bd8c02780bb2', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('87fd981ef0ec4fbba436d96a26f0a7de', 'qw2q98sss', '23cc6cd1ed284fc8cb2bc1c0433b6c21', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('8901858986044713ab6a1c8c456f0e05', 'lxh52caicai', '136d9bd671d680e2358fac1638032e47', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('895f7be9889447908d8d3071fe71a633', 'qw2q8sss', 'a700911bf52df6d996d7761f5416b4e8', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('89de57e0833949db847a5e0ada49e9dd', 'qwq31sss', 'cf831ae3a1a78b47995bf87c9b04a7f8', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('8a1410e7763b41678942411dcd9191a0', 'aaa49sss', 'c7a21d74ce9a714f785dab12e37880e8', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('8aaa65615d124b94ac2801c20ec11bb5', 'qw2q76sss', 'b54fe578e581ea4111daeee062551aeb', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('8afb7ab2f9ae405d986a7c5c9321e1c2', 'abc7abc', 'c3a7cc136dd18655005aa1e353838d8d', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:08:39', '2023-05-09 21:08:39');
INSERT INTO `user_info` VALUES ('8b0d1d8e0f1f426999e6043c98dc8698', 'lxh58caicai', 'c48a5e924c7b389563e4d8842e78934d', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('8b70495dea6d4e4ea0bc5eae889a8fcd', 'aaa43sss', 'eac6c129f8feab83b151d4de7ccc29e3', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('8bd7d6c2e99c4f2893a22c70d92af241', 'lxh10caicai', 'ff03a5384c3a23bcbb41eb2430462c2e', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('8c8e0507f8bd49d68f57dff3e9e69063', 'qwq74sss', '3b0bc15152aa2ce31c4389d9a7aa628b', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('8d33acaa1fc74f3ba60ee7333430f6b4', 'lxh20caicai', '2734997dcc63c7186d245c8d93ea38ed', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('8d410c51e94545368ba4ec5af9bdecda', 'lxh13caicai', '5296c8cb0bb26fed921160ad7da3395a', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('8db44e3d2a2a4a13a9f7af4ec6499f9f', 'aaa56sss', 'fa7b880462c3b64a9444558326bda937', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('8e2526bd86cd4cebad5d8da09f062bab', 'qwq80sss', '6110f12234b37e7ea84ca4555ed53b00', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('8eab5435526b486888f5254d8eeea887', 'qwq58sss', '9530dbec26384f8037fdd4843a543164', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('8f075f44c1cf40ed9059a3ac73eb1a0a', 'qwq23sss', '577f0181228fafd06654260dafe8cacb', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('8f3a0ac75c0a4e75b1c03c72436c5ac6', 'qwq42sss', '422c738136b39414b5e9f212faef062c', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('8fda6af7738e4d0b80f703bae1ca8e3e', 'qw2q97sss', 'c2d6d0cddf8d1a6f900c8c98a28cf4b4', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('90550f2c047848ff8c448184b981b474', 'aaa19sss', '8b77cecc45d2eb331ecbc7095620dbd5', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('91bbc85c9aa04477aa00cba9f5549dfe', 'qwq19sss', '0695114240411fbf89daed569c1b61c3', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('92f6ff93bd6b471899168507a4a396a0', 'lxh55caicai', 'a4e3eabfc14812c09f97e3a8f5f2cfbb', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('93454ed8c4fb4cc99381ac3a5ea7d962', 'qw2q25sss', 'b424471405e717469919b7312867ffb3', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('93900bb2e1834aaa98b8aa97c449ccb2', 'qwq20sss', '63cb07ae6ecc6b4ee65029cf9e01ff5d', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('93ea4948e3a347799f56783f7fe1ec9c', 'aaa37sss', '76148d8d5cbcef9ee58084fa02b54369', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('95176b46ae6b435d8500d3723245bc2d', 'qw2q45sss', '4f704b0ef0156d61c6fc41238b61663f', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('9519370c7a5d4a4e8aed3f1a7c093f96', 'qw2q92sss', '77c880e0bbaabbcda01949a41a18ed30', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('965743aedcc4496280dbc378f88cd2a6', 'qw2q26sss', '6e1ad8a5fa01e269092fa23e8b6b3fd0', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('983002e42b094577bfc1450f29344123', 'abc0abc', 'a245cf0ad64d13875f8ca35422c33978', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:08:39', '2023-05-09 21:08:39');
INSERT INTO `user_info` VALUES ('98cf0561cb6e40948294fc77fa1f701e', 'qw2q13sss', '73b5f278f1f8f2d261c068b471d04ee9', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('9975181284cc4318b3033f91dfae5677', 'aaa84sss', 'e1dc1b738c7bd58ef2f85a0bd4353b5a', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('99acae2046ec4288923d21ec90616b2a', 'qwq16sss', 'cd79bdbd6dee8671b0f1331ba802aa3a', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('9a6d708da8dd40bcbf4d42ba319042b5', 'lxh30caicai', '9f2fd01a510efd5692c9955593d83d42', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('9b156c76400846c68a1018cd3a209c95', 'qw2q43sss', '95e3f5bc7dcb6962a953f41810433613', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('9b78f3684f93442194d742cb7ef1b746', 'aaa34sss', '239e002d7a4035aa57efd262d36213ed', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('9bd807d1abde4f719b22b4a319945730', 'aaa24sss', 'c68edec9c3397d973019bd0d8199a353', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('9c45185e988348bd9cccf6b9be07ce77', 'abc4abc', '1c1821401a47c3a4d19ea507a2256608', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:08:39', '2023-05-09 21:08:39');
INSERT INTO `user_info` VALUES ('9da55b32438e408698bd64aa3a86c474', 'lxh97caicai', '63729a8b57c07a8cfd5c27b8a82f741b', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('9dcfb031ed1d4f96add97a32310f55b7', 'aaa89sss', '108dd3e6a0ccdfd1db66c24ddca1ffc4', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('9e3ca25add25494e9b43357f414f2775', '6', '92ac31ec03d9d1938ea757787d41f841', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:15:42', '2023-05-06 01:15:42');
INSERT INTO `user_info` VALUES ('9f554a31416c4aa39408221bf18fa08b', 'aaa66sss', '0b1676c72574eec0579025d705d7f232', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('9f6c15594b55471381690eeadf6028e0', 'lxh2caicai', '073903a3caaacfbbe73eaa2c084312cd', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('a0af53355faf43b7b93d9a92ec13159e', 'kkk3qqq', 'd73d6435260737bbc94ce57ae716f60b', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-12 20:25:41', '2023-05-12 20:25:41');
INSERT INTO `user_info` VALUES ('a0e146e145354146be3b430adfb09f22', 'aaa82sss', '1ce6ba30e732b4bf8cfefd7d9fae0a1d', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('a149a57f6de641d8ac49f5359286cfc7', 'qw2q59sss', '9d5a42e46ff8c5106c4c6bd541aaf615', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('a259d8b5b1e94c559fc57a4839302a34', 'qwq82sss', '51f6b483c4b1ccc80f57a0bc9cd43ec9', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('a26794e661844a57b7c77ee7744c5050', 'kkk7qqq', '36f3f0dc488937523cc1f45cf5d3c05f', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-12 20:25:41', '2023-05-12 20:25:41');
INSERT INTO `user_info` VALUES ('a359d6d691f24d2d84683e0e96682e15', 'lxh26caicai', 'c691ac9891b25bbd6c7727e53f996bf6', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('a3e07889b45644209958c76ad600d3b4', 'qw2q74sss', 'f1cb309f999408b4665a65381c56f8a0', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('a4545b72379d430dae9e2f5afbadfa3c', '9', '4d81c055f033b3a544b395408b35e035', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:15:42', '2023-05-06 01:15:42');
INSERT INTO `user_info` VALUES ('a49820d9a26b4bc3872b0e986165bed9', 'aaa32sss', '220de07924855477d738f5e71f975272', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('a59f02b82f6e4a6bbedfa5b6dbefaefe', 'lxh29caicai', '2caf82f53db793df356324f3ecee8d5b', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('a5d8587471774c809ca4fccabbe9f625', 'qwq0sss', '0e8e1079d0b1cc73a06553ef2844d3ca', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('a63dcacf41a8448982342b86b50903cc', 'qwq18sss', '8f8a481743887cb1468eb09dae143a2b', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('a69ef013a45f4354a2951974a6125734', 'lxh34caicai', '0e888377a22166b17867e7471bd65789', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('a78a992b3b8b40a7a60f007b07ff5ee9', 'aaa95sss', '275348172802aa55b3cea387734793e8', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('a83371f25dad457ab17eaa578d8653d1', 'lxh80caicai', 'c3807ce0884a47644d20bf3241b58167', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('a843c6687ccc48b39cff150b09f4327a', 'kkk6qqq', '94c6e054f4114e0e327a6eccdfc80baa', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-12 20:25:41', '2023-05-12 20:25:41');
INSERT INTO `user_info` VALUES ('a9016dc2abfe45deaf87a926363d5e05', 'aaa44sss', 'c0ce3cfdaed1bd99fee9da0d976470c3', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('a94b4040f6bd4c03a952115d38eaa967', 'qwq61sss', '6b8f2e2d41eb64e7f6ea449b881d427c', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('aa903bd555dd4e0eaa689fd2319776d4', 'qw2q55sss', 'd05288f568d3fa5b2510896f503dd9b3', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('aaa076e4492d4c4893dedbe149002bab', 'aaa80sss', '051d718c4cbcca0491caa88d73e65029', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('ab47ab677c2a4f2f9c7e5b3f25ce0e5b', 'qw2q39sss', '5d442a924266713e693a6e61c14b2708', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('ad97330d12de4e818a425c6cd8a67ed7', 'qw2q11sss', 'a2e8a8601d0aa45e81c8ddd3e9280b98', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('ae2052d09881408c92a7e870f33e84ef', 'qw2q68sss', '0fdbb017968948fc4eb4d2102dc6734e', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('aeae61ff71d04c329a6fcd4370d802bc', '1', '42b73ec3d5edfda6328ea63376ed4158', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:15:42', '2023-05-06 01:15:42');
INSERT INTO `user_info` VALUES ('aeb6ffd910f34e858239f3d53b456974', 'lxh94caicai', '02c4ee441e8385fa4d611b3d4c701fc5', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('af17f3af6ffa437b9cdb72b37511b53d', 'lxhcaicai', 'dec36be33328a09b845d01ad848daca2', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, '2034276263@qq.com', NULL, NULL, NULL, NULL, 0, '2023-05-14 12:13:17', '2023-05-14 12:13:17');
INSERT INTO `user_info` VALUES ('b01d2b1c33624d3296cf6878f0ec2325', 'qwq3sss', '98ae5692fe55d4b802ad17422c24ff20', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('b07f6640dbe34935a7310039e9ca8792', 'lxh46caicai', '7a363297b95d8c9b41ed859415ff7481', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('b48c1984823d45e59dc807e6632219a4', 'qw2q3sss', 'bbce9fa6193505d4dad07b1ae19c7363', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('b4d0569c34ef444c91d6e30c6931fff4', 'lxh32caicai', 'ba8d604eda386e4547b5c0766378ac9e', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('b5f2c044258e4bb3b4fa69cae655db65', 'qwq69sss', '0a6984fd42cd4ed64b0078dee22117ce', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('b5f8ebc88ba84aefbf87e26148f2f5b6', 'qwq48sss', 'b3d7d089f1a23884b5feaa0532c03e07', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('b5faeeb5c8144d3ea584556f9c4efab3', 'qwq8sss', 'cf1317bd61d35c1295f16ff14206cca9', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('b70ceaf6b3694d0c9c42fa794838d9a3', 'abc1abc', 'ee6f3136d944d9b32f3844c2c4d932c2', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:08:39', '2023-05-09 21:08:39');
INSERT INTO `user_info` VALUES ('b75084176ccc4787a9d237161a7936b5', 'qw2q20sss', '3203da35ca51eb744cf4ee33d402f379', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('b7b4600d8f0046f1a21a22155a334c89', 'aaa46sss', 'ae8e9ad71c87c0974d9446bdaf252962', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('b8eaa98687b448bdb3bf5ee322beb490', 'qwq7sss', 'd5c19ea0cd09fcf02a30b9d7f705d982', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('b9a023278529486696a0d5bf4bf1f379', 'qwq77sss', '23c353f16c0e360369bf4d357f533e35', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('ba1bca167b834528879577117e679d80', 'aaa88sss', '816eeb3c5be6f5a52c0a9b5e37081459', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('ba373125f19f47299f43bc8d39025e7e', '7', '1bab6f6b18fd94dfcc1b65d9b84716f0', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:15:42', '2023-05-06 01:15:42');
INSERT INTO `user_info` VALUES ('ba4a247dcdf54704b255724157ad2550', 'aaa77sss', 'd789d93c8159a5c19e6bb7f20817ac09', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('baeb9796936a422a9c808a8954b3e30c', 'aaa31sss', 'c831429e221f3a02be9a6e9084089171', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('bb3747ff81fe492ba29c8ea90987497d', 'qw2q18sss', 'cb27074248acd16582965a63c5978be3', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('bb72aca6e69349c386c8e2c26bddfdad', 'aaa9sss', '4831658b6286c752d8d5f196d586ebb7', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('bba66fa2ab2d477f8caf368cf7e06c05', 'qwq51sss', 'ae6bcfba02478b3b98af92c8048747cd', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('bbab3088fd9b476ba2a34ee3bd949140', 'qwq49sss', '7930403e67924ef6488694edb08d5b54', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('bbe13a0c006b453eb5b21f321c745119', 'qwq94sss', '99f386ae40d062ebfd1e373860d6e903', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('bd4275b7498243a78307d1e34c39d97c', 'qw2q29sss', '1571981b1e5abcc7f8ddf829744525dc', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('bdbe061e7f0b42e6830b4da93a19d0d9', 'qwq32sss', 'b46d0fd37cd72d87bff07410c24b930a', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('bdef3968994b4a12ac7e30990e4579c9', 'aaa38sss', '3369b9ab45bf88775c26e4edc58f021c', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('bf56a3d523a24d0289a9574e23f908cc', 'aaa97sss', 'e9a43e7bc221131b8969798bedf2e32a', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('bf6ad0bddfb64280bf4f5a205490cc8d', 'lxh7caicai', '3c9254bd060ea26468f321e0b083ce37', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('bfda73ef139f4fdeab7159e8d03b7efd', 'qw2q14sss', '9caa3d91decdf08e8823cb516586d829', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('c01ad37173c74ed6ac6ca09a080db5af', 'kkk0qqq', '8092e15fe2ad29e29d70810c6753a127', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-12 20:25:41', '2023-05-12 20:25:41');
INSERT INTO `user_info` VALUES ('c0348e95318442d383286654980ab449', 'qwq88sss', 'dfab0255237c1e3ec88f7be8d1293664', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('c0fa5f66765d44a2a36967394bea3228', 'qw2q17sss', '6925b8f7a8dd7fb9eb5c39b42a538a75', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('c0fd41b337784ae7a9e470574ab2caae', 'lxh63caicai', 'a88af4c662ff346a3f71821d5a9960a7', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('c2f5de4532754205aa20b249b9e4aecd', 'qwq25sss', '49f8cd9d45cbd4c3beab324b2251671c', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('c3328ab1e66847c48d553d2f7e02bcd5', 'qw2q34sss', '1624f091ad61aff4a2fac27017621250', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('c369d75b34414af18daa5a03a3350518', 'qw2q75sss', '378f23f051c3941a28a089702a5302fc', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('c3f43b10635141debf5008557744164b', 'abc3abc', '05c52680d6ad39667e5ac30d1b7b5cd3', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:08:39', '2023-05-09 21:08:39');
INSERT INTO `user_info` VALUES ('c53f0867956d4686accf263a63e37c14', 'lxh78caicai', '982b01c870a02ed8aa787b9df8303bd4', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('c768c3f5947b4a5eaf08777e8d9bd34a', 'qwq60sss', '42bad1937f415b16457709d5ae3550c4', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('c879102c80a24decba681aaac013fcf6', 'qwq30sss', 'bd3917ff4522ef15395dfdf49ff28ba0', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('c8947fbcb68344649b2f4b51cfd041f4', 'qwq62sss', '005ee5c60dae63efd3d06716db358c4f', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('c9f53029f3c847f59e163e39939f0a61', 'qwq71sss', '847d56564af13a0377510a4c4c5d015e', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('ca6915d8d78a4fe5bfc0aa0f75916fa8', 'aaa45sss', 'c1824403c9cef10c074f2135619dc00a', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('caa1e0558c1a4e0b9d6931bd18365be2', 'qwq93sss', '5be9b779abbcb68517ea8e07d557b0ac', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('cab1fa2710d2461f9af619c21fb5cd90', 'lxh49caicai', '95bb871109030e153075e4da0cb7c966', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('cb38cc5fc62746c894013dda5fd899a3', 'aaa96sss', 'e6be7e3095655efb65df649d9cc96079', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('cc1d3646042e441c9b0be6bd25e3021f', 'lxh98caicai', '100767183a6509c4f38f87d6628aa980', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('cce5cd24e9154b65a4befd97b74b2880', 'lxh74caicai', 'bda4bfc52dcdd457f169b41699ee0963', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('cd302db0f6ea4f4e8703c66598edfb66', 'qw2q22sss', '5554de004ff103866b4479e291de5e22', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('cd60766fdad84083bf8ef4775b858a4e', 'aaa3sss', 'f5008615d6f1ee204a59fa1369ee4e90', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('cd880aca32cf4f0a87eaef937e642e96', 'aaa18sss', '0efbeee2ab653efeb9de634c20057a5e', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('cdf039411e054c97b3beeca0c29f09fb', 'lxh33caicai', 'e5ca76391f53012438e248241ceddd58', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('cfbcccee10a74fc4a3b9f7a59fca11d7', 'qw2q12sss', 'b2e848bd93031104b18fe2d23c7ff4de', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('d0085b3db9c64b12a876e236b44b1a57', 'lxh93caicai', '66469bb642b0cfd9555277b471760507', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('d14b1dcedfb64f169377c9607040968f', 'aaa39sss', '5e4ccf5ffa9ece5fae6f8ced35d93455', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('d3d47a78d58b4220b9743c4b587dde81', 'qwq64sss', 'e2f8578f8efebeb2871f8cb09b30cb53', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('d45ab2362923485e9cf29db4f052387a', 'aaa6sss', '73ae8220910aa053096ec1c83202770f', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('d48468af105b45cd99b0a83b8043e5d0', 'aaa7sss', 'd921c77cbb38f3271f32a690d88f6e4a', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('d53621fd6ce643e1a4412cc6a2c30a01', 'lxh15caicai', 'e17d0fd31e20b0d6fa2c72db2190517a', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('d6286972c79740d786db38ccfb8e601b', 'aaa13sss', '611aba6c8e42d22ac95a1d96a4005be5', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('d6878a306b96403388deaee77234fa6e', 'aaa81sss', '69f33b5e4595209137df93bebf01c28e', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('d746cae8a0b340f3910cea5ed4fa7e5d', 'aaa52sss', 'f2e82479063dce38f22cb7c404c624ee', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('d78225d791aa476699e073bfa2a0140d', 'qw2q21sss', '6b507f8a9fdad5b9501f0e8f9049bb6c', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('d7bef82561aa4310b5f77ba67bb46a3c', 'lxh59caicai', '7b807c549fd9980d545f97698c0baeee', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('d7ff07448dff4b9a8f1fe121d279c0f7', 'qw2q79sss', 'bbf4e53be19e1c643072372630135642', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('d838d6edbc1a419aba994eea00229b66', 'aaa73sss', 'abf0f6c6db6735a029d701ddc961f73b', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('d89bb99d28f14e02a7aaa5a6dd6e3a02', 'lxh69caicai', '725e7b62a70bb83cbf0f35e96b16cc29', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('d8d20d9651644594b201de2828ebbf88', 'qw2q57sss', 'b4bbdcfc45254bedd8d753e3acdc1951', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('d9219566b4324e428cc7c34431d41e25', 'lxh87caicai', '4722d4ebc274b2801ccd612f6c91968f', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('d9d5e5ae3f3d4a44a055e52f7a7fa6c9', 'kkk10qqq', '154f6c52713e336ad8c9f700a74d86d6', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-12 20:25:41', '2023-05-12 20:25:41');
INSERT INTO `user_info` VALUES ('d9e56fe15e284934b6846e4885fc0eb9', 'aaa92sss', '474dbc4bcff5dbe88b44754e9cbf10d4', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('da1cc31c179548b48400ae7e34c98e26', 'qw2q48sss', '6baeb5410bc5b9811c67560673b890a3', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('daa3d431aadb42c7a16ecbd00e0d9cf7', 'lxh64caicai', 'a8abc05f0223581dfca29da9760e6b66', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('dacf29857ca54fb0a19b2c39c2deebb2', 'aaa70sss', '1aa64ea9002daa2defa967d9dd2cb389', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('daf60eae04754cea84ce3a7a6ef310c6', 'aaa86sss', 'aa9f322757d68a224f92f2648908be4d', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('daf7783ce14d4d1d9222a296dd2ca157', 'aaa99sss', 'd2eca5dd302d6d98fd33794b4e7d5ced', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('db06b2044cc64826a3af71ffd83ba1b7', 'lxh3caicai', '4c7425a9601f7a703c7ded383d79ce85', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('db92f6420c60441f8d538432fa35aaf1', 'abc8abc', '403a390b8cf02d92fd07cbe350120e55', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:08:39', '2023-05-09 21:08:39');
INSERT INTO `user_info` VALUES ('dbb237e870814b6eb9dc58abe9ee329b', 'qwq27sss', 'b809663f3aeafe798032a9b26aa811a0', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('dc4408f3ffd04f928d2cbcf36ad025a1', 'aaa76sss', 'd256f356196ef4e8afa55a4b4b690b48', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('dc68cdbf4b144116a0f322df20ac2ed5', 'lxh43caicai', '30b5f4729483e8de56a39c6c60cde168', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('dcf0cde95e1941a6bf2bc1df58a336e0', 'lxh81caicai', 'ad853bf2efb1148a4baec5e5fb426330', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('ddab3db9770047b3999d438f20218a77', 'qwq89sss', '71afe2347d3be8ac3f1b7bc1cc5783dd', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('de3de853877c4b77871d37ab4cc8d08b', 'qwq17sss', '76fdccd1fe2a05f4cb1d5f0fd4d070fe', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('de45b98df1c54c94882a30ef62626e77', 'qwq21sss', '35f69f0c44bfd1e13b9a64e996207a70', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('de73881f711842c4bf16fd3b5f6ea652', 'aaa4sss', '7f72f6e4d570f50f76f35400b93761dc', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('dec423044e6b43e2aec8ea35149ef384', 'lxh90caicai', 'a29f9847fc119d9337a634a60fbd487f', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('dfab7817728b4d3581d9542390426c49', 'lxh89caicai', '03bc5a159bc937b27a6006f6e80307c3', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('dfd1ac5eaded4af196d228b66a89d730', 'qwq46sss', '66851f300e0691baf4567aec92034f26', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('e033b5809d38418f93ebeac3dda5782e', 'lxh95caicai', '4042d741b98c5875ff338587f5a75b8c', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('e04641b5fd284a4983cb0c4b0f848187', 'aaa59sss', '2b4b6914cb0efd369f8ed09a070988ad', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('e0b9f6656eb342d98599d0cded202ef9', 'qwq14sss', '2946c683725982e6ae610d0365b55554', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('e1e47cc972b1482fa34dae21cd5af860', 'aaa61sss', '1dca9872dabc90b27e70d16f44738054', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('e2105f3c986f442b81adc5d0c609d28f', 'aaa75sss', '0f92f0514ec32dd950f2dbf73ae6c206', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('e283e4c3e63141babca0d19fe2a72621', 'qwq36sss', '27318a406b1ce90ceddf5510937b08fe', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('e2bb84821e634d4792dc7a49d6c19645', 'aaa23sss', '30c02669912ebb553712f57a8cfac7cc', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('e350bf8b8cad41d7b764f8dae2688834', 'qw2q60sss', '8879c2fb466078f76645aacc807c2438', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('e38c9e7140324ddeb2623b58fceca67c', 'qw2q36sss', '238c033591c8981b260c853d462bd882', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('e3ab671297db4e368b66565df3735a8b', 'qwq95sss', 'eeb57f705e0b4a8b2e6e771c7c047121', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('e40196c3cc6c43cc8590cdbed17a09d8', 'qw2q24sss', '9d563c6323beee7b25d64722728bd692', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('e41a4ae5a714499d96f19b1ac06ebd77', 'qw2q99sss', 'a35089001434644fdecf553b69c56d4e', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('e5a5a3796d9346d5893b391e09722151', 'lxh72caicai', 'cf4100b6986f0c3d710b8956e9aa267e', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('e5dba40dcf474eccaab450bc007f671e', 'aaa40sss', 'd4c29ddf797bb68a9e5d98d58acd338a', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('e5dc11faef8a46658acb5e2dc1245c9e', 'qw2q62sss', '2ae45aea70876cc53a2bef1c7f189b76', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('e6936131f6944c609dd7a879268bbaf9', 'qw2q41sss', 'f9181759bf5548345f3cb3ba38c24b1e', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('e693b1b6cc22401aba6e9a9f77c92424', 'abc9abc', '817537cede87bb28ee85e701a98e77fa', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:08:39', '2023-05-09 21:08:39');
INSERT INTO `user_info` VALUES ('e700c37855be42b6a591fc665372887c', 'qw2q46sss', '3d1bf5f08eb9d9ccfebbd6f3847e081b', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('e7a82177430b4547ac81d6c5617fb7fa', 'aaa79sss', 'f17d58918675a96d387e1aff09dd2012', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('e7f10d719c9f48c78b3ba0ad18b00827', 'aaa14sss', '5e1ce9881924c91d5a55747168638795', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('e815e6957ba84d7ea143cb8bdb04b9e0', 'qwq34sss', '3805ecb98da5f0e9ce3e358cd777d951', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('e85b5c413a874b39885eb47b33c851e5', 'abc5abc', '91146e440a20b8ae7ebd44548e3f123b', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:08:39', '2023-05-09 21:08:39');
INSERT INTO `user_info` VALUES ('e8897e30016e482d8ff87da8d06fa2ba', 'qwq63sss', '9f91fdc9fc9ff9be5125345e44261bd1', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('e8c5e3f8acb14bf5953d2f4c30b63732', 'lxh62caicai', '86645c8999e12148b351624c239b32e9', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('e8ccd86b35974750a25337b099291b36', 'lxh47caicai', '6a782e4ca04796a7a26588c5e49b1237', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('e975dd8505e6491aaeb106e8a92fc598', 'aaa87sss', '914d5255c35bbc5e55efa7c43d27ab40', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('ea03047ba5574fdba96b6633aca21873', 'lxh25caicai', '9c0877d9834709e54996b0c66fbf630f', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('ea241869c7f3451a914eecb1af504843', 'kkk5qqq', '362cee106ee9f89dbf8fc08cc718744e', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-12 20:25:41', '2023-05-12 20:25:41');
INSERT INTO `user_info` VALUES ('ea8445dddf8c4d0197cb151936fc9e1c', 'qw2q94sss', '741931795ba3d4032633a25b139930ed', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('ec1a92efea184568aa1f585068a3fd59', 'qwq22sss', 'ec508771ebd8275b8e0158b11f7e0de7', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('ec9da93e3bfe4ebbb7afc20cb13b9850', 'qw2q84sss', '8f64c25411360e46863899538b917f4d', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('ecaa6707279845598770d232805579eb', 'qw2q33sss', '6a202b1013657ee26eb5b96b57e1ec2a', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('ecb5390bb77c4e329c63884cf65237f1', 'qwq9sss', '98f232e3eb5e1cf918b65fa4c2cb3052', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('edb98f2680fa489c9789f9246ef479bd', 'qwq98sss', '8e72bd0c941dc80166fb526120728664', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('eeaad73f74cb491587bf24cc320b671c', 'lxh53caicai', '8997a99a7635c5773d42ea57995809c7', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('ef7940a9411b4e82b85225ee40eeb9ff', 'qwq15sss', 'e9d949ad5c65a646f87bd8269a98cb10', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('f175b04c3e954ee4ab0263bb226f3c8a', 'qw2q42sss', '01264f3b8156669c8ca6a7c11fb34067', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('f27c499a4aca4d7fafd3fd0a49952cc8', 'qwq59sss', 'a7cade8a732ad212031295634a34e5f8', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('f34695c51a7b4e5fb88ee720be1cffe4', 'qw2q52sss', '709988999d660ab5965b1a38e22c6271', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('f3a28427b1cb4972b3dd25f0f6eadd0d', 'qwq75sss', 'c2e18fc65105f2f6662f3ebc076d8991', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('f3ce83f289e0418ab175183e2cd2aa66', 'qwq54sss', '0e0ce36146a4a75d336734102176bf73', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('f465e56cfe1441748ccbf7b7bffdec11', 'qw2q44sss', 'f6bc5770d66c012dea9213484e2f935c', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('f49c3dd55aaa455480d18fe14f3ca9d1', 'lxh99caicai', 'd4add2aa2774e838d5fc580796c60f66', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('f69a3c2ee3da4cf195fbb57a7c4b3e63', 'qw2q28sss', 'a5773698568759fa1b5b9a3d007e464d', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('f75ffebf280748b1ade83e0c39a8b862', 'qwq65sss', 'd3d266dc71be0fdf1886db767ee647dd', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('f840e69ec8784a1e9433b44407af45be', 'lxh68caicai', 'f675e4cb964270e3e9376a952cfcc438', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('f868b1d349e040f5a03ddfe7ab889631', 'lxh48caicai', '6fd2337eb38c810fcbc5a963d7cfb2b5', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('f86d16976c724b5e9c063dadd72b305b', 'qwq55sss', '239462ade217477bed84338c205590c4', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('f8708200db1946d1a9066d88b0a0f2fe', 'qwq70sss', '9f5fd4b76378620e4b34602ebb9aae23', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('f8786eed11614c80a804df082ceb5beb', 'lxh22caicai', 'c60eadbb261158d9b155e806220f7c70', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('fa4edb799e544c30bcb631d90218b6f5', 'qw2q50sss', '22f5a9b42f774491af2010806b3d50d9', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_info` VALUES ('fbbe10b083744bdabf939cc7e9883e0a', 'qwq50sss', 'c1a2e527fe81384a74c3f45788e4c232', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('fc8f97df3acf4e04800392ac09eaad90', 'qwq68sss', '7dfe03736ff63fe0d0644857d825650b', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_info` VALUES ('fd3ae04892b847b7aeefa8ad62c4527f', 'aaa90sss', '0eef686dfb4ae714321fa250ad1f2c01', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_info` VALUES ('fd607ff6d2bb40ec86a08e59d323d745', '10', '9ff02dde27ec8ad35d2799bbf6f5d02a', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:15:42', '2023-05-06 01:15:42');
INSERT INTO `user_info` VALUES ('fe47d3bee8e44e7ca0f3924527552fe7', 'lxh17caicai', '38fd1103dbc367c7f215748a0f238027', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_info` VALUES ('ffb14501ad9a41a2ad7c46105e23cbb7', 'qw2q49sss', 'e10adc3949ba59abbe56e057f20f883e', NULL, NULL, NULL, NULL, 'lxhcaicai', 'secrecy', NULL, NULL, NULL, '12345678@qq.com', NULL, NULL, 'QWQ', '#8470FF', 0, '2023-05-06 01:20:37', '2023-05-06 20:24:10');
INSERT INTO `user_info` VALUES ('ffea0ff4e7664ba4ab3f7c6e9e3b8a62', 'qwq83sss', '70c2c7f5e58ef5837fe090baf234ac0c', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-06 01:16:29', '2023-05-06 01:16:29');

-- ----------------------------
-- Table structure for user_record
-- ----------------------------
DROP TABLE IF EXISTS `user_record`;
CREATE TABLE `user_record`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT,
  `uid` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户id',
  `rating` int(0) NULL DEFAULT NULL COMMENT 'cf得分',
  `gmt_create` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `gmt_modified` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`, `uid`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  CONSTRAINT `user_record_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `user_info` (`uuid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 443 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_record
-- ----------------------------
INSERT INTO `user_record` VALUES (1, '1', NULL, '2023-04-07 01:27:53', '2023-04-07 01:27:53');
INSERT INTO `user_record` VALUES (2, '5566979f8963485a94fa488594aa1e17', NULL, '2023-05-06 01:15:42', '2023-05-06 01:15:42');
INSERT INTO `user_record` VALUES (3, 'aeae61ff71d04c329a6fcd4370d802bc', NULL, '2023-05-06 01:15:42', '2023-05-06 01:15:42');
INSERT INTO `user_record` VALUES (4, '2b3de663e587412f882d1cce83c706d7', NULL, '2023-05-06 01:15:42', '2023-05-06 01:15:42');
INSERT INTO `user_record` VALUES (5, '15caa925bce844c5a15d089f944cb86f', NULL, '2023-05-06 01:15:42', '2023-05-06 01:15:42');
INSERT INTO `user_record` VALUES (6, '64843d9eed804ac891b6a7caabc02876', NULL, '2023-05-06 01:15:42', '2023-05-06 01:15:42');
INSERT INTO `user_record` VALUES (7, '3578f118abe44946a2c874ed2c0083c4', NULL, '2023-05-06 01:15:42', '2023-05-06 01:15:42');
INSERT INTO `user_record` VALUES (8, '9e3ca25add25494e9b43357f414f2775', NULL, '2023-05-06 01:15:42', '2023-05-06 01:15:42');
INSERT INTO `user_record` VALUES (9, 'ba373125f19f47299f43bc8d39025e7e', NULL, '2023-05-06 01:15:42', '2023-05-06 01:15:42');
INSERT INTO `user_record` VALUES (10, '8381fe679e25473d8bfcd5fe6ea59436', NULL, '2023-05-06 01:15:42', '2023-05-06 01:15:42');
INSERT INTO `user_record` VALUES (11, 'a4545b72379d430dae9e2f5afbadfa3c', NULL, '2023-05-06 01:15:42', '2023-05-06 01:15:42');
INSERT INTO `user_record` VALUES (12, 'fd607ff6d2bb40ec86a08e59d323d745', NULL, '2023-05-06 01:15:42', '2023-05-06 01:15:42');
INSERT INTO `user_record` VALUES (13, 'a5d8587471774c809ca4fccabbe9f625', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (14, '65f0b60bd2994bc492c40b57ea872a72', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (15, '3a36ad8601a6477d8aa649ddc919e37e', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (16, 'b01d2b1c33624d3296cf6878f0ec2325', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (17, '778f50a6e6804cf3bb61bee638bf4012', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (18, '54acf4f404bf46038bfe75b5f00fbe73', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (19, '4f3efdd2fdec4164b85276abd07b09f9', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (20, 'b8eaa98687b448bdb3bf5ee322beb490', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (21, 'b5faeeb5c8144d3ea584556f9c4efab3', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (22, 'ecb5390bb77c4e329c63884cf65237f1', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (23, '150522e5f6554d20b28b0c97a1a313b2', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (24, '27794e12eb064f4e88c8c055e709cb9d', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (25, '77b7d1e6b3094348ac8a30c3523df550', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (26, '342f411e3ef94af59cd61ae36ee0612c', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (27, 'e0b9f6656eb342d98599d0cded202ef9', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (28, 'ef7940a9411b4e82b85225ee40eeb9ff', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (29, '99acae2046ec4288923d21ec90616b2a', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (30, 'de3de853877c4b77871d37ab4cc8d08b', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (31, 'a63dcacf41a8448982342b86b50903cc', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (32, '91bbc85c9aa04477aa00cba9f5549dfe', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (33, '93900bb2e1834aaa98b8aa97c449ccb2', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (34, 'de45b98df1c54c94882a30ef62626e77', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (35, 'ec1a92efea184568aa1f585068a3fd59', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (36, '8f075f44c1cf40ed9059a3ac73eb1a0a', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (37, '3f902b2315ba4c09a0b942ecb7e938a6', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (38, 'c2f5de4532754205aa20b249b9e4aecd', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (39, '26056682369f4dc28a061db3936073fc', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (40, 'dbb237e870814b6eb9dc58abe9ee329b', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (41, '2cd420e7dafc4efaa4e3879f2d1c3a42', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (42, '542f448bc2be4b1ca97808bbf50915ed', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (43, 'c879102c80a24decba681aaac013fcf6', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (44, '89de57e0833949db847a5e0ada49e9dd', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (45, 'bdbe061e7f0b42e6830b4da93a19d0d9', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (46, '555d1bd8fead43cd84723b3c7053253e', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (47, 'e815e6957ba84d7ea143cb8bdb04b9e0', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (48, '5afbe007bc6a4940ae2455c2a37ed971', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (49, 'e283e4c3e63141babca0d19fe2a72621', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (50, '2c2dcd8aa8f349a9a849c1b3fe18d688', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (51, '652b4d46f7b34546b682fc58d7427e01', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (52, '6058681f3c1749cd857e8a0844f51577', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (53, '11fc52bf40104214a2980b785c93e497', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (54, '264f1c32743f476f84b368405717158e', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (55, '8f3a0ac75c0a4e75b1c03c72436c5ac6', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (56, '412d2015a0024278850398ad4ba61132', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (57, '2d97bdd084834f9aaf4712308da1a8fd', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (58, '4f97e9f5860140d0a9af7d0b93fd9e89', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (59, 'dfd1ac5eaded4af196d228b66a89d730', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (60, '3754d4d227c94656b63362a4ac4eb647', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (61, 'b5f8ebc88ba84aefbf87e26148f2f5b6', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (62, 'bbab3088fd9b476ba2a34ee3bd949140', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (63, 'fbbe10b083744bdabf939cc7e9883e0a', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (64, 'bba66fa2ab2d477f8caf368cf7e06c05', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (65, '652a06335f0a4daf8d1c810e91ef84eb', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (66, '530a1e676cc3428aaa6f0dcacd530b58', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (67, 'f3ce83f289e0418ab175183e2cd2aa66', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (68, 'f86d16976c724b5e9c063dadd72b305b', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (69, '07291b87c020480c9135fb1fb8ba1b4f', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (70, '616118362cea4ae18a736ccf898378d3', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (71, '8eab5435526b486888f5254d8eeea887', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (72, 'f27c499a4aca4d7fafd3fd0a49952cc8', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (73, 'c768c3f5947b4a5eaf08777e8d9bd34a', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (74, 'a94b4040f6bd4c03a952115d38eaa967', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (75, 'c8947fbcb68344649b2f4b51cfd041f4', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (76, 'e8897e30016e482d8ff87da8d06fa2ba', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (77, 'd3d47a78d58b4220b9743c4b587dde81', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (78, 'f75ffebf280748b1ade83e0c39a8b862', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (79, '81329d68d21a45c196e99c79d650f69f', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (80, '7bf8f052e1ce4421908307159a2414f3', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (81, 'fc8f97df3acf4e04800392ac09eaad90', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (82, 'b5f2c044258e4bb3b4fa69cae655db65', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (83, 'f8708200db1946d1a9066d88b0a0f2fe', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (84, 'c9f53029f3c847f59e163e39939f0a61', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (85, '553507c55d3c4260afb767e67a3fa773', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (86, '1835b594b0fd43b795fb1d28379b971a', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (87, '8c8e0507f8bd49d68f57dff3e9e69063', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (88, 'f3a28427b1cb4972b3dd25f0f6eadd0d', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (89, '59244b26e9e048daace89b409610c78f', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (90, 'b9a023278529486696a0d5bf4bf1f379', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (91, '117d3f0eb9e147a7a572fd60b2e210b8', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (92, '5f80cda0ea92463fb77a8659bbf0a56c', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (93, '8e2526bd86cd4cebad5d8da09f062bab', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (94, '547f9fe0ae68410f88f66068499a15ac', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (95, 'a259d8b5b1e94c559fc57a4839302a34', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (96, 'ffea0ff4e7664ba4ab3f7c6e9e3b8a62', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (97, '2a8d32d1cceb48b2a562079d3f426dd4', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (98, '67977e5ef3c64cd8816835a3972f4c12', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (99, '858ae05bb3ed4dc9b460e92237ae0556', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (100, '4aff9d2af7ed4230818a4dace6f8978e', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (101, 'c0348e95318442d383286654980ab449', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (102, 'ddab3db9770047b3999d438f20218a77', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (103, '4c130f4a245d409997bca875effe23ae', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (104, '6b525ae5cc464a9f9a530083b5044494', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (105, '40864eae5da341ef9a19effda50f3f5d', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (106, 'caa1e0558c1a4e0b9d6931bd18365be2', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (107, 'bbe13a0c006b453eb5b21f321c745119', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (108, 'e3ab671297db4e368b66565df3735a8b', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (109, '80bc874fb12b4e3eb775faf59dab1fdf', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (110, '21225cdc22f3429fa0ded5256e4e809b', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (111, 'edb98f2680fa489c9789f9246ef479bd', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (112, '7b73d77bc2ee4478868f6b0e6e475a0b', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (113, '43b912b8d0a44794a5a0d983ba216cc1', NULL, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_record` VALUES (114, '65637d34be8248d094fa9b375fabfb22', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (115, '42acc786b6b843ef8b0ba87c710036be', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (116, '79781b55854a4acf9354fa932ea2c028', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (117, 'b48c1984823d45e59dc807e6632219a4', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (118, '1b1559a734084fe1b8cedca8a873698e', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (119, '79970b3bad014f2e897610bcf0af3958', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (120, '8417be5a43694535bc24611490f06488', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (121, '57fee3abff734fe291a0061b7de3c078', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (122, '895f7be9889447908d8d3071fe71a633', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (123, '23de1837bfbf49ebafa670b585b0d220', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (124, '7464c64c54d7444a8aa0de350e9a25b5', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (125, 'ad97330d12de4e818a425c6cd8a67ed7', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (126, 'cfbcccee10a74fc4a3b9f7a59fca11d7', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (127, '98cf0561cb6e40948294fc77fa1f701e', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (128, 'bfda73ef139f4fdeab7159e8d03b7efd', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (129, '3d55fea87aaa46a6acf8d843a1468226', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (131, 'c0fa5f66765d44a2a36967394bea3228', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (132, 'bb3747ff81fe492ba29c8ea90987497d', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (133, '624ea97125ed4c4f86278cf4e0f2f652', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (134, 'b75084176ccc4787a9d237161a7936b5', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (135, 'd78225d791aa476699e073bfa2a0140d', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (136, 'cd302db0f6ea4f4e8703c66598edfb66', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (137, '64dd0808363e419392dc233677ecce20', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (138, 'e40196c3cc6c43cc8590cdbed17a09d8', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (139, '93454ed8c4fb4cc99381ac3a5ea7d962', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (140, '965743aedcc4496280dbc378f88cd2a6', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (141, '4f946f2a47de424f95d8e1e0e7b535d0', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (142, 'f69a3c2ee3da4cf195fbb57a7c4b3e63', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (143, 'bd4275b7498243a78307d1e34c39d97c', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (144, '25a91161a9164ae9a638bf71097234ed', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (145, '4c2d7feba05342dda668ea9202f2cf21', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (146, '7e050dbd92714bd887dfe6b7b472441e', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (147, 'ecaa6707279845598770d232805579eb', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (148, 'c3328ab1e66847c48d553d2f7e02bcd5', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (149, '31f1f36f649e48719e7aec74c04c84d8', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (150, 'e38c9e7140324ddeb2623b58fceca67c', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (151, '07fd5ae95aae40b3b4358897b198577f', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (152, '1e884535163240c896f1e72b06d58a19', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (153, 'ab47ab677c2a4f2f9c7e5b3f25ce0e5b', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (154, '344e3dbcd2df4b588c20fd2835b80ccd', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (155, 'e6936131f6944c609dd7a879268bbaf9', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (156, 'f175b04c3e954ee4ab0263bb226f3c8a', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (157, '9b156c76400846c68a1018cd3a209c95', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (158, 'f465e56cfe1441748ccbf7b7bffdec11', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (159, '95176b46ae6b435d8500d3723245bc2d', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (160, 'e700c37855be42b6a591fc665372887c', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (161, '21d1f1af9f404309aa344635082c3559', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (162, 'da1cc31c179548b48400ae7e34c98e26', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (163, 'ffb14501ad9a41a2ad7c46105e23cbb7', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (164, 'fa4edb799e544c30bcb631d90218b6f5', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (165, '2e6ccc31d39842769040f394788612ff', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (166, 'f34695c51a7b4e5fb88ee720be1cffe4', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (167, '0273e0ac65d146fe88383ea3f33b6108', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (168, '0841e27a7d364a788fbee7a87106039d', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (169, 'aa903bd555dd4e0eaa689fd2319776d4', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (170, '78a8a7ecc8564ba0b773b14eaffd4615', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (171, 'd8d20d9651644594b201de2828ebbf88', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (173, 'a149a57f6de641d8ac49f5359286cfc7', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (174, 'e350bf8b8cad41d7b764f8dae2688834', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (175, '1faee900b97d459ba387081d42e8a2be', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (176, 'e5dc11faef8a46658acb5e2dc1245c9e', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (177, '62595c4ccc864be9bbd84d94ff21e0f4', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (178, '58aeef3d33c642adb24f556a1fc4f0bd', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (179, '36afedd8b2cb4168b1d6ffb537d00525', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (180, '3eeb2d58a2ff42149fb005c1c6581320', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (181, '4a0f2198f58243a7a51f9cf4a7773b21', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (182, 'ae2052d09881408c92a7e870f33e84ef', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (183, '50e5abe14aad4c459f08156f1d316772', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (184, '0b715fae3ae04b84a3fb2f8f3d3e4077', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (185, '6fee6ee82c1f47efb5baf6491477d2f5', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (186, '56ab1fd5cf9c44818f1f943078a8b710', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (187, '6bbbce3bc8c94ce2ba6840a25a3a37c6', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (188, 'a3e07889b45644209958c76ad600d3b4', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (189, 'c369d75b34414af18daa5a03a3350518', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (190, '8aaa65615d124b94ac2801c20ec11bb5', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (191, '2d391e23eb1841188a75272522f6271e', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (192, '02cc9e77ed35441b839fef5f95cddf41', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (193, 'd7ff07448dff4b9a8f1fe121d279c0f7', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (194, '602a9cecfc9c4c10999ca3176327e6ca', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (195, '0b657915618741399ac6e3c86173d9b7', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (196, '7ec6a1457f254089987a740709f109a0', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (197, '2077144f6c2e4986937fe0924c24790f', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (198, 'ec9da93e3bfe4ebbb7afc20cb13b9850', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (199, '5f3c392f493c4044a61c6ddbd9e4127a', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (200, '111581629b024858a462ca41c9a37fe3', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (201, '4f2b561d93c04891aafbf20c91573e52', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (202, '58580ac4917f49bd8b5d712bb574eec8', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (203, '6017cb888e284adaac2a3b3c0994c5bc', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (204, '14da1c323706435c94f43a30c59f8ccb', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (205, '650446277f2b480b961b6acf830ad065', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (206, '9519370c7a5d4a4e8aed3f1a7c093f96', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (207, '7731835d18d04d1087d2dffbb7e640bb', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (208, 'ea8445dddf8c4d0197cb151936fc9e1c', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (210, '83462148c30a4f908f56f91fa1976b61', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (211, '8fda6af7738e4d0b80f703bae1ca8e3e', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (212, '87fd981ef0ec4fbba436d96a26f0a7de', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (213, 'e41a4ae5a714499d96f19b1ac06ebd77', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (214, '4aedd26f23954f65b1659ffa7800d1b7', NULL, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_record` VALUES (215, '983002e42b094577bfc1450f29344123', NULL, '2023-05-09 21:08:39', '2023-05-09 21:08:39');
INSERT INTO `user_record` VALUES (216, 'b70ceaf6b3694d0c9c42fa794838d9a3', NULL, '2023-05-09 21:08:39', '2023-05-09 21:08:39');
INSERT INTO `user_record` VALUES (217, '31eedf8ed0364038ac9cc1871e83a28d', NULL, '2023-05-09 21:08:39', '2023-05-09 21:08:39');
INSERT INTO `user_record` VALUES (218, 'c3f43b10635141debf5008557744164b', NULL, '2023-05-09 21:08:39', '2023-05-09 21:08:39');
INSERT INTO `user_record` VALUES (219, '9c45185e988348bd9cccf6b9be07ce77', NULL, '2023-05-09 21:08:39', '2023-05-09 21:08:39');
INSERT INTO `user_record` VALUES (220, 'e85b5c413a874b39885eb47b33c851e5', NULL, '2023-05-09 21:08:39', '2023-05-09 21:08:39');
INSERT INTO `user_record` VALUES (221, '1e21e301209f465bba12c8c27dfb2753', NULL, '2023-05-09 21:08:39', '2023-05-09 21:08:39');
INSERT INTO `user_record` VALUES (222, '8afb7ab2f9ae405d986a7c5c9321e1c2', NULL, '2023-05-09 21:08:39', '2023-05-09 21:08:39');
INSERT INTO `user_record` VALUES (223, 'db92f6420c60441f8d538432fa35aaf1', NULL, '2023-05-09 21:08:39', '2023-05-09 21:08:39');
INSERT INTO `user_record` VALUES (224, 'e693b1b6cc22401aba6e9a9f77c92424', NULL, '2023-05-09 21:08:39', '2023-05-09 21:08:39');
INSERT INTO `user_record` VALUES (225, '4c05b7e8d785482ab08e235c62416486', NULL, '2023-05-09 21:08:39', '2023-05-09 21:08:39');
INSERT INTO `user_record` VALUES (226, '24579ed0c60e4159b3b830155b0dbcf3', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (227, '66876a7543dd48ddbb4894d6df6114cc', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (228, '9f6c15594b55471381690eeadf6028e0', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (229, 'db06b2044cc64826a3af71ffd83ba1b7', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (230, '4fe98a210d0842c98713f140c525865f', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (231, '5b178f92b8cf45f79ea919355484a0a0', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (232, '122b56674d1f4844998a1650091dc830', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (233, 'bf6ad0bddfb64280bf4f5a205490cc8d', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (234, '5dec0bb7c40643fdabb24f0095a08beb', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (235, '68687098fe18428c9d35e4206ec0eb54', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (236, '8bd7d6c2e99c4f2893a22c70d92af241', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (237, '8143f1683ef64f54a0bf32055f6cde01', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (238, '72b0fcfe41844a608b9d06a1d7b596a9', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (239, '8d410c51e94545368ba4ec5af9bdecda', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (240, '16a2b8ac4df345b3a81279f7f686b053', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (241, 'd53621fd6ce643e1a4412cc6a2c30a01', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (242, '2f98628beb814e8dbf2e9e0409ea3fcc', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (243, 'fe47d3bee8e44e7ca0f3924527552fe7', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (244, '6b9e8a5c12cc478f9347d1e79fa2a8e0', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (245, '4e152da6b55a4b93ba72cca8b0a1e98f', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (246, '8d33acaa1fc74f3ba60ee7333430f6b4', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (247, '632fbba8a5a34f209538eb1f8f56d6b4', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (248, 'f8786eed11614c80a804df082ceb5beb', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (249, '6e734aba229c479689db7b9f7074c8e1', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (250, '47db77484795460baa65f3d1d21fa4c8', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (251, 'ea03047ba5574fdba96b6633aca21873', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (252, 'a359d6d691f24d2d84683e0e96682e15', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (253, '4ce9912bdffd4f07abbdcdc814278a97', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (254, '36688c91ce12463a8c2ee0bf793bb322', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (255, 'a59f02b82f6e4a6bbedfa5b6dbefaefe', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (256, '9a6d708da8dd40bcbf4d42ba319042b5', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (257, '00cb64ad2f5143cca6064d4b3187b4ee', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (258, 'b4d0569c34ef444c91d6e30c6931fff4', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (259, 'cdf039411e054c97b3beeca0c29f09fb', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (260, 'a69ef013a45f4354a2951974a6125734', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (261, '353df3538e0a46cc961f5bb287f129ef', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (262, '2abe5fe68f4241839b6d613f56db52d1', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (263, '40ca10c0f3644e0f936a2d7ae3faf05a', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (264, '50b8ecd6a62e4577a723e577ec61b2f7', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (265, '2692a1a8d39e4b5ea2b09c50957f7c23', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (266, '35989086aa0b4b5e82ba2ac0f09dbdf5', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (267, '4197a7eba4df4ff2a3e61d37a06a0f3c', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (268, '4d2ce36554b74b29805dae33ecbae636', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (269, 'dc68cdbf4b144116a0f322df20ac2ed5', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (270, '3d87ca7fe9f348b1bf6a4c491b94e059', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (271, '2b8c38a1466b40a78b5d0afbabc4f3d5', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (272, 'b07f6640dbe34935a7310039e9ca8792', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (273, 'e8ccd86b35974750a25337b099291b36', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (274, 'f868b1d349e040f5a03ddfe7ab889631', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (275, 'cab1fa2710d2461f9af619c21fb5cd90', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (276, '16e047acbf15451290408f9b77e303f5', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (277, '0aabf963bee9485780c3351123b58f8b', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (278, '8901858986044713ab6a1c8c456f0e05', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (279, 'eeaad73f74cb491587bf24cc320b671c', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (280, '49e10db996234ebdba7f241999710ba9', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (281, '92f6ff93bd6b471899168507a4a396a0', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (282, '2e483216acab485c80aeeeba7719e3ea', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (283, '664970c7c2e24f81951be92bd1891814', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (284, '8b0d1d8e0f1f426999e6043c98dc8698', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (285, 'd7bef82561aa4310b5f77ba67bb46a3c', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (286, '06cace76e41a4391b418cc010d453dda', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (287, '325349216c794dc3afc4024fffa7e0fb', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (288, 'e8c5e3f8acb14bf5953d2f4c30b63732', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (289, 'c0fd41b337784ae7a9e470574ab2caae', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (290, 'daa3d431aadb42c7a16ecbd00e0d9cf7', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (291, '80d6d1df0e8e4afdbb232912af02ecd1', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (292, '58348e2e0758421e87b53d7af46bebb4', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (293, '145d1807a64b4395af32de2799e00ba3', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (294, 'f840e69ec8784a1e9433b44407af45be', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (295, 'd89bb99d28f14e02a7aaa5a6dd6e3a02', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (296, '5d5847fd69084317b46d268b6e05f3b6', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (297, '13106c57502c427dbc5489ab34196ae4', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (298, 'e5a5a3796d9346d5893b391e09722151', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (299, '18cb3a9b3b124a469158d5381f73744a', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (300, 'cce5cd24e9154b65a4befd97b74b2880', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (301, '63925f6cf1a84b30a9ef5996d5e900ba', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (302, '3a20618e6e3d44ee815bd7855e200368', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (303, '31e32a03e55f4337b21e99981e9c0970', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (304, 'c53f0867956d4686accf263a63e37c14', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (305, '684f5c75e46f4a55ac79c04f6d37152c', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (306, 'a83371f25dad457ab17eaa578d8653d1', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (307, 'dcf0cde95e1941a6bf2bc1df58a336e0', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (308, '15c535f043ff48beacefb16f5c3bd7b2', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (309, '3e46cbc27f0b4a018c5207914fd9de8a', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (310, '1059d20f95a749c7af75b3b874c9485c', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (311, '63f8c8a1bc0f41aeb07b5f4b9afb1e6d', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (312, '16b4f27bfb9d4f2cb1cd75b8057e2d16', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (313, 'd9219566b4324e428cc7c34431d41e25', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (314, '156e5c230dc645df894645f46f98bd3e', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (315, 'dfab7817728b4d3581d9542390426c49', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (316, 'dec423044e6b43e2aec8ea35149ef384', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (317, '57ab1c550ca344c9a454d315bac1dcb9', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (318, '6a48846f7e734a668800ac71baa010b9', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (319, 'd0085b3db9c64b12a876e236b44b1a57', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (320, 'aeb6ffd910f34e858239f3d53b456974', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (321, 'e033b5809d38418f93ebeac3dda5782e', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (322, '810f3254c97a41cfbc2de94af3991f82', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (323, '9da55b32438e408698bd64aa3a86c474', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (324, 'cc1d3646042e441c9b0be6bd25e3021f', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (325, 'f49c3dd55aaa455480d18fe14f3ca9d1', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (326, '2f1a93d640e94b1ca84fd2e88000de49', NULL, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_record` VALUES (327, '4c2b67f11d634355b6135cdb70cd4b14', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (328, '3701afd5c368442a86827aa6419e0995', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (329, '455dbe5bce3f44d2903f26ceae9ad59f', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (330, 'cd60766fdad84083bf8ef4775b858a4e', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (331, 'de73881f711842c4bf16fd3b5f6ea652', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (332, '11a49c668ce94ed097aa7c5244bea9ca', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (333, 'd45ab2362923485e9cf29db4f052387a', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (334, 'd48468af105b45cd99b0a83b8043e5d0', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (335, '0a2e447fb0a04631a366f212538f8b84', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (336, 'bb72aca6e69349c386c8e2c26bddfdad', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (337, '416f5e4ae2c54aaf8fb67668a5c67893', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (338, '494f3410f72942689b052309dde1d010', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (339, '64e4e6559624493ba0a7603f70eb8df2', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (340, 'd6286972c79740d786db38ccfb8e601b', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (341, 'e7f10d719c9f48c78b3ba0ad18b00827', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (342, '5209d551064e4bd49ecd30bc79097bce', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (343, '7c7ce6ae5e634e928263c3c1605d1da6', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (344, '4b10a50c4ed84cc59789eaa0d42b6771', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (345, 'cd880aca32cf4f0a87eaef937e642e96', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (346, '90550f2c047848ff8c448184b981b474', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (347, '4bd7a55994b747ec9f6a3f643ebda36d', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (348, '849e8d0dc7b74169a83d99d1edef9586', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (349, '5e95259794994889a4b158cba8b39b89', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (350, 'e2bb84821e634d4792dc7a49d6c19645', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (351, '9bd807d1abde4f719b22b4a319945730', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (352, '2c7ba4628d48415bbcd6732273e657de', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (353, '46563b9a2329498a8fc1f99f2db1db10', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (354, '606ffb7607594857a2221fc77651a86b', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (355, '09e1a321da654b6880cd0b61f40509d9', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (356, '28c170755ad2428aae288e2703bbce03', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (357, '63a54b01e11f46b3a923cb423d72c5b3', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (358, 'baeb9796936a422a9c808a8954b3e30c', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (359, 'a49820d9a26b4bc3872b0e986165bed9', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (360, '3102f8f8d3294821a7b09269896c918f', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (361, '9b78f3684f93442194d742cb7ef1b746', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (362, '8463e213ff72441bb18c134c3efb4445', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (363, '6e1a40be34344c5db90624778d9f27a8', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (364, '93ea4948e3a347799f56783f7fe1ec9c', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (365, 'bdef3968994b4a12ac7e30990e4579c9', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (366, 'd14b1dcedfb64f169377c9607040968f', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (367, 'e5dba40dcf474eccaab450bc007f671e', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (368, '050e69fa551245d8879d504d2efa1223', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (369, '28761360c7ed447592b70e4d3dd5201b', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (370, '8b70495dea6d4e4ea0bc5eae889a8fcd', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (371, 'a9016dc2abfe45deaf87a926363d5e05', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (372, 'ca6915d8d78a4fe5bfc0aa0f75916fa8', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (373, 'b7b4600d8f0046f1a21a22155a334c89', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (374, '7414aaeca87d463ca100c73f29798bf8', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (375, '45c191a84e6a4002a2a503e7f15ff079', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (376, '8a1410e7763b41678942411dcd9191a0', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (377, '7840179a40c3496cacfd94ad070bd3db', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (378, '828558666e8a40b080206dddd17c51a4', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (379, 'd746cae8a0b340f3910cea5ed4fa7e5d', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (380, '512dc1a99c294405944276aaa3002a0a', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (381, '2fddf8abf2e94c2aa3c171855549bf98', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (382, '41534b2b6fbe43cf8accd0960d21d5ac', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (383, '8db44e3d2a2a4a13a9f7af4ec6499f9f', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (384, '24edbb55f7cc44c2bd965a58de3d24fd', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (385, '220096cd878f40ce8809bd1ec049d7f3', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (386, 'e04641b5fd284a4983cb0c4b0f848187', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (387, '5cae094d92d34331899486b79f54e209', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (388, 'e1e47cc972b1482fa34dae21cd5af860', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (389, '157026427da04336929f8fb7662f08bb', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (390, '3c5e8ee696d24f0f82f2b054c3f6d7e6', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (392, '819deedf39674a4480fd6b620f74ea6b', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (393, '9f554a31416c4aa39408221bf18fa08b', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (394, '65bf4299877f4ba5a44cf721aafc0e32', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (395, '5fea6ee4d4c64da2920ca592a491a547', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (396, '1d18e422a9fd4916b99bc928ef7783c5', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (397, 'dacf29857ca54fb0a19b2c39c2deebb2', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (398, '184dcb0cb87b46f09e6d4518ca5a45af', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (399, '245e921ffad34de18099121aac72d4a0', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (400, 'd838d6edbc1a419aba994eea00229b66', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (401, '0fd8af0e419f4eb9a505b642160fe465', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (402, 'e2105f3c986f442b81adc5d0c609d28f', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (403, 'dc4408f3ffd04f928d2cbcf36ad025a1', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (404, 'ba4a247dcdf54704b255724157ad2550', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (405, '1d21781e91ec4bfd87edcd11efa97da2', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (406, 'e7a82177430b4547ac81d6c5617fb7fa', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (407, 'aaa076e4492d4c4893dedbe149002bab', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (408, 'd6878a306b96403388deaee77234fa6e', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (409, 'a0e146e145354146be3b430adfb09f22', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (410, '05e5342614734a7c92860a85c2858379', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (411, '9975181284cc4318b3033f91dfae5677', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (412, '1fbecc8d4b8e40838923479af95e0d3a', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (413, 'daf60eae04754cea84ce3a7a6ef310c6', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (414, 'e975dd8505e6491aaeb106e8a92fc598', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (415, 'ba1bca167b834528879577117e679d80', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (416, '9dcfb031ed1d4f96add97a32310f55b7', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (417, 'fd3ae04892b847b7aeefa8ad62c4527f', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (418, '1374c0523c3942e286535407af39680b', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (419, 'd9e56fe15e284934b6846e4885fc0eb9', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (420, '2fac493ea0624690ba77cb851325771d', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (421, '83d37ad0db3e4539acdb77053838179e', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (422, 'a78a992b3b8b40a7a60f007b07ff5ee9', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (423, 'cb38cc5fc62746c894013dda5fd899a3', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (424, 'bf56a3d523a24d0289a9574e23f908cc', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (425, '52a9ab971bb14a7e9de2dbd0b9b6dcd5', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (426, 'daf7783ce14d4d1d9222a296dd2ca157', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (427, '326cbf2495f9449d840726e551b7ccfb', NULL, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_record` VALUES (428, 'c01ad37173c74ed6ac6ca09a080db5af', NULL, '2023-05-12 20:25:41', '2023-05-12 20:25:41');
INSERT INTO `user_record` VALUES (429, '315c3ff6d0f648f78b7c2a05f939a637', NULL, '2023-05-12 20:25:41', '2023-05-12 20:25:41');
INSERT INTO `user_record` VALUES (430, '5978594be7a94a35b9c1d28304613fb9', NULL, '2023-05-12 20:25:41', '2023-05-12 20:25:41');
INSERT INTO `user_record` VALUES (431, 'a0af53355faf43b7b93d9a92ec13159e', NULL, '2023-05-12 20:25:41', '2023-05-12 20:25:41');
INSERT INTO `user_record` VALUES (432, '52c4176536184deb88656832dfdeccdc', NULL, '2023-05-12 20:25:41', '2023-05-12 20:25:41');
INSERT INTO `user_record` VALUES (433, 'ea241869c7f3451a914eecb1af504843', NULL, '2023-05-12 20:25:41', '2023-05-12 20:25:41');
INSERT INTO `user_record` VALUES (434, 'a843c6687ccc48b39cff150b09f4327a', NULL, '2023-05-12 20:25:41', '2023-05-12 20:25:41');
INSERT INTO `user_record` VALUES (435, 'a26794e661844a57b7c77ee7744c5050', NULL, '2023-05-12 20:25:41', '2023-05-12 20:25:41');
INSERT INTO `user_record` VALUES (436, '3605de92ad8e4af4ac1ebbfc4fc8cb2e', NULL, '2023-05-12 20:25:41', '2023-05-12 20:25:41');
INSERT INTO `user_record` VALUES (437, '452396b08cb04ef48f6d4618241b2508', NULL, '2023-05-12 20:25:41', '2023-05-12 20:25:41');
INSERT INTO `user_record` VALUES (438, 'd9d5e5ae3f3d4a44a055e52f7a7fa6c9', NULL, '2023-05-12 20:25:41', '2023-05-12 20:25:41');
INSERT INTO `user_record` VALUES (443, 'af17f3af6ffa437b9cdb72b37511b53d', NULL, '2023-05-14 12:13:17', '2023-05-14 12:13:17');

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `role_id` bigint(0) UNSIGNED NOT NULL,
  `gmt_create` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `gmt_modified` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  INDEX `role_id`(`role_id`) USING BTREE,
  CONSTRAINT `user_role_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `user_info` (`uuid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_role_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 443 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES (1, '1', 1000, '2023-04-07 01:27:53', '2023-04-07 01:27:53');
INSERT INTO `user_role` VALUES (2, '5566979f8963485a94fa488594aa1e17', 1002, '2023-05-06 01:15:42', '2023-05-06 01:15:42');
INSERT INTO `user_role` VALUES (3, 'aeae61ff71d04c329a6fcd4370d802bc', 1002, '2023-05-06 01:15:42', '2023-05-06 01:15:42');
INSERT INTO `user_role` VALUES (4, '2b3de663e587412f882d1cce83c706d7', 1002, '2023-05-06 01:15:42', '2023-05-06 01:15:42');
INSERT INTO `user_role` VALUES (5, '15caa925bce844c5a15d089f944cb86f', 1002, '2023-05-06 01:15:42', '2023-05-06 01:15:42');
INSERT INTO `user_role` VALUES (6, '64843d9eed804ac891b6a7caabc02876', 1002, '2023-05-06 01:15:42', '2023-05-06 01:15:42');
INSERT INTO `user_role` VALUES (7, '3578f118abe44946a2c874ed2c0083c4', 1002, '2023-05-06 01:15:42', '2023-05-06 01:15:42');
INSERT INTO `user_role` VALUES (8, '9e3ca25add25494e9b43357f414f2775', 1002, '2023-05-06 01:15:42', '2023-05-06 01:15:42');
INSERT INTO `user_role` VALUES (9, 'ba373125f19f47299f43bc8d39025e7e', 1002, '2023-05-06 01:15:42', '2023-05-06 01:15:42');
INSERT INTO `user_role` VALUES (10, '8381fe679e25473d8bfcd5fe6ea59436', 1002, '2023-05-06 01:15:42', '2023-05-06 01:15:42');
INSERT INTO `user_role` VALUES (11, 'a4545b72379d430dae9e2f5afbadfa3c', 1002, '2023-05-06 01:15:42', '2023-05-06 01:15:42');
INSERT INTO `user_role` VALUES (12, 'fd607ff6d2bb40ec86a08e59d323d745', 1002, '2023-05-06 01:15:42', '2023-05-06 01:15:42');
INSERT INTO `user_role` VALUES (13, 'a5d8587471774c809ca4fccabbe9f625', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (14, '65f0b60bd2994bc492c40b57ea872a72', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (15, '3a36ad8601a6477d8aa649ddc919e37e', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (16, 'b01d2b1c33624d3296cf6878f0ec2325', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (17, '778f50a6e6804cf3bb61bee638bf4012', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (18, '54acf4f404bf46038bfe75b5f00fbe73', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (19, '4f3efdd2fdec4164b85276abd07b09f9', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (20, 'b8eaa98687b448bdb3bf5ee322beb490', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (21, 'b5faeeb5c8144d3ea584556f9c4efab3', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (22, 'ecb5390bb77c4e329c63884cf65237f1', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (23, '150522e5f6554d20b28b0c97a1a313b2', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (24, '27794e12eb064f4e88c8c055e709cb9d', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (25, '77b7d1e6b3094348ac8a30c3523df550', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (26, '342f411e3ef94af59cd61ae36ee0612c', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (27, 'e0b9f6656eb342d98599d0cded202ef9', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (28, 'ef7940a9411b4e82b85225ee40eeb9ff', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (29, '99acae2046ec4288923d21ec90616b2a', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (30, 'de3de853877c4b77871d37ab4cc8d08b', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (31, 'a63dcacf41a8448982342b86b50903cc', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (32, '91bbc85c9aa04477aa00cba9f5549dfe', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (33, '93900bb2e1834aaa98b8aa97c449ccb2', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (34, 'de45b98df1c54c94882a30ef62626e77', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (35, 'ec1a92efea184568aa1f585068a3fd59', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (36, '8f075f44c1cf40ed9059a3ac73eb1a0a', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (37, '3f902b2315ba4c09a0b942ecb7e938a6', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (38, 'c2f5de4532754205aa20b249b9e4aecd', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (39, '26056682369f4dc28a061db3936073fc', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (40, 'dbb237e870814b6eb9dc58abe9ee329b', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (41, '2cd420e7dafc4efaa4e3879f2d1c3a42', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (42, '542f448bc2be4b1ca97808bbf50915ed', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (43, 'c879102c80a24decba681aaac013fcf6', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (44, '89de57e0833949db847a5e0ada49e9dd', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (45, 'bdbe061e7f0b42e6830b4da93a19d0d9', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (46, '555d1bd8fead43cd84723b3c7053253e', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (47, 'e815e6957ba84d7ea143cb8bdb04b9e0', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (48, '5afbe007bc6a4940ae2455c2a37ed971', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (49, 'e283e4c3e63141babca0d19fe2a72621', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (50, '2c2dcd8aa8f349a9a849c1b3fe18d688', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (51, '652b4d46f7b34546b682fc58d7427e01', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (52, '6058681f3c1749cd857e8a0844f51577', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (53, '11fc52bf40104214a2980b785c93e497', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (54, '264f1c32743f476f84b368405717158e', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (55, '8f3a0ac75c0a4e75b1c03c72436c5ac6', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (56, '412d2015a0024278850398ad4ba61132', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (57, '2d97bdd084834f9aaf4712308da1a8fd', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (58, '4f97e9f5860140d0a9af7d0b93fd9e89', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (59, 'dfd1ac5eaded4af196d228b66a89d730', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (60, '3754d4d227c94656b63362a4ac4eb647', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (61, 'b5f8ebc88ba84aefbf87e26148f2f5b6', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (62, 'bbab3088fd9b476ba2a34ee3bd949140', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (63, 'fbbe10b083744bdabf939cc7e9883e0a', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (64, 'bba66fa2ab2d477f8caf368cf7e06c05', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (65, '652a06335f0a4daf8d1c810e91ef84eb', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (66, '530a1e676cc3428aaa6f0dcacd530b58', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (67, 'f3ce83f289e0418ab175183e2cd2aa66', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (68, 'f86d16976c724b5e9c063dadd72b305b', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (69, '07291b87c020480c9135fb1fb8ba1b4f', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (70, '616118362cea4ae18a736ccf898378d3', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (71, '8eab5435526b486888f5254d8eeea887', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (72, 'f27c499a4aca4d7fafd3fd0a49952cc8', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (73, 'c768c3f5947b4a5eaf08777e8d9bd34a', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (74, 'a94b4040f6bd4c03a952115d38eaa967', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (75, 'c8947fbcb68344649b2f4b51cfd041f4', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (76, 'e8897e30016e482d8ff87da8d06fa2ba', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (77, 'd3d47a78d58b4220b9743c4b587dde81', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (78, 'f75ffebf280748b1ade83e0c39a8b862', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (79, '81329d68d21a45c196e99c79d650f69f', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (80, '7bf8f052e1ce4421908307159a2414f3', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (81, 'fc8f97df3acf4e04800392ac09eaad90', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (82, 'b5f2c044258e4bb3b4fa69cae655db65', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (83, 'f8708200db1946d1a9066d88b0a0f2fe', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (84, 'c9f53029f3c847f59e163e39939f0a61', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (85, '553507c55d3c4260afb767e67a3fa773', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (86, '1835b594b0fd43b795fb1d28379b971a', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (87, '8c8e0507f8bd49d68f57dff3e9e69063', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (88, 'f3a28427b1cb4972b3dd25f0f6eadd0d', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (89, '59244b26e9e048daace89b409610c78f', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (90, 'b9a023278529486696a0d5bf4bf1f379', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (91, '117d3f0eb9e147a7a572fd60b2e210b8', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (92, '5f80cda0ea92463fb77a8659bbf0a56c', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (93, '8e2526bd86cd4cebad5d8da09f062bab', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (94, '547f9fe0ae68410f88f66068499a15ac', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (95, 'a259d8b5b1e94c559fc57a4839302a34', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (96, 'ffea0ff4e7664ba4ab3f7c6e9e3b8a62', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (97, '2a8d32d1cceb48b2a562079d3f426dd4', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (98, '67977e5ef3c64cd8816835a3972f4c12', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (99, '858ae05bb3ed4dc9b460e92237ae0556', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (100, '4aff9d2af7ed4230818a4dace6f8978e', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (101, 'c0348e95318442d383286654980ab449', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (102, 'ddab3db9770047b3999d438f20218a77', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (103, '4c130f4a245d409997bca875effe23ae', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (104, '6b525ae5cc464a9f9a530083b5044494', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (105, '40864eae5da341ef9a19effda50f3f5d', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (106, 'caa1e0558c1a4e0b9d6931bd18365be2', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (107, 'bbe13a0c006b453eb5b21f321c745119', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (108, 'e3ab671297db4e368b66565df3735a8b', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (109, '80bc874fb12b4e3eb775faf59dab1fdf', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (110, '21225cdc22f3429fa0ded5256e4e809b', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (111, 'edb98f2680fa489c9789f9246ef479bd', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (112, '7b73d77bc2ee4478868f6b0e6e475a0b', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (113, '43b912b8d0a44794a5a0d983ba216cc1', 1002, '2023-05-06 01:16:29', '2023-05-06 01:16:29');
INSERT INTO `user_role` VALUES (114, '65637d34be8248d094fa9b375fabfb22', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (115, '42acc786b6b843ef8b0ba87c710036be', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (116, '79781b55854a4acf9354fa932ea2c028', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (117, 'b48c1984823d45e59dc807e6632219a4', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (118, '1b1559a734084fe1b8cedca8a873698e', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (119, '79970b3bad014f2e897610bcf0af3958', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (120, '8417be5a43694535bc24611490f06488', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (121, '57fee3abff734fe291a0061b7de3c078', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (122, '895f7be9889447908d8d3071fe71a633', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (123, '23de1837bfbf49ebafa670b585b0d220', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (124, '7464c64c54d7444a8aa0de350e9a25b5', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (125, 'ad97330d12de4e818a425c6cd8a67ed7', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (126, 'cfbcccee10a74fc4a3b9f7a59fca11d7', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (127, '98cf0561cb6e40948294fc77fa1f701e', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (128, 'bfda73ef139f4fdeab7159e8d03b7efd', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (129, '3d55fea87aaa46a6acf8d843a1468226', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (131, 'c0fa5f66765d44a2a36967394bea3228', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (132, 'bb3747ff81fe492ba29c8ea90987497d', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (133, '624ea97125ed4c4f86278cf4e0f2f652', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (134, 'b75084176ccc4787a9d237161a7936b5', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (135, 'd78225d791aa476699e073bfa2a0140d', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (136, 'cd302db0f6ea4f4e8703c66598edfb66', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (137, '64dd0808363e419392dc233677ecce20', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (138, 'e40196c3cc6c43cc8590cdbed17a09d8', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (139, '93454ed8c4fb4cc99381ac3a5ea7d962', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (140, '965743aedcc4496280dbc378f88cd2a6', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (141, '4f946f2a47de424f95d8e1e0e7b535d0', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (142, 'f69a3c2ee3da4cf195fbb57a7c4b3e63', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (143, 'bd4275b7498243a78307d1e34c39d97c', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (144, '25a91161a9164ae9a638bf71097234ed', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (145, '4c2d7feba05342dda668ea9202f2cf21', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (146, '7e050dbd92714bd887dfe6b7b472441e', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (147, 'ecaa6707279845598770d232805579eb', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (148, 'c3328ab1e66847c48d553d2f7e02bcd5', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (149, '31f1f36f649e48719e7aec74c04c84d8', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (150, 'e38c9e7140324ddeb2623b58fceca67c', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (151, '07fd5ae95aae40b3b4358897b198577f', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (152, '1e884535163240c896f1e72b06d58a19', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (153, 'ab47ab677c2a4f2f9c7e5b3f25ce0e5b', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (154, '344e3dbcd2df4b588c20fd2835b80ccd', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (155, 'e6936131f6944c609dd7a879268bbaf9', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (156, 'f175b04c3e954ee4ab0263bb226f3c8a', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (157, '9b156c76400846c68a1018cd3a209c95', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (158, 'f465e56cfe1441748ccbf7b7bffdec11', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (159, '95176b46ae6b435d8500d3723245bc2d', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (160, 'e700c37855be42b6a591fc665372887c', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (161, '21d1f1af9f404309aa344635082c3559', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (162, 'da1cc31c179548b48400ae7e34c98e26', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (163, 'ffb14501ad9a41a2ad7c46105e23cbb7', 1001, '2023-05-06 01:20:37', '2023-05-06 20:24:11');
INSERT INTO `user_role` VALUES (164, 'fa4edb799e544c30bcb631d90218b6f5', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (165, '2e6ccc31d39842769040f394788612ff', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (166, 'f34695c51a7b4e5fb88ee720be1cffe4', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (167, '0273e0ac65d146fe88383ea3f33b6108', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (168, '0841e27a7d364a788fbee7a87106039d', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (169, 'aa903bd555dd4e0eaa689fd2319776d4', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (170, '78a8a7ecc8564ba0b773b14eaffd4615', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (171, 'd8d20d9651644594b201de2828ebbf88', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (173, 'a149a57f6de641d8ac49f5359286cfc7', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (174, 'e350bf8b8cad41d7b764f8dae2688834', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (175, '1faee900b97d459ba387081d42e8a2be', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (176, 'e5dc11faef8a46658acb5e2dc1245c9e', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (177, '62595c4ccc864be9bbd84d94ff21e0f4', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (178, '58aeef3d33c642adb24f556a1fc4f0bd', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (179, '36afedd8b2cb4168b1d6ffb537d00525', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (180, '3eeb2d58a2ff42149fb005c1c6581320', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (181, '4a0f2198f58243a7a51f9cf4a7773b21', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (182, 'ae2052d09881408c92a7e870f33e84ef', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (183, '50e5abe14aad4c459f08156f1d316772', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (184, '0b715fae3ae04b84a3fb2f8f3d3e4077', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (185, '6fee6ee82c1f47efb5baf6491477d2f5', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (186, '56ab1fd5cf9c44818f1f943078a8b710', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (187, '6bbbce3bc8c94ce2ba6840a25a3a37c6', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (188, 'a3e07889b45644209958c76ad600d3b4', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (189, 'c369d75b34414af18daa5a03a3350518', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (190, '8aaa65615d124b94ac2801c20ec11bb5', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (191, '2d391e23eb1841188a75272522f6271e', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (192, '02cc9e77ed35441b839fef5f95cddf41', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (193, 'd7ff07448dff4b9a8f1fe121d279c0f7', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (194, '602a9cecfc9c4c10999ca3176327e6ca', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (195, '0b657915618741399ac6e3c86173d9b7', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (196, '7ec6a1457f254089987a740709f109a0', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (197, '2077144f6c2e4986937fe0924c24790f', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (198, 'ec9da93e3bfe4ebbb7afc20cb13b9850', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (199, '5f3c392f493c4044a61c6ddbd9e4127a', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (200, '111581629b024858a462ca41c9a37fe3', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (201, '4f2b561d93c04891aafbf20c91573e52', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (202, '58580ac4917f49bd8b5d712bb574eec8', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (203, '6017cb888e284adaac2a3b3c0994c5bc', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (204, '14da1c323706435c94f43a30c59f8ccb', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (205, '650446277f2b480b961b6acf830ad065', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (206, '9519370c7a5d4a4e8aed3f1a7c093f96', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (207, '7731835d18d04d1087d2dffbb7e640bb', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (208, 'ea8445dddf8c4d0197cb151936fc9e1c', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (210, '83462148c30a4f908f56f91fa1976b61', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (211, '8fda6af7738e4d0b80f703bae1ca8e3e', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (212, '87fd981ef0ec4fbba436d96a26f0a7de', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (213, 'e41a4ae5a714499d96f19b1ac06ebd77', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (214, '4aedd26f23954f65b1659ffa7800d1b7', 1002, '2023-05-06 01:20:37', '2023-05-06 01:20:37');
INSERT INTO `user_role` VALUES (215, '983002e42b094577bfc1450f29344123', 1002, '2023-05-09 21:08:39', '2023-05-09 21:08:39');
INSERT INTO `user_role` VALUES (216, 'b70ceaf6b3694d0c9c42fa794838d9a3', 1002, '2023-05-09 21:08:39', '2023-05-09 21:08:39');
INSERT INTO `user_role` VALUES (217, '31eedf8ed0364038ac9cc1871e83a28d', 1002, '2023-05-09 21:08:39', '2023-05-09 21:08:39');
INSERT INTO `user_role` VALUES (218, 'c3f43b10635141debf5008557744164b', 1002, '2023-05-09 21:08:39', '2023-05-09 21:08:39');
INSERT INTO `user_role` VALUES (219, '9c45185e988348bd9cccf6b9be07ce77', 1002, '2023-05-09 21:08:39', '2023-05-09 21:08:39');
INSERT INTO `user_role` VALUES (220, 'e85b5c413a874b39885eb47b33c851e5', 1002, '2023-05-09 21:08:39', '2023-05-09 21:08:39');
INSERT INTO `user_role` VALUES (221, '1e21e301209f465bba12c8c27dfb2753', 1002, '2023-05-09 21:08:39', '2023-05-09 21:08:39');
INSERT INTO `user_role` VALUES (222, '8afb7ab2f9ae405d986a7c5c9321e1c2', 1002, '2023-05-09 21:08:39', '2023-05-09 21:08:39');
INSERT INTO `user_role` VALUES (223, 'db92f6420c60441f8d538432fa35aaf1', 1002, '2023-05-09 21:08:39', '2023-05-09 21:08:39');
INSERT INTO `user_role` VALUES (224, 'e693b1b6cc22401aba6e9a9f77c92424', 1002, '2023-05-09 21:08:39', '2023-05-09 21:08:39');
INSERT INTO `user_role` VALUES (225, '4c05b7e8d785482ab08e235c62416486', 1002, '2023-05-09 21:08:39', '2023-05-09 21:08:39');
INSERT INTO `user_role` VALUES (226, '24579ed0c60e4159b3b830155b0dbcf3', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (227, '66876a7543dd48ddbb4894d6df6114cc', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (228, '9f6c15594b55471381690eeadf6028e0', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (229, 'db06b2044cc64826a3af71ffd83ba1b7', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (230, '4fe98a210d0842c98713f140c525865f', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (231, '5b178f92b8cf45f79ea919355484a0a0', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (232, '122b56674d1f4844998a1650091dc830', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (233, 'bf6ad0bddfb64280bf4f5a205490cc8d', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (234, '5dec0bb7c40643fdabb24f0095a08beb', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (235, '68687098fe18428c9d35e4206ec0eb54', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (236, '8bd7d6c2e99c4f2893a22c70d92af241', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (237, '8143f1683ef64f54a0bf32055f6cde01', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (238, '72b0fcfe41844a608b9d06a1d7b596a9', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (239, '8d410c51e94545368ba4ec5af9bdecda', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (240, '16a2b8ac4df345b3a81279f7f686b053', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (241, 'd53621fd6ce643e1a4412cc6a2c30a01', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (242, '2f98628beb814e8dbf2e9e0409ea3fcc', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (243, 'fe47d3bee8e44e7ca0f3924527552fe7', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (244, '6b9e8a5c12cc478f9347d1e79fa2a8e0', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (245, '4e152da6b55a4b93ba72cca8b0a1e98f', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (246, '8d33acaa1fc74f3ba60ee7333430f6b4', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (247, '632fbba8a5a34f209538eb1f8f56d6b4', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (248, 'f8786eed11614c80a804df082ceb5beb', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (249, '6e734aba229c479689db7b9f7074c8e1', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (250, '47db77484795460baa65f3d1d21fa4c8', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (251, 'ea03047ba5574fdba96b6633aca21873', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (252, 'a359d6d691f24d2d84683e0e96682e15', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (253, '4ce9912bdffd4f07abbdcdc814278a97', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (254, '36688c91ce12463a8c2ee0bf793bb322', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (255, 'a59f02b82f6e4a6bbedfa5b6dbefaefe', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (256, '9a6d708da8dd40bcbf4d42ba319042b5', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (257, '00cb64ad2f5143cca6064d4b3187b4ee', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (258, 'b4d0569c34ef444c91d6e30c6931fff4', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (259, 'cdf039411e054c97b3beeca0c29f09fb', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (260, 'a69ef013a45f4354a2951974a6125734', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (261, '353df3538e0a46cc961f5bb287f129ef', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (262, '2abe5fe68f4241839b6d613f56db52d1', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (263, '40ca10c0f3644e0f936a2d7ae3faf05a', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (264, '50b8ecd6a62e4577a723e577ec61b2f7', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (265, '2692a1a8d39e4b5ea2b09c50957f7c23', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (266, '35989086aa0b4b5e82ba2ac0f09dbdf5', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (267, '4197a7eba4df4ff2a3e61d37a06a0f3c', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (268, '4d2ce36554b74b29805dae33ecbae636', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (269, 'dc68cdbf4b144116a0f322df20ac2ed5', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (270, '3d87ca7fe9f348b1bf6a4c491b94e059', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (271, '2b8c38a1466b40a78b5d0afbabc4f3d5', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (272, 'b07f6640dbe34935a7310039e9ca8792', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (273, 'e8ccd86b35974750a25337b099291b36', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (274, 'f868b1d349e040f5a03ddfe7ab889631', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (275, 'cab1fa2710d2461f9af619c21fb5cd90', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (276, '16e047acbf15451290408f9b77e303f5', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (277, '0aabf963bee9485780c3351123b58f8b', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (278, '8901858986044713ab6a1c8c456f0e05', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (279, 'eeaad73f74cb491587bf24cc320b671c', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (280, '49e10db996234ebdba7f241999710ba9', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (281, '92f6ff93bd6b471899168507a4a396a0', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (282, '2e483216acab485c80aeeeba7719e3ea', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (283, '664970c7c2e24f81951be92bd1891814', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (284, '8b0d1d8e0f1f426999e6043c98dc8698', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (285, 'd7bef82561aa4310b5f77ba67bb46a3c', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (286, '06cace76e41a4391b418cc010d453dda', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (287, '325349216c794dc3afc4024fffa7e0fb', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (288, 'e8c5e3f8acb14bf5953d2f4c30b63732', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (289, 'c0fd41b337784ae7a9e470574ab2caae', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (290, 'daa3d431aadb42c7a16ecbd00e0d9cf7', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (291, '80d6d1df0e8e4afdbb232912af02ecd1', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (292, '58348e2e0758421e87b53d7af46bebb4', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (293, '145d1807a64b4395af32de2799e00ba3', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (294, 'f840e69ec8784a1e9433b44407af45be', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (295, 'd89bb99d28f14e02a7aaa5a6dd6e3a02', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (296, '5d5847fd69084317b46d268b6e05f3b6', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (297, '13106c57502c427dbc5489ab34196ae4', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (298, 'e5a5a3796d9346d5893b391e09722151', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (299, '18cb3a9b3b124a469158d5381f73744a', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (300, 'cce5cd24e9154b65a4befd97b74b2880', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (301, '63925f6cf1a84b30a9ef5996d5e900ba', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (302, '3a20618e6e3d44ee815bd7855e200368', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (303, '31e32a03e55f4337b21e99981e9c0970', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (304, 'c53f0867956d4686accf263a63e37c14', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (305, '684f5c75e46f4a55ac79c04f6d37152c', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (306, 'a83371f25dad457ab17eaa578d8653d1', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (307, 'dcf0cde95e1941a6bf2bc1df58a336e0', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (308, '15c535f043ff48beacefb16f5c3bd7b2', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (309, '3e46cbc27f0b4a018c5207914fd9de8a', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (310, '1059d20f95a749c7af75b3b874c9485c', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (311, '63f8c8a1bc0f41aeb07b5f4b9afb1e6d', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (312, '16b4f27bfb9d4f2cb1cd75b8057e2d16', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (313, 'd9219566b4324e428cc7c34431d41e25', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (314, '156e5c230dc645df894645f46f98bd3e', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (315, 'dfab7817728b4d3581d9542390426c49', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (316, 'dec423044e6b43e2aec8ea35149ef384', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (317, '57ab1c550ca344c9a454d315bac1dcb9', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (318, '6a48846f7e734a668800ac71baa010b9', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (319, 'd0085b3db9c64b12a876e236b44b1a57', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (320, 'aeb6ffd910f34e858239f3d53b456974', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (321, 'e033b5809d38418f93ebeac3dda5782e', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (322, '810f3254c97a41cfbc2de94af3991f82', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (323, '9da55b32438e408698bd64aa3a86c474', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (324, 'cc1d3646042e441c9b0be6bd25e3021f', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (325, 'f49c3dd55aaa455480d18fe14f3ca9d1', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (326, '2f1a93d640e94b1ca84fd2e88000de49', 1002, '2023-05-09 21:11:49', '2023-05-09 21:11:49');
INSERT INTO `user_role` VALUES (327, '4c2b67f11d634355b6135cdb70cd4b14', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (328, '3701afd5c368442a86827aa6419e0995', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (329, '455dbe5bce3f44d2903f26ceae9ad59f', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (330, 'cd60766fdad84083bf8ef4775b858a4e', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (331, 'de73881f711842c4bf16fd3b5f6ea652', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (332, '11a49c668ce94ed097aa7c5244bea9ca', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (333, 'd45ab2362923485e9cf29db4f052387a', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (334, 'd48468af105b45cd99b0a83b8043e5d0', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (335, '0a2e447fb0a04631a366f212538f8b84', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (336, 'bb72aca6e69349c386c8e2c26bddfdad', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (337, '416f5e4ae2c54aaf8fb67668a5c67893', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (338, '494f3410f72942689b052309dde1d010', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (339, '64e4e6559624493ba0a7603f70eb8df2', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (340, 'd6286972c79740d786db38ccfb8e601b', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (341, 'e7f10d719c9f48c78b3ba0ad18b00827', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (342, '5209d551064e4bd49ecd30bc79097bce', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (343, '7c7ce6ae5e634e928263c3c1605d1da6', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (344, '4b10a50c4ed84cc59789eaa0d42b6771', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (345, 'cd880aca32cf4f0a87eaef937e642e96', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (346, '90550f2c047848ff8c448184b981b474', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (347, '4bd7a55994b747ec9f6a3f643ebda36d', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (348, '849e8d0dc7b74169a83d99d1edef9586', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (349, '5e95259794994889a4b158cba8b39b89', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (350, 'e2bb84821e634d4792dc7a49d6c19645', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (351, '9bd807d1abde4f719b22b4a319945730', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (352, '2c7ba4628d48415bbcd6732273e657de', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (353, '46563b9a2329498a8fc1f99f2db1db10', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (354, '606ffb7607594857a2221fc77651a86b', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (355, '09e1a321da654b6880cd0b61f40509d9', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (356, '28c170755ad2428aae288e2703bbce03', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (357, '63a54b01e11f46b3a923cb423d72c5b3', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (358, 'baeb9796936a422a9c808a8954b3e30c', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (359, 'a49820d9a26b4bc3872b0e986165bed9', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (360, '3102f8f8d3294821a7b09269896c918f', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (361, '9b78f3684f93442194d742cb7ef1b746', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (362, '8463e213ff72441bb18c134c3efb4445', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (363, '6e1a40be34344c5db90624778d9f27a8', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (364, '93ea4948e3a347799f56783f7fe1ec9c', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (365, 'bdef3968994b4a12ac7e30990e4579c9', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (366, 'd14b1dcedfb64f169377c9607040968f', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (367, 'e5dba40dcf474eccaab450bc007f671e', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (368, '050e69fa551245d8879d504d2efa1223', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (369, '28761360c7ed447592b70e4d3dd5201b', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (370, '8b70495dea6d4e4ea0bc5eae889a8fcd', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (371, 'a9016dc2abfe45deaf87a926363d5e05', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (372, 'ca6915d8d78a4fe5bfc0aa0f75916fa8', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (373, 'b7b4600d8f0046f1a21a22155a334c89', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (374, '7414aaeca87d463ca100c73f29798bf8', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (375, '45c191a84e6a4002a2a503e7f15ff079', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (376, '8a1410e7763b41678942411dcd9191a0', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (377, '7840179a40c3496cacfd94ad070bd3db', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (378, '828558666e8a40b080206dddd17c51a4', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (379, 'd746cae8a0b340f3910cea5ed4fa7e5d', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (380, '512dc1a99c294405944276aaa3002a0a', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (381, '2fddf8abf2e94c2aa3c171855549bf98', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (382, '41534b2b6fbe43cf8accd0960d21d5ac', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (383, '8db44e3d2a2a4a13a9f7af4ec6499f9f', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (384, '24edbb55f7cc44c2bd965a58de3d24fd', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (385, '220096cd878f40ce8809bd1ec049d7f3', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (386, 'e04641b5fd284a4983cb0c4b0f848187', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (387, '5cae094d92d34331899486b79f54e209', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (388, 'e1e47cc972b1482fa34dae21cd5af860', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (389, '157026427da04336929f8fb7662f08bb', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (390, '3c5e8ee696d24f0f82f2b054c3f6d7e6', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (392, '819deedf39674a4480fd6b620f74ea6b', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (393, '9f554a31416c4aa39408221bf18fa08b', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (394, '65bf4299877f4ba5a44cf721aafc0e32', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (395, '5fea6ee4d4c64da2920ca592a491a547', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (396, '1d18e422a9fd4916b99bc928ef7783c5', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (397, 'dacf29857ca54fb0a19b2c39c2deebb2', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (398, '184dcb0cb87b46f09e6d4518ca5a45af', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (399, '245e921ffad34de18099121aac72d4a0', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (400, 'd838d6edbc1a419aba994eea00229b66', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (401, '0fd8af0e419f4eb9a505b642160fe465', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (402, 'e2105f3c986f442b81adc5d0c609d28f', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (403, 'dc4408f3ffd04f928d2cbcf36ad025a1', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (404, 'ba4a247dcdf54704b255724157ad2550', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (405, '1d21781e91ec4bfd87edcd11efa97da2', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (406, 'e7a82177430b4547ac81d6c5617fb7fa', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (407, 'aaa076e4492d4c4893dedbe149002bab', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (408, 'd6878a306b96403388deaee77234fa6e', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (409, 'a0e146e145354146be3b430adfb09f22', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (410, '05e5342614734a7c92860a85c2858379', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (411, '9975181284cc4318b3033f91dfae5677', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (412, '1fbecc8d4b8e40838923479af95e0d3a', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (413, 'daf60eae04754cea84ce3a7a6ef310c6', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (414, 'e975dd8505e6491aaeb106e8a92fc598', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (415, 'ba1bca167b834528879577117e679d80', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (416, '9dcfb031ed1d4f96add97a32310f55b7', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (417, 'fd3ae04892b847b7aeefa8ad62c4527f', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (418, '1374c0523c3942e286535407af39680b', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (419, 'd9e56fe15e284934b6846e4885fc0eb9', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (420, '2fac493ea0624690ba77cb851325771d', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (421, '83d37ad0db3e4539acdb77053838179e', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (422, 'a78a992b3b8b40a7a60f007b07ff5ee9', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (423, 'cb38cc5fc62746c894013dda5fd899a3', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (424, 'bf56a3d523a24d0289a9574e23f908cc', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (425, '52a9ab971bb14a7e9de2dbd0b9b6dcd5', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (426, 'daf7783ce14d4d1d9222a296dd2ca157', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (427, '326cbf2495f9449d840726e551b7ccfb', 1002, '2023-05-09 21:29:09', '2023-05-09 21:29:09');
INSERT INTO `user_role` VALUES (428, 'c01ad37173c74ed6ac6ca09a080db5af', 1002, '2023-05-12 20:25:41', '2023-05-12 20:25:41');
INSERT INTO `user_role` VALUES (429, '315c3ff6d0f648f78b7c2a05f939a637', 1002, '2023-05-12 20:25:41', '2023-05-12 20:25:41');
INSERT INTO `user_role` VALUES (430, '5978594be7a94a35b9c1d28304613fb9', 1002, '2023-05-12 20:25:41', '2023-05-12 20:25:41');
INSERT INTO `user_role` VALUES (431, 'a0af53355faf43b7b93d9a92ec13159e', 1002, '2023-05-12 20:25:41', '2023-05-12 20:25:41');
INSERT INTO `user_role` VALUES (432, '52c4176536184deb88656832dfdeccdc', 1002, '2023-05-12 20:25:41', '2023-05-12 20:25:41');
INSERT INTO `user_role` VALUES (433, 'ea241869c7f3451a914eecb1af504843', 1002, '2023-05-12 20:25:41', '2023-05-12 20:25:41');
INSERT INTO `user_role` VALUES (434, 'a843c6687ccc48b39cff150b09f4327a', 1002, '2023-05-12 20:25:41', '2023-05-12 20:25:41');
INSERT INTO `user_role` VALUES (435, 'a26794e661844a57b7c77ee7744c5050', 1002, '2023-05-12 20:25:41', '2023-05-12 20:25:41');
INSERT INTO `user_role` VALUES (436, '3605de92ad8e4af4ac1ebbfc4fc8cb2e', 1002, '2023-05-12 20:25:41', '2023-05-12 20:25:41');
INSERT INTO `user_role` VALUES (437, '452396b08cb04ef48f6d4618241b2508', 1002, '2023-05-12 20:25:41', '2023-05-12 20:25:41');
INSERT INTO `user_role` VALUES (438, 'd9d5e5ae3f3d4a44a055e52f7a7fa6c9', 1002, '2023-05-12 20:25:41', '2023-05-12 20:25:41');
INSERT INTO `user_role` VALUES (443, 'af17f3af6ffa437b9cdb72b37511b53d', 1002, '2023-05-14 12:13:17', '2023-05-14 12:13:17');

-- ----------------------------
-- Table structure for user_sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `user_sys_notice`;
CREATE TABLE `user_sys_notice`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `sys_notice_id` bigint(0) UNSIGNED NULL DEFAULT NULL COMMENT '系统通知的id',
  `recipient_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '接受通知的用户id',
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '消息类型，系统通知sys、我的信息mine',
  `state` tinyint(1) NULL DEFAULT 0 COMMENT '是否已读',
  `gmt_create` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '读取时间',
  `gmt_modified` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sys_notice_id`(`sys_notice_id`) USING BTREE,
  INDEX `recipient_id`(`recipient_id`) USING BTREE,
  CONSTRAINT `user_sys_notice_ibfk_1` FOREIGN KEY (`sys_notice_id`) REFERENCES `admin_sys_notice` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_sys_notice_ibfk_2` FOREIGN KEY (`recipient_id`) REFERENCES `user_info` (`uuid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_sys_notice
-- ----------------------------
INSERT INTO `user_sys_notice` VALUES (1, 1, '1', 'Sys', 1, '2023-04-25 21:43:58', '2023-04-25 21:46:36');
INSERT INTO `user_sys_notice` VALUES (2, 2, '1', 'Sys', 1, '2023-04-26 22:07:57', '2023-04-27 23:47:38');
INSERT INTO `user_sys_notice` VALUES (3, 3, '1', 'Sys', 1, '2023-04-27 23:41:53', '2023-04-27 23:47:38');
INSERT INTO `user_sys_notice` VALUES (4, 4, '1', 'Sys', 1, '2023-05-05 00:45:14', '2023-05-06 21:55:04');
INSERT INTO `user_sys_notice` VALUES (5, 5, '1', 'Sys', 1, '2023-05-06 01:12:00', '2023-05-06 21:55:04');
INSERT INTO `user_sys_notice` VALUES (6, 6, '1', 'Sys', 1, '2023-05-06 01:16:16', '2023-05-06 21:55:04');
INSERT INTO `user_sys_notice` VALUES (7, 7, 'ffb14501ad9a41a2ad7c46105e23cbb7', 'Sys', 0, '2023-05-06 20:24:11', '2023-05-06 20:24:11');
INSERT INTO `user_sys_notice` VALUES (8, 8, '1', 'Sys', 1, '2023-05-06 21:44:57', '2023-05-06 21:55:04');
INSERT INTO `user_sys_notice` VALUES (9, 9, '1', 'Sys', 1, '2023-05-06 21:54:08', '2023-05-06 21:55:04');
INSERT INTO `user_sys_notice` VALUES (10, 10, '1', 'Sys', 1, '2023-05-09 01:27:44', '2023-05-14 18:32:30');
INSERT INTO `user_sys_notice` VALUES (11, 11, '1', 'Sys', 1, '2023-05-09 20:00:53', '2023-05-14 18:32:30');
INSERT INTO `user_sys_notice` VALUES (12, 12, '1', 'Sys', 1, '2023-05-10 22:24:15', '2023-05-14 18:32:30');
INSERT INTO `user_sys_notice` VALUES (13, 13, '1', 'Sys', 1, '2023-05-10 22:33:50', '2023-05-14 18:32:30');
INSERT INTO `user_sys_notice` VALUES (14, 14, '1', 'Sys', 1, '2023-05-12 03:23:16', '2023-05-14 18:32:30');
INSERT INTO `user_sys_notice` VALUES (15, 15, '1', 'Sys', 1, '2023-05-12 23:11:43', '2023-05-14 18:32:30');
INSERT INTO `user_sys_notice` VALUES (16, 16, '1', 'Sys', 1, '2023-05-12 23:18:48', '2023-05-14 18:32:30');
INSERT INTO `user_sys_notice` VALUES (17, 17, NULL, 'Sys', 0, '2023-05-12 23:42:42', '2023-05-12 23:42:42');
INSERT INTO `user_sys_notice` VALUES (18, 18, '1', 'Sys', 1, '2023-05-14 11:15:18', '2023-05-14 18:32:30');
INSERT INTO `user_sys_notice` VALUES (19, 19, '1', 'Sys', 0, '2023-05-14 18:41:00', '2023-05-14 18:41:00');
INSERT INTO `user_sys_notice` VALUES (20, 20, '1', 'Sys', 0, '2023-05-15 19:40:22', '2023-05-15 19:40:22');
INSERT INTO `user_sys_notice` VALUES (21, 21, '1', 'Sys', 0, '2023-05-15 22:19:10', '2023-05-15 22:19:10');
INSERT INTO `user_sys_notice` VALUES (22, 22, '1', 'Sys', 0, '2023-05-16 21:39:24', '2023-05-16 21:39:24');
INSERT INTO `user_sys_notice` VALUES (23, 23, '1', 'Sys', 0, '2023-05-16 22:40:40', '2023-05-16 22:40:40');
INSERT INTO `user_sys_notice` VALUES (24, 24, '1', 'Sys', 0, '2023-05-17 22:45:06', '2023-05-17 22:45:06');
INSERT INTO `user_sys_notice` VALUES (25, 25, '1', 'Sys', 0, '2023-05-17 23:12:24', '2023-05-17 23:12:24');
INSERT INTO `user_sys_notice` VALUES (26, 26, '1', 'Sys', 0, '2023-05-18 22:01:44', '2023-05-18 22:01:44');

-- ----------------------------
-- Procedure structure for contest_status
-- ----------------------------
DROP PROCEDURE IF EXISTS `contest_status`;
delimiter ;;
CREATE PROCEDURE `contest_status`()
BEGIN
      UPDATE contest 
	SET STATUS = (
	CASE 
	  WHEN NOW() < start_time THEN -1 
	  WHEN NOW() >= start_time AND NOW()<end_time THEN  0
	  WHEN NOW() >= end_time THEN 1
	END);
    END
;;
delimiter ;

-- ----------------------------
-- Event structure for contest_event
-- ----------------------------
DROP EVENT IF EXISTS `contest_event`;
delimiter ;;
CREATE EVENT `contest_event`
ON SCHEDULE
EVERY '1' SECOND STARTS '2021-04-18 19:04:49'
ON COMPLETION PRESERVE
DO CALL contest_status()
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table contest
-- ----------------------------
DROP TRIGGER IF EXISTS `contest_trigger`;
delimiter ;;
CREATE TRIGGER `contest_trigger` BEFORE INSERT ON `contest` FOR EACH ROW BEGIN
set new.status=(
	CASE 
	  WHEN NOW() < new.start_time THEN -1 
	  WHEN NOW() >= new.start_time AND NOW()<new.end_time THEN  0
	  WHEN NOW() >= new.end_time THEN 1
	END);
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
