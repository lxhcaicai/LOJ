/*
 Navicat Premium Data Transfer

 Source Server         : loj-mysql
 Source Server Type    : MySQL
 Source Server Version : 80100 (8.1.0)
 Source Host           : localhost:3307
 Source Schema         : loj

 Target Server Type    : MySQL
 Target Server Version : 80100 (8.1.0)
 File Encoding         : 65001

 Date: 16/09/2023 01:05:19
*/

CREATE DATABASE IF NOT EXISTS`loj` DEFAULT CHARACTER SET utf8;

USE `loj`;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin_sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `admin_sys_notice`;
CREATE TABLE `admin_sys_notice`  (
                                     `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
                                     `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                     `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
                                     `type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '发给哪些用户类型',
                                     `state` tinyint(1) NULL DEFAULT 0 COMMENT '是否已拉取给用户',
                                     `recipient_id` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '接受通知的用户id',
                                     `admin_id` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '发送通知的管理员id',
                                     `gmt_create` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                     `gmt_modified` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
                                     PRIMARY KEY (`id`) USING BTREE,
                                     INDEX `recipient_id`(`recipient_id` ASC) USING BTREE,
                                     INDEX `admin_id`(`admin_id` ASC) USING BTREE,
                                     CONSTRAINT `admin_sys_notice_ibfk_1` FOREIGN KEY (`recipient_id`) REFERENCES `user_info` (`uuid`) ON DELETE CASCADE ON UPDATE CASCADE,
                                     CONSTRAINT `admin_sys_notice_ibfk_2` FOREIGN KEY (`admin_id`) REFERENCES `user_info` (`uuid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 43 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_sys_notice
-- ----------------------------
INSERT INTO `admin_sys_notice` VALUES (1, '账号异地登录通知(Account Remote Login Notice)', '亲爱的用户，您好！您的账号于2023-04-25 21:43:57在【 本机地址】登录，登录IP为：【127.0.0.1】，若非本人操作，请立即修改密码。\n\nHello! Dear user, Your account was logged in in 【 本机地址】 on 2023-04-25 21:43:57. If you do not operate by yourself, please change your password immediately.', 'Single', 1, '1', '1', '2023-04-25 21:43:58', '2023-04-25 21:43:58');
INSERT INTO `admin_sys_notice` VALUES (2, '账号异地登录通知(Account Remote Login Notice)', '亲爱的用户，您好！您的账号于2023-04-26 22:07:55在【广东省深圳市 电信】登录，登录IP为：【0:0:0:0:0:0:0:1】，若非本人操作，请立即修改密码。\n\nHello! Dear user, Your account was logged in in 【广东省深圳市 电信】 on 2023-04-26 22:07:55. If you do not operate by yourself, please change your password immediately.', 'Single', 1, '1', '1', '2023-04-26 22:07:56', '2023-04-26 22:07:57');
INSERT INTO `admin_sys_notice` VALUES (3, '账号异地登录通知(Account Remote Login Notice)', '亲爱的用户，您好！您的账号于2023-04-27 23:41:52在【 本机地址】登录，登录IP为：【127.0.0.1】，若非本人操作，请立即修改密码。\n\nHello! Dear user, Your account was logged in in 【 本机地址】 on 2023-04-27 23:41:52. If you do not operate by yourself, please change your password immediately.', 'Single', 1, '1', '1', '2023-04-27 23:41:53', '2023-04-27 23:41:53');
INSERT INTO `admin_sys_notice` VALUES (4, '账号异地登录通知(Account Remote Login Notice)', '亲爱的用户，您好！您的账号于2023-05-05 00:45:13在【广东省深圳市 电信】登录，登录IP为：【0:0:0:0:0:0:0:1】，若非本人操作，请立即修改密码。\n\nHello! Dear user, Your account was logged in in 【广东省深圳市 电信】 on 2023-05-05 00:45:13. If you do not operate by yourself, please change your password immediately.', 'Single', 1, '1', '1', '2023-05-05 00:45:14', '2023-05-05 00:45:14');
INSERT INTO `admin_sys_notice` VALUES (5, '账号异地登录通知(Account Remote Login Notice)', '亲爱的用户，您好！您的账号于2023-05-06 01:11:59在【 本机地址】登录，登录IP为：【127.0.0.1】，若非本人操作，请立即修改密码。\n\nHello! Dear user, Your account was logged in in 【 本机地址】 on 2023-05-06 01:11:59. If you do not operate by yourself, please change your password immediately.', 'Single', 1, '1', '1', '2023-05-06 01:12:00', '2023-05-06 01:12:00');
INSERT INTO `admin_sys_notice` VALUES (6, '账号异地登录通知(Account Remote Login Notice)', '亲爱的用户，您好！您的账号于2023-05-06 01:16:15在【广东省深圳市 电信】登录，登录IP为：【0:0:0:0:0:0:0:1】，若非本人操作，请立即修改密码。\n\nHello! Dear user, Your account was logged in in 【广东省深圳市 电信】 on 2023-05-06 01:16:15. If you do not operate by yourself, please change your password immediately.', 'Single', 1, '1', '1', '2023-05-06 01:16:16', '2023-05-06 01:16:16');
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
INSERT INTO `admin_sys_notice` VALUES (27, '账号异地登录通知(Account Remote Login Notice)', '亲爱的用户，您好！您的账号于2023-07-03 22:38:32在【广东省深圳市 电信】登录，登录IP为：【0:0:0:0:0:0:0:1】，若非本人操作，请立即修改密码。\n\nHello! Dear user, Your account was logged in in 【广东省深圳市 电信】 on 2023-07-03 22:38:32. If you do not operate by yourself, please change your password immediately.', 'Single', 1, '1', '1', '2023-07-03 22:38:33', '2023-07-03 22:38:33');
INSERT INTO `admin_sys_notice` VALUES (28, '账号异地登录通知(Account Remote Login Notice)', '亲爱的用户，您好！您的账号于2023-07-04 22:53:44在【 本机地址】登录，登录IP为：【127.0.0.1】，若非本人操作，请立即修改密码。\n\nHello! Dear user, Your account was logged in in 【 本机地址】 on 2023-07-04 22:53:44. If you do not operate by yourself, please change your password immediately.', 'Single', 1, '1', '1', '2023-07-04 22:53:45', '2023-07-04 22:53:45');
INSERT INTO `admin_sys_notice` VALUES (29, '账号异地登录通知(Account Remote Login Notice)', '亲爱的用户，您好！您的账号于2023-07-04 22:55:51在【广东省深圳市 电信】登录，登录IP为：【0:0:0:0:0:0:0:1】，若非本人操作，请立即修改密码。\n\nHello! Dear user, Your account was logged in in 【广东省深圳市 电信】 on 2023-07-04 22:55:51. If you do not operate by yourself, please change your password immediately.', 'Single', 1, '1', '1', '2023-07-04 22:55:52', '2023-07-04 22:55:52');
INSERT INTO `admin_sys_notice` VALUES (30, '账号异地登录通知(Account Remote Login Notice)', '亲爱的用户，您好！您的账号于2023-07-07 23:19:07在【 本机地址】登录，登录IP为：【127.0.0.1】，若非本人操作，请立即修改密码。\n\nHello! Dear user, Your account was logged in in 【 本机地址】 on 2023-07-07 23:19:07. If you do not operate by yourself, please change your password immediately.', 'Single', 1, '1', '1', '2023-07-07 23:19:08', '2023-07-07 23:19:08');
INSERT INTO `admin_sys_notice` VALUES (31, '账号异地登录通知(Account Remote Login Notice)', '亲爱的用户，您好！您的账号于2023-07-07 23:23:45在【广东省深圳市 电信】登录，登录IP为：【0:0:0:0:0:0:0:1】，若非本人操作，请立即修改密码。\n\nHello! Dear user, Your account was logged in in 【广东省深圳市 电信】 on 2023-07-07 23:23:45. If you do not operate by yourself, please change your password immediately.', 'Single', 1, '1', '1', '2023-07-07 23:23:46', '2023-07-07 23:23:46');
INSERT INTO `admin_sys_notice` VALUES (32, '账号异地登录通知(Account Remote Login Notice)', '亲爱的用户，您好！您的账号于2023-07-11 08:13:06在【 本机地址】登录，登录IP为：【127.0.0.1】，若非本人操作，请立即修改密码。\n\nHello! Dear user, Your account was logged in in 【 本机地址】 on 2023-07-11 08:13:06. If you do not operate by yourself, please change your password immediately.', 'Single', 1, '1', '1', '2023-07-11 08:13:07', '2023-07-11 08:13:07');
INSERT INTO `admin_sys_notice` VALUES (33, '账号异地登录通知(Account Remote Login Notice)', '亲爱的用户，您好！您的账号于2023-07-11 20:35:41在【广东省深圳市 电信】登录，登录IP为：【0:0:0:0:0:0:0:1】，若非本人操作，请立即修改密码。\n\nHello! Dear user, Your account was logged in in 【广东省深圳市 电信】 on 2023-07-11 20:35:41. If you do not operate by yourself, please change your password immediately.', 'Single', 1, '1', '1', '2023-07-11 20:35:42', '2023-07-11 20:35:42');
INSERT INTO `admin_sys_notice` VALUES (34, '账号异地登录通知(Account Remote Login Notice)', '亲爱的用户，您好！您的账号于2023-07-16 10:13:45在【 本机地址】登录，登录IP为：【127.0.0.1】，若非本人操作，请立即修改密码。\n\nHello! Dear user, Your account was logged in in 【 本机地址】 on 2023-07-16 10:13:45. If you do not operate by yourself, please change your password immediately.', 'Single', 1, '1', '1', '2023-07-16 10:13:47', '2023-07-16 10:13:47');
INSERT INTO `admin_sys_notice` VALUES (35, '账号异地登录通知(Account Remote Login Notice)', '亲爱的用户，您好！您的账号于2023-07-16 10:15:29在【广东省深圳市 电信】登录，登录IP为：【0:0:0:0:0:0:0:1】，若非本人操作，请立即修改密码。\n\nHello! Dear user, Your account was logged in in 【广东省深圳市 电信】 on 2023-07-16 10:15:29. If you do not operate by yourself, please change your password immediately.', 'Single', 1, '1', '1', '2023-07-16 10:15:31', '2023-07-16 10:15:31');
INSERT INTO `admin_sys_notice` VALUES (36, '账号异地登录通知(Account Remote Login Notice)', '亲爱的用户，您好！您的账号于2023-07-16 10:26:07在【 本机地址】登录，登录IP为：【127.0.0.1】，若非本人操作，请立即修改密码。\n\nHello! Dear user, Your account was logged in in 【 本机地址】 on 2023-07-16 10:26:07. If you do not operate by yourself, please change your password immediately.', 'Single', 1, '1', '1', '2023-07-16 10:26:09', '2023-07-16 10:26:09');
INSERT INTO `admin_sys_notice` VALUES (37, '账号异地登录通知(Account Remote Login Notice)', '亲爱的用户，您好！您的账号于2023-07-16 11:17:30在【广东省深圳市 电信】登录，登录IP为：【0:0:0:0:0:0:0:1】，若非本人操作，请立即修改密码。\n\nHello! Dear user, Your account was logged in in 【广东省深圳市 电信】 on 2023-07-16 11:17:30. If you do not operate by yourself, please change your password immediately.', 'Single', 1, '1', '1', '2023-07-16 11:17:32', '2023-07-16 11:17:32');
INSERT INTO `admin_sys_notice` VALUES (38, '账号异地登录通知(Account Remote Login Notice)', '亲爱的用户，您好！您的账号于2023-07-19 22:55:59在【 本机地址】登录，登录IP为：【127.0.0.1】，若非本人操作，请立即修改密码。\n\nHello! Dear user, Your account was logged in in 【 本机地址】 on 2023-07-19 22:55:59. If you do not operate by yourself, please change your password immediately.', 'Single', 1, '1', '1', '2023-07-19 22:56:00', '2023-07-19 22:56:00');
INSERT INTO `admin_sys_notice` VALUES (39, '账号异地登录通知(Account Remote Login Notice)', '亲爱的用户，您好！您的账号于2023-07-19 23:33:08在【广东省深圳市 电信】登录，登录IP为：【0:0:0:0:0:0:0:1】，若非本人操作，请立即修改密码。\n\nHello! Dear user, Your account was logged in in 【广东省深圳市 电信】 on 2023-07-19 23:33:08. If you do not operate by yourself, please change your password immediately.', 'Single', 1, '1', '1', '2023-07-19 23:33:09', '2023-07-19 23:33:09');
INSERT INTO `admin_sys_notice` VALUES (40, '账号异地登录通知(Account Remote Login Notice)', '亲爱的用户，您好！您的账号于2023-09-05 21:22:27在【 本机地址】登录，登录IP为：【127.0.0.1】，若非本人操作，请立即修改密码。\n\nHello! Dear user, Your account was logged in in 【 本机地址】 on 2023-09-05 21:22:27. If you do not operate by yourself, please change your password immediately.', 'Single', 1, '1', '1', '2023-09-05 21:22:28', '2023-09-05 21:22:28');
INSERT INTO `admin_sys_notice` VALUES (41, '这个是通知呀！', '这个是通知呀！', 'All', 1, NULL, '1', '2023-09-10 18:27:37', '2023-09-10 19:00:00');
INSERT INTO `admin_sys_notice` VALUES (42, '权限变更通知(Authority Change Notice)', '您好，您的权限产生了变更，由【普通用户(默认)】变更为【超级管理员】。部分权限可能与之前有所不同，请您注意！\n\nHello, your permission has been changed from 【Normal User(Default)】 to 【Super Administrator】. Some permissions may be different from before. Please note!', 'Single', 1, 'af17f3af6ffa437b9cdb72b37511b53d', '1', '2023-09-16 00:59:59', '2023-09-16 00:59:59');

-- ----------------------------
-- Table structure for announcement
-- ----------------------------
DROP TABLE IF EXISTS `announcement`;
CREATE TABLE `announcement`  (
                                 `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
                                 `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                 `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
                                 `uid` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
                                 `status` int NULL DEFAULT 0 COMMENT '0可见，1不可见',
                                 `gid` bigint UNSIGNED NULL DEFAULT NULL,
                                 `gmt_create` datetime NULL DEFAULT CURRENT_TIMESTAMP,
                                 `gmt_modified` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                 PRIMARY KEY (`id`) USING BTREE,
                                 INDEX `uid`(`uid` ASC) USING BTREE,
                                 INDEX `announcement_ibfk_2`(`gid` ASC) USING BTREE,
                                 CONSTRAINT `announcement_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `user_info` (`uuid`) ON DELETE CASCADE ON UPDATE CASCADE,
                                 CONSTRAINT `announcement_ibfk_2` FOREIGN KEY (`gid`) REFERENCES `group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of announcement
-- ----------------------------
INSERT INTO `announcement` VALUES (1, '这是一个公告', '这是一个公告！！！', '1', 0, NULL, '2023-05-17 23:34:40', '2023-05-17 23:34:40');
INSERT INTO `announcement` VALUES (2, '这是公告', '这是公告xxxaasdasdas', '1', 0, NULL, '2023-09-10 18:27:12', '2023-09-10 18:27:12');

-- ----------------------------
-- Table structure for auth
-- ----------------------------
DROP TABLE IF EXISTS `auth`;
CREATE TABLE `auth`  (
                         `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
                         `name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '权限名称',
                         `permission` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '权限字符串',
                         `status` tinyint NOT NULL DEFAULT 0 COMMENT '0可用，1不可用',
                         `gmt_create` datetime NULL DEFAULT CURRENT_TIMESTAMP,
                         `gmt_modified` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                         PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

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
                             `id` int NOT NULL AUTO_INCREMENT,
                             `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
                             `gmt_create` datetime NULL DEFAULT CURRENT_TIMESTAMP,
                             `gmt_modified` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                             PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (1, '闲聊', '2021-05-06 11:25:24', '2023-07-09 11:59:01');
INSERT INTO `category` VALUES (2, '题解', '2021-05-06 11:25:36', '2023-07-09 11:59:01');
INSERT INTO `category` VALUES (3, '求助', '2021-05-06 11:25:40', '2023-07-09 11:59:01');
INSERT INTO `category` VALUES (4, '建议', '2021-05-06 11:25:56', '2023-07-09 11:59:01');
INSERT INTO `category` VALUES (5, '记录', '2021-05-06 11:26:02', '2023-07-09 11:59:01');

-- ----------------------------
-- Table structure for code_template
-- ----------------------------
DROP TABLE IF EXISTS `code_template`;
CREATE TABLE `code_template`  (
                                  `id` int NOT NULL AUTO_INCREMENT,
                                  `pid` bigint UNSIGNED NOT NULL,
                                  `lid` bigint UNSIGNED NOT NULL,
                                  `code` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
                                  `status` tinyint(1) NULL DEFAULT 0,
                                  `gmt_create` datetime NULL DEFAULT CURRENT_TIMESTAMP,
                                  `gmt_modified` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                  PRIMARY KEY (`id`) USING BTREE,
                                  INDEX `pid`(`pid` ASC) USING BTREE,
                                  INDEX `lid`(`lid` ASC) USING BTREE,
                                  CONSTRAINT `code_template_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `problem` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                                  CONSTRAINT `code_template_ibfk_2` FOREIGN KEY (`lid`) REFERENCES `language` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of code_template
-- ----------------------------

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
                            `id` int NOT NULL AUTO_INCREMENT,
                            `cid` bigint UNSIGNED NULL DEFAULT NULL COMMENT 'null表示无引用比赛',
                            `did` int NULL DEFAULT NULL COMMENT 'null表示无引用讨论',
                            `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
                            `from_uid` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '评论者id',
                            `from_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '评论者用户名',
                            `from_avatar` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '评论组头像地址',
                            `from_role` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '评论者角色',
                            `like_num` int NULL DEFAULT 0 COMMENT '点赞数量',
                            `status` int NULL DEFAULT 0 COMMENT '是否封禁或逻辑删除该评论',
                            `gmt_create` datetime NULL DEFAULT CURRENT_TIMESTAMP,
                            `gmt_modified` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                            PRIMARY KEY (`id`) USING BTREE,
                            INDEX `uid`(`from_uid` ASC) USING BTREE,
                            INDEX `from_avatar`(`from_avatar` ASC) USING BTREE,
                            INDEX `comment_ibfk_7`(`did` ASC) USING BTREE,
                            INDEX `cid`(`cid` ASC) USING BTREE,
                            CONSTRAINT `comment_ibfk_6` FOREIGN KEY (`from_avatar`) REFERENCES `user_info` (`avatar`) ON DELETE CASCADE ON UPDATE CASCADE,
                            CONSTRAINT `comment_ibfk_7` FOREIGN KEY (`did`) REFERENCES `discussion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                            CONSTRAINT `comment_ibfk_8` FOREIGN KEY (`cid`) REFERENCES `contest` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES (1, NULL, 1, '牛逼！&#128512;', '1', 'root', NULL, 'root', -1, 0, '2023-07-03 22:30:41', '2023-07-19 23:38:39');
INSERT INTO `comment` VALUES (2, NULL, 1, '哈哈', '1', 'root', NULL, 'root', 0, 0, '2023-07-03 22:31:37', '2023-07-03 22:31:37');
INSERT INTO `comment` VALUES (3, NULL, 5, '111', '1', 'root', NULL, 'root', 0, 0, '2023-07-16 11:13:11', '2023-07-16 11:13:11');
INSERT INTO `comment` VALUES (4, NULL, 5, '222', '1', 'root', NULL, 'root', 0, 0, '2023-07-16 11:13:54', '2023-07-16 11:13:54');
INSERT INTO `comment` VALUES (5, NULL, 5, '&#128512;111\n```\ncode block\n```\n[hh](www.baidu.com)\n1. ...', '1', 'root', NULL, 'root', 0, 0, '2023-07-16 11:16:23', '2023-07-16 11:16:23');
INSERT INTO `comment` VALUES (6, NULL, 5, '&#128512;122\n```\ncode block\n```\n[hh](www.baidu.com)\n1. ...', '1', 'root', NULL, 'root', 0, 0, '2023-07-16 11:17:55', '2023-07-16 11:17:55');
INSERT INTO `comment` VALUES (7, NULL, 5, '&#128512;122\n```\ncode block\n```\n[hh](www.baidu.com)\n1. ...', '1', 'root', NULL, 'root', 0, 0, '2023-07-16 12:06:18', '2023-07-16 12:06:18');
INSERT INTO `comment` VALUES (8, NULL, 5, '&#128512;12345\n```\ncode block\n```\n[hh](www.baidu.com)\n1. ...', '1', 'root', NULL, 'root', 0, 0, '2023-07-16 12:40:51', '2023-07-16 12:40:51');
INSERT INTO `comment` VALUES (9, NULL, 5, '&#128512;122\n```\ncode block\n```\n[hh](www.baidu.com)\n1. ...', '1', 'root', NULL, 'root', 0, 0, '2023-07-17 08:32:37', '2023-07-17 08:32:37');
INSERT INTO `comment` VALUES (10, NULL, 5, '&#128512;122\n```\ncode block\n```\n[hh](www.baidu.com)\n1. ...', '1', 'root', NULL, 'root', 0, 0, '2023-07-17 08:33:12', '2023-07-17 08:33:12');
INSERT INTO `comment` VALUES (11, NULL, 1, '我好无聊啊啊啊啊啊啊', '1', 'root', NULL, 'root', 1, 0, '2023-09-05 21:40:42', '2023-09-05 21:40:45');
INSERT INTO `comment` VALUES (12, NULL, 1, '大佬牛逼！！！！', '1', 'root', NULL, 'root', 0, 0, '2023-09-11 22:50:26', '2023-09-11 22:50:26');
INSERT INTO `comment` VALUES (13, NULL, 8, 'test1&#129395;', '1', 'root', NULL, 'root', 1, 0, '2023-09-12 22:28:57', '2023-09-12 22:29:00');
INSERT INTO `comment` VALUES (14, NULL, 8, '\n```Java\n    @Async\n    @Override\n    public void syncContestRecord(Long pid, Long cid, String displayId) {\n        UpdateWrapper<ContestRecord> updateWrapper = new UpdateWrapper<>();\n        updateWrapper.eq(\"pid\", pid)\n                .eq(\"cid\", cid)\n                .set(\"display_id\", displayId);\n        contestRecordEntityService.update(updateWrapper);\n    }\n```\n', '1', 'root', NULL, 'root', 0, 0, '2023-09-12 22:30:30', '2023-09-12 22:30:30');
INSERT INTO `comment` VALUES (15, NULL, 1, 'hah', '1', 'root', NULL, 'root', 0, 0, '2023-09-14 21:49:55', '2023-09-14 21:49:55');

-- ----------------------------
-- Table structure for comment_like
-- ----------------------------
DROP TABLE IF EXISTS `comment_like`;
CREATE TABLE `comment_like`  (
                                 `id` int NOT NULL AUTO_INCREMENT,
                                 `uid` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
                                 `cid` int NOT NULL,
                                 `gmt_create` datetime NULL DEFAULT CURRENT_TIMESTAMP,
                                 `gmt_modified` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                 PRIMARY KEY (`id`) USING BTREE,
                                 INDEX `uid`(`uid` ASC) USING BTREE,
                                 INDEX `cid`(`cid` ASC) USING BTREE,
                                 CONSTRAINT `comment_like_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `user_info` (`uuid`) ON DELETE CASCADE ON UPDATE CASCADE,
                                 CONSTRAINT `comment_like_ibfk_2` FOREIGN KEY (`cid`) REFERENCES `comment` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comment_like
-- ----------------------------
INSERT INTO `comment_like` VALUES (3, '1', 11, '2023-09-05 21:40:45', '2023-09-05 21:40:45');
INSERT INTO `comment_like` VALUES (4, '1', 13, '2023-09-12 22:29:00', '2023-09-12 22:29:00');

-- ----------------------------
-- Table structure for contest
-- ----------------------------
DROP TABLE IF EXISTS `contest`;
CREATE TABLE `contest`  (
                            `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
                            `uid` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '比赛创建者id',
                            `author` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '比赛创建者的用户名',
                            `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                            `type` int NOT NULL DEFAULT 0 COMMENT '0为acm赛制，1为比分赛制',
                            `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
                            `source` int NULL DEFAULT 0 COMMENT '比赛来源，原创为0，克隆赛为比赛id',
                            `auth` int NOT NULL COMMENT '0为公开赛，1为私有赛（访问有密码），2为保护赛（提交有密码）',
                            `pwd` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '比赛密码',
                            `start_time` datetime NULL DEFAULT NULL COMMENT '开始时间',
                            `end_time` datetime NULL DEFAULT NULL COMMENT '结束时间',
                            `duration` bigint NULL DEFAULT NULL COMMENT '比赛时长(s)',
                            `seal_rank` tinyint(1) NULL DEFAULT 0 COMMENT '是否开启封榜',
                            `seal_rank_time` datetime NULL DEFAULT NULL COMMENT '封榜起始时间，一直到比赛结束，不刷新榜单',
                            `auto_real_rank` tinyint(1) NULL DEFAULT 1 COMMENT '比赛结束是否自动解除封榜,自动转换成真实榜单',
                            `status` int NULL DEFAULT NULL COMMENT '-1为未开始，0为进行中，1为已结束',
                            `visible` tinyint(1) NULL DEFAULT 1 COMMENT '是否可见',
                            `open_print` tinyint(1) NULL DEFAULT 0 COMMENT '是否打开打印功能',
                            `open_account_limit` tinyint(1) NULL DEFAULT 0 COMMENT '是否开启账号限制',
                            `account_limit_rule` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '账号限制规则',
                            `rank_show_name` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'username' COMMENT '排行榜显示（username、nickname、realname）',
                            `open_rank` tinyint(1) NULL DEFAULT 0 COMMENT '是否开放比赛榜单',
                            `star_account` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '打星用户列表',
                            `oi_rank_score_type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'Recent' COMMENT 'oi排行榜得分方式，Recent、Highest',
                            `is_group` tinyint(1) NULL DEFAULT 0,
                            `gid` bigint UNSIGNED NULL DEFAULT NULL,
                            `award_type` int NULL DEFAULT 0 COMMENT '奖项类型：0(不设置),1(设置占比),2(设置人数)',
                            `award_config` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '奖项配置 json',
                            `gmt_create` datetime NULL DEFAULT CURRENT_TIMESTAMP,
                            `gmt_modified` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                            PRIMARY KEY (`id`, `uid`) USING BTREE,
                            INDEX `uid`(`uid` ASC) USING BTREE,
                            INDEX `contest_ibfk_2`(`gid` ASC) USING BTREE,
                            CONSTRAINT `contest_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `user_info` (`uuid`) ON DELETE CASCADE ON UPDATE CASCADE,
                            CONSTRAINT `contest_ibfk_2` FOREIGN KEY (`gid`) REFERENCES `group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1001 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of contest
-- ----------------------------
INSERT INTO `contest` VALUES (1000, '1', 'root', 'this is contest', 0, 'this is contest', 0, 0, '', '2023-05-17 22:48:29', '2023-05-26 00:00:00', 695491, 1, '2023-05-25 23:00:00', 1, 1, 1, 0, 0, '', 'nickname', 0, '{\"star_account\":[]}', 'Recent', 0, NULL, 0, NULL, '2023-05-17 22:49:10', '2023-06-30 00:02:02');

-- ----------------------------
-- Table structure for contest_announcement
-- ----------------------------
DROP TABLE IF EXISTS `contest_announcement`;
CREATE TABLE `contest_announcement`  (
                                         `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
                                         `aid` bigint UNSIGNED NOT NULL COMMENT '公告id',
                                         `cid` bigint UNSIGNED NOT NULL COMMENT '比赛id',
                                         `gmt_create` datetime NULL DEFAULT CURRENT_TIMESTAMP,
                                         `gmt_modified` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                         PRIMARY KEY (`id`) USING BTREE,
                                         INDEX `contest_announcement_ibfk_1`(`cid` ASC) USING BTREE,
                                         INDEX `contest_announcement_ibfk_2`(`aid` ASC) USING BTREE,
                                         CONSTRAINT `contest_announcement_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `contest` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                                         CONSTRAINT `contest_announcement_ibfk_2` FOREIGN KEY (`aid`) REFERENCES `announcement` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of contest_announcement
-- ----------------------------
INSERT INTO `contest_announcement` VALUES (1, 1, 1000, '2023-05-17 23:34:40', '2023-05-17 23:34:40');

-- ----------------------------
-- Table structure for contest_explanation
-- ----------------------------
DROP TABLE IF EXISTS `contest_explanation`;
CREATE TABLE `contest_explanation`  (
                                        `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
                                        `cid` bigint UNSIGNED NOT NULL,
                                        `uid` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '发布者（必须为比赛创建者或者超级管理员才能）',
                                        `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
                                        `gmt_create` datetime NULL DEFAULT CURRENT_TIMESTAMP,
                                        `gmt_modified` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                        PRIMARY KEY (`id`) USING BTREE,
                                        INDEX `uid`(`uid` ASC) USING BTREE,
                                        INDEX `contest_explanation_ibfk_1`(`cid` ASC) USING BTREE,
                                        CONSTRAINT `contest_explanation_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `contest` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                                        CONSTRAINT `contest_explanation_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `user_info` (`uuid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of contest_explanation
-- ----------------------------

-- ----------------------------
-- Table structure for contest_print
-- ----------------------------
DROP TABLE IF EXISTS `contest_print`;
CREATE TABLE `contest_print`  (
                                  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
                                  `username` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
                                  `realname` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
                                  `cid` bigint UNSIGNED NULL DEFAULT NULL,
                                  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
                                  `status` int NULL DEFAULT 0,
                                  `gmt_create` datetime NULL DEFAULT CURRENT_TIMESTAMP,
                                  `gmt_modified` datetime NULL DEFAULT CURRENT_TIMESTAMP,
                                  PRIMARY KEY (`id`) USING BTREE,
                                  INDEX `cid`(`cid` ASC) USING BTREE,
                                  INDEX `username`(`username` ASC) USING BTREE,
                                  CONSTRAINT `contest_print_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `contest` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                                  CONSTRAINT `contest_print_ibfk_2` FOREIGN KEY (`username`) REFERENCES `user_info` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of contest_print
-- ----------------------------

-- ----------------------------
-- Table structure for contest_problem
-- ----------------------------
DROP TABLE IF EXISTS `contest_problem`;
CREATE TABLE `contest_problem`  (
                                    `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
                                    `display_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '该题目在比赛中的顺序id',
                                    `cid` bigint UNSIGNED NOT NULL COMMENT '比赛id',
                                    `pid` bigint UNSIGNED NOT NULL COMMENT '题目id',
                                    `display_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                    `color` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '气球颜色',
                                    `gmt_create` datetime NULL DEFAULT CURRENT_TIMESTAMP,
                                    `gmt_modified` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                    PRIMARY KEY (`id`, `cid`, `pid`) USING BTREE,
                                    UNIQUE INDEX `display_id`(`display_id` ASC, `cid` ASC, `pid` ASC) USING BTREE,
                                    INDEX `contest_problem_ibfk_1`(`cid` ASC) USING BTREE,
                                    INDEX `contest_problem_ibfk_2`(`pid` ASC) USING BTREE,
                                    CONSTRAINT `contest_problem_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `contest` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                                    CONSTRAINT `contest_problem_ibfk_2` FOREIGN KEY (`pid`) REFERENCES `problem` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of contest_problem
-- ----------------------------

-- ----------------------------
-- Table structure for contest_record
-- ----------------------------
DROP TABLE IF EXISTS `contest_record`;
CREATE TABLE `contest_record`  (
                                   `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
                                   `cid` bigint UNSIGNED NULL DEFAULT NULL COMMENT '比赛id',
                                   `uid` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '用户id',
                                   `pid` bigint UNSIGNED NULL DEFAULT NULL COMMENT '题目id',
                                   `cpid` bigint UNSIGNED NULL DEFAULT NULL COMMENT '比赛中的题目的id',
                                   `username` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '用户名',
                                   `realname` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '真实姓名',
                                   `display_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '比赛中展示的id',
                                   `submit_id` bigint UNSIGNED NOT NULL COMMENT '提交id，用于可重判',
                                   `status` int NULL DEFAULT NULL COMMENT '提交结果，0表示未AC通过不罚时，1表示AC通过，-1为未AC通过算罚时',
                                   `submit_time` datetime NOT NULL COMMENT '具体提交时间',
                                   `time` bigint UNSIGNED NULL DEFAULT NULL COMMENT '提交时间，为提交时间减去比赛时间',
                                   `score` int NULL DEFAULT NULL COMMENT 'OI比赛的得分',
                                   `use_time` int NULL DEFAULT NULL COMMENT '运行耗时',
                                   `first_blood` tinyint(1) NULL DEFAULT 0 COMMENT '是否为一血AC(废弃)',
                                   `checked` tinyint(1) NULL DEFAULT 0 COMMENT 'AC是否已校验',
                                   `gmt_create` datetime NULL DEFAULT CURRENT_TIMESTAMP,
                                   `gmt_modified` datetime NULL DEFAULT CURRENT_TIMESTAMP,
                                   PRIMARY KEY (`id`, `submit_id`) USING BTREE,
                                   INDEX `uid`(`uid` ASC) USING BTREE,
                                   INDEX `pid`(`pid` ASC) USING BTREE,
                                   INDEX `cpid`(`cpid` ASC) USING BTREE,
                                   INDEX `submit_id`(`submit_id` ASC) USING BTREE,
                                   INDEX `index_cid`(`cid` ASC) USING BTREE,
                                   INDEX `index_time`(`time` ASC) USING BTREE,
                                   CONSTRAINT `contest_record_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `contest` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                                   CONSTRAINT `contest_record_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `user_info` (`uuid`) ON DELETE CASCADE ON UPDATE CASCADE,
                                   CONSTRAINT `contest_record_ibfk_3` FOREIGN KEY (`pid`) REFERENCES `problem` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                                   CONSTRAINT `contest_record_ibfk_4` FOREIGN KEY (`cpid`) REFERENCES `contest_problem` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                                   CONSTRAINT `contest_record_ibfk_5` FOREIGN KEY (`submit_id`) REFERENCES `judge` (`submit_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of contest_record
-- ----------------------------

-- ----------------------------
-- Table structure for contest_register
-- ----------------------------
DROP TABLE IF EXISTS `contest_register`;
CREATE TABLE `contest_register`  (
                                     `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
                                     `cid` bigint UNSIGNED NOT NULL COMMENT '比赛id',
                                     `uid` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '用户id',
                                     `status` int NULL DEFAULT 0 COMMENT '默认为0表示正常，1为失效。',
                                     `gmt_create` datetime NULL DEFAULT CURRENT_TIMESTAMP,
                                     `gmt_modified` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                     PRIMARY KEY (`id`, `cid`, `uid`) USING BTREE,
                                     UNIQUE INDEX `cid_uid_unique`(`cid` ASC, `uid` ASC) USING BTREE,
                                     INDEX `contest_register_ibfk_2`(`uid` ASC) USING BTREE,
                                     CONSTRAINT `contest_register_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `contest` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                                     CONSTRAINT `contest_register_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `user_info` (`uuid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of contest_register
-- ----------------------------

-- ----------------------------
-- Table structure for contest_score
-- ----------------------------
DROP TABLE IF EXISTS `contest_score`;
CREATE TABLE `contest_score`  (
                                  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
                                  `cid` bigint UNSIGNED NOT NULL,
                                  `last` int NULL DEFAULT NULL COMMENT '比赛前的score得分',
                                  `change` int NULL DEFAULT NULL COMMENT 'Score比分变化',
                                  `now` int NULL DEFAULT NULL COMMENT '现在的score',
                                  `gmt_create` datetime NULL DEFAULT CURRENT_TIMESTAMP,
                                  `gmt_modified` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                  PRIMARY KEY (`id`, `cid`) USING BTREE,
                                  INDEX `contest_score_ibfk_1`(`cid` ASC) USING BTREE,
                                  CONSTRAINT `contest_score_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `contest` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of contest_score
-- ----------------------------

-- ----------------------------
-- Table structure for discussion
-- ----------------------------
DROP TABLE IF EXISTS `discussion`;
CREATE TABLE `discussion`  (
                               `id` int NOT NULL AUTO_INCREMENT,
                               `category_id` int NOT NULL COMMENT '分类id',
                               `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                               `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                               `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
                               `pid` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '关联题目id',
                               `uid` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '发表者id',
                               `author` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '发表者用户名',
                               `avatar` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '发表讨论者头像',
                               `role` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'user' COMMENT '发表者角色',
                               `view_num` int NULL DEFAULT 0 COMMENT '浏览数量',
                               `like_num` int NULL DEFAULT 0 COMMENT '点赞数量',
                               `top_priority` tinyint(1) NULL DEFAULT 0 COMMENT '优先级，是否置顶',
                               `comment_num` int NULL DEFAULT 0 COMMENT '评论数量',
                               `status` int NULL DEFAULT 0 COMMENT '是否封禁该讨论',
                               `gid` bigint UNSIGNED NULL DEFAULT NULL,
                               `gmt_create` datetime NULL DEFAULT CURRENT_TIMESTAMP,
                               `gmt_modified` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                               PRIMARY KEY (`id`) USING BTREE,
                               INDEX `category_id`(`category_id` ASC) USING BTREE,
                               INDEX `discussion_ibfk_4`(`avatar` ASC) USING BTREE,
                               INDEX `discussion_ibfk_1`(`uid` ASC) USING BTREE,
                               INDEX `pid`(`pid` ASC) USING BTREE,
                               INDEX `discussion_ibfk_3`(`gid` ASC) USING BTREE,
                               CONSTRAINT `discussion_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `user_info` (`uuid`) ON DELETE RESTRICT ON UPDATE CASCADE,
                               CONSTRAINT `discussion_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
                               CONSTRAINT `discussion_ibfk_3` FOREIGN KEY (`gid`) REFERENCES `group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                               CONSTRAINT `discussion_ibfk_4` FOREIGN KEY (`avatar`) REFERENCES `user_info` (`avatar`) ON DELETE RESTRICT ON UPDATE CASCADE,
                               CONSTRAINT `discussion_ibfk_6` FOREIGN KEY (`pid`) REFERENCES `problem` (`problem_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of discussion
-- ----------------------------
INSERT INTO `discussion` VALUES (1, 1, 'qwq', '这是一个讨论!!!', 'qwq', NULL, '1', 'root', NULL, 'root', 30, -2, 1, 5, 0, NULL, '2023-07-01 11:17:21', '2023-09-14 21:49:55');
INSERT INTO `discussion` VALUES (3, 1, '哈哈哈', 'test 哈哈哈', '## 二级标题\n\n我是shabby', NULL, '1', 'root', NULL, 'root', 0, 0, 0, 0, 0, NULL, '2023-07-03 22:34:47', '2023-07-03 22:34:47');
INSERT INTO `discussion` VALUES (4, 1, '哈哈哈', 'test 哈哈哈', '## 二级标题\n\n我是shabby', NULL, '1', 'root', NULL, 'root', 1, 0, 0, 0, 0, NULL, '2023-07-03 22:38:54', '2023-09-05 21:41:13');
INSERT INTO `discussion` VALUES (5, 1, 'HAHAHHA', 'test 哈哈哈', '## 二级标题\n\n我是shabby!!!', NULL, '1', 'root', NULL, 'root', 7, 0, 0, 11, 0, NULL, '2023-07-03 23:08:18', '2023-07-19 23:36:30');
INSERT INTO `discussion` VALUES (6, 1, '哈哈哈', 'test 哈哈哈', '## 二级标题\n\n我是shabby', NULL, '1', 'root', NULL, 'root', 2, 0, 0, 0, 0, NULL, '2023-07-27 22:39:10', '2023-09-11 22:46:39');
INSERT INTO `discussion` VALUES (7, 1, '哈哈哈', 'test 哈哈哈', '## 二级标题\n\n我是shabby', NULL, '1', 'root', NULL, 'root', 0, 0, 0, 0, 0, NULL, '2023-07-27 22:39:27', '2023-07-27 22:39:27');
INSERT INTO `discussion` VALUES (8, 1, '我要发布一个讨论呀啊哈哈哈', '我要发布一个讨论呀啊哈哈哈', '**我要发布一个讨论呀啊哈哈哈**', NULL, '1', 'root', NULL, 'root', 4, 0, 0, 4, 0, NULL, '2023-09-12 22:28:40', '2023-09-12 22:30:50');

-- ----------------------------
-- Table structure for discussion_like
-- ----------------------------
DROP TABLE IF EXISTS `discussion_like`;
CREATE TABLE `discussion_like`  (
                                    `id` int NOT NULL AUTO_INCREMENT,
                                    `uid` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
                                    `did` int NOT NULL,
                                    `gmt_create` datetime NULL DEFAULT CURRENT_TIMESTAMP,
                                    `gmt_modified` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                    PRIMARY KEY (`id`) USING BTREE,
                                    INDEX `did`(`did` ASC) USING BTREE,
                                    INDEX `uid`(`uid` ASC) USING BTREE,
                                    CONSTRAINT `discussion_like_ibfk_1` FOREIGN KEY (`did`) REFERENCES `discussion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                                    CONSTRAINT `discussion_like_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `user_info` (`uuid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of discussion_like
-- ----------------------------

-- ----------------------------
-- Table structure for discussion_report
-- ----------------------------
DROP TABLE IF EXISTS `discussion_report`;
CREATE TABLE `discussion_report`  (
                                      `id` int NOT NULL AUTO_INCREMENT,
                                      `did` int NULL DEFAULT NULL COMMENT '讨论id',
                                      `reporter` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '举报者的用户名',
                                      `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                      `status` tinyint(1) NULL DEFAULT 0 COMMENT '是否已读',
                                      `gmt_create` datetime NULL DEFAULT CURRENT_TIMESTAMP,
                                      `gmt_modified` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                      PRIMARY KEY (`id`) USING BTREE,
                                      INDEX `did`(`did` ASC) USING BTREE,
                                      INDEX `reporter`(`reporter` ASC) USING BTREE,
                                      CONSTRAINT `discussion_report_ibfk_1` FOREIGN KEY (`did`) REFERENCES `discussion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                                      CONSTRAINT `discussion_report_ibfk_2` FOREIGN KEY (`reporter`) REFERENCES `user_info` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of discussion_report
-- ----------------------------
INSERT INTO `discussion_report` VALUES (1, 5, 'root', '#违法违规# 111', 0, '2023-07-08 00:29:49', '2023-07-08 00:29:49');
INSERT INTO `discussion_report` VALUES (2, 5, 'root', '#违法违规# 111', 0, '2023-07-08 00:29:51', '2023-07-08 00:29:51');
INSERT INTO `discussion_report` VALUES (3, 5, 'root', '#违法违规# 111', 0, '2023-07-08 00:32:52', '2023-07-08 00:32:52');
INSERT INTO `discussion_report` VALUES (4, 5, 'root', '#违法违规# 111', 0, '2023-07-08 00:32:53', '2023-07-08 00:32:53');
INSERT INTO `discussion_report` VALUES (5, 5, 'root', '#违法违规# 111', 0, '2023-07-08 00:57:06', '2023-07-08 00:57:06');
INSERT INTO `discussion_report` VALUES (6, 5, 'root', '#违法违规# 111', 0, '2023-07-09 11:55:32', '2023-07-09 11:55:32');

-- ----------------------------
-- Table structure for file
-- ----------------------------
DROP TABLE IF EXISTS `file`;
CREATE TABLE `file`  (
                         `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
                         `uid` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '用户id',
                         `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '文件名',
                         `suffix` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '文件后缀格式',
                         `folder_path` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '文件所在文件夹的路径',
                         `file_path` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '文件绝对路径',
                         `type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '文件所属类型，例如avatar',
                         `delete` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除',
                         `gid` bigint UNSIGNED NULL DEFAULT NULL,
                         `gmt_create` datetime NULL DEFAULT CURRENT_TIMESTAMP,
                         `gmt_modified` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                         PRIMARY KEY (`id`) USING BTREE,
                         INDEX `uid`(`uid` ASC) USING BTREE,
                         INDEX `file_ibfk_2`(`gid` ASC) USING BTREE,
                         CONSTRAINT `file_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `user_info` (`uuid`) ON DELETE SET NULL ON UPDATE CASCADE,
                         CONSTRAINT `file_ibfk_2` FOREIGN KEY (`gid`) REFERENCES `group` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of file
-- ----------------------------

-- ----------------------------
-- Table structure for group
-- ----------------------------
DROP TABLE IF EXISTS `group`;
CREATE TABLE `group`  (
                          `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
                          `avatar` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '头像地址',
                          `name` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '团队名称',
                          `short_name` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '团队简称，创建题目时题号自动添加的前缀',
                          `brief` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '团队简介',
                          `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
                          `owner` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '团队拥有者用户名',
                          `uid` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '团队拥有者用户id',
                          `auth` int NOT NULL COMMENT '0为Public，1为Protected，2为Private',
                          `visible` tinyint(1) NULL DEFAULT 1 COMMENT '是否可见',
                          `status` tinyint(1) NULL DEFAULT 0 COMMENT '是否封禁',
                          `code` varchar(6) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '邀请码',
                          `gmt_create` datetime NULL DEFAULT CURRENT_TIMESTAMP,
                          `gmt_modified` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                          PRIMARY KEY (`id`) USING BTREE,
                          UNIQUE INDEX `NAME_UNIQUE`(`name` ASC) USING BTREE,
                          UNIQUE INDEX `short_name`(`short_name` ASC) USING BTREE,
                          INDEX `group_ibfk_1`(`uid` ASC) USING BTREE,
                          CONSTRAINT `group_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `user_info` (`uuid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of group
-- ----------------------------

-- ----------------------------
-- Table structure for group_member
-- ----------------------------
DROP TABLE IF EXISTS `group_member`;
CREATE TABLE `group_member`  (
                                 `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
                                 `gid` bigint UNSIGNED NOT NULL COMMENT '团队id',
                                 `uid` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '用户id',
                                 `auth` int NULL DEFAULT 1 COMMENT '1未审批，2拒绝，3普通成员，4团队管理员，5团队拥有者',
                                 `reason` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                 `gmt_create` datetime NULL DEFAULT CURRENT_TIMESTAMP,
                                 `gmt_modified` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                 PRIMARY KEY (`id`) USING BTREE,
                                 UNIQUE INDEX `gid_uid_unique`(`gid` ASC, `uid` ASC) USING BTREE,
                                 INDEX `gid`(`gid` ASC) USING BTREE,
                                 INDEX `uid`(`uid` ASC) USING BTREE,
                                 CONSTRAINT `group_member_ibfk_1` FOREIGN KEY (`gid`) REFERENCES `group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                                 CONSTRAINT `group_member_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `user_info` (`uuid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of group_member
-- ----------------------------

-- ----------------------------
-- Table structure for judge
-- ----------------------------
DROP TABLE IF EXISTS `judge`;
CREATE TABLE `judge`  (
                          `submit_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
                          `pid` bigint UNSIGNED NOT NULL COMMENT '题目id',
                          `display_pid` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '题目展示id',
                          `uid` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '用户id',
                          `username` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '用户名',
                          `submit_time` datetime NOT NULL COMMENT '提交的时间',
                          `status` int NULL DEFAULT NULL COMMENT '结果码具体参考文档',
                          `share` tinyint(1) NULL DEFAULT 0 COMMENT '0为仅自己可见，1为全部人可见。',
                          `error_message` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '错误提醒（编译错误，或者vj提醒）',
                          `time` int NULL DEFAULT NULL COMMENT '运行时间(ms)',
                          `memory` int NULL DEFAULT NULL COMMENT '运行内存（kb）',
                          `score` int NULL DEFAULT NULL COMMENT 'IO判题则不为空',
                          `length` int NULL DEFAULT NULL COMMENT '代码长度',
                          `code` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
                          `language` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '代码语言',
                          `gid` bigint UNSIGNED NULL DEFAULT NULL COMMENT '团队id，不为团队内提交则为null',
                          `cid` bigint UNSIGNED NOT NULL DEFAULT 0 COMMENT '比赛id，非比赛题目默认为0',
                          `cpid` bigint UNSIGNED NULL DEFAULT 0 COMMENT '比赛中题目排序id，非比赛题目默认为0',
                          `judger` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '判题机ip',
                          `ip` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '提交者所在ip',
                          `version` int NOT NULL DEFAULT 0 COMMENT '乐观锁',
                          `oi_rank_score` int NULL DEFAULT 0 COMMENT 'oi排行榜得分',
                          `vjudge_submit_id` bigint UNSIGNED NULL DEFAULT NULL COMMENT 'vjudge判题在其它oj的提交id',
                          `vjudge_username` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT 'vjudge判题在其它oj的提交用户名',
                          `vjudge_password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT 'vjudge判题在其它oj的提交账号密码',
                          `is_manual` tinyint(1) NULL DEFAULT 0 COMMENT '是否为人工评测',
                          `gmt_create` datetime NULL DEFAULT CURRENT_TIMESTAMP,
                          `gmt_modified` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                          `oi_rank` int NULL DEFAULT NULL COMMENT '该题在OI排行榜的分数',
                          PRIMARY KEY (`submit_id`, `pid`, `display_pid`, `uid`, `cid`) USING BTREE,
                          INDEX `pid`(`pid` ASC) USING BTREE,
                          INDEX `uid`(`uid` ASC) USING BTREE,
                          INDEX `username`(`username` ASC) USING BTREE,
                          INDEX `judge_ibfk_4`(`gid` ASC) USING BTREE,
                          CONSTRAINT `judge_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `problem` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                          CONSTRAINT `judge_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `user_info` (`uuid`) ON DELETE CASCADE ON UPDATE CASCADE,
                          CONSTRAINT `judge_ibfk_3` FOREIGN KEY (`username`) REFERENCES `user_info` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
                          CONSTRAINT `judge_ibfk_4` FOREIGN KEY (`gid`) REFERENCES `group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 261 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of judge
-- ----------------------------

-- ----------------------------
-- Table structure for judge_case
-- ----------------------------
DROP TABLE IF EXISTS `judge_case`;
CREATE TABLE `judge_case`  (
                               `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
                               `submit_id` bigint UNSIGNED NOT NULL COMMENT '提交判题id',
                               `uid` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '用户id',
                               `pid` bigint UNSIGNED NOT NULL COMMENT '题目id',
                               `case_id` bigint NULL DEFAULT NULL COMMENT '测试样例id',
                               `status` int NULL DEFAULT NULL COMMENT '具体看结果码',
                               `time` int NULL DEFAULT NULL COMMENT '测试该样例所用时间ms',
                               `memory` int NULL DEFAULT NULL COMMENT '测试该样例所用空间KB',
                               `score` int NULL DEFAULT NULL COMMENT 'IO得分',
                               `group_num` int NULL DEFAULT NULL COMMENT 'subtask分组的组号',
                               `seq` int NULL DEFAULT NULL COMMENT '排序',
                               `mode` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'default' COMMENT 'default,subtask_lowest,subtask_average',
                               `input_data` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '样例输入，比赛不可看',
                               `output_data` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '样例输出，比赛不可看',
                               `user_output` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '用户样例输出，比赛不可看',
                               `gmt_create` datetime NULL DEFAULT CURRENT_TIMESTAMP,
                               `gmt_modified` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                               PRIMARY KEY (`id`, `submit_id`, `uid`, `pid`) USING BTREE,
                               INDEX `case_id`(`case_id` ASC) USING BTREE,
                               INDEX `judge_case_ibfk_1`(`uid` ASC) USING BTREE,
                               INDEX `judge_case_ibfk_2`(`pid` ASC) USING BTREE,
                               INDEX `judge_case_ibfk_3`(`submit_id` ASC) USING BTREE,
                               CONSTRAINT `judge_case_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `user_info` (`uuid`) ON DELETE CASCADE ON UPDATE CASCADE,
                               CONSTRAINT `judge_case_ibfk_2` FOREIGN KEY (`pid`) REFERENCES `problem` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                               CONSTRAINT `judge_case_ibfk_3` FOREIGN KEY (`submit_id`) REFERENCES `judge` (`submit_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 3627 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of judge_case
-- ----------------------------

-- ----------------------------
-- Table structure for judge_server
-- ----------------------------
DROP TABLE IF EXISTS `judge_server`;
CREATE TABLE `judge_server`  (
                                 `id` int NOT NULL AUTO_INCREMENT,
                                 `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '判题服务名字',
                                 `ip` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '判题机ip',
                                 `port` int NOT NULL COMMENT '判题机端口号',
                                 `url` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT 'ip:port',
                                 `cpu_core` int NULL DEFAULT 0 COMMENT '判题机所在服务器cpu核心数',
                                 `task_number` int NOT NULL DEFAULT 0 COMMENT '当前判题数',
                                 `max_task_number` int NOT NULL COMMENT '判题并发最大数',
                                 `status` int NULL DEFAULT 0 COMMENT '0可用，1不可用',
                                 `is_remote` tinyint(1) NULL DEFAULT NULL COMMENT '是否开启远程判题vj',
                                 `cf_submittable` tinyint(1) NULL DEFAULT 1 COMMENT '是否可提交CF',
                                 `gmt_create` datetime NULL DEFAULT CURRENT_TIMESTAMP,
                                 `gmt_modified` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                 PRIMARY KEY (`id`) USING BTREE,
                                 INDEX `index_judge_remote`(`is_remote` ASC) USING BTREE,
                                 INDEX `index_judge_url`(`url` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 439 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of judge_server
-- ----------------------------
INSERT INTO `judge_server` VALUES (327, 'hoj-judger-1', '127.0.0.1', 7788, '127.0.0.1:7788', 32, 0, 33, 0, 0, 1, '2023-09-14 00:57:52', '2023-09-14 01:08:18');
INSERT INTO `judge_server` VALUES (328, 'hoj-judger-1', '127.0.0.1', 7788, '127.0.0.1:7788', 32, 0, 65, 0, 1, 1, '2023-09-14 00:57:52', '2023-09-14 00:57:52');
INSERT INTO `judge_server` VALUES (339, 'loj-judger-1', '127.0.0.1', 5588, '127.0.0.1:5588', 32, 0, 6, 0, 0, 1, '2023-09-14 21:57:05', '2023-09-14 21:57:05');
INSERT INTO `judge_server` VALUES (340, 'loj-judger-1', '127.0.0.1', 5588, '127.0.0.1:5588', 32, 0, 65, 0, 1, 1, '2023-09-14 21:57:05', '2023-09-14 21:57:05');
INSERT INTO `judge_server` VALUES (357, 'judger-2', '172.20.0.7', 7788, '172.20.0.7:7788', 32, 0, 33, 0, 0, 1, '2023-09-15 02:36:56', '2023-09-15 02:38:12');
INSERT INTO `judge_server` VALUES (358, 'judger-2', '172.20.0.7', 7788, '172.20.0.7:7788', 32, 0, 65, 0, 1, 1, '2023-09-15 02:36:56', '2023-09-15 02:36:56');
INSERT INTO `judge_server` VALUES (405, 'judger-2', '172.20.0.9', 7788, '172.20.0.9:7788', 32, 0, 33, 0, 0, 1, '2023-09-15 22:07:56', '2023-09-15 22:07:56');
INSERT INTO `judge_server` VALUES (406, 'judger-2', '172.20.0.9', 7788, '172.20.0.9:7788', 32, 0, 65, 0, 1, 1, '2023-09-15 22:07:56', '2023-09-15 22:07:56');
INSERT INTO `judge_server` VALUES (407, 'judger-5', '172.20.0.12', 8888, '172.20.0.12:8888', 32, 0, 33, 0, 0, 1, '2023-09-15 22:07:57', '2023-09-15 22:07:57');
INSERT INTO `judge_server` VALUES (408, 'judger-5', '172.20.0.12', 8888, '172.20.0.12:8888', 32, 0, 65, 0, 1, 1, '2023-09-15 22:07:57', '2023-09-15 22:07:57');
INSERT INTO `judge_server` VALUES (409, 'judger-3', '172.20.0.10', 8888, '172.20.0.10:8888', 32, 0, 33, 0, 0, 1, '2023-09-15 22:07:57', '2023-09-15 22:07:57');
INSERT INTO `judge_server` VALUES (410, 'judger-6', '172.20.0.13', 6688, '172.20.0.13:6688', 32, 0, 33, 0, 0, 1, '2023-09-15 22:07:57', '2023-09-15 22:07:57');
INSERT INTO `judge_server` VALUES (411, 'judger-3', '172.20.0.10', 8888, '172.20.0.10:8888', 32, 0, 65, 0, 1, 1, '2023-09-15 22:07:57', '2023-09-15 22:07:57');
INSERT INTO `judge_server` VALUES (412, 'judger-6', '172.20.0.13', 6688, '172.20.0.13:6688', 32, 0, 65, 0, 1, 1, '2023-09-15 22:07:57', '2023-09-15 22:07:57');
INSERT INTO `judge_server` VALUES (413, 'judger-4', '172.20.0.11', 9988, '172.20.0.11:9988', 32, 0, 33, 0, 0, 1, '2023-09-15 22:07:57', '2023-09-15 22:07:57');
INSERT INTO `judge_server` VALUES (414, 'judger-4', '172.20.0.11', 9988, '172.20.0.11:9988', 32, 0, 65, 0, 1, 1, '2023-09-15 22:07:57', '2023-09-15 22:07:57');
INSERT INTO `judge_server` VALUES (437, 'judger-alone', '172.20.0.7', 5588, '172.20.0.7:5588', 32, 0, 33, 0, 0, 1, '2023-09-16 00:57:36', '2023-09-16 00:57:36');
INSERT INTO `judge_server` VALUES (438, 'judger-alone', '172.20.0.7', 5588, '172.20.0.7:5588', 32, 0, 65, 0, 1, 1, '2023-09-16 00:57:36', '2023-09-16 00:57:36');

-- ----------------------------
-- Table structure for language
-- ----------------------------
DROP TABLE IF EXISTS `language`;
CREATE TABLE `language`  (
                             `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
                             `content_type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '语言类型',
                             `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                             `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '语言名字',
                             `compile_command` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '编译指令',
                             `template` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '模板',
                             `code_template` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '语言默认代码模板',
                             `is_spj` tinyint(1) NULL DEFAULT 0 COMMENT '是否可作为特殊判题的一种语言',
                             `oj` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '该语言属于哪个oj，自身oj用ME',
                             `seq` int NULL DEFAULT 0 COMMENT '语言排序',
                             `gmt_create` datetime NULL DEFAULT CURRENT_TIMESTAMP,
                             `gmt_modified` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                             PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 212 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

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
                                              `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
                                              `tid` bigint UNSIGNED NOT NULL,
                                              `cid` bigint UNSIGNED NOT NULL,
                                              `gmt_create` datetime NULL DEFAULT CURRENT_TIMESTAMP,
                                              `gmt_modified` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                              PRIMARY KEY (`id`) USING BTREE,
                                              INDEX `tid`(`tid` ASC) USING BTREE,
                                              INDEX `cid`(`cid` ASC) USING BTREE,
                                              CONSTRAINT `mapping_training_category_ibfk_1` FOREIGN KEY (`tid`) REFERENCES `training` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                                              CONSTRAINT `mapping_training_category_ibfk_2` FOREIGN KEY (`cid`) REFERENCES `training_category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mapping_training_category
-- ----------------------------
INSERT INTO `mapping_training_category` VALUES (1, 1, 1, '2023-05-16 21:40:56', '2023-05-16 21:40:56');

-- ----------------------------
-- Table structure for msg_remind
-- ----------------------------
DROP TABLE IF EXISTS `msg_remind`;
CREATE TABLE `msg_remind`  (
                               `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
                               `action` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '动作类型，如点赞讨论帖Like_Post、点赞评论Like_Discuss、评论Discuss、回复Reply等',
                               `source_id` int UNSIGNED NULL DEFAULT NULL COMMENT '消息来源id，讨论id或比赛id',
                               `source_type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '事件源类型：\'Discussion\'、\'Contest\'等',
                               `source_content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                               `quote_id` int UNSIGNED NULL DEFAULT NULL COMMENT '事件引用上一级评论或回复id',
                               `quote_type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '事件引用上一级的类型：Comment、Reply',
                               `url` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '事件所发生的地点链接 url',
                               `state` tinyint(1) NULL DEFAULT 0 COMMENT '是否已读',
                               `sender_id` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '操作者的id',
                               `recipient_id` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '接受消息的用户id',
                               `gmt_create` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                               `gmt_modified` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
                               PRIMARY KEY (`id`) USING BTREE,
                               INDEX `sender_id`(`sender_id` ASC) USING BTREE,
                               INDEX `recipient_id`(`recipient_id` ASC) USING BTREE,
                               CONSTRAINT `msg_remind_ibfk_1` FOREIGN KEY (`sender_id`) REFERENCES `user_info` (`uuid`) ON DELETE CASCADE ON UPDATE CASCADE,
                               CONSTRAINT `msg_remind_ibfk_2` FOREIGN KEY (`recipient_id`) REFERENCES `user_info` (`uuid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of msg_remind
-- ----------------------------
INSERT INTO `msg_remind` VALUES (1, 'Discuss', 1, 'Discussion', '牛逼！&#128512;', NULL, NULL, '/discussion-detail/1', 1, '1', '1', '2023-07-03 22:30:41', '2023-09-06 18:57:37');
INSERT INTO `msg_remind` VALUES (2, 'Discuss', 1, 'Discussion', '哈哈', NULL, NULL, '/discussion-detail/1', 1, '1', '1', '2023-07-03 22:31:37', '2023-09-06 18:57:37');
INSERT INTO `msg_remind` VALUES (3, 'Like_Post', 1, 'Discussion', NULL, NULL, NULL, '/discussion-detail/1', 1, '1', '1', '2023-07-08 00:22:29', '2023-09-06 18:57:09');
INSERT INTO `msg_remind` VALUES (4, 'Discuss', 5, 'Discussion', '111', NULL, NULL, '/discussion-detail/5', 1, '1', '1', '2023-07-16 11:13:11', '2023-09-06 18:57:37');
INSERT INTO `msg_remind` VALUES (5, 'Discuss', 5, 'Discussion', '222', NULL, NULL, '/discussion-detail/5', 1, '1', '1', '2023-07-16 11:13:54', '2023-09-06 18:57:37');
INSERT INTO `msg_remind` VALUES (6, 'Discuss', 5, 'Discussion', '&#128512;111\n```\ncode block\n```\n[hh](www.baidu.com)\n1. ...', NULL, NULL, '/discussion-detail/5', 1, '1', '1', '2023-07-16 11:16:24', '2023-09-06 18:57:37');
INSERT INTO `msg_remind` VALUES (7, 'Discuss', 5, 'Discussion', '&#128512;122\n```\ncode block\n```\n[hh](www.baidu.com)\n1. ...', NULL, NULL, '/discussion-detail/5', 1, '1', '1', '2023-07-16 11:17:55', '2023-09-06 18:57:11');
INSERT INTO `msg_remind` VALUES (8, 'Discuss', 5, 'Discussion', '&#128512;122\n```\ncode block\n```\n[hh](www.baidu.com)\n1. ...', NULL, NULL, '/discussion-detail/5', 1, '1', '1', '2023-07-16 12:06:18', '2023-09-06 18:57:11');
INSERT INTO `msg_remind` VALUES (9, 'Discuss', 5, 'Discussion', NULL, NULL, NULL, '/discussion-detail/5', 1, '1', '1', '2023-07-16 12:40:51', '2023-09-06 18:57:11');
INSERT INTO `msg_remind` VALUES (10, 'Discuss', 5, 'Discussion', '&#128512;122\n```\ncode block\n```\n[hh](www.baidu.com)\n1. ...', NULL, NULL, '/discussion-detail/5', 1, '1', '1', '2023-07-17 08:32:37', '2023-09-06 18:57:11');
INSERT INTO `msg_remind` VALUES (11, 'Discuss', 5, 'Discussion', '&#128512;122\n```\ncode block\n```\n[hh](www.baidu.com)\n1. ...', NULL, NULL, '/discussion-detail/5', 1, '1', '1', '2023-07-17 08:33:12', '2023-09-06 18:57:11');
INSERT INTO `msg_remind` VALUES (12, 'Reply', 5, 'Discussion', 'yes吖啊啊啊', 10, 'Comment', '/discussion-detail/5', 1, '1', '1', '2023-07-19 22:56:20', '2023-09-06 18:57:10');
INSERT INTO `msg_remind` VALUES (13, 'Reply', 5, 'Discussion', '哈哈', 1, 'Reply', '/discussion-detail/5', 1, '1', '1', '2023-07-19 23:33:27', '2023-09-06 18:57:10');
INSERT INTO `msg_remind` VALUES (14, 'Reply', 5, 'Discussion', '哈哈', 1, 'Reply', '/discussion-detail/5', 1, '1', '1', '2023-07-19 23:36:30', '2023-09-06 18:57:10');
INSERT INTO `msg_remind` VALUES (15, 'Discuss', 1, 'Discussion', NULL, NULL, NULL, '/discussion-detail/1', 1, '1', '1', '2023-09-05 21:40:42', '2023-09-06 18:57:11');
INSERT INTO `msg_remind` VALUES (16, 'Discuss', 1, 'Discussion', NULL, NULL, NULL, '/discussion-detail/1', 1, '1', '1', '2023-09-11 22:50:26', '2023-09-11 22:50:59');
INSERT INTO `msg_remind` VALUES (17, 'Discuss', 8, 'Discussion', NULL, NULL, NULL, '/discussion-detail/8', 1, '1', '1', '2023-09-12 22:28:57', '2023-09-12 22:42:44');
INSERT INTO `msg_remind` VALUES (18, 'Reply', 8, 'Discussion', 'test2', 13, 'Comment', '/discussion-detail/8', 1, '1', '1', '2023-09-12 22:29:13', '2023-09-12 22:42:47');
INSERT INTO `msg_remind` VALUES (19, 'Reply', 8, 'Discussion', 'test3', 4, 'Reply', '/discussion-detail/8', 1, '1', '1', '2023-09-12 22:29:19', '2023-09-12 22:42:47');
INSERT INTO `msg_remind` VALUES (20, 'Reply', 8, 'Discussion', '\n```\n    @Override\n    public List<ContestProblemVO> getContestProblemList(Long cid, Date startTime, Date endTime, Date sealTime, Boolean isAdmin, String contestAuthorUid, List<String> groupRootUidLis...', 4, 'Reply', '/discussion-detail/8', 1, '1', '1', '2023-09-12 22:29:50', '2023-09-12 22:42:47');
INSERT INTO `msg_remind` VALUES (21, 'Discuss', 8, 'Discussion', NULL, NULL, NULL, '/discussion-detail/8', 1, '1', '1', '2023-09-12 22:30:30', '2023-09-12 22:42:44');
INSERT INTO `msg_remind` VALUES (22, 'Discuss', 1, 'Discussion', NULL, NULL, NULL, '/discussion-detail/1', 1, '1', '1', '2023-09-14 21:49:55', '2023-09-15 23:28:43');

-- ----------------------------
-- Table structure for problem
-- ----------------------------
DROP TABLE IF EXISTS `problem`;
CREATE TABLE `problem`  (
                            `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
                            `problem_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '问题的自定义ID 例如（HOJ-1000）',
                            `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                            `author` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '未知' COMMENT '作者',
                            `type` int NOT NULL DEFAULT 0 COMMENT '0为ACM,1为OI',
                            `time_limit` int NULL DEFAULT 1000 COMMENT '单位ms',
                            `memory_limit` int NULL DEFAULT 65535 COMMENT '单位kb',
                            `stack_limit` int NULL DEFAULT 128 COMMENT '单位mb',
                            `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
                            `input` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
                            `output` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
                            `examples` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '题面样例',
                            `is_remote` tinyint(1) NULL DEFAULT 0 COMMENT '是否为vj判题',
                            `source` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
                            `difficulty` int NULL DEFAULT 0 COMMENT '题目难度,0简单，1中等，2困难',
                            `hint` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
                            `auth` int NULL DEFAULT 1 COMMENT '默认为1公开，2为私有，3为比赛题目',
                            `io_score` int NULL DEFAULT 100 COMMENT '当该题目为io题目时的分数',
                            `code_share` tinyint(1) NULL DEFAULT 1 COMMENT '该题目对应的相关提交代码，用户是否可用分享',
                            `judge_mode` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'default' COMMENT '题目评测模式,default、spj、interactive',
                            `judge_case_mode` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'default' COMMENT '题目样例评测模式,default,subtask_lowest,subtask_average',
                            `user_extra_file` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '题目评测时用户程序的额外文件 json key:name value:content',
                            `judge_extra_file` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '题目评测时交互或特殊程序的额外文件 json key:name value:content',
                            `spj_code` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
                            `spj_language` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '特判程序或交互程序代码的语言',
                            `is_remove_end_blank` tinyint(1) NULL DEFAULT 1 COMMENT '是否默认去除用户代码的文末空格',
                            `open_case_result` tinyint(1) NULL DEFAULT 1 COMMENT '是否默认开启该题目的测试样例结果查看',
                            `is_upload_case` tinyint(1) NULL DEFAULT 1 COMMENT '题目测试数据是否是上传文件的',
                            `case_version` varchar(40) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '题目测试数据的版本号',
                            `modified_user` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '修改题目的管理员用户名',
                            `is_group` tinyint(1) NULL DEFAULT 0,
                            `gid` bigint UNSIGNED NULL DEFAULT NULL,
                            `apply_public_progress` int NULL DEFAULT NULL COMMENT '申请公开的进度：null为未申请，1为申请中，2为申请通过，3为申请拒绝',
                            `gmt_create` datetime NULL DEFAULT CURRENT_TIMESTAMP,
                            `gmt_modified` datetime NULL DEFAULT CURRENT_TIMESTAMP,
                            PRIMARY KEY (`id`) USING BTREE,
                            INDEX `author`(`author` ASC) USING BTREE,
                            INDEX `problem_id`(`problem_id` ASC) USING BTREE,
                            INDEX `problem_ibfk_2`(`gid` ASC) USING BTREE,
                            CONSTRAINT `problem_ibfk_1` FOREIGN KEY (`author`) REFERENCES `user_info` (`username`) ON DELETE RESTRICT ON UPDATE CASCADE,
                            CONSTRAINT `problem_ibfk_2` FOREIGN KEY (`gid`) REFERENCES `group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1037 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of problem
-- ----------------------------

-- ----------------------------
-- Table structure for problem_case
-- ----------------------------
DROP TABLE IF EXISTS `problem_case`;
CREATE TABLE `problem_case`  (
                                 `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id',
                                 `pid` bigint UNSIGNED NOT NULL COMMENT '题目id',
                                 `input` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '测试样例的输入',
                                 `output` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '测试样例的输出',
                                 `score` int NULL DEFAULT NULL COMMENT '该测试样例的IO得分',
                                 `status` int NULL DEFAULT 0 COMMENT '0可用，1不可用',
                                 `group_num` int NULL DEFAULT 1 COMMENT 'subtask分组的编号',
                                 `gmt_create` datetime NULL DEFAULT CURRENT_TIMESTAMP,
                                 `gmt_modified` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                 PRIMARY KEY (`id`) USING BTREE,
                                 INDEX `pid`(`pid` ASC) USING BTREE,
                                 CONSTRAINT `problem_case_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `problem` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 48 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of problem_case
-- ----------------------------

-- ----------------------------
-- Table structure for problem_language
-- ----------------------------
DROP TABLE IF EXISTS `problem_language`;
CREATE TABLE `problem_language`  (
                                     `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
                                     `pid` bigint UNSIGNED NOT NULL,
                                     `lid` bigint UNSIGNED NOT NULL,
                                     `gmt_create` datetime NULL DEFAULT CURRENT_TIMESTAMP,
                                     `gmt_modified` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                     PRIMARY KEY (`id`) USING BTREE,
                                     INDEX `pid`(`pid` ASC) USING BTREE,
                                     INDEX `lid`(`lid` ASC) USING BTREE,
                                     CONSTRAINT `problem_language_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `problem` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                                     CONSTRAINT `problem_language_ibfk_2` FOREIGN KEY (`lid`) REFERENCES `language` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 716 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of problem_language
-- ----------------------------

-- ----------------------------
-- Table structure for problem_tag
-- ----------------------------
DROP TABLE IF EXISTS `problem_tag`;
CREATE TABLE `problem_tag`  (
                                `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
                                `pid` bigint UNSIGNED NOT NULL,
                                `tid` bigint UNSIGNED NOT NULL,
                                `gmt_create` datetime NULL DEFAULT CURRENT_TIMESTAMP,
                                `gmt_modified` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                PRIMARY KEY (`id`) USING BTREE,
                                INDEX `pid`(`pid` ASC) USING BTREE,
                                INDEX `tid`(`tid` ASC) USING BTREE,
                                CONSTRAINT `problem_tag_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `problem` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                                CONSTRAINT `problem_tag_ibfk_2` FOREIGN KEY (`tid`) REFERENCES `tag` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of problem_tag
-- ----------------------------

-- ----------------------------
-- Table structure for remote_judge_account
-- ----------------------------
DROP TABLE IF EXISTS `remote_judge_account`;
CREATE TABLE `remote_judge_account`  (
                                         `id` int NOT NULL AUTO_INCREMENT,
                                         `oj` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '远程oj名字',
                                         `username` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '账号',
                                         `password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '密码',
                                         `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否可用',
                                         `version` bigint NULL DEFAULT 0 COMMENT '版本控制',
                                         `gmt_create` datetime NULL DEFAULT CURRENT_TIMESTAMP,
                                         `gmt_modified` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                         PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 268 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of remote_judge_account
-- ----------------------------
INSERT INTO `remote_judge_account` VALUES (264, 'HDU', 'lxhcaicai', 'dgut2834', 1, 0, '2023-09-14 22:21:01', '2023-09-14 22:21:01');
INSERT INTO `remote_judge_account` VALUES (265, 'POJ', 'lxhcaicai', 'dgut2834', 1, 0, '2023-09-14 22:21:01', '2023-09-14 22:21:01');
INSERT INTO `remote_judge_account` VALUES (266, 'CF', '2778763221@qq.com', 'dgut2834', 1, 0, '2023-09-14 22:21:01', '2023-09-14 22:21:01');
INSERT INTO `remote_judge_account` VALUES (267, 'AC', 'lxhcaicai', 'dgut2834', 1, 0, '2023-09-14 22:21:01', '2023-09-14 22:21:01');

-- ----------------------------
-- Table structure for reply
-- ----------------------------
DROP TABLE IF EXISTS `reply`;
CREATE TABLE `reply`  (
                          `id` int NOT NULL AUTO_INCREMENT,
                          `comment_id` int NOT NULL COMMENT '被回复的评论id',
                          `from_uid` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '发起回复的用户id',
                          `from_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '发起回复的用户名',
                          `from_avatar` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '发起回复的用户头像地址',
                          `from_role` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '发起回复的用户角色',
                          `to_uid` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '被回复的用户id',
                          `to_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '被回复的用户名',
                          `to_avatar` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '被回复的用户头像地址',
                          `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
                          `status` int NULL DEFAULT 0 COMMENT '是否封禁或逻辑删除该回复',
                          `gmt_create` datetime NULL DEFAULT CURRENT_TIMESTAMP,
                          `gmt_modified` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                          PRIMARY KEY (`id`) USING BTREE,
                          INDEX `comment_id`(`comment_id` ASC) USING BTREE,
                          INDEX `from_avatar`(`from_avatar` ASC) USING BTREE,
                          INDEX `to_avatar`(`to_avatar` ASC) USING BTREE,
                          CONSTRAINT `reply_ibfk_1` FOREIGN KEY (`comment_id`) REFERENCES `comment` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                          CONSTRAINT `reply_ibfk_2` FOREIGN KEY (`from_avatar`) REFERENCES `user_info` (`avatar`) ON DELETE CASCADE ON UPDATE CASCADE,
                          CONSTRAINT `reply_ibfk_3` FOREIGN KEY (`to_avatar`) REFERENCES `user_info` (`avatar`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reply
-- ----------------------------
INSERT INTO `reply` VALUES (1, 10, '1', 'root', NULL, 'root', '1', 'root', NULL, 'yes吖啊啊啊', 0, '2023-07-19 22:56:20', '2023-07-19 22:56:20');
INSERT INTO `reply` VALUES (2, 10, '1', 'root', NULL, 'root', '1', 'root', NULL, '哈哈', 0, '2023-07-19 23:33:27', '2023-07-19 23:33:27');
INSERT INTO `reply` VALUES (3, 10, '1', 'root', NULL, 'root', '1', 'root', NULL, '哈哈', 0, '2023-07-19 23:36:30', '2023-07-19 23:36:30');
INSERT INTO `reply` VALUES (4, 13, '1', 'root', NULL, 'root', '1', 'root', NULL, 'test2', 0, '2023-09-12 22:29:13', '2023-09-12 22:29:13');
INSERT INTO `reply` VALUES (5, 13, '1', 'root', NULL, 'root', '1', 'root', NULL, 'test3', 0, '2023-09-12 22:29:19', '2023-09-12 22:29:19');
INSERT INTO `reply` VALUES (6, 13, '1', 'root', NULL, 'root', '1', 'root', NULL, '\n```\n    @Override\n    public List<ContestProblemVO> getContestProblemList(Long cid, Date startTime, Date endTime, Date sealTime, Boolean isAdmin, String contestAuthorUid, List<String> groupRootUidList) {\n        // 筛去 比赛管理员和超级管理员的提交\n        List<String> superAdminUidList = userInfoEntityService.getSuperAdminUidList();\n        superAdminUidList.add(contestAuthorUid);\n\n        if(!CollectionUtils.isEmpty(groupRootUidList)) {\n            superAdminUidList.addAll(groupRootUidList);\n        }\n\n        return contestProblemMapper.getContestProblemList(cid,startTime,endTime, sealTime, isAdmin, superAdminUidList);\n    }\n```\n', 1, '2023-09-12 22:29:50', '2023-09-12 22:30:09');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
                         `id` bigint(20) UNSIGNED ZEROFILL NOT NULL,
                         `role` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '角色',
                         `description` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '描述',
                         `status` tinyint NOT NULL DEFAULT 0 COMMENT '默认0可用，1不可用',
                         `gmt_create` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                         `gmt_modified` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
                         PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

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
                              `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
                              `auth_id` bigint UNSIGNED NOT NULL,
                              `role_id` bigint UNSIGNED NOT NULL,
                              `gmt_create` datetime NULL DEFAULT CURRENT_TIMESTAMP,
                              `gmt_modified` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                              PRIMARY KEY (`id`) USING BTREE,
                              INDEX `auth_id`(`auth_id` ASC) USING BTREE,
                              INDEX `role_id`(`role_id` ASC) USING BTREE,
                              CONSTRAINT `role_auth_ibfk_1` FOREIGN KEY (`auth_id`) REFERENCES `auth` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                              CONSTRAINT `role_auth_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 62 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

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
                            `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
                            `uid` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
                            `user_agent` varchar(512) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
                            `ip` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
                            `gmt_create` datetime NULL DEFAULT CURRENT_TIMESTAMP,
                            `gmt_modified` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                            PRIMARY KEY (`id`) USING BTREE,
                            INDEX `uid`(`uid` ASC) USING BTREE,
                            CONSTRAINT `session_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `user_info` (`uuid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 138 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

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
INSERT INTO `session` VALUES (75, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36 Edg/114.0.1823.58', '127.0.0.1', '2023-06-30 01:11:26', '2023-06-30 01:11:26');
INSERT INTO `session` VALUES (76, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36', '127.0.0.1', '2023-07-01 10:56:48', '2023-07-01 10:56:48');
INSERT INTO `session` VALUES (77, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36', '127.0.0.1', '2023-07-02 18:04:19', '2023-07-02 18:04:19');
INSERT INTO `session` VALUES (78, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36', '127.0.0.1', '2023-07-03 22:30:19', '2023-07-03 22:30:19');
INSERT INTO `session` VALUES (79, '1', 'PostmanRuntime/7.32.3', '0:0:0:0:0:0:0:1', '2023-07-03 22:38:32', '2023-07-03 22:38:32');
INSERT INTO `session` VALUES (80, '1', 'PostmanRuntime/7.32.3', '0:0:0:0:0:0:0:1', '2023-07-03 23:08:14', '2023-07-03 23:08:14');
INSERT INTO `session` VALUES (81, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36 Edg/114.0.1823.67', '127.0.0.1', '2023-07-04 22:53:44', '2023-07-04 22:53:44');
INSERT INTO `session` VALUES (82, '1', 'PostmanRuntime/7.32.3', '0:0:0:0:0:0:0:1', '2023-07-04 22:55:51', '2023-07-04 22:55:51');
INSERT INTO `session` VALUES (83, '1', 'PostmanRuntime/7.32.3', '0:0:0:0:0:0:0:1', '2023-07-04 23:12:21', '2023-07-04 23:12:21');
INSERT INTO `session` VALUES (84, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36', '127.0.0.1', '2023-07-07 23:19:07', '2023-07-07 23:19:07');
INSERT INTO `session` VALUES (85, '1', 'PostmanRuntime/7.32.3', '0:0:0:0:0:0:0:1', '2023-07-07 23:23:45', '2023-07-07 23:23:45');
INSERT INTO `session` VALUES (86, '1', 'PostmanRuntime/7.32.3', '0:0:0:0:0:0:0:1', '2023-07-08 00:22:06', '2023-07-08 00:22:06');
INSERT INTO `session` VALUES (87, '1', 'PostmanRuntime/7.32.3', '0:0:0:0:0:0:0:1', '2023-07-09 11:50:32', '2023-07-09 11:50:32');
INSERT INTO `session` VALUES (88, '1', 'PostmanRuntime/7.32.3', '0:0:0:0:0:0:0:1', '2023-07-09 11:58:58', '2023-07-09 11:58:58');
INSERT INTO `session` VALUES (89, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36', '127.0.0.1', '2023-07-11 08:13:06', '2023-07-11 08:13:06');
INSERT INTO `session` VALUES (90, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36', '127.0.0.1', '2023-07-11 08:13:44', '2023-07-11 08:13:44');
INSERT INTO `session` VALUES (91, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36', '127.0.0.1', '2023-07-11 08:14:24', '2023-07-11 08:14:24');
INSERT INTO `session` VALUES (92, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36', '127.0.0.1', '2023-07-11 08:33:17', '2023-07-11 08:33:17');
INSERT INTO `session` VALUES (93, '1', 'PostmanRuntime/7.32.3', '0:0:0:0:0:0:0:1', '2023-07-11 20:35:41', '2023-07-11 20:35:41');
INSERT INTO `session` VALUES (94, '1', 'PostmanRuntime/7.32.3', '0:0:0:0:0:0:0:1', '2023-07-11 20:36:49', '2023-07-11 20:36:49');
INSERT INTO `session` VALUES (95, '1', 'PostmanRuntime/7.32.3', '0:0:0:0:0:0:0:1', '2023-07-16 09:55:39', '2023-07-16 09:55:39');
INSERT INTO `session` VALUES (96, '1', 'PostmanRuntime/7.32.3', '0:0:0:0:0:0:0:1', '2023-07-16 09:56:49', '2023-07-16 09:56:49');
INSERT INTO `session` VALUES (97, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36', '127.0.0.1', '2023-07-16 10:13:45', '2023-07-16 10:13:45');
INSERT INTO `session` VALUES (98, '1', 'PostmanRuntime/7.32.3', '0:0:0:0:0:0:0:1', '2023-07-16 10:15:29', '2023-07-16 10:15:29');
INSERT INTO `session` VALUES (99, '1', 'PostmanRuntime/7.32.3', '0:0:0:0:0:0:0:1', '2023-07-16 10:15:46', '2023-07-16 10:15:46');
INSERT INTO `session` VALUES (100, '1', 'PostmanRuntime/7.32.3', '0:0:0:0:0:0:0:1', '2023-07-16 10:17:25', '2023-07-16 10:17:25');
INSERT INTO `session` VALUES (101, '1', 'PostmanRuntime/7.32.3', '0:0:0:0:0:0:0:1', '2023-07-16 10:17:49', '2023-07-16 10:17:49');
INSERT INTO `session` VALUES (102, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36', '127.0.0.1', '2023-07-16 10:26:07', '2023-07-16 10:26:07');
INSERT INTO `session` VALUES (103, '1', 'PostmanRuntime/7.32.3', '0:0:0:0:0:0:0:1', '2023-07-16 11:17:30', '2023-07-16 11:17:30');
INSERT INTO `session` VALUES (104, '1', 'PostmanRuntime/7.32.3', '0:0:0:0:0:0:0:1', '2023-07-17 08:32:18', '2023-07-17 08:32:18');
INSERT INTO `session` VALUES (105, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36', '127.0.0.1', '2023-07-19 22:55:59', '2023-07-19 22:55:59');
INSERT INTO `session` VALUES (106, '1', 'PostmanRuntime/7.32.3', '0:0:0:0:0:0:0:1', '2023-07-19 23:33:08', '2023-07-19 23:33:08');
INSERT INTO `session` VALUES (107, '1', 'PostmanRuntime/7.32.3', '0:0:0:0:0:0:0:1', '2023-07-19 23:34:13', '2023-07-19 23:34:13');
INSERT INTO `session` VALUES (108, '1', 'PostmanRuntime/7.32.3', '0:0:0:0:0:0:0:1', '2023-07-27 22:37:10', '2023-07-27 22:37:10');
INSERT INTO `session` VALUES (109, '1', 'PostmanRuntime/7.32.3', '0:0:0:0:0:0:0:1', '2023-07-27 22:37:15', '2023-07-27 22:37:15');
INSERT INTO `session` VALUES (110, '1', 'PostmanRuntime/7.32.3', '0:0:0:0:0:0:0:1', '2023-07-27 22:37:16', '2023-07-27 22:37:16');
INSERT INTO `session` VALUES (111, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', '127.0.0.1', '2023-09-05 21:22:27', '2023-09-05 21:22:27');
INSERT INTO `session` VALUES (112, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', '127.0.0.1', '2023-09-05 21:23:40', '2023-09-05 21:23:40');
INSERT INTO `session` VALUES (113, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', '127.0.0.1', '2023-09-05 21:23:51', '2023-09-05 21:23:51');
INSERT INTO `session` VALUES (114, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', '127.0.0.1', '2023-09-05 21:25:08', '2023-09-05 21:25:08');
INSERT INTO `session` VALUES (115, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', '127.0.0.1', '2023-09-05 21:46:00', '2023-09-05 21:46:00');
INSERT INTO `session` VALUES (116, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', '127.0.0.1', '2023-09-10 17:45:06', '2023-09-10 17:45:06');
INSERT INTO `session` VALUES (117, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', '127.0.0.1', '2023-09-10 18:01:30', '2023-09-10 18:01:30');
INSERT INTO `session` VALUES (118, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', '172.17.0.1', '2023-09-10 18:22:21', '2023-09-10 18:22:21');
INSERT INTO `session` VALUES (119, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36 Edg/116.0.1938.76', '172.17.0.1', '2023-09-10 22:17:31', '2023-09-10 22:17:31');
INSERT INTO `session` VALUES (120, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', '172.17.0.1', '2023-09-10 22:19:40', '2023-09-10 22:19:40');
INSERT INTO `session` VALUES (121, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', '172.17.0.1', '2023-09-12 22:16:27', '2023-09-12 22:16:27');
INSERT INTO `session` VALUES (122, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', '172.17.0.1', '2023-09-13 22:11:20', '2023-09-13 22:11:20');
INSERT INTO `session` VALUES (123, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', '172.17.0.1', '2023-09-13 23:56:37', '2023-09-13 23:56:37');
INSERT INTO `session` VALUES (124, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', '172.17.0.1', '2023-09-14 00:01:02', '2023-09-14 00:01:02');
INSERT INTO `session` VALUES (125, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', '172.17.0.1', '2023-09-14 01:16:17', '2023-09-14 01:16:17');
INSERT INTO `session` VALUES (126, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', '172.17.0.1', '2023-09-14 21:48:24', '2023-09-14 21:48:24');
INSERT INTO `session` VALUES (127, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', '172.17.0.1', '2023-09-14 22:07:12', '2023-09-14 22:07:12');
INSERT INTO `session` VALUES (128, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', '172.17.0.1', '2023-09-14 23:05:28', '2023-09-14 23:05:28');
INSERT INTO `session` VALUES (129, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', '172.17.0.1', '2023-09-15 01:34:47', '2023-09-15 01:34:47');
INSERT INTO `session` VALUES (130, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', '172.17.0.1', '2023-09-15 02:15:24', '2023-09-15 02:15:24');
INSERT INTO `session` VALUES (131, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', '172.20.0.1', '2023-09-15 23:17:52', '2023-09-15 23:17:52');
INSERT INTO `session` VALUES (132, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', '172.20.0.1', '2023-09-15 23:28:06', '2023-09-15 23:28:06');
INSERT INTO `session` VALUES (133, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', '172.20.0.1', '2023-09-16 00:22:02', '2023-09-16 00:22:02');
INSERT INTO `session` VALUES (134, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', '172.20.0.1', '2023-09-16 00:51:45', '2023-09-16 00:51:45');
INSERT INTO `session` VALUES (135, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', '172.20.0.1', '2023-09-16 00:58:21', '2023-09-16 00:58:21');
INSERT INTO `session` VALUES (136, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', '172.20.0.1', '2023-09-16 01:01:15', '2023-09-16 01:01:15');
INSERT INTO `session` VALUES (137, 'af17f3af6ffa437b9cdb72b37511b53d', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', '172.20.0.1', '2023-09-16 01:02:02', '2023-09-16 01:02:02');

-- ----------------------------
-- Table structure for tag
-- ----------------------------
DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag`  (
                        `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
                        `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '标签名字',
                        `color` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '标签颜色',
                        `oj` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'ME' COMMENT '标签所属oj',
                        `gid` bigint UNSIGNED NULL DEFAULT NULL,
                        `tcid` bigint UNSIGNED NULL DEFAULT NULL,
                        `gmt_create` datetime NULL DEFAULT CURRENT_TIMESTAMP,
                        `gmt_modified` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                        PRIMARY KEY (`id`) USING BTREE,
                        UNIQUE INDEX `name`(`name` ASC, `oj` ASC, `gid` ASC) USING BTREE,
                        INDEX `tag_ibfk_1`(`gid` ASC) USING BTREE,
                        INDEX `tag_ibfk_2`(`tcid` ASC) USING BTREE,
                        CONSTRAINT `tag_ibfk_1` FOREIGN KEY (`gid`) REFERENCES `group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                        CONSTRAINT `tag_ibfk_2` FOREIGN KEY (`tcid`) REFERENCES `tag_classification` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

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
                                       `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
                                       `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '标签分类名称',
                                       `oj` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '标签分类所属oj',
                                       `gmt_create` datetime NULL DEFAULT NULL,
                                       `gmt_modified` datetime NULL DEFAULT NULL,
                                       `rank` int(10) UNSIGNED ZEROFILL NULL DEFAULT NULL COMMENT '标签分类优先级 越小越高',
                                       PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tag_classification
-- ----------------------------

-- ----------------------------
-- Table structure for training
-- ----------------------------
DROP TABLE IF EXISTS `training`;
CREATE TABLE `training`  (
                             `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
                             `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                             `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
                             `author` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '训练题单创建者用户名',
                             `auth` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '训练题单权限类型：Public、Private',
                             `private_pwd` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '训练题单权限为Private时的密码',
                             `rank` int NULL DEFAULT 0 COMMENT '编号，升序',
                             `status` tinyint(1) NULL DEFAULT 1 COMMENT '是否可用',
                             `is_group` tinyint(1) NULL DEFAULT 0,
                             `gid` bigint UNSIGNED NULL DEFAULT NULL,
                             `gmt_create` datetime NULL DEFAULT CURRENT_TIMESTAMP,
                             `gmt_modified` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                             PRIMARY KEY (`id`) USING BTREE,
                             INDEX `training_ibfk_1`(`gid` ASC) USING BTREE,
                             CONSTRAINT `training_ibfk_1` FOREIGN KEY (`gid`) REFERENCES `group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of training
-- ----------------------------
INSERT INTO `training` VALUES (1, '这是一个训练', '这是一个训练', 'root', 'Public', '', 1000, 1, 0, NULL, '2023-05-16 21:40:56', '2023-05-16 21:41:29');

-- ----------------------------
-- Table structure for training_category
-- ----------------------------
DROP TABLE IF EXISTS `training_category`;
CREATE TABLE `training_category`  (
                                      `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
                                      `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
                                      `color` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
                                      `gid` bigint UNSIGNED NULL DEFAULT NULL,
                                      `gmt_create` datetime NULL DEFAULT CURRENT_TIMESTAMP,
                                      `gmt_modified` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                      PRIMARY KEY (`id`) USING BTREE,
                                      INDEX `training_category_ibfk_1`(`gid` ASC) USING BTREE,
                                      CONSTRAINT `training_category_ibfk_1` FOREIGN KEY (`gid`) REFERENCES `group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of training_category
-- ----------------------------
INSERT INTO `training_category` VALUES (1, 'test', '#409eff', NULL, '2023-05-16 21:40:33', '2023-05-16 21:40:33');
INSERT INTO `training_category` VALUES (2, '新的训练', '#40FFC6', NULL, '2023-09-10 18:29:46', '2023-09-10 18:30:01');

-- ----------------------------
-- Table structure for training_problem
-- ----------------------------
DROP TABLE IF EXISTS `training_problem`;
CREATE TABLE `training_problem`  (
                                     `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
                                     `tid` bigint UNSIGNED NOT NULL COMMENT '训练id',
                                     `pid` bigint UNSIGNED NOT NULL COMMENT '题目id',
                                     `rank` int NULL DEFAULT 0,
                                     `display_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
                                     `gmt_create` datetime NULL DEFAULT CURRENT_TIMESTAMP,
                                     `gmt_modified` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                     PRIMARY KEY (`id`) USING BTREE,
                                     INDEX `tid`(`tid` ASC) USING BTREE,
                                     INDEX `pid`(`pid` ASC) USING BTREE,
                                     INDEX `display_id`(`display_id` ASC) USING BTREE,
                                     CONSTRAINT `training_problem_ibfk_1` FOREIGN KEY (`tid`) REFERENCES `training` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                                     CONSTRAINT `training_problem_ibfk_2` FOREIGN KEY (`pid`) REFERENCES `problem` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                                     CONSTRAINT `training_problem_ibfk_3` FOREIGN KEY (`display_id`) REFERENCES `problem` (`problem_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of training_problem
-- ----------------------------

-- ----------------------------
-- Table structure for training_record
-- ----------------------------
DROP TABLE IF EXISTS `training_record`;
CREATE TABLE `training_record`  (
                                    `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
                                    `tid` bigint UNSIGNED NOT NULL,
                                    `tpid` bigint UNSIGNED NOT NULL,
                                    `pid` bigint UNSIGNED NOT NULL,
                                    `uid` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
                                    `submit_id` bigint UNSIGNED NOT NULL,
                                    `gmt_create` datetime NULL DEFAULT CURRENT_TIMESTAMP,
                                    `gmt_modified` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                    PRIMARY KEY (`id`) USING BTREE,
                                    INDEX `tid`(`tid` ASC) USING BTREE,
                                    INDEX `tpid`(`tpid` ASC) USING BTREE,
                                    INDEX `pid`(`pid` ASC) USING BTREE,
                                    INDEX `uid`(`uid` ASC) USING BTREE,
                                    INDEX `submit_id`(`submit_id` ASC) USING BTREE,
                                    CONSTRAINT `training_record_ibfk_1` FOREIGN KEY (`tid`) REFERENCES `training` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                                    CONSTRAINT `training_record_ibfk_2` FOREIGN KEY (`tpid`) REFERENCES `training_problem` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                                    CONSTRAINT `training_record_ibfk_3` FOREIGN KEY (`pid`) REFERENCES `problem` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                                    CONSTRAINT `training_record_ibfk_4` FOREIGN KEY (`uid`) REFERENCES `user_info` (`uuid`) ON DELETE CASCADE ON UPDATE CASCADE,
                                    CONSTRAINT `training_record_ibfk_5` FOREIGN KEY (`submit_id`) REFERENCES `judge` (`submit_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of training_record
-- ----------------------------

-- ----------------------------
-- Table structure for training_register
-- ----------------------------
DROP TABLE IF EXISTS `training_register`;
CREATE TABLE `training_register`  (
                                      `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
                                      `tid` bigint UNSIGNED NOT NULL COMMENT '训练id',
                                      `uid` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '用户id',
                                      `status` tinyint(1) NULL DEFAULT 1 COMMENT '是否可用',
                                      `gmt_create` datetime NULL DEFAULT CURRENT_TIMESTAMP,
                                      `gmt_modified` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                      PRIMARY KEY (`id`) USING BTREE,
                                      INDEX `tid`(`tid` ASC) USING BTREE,
                                      INDEX `uid`(`uid` ASC) USING BTREE,
                                      CONSTRAINT `training_register_ibfk_1` FOREIGN KEY (`tid`) REFERENCES `training` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                                      CONSTRAINT `training_register_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `user_info` (`uuid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of training_register
-- ----------------------------

-- ----------------------------
-- Table structure for user_acproblem
-- ----------------------------
DROP TABLE IF EXISTS `user_acproblem`;
CREATE TABLE `user_acproblem`  (
                                   `id` bigint NOT NULL AUTO_INCREMENT,
                                   `uid` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '用户id',
                                   `pid` bigint UNSIGNED NOT NULL COMMENT 'ac的题目id',
                                   `submit_id` bigint UNSIGNED NOT NULL COMMENT '提交id',
                                   `gmt_create` datetime NULL DEFAULT CURRENT_TIMESTAMP,
                                   `gmt_modified` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                   PRIMARY KEY (`id`) USING BTREE,
                                   INDEX `submit_id`(`submit_id` ASC) USING BTREE,
                                   INDEX `uid`(`uid` ASC) USING BTREE,
                                   INDEX `pid`(`pid` ASC) USING BTREE,
                                   CONSTRAINT `user_acproblem_ibfk_2` FOREIGN KEY (`pid`) REFERENCES `problem` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                                   CONSTRAINT `user_acproblem_ibfk_3` FOREIGN KEY (`submit_id`) REFERENCES `judge` (`submit_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1263 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_acproblem
-- ----------------------------

-- ----------------------------
-- Table structure for user_info
-- ----------------------------
DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info`  (
                              `uuid` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
                              `username` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '用户名',
                              `password` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '密码',
                              `nickname` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '昵称',
                              `school` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '学校',
                              `course` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '专业',
                              `number` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '学号',
                              `realname` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '真实姓名',
                              `gender` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT 'secrecy' COMMENT '性别',
                              `github` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT 'github地址',
                              `blog` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '博客地址',
                              `cf_username` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT 'cf的username',
                              `email` varchar(320) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '邮箱',
                              `avatar` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '头像地址',
                              `signature` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
                              `title_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '头衔、称号',
                              `title_color` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '头衔、称号的颜色',
                              `status` int NOT NULL DEFAULT 0 COMMENT '0可用，1不可用',
                              `gmt_create` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                              `gmt_modified` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
                              PRIMARY KEY (`uuid`) USING BTREE,
                              UNIQUE INDEX `USERNAME_UNIQUE`(`username` ASC) USING BTREE,
                              UNIQUE INDEX `EMAIL_UNIQUE`(`email` ASC) USING BTREE,
                              UNIQUE INDEX `avatar`(`avatar` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_info
-- ----------------------------
INSERT INTO `user_info` VALUES ('1', 'root', '1a5b0bf6f536e21215e3305ba0058092', 'lxhcaicai', 'dgut', NULL, '1111', 'lxhcaicai', 'male', 'https://github.com/lxhcaicai', 'https://blog.csdn.net/weixin_43601905?type=blog', 'codeforeces', '2778763221@qq.com', NULL, '哈哈哈，我是lxhcaicai', '开挂权限', '#6506E9', 0, '2023-04-07 01:27:53', '2023-09-16 01:00:36');
INSERT INTO `user_info` VALUES ('af17f3af6ffa437b9cdb72b37511b53d', 'lxhcaicai', '1a5b0bf6f536e21215e3305ba0058092', NULL, NULL, NULL, NULL, NULL, 'secrecy', NULL, NULL, NULL, '2034276263@qq.com', NULL, NULL, 'caicai', '#E90606', 0, '2023-05-14 12:13:17', '2023-09-16 01:01:50');

-- ----------------------------
-- Table structure for user_record
-- ----------------------------
DROP TABLE IF EXISTS `user_record`;
CREATE TABLE `user_record`  (
                                `id` bigint NOT NULL AUTO_INCREMENT,
                                `uid` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '用户id',
                                `rating` int NULL DEFAULT NULL COMMENT 'cf得分',
                                `gmt_create` datetime NULL DEFAULT CURRENT_TIMESTAMP,
                                `gmt_modified` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                PRIMARY KEY (`id`, `uid`) USING BTREE,
                                INDEX `uid`(`uid` ASC) USING BTREE,
                                CONSTRAINT `user_record_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `user_info` (`uuid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 444 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_record
-- ----------------------------
INSERT INTO `user_record` VALUES (1, '1', NULL, '2023-04-07 01:27:53', '2023-04-07 01:27:53');
INSERT INTO `user_record` VALUES (443, 'af17f3af6ffa437b9cdb72b37511b53d', NULL, '2023-05-14 12:13:17', '2023-05-14 12:13:17');

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role`  (
                              `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
                              `uid` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
                              `role_id` bigint UNSIGNED NOT NULL,
                              `gmt_create` datetime NULL DEFAULT CURRENT_TIMESTAMP,
                              `gmt_modified` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                              PRIMARY KEY (`id`) USING BTREE,
                              INDEX `uid`(`uid` ASC) USING BTREE,
                              INDEX `role_id`(`role_id` ASC) USING BTREE,
                              CONSTRAINT `user_role_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `user_info` (`uuid`) ON DELETE CASCADE ON UPDATE CASCADE,
                              CONSTRAINT `user_role_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 444 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES (1, '1', 1000, '2023-04-07 01:27:53', '2023-04-07 01:27:53');
INSERT INTO `user_role` VALUES (443, 'af17f3af6ffa437b9cdb72b37511b53d', 1000, '2023-05-14 12:13:17', '2023-09-16 00:59:59');

-- ----------------------------
-- Table structure for user_sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `user_sys_notice`;
CREATE TABLE `user_sys_notice`  (
                                    `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
                                    `sys_notice_id` bigint UNSIGNED NULL DEFAULT NULL COMMENT '系统通知的id',
                                    `recipient_id` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '接受通知的用户id',
                                    `type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '消息类型，系统通知sys、我的信息mine',
                                    `state` tinyint(1) NULL DEFAULT 0 COMMENT '是否已读',
                                    `gmt_create` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '读取时间',
                                    `gmt_modified` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                    PRIMARY KEY (`id`) USING BTREE,
                                    INDEX `sys_notice_id`(`sys_notice_id` ASC) USING BTREE,
                                    INDEX `recipient_id`(`recipient_id` ASC) USING BTREE,
                                    CONSTRAINT `user_sys_notice_ibfk_1` FOREIGN KEY (`sys_notice_id`) REFERENCES `admin_sys_notice` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                                    CONSTRAINT `user_sys_notice_ibfk_2` FOREIGN KEY (`recipient_id`) REFERENCES `user_info` (`uuid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 44 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_sys_notice
-- ----------------------------
INSERT INTO `user_sys_notice` VALUES (1, 1, '1', 'Sys', 1, '2023-04-25 21:43:58', '2023-04-25 21:46:36');
INSERT INTO `user_sys_notice` VALUES (2, 2, '1', 'Sys', 1, '2023-04-26 22:07:57', '2023-04-27 23:47:38');
INSERT INTO `user_sys_notice` VALUES (3, 3, '1', 'Sys', 1, '2023-04-27 23:41:53', '2023-04-27 23:47:38');
INSERT INTO `user_sys_notice` VALUES (4, 4, '1', 'Sys', 1, '2023-05-05 00:45:14', '2023-05-06 21:55:04');
INSERT INTO `user_sys_notice` VALUES (5, 5, '1', 'Sys', 1, '2023-05-06 01:12:00', '2023-05-06 21:55:04');
INSERT INTO `user_sys_notice` VALUES (6, 6, '1', 'Sys', 1, '2023-05-06 01:16:16', '2023-05-06 21:55:04');
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
INSERT INTO `user_sys_notice` VALUES (19, 19, '1', 'Sys', 1, '2023-05-14 18:41:00', '2023-09-11 22:57:52');
INSERT INTO `user_sys_notice` VALUES (20, 20, '1', 'Sys', 1, '2023-05-15 19:40:22', '2023-09-11 22:57:52');
INSERT INTO `user_sys_notice` VALUES (21, 21, '1', 'Sys', 1, '2023-05-15 22:19:10', '2023-09-11 22:57:52');
INSERT INTO `user_sys_notice` VALUES (22, 22, '1', 'Sys', 1, '2023-05-16 21:39:24', '2023-09-11 22:57:52');
INSERT INTO `user_sys_notice` VALUES (23, 23, '1', 'Sys', 1, '2023-05-16 22:40:40', '2023-09-11 22:57:52');
INSERT INTO `user_sys_notice` VALUES (24, 24, '1', 'Sys', 1, '2023-05-17 22:45:06', '2023-09-06 18:57:03');
INSERT INTO `user_sys_notice` VALUES (25, 25, '1', 'Sys', 1, '2023-05-17 23:12:24', '2023-09-06 18:57:03');
INSERT INTO `user_sys_notice` VALUES (26, 26, '1', 'Sys', 1, '2023-05-18 22:01:44', '2023-09-06 18:57:03');
INSERT INTO `user_sys_notice` VALUES (27, 27, '1', 'Sys', 1, '2023-07-03 22:38:33', '2023-09-06 18:57:03');
INSERT INTO `user_sys_notice` VALUES (28, 28, '1', 'Sys', 1, '2023-07-04 22:53:45', '2023-09-06 18:57:03');
INSERT INTO `user_sys_notice` VALUES (29, 29, '1', 'Sys', 1, '2023-07-04 22:55:52', '2023-09-06 18:57:03');
INSERT INTO `user_sys_notice` VALUES (30, 30, '1', 'Sys', 1, '2023-07-07 23:19:08', '2023-09-06 18:57:03');
INSERT INTO `user_sys_notice` VALUES (31, 31, '1', 'Sys', 1, '2023-07-07 23:23:46', '2023-09-06 18:57:03');
INSERT INTO `user_sys_notice` VALUES (32, 32, '1', 'Sys', 1, '2023-07-11 08:13:07', '2023-09-06 18:57:03');
INSERT INTO `user_sys_notice` VALUES (33, 33, '1', 'Sys', 1, '2023-07-11 20:35:42', '2023-09-06 18:57:03');
INSERT INTO `user_sys_notice` VALUES (34, 34, '1', 'Sys', 1, '2023-07-16 10:13:47', '2023-09-06 18:57:03');
INSERT INTO `user_sys_notice` VALUES (35, 35, '1', 'Sys', 1, '2023-07-16 10:15:31', '2023-09-06 18:57:03');
INSERT INTO `user_sys_notice` VALUES (36, 36, '1', 'Sys', 1, '2023-07-16 10:26:09', '2023-09-06 18:57:03');
INSERT INTO `user_sys_notice` VALUES (37, 37, '1', 'Sys', 1, '2023-07-16 11:17:32', '2023-09-06 18:57:03');
INSERT INTO `user_sys_notice` VALUES (38, 38, '1', 'Sys', 1, '2023-07-19 22:56:00', '2023-09-06 18:57:03');
INSERT INTO `user_sys_notice` VALUES (39, 39, '1', 'Sys', 1, '2023-07-19 23:33:09', '2023-09-06 18:57:03');
INSERT INTO `user_sys_notice` VALUES (40, 40, NULL, 'Sys', 0, '2023-09-05 21:22:28', '2023-09-05 21:22:28');
INSERT INTO `user_sys_notice` VALUES (41, 41, '1', 'Sys', 1, '2023-09-10 19:00:00', '2023-09-11 22:57:52');
INSERT INTO `user_sys_notice` VALUES (42, 41, '1', 'Sys', 1, '2023-09-10 19:00:00', '2023-09-11 22:57:52');
INSERT INTO `user_sys_notice` VALUES (43, 42, 'af17f3af6ffa437b9cdb72b37511b53d', 'Sys', 0, '2023-09-16 00:59:59', '2023-09-16 00:59:59');

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
