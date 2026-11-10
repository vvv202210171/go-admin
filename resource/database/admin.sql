/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80043 (8.0.43)
 Source Host           : localhost:3306
 Source Schema         : go-admin

 Target Server Type    : MySQL
 Target Server Version : 80043 (8.0.43)
 File Encoding         : 65001

 Date: 10/11/2026 16:23:47
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sys_users
-- ----------------------------
DROP TABLE IF EXISTS `sys_users`;
CREATE TABLE `sys_users`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '' COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '' COMMENT '密码',
  `email` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT '' COMMENT '邮箱',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '是否启用 0停用 1启用',
  `dept_id` int UNSIGNED NULL DEFAULT 0 COMMENT '部门ID',
  `phone` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT '' COMMENT '电话',
  `sex` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT '' COMMENT '性别',
  `nick_name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT '' COMMENT '昵称',
  `avatar` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT '' COMMENT '头像',
  `description` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL COMMENT '描述',
  `created_at` datetime NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  `deleted_at` datetime NULL DEFAULT NULL,
  `created_by` int UNSIGNED NULL DEFAULT 0 COMMENT '创建人',
  `tenant_id` int UNSIGNED NULL DEFAULT 0 COMMENT '租户ID字段',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_users
-- ----------------------------
INSERT INTO `sys_users` VALUES (1, 'admin', '$2a$10$48BNh9MEmJpNmS.xGomYiu9KSXhQGPX223mXdxjgCOri8NFiZIxBi', '', 1, 0, '', '1', '超级管理员', '/public/uploads/2026-11-09/20261109_65b0b355-2ba8-481f-b431-233096136b83.png', '超级管理员', '2026-11-09 12:27:27', '2026-11-09 16:19:59', NULL, 0, 0);
INSERT INTO `sys_users` VALUES (5, 'vvv', '$2a$10$pnTXuBeE1EYHAVhGApXf/ewMbdxBsyhMGoPGzn9qnsntlebVOZ6p6', 'vvv@qq.com', 1, 2, '133133', '1', '成衣', '', '', '2026-11-09 16:28:24', '2026-11-09 16:28:24', NULL, 0, 0);

-- ----------------------------
-- Table structure for sys_user_tenant
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_tenant`;
CREATE TABLE `sys_user_tenant`  (
  `user_id` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户ID',
  `tenant_id` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '租户id',
  `is_default` tinyint(1) NULL DEFAULT 0 COMMENT '是否默认租户',
  `created_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`, `tenant_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci COMMENT = '用户及租户关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_tenant
-- ----------------------------

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户ID',
  `role_id` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (5, 4);

-- ----------------------------
-- Table structure for sys_tenants
-- ----------------------------
DROP TABLE IF EXISTS `sys_tenants`;
CREATE TABLE `sys_tenants`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` datetime NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  `deleted_at` datetime NULL DEFAULT NULL,
  `created_by` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建人',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租户名称',
  `code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租户编码',
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '租户描述',
  `status` tinyint NOT NULL DEFAULT 1 COMMENT '状态 0停用 1启用',
  `domain` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '租户域名',
  `platform_domain` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '主域名',
  `menu_permission` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '菜单权限',
  `menu_filter_enabled` tinyint(1) NOT NULL DEFAULT 0 COMMENT '菜单权限过滤开关 0关闭 1开启',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `code`(`code` ASC) USING BTREE,
  UNIQUE INDEX `domain`(`domain` ASC) USING BTREE,
  INDEX `idx_sys_tenants_deleted_at`(`deleted_at` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_tenants
-- ----------------------------

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` int UNSIGNED NOT NULL,
  `menu_id` int UNSIGNED NOT NULL,
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (3, 140350);
INSERT INTO `sys_role_menu` VALUES (3, 140351);
INSERT INTO `sys_role_menu` VALUES (3, 140352);
INSERT INTO `sys_role_menu` VALUES (3, 140353);
INSERT INTO `sys_role_menu` VALUES (3, 140354);
INSERT INTO `sys_role_menu` VALUES (3, 140355);
INSERT INTO `sys_role_menu` VALUES (3, 140356);
INSERT INTO `sys_role_menu` VALUES (3, 140357);
INSERT INTO `sys_role_menu` VALUES (3, 140358);
INSERT INTO `sys_role_menu` VALUES (3, 140359);
INSERT INTO `sys_role_menu` VALUES (3, 140360);
INSERT INTO `sys_role_menu` VALUES (3, 140361);
INSERT INTO `sys_role_menu` VALUES (3, 140362);
INSERT INTO `sys_role_menu` VALUES (3, 140363);
INSERT INTO `sys_role_menu` VALUES (3, 140364);
INSERT INTO `sys_role_menu` VALUES (3, 140365);
INSERT INTO `sys_role_menu` VALUES (3, 140366);
INSERT INTO `sys_role_menu` VALUES (3, 140367);
INSERT INTO `sys_role_menu` VALUES (3, 140368);
INSERT INTO `sys_role_menu` VALUES (3, 140369);
INSERT INTO `sys_role_menu` VALUES (3, 140370);
INSERT INTO `sys_role_menu` VALUES (3, 140371);
INSERT INTO `sys_role_menu` VALUES (3, 140372);
INSERT INTO `sys_role_menu` VALUES (3, 140373);
INSERT INTO `sys_role_menu` VALUES (3, 140374);
INSERT INTO `sys_role_menu` VALUES (3, 140375);
INSERT INTO `sys_role_menu` VALUES (3, 140376);
INSERT INTO `sys_role_menu` VALUES (3, 140377);
INSERT INTO `sys_role_menu` VALUES (3, 140378);
INSERT INTO `sys_role_menu` VALUES (3, 140379);
INSERT INTO `sys_role_menu` VALUES (3, 140380);
INSERT INTO `sys_role_menu` VALUES (3, 140381);
INSERT INTO `sys_role_menu` VALUES (3, 140382);
INSERT INTO `sys_role_menu` VALUES (3, 140383);
INSERT INTO `sys_role_menu` VALUES (3, 140384);
INSERT INTO `sys_role_menu` VALUES (3, 140385);
INSERT INTO `sys_role_menu` VALUES (3, 140386);
INSERT INTO `sys_role_menu` VALUES (3, 140387);
INSERT INTO `sys_role_menu` VALUES (3, 140388);
INSERT INTO `sys_role_menu` VALUES (3, 140389);
INSERT INTO `sys_role_menu` VALUES (3, 140390);
INSERT INTO `sys_role_menu` VALUES (3, 140391);
INSERT INTO `sys_role_menu` VALUES (3, 140392);
INSERT INTO `sys_role_menu` VALUES (3, 140393);
INSERT INTO `sys_role_menu` VALUES (3, 140394);
INSERT INTO `sys_role_menu` VALUES (3, 140395);
INSERT INTO `sys_role_menu` VALUES (3, 140396);
INSERT INTO `sys_role_menu` VALUES (3, 140397);
INSERT INTO `sys_role_menu` VALUES (3, 140398);
INSERT INTO `sys_role_menu` VALUES (3, 140399);
INSERT INTO `sys_role_menu` VALUES (3, 140400);
INSERT INTO `sys_role_menu` VALUES (3, 140401);
INSERT INTO `sys_role_menu` VALUES (3, 140402);
INSERT INTO `sys_role_menu` VALUES (3, 140403);
INSERT INTO `sys_role_menu` VALUES (3, 140404);
INSERT INTO `sys_role_menu` VALUES (3, 140405);
INSERT INTO `sys_role_menu` VALUES (3, 140406);
INSERT INTO `sys_role_menu` VALUES (3, 140407);
INSERT INTO `sys_role_menu` VALUES (3, 140408);
INSERT INTO `sys_role_menu` VALUES (3, 140409);
INSERT INTO `sys_role_menu` VALUES (3, 140410);
INSERT INTO `sys_role_menu` VALUES (3, 140411);
INSERT INTO `sys_role_menu` VALUES (3, 140412);
INSERT INTO `sys_role_menu` VALUES (3, 140413);
INSERT INTO `sys_role_menu` VALUES (3, 140414);
INSERT INTO `sys_role_menu` VALUES (3, 140415);
INSERT INTO `sys_role_menu` VALUES (3, 140416);
INSERT INTO `sys_role_menu` VALUES (3, 140417);
INSERT INTO `sys_role_menu` VALUES (3, 140418);
INSERT INTO `sys_role_menu` VALUES (3, 140419);
INSERT INTO `sys_role_menu` VALUES (3, 140420);
INSERT INTO `sys_role_menu` VALUES (3, 140421);
INSERT INTO `sys_role_menu` VALUES (3, 140422);
INSERT INTO `sys_role_menu` VALUES (3, 140423);
INSERT INTO `sys_role_menu` VALUES (3, 140424);
INSERT INTO `sys_role_menu` VALUES (3, 140425);
INSERT INTO `sys_role_menu` VALUES (3, 140426);
INSERT INTO `sys_role_menu` VALUES (3, 140427);
INSERT INTO `sys_role_menu` VALUES (3, 140428);
INSERT INTO `sys_role_menu` VALUES (3, 140429);
INSERT INTO `sys_role_menu` VALUES (3, 140430);
INSERT INTO `sys_role_menu` VALUES (3, 140431);
INSERT INTO `sys_role_menu` VALUES (3, 140432);
INSERT INTO `sys_role_menu` VALUES (3, 140433);
INSERT INTO `sys_role_menu` VALUES (3, 140434);
INSERT INTO `sys_role_menu` VALUES (3, 140435);
INSERT INTO `sys_role_menu` VALUES (3, 140436);
INSERT INTO `sys_role_menu` VALUES (3, 140437);
INSERT INTO `sys_role_menu` VALUES (3, 140438);
INSERT INTO `sys_role_menu` VALUES (3, 140439);
INSERT INTO `sys_role_menu` VALUES (3, 140440);
INSERT INTO `sys_role_menu` VALUES (4, 140350);
INSERT INTO `sys_role_menu` VALUES (4, 140351);
INSERT INTO `sys_role_menu` VALUES (4, 140352);
INSERT INTO `sys_role_menu` VALUES (4, 140353);
INSERT INTO `sys_role_menu` VALUES (4, 140354);
INSERT INTO `sys_role_menu` VALUES (4, 140355);
INSERT INTO `sys_role_menu` VALUES (4, 140356);
INSERT INTO `sys_role_menu` VALUES (4, 140357);
INSERT INTO `sys_role_menu` VALUES (4, 140358);
INSERT INTO `sys_role_menu` VALUES (4, 140359);
INSERT INTO `sys_role_menu` VALUES (4, 140360);
INSERT INTO `sys_role_menu` VALUES (4, 140361);
INSERT INTO `sys_role_menu` VALUES (4, 140362);
INSERT INTO `sys_role_menu` VALUES (4, 140363);
INSERT INTO `sys_role_menu` VALUES (4, 140364);
INSERT INTO `sys_role_menu` VALUES (4, 140365);
INSERT INTO `sys_role_menu` VALUES (4, 140366);
INSERT INTO `sys_role_menu` VALUES (4, 140367);
INSERT INTO `sys_role_menu` VALUES (4, 140368);
INSERT INTO `sys_role_menu` VALUES (4, 140369);
INSERT INTO `sys_role_menu` VALUES (4, 140370);
INSERT INTO `sys_role_menu` VALUES (4, 140371);
INSERT INTO `sys_role_menu` VALUES (4, 140372);
INSERT INTO `sys_role_menu` VALUES (4, 140373);
INSERT INTO `sys_role_menu` VALUES (4, 140374);
INSERT INTO `sys_role_menu` VALUES (4, 140375);
INSERT INTO `sys_role_menu` VALUES (4, 140376);
INSERT INTO `sys_role_menu` VALUES (4, 140377);
INSERT INTO `sys_role_menu` VALUES (4, 140378);
INSERT INTO `sys_role_menu` VALUES (4, 140379);
INSERT INTO `sys_role_menu` VALUES (4, 140380);
INSERT INTO `sys_role_menu` VALUES (4, 140381);
INSERT INTO `sys_role_menu` VALUES (4, 140382);
INSERT INTO `sys_role_menu` VALUES (4, 140383);
INSERT INTO `sys_role_menu` VALUES (4, 140384);
INSERT INTO `sys_role_menu` VALUES (4, 140385);
INSERT INTO `sys_role_menu` VALUES (4, 140386);
INSERT INTO `sys_role_menu` VALUES (4, 140387);
INSERT INTO `sys_role_menu` VALUES (4, 140388);
INSERT INTO `sys_role_menu` VALUES (4, 140389);
INSERT INTO `sys_role_menu` VALUES (4, 140390);
INSERT INTO `sys_role_menu` VALUES (4, 140391);
INSERT INTO `sys_role_menu` VALUES (4, 140392);
INSERT INTO `sys_role_menu` VALUES (4, 140393);
INSERT INTO `sys_role_menu` VALUES (4, 140394);
INSERT INTO `sys_role_menu` VALUES (4, 140395);
INSERT INTO `sys_role_menu` VALUES (4, 140396);
INSERT INTO `sys_role_menu` VALUES (4, 140397);
INSERT INTO `sys_role_menu` VALUES (4, 140398);
INSERT INTO `sys_role_menu` VALUES (4, 140399);
INSERT INTO `sys_role_menu` VALUES (4, 140400);
INSERT INTO `sys_role_menu` VALUES (4, 140401);
INSERT INTO `sys_role_menu` VALUES (4, 140402);
INSERT INTO `sys_role_menu` VALUES (4, 140403);
INSERT INTO `sys_role_menu` VALUES (4, 140404);
INSERT INTO `sys_role_menu` VALUES (4, 140405);
INSERT INTO `sys_role_menu` VALUES (4, 140406);
INSERT INTO `sys_role_menu` VALUES (4, 140407);
INSERT INTO `sys_role_menu` VALUES (4, 140408);
INSERT INTO `sys_role_menu` VALUES (4, 140409);
INSERT INTO `sys_role_menu` VALUES (4, 140410);
INSERT INTO `sys_role_menu` VALUES (4, 140411);
INSERT INTO `sys_role_menu` VALUES (4, 140412);
INSERT INTO `sys_role_menu` VALUES (4, 140413);
INSERT INTO `sys_role_menu` VALUES (4, 140414);
INSERT INTO `sys_role_menu` VALUES (4, 140415);
INSERT INTO `sys_role_menu` VALUES (4, 140416);
INSERT INTO `sys_role_menu` VALUES (4, 140417);
INSERT INTO `sys_role_menu` VALUES (4, 140418);
INSERT INTO `sys_role_menu` VALUES (4, 140419);
INSERT INTO `sys_role_menu` VALUES (4, 140420);
INSERT INTO `sys_role_menu` VALUES (4, 140421);
INSERT INTO `sys_role_menu` VALUES (4, 140422);
INSERT INTO `sys_role_menu` VALUES (4, 140423);
INSERT INTO `sys_role_menu` VALUES (4, 140424);
INSERT INTO `sys_role_menu` VALUES (4, 140425);
INSERT INTO `sys_role_menu` VALUES (4, 140426);
INSERT INTO `sys_role_menu` VALUES (4, 140427);
INSERT INTO `sys_role_menu` VALUES (4, 140428);
INSERT INTO `sys_role_menu` VALUES (4, 140429);
INSERT INTO `sys_role_menu` VALUES (4, 140430);
INSERT INTO `sys_role_menu` VALUES (4, 140431);
INSERT INTO `sys_role_menu` VALUES (4, 140432);
INSERT INTO `sys_role_menu` VALUES (4, 140433);
INSERT INTO `sys_role_menu` VALUES (4, 140434);
INSERT INTO `sys_role_menu` VALUES (4, 140435);
INSERT INTO `sys_role_menu` VALUES (4, 140436);
INSERT INTO `sys_role_menu` VALUES (4, 140437);
INSERT INTO `sys_role_menu` VALUES (4, 140438);
INSERT INTO `sys_role_menu` VALUES (4, 140439);
INSERT INTO `sys_role_menu` VALUES (4, 140440);

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '角色名称',
  `sort` int NULL DEFAULT 0 COMMENT '排序',
  `status` tinyint NULL DEFAULT 0 COMMENT '状态',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '描述',
  `parent_id` int UNSIGNED NULL DEFAULT 0,
  `created_at` datetime NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  `deleted_at` datetime NULL DEFAULT NULL,
  `created_by` int UNSIGNED NULL DEFAULT NULL,
  `data_scope` int NULL DEFAULT 0 COMMENT '数据权限',
  `checked_depts` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '数据权限关联的部门',
  `tenant_id` int UNSIGNED NULL DEFAULT 0 COMMENT '租户ID字段',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (3, '系统管理员', 0, 1, '拥有所有权限', 0, '2026-11-09 16:26:03', '2026-11-09 16:26:03', NULL, 0, 0, '', 0);
INSERT INTO `sys_role` VALUES (4, '开发人员', 0, 1, '拥有开发权限', 0, '2026-11-09 16:26:28', '2026-11-09 16:26:28', NULL, 0, 0, '', 0);

-- ----------------------------
-- Table structure for sys_param
-- ----------------------------
DROP TABLE IF EXISTS `sys_param`;
CREATE TABLE `sys_param`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '参数名称',
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '参数唯一标识',
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '参数值',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态(0禁用/1启用)',
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '描述',
  `created_at` datetime NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  `deleted_at` datetime NULL DEFAULT NULL,
  `created_by` int UNSIGNED NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_sys_param_code`(`code` ASC) USING BTREE,
  INDEX `idx_sys_param_deleted_at`(`deleted_at` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统参数配置' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_param
-- ----------------------------

-- ----------------------------
-- Table structure for sys_operation_logs
-- ----------------------------
DROP TABLE IF EXISTS `sys_operation_logs`;
CREATE TABLE `sys_operation_logs`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) NULL DEFAULT NULL,
  `updated_at` datetime(3) NULL DEFAULT NULL,
  `deleted_at` datetime(3) NULL DEFAULT NULL,
  `user_id` bigint UNSIGNED NULL DEFAULT NULL COMMENT '操作用户ID',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '操作用户名',
  `module` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '操作模块',
  `operation` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '操作类型',
  `method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '请求方法',
  `path` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '请求路径',
  `ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '客户端IP',
  `user_agent` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户代理',
  `request_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '请求参数',
  `response_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '响应数据',
  `status_code` int NULL DEFAULT NULL COMMENT '响应状态码',
  `duration` bigint NULL DEFAULT NULL COMMENT '操作耗时(毫秒)',
  `error_msg` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '错误信息',
  `location` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '操作地点',
  `tenant_id` int UNSIGNED NULL DEFAULT 0 COMMENT '租户ID字段',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_sys_operation_logs_deleted_at`(`deleted_at` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统操作日志表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_operation_logs
-- ----------------------------

-- ----------------------------
-- Table structure for sys_menu_api
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu_api`;
CREATE TABLE `sys_menu_api`  (
  `menu_id` int UNSIGNED NOT NULL,
  `api_id` int UNSIGNED NOT NULL,
  PRIMARY KEY (`menu_id`, `api_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_menu_api
-- ----------------------------
INSERT INTO `sys_menu_api` VALUES (140350, 217);
INSERT INTO `sys_menu_api` VALUES (140350, 218);
INSERT INTO `sys_menu_api` VALUES (140350, 219);
INSERT INTO `sys_menu_api` VALUES (140350, 220);
INSERT INTO `sys_menu_api` VALUES (140350, 221);
INSERT INTO `sys_menu_api` VALUES (140350, 222);
INSERT INTO `sys_menu_api` VALUES (140350, 223);
INSERT INTO `sys_menu_api` VALUES (140351, 218);
INSERT INTO `sys_menu_api` VALUES (140352, 224);
INSERT INTO `sys_menu_api` VALUES (140353, 225);
INSERT INTO `sys_menu_api` VALUES (140354, 226);
INSERT INTO `sys_menu_api` VALUES (140355, 227);
INSERT INTO `sys_menu_api` VALUES (140355, 228);
INSERT INTO `sys_menu_api` VALUES (140355, 229);
INSERT INTO `sys_menu_api` VALUES (140356, 230);
INSERT INTO `sys_menu_api` VALUES (140357, 231);
INSERT INTO `sys_menu_api` VALUES (140358, 232);
INSERT INTO `sys_menu_api` VALUES (140359, 233);
INSERT INTO `sys_menu_api` VALUES (140360, 234);
INSERT INTO `sys_menu_api` VALUES (140360, 235);
INSERT INTO `sys_menu_api` VALUES (140360, 236);
INSERT INTO `sys_menu_api` VALUES (140361, 237);
INSERT INTO `sys_menu_api` VALUES (140362, 238);
INSERT INTO `sys_menu_api` VALUES (140363, 239);
INSERT INTO `sys_menu_api` VALUES (140364, 240);
INSERT INTO `sys_menu_api` VALUES (140365, 241);
INSERT INTO `sys_menu_api` VALUES (140365, 242);
INSERT INTO `sys_menu_api` VALUES (140366, 243);
INSERT INTO `sys_menu_api` VALUES (140367, 244);
INSERT INTO `sys_menu_api` VALUES (140368, 245);
INSERT INTO `sys_menu_api` VALUES (140369, 246);
INSERT INTO `sys_menu_api` VALUES (140370, 247);
INSERT INTO `sys_menu_api` VALUES (140370, 248);
INSERT INTO `sys_menu_api` VALUES (140371, 249);
INSERT INTO `sys_menu_api` VALUES (140372, 250);
INSERT INTO `sys_menu_api` VALUES (140373, 251);
INSERT INTO `sys_menu_api` VALUES (140373, 252);
INSERT INTO `sys_menu_api` VALUES (140373, 253);
INSERT INTO `sys_menu_api` VALUES (140373, 254);
INSERT INTO `sys_menu_api` VALUES (140373, 255);
INSERT INTO `sys_menu_api` VALUES (140373, 256);
INSERT INTO `sys_menu_api` VALUES (140373, 257);
INSERT INTO `sys_menu_api` VALUES (140373, 258);
INSERT INTO `sys_menu_api` VALUES (140374, 259);
INSERT INTO `sys_menu_api` VALUES (140375, 260);
INSERT INTO `sys_menu_api` VALUES (140376, 261);
INSERT INTO `sys_menu_api` VALUES (140377, 262);
INSERT INTO `sys_menu_api` VALUES (140378, 219);
INSERT INTO `sys_menu_api` VALUES (140378, 226);
INSERT INTO `sys_menu_api` VALUES (140378, 241);
INSERT INTO `sys_menu_api` VALUES (140378, 263);
INSERT INTO `sys_menu_api` VALUES (140379, 264);
INSERT INTO `sys_menu_api` VALUES (140380, 265);
INSERT INTO `sys_menu_api` VALUES (140381, 266);
INSERT INTO `sys_menu_api` VALUES (140382, 267);
INSERT INTO `sys_menu_api` VALUES (140383, 268);
INSERT INTO `sys_menu_api` VALUES (140384, 269);
INSERT INTO `sys_menu_api` VALUES (140385, 270);
INSERT INTO `sys_menu_api` VALUES (140385, 271);
INSERT INTO `sys_menu_api` VALUES (140386, 272);
INSERT INTO `sys_menu_api` VALUES (140386, 273);
INSERT INTO `sys_menu_api` VALUES (140387, 274);
INSERT INTO `sys_menu_api` VALUES (140388, 275);
INSERT INTO `sys_menu_api` VALUES (140389, 276);
INSERT INTO `sys_menu_api` VALUES (140390, 277);
INSERT INTO `sys_menu_api` VALUES (140391, 278);
INSERT INTO `sys_menu_api` VALUES (140392, 279);
INSERT INTO `sys_menu_api` VALUES (140393, 280);
INSERT INTO `sys_menu_api` VALUES (140394, 281);
INSERT INTO `sys_menu_api` VALUES (140395, 282);
INSERT INTO `sys_menu_api` VALUES (140396, 283);
INSERT INTO `sys_menu_api` VALUES (140397, 284);
INSERT INTO `sys_menu_api` VALUES (140398, 285);
INSERT INTO `sys_menu_api` VALUES (140399, 286);
INSERT INTO `sys_menu_api` VALUES (140400, 287);
INSERT INTO `sys_menu_api` VALUES (140401, 288);
INSERT INTO `sys_menu_api` VALUES (140402, 289);
INSERT INTO `sys_menu_api` VALUES (140403, 290);
INSERT INTO `sys_menu_api` VALUES (140403, 291);
INSERT INTO `sys_menu_api` VALUES (140404, 292);
INSERT INTO `sys_menu_api` VALUES (140404, 293);
INSERT INTO `sys_menu_api` VALUES (140405, 294);
INSERT INTO `sys_menu_api` VALUES (140405, 295);
INSERT INTO `sys_menu_api` VALUES (140406, 296);
INSERT INTO `sys_menu_api` VALUES (140406, 297);
INSERT INTO `sys_menu_api` VALUES (140407, 298);
INSERT INTO `sys_menu_api` VALUES (140408, 299);
INSERT INTO `sys_menu_api` VALUES (140409, 300);
INSERT INTO `sys_menu_api` VALUES (140410, 301);
INSERT INTO `sys_menu_api` VALUES (140411, 302);
INSERT INTO `sys_menu_api` VALUES (140412, 227);
INSERT INTO `sys_menu_api` VALUES (140413, 303);
INSERT INTO `sys_menu_api` VALUES (140413, 304);
INSERT INTO `sys_menu_api` VALUES (140413, 305);
INSERT INTO `sys_menu_api` VALUES (140414, 292);
INSERT INTO `sys_menu_api` VALUES (140414, 306);
INSERT INTO `sys_menu_api` VALUES (140414, 307);
INSERT INTO `sys_menu_api` VALUES (140415, 308);
INSERT INTO `sys_menu_api` VALUES (140415, 309);
INSERT INTO `sys_menu_api` VALUES (140416, 310);
INSERT INTO `sys_menu_api` VALUES (140417, 311);
INSERT INTO `sys_menu_api` VALUES (140418, 312);
INSERT INTO `sys_menu_api` VALUES (140418, 313);
INSERT INTO `sys_menu_api` VALUES (140419, 314);
INSERT INTO `sys_menu_api` VALUES (140420, 315);
INSERT INTO `sys_menu_api` VALUES (140421, 316);
INSERT INTO `sys_menu_api` VALUES (140422, 317);
INSERT INTO `sys_menu_api` VALUES (140423, 318);
INSERT INTO `sys_menu_api` VALUES (140424, 319);
INSERT INTO `sys_menu_api` VALUES (140425, 316);
INSERT INTO `sys_menu_api` VALUES (140426, 319);
INSERT INTO `sys_menu_api` VALUES (140426, 320);
INSERT INTO `sys_menu_api` VALUES (140426, 321);
INSERT INTO `sys_menu_api` VALUES (140426, 322);
INSERT INTO `sys_menu_api` VALUES (140426, 323);
INSERT INTO `sys_menu_api` VALUES (140429, 324);
INSERT INTO `sys_menu_api` VALUES (140429, 325);
INSERT INTO `sys_menu_api` VALUES (140430, 326);
INSERT INTO `sys_menu_api` VALUES (140431, 327);
INSERT INTO `sys_menu_api` VALUES (140431, 328);
INSERT INTO `sys_menu_api` VALUES (140431, 329);
INSERT INTO `sys_menu_api` VALUES (140432, 330);
INSERT INTO `sys_menu_api` VALUES (140433, 331);
INSERT INTO `sys_menu_api` VALUES (140434, 332);
INSERT INTO `sys_menu_api` VALUES (140435, 333);
INSERT INTO `sys_menu_api` VALUES (140437, 334);
INSERT INTO `sys_menu_api` VALUES (140437, 335);
INSERT INTO `sys_menu_api` VALUES (140438, 336);
INSERT INTO `sys_menu_api` VALUES (140439, 337);
INSERT INTO `sys_menu_api` VALUES (140440, 338);

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '路由ID',
  `parent_id` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '父级路由ID，顶层为0',
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '路由路径',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '路由名称',
  `redirect` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '重定向',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '组件文件路径',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '菜单标题，国际化key',
  `is_full` tinyint(1) NULL DEFAULT 0 COMMENT '是否全屏显示：0-否，1-是',
  `hide` tinyint(1) NULL DEFAULT 0 COMMENT '是否隐藏：0-否，1-是',
  `disable` tinyint(1) NULL DEFAULT 0 COMMENT '是否停用：0-否，1-是',
  `keep_alive` tinyint(1) NULL DEFAULT 0 COMMENT '是否缓存：0-否，1-是',
  `affix` tinyint(1) NULL DEFAULT 0 COMMENT '是否固定：0-否，1-是',
  `link` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '外链地址',
  `iframe` tinyint(1) NULL DEFAULT 0 COMMENT '是否内嵌：0-否，1-是',
  `svg_icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT 'svg图标名称',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '普通图标名称',
  `sort` int NULL DEFAULT 0 COMMENT '排序字段',
  `type` tinyint(1) NULL DEFAULT 2 COMMENT '类型：1-目录，2-菜单，3-按钮',
  `is_link` tinyint(1) NULL DEFAULT 0 COMMENT '是否外链',
  `permission` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '权限标识',
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted_at` datetime NULL DEFAULT NULL,
  `created_by` int UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_parent_id`(`parent_id` ASC) USING BTREE,
  INDEX `idx_sort`(`sort` ASC) USING BTREE,
  INDEX `idx_type`(`type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 140443 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统菜单路由表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (140350, 0, '/system', 'system', '', '', 'system', 0, 0, 0, 1, 0, '', 0, 'set', '', 97, 1, 0, '', '2025-08-27 09:09:44', '2026-09-10 10:13:34', NULL, 1);
INSERT INTO `sys_menu` VALUES (140351, 140350, '/system/userinfo', 'userinfo', '', 'system/userinfo/userinfo', 'userinfo', 0, 1, 0, 1, 0, '', 0, '', 'icon-menu', 17, 2, 0, '', '2025-08-27 09:09:44', '2025-09-17 11:19:11', NULL, 1);
INSERT INTO `sys_menu` VALUES (140352, 140351, '', '', '', '', '修改用户基本信息', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'system:userinfo:updateBasicInfo', '2025-10-31 09:26:42', '2025-10-31 09:26:42', NULL, 1);
INSERT INTO `sys_menu` VALUES (140353, 140351, '', '', '', '', '修改密码、手机号等', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'system:userinfo:updateAccount', '2025-10-17 11:12:56', '2025-10-17 11:12:56', NULL, 1);
INSERT INTO `sys_menu` VALUES (140354, 140350, '/system/role', 'role', '', 'system/role/role', 'role', 0, 0, 0, 1, 0, '', 0, '', 'IconUserGroup', 2, 2, 0, '', '2025-08-27 09:09:44', '2025-10-11 16:16:08', NULL, 1);
INSERT INTO `sys_menu` VALUES (140355, 140354, '', '', '', '', '分配权限', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'system:role:addRoleMenu', '2025-09-04 16:53:09', '2025-09-04 16:53:09', NULL, 1);
INSERT INTO `sys_menu` VALUES (140356, 140354, '', '', '', '', '删除', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'system:role:delete', '2025-09-04 16:50:19', '2025-09-04 16:50:19', NULL, 1);
INSERT INTO `sys_menu` VALUES (140357, 140354, '', '', '', '', '编辑', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'system:role:edit', '2025-09-04 16:47:15', '2025-09-04 16:47:15', NULL, 1);
INSERT INTO `sys_menu` VALUES (140358, 140354, '', '', '', '', '数据权限', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'system:role:dataScope', '2025-09-26 17:07:16', '2025-09-26 17:07:16', NULL, 1);
INSERT INTO `sys_menu` VALUES (140359, 140354, '', '', '', '', '新增', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'system:role:add', '2025-09-04 16:43:54', '2025-09-04 16:43:54', NULL, 1);
INSERT INTO `sys_menu` VALUES (140360, 140350, '/system/area', 'SystemArea', '', 'system/area/area', 'area-manage', 0, 0, 0, 1, 0, '', 0, '', 'IconMindMapping', 16, 2, 0, '', '2026-07-03 09:51:20', '2026-07-03 18:16:10', NULL, 1);
INSERT INTO `sys_menu` VALUES (140361, 140360, '', '', '', '', '删除', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'system:area:delete', '2026-07-03 09:57:19', '2026-07-03 09:57:19', NULL, 1);
INSERT INTO `sys_menu` VALUES (140362, 140360, '', '', '', '', '编辑', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'system:area:edit', '2026-07-03 09:57:05', '2026-07-03 09:57:05', NULL, 1);
INSERT INTO `sys_menu` VALUES (140363, 140360, '', '', '', '', '新增', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'system:area:add', '2026-07-03 09:55:29', '2026-07-03 09:55:29', NULL, 1);
INSERT INTO `sys_menu` VALUES (140364, 140360, '', '', '', '', '初始化数据', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'system:area:initData', '2026-07-03 18:09:10', '2026-07-03 18:09:10', NULL, 1);
INSERT INTO `sys_menu` VALUES (140365, 140350, '/system/division', 'division', '', 'system/division/division', 'division', 0, 0, 0, 1, 0, '', 0, '', 'IconMindMapping', 5, 2, 0, '', '2025-08-27 09:09:44', '2025-10-11 16:23:14', NULL, 1);
INSERT INTO `sys_menu` VALUES (140366, 140365, '', '', '', '', '删除部门', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'system:division:delete', '2025-09-12 14:51:51', '2025-09-12 14:51:51', NULL, 1);
INSERT INTO `sys_menu` VALUES (140367, 140365, '', '', '', '', '新增部门', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'system:division:add', '2025-09-12 14:50:55', '2025-09-12 14:50:55', NULL, 1);
INSERT INTO `sys_menu` VALUES (140368, 140365, '', '', '', '', '编辑部门', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'system:division:edit', '2025-09-12 14:51:17', '2025-09-12 14:51:17', NULL, 1);
INSERT INTO `sys_menu` VALUES (140369, 140350, '/system/systenant', 'SystemSystenant', '', 'system/tenant/tenant', 'tenant', 0, 0, 0, 1, 0, '', 0, '', 'IconTags', 12, 2, 0, '', '2025-10-24 09:11:32', '2025-10-24 09:20:59', NULL, 1);
INSERT INTO `sys_menu` VALUES (140370, 140369, '', '', '', '', '修改租户', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'system:tenant:edit', '2025-10-24 09:14:50', '2025-10-24 09:14:50', NULL, 1);
INSERT INTO `sys_menu` VALUES (140371, 140369, '', '', '', '', '删除租户', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'system:tenant:delete', '2025-10-24 09:15:07', '2025-10-24 09:15:07', NULL, 1);
INSERT INTO `sys_menu` VALUES (140372, 140369, '', '', '', '', '新增租户', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'system:tenant:add', '2025-10-24 09:14:25', '2025-10-24 09:14:25', NULL, 1);
INSERT INTO `sys_menu` VALUES (140373, 140369, '', '', '', '', '分配用户', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'system:tenant:assignUser', '2025-10-27 18:03:07', '2025-10-27 18:03:07', NULL, 1);
INSERT INTO `sys_menu` VALUES (140374, 140350, '/system/pluginsmanager', 'SystemPluginsmanager', '', 'system/pluginsmanager/pluginsmanager', 'plugins-manager', 0, 0, 0, 1, 0, '', 0, '', 'IconApps', 11, 2, 0, '', '2025-12-05 17:59:34', '2025-12-05 17:59:34', NULL, 1);
INSERT INTO `sys_menu` VALUES (140375, 140374, '', '', '', '', '导入插件', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'system:pluginsmanager:import', '2025-12-08 16:33:51', '2025-12-08 16:33:51', NULL, 1);
INSERT INTO `sys_menu` VALUES (140376, 140374, '', '', '', '', '导出插件', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'system:pluginsmanager:export', '2025-12-08 16:33:32', '2025-12-08 16:33:32', NULL, 1);
INSERT INTO `sys_menu` VALUES (140377, 140374, '', '', '', '', '插件卸载', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'system:pluginsmanager:uninstall', '2025-12-08 16:34:53', '2025-12-08 16:34:53', NULL, 1);
INSERT INTO `sys_menu` VALUES (140378, 140350, '/system/account', 'account', '', 'system/account/account', 'account', 0, 0, 0, 1, 0, '', 0, '', 'IconUser', 1, 2, 0, '', '2025-08-27 09:09:44', '2025-10-11 15:37:41', NULL, 1);
INSERT INTO `sys_menu` VALUES (140379, 140378, '', '', '', '', '删除', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'system:account:delete', '2025-09-03 17:12:22', '2025-09-03 17:12:22', NULL, 1);
INSERT INTO `sys_menu` VALUES (140380, 140378, '', '', '', '', '新增', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'system:account:add', '2025-09-03 16:11:58', '2025-09-03 16:11:58', NULL, 1);
INSERT INTO `sys_menu` VALUES (140381, 140378, '', '', '', '', '编辑', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'system:account:edit', '2025-09-03 17:11:24', '2025-09-03 17:11:24', NULL, 1);
INSERT INTO `sys_menu` VALUES (140382, 140350, '/system/sysconfig', 'SystemSysconfig', '', 'system/sysconfig/sysconfig', 'system-config', 0, 0, 0, 1, 0, '', 0, '', 'IconSettings', 18, 2, 0, '', '2025-10-09 16:15:21', '2025-10-15 18:10:54', NULL, 1);
INSERT INTO `sys_menu` VALUES (140383, 140382, '', '', '', '', '修改系统配置', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'system:config:update', '2025-10-09 16:24:33', '2025-10-09 16:24:33', NULL, 1);
INSERT INTO `sys_menu` VALUES (140384, 140350, '/system/codegen', 'SystemCodegen', '', 'system/codegen/codegen', 'codegen', 0, 0, 0, 1, 0, '', 0, '', 'IconCode', 10, 2, 0, '', '2025-11-04 11:45:49', '2025-11-04 11:45:49', NULL, 1);
INSERT INTO `sys_menu` VALUES (140385, 140384, '', '', '', '', '导入表', 0, 0, 0, 1, 0, '', 0, '', '', 1, 3, 0, 'system:codegen:batchInsert', '2025-11-17 15:32:25', '2025-11-17 15:32:25', NULL, 1);
INSERT INTO `sys_menu` VALUES (140386, 140384, '', '', '', '', '配置', 0, 0, 0, 1, 0, '', 0, '', '', 1, 3, 0, 'system:codegen:update', '2025-11-17 15:33:57', '2025-11-17 15:33:57', NULL, 1);
INSERT INTO `sys_menu` VALUES (140387, 140384, '', '', '', '', '生成菜单', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'system:codegen:insertmenuandapi', '2025-11-26 15:16:32', '2025-11-26 15:16:32', NULL, 1);
INSERT INTO `sys_menu` VALUES (140388, 140384, '', '', '', '', '删除', 0, 0, 0, 1, 0, '', 0, '', '', 1, 3, 0, 'system:codegen:delete', '2025-11-17 15:36:50', '2025-11-17 15:36:50', NULL, 1);
INSERT INTO `sys_menu` VALUES (140389, 140384, '', '', '', '', '生成代码文件', 0, 0, 0, 1, 0, '', 0, '', '', 1, 3, 0, 'system:codegen:generate', '2025-11-17 15:35:00', '2025-11-17 15:35:00', NULL, 1);
INSERT INTO `sys_menu` VALUES (140390, 140384, '', '', '', '', '同步数据库', 0, 0, 0, 1, 0, '', 0, '', '', 1, 3, 0, 'system:codegen:refreshFields', '2025-11-17 15:35:51', '2025-11-17 15:35:51', NULL, 1);
INSERT INTO `sys_menu` VALUES (140391, 140384, '', '', '', '', '预览', 0, 0, 0, 1, 0, '', 0, '', '', 1, 3, 0, 'system:codegen:preview', '2025-11-17 15:34:24', '2025-11-17 15:34:24', NULL, 1);
INSERT INTO `sys_menu` VALUES (140392, 140350, '/system/dictionary', 'dictionary', '', 'system/dictionary/dictionary', 'dictionary', 0, 0, 0, 1, 0, '', 0, '', 'IconBook', 15, 2, 0, '', '2025-08-27 09:09:44', '2025-10-11 16:23:47', NULL, 1);
INSERT INTO `sys_menu` VALUES (140393, 140392, '', '', '', '', '删除', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'system:dict:delete', '2025-09-16 16:40:19', '2025-09-16 16:40:19', NULL, 1);
INSERT INTO `sys_menu` VALUES (140394, 140392, '', '', '', '', '编辑', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'system:dict:edit', '2025-09-16 16:39:58', '2025-09-16 16:39:58', NULL, 1);
INSERT INTO `sys_menu` VALUES (140395, 140392, '', '', '', '', '删除字典项', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'system:dictitem:delete', '2025-09-16 17:33:41', '2025-09-16 17:33:41', NULL, 1);
INSERT INTO `sys_menu` VALUES (140396, 140392, '', '', '', '', '新增', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'system:dict:add', '2025-09-16 16:38:06', '2025-09-16 16:38:06', NULL, 1);
INSERT INTO `sys_menu` VALUES (140397, 140392, '', '', '', '', '编辑字典项', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'system:dictitem:edit', '2025-09-16 17:33:16', '2025-09-16 17:33:16', NULL, 1);
INSERT INTO `sys_menu` VALUES (140398, 140392, '', '', '', '', '新增字典项', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'system:dictitem:add', '2025-09-16 17:32:06', '2025-09-16 17:32:06', NULL, 1);
INSERT INTO `sys_menu` VALUES (140399, 140392, '', '', '', '', '字典项管理', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'system:dictitem:list', '2025-09-16 17:09:58', '2025-09-16 17:31:35', NULL, 1);
INSERT INTO `sys_menu` VALUES (140400, 140350, '/system/sysparam', 'SystemSysparam', '', 'system/sysparam/sysparam', 'params-manager', 0, 0, 0, 1, 0, '', 0, '', 'IconSettings', 14, 2, 0, '', '2026-08-17 17:36:37', '2026-08-17 17:36:37', NULL, 1);
INSERT INTO `sys_menu` VALUES (140401, 140400, '', '', '', '', '新增', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'system:param:add', '2026-08-17 17:36:36', '2026-08-17 17:36:36', NULL, 1);
INSERT INTO `sys_menu` VALUES (140402, 140400, '', '', '', '', '删除', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'system:param:delete', '2026-08-17 17:36:37', '2026-08-17 17:36:37', NULL, 1);
INSERT INTO `sys_menu` VALUES (140403, 140400, '', '', '', '', '修改', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'system:param:edit', '2026-08-17 17:36:36', '2026-08-17 17:36:36', NULL, 1);
INSERT INTO `sys_menu` VALUES (140404, 140350, '/system/api', 'SystemApi', '', 'system/sysapi/sysapi', 'api-management', 0, 0, 0, 1, 0, '', 0, '', 'IconFile', 3, 2, 0, '', '2025-09-03 10:53:57', '2025-10-16 08:53:42', NULL, 1);
INSERT INTO `sys_menu` VALUES (140405, 140404, '', '', '', '', '同步路由', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'system:api:sync', '2026-07-06 17:37:18', '2026-07-06 17:37:18', NULL, 1);
INSERT INTO `sys_menu` VALUES (140406, 140404, '', '', '', '', '编辑', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'system:api:edit', '2025-09-04 17:31:20', '2025-09-04 17:31:20', NULL, 1);
INSERT INTO `sys_menu` VALUES (140407, 140404, '', '', '', '', '新增', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'system:api:add', '2025-09-04 17:30:56', '2025-09-04 17:30:56', NULL, 1);
INSERT INTO `sys_menu` VALUES (140408, 140404, '', '', '', '', '删除', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'system:api:delete', '2025-09-04 17:31:38', '2025-09-04 17:31:38', NULL, 1);
INSERT INTO `sys_menu` VALUES (140409, 140350, '/system/log', 'log', '', 'system/log/log', 'log', 0, 0, 0, 1, 0, '', 0, '', 'IconCommon', 19, 2, 0, '', '2025-08-27 09:09:44', '2025-10-20 17:14:19', NULL, 1);
INSERT INTO `sys_menu` VALUES (140410, 140409, '', '', '', '', '导出', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'system:log:export', '2025-10-20 10:16:51', '2025-10-20 10:16:51', NULL, 1);
INSERT INTO `sys_menu` VALUES (140411, 140409, '', '', '', '', '删除', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'system:log:delete', '2025-10-20 10:17:19', '2025-10-20 10:17:19', NULL, 1);
INSERT INTO `sys_menu` VALUES (140412, 140350, '/system/menu', 'menu', '', 'system/menu/menu', 'menu', 0, 0, 0, 1, 0, '', 0, '', 'icon-menu', 4, 2, 0, '', '2025-08-27 09:09:44', '2025-08-27 09:09:44', NULL, 1);
INSERT INTO `sys_menu` VALUES (140413, 140412, '', '', '', '', '导出', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'system:menu:export', '2025-10-20 17:18:01', '2025-10-20 17:18:13', NULL, 1);
INSERT INTO `sys_menu` VALUES (140414, 140412, '', '', '', '', '分配权限', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'system:menu:setMenuApis', '2025-09-04 17:20:09', '2025-09-04 17:20:09', NULL, 1);
INSERT INTO `sys_menu` VALUES (140415, 140412, '', '', '', '', '导入', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'system:menu:import', '2025-10-21 11:29:45', '2025-10-21 11:29:45', NULL, 1);
INSERT INTO `sys_menu` VALUES (140416, 140412, '', '', '', '', '编辑', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'system:menu:edit', '2025-09-04 17:11:51', '2025-09-04 17:11:51', NULL, 1);
INSERT INTO `sys_menu` VALUES (140417, 140412, '', '', '', '', '新增', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'system:menu:add', '2025-09-04 17:07:16', '2025-09-04 17:07:16', NULL, 1);
INSERT INTO `sys_menu` VALUES (140418, 140412, '', '', '', '', '删除', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'system:menu:delete', '2025-09-04 17:12:24', '2025-09-04 17:12:24', NULL, 1);
INSERT INTO `sys_menu` VALUES (140419, 140412, '', '', '', '', '删除备份', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'system:menu:deleteBackup', '2026-09-09 17:39:05', '2026-09-09 17:39:05', NULL, 1);
INSERT INTO `sys_menu` VALUES (140420, 140350, '/system/affix', 'SystemAffix', '', 'system/affix/affix', 'file-manager', 0, 0, 0, 1, 0, '', 0, '', 'IconFolder', 13, 2, 0, '', '2025-09-25 15:17:00', '2025-10-15 18:14:16', NULL, 1);
INSERT INTO `sys_menu` VALUES (140421, 140420, '', '', '', '', '复制链接', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'system:affix:copy', '2025-10-17 11:38:09', '2025-10-17 11:38:09', NULL, 1);
INSERT INTO `sys_menu` VALUES (140422, 140420, '', '', '', '', '删除文件', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'system:affix:delete', '2025-09-25 15:46:52', '2025-09-25 15:46:52', NULL, 1);
INSERT INTO `sys_menu` VALUES (140423, 140420, '', '', '', '', '修改文件名', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'system:affix:updateName', '2025-09-25 15:47:41', '2025-09-25 15:47:41', NULL, 1);
INSERT INTO `sys_menu` VALUES (140424, 140420, '', '', '', '', '文件上传', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'system:affix:upload', '2025-09-25 15:45:29', '2025-09-25 15:46:29', NULL, 1);
INSERT INTO `sys_menu` VALUES (140425, 140420, '', '', '', '', '下载文件', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'system:affix:download', '2025-09-25 15:48:56', '2025-09-25 15:48:56', NULL, 1);
INSERT INTO `sys_menu` VALUES (140426, 140420, '', '', '', '', '大文件上传', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'system:affix:bigupload', '2026-04-09 15:47:39', '2026-04-09 15:47:39', NULL, 1);
INSERT INTO `sys_menu` VALUES (140427, 0, '/home', 'home', '', 'home/home', 'home', 0, 0, 0, 0, 1, '', 0, 'home', '', 0, 2, 0, '', '2025-08-27 09:09:44', '2025-08-27 09:09:44', NULL, 1);
INSERT INTO `sys_menu` VALUES (140428, 0, '/sysjobs', 'Sysjobs', '', '', 'sysjobs', 0, 0, 0, 1, 0, '', 0, 'functions', '', 98, 1, 0, '', '2026-02-11 11:29:40', '2026-09-10 10:13:39', NULL, 1);
INSERT INTO `sys_menu` VALUES (140429, 140428, '/system/sysjobslist', 'SystemSysjobslist', '', 'system/sysjobs/sysjobslist', 'jobslist', 0, 0, 0, 1, 0, '', 0, '', 'IconList', 0, 2, 0, '', '2026-02-11 11:36:54', '2026-02-11 11:36:54', NULL, 1);
INSERT INTO `sys_menu` VALUES (140430, 140429, '', '', '', '', '删除', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'system:sysjobs:delete', '2026-02-11 11:44:22', '2026-02-11 11:44:22', NULL, 1);
INSERT INTO `sys_menu` VALUES (140431, 140429, '', '', '', '', '编辑', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'system:sysjobs:edit', '2026-02-11 11:44:00', '2026-02-11 11:44:00', NULL, 1);
INSERT INTO `sys_menu` VALUES (140432, 140429, '', '', '', '', '新增', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'system:sysjobs:add', '2026-02-11 11:43:35', '2026-02-11 11:43:35', NULL, 1);
INSERT INTO `sys_menu` VALUES (140433, 140429, '', '', '', '', '执行一次', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'system:sysjobs:executeNow', '2026-02-12 17:59:02', '2026-02-12 17:59:02', NULL, 1);
INSERT INTO `sys_menu` VALUES (140434, 140428, '/system/joblog', 'SystemJoblog', '', 'system/sysjobresults/sysjobresultslist', 'joblog', 0, 0, 0, 1, 0, '', 0, '', 'IconHistory', 0, 2, 0, '', '2026-02-11 11:41:27', '2026-02-11 11:41:27', NULL, 1);
INSERT INTO `sys_menu` VALUES (140435, 140434, '', '', '', '', '删除', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'system:sysjobresults:delete', '2026-02-11 11:45:18', '2026-02-11 11:45:18', NULL, 1);
INSERT INTO `sys_menu` VALUES (140436, 0, '/demo', 'Demo', '', '', 'plugin-example', 0, 0, 0, 1, 0, '', 0, 'more', '', 99, 1, 0, '', '2025-10-13 14:38:38', '2026-09-10 11:53:11', NULL, 1);
INSERT INTO `sys_menu` VALUES (140437, 140436, '/plugins/example', 'PluginsExample', '', 'plugins/example/views/examplelist', 'plugin-example', 0, 0, 0, 1, 0, '', 0, '', 'IconMenu', 0, 2, 0, '', '2025-10-13 15:19:20', '2025-10-16 08:55:19', NULL, 1);
INSERT INTO `sys_menu` VALUES (140438, 140437, '', '', '', '', '删除', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'plugins:example:delete', '2025-10-14 11:03:25', '2025-10-14 11:03:25', NULL, 1);
INSERT INTO `sys_menu` VALUES (140439, 140437, '', '', '', '', '编辑', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'plugins:example:edit', '2025-10-14 11:03:08', '2025-10-14 11:03:08', NULL, 1);
INSERT INTO `sys_menu` VALUES (140440, 140437, '', '', '', '', '新增', 0, 0, 0, 1, 0, '', 0, '', '', 0, 3, 0, 'plugins:example:add', '2025-10-14 11:02:42', '2025-10-14 11:02:42', NULL, 1);
INSERT INTO `sys_menu` VALUES (140441, 0, '/user', 'TinodeUser', '/user/list', '', 'tinode-user', 0, 0, 0, 0, 0, '', 0, '', 'IconUser', 1, 1, 0, '', '2026-11-10 15:24:51', '2026-11-10 15:24:51', NULL, 0);
INSERT INTO `sys_menu` VALUES (140442, 140441, '/user/list', 'TinodeUserList', '', 'user/list/list', 'tinode-user-list', 0, 0, 0, 1, 0, '', 0, '', 'IconList', 1, 2, 0, '', '2026-11-10 15:24:51', '2026-11-10 15:24:51', NULL, 0);

-- ----------------------------
-- Table structure for sys_jobs
-- ----------------------------
DROP TABLE IF EXISTS `sys_jobs`;
CREATE TABLE `sys_jobs`  (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '任务ID',
  `group` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '任务分组名称',
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '任务名称',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '任务描述',
  `executor_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '执行器名称',
  `execution_policy` tinyint NOT NULL DEFAULT 1 COMMENT '执行策略: 0=单次执行, 1=重复执行',
  `status` tinyint NOT NULL DEFAULT 1 COMMENT '任务状态: 0=禁用, 1=启用',
  `cron_expression` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Cron表达式',
  `parameters` json NULL COMMENT '任务参数(JSON格式)',
  `blocking_policy` tinyint NOT NULL DEFAULT 0 COMMENT '阻塞策略: 0=丢弃, 1=覆盖, 2=并行',
  `timeout` bigint NOT NULL DEFAULT 30000000000 COMMENT '超时时间(纳秒)',
  `max_retry` int NOT NULL DEFAULT 0 COMMENT '最大重试次数',
  `retry_interval` bigint NOT NULL DEFAULT 10000000000 COMMENT '重试间隔(纳秒)',
  `parallel_num` int NOT NULL DEFAULT 1 COMMENT '并行数',
  `running_count` int NOT NULL DEFAULT 0 COMMENT '当前运行中的任务数',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted_at` datetime NULL DEFAULT NULL,
  `created_by` int UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_group`(`group` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_executor_name`(`executor_name` ASC) USING BTREE,
  INDEX `idx_created_at`(`created_at` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '任务调度表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_jobs
-- ----------------------------
INSERT INTO `sys_jobs` VALUES ('operation-log-cleanup', 'system', '操作日志清理', '每天凌晨 3 点清理 retain_days 天之前的操作日志（默认保留 90 天，任务参数可配）', 'operation-log-cleanup', 1, 0, '0 0 3 * * *', '{\"retain_days\": 90}', 0, 600000000000, 0, 10000000000, 1, 0, '2026-11-07 18:18:32', '2026-11-07 18:18:32', NULL, 0);

-- ----------------------------
-- Table structure for sys_job_results
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_results`;
CREATE TABLE `sys_job_results`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `job_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '任务ID',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '执行状态: SUCCESS, FAILED, PANIC',
  `error` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '错误信息',
  `start_time` datetime NOT NULL COMMENT '开始时间',
  `end_time` datetime NOT NULL COMMENT '结束时间',
  `duration` bigint NOT NULL COMMENT '执行时长(纳秒)',
  `retry_count` int NOT NULL DEFAULT 0 COMMENT '重试次数',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_job_id`(`job_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_start_time`(`start_time` ASC) USING BTREE,
  INDEX `idx_created_at`(`created_at` ASC) USING BTREE,
  CONSTRAINT `sys_job_results_ibfk_1` FOREIGN KEY (`job_id`) REFERENCES `sys_jobs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '任务执行结果表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job_results
-- ----------------------------

-- ----------------------------
-- Table structure for sys_dict_item
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_item`;
CREATE TABLE `sys_dict_item`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `status` tinyint(1) NULL DEFAULT NULL COMMENT '状态',
  `dict_id` int UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 43 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_item
-- ----------------------------

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '字典名称',
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '字典编码',
  `status` tinyint(1) NULL DEFAULT NULL COMMENT '状态',
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  `deleted_at` datetime NULL DEFAULT NULL,
  `created_by` int UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict
-- ----------------------------

-- ----------------------------
-- Table structure for sys_department
-- ----------------------------
DROP TABLE IF EXISTS `sys_department`;
CREATE TABLE `sys_department`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `parent_id` int UNSIGNED NULL DEFAULT 0 COMMENT '父级',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '部门名称',
  `status` tinyint(1) NULL DEFAULT NULL COMMENT '状态： 0 停用 1 启用',
  `leader` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
  `sort` int NULL DEFAULT 0 COMMENT '排序',
  `describe` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '描述',
  `created_at` datetime NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  `deleted_at` datetime NULL DEFAULT NULL,
  `created_by` int UNSIGNED NULL DEFAULT NULL,
  `tenant_id` int UNSIGNED NULL DEFAULT 0 COMMENT '租户ID字段',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_department
-- ----------------------------
INSERT INTO `sys_department` VALUES (2, NULL, '总部', 1, '懂事长李德', '13966521456', 'lide@qq.com', 0, '', '2026-11-09 16:25:01', '2026-11-09 16:25:01', NULL, 0, 0);

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '配置键',
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '配置值',
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '描述',
  `created_at` datetime NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_sys_config_code`(`code` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统配置表(后台「系统配置」页面的用户配置项,缺失行启动时按config.yml初始值补种)' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, 'system.systemlogo', '', '系统LOGO图片地址', '2026-11-09 14:31:36', '2026-11-09 14:31:36');
INSERT INTO `sys_config` VALUES (2, 'system.systemicon', '', '系统图标地址', '2026-11-09 14:31:36', '2026-11-09 14:31:36');
INSERT INTO `sys_config` VALUES (3, 'system.systemname', 'GinFast', '系统名称', '2026-11-09 14:31:36', '2026-11-09 14:31:36');
INSERT INTO `sys_config` VALUES (4, 'system.systemcopyright', 'Copyright © 2025 -2028  云南奇讯科技有限公司版权所有', '版权声明信息', '2026-11-09 14:31:36', '2026-11-09 14:31:36');
INSERT INTO `sys_config` VALUES (5, 'system.systemrecordno', '滇ICP备16002997号', '网站备案号', '2026-11-09 14:31:36', '2026-11-09 14:31:36');
INSERT INTO `sys_config` VALUES (6, 'server.demoaccount.defaultusername', 'admin', '登录页默认账号（演示账号开关开启时显示）', '2026-11-09 14:31:36', '2026-11-09 14:31:36');
INSERT INTO `sys_config` VALUES (7, 'server.demoaccount.defaultpassword', '123456', '演示密码（登录页密码框placeholder提示用，用户自行输入）', '2026-11-09 14:31:36', '2026-11-09 14:31:36');
INSERT INTO `sys_config` VALUES (8, 'safe.loginlockthreshold', '3', '密码错误锁定阈值（指定时间内连续登录失败次数达到该值将锁定账号，0表示不锁定）', '2026-11-09 14:31:36', '2026-11-09 14:31:36');
INSERT INTO `sys_config` VALUES (9, 'safe.loginlockexpire', '60', '连续登录失败次数记录缓存时间（秒）', '2026-11-09 14:31:36', '2026-11-09 14:31:36');
INSERT INTO `sys_config` VALUES (10, 'safe.loginlockduration', '600', '账号锁定时长（秒）', '2026-11-09 14:31:36', '2026-11-09 14:31:36');
INSERT INTO `sys_config` VALUES (11, 'safe.minpasswordlength', '6', '密码最小长度', '2026-11-09 14:31:36', '2026-11-09 14:31:36');
INSERT INTO `sys_config` VALUES (12, 'safe.requirespecialchar', 'true', '密码是否必须包含特殊字符', '2026-11-09 14:31:36', '2026-11-09 14:31:36');
INSERT INTO `sys_config` VALUES (13, 'captcha.open', 'false', '是否开启验证码功能', '2026-11-09 14:31:36', '2026-11-09 14:31:36');
INSERT INTO `sys_config` VALUES (14, 'captcha.length', '4', '验证码字符长度', '2026-11-09 14:31:36', '2026-11-09 14:31:36');

-- ----------------------------
-- Table structure for sys_casbin_rule
-- ----------------------------
DROP TABLE IF EXISTS `sys_casbin_rule`;
CREATE TABLE `sys_casbin_rule`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `ptype` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `v0` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `v1` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `v2` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `v3` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `v4` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `v5` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_casbin_rule`(`ptype` ASC, `v0` ASC, `v1` ASC, `v2` ASC, `v3` ASC, `v4` ASC, `v5` ASC) USING BTREE,
  UNIQUE INDEX `idx_sys_casbin_rule`(`ptype` ASC, `v0` ASC, `v1` ASC, `v2` ASC, `v3` ASC, `v4` ASC, `v5` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7806 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_casbin_rule
-- ----------------------------
INSERT INTO `sys_casbin_rule` VALUES (7805, 'g', 'user_5', 'role_4', '*', '', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7611, 'p', 'role_3', '/api/codegen/generate', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7678, 'p', 'role_3', '/api/codegen/insertmenuandapi', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7564, 'p', 'role_3', '/api/codegen/preview', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7659, 'p', 'role_3', '/api/codegen/tables', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7589, 'p', 'role_3', '/api/config/get', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7623, 'p', 'role_3', '/api/config/update', 'PUT', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7680, 'p', 'role_3', '/api/plugins/example/:id', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7643, 'p', 'role_3', '/api/plugins/example/add', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7656, 'p', 'role_3', '/api/plugins/example/delete', 'DELETE', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7657, 'p', 'role_3', '/api/plugins/example/edit', 'PUT', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7633, 'p', 'role_3', '/api/plugins/example/list', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7619, 'p', 'role_3', '/api/pluginsmanager/export', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7640, 'p', 'role_3', '/api/pluginsmanager/exports', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7662, 'p', 'role_3', '/api/pluginsmanager/import', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7629, 'p', 'role_3', '/api/pluginsmanager/uninstall', 'DELETE', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7631, 'p', 'role_3', '/api/sysAffix/chunk/cancel', 'DELETE', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7630, 'p', 'role_3', '/api/sysAffix/chunk/init', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7615, 'p', 'role_3', '/api/sysAffix/chunk/merge', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7606, 'p', 'role_3', '/api/sysAffix/chunk/upload', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7598, 'p', 'role_3', '/api/sysAffix/delete', 'DELETE', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7612, 'p', 'role_3', '/api/sysAffix/download/:id', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7566, 'p', 'role_3', '/api/sysAffix/list', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7679, 'p', 'role_3', '/api/sysAffix/updateName', 'PUT', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7675, 'p', 'role_3', '/api/sysAffix/upload', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7609, 'p', 'role_3', '/api/sysApi/:id', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7621, 'p', 'role_3', '/api/sysApi/add', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7674, 'p', 'role_3', '/api/sysApi/delete', 'DELETE', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7620, 'p', 'role_3', '/api/sysApi/edit', 'PUT', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7671, 'p', 'role_3', '/api/sysApi/groupList', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7575, 'p', 'role_3', '/api/sysApi/list', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7641, 'p', 'role_3', '/api/sysApi/previewRoutes', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7570, 'p', 'role_3', '/api/sysApi/syncRoutes', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7658, 'p', 'role_3', '/api/sysArea/add', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7571, 'p', 'role_3', '/api/sysArea/children/:value', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7637, 'p', 'role_3', '/api/sysArea/delete', 'DELETE', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7634, 'p', 'role_3', '/api/sysArea/edit', 'PUT', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7572, 'p', 'role_3', '/api/sysArea/initData', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7653, 'p', 'role_3', '/api/sysArea/list', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7628, 'p', 'role_3', '/api/sysArea/search', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7608, 'p', 'role_3', '/api/sysDepartment/:id', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7654, 'p', 'role_3', '/api/sysDepartment/add', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7618, 'p', 'role_3', '/api/sysDepartment/delete', 'DELETE', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7573, 'p', 'role_3', '/api/sysDepartment/edit', 'PUT', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7638, 'p', 'role_3', '/api/sysDepartment/getDivision', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7590, 'p', 'role_3', '/api/sysDict/add', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7647, 'p', 'role_3', '/api/sysDict/delete', 'DELETE', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7648, 'p', 'role_3', '/api/sysDict/edit', 'PUT', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7568, 'p', 'role_3', '/api/sysDict/getAllDicts', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7594, 'p', 'role_3', '/api/sysDict/list', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7673, 'p', 'role_3', '/api/sysDictItem/add', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7602, 'p', 'role_3', '/api/sysDictItem/delete', 'DELETE', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7577, 'p', 'role_3', '/api/sysDictItem/edit', 'PUT', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7663, 'p', 'role_3', '/api/sysDictItem/getByDictId/:dictId', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7563, 'p', 'role_3', '/api/sysGen/:id', 'DELETE', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7584, 'p', 'role_3', '/api/sysGen/:id', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7668, 'p', 'role_3', '/api/sysGen/batchInsert', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7562, 'p', 'role_3', '/api/sysGen/list', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7601, 'p', 'role_3', '/api/sysGen/refreshFields', 'PUT', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7605, 'p', 'role_3', '/api/sysGen/update', 'PUT', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7574, 'p', 'role_3', '/api/sysJobResults/delete', 'DELETE', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7581, 'p', 'role_3', '/api/sysJobResults/list', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7613, 'p', 'role_3', '/api/sysJobs/:id', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7632, 'p', 'role_3', '/api/sysJobs/add', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7660, 'p', 'role_3', '/api/sysJobs/delete', 'DELETE', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7617, 'p', 'role_3', '/api/sysJobs/edit', 'PUT', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7591, 'p', 'role_3', '/api/sysJobs/executeNow', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7567, 'p', 'role_3', '/api/sysJobs/executors', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7607, 'p', 'role_3', '/api/sysJobs/list', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7642, 'p', 'role_3', '/api/sysJobs/setStatus', 'PUT', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7636, 'p', 'role_3', '/api/sysMenu/add', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7677, 'p', 'role_3', '/api/sysMenu/apis/:id', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7565, 'p', 'role_3', '/api/sysMenu/backup', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7597, 'p', 'role_3', '/api/sysMenu/backupDelete', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7583, 'p', 'role_3', '/api/sysMenu/backupList', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7596, 'p', 'role_3', '/api/sysMenu/batchDelete', 'DELETE', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7580, 'p', 'role_3', '/api/sysMenu/delete', 'DELETE', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7682, 'p', 'role_3', '/api/sysMenu/edit', 'PUT', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7592, 'p', 'role_3', '/api/sysMenu/export', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7624, 'p', 'role_3', '/api/sysMenu/getMenuList', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7599, 'p', 'role_3', '/api/sysMenu/getRouters', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7655, 'p', 'role_3', '/api/sysMenu/import', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7665, 'p', 'role_3', '/api/sysMenu/restore', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7669, 'p', 'role_3', '/api/sysMenu/setApis', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7579, 'p', 'role_3', '/api/sysOperationLog/delete', 'DELETE', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7627, 'p', 'role_3', '/api/sysOperationLog/export', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7635, 'p', 'role_3', '/api/sysOperationLog/list', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7578, 'p', 'role_3', '/api/sysParam/:id', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7650, 'p', 'role_3', '/api/sysParam/add', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7595, 'p', 'role_3', '/api/sysParam/delete', 'DELETE', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7664, 'p', 'role_3', '/api/sysParam/edit', 'PUT', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7649, 'p', 'role_3', '/api/sysParam/list', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7676, 'p', 'role_3', '/api/sysRole/add', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7644, 'p', 'role_3', '/api/sysRole/addRoleMenu', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7587, 'p', 'role_3', '/api/sysRole/dataScope', 'PUT', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7603, 'p', 'role_3', '/api/sysRole/delete', 'DELETE', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7652, 'p', 'role_3', '/api/sysRole/edit', 'PUT', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7667, 'p', 'role_3', '/api/sysRole/getRoles', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7670, 'p', 'role_3', '/api/sysRole/getUserPermission/:roleId', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7604, 'p', 'role_3', '/api/sysTenant/:id', 'DELETE', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7625, 'p', 'role_3', '/api/sysTenant/:id', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7645, 'p', 'role_3', '/api/sysTenant/add', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7561, 'p', 'role_3', '/api/sysTenant/edit', 'PUT', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7622, 'p', 'role_3', '/api/sysTenant/list', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7576, 'p', 'role_3', '/api/sysUserTenant/batchAdd', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7600, 'p', 'role_3', '/api/sysUserTenant/batchDelete', 'DELETE', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7639, 'p', 'role_3', '/api/sysUserTenant/get', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7626, 'p', 'role_3', '/api/sysUserTenant/getRolesAll', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7588, 'p', 'role_3', '/api/sysUserTenant/getUserRoleIDs', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7616, 'p', 'role_3', '/api/sysUserTenant/list', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7614, 'p', 'role_3', '/api/sysUserTenant/setUserRoles', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7646, 'p', 'role_3', '/api/sysUserTenant/userListAll', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7666, 'p', 'role_3', '/api/users/:id', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7672, 'p', 'role_3', '/api/users/add', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7610, 'p', 'role_3', '/api/users/delete', 'DELETE', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7582, 'p', 'role_3', '/api/users/edit', 'PUT', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7661, 'p', 'role_3', '/api/users/list', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7593, 'p', 'role_3', '/api/users/logout', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7585, 'p', 'role_3', '/api/users/profile', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7651, 'p', 'role_3', '/api/users/switchTenant/:tenantId', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7569, 'p', 'role_3', '/api/users/updateAccount', 'PUT', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7681, 'p', 'role_3', '/api/users/updateBasicInfo', 'PUT', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7586, 'p', 'role_3', '/api/users/uploadAvatar', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7723, 'p', 'role_4', '/api/codegen/generate', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7750, 'p', 'role_4', '/api/codegen/insertmenuandapi', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7692, 'p', 'role_4', '/api/codegen/preview', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7704, 'p', 'role_4', '/api/codegen/tables', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7722, 'p', 'role_4', '/api/config/get', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7758, 'p', 'role_4', '/api/config/update', 'PUT', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7752, 'p', 'role_4', '/api/plugins/example/:id', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7802, 'p', 'role_4', '/api/plugins/example/add', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7725, 'p', 'role_4', '/api/plugins/example/delete', 'DELETE', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7774, 'p', 'role_4', '/api/plugins/example/edit', 'PUT', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7695, 'p', 'role_4', '/api/plugins/example/list', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7777, 'p', 'role_4', '/api/pluginsmanager/export', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7732, 'p', 'role_4', '/api/pluginsmanager/exports', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7687, 'p', 'role_4', '/api/pluginsmanager/import', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7684, 'p', 'role_4', '/api/pluginsmanager/uninstall', 'DELETE', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7685, 'p', 'role_4', '/api/sysAffix/chunk/cancel', 'DELETE', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7707, 'p', 'role_4', '/api/sysAffix/chunk/init', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7762, 'p', 'role_4', '/api/sysAffix/chunk/merge', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7771, 'p', 'role_4', '/api/sysAffix/chunk/upload', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7712, 'p', 'role_4', '/api/sysAffix/delete', 'DELETE', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7694, 'p', 'role_4', '/api/sysAffix/download/:id', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7711, 'p', 'role_4', '/api/sysAffix/list', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7780, 'p', 'role_4', '/api/sysAffix/updateName', 'PUT', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7761, 'p', 'role_4', '/api/sysAffix/upload', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7746, 'p', 'role_4', '/api/sysApi/:id', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7693, 'p', 'role_4', '/api/sysApi/add', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7791, 'p', 'role_4', '/api/sysApi/delete', 'DELETE', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7751, 'p', 'role_4', '/api/sysApi/edit', 'PUT', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7741, 'p', 'role_4', '/api/sysApi/groupList', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7708, 'p', 'role_4', '/api/sysApi/list', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7799, 'p', 'role_4', '/api/sysApi/previewRoutes', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7770, 'p', 'role_4', '/api/sysApi/syncRoutes', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7785, 'p', 'role_4', '/api/sysArea/add', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7745, 'p', 'role_4', '/api/sysArea/children/:value', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7776, 'p', 'role_4', '/api/sysArea/delete', 'DELETE', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7690, 'p', 'role_4', '/api/sysArea/edit', 'PUT', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7779, 'p', 'role_4', '/api/sysArea/initData', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7729, 'p', 'role_4', '/api/sysArea/list', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7689, 'p', 'role_4', '/api/sysArea/search', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7730, 'p', 'role_4', '/api/sysDepartment/:id', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7783, 'p', 'role_4', '/api/sysDepartment/add', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7744, 'p', 'role_4', '/api/sysDepartment/delete', 'DELETE', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7760, 'p', 'role_4', '/api/sysDepartment/edit', 'PUT', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7766, 'p', 'role_4', '/api/sysDepartment/getDivision', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7715, 'p', 'role_4', '/api/sysDict/add', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7705, 'p', 'role_4', '/api/sysDict/delete', 'DELETE', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7739, 'p', 'role_4', '/api/sysDict/edit', 'PUT', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7753, 'p', 'role_4', '/api/sysDict/getAllDicts', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7714, 'p', 'role_4', '/api/sysDict/list', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7700, 'p', 'role_4', '/api/sysDictItem/add', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7696, 'p', 'role_4', '/api/sysDictItem/delete', 'DELETE', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7797, 'p', 'role_4', '/api/sysDictItem/edit', 'PUT', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7786, 'p', 'role_4', '/api/sysDictItem/getByDictId/:dictId', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7769, 'p', 'role_4', '/api/sysGen/:id', 'DELETE', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7713, 'p', 'role_4', '/api/sysGen/:id', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7768, 'p', 'role_4', '/api/sysGen/batchInsert', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7701, 'p', 'role_4', '/api/sysGen/list', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7691, 'p', 'role_4', '/api/sysGen/refreshFields', 'PUT', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7790, 'p', 'role_4', '/api/sysGen/update', 'PUT', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7798, 'p', 'role_4', '/api/sysJobResults/delete', 'DELETE', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7763, 'p', 'role_4', '/api/sysJobResults/list', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7686, 'p', 'role_4', '/api/sysJobs/:id', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7733, 'p', 'role_4', '/api/sysJobs/add', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7781, 'p', 'role_4', '/api/sysJobs/delete', 'DELETE', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7784, 'p', 'role_4', '/api/sysJobs/edit', 'PUT', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7778, 'p', 'role_4', '/api/sysJobs/executeNow', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7794, 'p', 'role_4', '/api/sysJobs/executors', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7787, 'p', 'role_4', '/api/sysJobs/list', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7804, 'p', 'role_4', '/api/sysJobs/setStatus', 'PUT', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7706, 'p', 'role_4', '/api/sysMenu/add', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7710, 'p', 'role_4', '/api/sysMenu/apis/:id', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7801, 'p', 'role_4', '/api/sysMenu/backup', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7719, 'p', 'role_4', '/api/sysMenu/backupDelete', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7709, 'p', 'role_4', '/api/sysMenu/backupList', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7793, 'p', 'role_4', '/api/sysMenu/batchDelete', 'DELETE', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7702, 'p', 'role_4', '/api/sysMenu/delete', 'DELETE', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7697, 'p', 'role_4', '/api/sysMenu/edit', 'PUT', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7756, 'p', 'role_4', '/api/sysMenu/export', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7765, 'p', 'role_4', '/api/sysMenu/getMenuList', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7764, 'p', 'role_4', '/api/sysMenu/getRouters', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7803, 'p', 'role_4', '/api/sysMenu/import', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7748, 'p', 'role_4', '/api/sysMenu/restore', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7747, 'p', 'role_4', '/api/sysMenu/setApis', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7718, 'p', 'role_4', '/api/sysOperationLog/delete', 'DELETE', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7800, 'p', 'role_4', '/api/sysOperationLog/export', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7792, 'p', 'role_4', '/api/sysOperationLog/list', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7724, 'p', 'role_4', '/api/sysParam/:id', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7773, 'p', 'role_4', '/api/sysParam/add', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7688, 'p', 'role_4', '/api/sysParam/delete', 'DELETE', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7740, 'p', 'role_4', '/api/sysParam/edit', 'PUT', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7759, 'p', 'role_4', '/api/sysParam/list', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7736, 'p', 'role_4', '/api/sysRole/add', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7683, 'p', 'role_4', '/api/sysRole/addRoleMenu', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7703, 'p', 'role_4', '/api/sysRole/dataScope', 'PUT', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7735, 'p', 'role_4', '/api/sysRole/delete', 'DELETE', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7743, 'p', 'role_4', '/api/sysRole/edit', 'PUT', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7788, 'p', 'role_4', '/api/sysRole/getRoles', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7728, 'p', 'role_4', '/api/sysRole/getUserPermission/:roleId', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7731, 'p', 'role_4', '/api/sysTenant/:id', 'DELETE', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7795, 'p', 'role_4', '/api/sysTenant/:id', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7716, 'p', 'role_4', '/api/sysTenant/add', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7737, 'p', 'role_4', '/api/sysTenant/edit', 'PUT', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7699, 'p', 'role_4', '/api/sysTenant/list', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7754, 'p', 'role_4', '/api/sysUserTenant/batchAdd', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7755, 'p', 'role_4', '/api/sysUserTenant/batchDelete', 'DELETE', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7717, 'p', 'role_4', '/api/sysUserTenant/get', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7721, 'p', 'role_4', '/api/sysUserTenant/getRolesAll', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7767, 'p', 'role_4', '/api/sysUserTenant/getUserRoleIDs', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7796, 'p', 'role_4', '/api/sysUserTenant/list', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7789, 'p', 'role_4', '/api/sysUserTenant/setUserRoles', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7757, 'p', 'role_4', '/api/sysUserTenant/userListAll', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7734, 'p', 'role_4', '/api/users/:id', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7749, 'p', 'role_4', '/api/users/add', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7726, 'p', 'role_4', '/api/users/delete', 'DELETE', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7738, 'p', 'role_4', '/api/users/edit', 'PUT', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7772, 'p', 'role_4', '/api/users/list', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7727, 'p', 'role_4', '/api/users/logout', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7782, 'p', 'role_4', '/api/users/profile', 'GET', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7742, 'p', 'role_4', '/api/users/switchTenant/:tenantId', 'POST', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7698, 'p', 'role_4', '/api/users/updateAccount', 'PUT', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7775, 'p', 'role_4', '/api/users/updateBasicInfo', 'PUT', '*', '', '');
INSERT INTO `sys_casbin_rule` VALUES (7720, 'p', 'role_4', '/api/users/uploadAvatar', 'POST', '*', '', '');

-- ----------------------------
-- Table structure for sys_area
-- ----------------------------
DROP TABLE IF EXISTS `sys_area`;
CREATE TABLE `sys_area`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `value` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '地区编码',
  `label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '地区名称',
  `level` tinyint NULL DEFAULT NULL COMMENT '层级 1省2市3区县4街道',
  `parent` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '父级编码',
  `sort` int NULL DEFAULT 0 COMMENT '排序',
  `created_at` datetime NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  `deleted_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_sys_area_value`(`value` ASC) USING BTREE,
  INDEX `idx_sys_area_parent`(`parent` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '行政区划' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_area
-- ----------------------------

-- ----------------------------
-- Table structure for sys_api
-- ----------------------------
DROP TABLE IF EXISTS `sys_api`;
CREATE TABLE `sys_api`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '权限名称',
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '权限路径',
  `method` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '请求方法',
  `api_group` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '分组',
  `created_at` datetime NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  `deleted_at` datetime NULL DEFAULT NULL,
  `created_by` int UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 339 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_api
-- ----------------------------
INSERT INTO `sys_api` VALUES (217, '用户登出', '/api/users/logout', 'POST', '认证管理', '2025-09-03 11:13:09', '2025-09-03 11:13:09', NULL, 1);
INSERT INTO `sys_api` VALUES (218, '获取当前用户信息', '/api/users/profile', 'GET', '用户管理', '2025-09-03 11:13:09', '2025-09-03 11:13:09', NULL, 1);
INSERT INTO `sys_api` VALUES (219, '根据ID获取用户信息', '/api/users/:id', 'GET', '用户管理', '2025-09-03 11:13:09', '2025-09-03 11:13:09', NULL, 1);
INSERT INTO `sys_api` VALUES (220, '获取用户权限菜单', '/api/sysMenu/getRouters', 'GET', '菜单管理', '2025-09-03 11:13:10', '2025-09-03 11:13:10', NULL, 1);
INSERT INTO `sys_api` VALUES (221, '获取所有字典数据', '/api/sysDict/getAllDicts', 'GET', '字典管理', '2025-09-03 11:13:10', '2025-09-03 11:13:10', NULL, 1);
INSERT INTO `sys_api` VALUES (222, '头像上传', '/api/users/uploadAvatar', 'POST', '用户管理', '2025-09-24 17:01:05', '2025-09-24 17:01:05', NULL, 1);
INSERT INTO `sys_api` VALUES (223, '切换租户', '/api/users/switchTenant/:tenantId', 'POST', '用户管理', '2026-01-09 16:29:37', '2026-09-20 09:50:39', NULL, 1);
INSERT INTO `sys_api` VALUES (224, '修改用户基本信息', '/api/users/updateBasicInfo', 'PUT', '用户管理', '2025-10-31 09:05:00', '2025-10-31 09:05:00', NULL, 1);
INSERT INTO `sys_api` VALUES (225, '修改用户密码、手机号及邮箱', '/api/users/updateAccount', 'PUT', '用户管理', '2025-09-18 18:11:01', '2025-09-18 18:11:01', NULL, 1);
INSERT INTO `sys_api` VALUES (226, '获取所有角色数据', '/api/sysRole/getRoles', 'GET', '角色管理', '2025-09-03 11:13:10', '2025-09-03 11:13:10', NULL, 1);
INSERT INTO `sys_api` VALUES (227, '获取完整菜单列表', '/api/sysMenu/getMenuList', 'GET', '菜单管理', '2025-09-03 11:13:10', '2025-09-03 11:13:10', NULL, 1);
INSERT INTO `sys_api` VALUES (228, '根据角色ID获取角色菜单权限', '/api/sysRole/getUserPermission/:roleId', 'GET', '角色管理', '2025-09-03 11:13:10', '2025-09-03 11:13:10', NULL, 1);
INSERT INTO `sys_api` VALUES (229, '添加角色的菜单权限', '/api/sysRole/addRoleMenu', 'POST', '角色管理', '2025-09-03 11:13:10', '2025-09-03 11:13:10', NULL, 1);
INSERT INTO `sys_api` VALUES (230, '删除角色', '/api/sysRole/delete', 'DELETE', '角色管理', '2025-09-03 11:13:10', '2025-09-03 11:13:10', NULL, 1);
INSERT INTO `sys_api` VALUES (231, '更新角色', '/api/sysRole/edit', 'PUT', '角色管理', '2025-09-03 11:13:10', '2025-09-03 11:13:10', NULL, 1);
INSERT INTO `sys_api` VALUES (232, '设置数据权限', '/api/sysRole/dataScope', 'PUT', '角色管理', '2025-09-26 17:04:15', '2025-09-26 17:04:15', NULL, 1);
INSERT INTO `sys_api` VALUES (233, '新增角色', '/api/sysRole/add', 'POST', '角色管理', '2025-09-03 11:13:10', '2025-09-03 11:13:10', NULL, 1);
INSERT INTO `sys_api` VALUES (234, '行政区划-列表', '/api/sysArea/list', 'GET', '行政区划', '2026-07-03 17:54:15', '2026-07-03 17:54:15', NULL, 1);
INSERT INTO `sys_api` VALUES (235, '行政区划-搜索', '/api/sysArea/search', 'GET', '行政区划', '2026-07-03 17:56:10', '2026-07-03 17:56:10', NULL, 1);
INSERT INTO `sys_api` VALUES (236, '行政区划-获取指定节点的直接子节点', '/api/sysArea/children/:value', 'GET', '行政区划', '2026-07-03 17:57:38', '2026-07-03 17:57:38', NULL, 1);
INSERT INTO `sys_api` VALUES (237, '行政区划-删除', '/api/sysArea/delete', 'DELETE', '行政区划', '2026-07-03 18:00:23', '2026-07-03 18:00:23', NULL, 1);
INSERT INTO `sys_api` VALUES (238, '行政区划-编辑', '/api/sysArea/edit', 'PUT', '行政区划', '2026-07-03 17:59:29', '2026-07-03 17:59:29', NULL, 1);
INSERT INTO `sys_api` VALUES (239, '行政区划-新增', '/api/sysArea/add', 'POST', '行政区划', '2026-07-03 17:58:47', '2026-07-03 17:58:47', NULL, 1);
INSERT INTO `sys_api` VALUES (240, '行政区划-初始化', '/api/sysArea/initData', 'POST', '行政区划', '2026-07-03 18:01:38', '2026-07-03 18:01:38', NULL, 1);
INSERT INTO `sys_api` VALUES (241, '获取部门列表', '/api/sysDepartment/getDivision', 'GET', '部门管理', '2025-09-03 11:13:10', '2025-09-03 11:13:10', NULL, 1);
INSERT INTO `sys_api` VALUES (242, '根据ID获取部门信息', '/api/sysDepartment/:id', 'GET', '部门管理', '2025-09-12 14:46:42', '2025-09-12 14:46:42', NULL, 1);
INSERT INTO `sys_api` VALUES (243, '删除部门', '/api/sysDepartment/delete', 'DELETE', '部门管理', '2025-09-12 14:49:15', '2025-09-12 14:49:15', NULL, 1);
INSERT INTO `sys_api` VALUES (244, '新增部门', '/api/sysDepartment/add', 'POST', '部门管理', '2025-09-12 14:47:27', '2025-09-12 14:47:27', NULL, 1);
INSERT INTO `sys_api` VALUES (245, '更新部门', '/api/sysDepartment/edit', 'PUT', '部门管理', '2025-09-12 14:48:15', '2025-09-12 14:48:27', NULL, 1);
INSERT INTO `sys_api` VALUES (246, '租户列表', '/api/sysTenant/list', 'GET', '租户管理', '2025-10-24 09:04:18', '2025-10-24 09:04:18', NULL, 1);
INSERT INTO `sys_api` VALUES (247, '根据ID获取租户信息', '/api/sysTenant/:id', 'GET', '租户管理', '2025-10-24 09:05:23', '2025-10-24 09:05:23', NULL, 1);
INSERT INTO `sys_api` VALUES (248, '编辑租户', '/api/sysTenant/edit', 'PUT', '租户管理', '2025-10-24 09:06:54', '2025-10-24 09:06:54', NULL, 1);
INSERT INTO `sys_api` VALUES (249, '删除租户', '/api/sysTenant/:id', 'DELETE', '租户管理', '2025-10-24 09:07:47', '2025-10-24 09:07:56', NULL, 1);
INSERT INTO `sys_api` VALUES (250, '新增租户', '/api/sysTenant/add', 'POST', '租户管理', '2025-10-24 09:06:10', '2025-10-24 09:06:10', NULL, 1);
INSERT INTO `sys_api` VALUES (251, '租户关联列表', '/api/sysUserTenant/list', 'GET', '租户管理', '2025-10-27 17:51:52', '2025-10-27 17:51:52', NULL, 1);
INSERT INTO `sys_api` VALUES (252, '根据用户ID和租户ID获取用户租户关联信息', '/api/sysUserTenant/get', 'GET', '租户管理', '2025-10-27 17:53:13', '2025-10-27 17:53:13', NULL, 1);
INSERT INTO `sys_api` VALUES (253, '批量新增用户租户关联', '/api/sysUserTenant/batchAdd', 'POST', '租户管理', '2025-10-27 17:53:48', '2025-10-27 17:53:48', NULL, 1);
INSERT INTO `sys_api` VALUES (254, '批量删除用户租户关联', '/api/sysUserTenant/batchDelete', 'DELETE', '租户管理', '2025-10-27 17:54:25', '2025-10-27 17:54:25', NULL, 1);
INSERT INTO `sys_api` VALUES (255, '用户列表(不限租户)', '/api/sysUserTenant/userListAll', 'GET', '用户管理', '2025-10-28 09:41:19', '2025-10-28 16:32:35', NULL, 1);
INSERT INTO `sys_api` VALUES (256, '获取所有的角色数据(不限制租户)', '/api/sysUserTenant/getRolesAll', 'GET', '租户管理', '2025-10-29 09:17:01', '2025-10-29 09:17:01', NULL, 1);
INSERT INTO `sys_api` VALUES (257, '设置用户角色(不限租户)', '/api/sysUserTenant/setUserRoles', 'POST', '租户管理 ', '2025-10-29 09:17:50', '2025-10-29 09:17:50', NULL, 1);
INSERT INTO `sys_api` VALUES (258, '获取用户角色ID集合(不限租户)', '/api/sysUserTenant/getUserRoleIDs', 'GET', '租户管理', '2025-10-29 09:18:51', '2025-10-29 09:18:51', NULL, 1);
INSERT INTO `sys_api` VALUES (259, '获取插件列表', '/api/pluginsmanager/exports', 'GET', '插件管理', '2025-12-08 16:38:26', '2025-12-08 16:38:26', NULL, 1);
INSERT INTO `sys_api` VALUES (260, '导入插件', '/api/pluginsmanager/import', 'POST', '插件管理', '2025-12-08 16:47:11', '2025-12-08 16:47:11', NULL, 1);
INSERT INTO `sys_api` VALUES (261, '导出插件', '/api/pluginsmanager/export', 'POST', '插件管理', '2025-12-08 16:39:19', '2025-12-08 16:44:36', NULL, 1);
INSERT INTO `sys_api` VALUES (262, '卸载插件', '/api/pluginsmanager/uninstall', 'DELETE', '插件管理', '2025-12-08 16:48:07', '2025-12-08 16:48:07', NULL, 1);
INSERT INTO `sys_api` VALUES (263, '用户列表', '/api/users/list', 'GET', '用户管理', '2025-09-03 11:13:09', '2025-09-03 11:13:09', NULL, 1);
INSERT INTO `sys_api` VALUES (264, '删除用户', '/api/users/delete', 'DELETE', '用户管理', '2025-09-03 11:13:09', '2025-09-03 11:13:09', NULL, 1);
INSERT INTO `sys_api` VALUES (265, '新增用户', '/api/users/add', 'POST', '用户管理', '2025-09-03 11:13:09', '2025-09-03 11:13:09', NULL, 1);
INSERT INTO `sys_api` VALUES (266, '更新用户信息', '/api/users/edit', 'PUT', '用户管理', '2025-09-03 11:13:09', '2025-09-03 11:13:09', NULL, 1);
INSERT INTO `sys_api` VALUES (267, '读取系统配置', '/api/config/get', 'GET', '系统配置', '2025-10-09 16:21:29', '2025-10-09 16:21:29', NULL, 1);
INSERT INTO `sys_api` VALUES (268, '修改系统配置', '/api/config/update', 'PUT', '系统配置', '2025-10-09 16:21:59', '2025-10-09 16:22:09', NULL, 1);
INSERT INTO `sys_api` VALUES (269, '代码生成配置列表', '/api/sysGen/list', 'GET', '代码生成', '2025-11-17 15:15:20', '2025-11-17 15:15:20', NULL, 1);
INSERT INTO `sys_api` VALUES (270, '获取指定数据库中的表集合', '/api/codegen/tables', 'GET', '代码生成', '2025-11-17 15:13:38', '2025-11-17 15:13:38', NULL, 1);
INSERT INTO `sys_api` VALUES (271, ' 批量创建代码生成配置', '/api/sysGen/batchInsert', 'POST', '代码生成', '2025-11-17 15:22:46', '2025-11-17 15:22:46', NULL, 1);
INSERT INTO `sys_api` VALUES (272, '获取代码生成配置详情', '/api/sysGen/:id', 'GET', '代码生成', '2025-11-17 15:23:29', '2025-11-17 15:23:29', NULL, 1);
INSERT INTO `sys_api` VALUES (273, '更新代码生成配置和字段信息', '/api/sysGen/update', 'PUT', '代码生成', '2025-11-17 15:24:41', '2025-11-17 15:24:41', NULL, 1);
INSERT INTO `sys_api` VALUES (274, '生成菜单', '/api/codegen/insertmenuandapi', 'POST', '代码生成', '2025-11-26 15:12:56', '2025-11-26 15:12:56', NULL, 1);
INSERT INTO `sys_api` VALUES (275, '删除代码生成配置和字段信息', '/api/sysGen/:id', 'DELETE', '代码生成', '2025-11-17 15:26:44', '2025-11-17 15:26:44', NULL, 1);
INSERT INTO `sys_api` VALUES (276, '生成代码文件', '/api/codegen/generate', 'POST', '代码生成', '2025-11-07 15:32:53', '2025-11-07 15:32:53', NULL, 1);
INSERT INTO `sys_api` VALUES (277, '刷新代码生成配置的字段信息', '/api/sysGen/refreshFields', 'PUT', '代码生成', '2025-11-17 15:27:33', '2025-11-17 15:27:33', NULL, 1);
INSERT INTO `sys_api` VALUES (278, '代码预览', '/api/codegen/preview', 'GET', '代码生成', '2025-11-17 15:14:25', '2025-11-17 15:14:25', NULL, 1);
INSERT INTO `sys_api` VALUES (279, '字典分页列表', '/api/sysDict/list', 'GET', '字典管理', '2025-09-16 16:31:15', '2025-09-16 16:31:15', NULL, 1);
INSERT INTO `sys_api` VALUES (280, '删除字典', '/api/sysDict/delete', 'DELETE', '字典管理', '2025-09-16 16:31:15', '2025-09-16 16:31:15', NULL, 1);
INSERT INTO `sys_api` VALUES (281, '更新字典', '/api/sysDict/edit', 'PUT', '字典管理', '2025-09-16 16:31:15', '2025-09-16 16:31:15', NULL, 1);
INSERT INTO `sys_api` VALUES (282, '删除字典项', '/api/sysDictItem/delete', 'DELETE', '字典项管理', '2025-09-16 16:31:15', '2025-09-16 16:31:15', NULL, 1);
INSERT INTO `sys_api` VALUES (283, '新增字典', '/api/sysDict/add', 'POST', '字典管理', '2025-09-16 16:31:15', '2025-09-16 16:31:15', NULL, 1);
INSERT INTO `sys_api` VALUES (284, '更新字典项', '/api/sysDictItem/edit', 'PUT', '字典项管理', '2025-09-16 16:31:15', '2025-09-16 16:31:15', NULL, 1);
INSERT INTO `sys_api` VALUES (285, '新增字典项', '/api/sysDictItem/add', 'POST', '字典项管理', '2025-09-16 16:31:15', '2025-09-16 16:31:15', NULL, 1);
INSERT INTO `sys_api` VALUES (286, '根据字典ID获取字典项列表', '/api/sysDictItem/getByDictId/:dictId', 'GET', '字典项管理', '2025-09-16 16:31:15', '2025-09-16 16:31:15', NULL, 1);
INSERT INTO `sys_api` VALUES (287, '参数分页列表', '/api/sysParam/list', 'GET', '参数管理', '2026-08-17 17:36:37', '2026-08-17 17:36:37', NULL, 1);
INSERT INTO `sys_api` VALUES (288, '新增参数', '/api/sysParam/add', 'POST', '参数管理', '2026-08-17 17:36:36', '2026-08-17 17:36:36', NULL, 1);
INSERT INTO `sys_api` VALUES (289, '删除参数', '/api/sysParam/delete', 'DELETE', '参数管理', '2026-08-17 17:36:37', '2026-08-17 17:36:37', NULL, 1);
INSERT INTO `sys_api` VALUES (290, '根据ID获取参数信息', '/api/sysParam/:id', 'GET', '参数管理', '2026-08-17 17:36:36', '2026-08-17 17:36:36', NULL, 1);
INSERT INTO `sys_api` VALUES (291, '更新参数', '/api/sysParam/edit', 'PUT', '参数管理', '2026-08-17 17:36:36', '2026-08-17 17:36:36', NULL, 1);
INSERT INTO `sys_api` VALUES (292, 'API列表', '/api/sysApi/list', 'GET', 'API管理', '2025-09-03 11:13:10', '2025-09-03 11:13:10', NULL, 1);
INSERT INTO `sys_api` VALUES (293, 'API分组列表', '/api/sysApi/groupList', 'GET', 'API管理', '2026-09-17 11:19:45', '2026-09-17 11:19:45', NULL, 1);
INSERT INTO `sys_api` VALUES (294, '路由预览', '/api/sysApi/previewRoutes', 'GET', 'API管理', '2026-07-06 17:34:50', '2026-07-06 17:35:43', NULL, 1);
INSERT INTO `sys_api` VALUES (295, '同步路由', '/api/sysApi/syncRoutes', 'POST', 'API管理', '2026-07-06 17:34:50', '2026-07-06 17:35:24', NULL, 1);
INSERT INTO `sys_api` VALUES (296, '根据ID获取API信息', '/api/sysApi/:id', 'GET', 'API管理', '2025-09-03 11:13:10', '2025-09-03 11:13:10', NULL, 1);
INSERT INTO `sys_api` VALUES (297, '更新API', '/api/sysApi/edit', 'PUT', 'API管理', '2025-09-03 11:13:10', '2025-09-03 11:13:10', NULL, 1);
INSERT INTO `sys_api` VALUES (298, '新增API', '/api/sysApi/add', 'POST', 'API管理', '2025-09-03 11:13:10', '2025-09-03 11:13:10', NULL, 1);
INSERT INTO `sys_api` VALUES (299, '删除API', '/api/sysApi/delete', 'DELETE', 'API管理', '2025-09-03 11:13:10', '2025-09-03 11:13:10', NULL, 1);
INSERT INTO `sys_api` VALUES (300, '日志列表', '/api/sysOperationLog/list', 'GET', '日志管理', '2025-10-20 10:10:58', '2025-10-20 10:10:58', NULL, 1);
INSERT INTO `sys_api` VALUES (301, '日志导出', '/api/sysOperationLog/export', 'GET', '日志管理', '2025-10-20 10:14:11', '2025-10-20 10:14:11', NULL, 1);
INSERT INTO `sys_api` VALUES (302, '日志删除', '/api/sysOperationLog/delete', 'DELETE', '日志管理', '2025-10-20 10:13:19', '2025-10-20 10:13:19', NULL, 1);
INSERT INTO `sys_api` VALUES (303, '导出菜单', '/api/sysMenu/export', 'GET', '菜单管理', '2025-10-20 17:17:07', '2025-10-20 17:17:07', NULL, 1);
INSERT INTO `sys_api` VALUES (304, '获取菜单备份文件列表', '/api/sysMenu/backupList', 'GET', '菜单管理', '2026-09-09 14:40:26', '2026-09-09 14:40:26', NULL, 1);
INSERT INTO `sys_api` VALUES (305, '备份菜单数据到服务器', '/api/sysMenu/backup', 'POST', '菜单管理', '2026-09-09 14:40:26', '2026-09-09 14:40:26', NULL, 1);
INSERT INTO `sys_api` VALUES (306, '根据菜单ID获取API的ID集合', '/api/sysMenu/apis/:id', 'GET', '菜单管理', '2025-09-04 17:25:14', '2025-09-04 17:25:14', NULL, 1);
INSERT INTO `sys_api` VALUES (307, '设置菜单API权限', '/api/sysMenu/setApis', 'POST', '菜单管理', '2025-09-04 17:26:04', '2025-09-04 17:26:04', NULL, 1);
INSERT INTO `sys_api` VALUES (308, '导入菜单', '/api/sysMenu/import', 'POST', '菜单管理', '2025-10-21 11:30:34', '2025-10-24 08:59:44', NULL, 1);
INSERT INTO `sys_api` VALUES (309, '从备份文件恢复菜单数据', '/api/sysMenu/restore', 'POST', '菜单管理', '2026-09-09 14:40:26', '2026-09-09 14:40:26', NULL, 1);
INSERT INTO `sys_api` VALUES (310, '更新菜单', '/api/sysMenu/edit', 'PUT', '菜单管理', '2025-09-03 11:13:10', '2025-09-03 11:13:10', NULL, 1);
INSERT INTO `sys_api` VALUES (311, '新增菜单', '/api/sysMenu/add', 'POST', '菜单管理', '2025-09-03 11:13:10', '2025-09-03 11:13:10', NULL, 1);
INSERT INTO `sys_api` VALUES (312, '删除菜单', '/api/sysMenu/delete', 'DELETE', '菜单管理', '2025-09-03 11:13:10', '2025-09-03 11:13:10', NULL, 1);
INSERT INTO `sys_api` VALUES (313, '批量删除', '/api/sysMenu/batchDelete', 'DELETE', '菜单管理', '2025-12-05 17:48:52', '2025-12-05 17:48:52', NULL, 1);
INSERT INTO `sys_api` VALUES (314, '删除菜单备份文件', '/api/sysMenu/backupDelete', 'POST', '菜单管理', '2026-09-09 17:39:50', '2026-09-09 17:39:50', NULL, 1);
INSERT INTO `sys_api` VALUES (315, '文件列表', '/api/sysAffix/list', 'GET', '文件管理', '2025-09-25 15:54:03', '2025-09-25 15:54:03', NULL, 1);
INSERT INTO `sys_api` VALUES (316, '下载文件', '/api/sysAffix/download/:id', 'GET', '文件管理', '2025-09-25 15:56:15', '2025-09-25 15:58:06', NULL, 1);
INSERT INTO `sys_api` VALUES (317, '删除文件', '/api/sysAffix/delete', 'DELETE', '文件管理', '2025-09-25 15:51:38', '2025-09-25 15:51:38', NULL, 1);
INSERT INTO `sys_api` VALUES (318, '修改文件名', '/api/sysAffix/updateName', 'PUT', '文件管理', '2025-09-25 15:52:31', '2025-09-25 15:52:31', NULL, 1);
INSERT INTO `sys_api` VALUES (319, '上传文件', '/api/sysAffix/upload', 'POST', '文件管理', '2025-09-25 15:51:04', '2025-09-25 15:51:04', NULL, 1);
INSERT INTO `sys_api` VALUES (320, '分片上传初始化', '/api/sysAffix/chunk/init', 'POST', '文件管理', '2026-04-09 15:12:48', '2026-04-09 15:12:48', NULL, 1);
INSERT INTO `sys_api` VALUES (321, '分片上传上传分片', '/api/sysAffix/chunk/upload', 'POST', '文件管理', '2026-04-09 15:37:44', '2026-04-09 15:37:44', NULL, 1);
INSERT INTO `sys_api` VALUES (322, '分片上传合并分片', '/api/sysAffix/chunk/merge', 'POST', '文件管理', '2026-04-09 15:39:26', '2026-04-09 15:39:26', NULL, 1);
INSERT INTO `sys_api` VALUES (323, '分片上传取消上传', '/api/sysAffix/chunk/cancel', 'DELETE', '文件管理', '2026-04-09 15:43:38', '2026-04-09 15:43:38', NULL, 1);
INSERT INTO `sys_api` VALUES (324, '定时任务列表', '/api/sysJobs/list', 'GET', '任务调度', '2026-02-11 11:56:54', '2026-02-11 11:56:54', NULL, 1);
INSERT INTO `sys_api` VALUES (325, '定时任务获取所有执行器列表', '/api/sysJobs/executors', 'GET', '任务调度', '2026-02-12 17:57:47', '2026-02-12 17:57:47', NULL, 1);
INSERT INTO `sys_api` VALUES (326, '定时任务删除', '/api/sysJobs/delete', 'DELETE', '任务调度', '2026-02-11 11:59:05', '2026-02-11 11:59:05', NULL, 1);
INSERT INTO `sys_api` VALUES (327, '定时任务编辑', '/api/sysJobs/edit', 'PUT', '任务调度', '2026-02-11 11:57:58', '2026-02-11 11:57:58', NULL, 1);
INSERT INTO `sys_api` VALUES (328, '定时任务获取数据', '/api/sysJobs/:id', 'GET', '任务调度', '2026-02-11 11:59:54', '2026-02-11 11:59:54', NULL, 1);
INSERT INTO `sys_api` VALUES (329, '定时任务设置任务状态', '/api/sysJobs/setStatus', 'PUT', '任务调度', '2026-02-12 17:56:33', '2026-02-12 17:56:33', NULL, 1);
INSERT INTO `sys_api` VALUES (330, '定时任务新增', '/api/sysJobs/add', 'POST', '任务调度', '2026-02-11 11:57:33', '2026-02-11 11:57:33', NULL, 1);
INSERT INTO `sys_api` VALUES (331, '定时任务立即执行任务', '/api/sysJobs/executeNow', 'POST', '任务调度', '2026-02-12 17:57:07', '2026-02-12 17:57:07', NULL, 1);
INSERT INTO `sys_api` VALUES (332, '定时任务日志', '/api/sysJobResults/list', 'GET', '任务调度', '2026-02-11 12:00:54', '2026-02-11 12:00:54', NULL, 1);
INSERT INTO `sys_api` VALUES (333, '定时任务日志删除', '/api/sysJobResults/delete', 'DELETE', '任务调度', '2026-02-11 12:01:22', '2026-09-10 11:12:55', NULL, 1);
INSERT INTO `sys_api` VALUES (334, '列表查询', '/api/plugins/example/list', 'GET', '插件示例', '2025-10-14 10:54:47', '2025-10-14 10:54:47', NULL, 1);
INSERT INTO `sys_api` VALUES (335, '查询单条数据', '/api/plugins/example/:id', 'GET', '插件示例', '2025-10-14 10:59:33', '2025-10-14 10:59:33', NULL, 1);
INSERT INTO `sys_api` VALUES (336, '删除', '/api/plugins/example/delete', 'DELETE', '插件示例', '2025-10-14 10:58:03', '2025-10-14 10:58:03', NULL, 1);
INSERT INTO `sys_api` VALUES (337, '修改', '/api/plugins/example/edit', 'PUT', '插件示例', '2025-10-14 10:57:10', '2025-10-14 10:57:17', NULL, 1);
INSERT INTO `sys_api` VALUES (338, '新增', '/api/plugins/example/add', 'POST', '插件示例', '2025-10-14 10:56:43', '2025-10-14 10:56:43', NULL, 1);

-- ----------------------------
-- Table structure for sys_affix_chunk
-- ----------------------------
DROP TABLE IF EXISTS `sys_affix_chunk`;
CREATE TABLE `sys_affix_chunk`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `upload_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '上传会话ID',
  `file_md5` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文件MD5',
  `file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '原始文件名',
  `file_size` bigint NULL DEFAULT NULL COMMENT '文件总大小',
  `chunk_size` int NULL DEFAULT NULL COMMENT '分片大小',
  `total_chunks` int NULL DEFAULT NULL COMMENT '总分片数',
  `chunk_index` int NOT NULL COMMENT '当前分片序号',
  `chunk_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '分片文件路径',
  `status` tinyint NULL DEFAULT 0 COMMENT '0-上传中 1-已合并 2-已取消',
  `created_at` datetime NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  `deleted_at` datetime NULL DEFAULT NULL,
  `created_by` int NULL DEFAULT NULL COMMENT '创建者ID',
  `tenant_id` int UNSIGNED NULL DEFAULT 0 COMMENT '租户ID',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_upload_chunk`(`upload_id` ASC, `chunk_index` ASC) USING BTREE,
  INDEX `idx_upload_id`(`upload_id` ASC) USING BTREE,
  INDEX `idx_file_md5`(`file_md5` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 165 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_affix_chunk
-- ----------------------------

-- ----------------------------
-- Table structure for sys_affix
-- ----------------------------
DROP TABLE IF EXISTS `sys_affix`;
CREATE TABLE `sys_affix`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '文件名',
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '路径',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '文件url',
  `file_md5` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '文件MD5(秒传检测)',
  `size` int NULL DEFAULT NULL COMMENT '文件大小',
  `ftype` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '文件类型',
  `created_at` datetime NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  `deleted_at` datetime NULL DEFAULT NULL,
  `created_by` int NULL DEFAULT NULL,
  `suffix` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '文件后缀',
  `tenant_id` int UNSIGNED NULL DEFAULT 0 COMMENT '租户ID字段',
  `thumbnail_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '缩略图路径',
  `thumbnail_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '缩略图名称',
  `thumbnail_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '缩略图URL',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_sys_affix_file_md5`(`file_md5` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_affix
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
