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

 Date: 11/11/2026 11:53:32
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

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
) ENGINE = InnoDB AUTO_INCREMENT = 140446 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统菜单路由表' ROW_FORMAT = DYNAMIC;

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
INSERT INTO `sys_menu` VALUES (140443, 0, '/chat', 'TinodeMessage', '/chat/message', '', 'tinode-message', 0, 0, 0, 0, 0, '', 0, '', 'IconMessage', 2, 1, 0, '', '2026-11-11 12:05:00', '2026-11-11 12:05:00', NULL, 0);
INSERT INTO `sys_menu` VALUES (140444, 140443, '/chat/message', 'TinodeMessageList', '', 'chat/message/list', 'tinode-message-list', 0, 0, 0, 1, 0, '', 0, '', 'IconList', 1, 2, 0, '', '2026-11-11 12:05:00', '2026-11-11 12:05:00', NULL, 0);
INSERT INTO `sys_menu` VALUES (140445, 140443, '/chat/topic', 'TinodeTopicList', '', 'chat/topic/list', 'tinode-topic-list', 0, 0, 0, 1, 0, '', 0, '', 'IconUserGroup', 2, 2, 0, '', '2026-11-11 12:05:00', '2026-11-11 12:05:00', NULL, 0);

SET FOREIGN_KEY_CHECKS = 1;
