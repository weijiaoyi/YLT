-- phpMyAdmin SQL Dump
-- version 4.7.9
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: 2019-02-20 11:22:00
-- 服务器版本： 5.5.57-log
-- PHP Version: 5.6.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `qihuo`
--

-- --------------------------------------------------------

--
-- 表的结构 `admin_account`
--

CREATE TABLE `admin_account` (
  `admin_id` int(11) NOT NULL COMMENT '用户ID',
  `realname` varchar(100) NOT NULL COMMENT '真实姓名',
  `id_card` varchar(100) NOT NULL COMMENT '身份证号',
  `bank_name` varchar(100) NOT NULL COMMENT '银行名称',
  `bank_card` varchar(100) NOT NULL COMMENT '银行卡号',
  `bank_user` varchar(100) NOT NULL COMMENT '持卡人姓名',
  `bank_mobile` char(11) NOT NULL COMMENT '银行预留手机号',
  `bank_address` varchar(100) DEFAULT NULL COMMENT '开户行地址',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='管理员账户表';

-- --------------------------------------------------------

--
-- 表的结构 `admin_deposit`
--

CREATE TABLE `admin_deposit` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL COMMENT '订单id',
  `user_id` int(11) DEFAULT '0' COMMENT '头寸用户',
  `admin_id` int(11) NOT NULL COMMENT '账号',
  `amount` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '金额',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='管理员保证金记录表';

-- --------------------------------------------------------

--
-- 表的结构 `admin_leader`
--

CREATE TABLE `admin_leader` (
  `admin_id` int(11) NOT NULL,
  `mobile` char(11) DEFAULT '' COMMENT '手机号',
  `point` tinyint(3) DEFAULT '0' COMMENT '返点百分比%',
  `deposit` decimal(13,2) DEFAULT '0.00' COMMENT '保证金',
  `state` tinyint(4) DEFAULT '1',
  `created_at` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='综会表';

--
-- 转存表中的数据 `admin_leader`
--

INSERT INTO `admin_leader` (`admin_id`, `mobile`, `point`, `deposit`, `state`, `created_at`, `created_by`, `updated_at`, `updated_by`) VALUES
(88, '12311111111', 0, '9999.00', 1, '2019-02-20 11:01:26', 2, '2019-02-20 11:01:26', 2);

-- --------------------------------------------------------

--
-- 表的结构 `admin_menu`
--

CREATE TABLE `admin_menu` (
  `id` int(11) NOT NULL COMMENT '序号',
  `name` varchar(30) NOT NULL COMMENT '菜单名',
  `pid` int(11) DEFAULT '0' COMMENT '父ID',
  `level` smallint(6) DEFAULT '1' COMMENT '层级',
  `sort` int(11) DEFAULT '1' COMMENT '排序值',
  `url` varchar(250) DEFAULT '' COMMENT '跳转链接',
  `icon` varchar(250) DEFAULT NULL COMMENT '图标',
  `is_show` tinyint(4) DEFAULT '1' COMMENT '是否显示',
  `category` tinyint(4) DEFAULT '1' COMMENT '菜单分类',
  `state` tinyint(4) DEFAULT '1' COMMENT '状态',
  `created_at` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='菜单表';

--
-- 转存表中的数据 `admin_menu`
--

INSERT INTO `admin_menu` (`id`, `name`, `pid`, `level`, `sort`, `url`, `icon`, `is_show`, `category`, `state`, `created_at`, `created_by`, `updated_at`, `updated_by`) VALUES
(1, '系统管理', 0, 1, 1, 'system', '<i class=\"Hui-iconfont\">&#xe62e;</i>', 1, 1, 1, '2016-08-22 17:54:31', 1, '2016-10-28 15:03:56', 1),
(2, '系统设置', 1, 2, 1, 'system/setting', '', 1, 1, 1, '2016-08-22 17:54:58', 1, '2016-08-22 17:54:58', 1),
(3, '系统菜单', 1, 2, 2, 'system/menu', '', 1, 1, 1, '2016-08-22 17:55:35', 1, '2016-08-22 18:59:43', 1),
(4, '系统日志', 1, 2, 3, 'system/logList', '', 1, 1, 1, '2016-08-22 18:42:11', 1, '2016-09-02 11:40:45', 1),
(5, '管理员管理', 0, 1, 2, 'admin', '<i class=\"Hui-iconfont\">&#xe62d;</i>', 1, 1, 1, '2016-08-22 18:43:29', 1, '2016-10-28 15:03:56', 1),
(6, '管理员列表', 5, 2, 1, 'admin/list', '', 1, 1, 1, '2016-08-22 18:46:24', 1, '2016-08-22 18:46:24', 1),
(7, '角色列表', 5, 2, 2, 'admin/roleList', '', 1, 1, 1, '2016-08-22 18:46:50', 1, '2016-08-30 18:25:01', 1),
(8, '权限列表', 5, 2, 3, 'admin/permissionList', '', 1, 1, 1, '2016-08-22 18:47:10', 1, '2016-08-30 18:24:58', 1),
(9, '会员管理', 0, 1, 3, 'user', '<i class=\"Hui-iconfont\">&#xe60d;</i>', 1, 1, 1, '2016-08-22 18:47:49', 1, '2016-10-28 15:03:56', 1),
(10, '会员列表', 9, 2, 1, 'user/list', '', 1, 1, 1, '2016-08-22 18:48:13', 1, '2016-08-27 19:45:26', 1),
(11, '代理商管理', 0, 1, 7, 'retail', '<i class=\"Hui-iconfont\">&#xe616;</i>', 1, 1, 1, '2016-08-22 18:48:55', 1, '2016-11-28 16:49:41', 1),
(12, '代理商列表', 11, 2, 2, 'retail/list', '', 1, 1, 1, '2016-08-22 18:49:15', 1, '2016-11-28 16:49:54', 1),
(13, '体验券管理', 0, 1, 6, 'coupon', '<i class=\"Hui-iconfont\">&#xe613;</i>', 1, 1, 1, '2016-08-22 18:49:39', 1, '2016-10-28 15:07:00', 1),
(14, '体验券列表', 13, 2, 1, 'coupon/list', '', 1, 1, 1, '2016-08-22 18:49:54', 1, '2016-10-28 15:07:04', 1),
(15, '产品管理', 0, 1, 5, 'product', '<i class=\"Hui-iconfont\">&#xe620;</i>', 1, 1, 1, '2016-08-22 18:51:04', 1, '2016-10-28 15:03:56', 1),
(16, '产品列表', 15, 2, 1, 'product/list', '', 1, 1, 1, '2016-08-22 18:51:18', 1, '2016-08-22 18:51:18', 1),
(17, '分销管理', 0, 1, 6, 'sale', '<i class=\"Hui-iconfont\">&#xe622;</i>', 1, 1, -1, '2016-08-22 18:51:35', 1, '2016-10-28 15:03:56', 1),
(18, '经纪人列表', 17, 2, 2, 'sale/managerList', '', 1, 1, -1, '2016-08-22 18:52:10', 1, '2016-10-28 15:48:01', 1),
(19, '订单管理', 0, 1, 4, 'order', '<i class=\"Hui-iconfont\">&#xe61a;</i>', 1, 1, 1, '2016-08-22 19:00:05', 1, '2016-10-28 15:03:56', 1),
(20, '用户持有体验券', 13, 2, 2, 'coupon/ownerList', '', 1, 1, 1, '2016-10-27 14:50:18', 1, '2016-10-28 15:27:50', 1),
(21, '会员持仓列表', 9, 2, 2, 'user/positionList', '', 1, 1, 1, '2016-10-27 15:32:31', 1, '2016-10-28 09:27:38', 1),
(22, '会员赠金', 9, 2, 3, 'user/giveList', '', 1, 1, 1, '2016-10-27 15:33:45', 1, '2016-10-27 19:55:55', 1),
(23, '会员出金', 9, 2, 4, 'user/withdrawList', '', 1, 1, 1, '2016-10-27 15:34:11', 1, '2016-10-27 19:55:59', 1),
(24, '会员充值记录', 9, 2, 5, 'user/chargeRecordList', '', 1, 1, 1, '2016-10-27 15:36:04', 1, '2016-10-27 19:56:07', 1),
(25, '订单列表', 19, 2, 1, 'order/list', '', 1, 1, 1, '2016-10-27 21:10:41', 1, '2016-10-27 21:10:41', 1),
(26, '风险管理', 0, 1, 8, 'risk', '<i class=\"Hui-iconfont\">&#xe65a;</i>', 1, 1, 1, '2016-10-29 10:45:01', 1, '2016-10-29 10:50:36', 1),
(27, '风险控制', 26, 2, 1, 'risk/center', '', 1, 1, 1, '2016-10-29 10:45:37', 1, '2016-10-29 10:45:37', 1),
(28, '审核经纪人', 9, 2, 7, 'user/verifyManager', '', 1, 1, -1, '2016-10-31 17:06:34', 1, '2016-10-31 17:06:34', 1),
(29, '经纪人列表', 11, 2, 3, 'sale/managerList', '', 1, 1, 1, '2016-11-30 18:00:01', 1, '2016-11-30 18:00:01', 1),
(30, '审核经纪人', 11, 2, 4, 'user/verifyManager', '', 1, 1, 1, '2016-11-30 18:00:25', 1, '2016-11-30 18:00:25', 1),
(31, '管理员返点记录列表', 11, 2, 5, 'sale/managerRebateList', '', 1, 1, 1, '2016-12-06 15:50:40', 1, '2017-05-19 18:45:34', 1),
(32, '经纪人返点记录列表', 11, 2, 6, 'user/rebateList', '', 1, 1, 1, '2016-12-06 15:51:19', 1, '2017-05-19 18:45:18', 1),
(33, '代理商出金记录', 11, 2, 7, 'retail/withdrawList', '', 1, 1, 1, '2017-04-10 14:08:34', 1, '2017-04-10 14:08:34', 1),
(34, '运营中心', 11, 2, 1, 'admin/leaderList', '', 1, 1, 1, '2017-05-19 15:18:09', 1, '2017-12-21 16:30:20', 2),
(35, '用户头寸统计记录', 11, 2, 8, 'record/depositList', '', 1, 1, 1, '2017-05-20 10:49:44', 1, '2017-05-20 10:49:44', 1),
(36, '代理商出金申请', 11, 2, 9, 'retail/saveWithdraw', '', 1, 1, 1, '2017-12-20 09:17:20', 1, '2017-12-20 09:17:20', 1),
(37, '经纪人出金记录', 11, 2, 10, 'retail/exuserWithdrawList', '', 1, 1, 1, '2017-12-21 22:58:48', 1, '2017-12-21 22:58:48', 1);

-- --------------------------------------------------------

--
-- 表的结构 `admin_user`
--

CREATE TABLE `admin_user` (
  `id` int(11) NOT NULL,
  `username` varchar(30) NOT NULL COMMENT '账号',
  `password` varchar(80) NOT NULL COMMENT '密码',
  `realname` varchar(30) NOT NULL DEFAULT '' COMMENT '真名',
  `pid` int(11) DEFAULT '0' COMMENT '上级',
  `power` int(11) DEFAULT '10000' COMMENT '权力值',
  `created_at` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `state` tinyint(4) DEFAULT '1' COMMENT '状态'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='后台用户表';

--
-- 转存表中的数据 `admin_user`
--

INSERT INTO `admin_user` (`id`, `username`, `password`, `realname`, `pid`, `power`, `created_at`, `created_by`, `updated_at`, `updated_by`, `state`) VALUES
(2, 'admin', '$2y$13$SaHMssBgsDXZ5W578mRHluvaYTmNpZrJ2v6Nj981BlJV3SSamCJLy', 'admin', 0, 10000, '2016-10-26 17:41:00', 1, '2019-02-20 10:53:44', 2, 1),
(88, 'zonghui1', '$2y$13$gYEVJPfqC/TNal7fSABeG.LaxRIvcD6HwWuGS7EXNCxniOZGCJLsi', '综汇1', 2, 9998, '2019-02-20 11:01:26', 2, '2019-02-20 11:01:26', 2, 1),
(89, 'daili1', '$2y$13$nQZ2gCl.ITlp0GmZ1fHHXO6xiOMuTewwTS2HSI0VGJX9tpuXCaOhW', '代理01', 88, 9997, '2019-02-20 11:02:14', 2, '2019-02-20 11:02:14', 2, 1);

-- --------------------------------------------------------

--
-- 表的结构 `admin_withdraw`
--

CREATE TABLE `admin_withdraw` (
  `id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL COMMENT '用户ID',
  `amount` decimal(11,2) NOT NULL COMMENT '出金金额',
  `op_state` tinyint(4) DEFAULT '1' COMMENT '操作状态：1待审核，2已操作，-1不通过',
  `created_at` datetime DEFAULT NULL COMMENT '申请时间',
  `created_by` int(11) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL COMMENT '审核时间',
  `updated_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='管理员提款表';

-- --------------------------------------------------------

--
-- 表的结构 `article`
--

CREATE TABLE `article` (
  `id` int(11) NOT NULL,
  `title` varchar(50) NOT NULL COMMENT '标题',
  `content` text NOT NULL COMMENT '内容',
  `publish_time` datetime NOT NULL COMMENT '发生时间',
  `category` tinyint(4) DEFAULT '1' COMMENT '分类',
  `state` tinyint(4) DEFAULT '1' COMMENT '状态',
  `created_at` datetime DEFAULT NULL COMMENT '发布时间',
  `created_by` int(11) DEFAULT NULL COMMENT '发布人',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  `updated_by` int(11) DEFAULT NULL COMMENT '修改人'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资讯表';

-- --------------------------------------------------------

--
-- 表的结构 `auth_assignment`
--

CREATE TABLE `auth_assignment` (
  `item_name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `auth_assignment`
--

INSERT INTO `auth_assignment` (`item_name`, `user_id`, `created_at`) VALUES
('代理商管理', '13', 1511601338),
('代理商管理', '15', 1511605728),
('代理商管理', '16', 1511606016),
('代理商管理', '21', 1511607033),
('代理商管理', '24', 1511607622),
('代理商管理', '25', 1511611325),
('代理商管理', '28', 1511688523),
('代理商管理', '29', 1511854280),
('代理商管理', '30', 1512025482),
('代理商管理', '33', 1513752614),
('代理商管理', '39', 1513834604),
('代理商管理', '4', 1495179857),
('代理商管理', '41', 1515309093),
('代理商管理', '42', 1515309139),
('代理商管理', '43', 1528342759),
('代理商管理', '44', 1535331233),
('代理商管理', '45', 1535331541),
('代理商管理', '46', 1535331666),
('代理商管理', '47', 1535332866),
('代理商管理', '48', 1541515571),
('代理商管理', '49', 1541517485),
('代理商管理', '5', 1509001706),
('代理商管理', '50', 1541517713),
('代理商管理', '51', 1541559354),
('代理商管理', '52', 1541578488),
('代理商管理', '53', 1541667914),
('代理商管理', '54', 1541676478),
('代理商管理', '55', 1541676806),
('代理商管理', '56', 1541729946),
('代理商管理', '57', 1541730042),
('代理商管理', '58', 1541734123),
('代理商管理', '59', 1541746113),
('代理商管理', '60', 1541746405),
('代理商管理', '61', 1541746808),
('代理商管理', '62', 1541746939),
('代理商管理', '63', 1541747015),
('代理商管理', '65', 1543029282),
('代理商管理', '66', 1543029513),
('代理商管理', '67', 1543032858),
('代理商管理', '68', 1543034777),
('代理商管理', '69', 1543050516),
('代理商管理', '70', 1543072446),
('代理商管理', '71', 1543212744),
('代理商管理', '72', 1543507621),
('代理商管理', '73', 1543507729),
('代理商管理', '74', 1543803520),
('代理商管理', '75', 1544766021),
('代理商管理', '76', 1545015487),
('代理商管理', '77', 1545032283),
('代理商管理', '78', 1545034588),
('代理商管理', '79', 1545039234),
('代理商管理', '80', 1545040405),
('代理商管理', '81', 1545725386),
('代理商管理', '82', 1547024143),
('代理商管理', '83', 1547024252),
('代理商管理', '87', 1547024607),
('代理商管理', '89', 1550631734),
('代理商管理', '9', 1511596943),
('后台管理员', '15', 1511605728),
('后台管理员', '17', 1511606632),
('后台管理员', '25', 1511611325),
('后台管理员', '44', 1535331233),
('后台管理员', '47', 1535332866),
('后台管理员', '61', 1541746808),
('后台管理员', '65', 1543029282),
('后台管理员', '66', 1543029513),
('后台管理员', '72', 1543507621),
('后台管理员', '82', 1547024143),
('后台管理员', '84', 1547024358),
('系统管理员', '15', 1511605728),
('系统管理员', '18', 1511606839),
('系统管理员', '19', 1511606886),
('系统管理员', '25', 1511611325),
('系统管理员', '36', 1513768215),
('系统管理员', '61', 1541746808),
('系统管理员', '65', 1543029282),
('系统管理员', '66', 1543029513),
('系统管理员', '7', 1509004758),
('系统管理员', '72', 1543507621),
('系统管理员', '85', 1547024448),
('综会管理', '11', 1511601070),
('综会管理', '12', 1513732512),
('综会管理', '15', 1511605728),
('综会管理', '20', 1511606971),
('综会管理', '23', 1511607558),
('综会管理', '25', 1511611325),
('综会管理', '27', 1511688314),
('综会管理', '3', 1495178976),
('综会管理', '32', 1513834187),
('综会管理', '34', 1515378702),
('综会管理', '35', 1515378729),
('综会管理', '37', 1513768237),
('综会管理', '40', 1513837409),
('综会管理', '44', 1535331233),
('综会管理', '47', 1535332866),
('综会管理', '6', 1509004369),
('综会管理', '61', 1541746808),
('综会管理', '65', 1543029282),
('综会管理', '66', 1543029513),
('综会管理', '72', 1543507621),
('综会管理', '76', 1545015712),
('综会管理', '77', 1545032283),
('综会管理', '82', 1547024143),
('综会管理', '86', 1547024506),
('超级管理员', '2', 1472551696),
('超级管理员', '22', 1511607122),
('超级管理员', '25', 1511611325),
('超级管理员', '26', 1511611793),
('超级管理员', '38', 1513768253),
('超级管理员', '5', 1543507621),
('超级管理员', '61', 1541746808),
('超级管理员', '64', 1541993830),
('超级管理员', '65', 1543029282),
('超级管理员', '66', 1543029513),
('超级管理员', '72', 1543507621),
('超级管理员', '8', 1509005008);

-- --------------------------------------------------------

--
-- 表的结构 `auth_item`
--

CREATE TABLE `auth_item` (
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `type` int(11) NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `rule_name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `data` text COLLATE utf8_unicode_ci,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `auth_item`
--

INSERT INTO `auth_item` (`name`, `type`, `description`, `rule_name`, `data`, `created_at`, `updated_at`) VALUES
('frontendAdminAddPermission', 2, '添加权限', NULL, NULL, 1472525853, 1472525853),
('frontendAdminAjaxDeleteAdmin', 2, '删除管理员', NULL, NULL, 1477473346, 1477473346),
('frontendAdminAjaxDeleteRole', 2, '删除角色', NULL, NULL, 1472525853, 1472525853),
('frontendAdminAjaxRoleInfo', 2, '查看角色权限', NULL, NULL, 1472543566, 1472543566),
('frontendAdminAjaxUpdatePermission', 2, '修改权限', NULL, NULL, 1472525853, 1472525853),
('frontendAdminCreateRole', 2, '创建角色', NULL, NULL, 1472525853, 1472525853),
('frontendAdminEditPoint', 2, '修改综会返点%', NULL, NULL, 1495192221, 1495192221),
('frontendAdminEditRole', 2, '编辑角色', NULL, NULL, 1472525853, 1472525853),
('frontendAdminLeaderList', 2, '综会列表', NULL, NULL, 1495192221, 1495192221),
('frontendAdminList', 2, '管理员列表', NULL, NULL, 1472525853, 1472525853),
('frontendAdminPermissionList', 2, '权限列表', NULL, NULL, 1472525853, 1472525853),
('frontendAdminRoleList', 2, '角色列表', NULL, NULL, 1472525853, 1472525853),
('frontendAdminSaveAdmin', 2, '创建/修改管理员', NULL, NULL, 1477473346, 1477473346),
('frontendAdminSaveLeader', 2, '创建/修改综会', NULL, NULL, 1495192221, 1495192221),
('frontendArticleDeleteArticle', 2, '删除资讯', NULL, NULL, 1477837454, 1477837454),
('frontendArticleList', 2, '资讯列表', NULL, NULL, 1472720497, 1472723714),
('frontendArticleSaveArticle', 2, '添加/编辑资讯', NULL, NULL, 1477837454, 1477837454),
('frontendCouponCreateCoupon', 2, '添加体验券', NULL, NULL, 1477837454, 1477837454),
('frontendCouponList', 2, '体验券列表', NULL, NULL, 1477837454, 1477837454),
('frontendCouponOwnerList', 2, '会员体验券列表', NULL, NULL, 1477837454, 1477837512),
('frontendOrderList', 2, '订单列表', NULL, NULL, 1477837454, 1477837454),
('frontendOrderOrderExcel', 2, '订单信息导出', NULL, NULL, 1491882588, 1491882588),
('frontendOrderSellOrder', 2, '手动平仓', NULL, NULL, 1480586668, 1480586668),
('frontendProductAddProduct', 2, '添加特殊产品', NULL, NULL, 1495192221, 1495192221),
('frontendProductAddStock', 2, '添加股票', NULL, NULL, 1480586668, 1480586668),
('frontendProductAjaxAllDown', 2, '一键下架产品', NULL, NULL, 1477837454, 1477837454),
('frontendProductAjaxAllUp', 2, '一键上架产品', NULL, NULL, 1477837454, 1477837454),
('frontendProductDeletePrice', 2, '删除产品价格', NULL, NULL, 1477837454, 1477837504),
('frontendProductEditPoint', 2, '修改产品浮动点位', NULL, NULL, 1495192221, 1495192221),
('frontendProductFloatList', 2, '产品浮动列表', NULL, NULL, 1495192221, 1495192221),
('frontendProductList', 2, '产品列表', NULL, NULL, 1477837454, 1477837454),
('frontendProductSetTradePrice', 2, '设置交易价格', NULL, NULL, 1477837454, 1477837454),
('frontendProductSetTradeTime', 2, '设置交易时间', NULL, NULL, 1477837454, 1477837454),
('frontendProductUpdateProduct', 2, '更新一手盈亏单价', NULL, NULL, 1513910247, 1513910247),
('frontendRecordAddRingWechat', 2, '创建微会员公众号', NULL, NULL, 1495248674, 1495248674),
('frontendRecordDepositList', 2, '用户头寸统计记录', NULL, NULL, 1495248674, 1495248674),
('frontendRecordDepositRecord', 2, '保证金操作记录', NULL, NULL, 1495248674, 1495248674),
('frontendRecordFeeRecord', 2, '手续费提现记录', NULL, NULL, 1495248674, 1495248674),
('frontendRecordNewsWechat', 2, '公众号消息列表', NULL, NULL, 1495248674, 1495248674),
('frontendRecordRingWechatList', 2, '微会员公众号记录', NULL, NULL, 1495248674, 1495248674),
('frontendRecordSaveNewsWechat', 2, '添加/编辑公众号消息', NULL, NULL, 1495248674, 1495248674),
('frontendRecordSendMessage', 2, '推送微信图文消息', NULL, NULL, 1495248674, 1495248674),
('frontendRetailEditPoint', 2, '修改代理商返点%', NULL, NULL, 1495192221, 1495192221),
('frontendRetailExuserWithdrawList', 2, '经纪人出金列表', NULL, NULL, 1513868266, 1513868266),
('frontendRetailList', 2, '代理商列表', NULL, NULL, 1480586668, 1480586668),
('frontendRetailSaveRetail', 2, '添加/编辑会员单位', NULL, NULL, 1480586668, 1480586668),
('frontendRetailSaveWithdraw', 2, '添加/编辑代理商出金', NULL, NULL, 1491814259, 1491814259),
('frontendRetailVerifyExWithdraw', 2, '经纪人出金操作', NULL, NULL, 1513868266, 1513868266),
('frontendRetailVerifyWithdraw', 2, '代理商出金操作', NULL, NULL, 1491814259, 1491814259),
('frontendRetailWithdrawList', 2, '代理商出金列表', NULL, NULL, 1491814259, 1491814259),
('frontendRiskCenter', 2, '风险控制', NULL, NULL, 1477837454, 1477837454),
('frontendSaleEditPoint', 2, '修改经纪人返点%', NULL, NULL, 1480586668, 1480586668),
('frontendSaleManagerList', 2, '经纪人列表', NULL, NULL, 1477837454, 1477837454),
('frontendSaleManagerRebateList', 2, '代理商返点统计', NULL, NULL, 1481010977, 1481010977),
('frontendSystemAddSetting', 2, '添加系统设置', NULL, NULL, 1472720497, 1472720497),
('frontendSystemDeleteSetting', 2, '删除系统设置', NULL, NULL, 1472720497, 1472720497),
('frontendSystemDestroy', 2, '一键销毁数据', NULL, NULL, 1480586668, 1480586668),
('frontendSystemLogDetail', 2, '查看日志详情', NULL, NULL, 1472794349, 1472794349),
('frontendSystemLogList', 2, '系统日志', NULL, NULL, 1472794349, 1472794349),
('frontendSystemMenu', 2, '系统菜单', NULL, NULL, 1472525853, 1472525853),
('frontendSystemSaveSetting', 2, '修改系统设置', NULL, NULL, 1472720497, 1472720497),
('frontendSystemSetting', 2, '系统设置', NULL, NULL, 1472525853, 1472525853),
('frontendUserChargeExcel', 2, '用户充值信息导出', NULL, NULL, 1491875833, 1491875833),
('frontendUserChargeRecordList', 2, '会员充值记录', NULL, NULL, 1477837454, 1477837454),
('frontendUserDeleteAll', 2, 'deleteAll', NULL, NULL, 1513732202, 1513732202),
('frontendUserDeleteUser', 2, '冻结/恢复用户', NULL, NULL, 1477837454, 1477837454),
('frontendUserEditUserPass', 2, '修改会员密码', NULL, NULL, 1477837454, 1477837454),
('frontendUserGiveList', 2, '会员赠金', NULL, NULL, 1477837454, 1477837454),
('frontendUserList', 2, '会员列表', NULL, NULL, 1477837454, 1477837454),
('frontendUserMoveUser', 2, '修改会员代理商', NULL, NULL, 1513732202, 1513732202),
('frontendUserPositionList', 2, '会员持仓列表', NULL, NULL, 1477837454, 1477837454),
('frontendUserRebateList', 2, '返点记录列表', NULL, NULL, 1480586668, 1480586668),
('frontendUserSendCoupon', 2, '赠送优惠券', NULL, NULL, 1477837454, 1477837454),
('frontendUserUserExcel', 2, '用户信息导出', NULL, NULL, 1491814259, 1491814259),
('frontendUserVerifyManager', 2, '审核经纪人', NULL, NULL, 1477921692, 1477921692),
('frontendUserVerifyWithdraw', 2, '会员出金操作', NULL, NULL, 1477837454, 1477837454),
('frontendUserWithdrawExcel', 2, '用户出金信息导出', NULL, NULL, 1491875833, 1491875833),
('frontendUserWithdrawList', 2, '会员出金管理', NULL, NULL, 1477837454, 1477837454),
('代理商管理', 1, 'frontend', NULL, NULL, 1480500162, 1513868370),
('后台管理员', 1, 'frontend', NULL, NULL, 1477837542, 1495249299),
('系统管理员', 1, 'frontend', NULL, NULL, 1472433243, 1481011370),
('综会管理', 1, 'frontend', NULL, NULL, 1495178027, 1545743624),
('超级管理员', 1, 'frontend', NULL, NULL, 1472448576, 1513910280);

-- --------------------------------------------------------

--
-- 表的结构 `auth_item_child`
--

CREATE TABLE `auth_item_child` (
  `parent` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `child` varchar(64) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `auth_item_child`
--

INSERT INTO `auth_item_child` (`parent`, `child`) VALUES
('超级管理员', 'frontendAdminAddPermission'),
('超级管理员', 'frontendAdminAjaxDeleteAdmin'),
('超级管理员', 'frontendAdminAjaxDeleteRole'),
('系统管理员', 'frontendAdminAjaxRoleInfo'),
('超级管理员', 'frontendAdminAjaxRoleInfo'),
('超级管理员', 'frontendAdminAjaxUpdatePermission'),
('系统管理员', 'frontendAdminCreateRole'),
('超级管理员', 'frontendAdminCreateRole'),
('后台管理员', 'frontendAdminEditPoint'),
('超级管理员', 'frontendAdminEditPoint'),
('系统管理员', 'frontendAdminEditRole'),
('超级管理员', 'frontendAdminEditRole'),
('后台管理员', 'frontendAdminLeaderList'),
('超级管理员', 'frontendAdminLeaderList'),
('超级管理员', 'frontendAdminList'),
('超级管理员', 'frontendAdminPermissionList'),
('超级管理员', 'frontendAdminRoleList'),
('超级管理员', 'frontendAdminSaveAdmin'),
('后台管理员', 'frontendAdminSaveLeader'),
('超级管理员', 'frontendAdminSaveLeader'),
('超级管理员', 'frontendArticleDeleteArticle'),
('超级管理员', 'frontendArticleList'),
('超级管理员', 'frontendArticleSaveArticle'),
('超级管理员', 'frontendCouponCreateCoupon'),
('超级管理员', 'frontendCouponList'),
('超级管理员', 'frontendCouponOwnerList'),
('代理商管理', 'frontendOrderList'),
('后台管理员', 'frontendOrderList'),
('综会管理', 'frontendOrderList'),
('超级管理员', 'frontendOrderList'),
('后台管理员', 'frontendOrderOrderExcel'),
('超级管理员', 'frontendOrderOrderExcel'),
('超级管理员', 'frontendOrderSellOrder'),
('超级管理员', 'frontendProductAddProduct'),
('超级管理员', 'frontendProductAddStock'),
('后台管理员', 'frontendProductAjaxAllDown'),
('超级管理员', 'frontendProductAjaxAllDown'),
('后台管理员', 'frontendProductAjaxAllUp'),
('超级管理员', 'frontendProductAjaxAllUp'),
('后台管理员', 'frontendProductDeletePrice'),
('超级管理员', 'frontendProductDeletePrice'),
('超级管理员', 'frontendProductEditPoint'),
('超级管理员', 'frontendProductFloatList'),
('后台管理员', 'frontendProductList'),
('超级管理员', 'frontendProductList'),
('后台管理员', 'frontendProductSetTradePrice'),
('超级管理员', 'frontendProductSetTradePrice'),
('后台管理员', 'frontendProductSetTradeTime'),
('超级管理员', 'frontendProductSetTradeTime'),
('超级管理员', 'frontendProductUpdateProduct'),
('超级管理员', 'frontendRecordAddRingWechat'),
('后台管理员', 'frontendRecordDepositList'),
('综会管理', 'frontendRecordDepositList'),
('超级管理员', 'frontendRecordDepositList'),
('超级管理员', 'frontendRecordDepositRecord'),
('超级管理员', 'frontendRecordFeeRecord'),
('超级管理员', 'frontendRecordNewsWechat'),
('超级管理员', 'frontendRecordRingWechatList'),
('超级管理员', 'frontendRecordSaveNewsWechat'),
('超级管理员', 'frontendRecordSendMessage'),
('后台管理员', 'frontendRetailEditPoint'),
('综会管理', 'frontendRetailEditPoint'),
('超级管理员', 'frontendRetailEditPoint'),
('代理商管理', 'frontendRetailExuserWithdrawList'),
('综会管理', 'frontendRetailExuserWithdrawList'),
('超级管理员', 'frontendRetailExuserWithdrawList'),
('后台管理员', 'frontendRetailList'),
('综会管理', 'frontendRetailList'),
('超级管理员', 'frontendRetailList'),
('后台管理员', 'frontendRetailSaveRetail'),
('综会管理', 'frontendRetailSaveRetail'),
('超级管理员', 'frontendRetailSaveRetail'),
('代理商管理', 'frontendRetailSaveWithdraw'),
('综会管理', 'frontendRetailSaveWithdraw'),
('超级管理员', 'frontendRetailSaveWithdraw'),
('代理商管理', 'frontendRetailVerifyExWithdraw'),
('综会管理', 'frontendRetailVerifyExWithdraw'),
('超级管理员', 'frontendRetailVerifyExWithdraw'),
('超级管理员', 'frontendRetailVerifyWithdraw'),
('超级管理员', 'frontendRetailWithdrawList'),
('后台管理员', 'frontendRiskCenter'),
('超级管理员', 'frontendRiskCenter'),
('代理商管理', 'frontendSaleEditPoint'),
('后台管理员', 'frontendSaleEditPoint'),
('系统管理员', 'frontendSaleEditPoint'),
('综会管理', 'frontendSaleEditPoint'),
('超级管理员', 'frontendSaleEditPoint'),
('代理商管理', 'frontendSaleManagerList'),
('后台管理员', 'frontendSaleManagerList'),
('系统管理员', 'frontendSaleManagerList'),
('综会管理', 'frontendSaleManagerList'),
('超级管理员', 'frontendSaleManagerList'),
('后台管理员', 'frontendSaleManagerRebateList'),
('系统管理员', 'frontendSaleManagerRebateList'),
('综会管理', 'frontendSaleManagerRebateList'),
('超级管理员', 'frontendSaleManagerRebateList'),
('超级管理员', 'frontendSystemAddSetting'),
('超级管理员', 'frontendSystemDeleteSetting'),
('超级管理员', 'frontendSystemDestroy'),
('超级管理员', 'frontendSystemLogDetail'),
('超级管理员', 'frontendSystemLogList'),
('超级管理员', 'frontendSystemMenu'),
('系统管理员', 'frontendSystemSaveSetting'),
('超级管理员', 'frontendSystemSaveSetting'),
('系统管理员', 'frontendSystemSetting'),
('超级管理员', 'frontendSystemSetting'),
('后台管理员', 'frontendUserChargeExcel'),
('超级管理员', 'frontendUserChargeExcel'),
('代理商管理', 'frontendUserChargeRecordList'),
('后台管理员', 'frontendUserChargeRecordList'),
('综会管理', 'frontendUserChargeRecordList'),
('超级管理员', 'frontendUserChargeRecordList'),
('超级管理员', 'frontendUserDeleteAll'),
('代理商管理', 'frontendUserDeleteUser'),
('后台管理员', 'frontendUserDeleteUser'),
('综会管理', 'frontendUserDeleteUser'),
('超级管理员', 'frontendUserDeleteUser'),
('代理商管理', 'frontendUserEditUserPass'),
('后台管理员', 'frontendUserEditUserPass'),
('综会管理', 'frontendUserEditUserPass'),
('超级管理员', 'frontendUserEditUserPass'),
('后台管理员', 'frontendUserGiveList'),
('超级管理员', 'frontendUserGiveList'),
('代理商管理', 'frontendUserList'),
('后台管理员', 'frontendUserList'),
('综会管理', 'frontendUserList'),
('超级管理员', 'frontendUserList'),
('超级管理员', 'frontendUserMoveUser'),
('代理商管理', 'frontendUserPositionList'),
('后台管理员', 'frontendUserPositionList'),
('综会管理', 'frontendUserPositionList'),
('超级管理员', 'frontendUserPositionList'),
('后台管理员', 'frontendUserRebateList'),
('系统管理员', 'frontendUserRebateList'),
('综会管理', 'frontendUserRebateList'),
('超级管理员', 'frontendUserRebateList'),
('超级管理员', 'frontendUserSendCoupon'),
('后台管理员', 'frontendUserUserExcel'),
('超级管理员', 'frontendUserUserExcel'),
('代理商管理', 'frontendUserVerifyManager'),
('后台管理员', 'frontendUserVerifyManager'),
('综会管理', 'frontendUserVerifyManager'),
('超级管理员', 'frontendUserVerifyManager'),
('后台管理员', 'frontendUserVerifyWithdraw'),
('超级管理员', 'frontendUserVerifyWithdraw'),
('后台管理员', 'frontendUserWithdrawExcel'),
('超级管理员', 'frontendUserWithdrawExcel'),
('后台管理员', 'frontendUserWithdrawList'),
('超级管理员', 'frontendUserWithdrawList');

-- --------------------------------------------------------

--
-- 表的结构 `auth_rule`
--

CREATE TABLE `auth_rule` (
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `data` text COLLATE utf8_unicode_ci,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `bank_card`
--

CREATE TABLE `bank_card` (
  `id` int(11) NOT NULL,
  `bank_name` varchar(10) DEFAULT NULL COMMENT '银行名称',
  `bank_card` varchar(255) DEFAULT NULL COMMENT '银行卡号',
  `bank_user` varchar(10) DEFAULT NULL COMMENT '持卡人',
  `bank_mobile` varchar(12) DEFAULT NULL COMMENT '预留手机',
  `user_id` bigint(20) DEFAULT NULL COMMENT '会员id',
  `id_card` varchar(255) DEFAULT NULL COMMENT '身份证号码'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户绑定银行卡表';

--
-- 转存表中的数据 `bank_card`
--

INSERT INTO `bank_card` (`id`, `bank_name`, `bank_card`, `bank_user`, `bank_mobile`, `user_id`, `id_card`) VALUES
(4, '招商银行', '6214837105209856', '陈爱文', '18062816492', 100234, '420621198601121932'),
(5, '交通银行', '6222620640009234078', '蒋琴', '15174442750', 100277, '430821199608273426'),
(6, '建设银行', '6227007201590215307', '付子敬', '13397677535', 100269, '430426198602215132'),
(7, '建设银行', '6227007201590215307', '付子敬', '13397677535', 100288, '430426198602215132'),
(8, '建设银行', '6217002430007027031', '武殿花', '15670633552', 100284, '410325198509202526'),
(9, '招商银行', '6214832305064748', '赵维微', '15228261420', 100290, '510522199704151947'),
(10, '123', '1234567890123', '1', '12345678901', 100258, '123456789013246789'),
(11, '中国建设银行', '6236682920012879878', '周思寒', '15574993965', 100292, '43012419980514961x');

-- --------------------------------------------------------

--
-- 表的结构 `coupon`
--

CREATE TABLE `coupon` (
  `id` int(11) NOT NULL,
  `desc` varchar(50) NOT NULL COMMENT '描述',
  `remark` text COMMENT '备注信息',
  `amount` decimal(11,2) NOT NULL COMMENT '额度',
  `coupon_type` int(11) DEFAULT '0' COMMENT '优惠劵类型',
  `valid_day` int(11) NOT NULL COMMENT '有效时间（天）'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='优惠券表';

--
-- 转存表中的数据 `coupon`
--

INSERT INTO `coupon` (`id`, `desc`, `remark`, `amount`, `coupon_type`, `valid_day`) VALUES
(1, '系统赠送的100元体验券', '系统赠送的100元体验券', '100.00', 22, 1),
(2, '系统赠送的100元体验券', '系统赠送的100元体验券', '100.00', 1, 7);

-- --------------------------------------------------------

--
-- 表的结构 `data_all`
--

CREATE TABLE `data_all` (
  `name` varchar(20) NOT NULL COMMENT '产品名称',
  `price` varchar(20) DEFAULT '' COMMENT '当前价格',
  `time` datetime DEFAULT NULL COMMENT '当前时间',
  `diff` decimal(11,2) DEFAULT '0.00' COMMENT '涨跌值',
  `diff_rate` varchar(20) DEFAULT '0.00' COMMENT '涨跌%',
  `open` decimal(11,2) DEFAULT NULL,
  `high` decimal(11,2) DEFAULT NULL,
  `low` decimal(11,2) DEFAULT NULL,
  `close` decimal(11,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='所有产品数据汇总表';

--
-- 转存表中的数据 `data_all`
--

INSERT INTO `data_all` (`name`, `price`, `time`, `diff`, `diff_rate`, `open`, `high`, `low`, `close`) VALUES
('ay', '22923', '2019-01-02 18:54:53', '-397.00', '-1.7', '23320.00', '23417.00', '22786.00', '23320.00'),
('cedaxa0', '10526', '2019-01-02 18:54:53', '-47.00', '-0.44', '10669.50', '10707.00', '10378.50', '10573.00'),
('cl', '48.45', '2016-10-31 19:18:04', '-0.28', '0.00', NULL, NULL, NULL, NULL),
('cmgca0', '1348.2', '2019-02-20 11:21:54', '3.40', '0.2528', '1343.80', '1349.80', '1342.40', '1344.80'),
('cmhga0', '6211.00', '2018-11-06 22:34:02', '20.00', '0.3230', '6182.00', '6215.00', '6154.00', '6191.00'),
('cmsia0', '14.303', '2018-11-21 10:36:47', '-0.01', '-0.0824', '14.33', '14.35', '14.28', '14.32'),
('conc', '5358', '2017-04-12 10:07:34', '0.18', '0.34%', '5339.00', '5360.00', '5335.00', '5358.00'),
('cu1610', '36580.00', '2016-09-02 13:54:33', '130.00', '0.00', NULL, NULL, NULL, NULL),
('gc', '1.14255', '2018-11-06 22:34:02', '0.00', '0.13', '1.14', '1.14', '1.14', '1.14'),
('hihsif', '28450.00', '2019-02-20 11:21:54', '295.00', '1.0478', '28145.00', '28573.00', '28038.00', '28155.00'),
('himhif', '28450.00', '2019-02-20 11:21:54', '295.00', '1.0478', '28145.00', '28573.00', '28038.00', '28155.00'),
('hsi', '30548.781', '2018-06-01 16:08:00', '4.00', '1.00', '30548.78', '30581.12', '30363.49', '30468.56'),
('if1609', '3319.20', '2016-10-21 15:00:15', '1.80', '0.00', NULL, NULL, NULL, NULL),
('longyanxiang', '1246.7', '2017-12-12 02:53:52', '-1.70', '-0.1362', '1249.20', '1253.40', '1246.00', '1248.40'),
('necla0', '56.39', '2019-02-20 11:21:36', '0.30', '0.5349', '55.94', '56.39', '55.82', '56.09'),
('nenga0', '2.651', '2019-02-20 11:20:44', '-0.01', '-0.4132', '2.66', '2.66', '2.65', '2.66'),
('ng', '30997.98', '2018-06-04 16:08:00', '505.07', '1.66', '30836.77', '31012.92', '30743.18', '30492.91'),
('ni1609', '78450.00', '2016-09-02 13:54:30', '1360.00', '2.00', NULL, NULL, NULL, NULL),
('rm1609', '2329.00', '2016-09-02 13:54:33', '32.00', '1.00', NULL, NULL, NULL, NULL),
('ru1609', '10305.00', '2016-09-02 13:54:30', '190.00', '2.00', NULL, NULL, NULL, NULL),
('sgpmudi', '96.2256', '2018-11-06 22:34:29', '-0.12', '-0.13', '96.36', '96.45', '96.23', '96.35'),
('sh000001', '3385.9434', '2017-11-17 10:43:34', '-13.31', '-0.39', '3392.68', '3403.29', '3373.46', '3399.25'),
('sh601001', '5.830', '2017-11-17 10:43:36', '-0.17', '-2.83', '5.99', '6.04', '5.77', '6.00'),
('sz399001', '11460.643', '2017-11-17 10:43:42', '-77.31', '-0.67', '11519.92', '11555.87', '11417.31', '11537.96'),
('wgcna0', '11896.50', '2019-02-20 11:21:44', '71.50', '0.6000', '11825.00', '11961.50', '11881.50', '11825.00'),
('xag', '177.58', '2016-10-26 18:11:45', '0.03', '0.00', NULL, NULL, NULL, NULL),
('xhn', '7500', '2016-12-22 11:39:59', '-0.14', '-0.19%', '7552.00', '7562.00', '7489.00', '7500.00'),
('xpt', '961.25', '2016-10-26 18:11:45', '-2.54', '0.00', NULL, NULL, NULL, NULL),
('yb', '6191.75', '2019-01-02 18:54:53', '-160.50', '-2.53', '6349.00', '6386.25', '6154.00', '6352.25');

-- --------------------------------------------------------

--
-- 表的结构 `data_ay`
--

CREATE TABLE `data_ay` (
  `id` int(11) NOT NULL,
  `price` varchar(30) DEFAULT NULL,
  `time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `data_cedaxa0`
--

CREATE TABLE `data_cedaxa0` (
  `id` int(11) NOT NULL,
  `price` varchar(30) DEFAULT NULL,
  `time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `data_cmgca0`
--

CREATE TABLE `data_cmgca0` (
  `id` int(11) NOT NULL,
  `price` varchar(30) DEFAULT NULL,
  `time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `data_cmgca0`
--

INSERT INTO `data_cmgca0` (`id`, `price`, `time`) VALUES
(859534, '1292.0', '2019-01-14 10:48:28'),
(859547, '1291.8', '2019-01-14 10:49:12'),
(859549, '1291.9', '2019-01-14 10:49:15'),
(859550, '1291.8', '2019-01-14 10:49:23'),
(859553, '1291.8', '2019-01-14 10:49:24'),
(859555, '1291.7', '2019-01-14 10:49:34'),
(859557, '1291.7', '2019-01-14 10:49:38'),
(859561, '1291.7', '2019-01-14 10:49:49'),
(859564, '1291.7', '2019-01-14 10:49:53'),
(859567, '1291.7', '2019-01-14 10:49:59'),
(859568, '1291.5', '2019-01-14 11:32:04'),
(859569, '1291.6', '2019-01-14 11:33:05'),
(859572, '1291.4', '2019-01-14 11:38:05'),
(859586, '1291.4', '2019-01-14 11:38:12'),
(859601, '1291.5', '2019-01-14 11:38:21'),
(859630, '1291.4', '2019-01-14 11:38:42'),
(859637, '1291.5', '2019-01-14 11:38:50'),
(859649, '1291.4', '2019-01-14 11:44:33'),
(859650, '1291.4', '2019-01-14 11:46:01'),
(859651, '1291.4', '2019-01-14 11:48:43'),
(859653, '1291.4', '2019-01-14 12:11:44'),
(859706, '1291.5', '2019-01-14 12:13:10'),
(859712, '1291.4', '2019-01-14 12:13:16'),
(859723, '1291.4', '2019-01-14 12:13:26'),
(859735, '1291.3', '2019-01-14 12:13:36'),
(859758, '1291.3', '2019-01-14 12:14:03'),
(859770, '1291.3', '2019-01-14 12:14:15'),
(859792, '1291.3', '2019-01-14 12:14:34'),
(859840, '1291.4', '2019-01-14 12:15:25'),
(859852, '1291.3', '2019-01-14 12:15:34'),
(859917, '1291.4', '2019-01-14 12:16:40'),
(859982, '1291.3', '2019-01-14 12:17:46'),
(859988, '1291.4', '2019-01-14 12:17:58'),
(860011, '1291.3', '2019-01-14 12:18:13'),
(860017, '1291.4', '2019-01-14 12:18:19'),
(860042, '1291.3', '2019-01-14 12:18:48'),
(860076, '1291.4', '2019-01-14 12:19:20'),
(860088, '1291.3', '2019-01-14 12:19:32'),
(860094, '1291.4', '2019-01-14 12:19:35'),
(860102, '1291.4', '2019-01-14 12:19:47'),
(860113, '1291.4', '2019-01-14 12:19:59'),
(860153, '1291.3', '2019-01-14 12:20:36'),
(860167, '1291.4', '2019-01-14 12:20:55'),
(860173, '1291.3', '2019-01-14 12:21:01'),
(860199, '1291.3', '2019-01-14 12:21:27'),
(860205, '1291.3', '2019-01-14 12:21:29'),
(860209, '1291.3', '2019-01-14 12:21:34'),
(860215, '1291.4', '2019-01-14 12:21:43'),
(860231, '1291.3', '2019-01-14 12:22:00'),
(860273, '1291.4', '2019-01-14 12:22:42'),
(860323, '1291.3', '2019-01-14 12:23:32'),
(860333, '1291.3', '2019-01-14 12:23:35'),
(860334, '1291.3', '2019-01-14 12:23:43'),
(860350, '1291.2', '2019-01-14 12:24:02'),
(860370, '1291.3', '2019-01-14 12:24:20'),
(860380, '1291.3', '2019-01-14 12:24:30'),
(860431, '1291.2', '2019-01-14 12:25:20'),
(860462, '1291.3', '2019-01-14 12:25:52'),
(860465, '1291.2', '2019-01-14 12:25:54'),
(860515, '1291.3', '2019-01-14 12:26:41'),
(860523, '1291.3', '2019-01-14 12:26:51'),
(860554, '1291.4', '2019-01-14 12:27:20'),
(860679, '1291.4', '2019-01-14 12:29:38'),
(860703, '1291.3', '2019-01-14 12:29:59'),
(860710, '1291.4', '2019-01-14 12:30:06'),
(860716, '1291.3', '2019-01-14 12:30:12'),
(860723, '1291.3', '2019-01-14 12:30:13'),
(860758, '1291.3', '2019-01-14 12:30:56'),
(860773, '1291.2', '2019-01-14 12:31:11'),
(860793, '1291.1', '2019-01-14 12:31:31'),
(860838, '1291.2', '2019-01-14 12:32:13'),
(860856, '1291.1', '2019-01-14 12:32:24'),
(860860, '1291.0', '2019-01-14 12:32:29'),
(860878, '1291.1', '2019-01-14 12:32:45'),
(860883, '1291.0', '2019-01-14 12:32:52'),
(860886, '1291.1', '2019-01-14 12:32:58'),
(860909, '1291.0', '2019-01-14 12:33:16'),
(860952, '1291.1', '2019-01-14 12:34:03'),
(860986, '1291.0', '2019-01-14 12:34:33'),
(861012, '1290.9', '2019-01-14 12:35:00'),
(861018, '1290.8', '2019-01-14 12:35:05'),
(861024, '1290.9', '2019-01-14 12:35:11'),
(861028, '1290.9', '2019-01-14 12:35:18'),
(861034, '1290.8', '2019-01-14 12:35:20'),
(861062, '1291.0', '2019-01-14 12:35:52'),
(861067, '1290.9', '2019-01-14 12:35:58'),
(861085, '1291.0', '2019-01-14 12:36:18'),
(861120, '1290.8', '2019-01-14 12:36:52'),
(861129, '1290.9', '2019-01-14 12:37:02'),
(861174, '1290.9', '2019-01-14 12:37:40'),
(861178, '1290.8', '2019-01-14 12:37:44'),
(861186, '1290.9', '2019-01-14 12:37:57'),
(861192, '1290.8', '2019-01-14 12:38:03'),
(861202, '1290.9', '2019-01-14 12:38:10'),
(861214, '1348.7', '2019-02-20 10:23:53'),
(861222, '1348.6', '2019-02-20 10:24:02'),
(861230, '1348.7', '2019-02-20 10:24:05'),
(861246, '1348.7', '2019-02-20 10:24:17'),
(861280, '1348.8', '2019-02-20 10:24:36'),
(861296, '1348.9', '2019-02-20 10:24:46'),
(861304, '1348.8', '2019-02-20 10:24:50'),
(861314, '1348.9', '2019-02-20 10:24:58'),
(861325, '1348.7', '2019-02-20 10:25:00'),
(861339, '1348.6', '2019-02-20 10:25:06'),
(861348, '1348.6', '2019-02-20 10:25:09'),
(861351, '1348.7', '2019-02-20 10:25:14'),
(861368, '1348.7', '2019-02-20 10:25:33'),
(861411, '1348.7', '2019-02-20 10:26:15'),
(861415, '1348.6', '2019-02-20 10:26:23'),
(861428, '1348.6', '2019-02-20 10:26:35'),
(861436, '1348.5', '2019-02-20 10:26:43'),
(861471, '1348.6', '2019-02-20 10:27:13'),
(861475, '1348.6', '2019-02-20 10:27:21'),
(861487, '1348.7', '2019-02-20 10:27:36'),
(861496, '1348.5', '2019-02-20 10:27:46'),
(861500, '1348.5', '2019-02-20 10:27:51'),
(861504, '1348.6', '2019-02-20 10:27:56'),
(861508, '1348.6', '2019-02-20 10:28:01'),
(861514, '1348.8', '2019-02-20 10:28:53'),
(861515, '1348.8', '2019-02-20 10:28:56'),
(861524, '1348.9', '2019-02-20 10:29:09'),
(861528, '1348.8', '2019-02-20 10:29:13'),
(861532, '1348.8', '2019-02-20 10:29:19'),
(861537, '1348.9', '2019-02-20 10:29:21'),
(861549, '1348.9', '2019-02-20 10:29:35'),
(861553, '1349.0', '2019-02-20 10:29:43'),
(861562, '1348.9', '2019-02-20 10:29:53'),
(861568, '1348.8', '2019-02-20 10:29:56'),
(861583, '1348.9', '2019-02-20 10:30:07'),
(861588, '1348.8', '2019-02-20 10:30:14'),
(861597, '1348.9', '2019-02-20 10:30:20'),
(861605, '1348.9', '2019-02-20 10:30:33'),
(861609, '1348.9', '2019-02-20 10:30:36'),
(861617, '1348.8', '2019-02-20 10:30:46'),
(861634, '1348.9', '2019-02-20 10:31:03'),
(861642, '1349.0', '2019-02-20 10:31:06'),
(861648, '1349.1', '2019-02-20 10:31:13'),
(861652, '1349.0', '2019-02-20 10:31:18'),
(861656, '1348.8', '2019-02-20 10:31:23'),
(861660, '1348.8', '2019-02-20 10:31:27'),
(861664, '1348.7', '2019-02-20 10:31:32'),
(861670, '1348.8', '2019-02-20 10:31:34'),
(861672, '1348.7', '2019-02-20 10:31:43'),
(861682, '1348.7', '2019-02-20 10:31:54'),
(861686, '1348.8', '2019-02-20 10:31:56'),
(861696, '1348.7', '2019-02-20 10:32:02'),
(861708, '1348.7', '2019-02-20 10:32:04'),
(861717, '1348.8', '2019-02-20 10:32:12'),
(861725, '1348.8', '2019-02-20 10:32:17'),
(861743, '1348.8', '2019-02-20 10:32:28'),
(861768, '1348.7', '2019-02-20 10:32:39'),
(861785, '1348.6', '2019-02-20 10:32:49'),
(861795, '1348.7', '2019-02-20 10:32:59'),
(861805, '1348.7', '2019-02-20 10:33:03'),
(861819, '1348.7', '2019-02-20 10:33:04'),
(861828, '1348.8', '2019-02-20 10:33:13'),
(861837, '1348.9', '2019-02-20 10:33:24'),
(861842, '1348.9', '2019-02-20 10:33:28'),
(861857, '1348.9', '2019-02-20 10:33:48'),
(861863, '1348.9', '2019-02-20 10:33:53'),
(861875, '1348.8', '2019-02-20 10:34:04'),
(861892, '1348.7', '2019-02-20 10:34:15'),
(861904, '1348.7', '2019-02-20 10:34:34'),
(861909, '1348.5', '2019-02-20 10:34:38'),
(861913, '1348.6', '2019-02-20 10:34:40'),
(861922, '1348.5', '2019-02-20 10:34:50'),
(861943, '1348.6', '2019-02-20 10:35:05'),
(861948, '1348.7', '2019-02-20 10:35:12'),
(861953, '1348.6', '2019-02-20 10:35:19'),
(861957, '1348.7', '2019-02-20 10:35:22'),
(861961, '1348.8', '2019-02-20 10:35:27'),
(861977, '1348.5', '2019-02-20 10:35:47'),
(861982, '1348.6', '2019-02-20 10:35:53'),
(861987, '1348.6', '2019-02-20 10:35:55'),
(861995, '1348.8', '2019-02-20 10:36:04'),
(862008, '1348.8', '2019-02-20 10:36:11'),
(862017, '1348.7', '2019-02-20 10:36:20'),
(862020, '1348.8', '2019-02-20 10:36:29'),
(862024, '1348.7', '2019-02-20 10:36:34'),
(862029, '1348.8', '2019-02-20 10:36:35'),
(862033, '1348.7', '2019-02-20 10:36:41'),
(862037, '1348.8', '2019-02-20 10:36:49'),
(862042, '1348.8', '2019-02-20 10:36:54'),
(862047, '1348.8', '2019-02-20 10:36:57'),
(862068, '1348.8', '2019-02-20 10:37:11'),
(862072, '1348.8', '2019-02-20 10:37:16'),
(862085, '1348.7', '2019-02-20 10:37:31'),
(862089, '1348.7', '2019-02-20 10:37:39'),
(862093, '1348.7', '2019-02-20 10:37:41'),
(862123, '1348.7', '2019-02-20 10:38:05'),
(862148, '1348.8', '2019-02-20 10:38:39'),
(862152, '1349.0', '2019-02-20 10:41:59'),
(862155, '1348.9', '2019-02-20 10:42:01'),
(862159, '1349.0', '2019-02-20 10:42:10'),
(862163, '1348.9', '2019-02-20 10:42:11'),
(862173, '1349.0', '2019-02-20 10:42:20'),
(862176, '1348.9', '2019-02-20 10:42:28'),
(862180, '1349.0', '2019-02-20 10:42:30'),
(862184, '1349.0', '2019-02-20 10:42:38'),
(862188, '1349.1', '2019-02-20 10:42:44'),
(862219, '1349.0', '2019-02-20 10:43:05'),
(862223, '1349.1', '2019-02-20 10:43:10'),
(862228, '1349.1', '2019-02-20 10:43:16'),
(862232, '1349.2', '2019-02-20 10:43:23'),
(862236, '1349.2', '2019-02-20 10:43:26'),
(862240, '1349.4', '2019-02-20 10:43:33'),
(862244, '1349.5', '2019-02-20 10:43:38'),
(862249, '1349.5', '2019-02-20 10:43:41'),
(862252, '1349.5', '2019-02-20 10:43:46'),
(862257, '1349.5', '2019-02-20 10:43:54'),
(862263, '1349.6', '2019-02-20 10:43:59'),
(862271, '1349.5', '2019-02-20 10:44:03'),
(862279, '1349.4', '2019-02-20 10:44:08'),
(862287, '1349.5', '2019-02-20 10:44:18'),
(862295, '1349.4', '2019-02-20 10:44:29'),
(862300, '1349.4', '2019-02-20 10:44:31'),
(862304, '1349.4', '2019-02-20 10:44:38'),
(862308, '1349.4', '2019-02-20 10:44:40'),
(862312, '1349.3', '2019-02-20 10:44:49'),
(862317, '1349.4', '2019-02-20 10:44:52'),
(862323, '1349.5', '2019-02-20 10:44:59'),
(862331, '1349.6', '2019-02-20 10:45:02'),
(862339, '1349.6', '2019-02-20 10:45:09'),
(862343, '1349.5', '2019-02-20 10:45:14'),
(862347, '1349.5', '2019-02-20 10:45:18'),
(862352, '1349.5', '2019-02-20 10:45:20'),
(862368, '1349.4', '2019-02-20 10:45:41'),
(862372, '1349.5', '2019-02-20 10:45:45'),
(862377, '1349.5', '2019-02-20 10:45:53'),
(862381, '1349.4', '2019-02-20 10:45:58'),
(862391, '1349.4', '2019-02-20 10:46:04'),
(862399, '1349.5', '2019-02-20 10:46:05'),
(862404, '1349.4', '2019-02-20 10:46:14'),
(862407, '1349.4', '2019-02-20 10:46:18'),
(862412, '1349.4', '2019-02-20 10:46:22'),
(862416, '1349.3', '2019-02-20 10:46:28'),
(862419, '1349.3', '2019-02-20 10:46:33'),
(862424, '1349.4', '2019-02-20 10:46:39'),
(862432, '1349.3', '2019-02-20 10:46:47'),
(862437, '1349.3', '2019-02-20 10:46:54'),
(862449, '1349.3', '2019-02-20 10:47:01'),
(862459, '1349.4', '2019-02-20 10:47:04'),
(862463, '1349.3', '2019-02-20 10:47:11'),
(862467, '1349.4', '2019-02-20 10:47:18'),
(862472, '1349.4', '2019-02-20 10:47:23'),
(862475, '1349.4', '2019-02-20 10:47:27'),
(862479, '1349.3', '2019-02-20 10:47:32'),
(862497, '1349.4', '2019-02-20 10:47:53'),
(862510, '1349.4', '2019-02-20 10:48:04'),
(862518, '1349.4', '2019-02-20 10:48:07'),
(862527, '1349.5', '2019-02-20 10:48:18'),
(862532, '1349.4', '2019-02-20 10:48:24'),
(862536, '1349.5', '2019-02-20 10:48:26'),
(862545, '1349.5', '2019-02-20 10:48:36'),
(862549, '1349.6', '2019-02-20 10:48:43'),
(862553, '1349.7', '2019-02-20 10:48:45'),
(862562, '1349.6', '2019-02-20 10:48:59'),
(862570, '1349.7', '2019-02-20 10:49:02'),
(862579, '1349.7', '2019-02-20 10:49:09'),
(862587, '1349.7', '2019-02-20 10:49:19'),
(862595, '1349.7', '2019-02-20 10:49:27'),
(862599, '1349.7', '2019-02-20 10:49:33'),
(862604, '1349.6', '2019-02-20 10:49:39'),
(862608, '1349.7', '2019-02-20 10:49:40'),
(862612, '1349.7', '2019-02-20 10:49:48'),
(862631, '1349.8', '2019-02-20 10:50:03'),
(862639, '1349.7', '2019-02-20 10:50:05'),
(862644, '1349.5', '2019-02-20 10:50:10'),
(862648, '1349.6', '2019-02-20 10:50:19'),
(862656, '1349.5', '2019-02-20 10:50:27'),
(862664, '1349.5', '2019-02-20 10:50:35'),
(862668, '1349.4', '2019-02-20 10:50:43'),
(862672, '1349.4', '2019-02-20 10:50:45'),
(862678, '1349.4', '2019-02-20 10:50:54'),
(862683, '1349.4', '2019-02-20 10:50:57'),
(862691, '1349.4', '2019-02-20 10:51:02'),
(862704, '1349.4', '2019-02-20 10:51:11'),
(862708, '1349.4', '2019-02-20 10:51:17'),
(862712, '1349.3', '2019-02-20 10:51:22'),
(862716, '1349.3', '2019-02-20 10:51:27'),
(862720, '1349.2', '2019-02-20 10:51:32'),
(862724, '1349.2', '2019-02-20 10:51:35'),
(862728, '1349.3', '2019-02-20 10:51:44'),
(862733, '1349.2', '2019-02-20 10:51:49'),
(862743, '1349.3', '2019-02-20 10:51:56'),
(862751, '1349.2', '2019-02-20 10:51:59'),
(862759, '1349.3', '2019-02-20 10:52:06'),
(862767, '1349.4', '2019-02-20 10:52:19'),
(862772, '1349.4', '2019-02-20 10:52:23'),
(862777, '1349.6', '2019-02-20 10:52:29'),
(862780, '1349.5', '2019-02-20 10:52:32'),
(862784, '1349.6', '2019-02-20 10:52:39'),
(862788, '1349.6', '2019-02-20 10:52:43'),
(862792, '1349.4', '2019-02-20 10:52:49'),
(862797, '1349.5', '2019-02-20 10:52:53'),
(862803, '1349.5', '2019-02-20 10:52:55'),
(862811, '1349.4', '2019-02-20 10:53:04'),
(862819, '1349.6', '2019-02-20 10:53:05'),
(862824, '1349.6', '2019-02-20 10:53:12'),
(862827, '1349.4', '2019-02-20 10:53:16'),
(862836, '1349.5', '2019-02-20 10:53:29'),
(862845, '1349.5', '2019-02-20 10:53:39'),
(862848, '1349.4', '2019-02-20 10:53:41'),
(862853, '1349.5', '2019-02-20 10:53:46'),
(862863, '1349.4', '2019-02-20 10:53:59'),
(862879, '1349.4', '2019-02-20 10:54:09'),
(862888, '1349.5', '2019-02-20 10:54:16'),
(862891, '1349.5', '2019-02-20 10:54:21'),
(862896, '1349.6', '2019-02-20 10:54:29'),
(862900, '1349.5', '2019-02-20 10:54:33'),
(862904, '1349.5', '2019-02-20 10:54:36'),
(862912, '1349.6', '2019-02-20 10:54:47'),
(862917, '1349.6', '2019-02-20 10:54:54'),
(862923, '1349.5', '2019-02-20 10:54:55'),
(862931, '1349.6', '2019-02-20 10:55:04'),
(862939, '1349.6', '2019-02-20 10:55:09'),
(862968, '1349.6', '2019-02-20 10:55:43'),
(862972, '1349.7', '2019-02-20 10:55:49'),
(862977, '1349.6', '2019-02-20 10:55:52'),
(863007, '1349.6', '2019-02-20 10:56:19'),
(863024, '1349.6', '2019-02-20 10:56:39'),
(863032, '1349.5', '2019-02-20 10:56:46'),
(863043, '1349.6', '2019-02-20 10:56:59'),
(863051, '1349.6', '2019-02-20 10:57:00'),
(863072, '1349.6', '2019-02-20 10:57:23'),
(863084, '1349.5', '2019-02-20 10:57:36'),
(863093, '1349.6', '2019-02-20 10:57:49'),
(863097, '1349.6', '2019-02-20 10:57:50'),
(863144, '1349.7', '2019-02-20 10:58:39'),
(863152, '1349.6', '2019-02-20 10:58:45'),
(863172, '1349.7', '2019-02-20 10:59:04'),
(863180, '1349.6', '2019-02-20 10:59:09'),
(863184, '1349.7', '2019-02-20 10:59:14'),
(863196, '1349.6', '2019-02-20 10:59:29'),
(863205, '1349.5', '2019-02-20 10:59:39'),
(863231, '1349.5', '2019-02-20 11:00:04'),
(863240, '1349.6', '2019-02-20 11:00:09'),
(863244, '1349.6', '2019-02-20 11:00:13'),
(863248, '1349.6', '2019-02-20 11:00:19'),
(863252, '1349.6', '2019-02-20 11:00:24'),
(863258, '1349.7', '2019-02-20 11:00:29'),
(863273, '1349.6', '2019-02-20 11:00:45'),
(863277, '1349.6', '2019-02-20 11:00:54'),
(863285, '1349.7', '2019-02-20 11:00:55'),
(863299, '1349.5', '2019-02-20 11:01:10'),
(863308, '1349.6', '2019-02-20 11:01:19'),
(863324, '1349.5', '2019-02-20 11:01:37'),
(863328, '1349.6', '2019-02-20 11:01:44'),
(863333, '1349.6', '2019-02-20 11:01:50'),
(863337, '1349.6', '2019-02-20 11:01:51'),
(863343, '1349.6', '2019-02-20 11:01:58'),
(863351, '1349.6', '2019-02-20 11:02:04'),
(863367, '1349.6', '2019-02-20 11:02:19'),
(863372, '1349.6', '2019-02-20 11:02:23'),
(863380, '1349.6', '2019-02-20 11:02:33'),
(863385, '1349.6', '2019-02-20 11:02:40'),
(863388, '1349.6', '2019-02-20 11:02:45'),
(863393, '1349.5', '2019-02-20 11:02:49'),
(863397, '1349.6', '2019-02-20 11:02:51'),
(863403, '1349.6', '2019-02-20 11:02:58'),
(863427, '1349.5', '2019-02-20 11:03:17'),
(863444, '1349.4', '2019-02-20 11:03:39'),
(863448, '1349.4', '2019-02-20 11:03:45'),
(863452, '1349.4', '2019-02-20 11:03:47'),
(863457, '1349.5', '2019-02-20 11:03:54'),
(863462, '1349.5', '2019-02-20 11:03:58'),
(863483, '1349.4', '2019-02-20 11:04:11'),
(863497, '1349.5', '2019-02-20 11:04:29'),
(863499, '1349.4', '2019-02-20 11:04:31'),
(863524, '1349.4', '2019-02-20 11:04:59'),
(863531, '1349.3', '2019-02-20 11:05:05'),
(863548, '1349.4', '2019-02-20 11:05:20'),
(863552, '1349.4', '2019-02-20 11:05:23'),
(863561, '1349.3', '2019-02-20 11:05:33'),
(863577, '1349.4', '2019-02-20 11:05:55'),
(863591, '1349.3', '2019-02-20 11:05:59'),
(863612, '1349.4', '2019-02-20 11:06:23'),
(863617, '1349.3', '2019-02-20 11:06:29'),
(863620, '1349.3', '2019-02-20 11:06:33'),
(863624, '1349.4', '2019-02-20 11:06:40'),
(863638, '1349.3', '2019-02-20 11:06:56'),
(863651, '1349.2', '2019-02-20 11:07:02'),
(863659, '1349.4', '2019-02-20 11:07:08'),
(863663, '1349.4', '2019-02-20 11:07:14'),
(863667, '1349.4', '2019-02-20 11:07:18'),
(863671, '1349.3', '2019-02-20 11:07:21'),
(863675, '1349.3', '2019-02-20 11:07:27'),
(863680, '1349.2', '2019-02-20 11:07:34'),
(863684, '1349.2', '2019-02-20 11:07:39'),
(863688, '1349.2', '2019-02-20 11:07:43'),
(863692, '1349.1', '2019-02-20 11:07:47'),
(863709, '1349.1', '2019-02-20 11:08:01'),
(863719, '1349.1', '2019-02-20 11:08:05'),
(863727, '1349.0', '2019-02-20 11:08:17'),
(863731, '1348.8', '2019-02-20 11:08:23'),
(863735, '1348.8', '2019-02-20 11:08:28'),
(863756, '1348.9', '2019-02-20 11:08:54'),
(863761, '1348.8', '2019-02-20 11:08:59'),
(863770, '1348.8', '2019-02-20 11:09:03'),
(863779, '1348.8', '2019-02-20 11:09:07'),
(863783, '1348.8', '2019-02-20 11:09:13'),
(863787, '1348.9', '2019-02-20 11:09:18'),
(863791, '1348.8', '2019-02-20 11:09:21'),
(863795, '1348.7', '2019-02-20 11:09:27'),
(863812, '1348.7', '2019-02-20 11:09:48'),
(863816, '1348.7', '2019-02-20 11:09:53'),
(863822, '1348.8', '2019-02-20 11:09:58'),
(863838, '1348.8', '2019-02-20 11:10:06'),
(863847, '1348.9', '2019-02-20 11:10:19'),
(863852, '1348.8', '2019-02-20 11:10:22'),
(863856, '1348.9', '2019-02-20 11:10:25'),
(863860, '1348.9', '2019-02-20 11:10:32'),
(863864, '1348.8', '2019-02-20 11:10:35'),
(863868, '1348.8', '2019-02-20 11:10:43'),
(863883, '1348.9', '2019-02-20 11:10:55'),
(863899, '1348.8', '2019-02-20 11:11:08'),
(863903, '1348.8', '2019-02-20 11:11:10'),
(863907, '1348.7', '2019-02-20 11:11:18'),
(863911, '1348.8', '2019-02-20 11:11:24'),
(863916, '1348.8', '2019-02-20 11:11:25'),
(863919, '1348.8', '2019-02-20 11:11:33'),
(863927, '1348.7', '2019-02-20 11:11:40'),
(863950, '1348.8', '2019-02-20 11:12:00'),
(863959, '1348.7', '2019-02-20 11:12:05'),
(863976, '1348.8', '2019-02-20 11:12:26'),
(863980, '1348.7', '2019-02-20 11:12:30'),
(863992, '1348.7', '2019-02-20 11:12:46'),
(863996, '1348.7', '2019-02-20 11:12:51'),
(864003, '1348.7', '2019-02-20 11:12:59'),
(864012, '1348.6', '2019-02-20 11:13:03'),
(864020, '1348.6', '2019-02-20 11:13:08'),
(864028, '1348.6', '2019-02-20 11:13:18'),
(864032, '1348.6', '2019-02-20 11:13:21'),
(864037, '1348.6', '2019-02-20 11:13:26'),
(864040, '1348.6', '2019-02-20 11:13:32'),
(864044, '1348.6', '2019-02-20 11:13:35'),
(864073, '1348.6', '2019-02-20 11:14:02'),
(864080, '1348.6', '2019-02-20 11:14:08'),
(864092, '1348.6', '2019-02-20 11:14:22'),
(864097, '1348.7', '2019-02-20 11:14:30'),
(864101, '1348.6', '2019-02-20 11:14:31'),
(864105, '1348.7', '2019-02-20 11:14:40'),
(864113, '1348.6', '2019-02-20 11:14:50'),
(864117, '1348.6', '2019-02-20 11:14:55'),
(864133, '1348.6', '2019-02-20 11:15:03'),
(864140, '1348.5', '2019-02-20 11:15:08'),
(864145, '1348.4', '2019-02-20 11:15:15'),
(864158, '1348.4', '2019-02-20 11:15:29'),
(864161, '1348.4', '2019-02-20 11:15:33'),
(864178, '1348.4', '2019-02-20 11:15:55'),
(864186, '1348.3', '2019-02-20 11:16:00'),
(864196, '1348.4', '2019-02-20 11:16:04'),
(864200, '1348.3', '2019-02-20 11:16:08'),
(864208, '1348.4', '2019-02-20 11:16:19'),
(864212, '1348.4', '2019-02-20 11:16:23'),
(864218, '1348.4', '2019-02-20 11:16:28'),
(864221, '1348.4', '2019-02-20 11:16:35'),
(864225, '1348.3', '2019-02-20 11:16:40'),
(864237, '1348.3', '2019-02-20 11:16:51'),
(864246, '1348.3', '2019-02-20 11:17:00'),
(864253, '1348.4', '2019-02-20 11:17:04'),
(864269, '1348.4', '2019-02-20 11:17:19'),
(864273, '1348.3', '2019-02-20 11:17:24'),
(864281, '1348.2', '2019-02-20 11:17:33'),
(864285, '1348.2', '2019-02-20 11:17:38'),
(864289, '1348.2', '2019-02-20 11:17:44'),
(864293, '1348.2', '2019-02-20 11:17:50'),
(864298, '1348.3', '2019-02-20 11:17:52'),
(864307, '1348.3', '2019-02-20 11:17:59'),
(864313, '1348.2', '2019-02-20 11:18:05'),
(864320, '1348.3', '2019-02-20 11:18:09'),
(864324, '1348.2', '2019-02-20 11:18:14'),
(864328, '1348.4', '2019-02-20 11:18:21'),
(864333, '1348.3', '2019-02-20 11:18:26'),
(864337, '1348.3', '2019-02-20 11:18:30'),
(864341, '1348.3', '2019-02-20 11:18:32'),
(864345, '1348.2', '2019-02-20 11:18:39'),
(864349, '1348.3', '2019-02-20 11:18:44'),
(864357, '1348.3', '2019-02-20 11:18:56'),
(864367, '1348.3', '2019-02-20 11:19:00'),
(864373, '1348.2', '2019-02-20 11:19:05'),
(864380, '1348.3', '2019-02-20 11:19:11'),
(864384, '1348.3', '2019-02-20 11:19:15'),
(864388, '1348.4', '2019-02-20 11:19:20'),
(864393, '1348.3', '2019-02-20 11:19:25'),
(864401, '1348.3', '2019-02-20 11:19:34'),
(864405, '1348.2', '2019-02-20 11:19:39'),
(864413, '1348.3', '2019-02-20 11:19:51'),
(864418, '1348.2', '2019-02-20 11:19:56'),
(864433, '1348.3', '2019-02-20 11:20:01'),
(864444, '1348.3', '2019-02-20 11:20:14'),
(864448, '1348.3', '2019-02-20 11:20:18'),
(864453, '1348.3', '2019-02-20 11:20:25'),
(864458, '1348.2', '2019-02-20 11:20:29'),
(864469, '1348.2', '2019-02-20 11:20:46'),
(864473, '1348.2', '2019-02-20 11:20:50'),
(864477, '1348.2', '2019-02-20 11:20:53'),
(864493, '1348.3', '2019-02-20 11:21:03'),
(864500, '1348.2', '2019-02-20 11:21:06'),
(864504, '1348.3', '2019-02-20 11:21:12'),
(864509, '1348.2', '2019-02-20 11:21:17'),
(864518, '1348.3', '2019-02-20 11:21:28'),
(864522, '1348.2', '2019-02-20 11:21:36'),
(864529, '1348.2', '2019-02-20 11:21:38'),
(864533, '1348.2', '2019-02-20 11:21:49'),
(864537, '1348.2', '2019-02-20 11:21:54');

-- --------------------------------------------------------

--
-- 表的结构 `data_cmhga0`
--

CREATE TABLE `data_cmhga0` (
  `id` int(11) NOT NULL,
  `price` varchar(30) DEFAULT NULL,
  `time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `data_cmsia0`
--

CREATE TABLE `data_cmsia0` (
  `id` int(11) NOT NULL,
  `price` varchar(30) DEFAULT NULL,
  `time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `data_gc`
--

CREATE TABLE `data_gc` (
  `id` int(11) NOT NULL,
  `price` varchar(30) DEFAULT NULL,
  `time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `data_hihsif`
--

CREATE TABLE `data_hihsif` (
  `id` int(11) NOT NULL,
  `price` varchar(30) DEFAULT NULL,
  `time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `data_hihsif`
--

INSERT INTO `data_hihsif` (`id`, `price`, `time`) VALUES
(473099, '26291.00', '2019-01-14 10:48:53'),
(473100, '26290.00', '2019-01-14 10:48:59'),
(473102, '26283.00', '2019-01-14 10:49:04'),
(473104, '26282.00', '2019-01-14 10:49:09'),
(473107, '26285.00', '2019-01-14 10:49:14'),
(473108, '26279.00', '2019-01-14 10:49:19'),
(473110, '26280.00', '2019-01-14 10:49:24'),
(473112, '26283.00', '2019-01-14 10:49:29'),
(473115, '26280.00', '2019-01-14 10:49:34'),
(473116, '26280.00', '2019-01-14 10:49:39'),
(473119, '26284.00', '2019-01-14 10:49:43'),
(473121, '26280.00', '2019-01-14 10:49:49'),
(473123, '26279.00', '2019-01-14 10:49:54'),
(473126, '26278.00', '2019-01-14 10:49:59'),
(473128, '26236.00', '2019-01-14 11:32:20'),
(473129, '26239.00', '2019-01-14 11:33:05'),
(473130, '26237.00', '2019-01-14 11:33:10'),
(473132, '26268.00', '2019-01-14 11:38:05'),
(473139, '26263.00', '2019-01-14 11:38:10'),
(473147, '26265.00', '2019-01-14 11:38:15'),
(473154, '26269.00', '2019-01-14 11:38:19'),
(473161, '26269.00', '2019-01-14 11:38:24'),
(473168, '26268.00', '2019-01-14 11:38:30'),
(473176, '26267.00', '2019-01-14 11:38:35'),
(473183, '26267.00', '2019-01-14 11:38:40'),
(473190, '26265.00', '2019-01-14 11:38:45'),
(473198, '26263.00', '2019-01-14 11:38:50'),
(473205, '26265.00', '2019-01-14 11:38:55'),
(473209, '26286.00', '2019-01-14 11:44:45'),
(473210, '26295.00', '2019-01-14 11:46:45'),
(473211, '26279.00', '2019-01-14 11:49:05'),
(473213, '26294.00', '2019-01-14 11:59:59'),
(474774, '28531.00', '2019-02-20 10:23:53'),
(474775, '28532.00', '2019-02-20 10:23:57'),
(474782, '28539.00', '2019-02-20 10:24:02'),
(474790, '28542.00', '2019-02-20 10:24:08'),
(474800, '28541.00', '2019-02-20 10:24:13'),
(474806, '28539.00', '2019-02-20 10:24:18'),
(474816, '28541.00', '2019-02-20 10:24:23'),
(474823, '28541.00', '2019-02-20 10:24:28'),
(474832, '28542.00', '2019-02-20 10:24:33'),
(474840, '28538.00', '2019-02-20 10:24:38'),
(474848, '28538.00', '2019-02-20 10:24:43'),
(474856, '28540.00', '2019-02-20 10:24:48'),
(474864, '28541.00', '2019-02-20 10:24:53'),
(474875, '28541.00', '2019-02-20 10:24:58'),
(474885, '28541.00', '2019-02-20 10:25:03'),
(474899, '28539.00', '2019-02-20 10:25:06'),
(474908, '28538.00', '2019-02-20 10:25:12'),
(474911, '28536.00', '2019-02-20 10:25:18'),
(474915, '28541.00', '2019-02-20 10:25:22'),
(474919, '28539.00', '2019-02-20 10:25:28'),
(474924, '28536.00', '2019-02-20 10:25:33'),
(474928, '28533.00', '2019-02-20 10:25:38'),
(474932, '28534.00', '2019-02-20 10:25:42'),
(474936, '28534.00', '2019-02-20 10:25:48'),
(474940, '28537.00', '2019-02-20 10:25:52'),
(474946, '28537.00', '2019-02-20 10:25:58'),
(474954, '28537.00', '2019-02-20 10:26:02'),
(474962, '28532.00', '2019-02-20 10:26:08'),
(474967, '28534.00', '2019-02-20 10:26:12'),
(474971, '28533.00', '2019-02-20 10:26:18'),
(474975, '28535.00', '2019-02-20 10:26:23'),
(474979, '28533.00', '2019-02-20 10:26:28'),
(474984, '28537.00', '2019-02-20 10:26:33'),
(474988, '28532.00', '2019-02-20 10:26:38'),
(474993, '28535.00', '2019-02-20 10:26:43'),
(474996, '28533.00', '2019-02-20 10:26:47'),
(475000, '28533.00', '2019-02-20 10:26:52'),
(475004, '28537.00', '2019-02-20 10:26:58'),
(475014, '28542.00', '2019-02-20 10:27:03'),
(475022, '28542.00', '2019-02-20 10:27:08'),
(475028, '28540.00', '2019-02-20 10:27:11'),
(475031, '28543.00', '2019-02-20 10:27:18'),
(475035, '28543.00', '2019-02-20 10:27:21'),
(475040, '28540.00', '2019-02-20 10:27:28'),
(475043, '28535.00', '2019-02-20 10:27:33'),
(475047, '28531.00', '2019-02-20 10:27:38'),
(475052, '28530.00', '2019-02-20 10:27:43'),
(475056, '28525.00', '2019-02-20 10:27:47'),
(475060, '28525.00', '2019-02-20 10:27:53'),
(475064, '28526.00', '2019-02-20 10:27:58'),
(475068, '28525.00', '2019-02-20 10:28:03'),
(475073, '28524.00', '2019-02-20 10:28:08'),
(475074, '28538.00', '2019-02-20 10:28:54'),
(475075, '28544.00', '2019-02-20 10:28:58'),
(475079, '28546.00', '2019-02-20 10:29:04'),
(475084, '28560.00', '2019-02-20 10:29:09'),
(475088, '28559.00', '2019-02-20 10:29:13'),
(475092, '28557.00', '2019-02-20 10:29:19'),
(475097, '28561.00', '2019-02-20 10:29:24'),
(475100, '28565.00', '2019-02-20 10:29:29'),
(475105, '28562.00', '2019-02-20 10:29:34'),
(475109, '28563.00', '2019-02-20 10:29:39'),
(475113, '28570.00', '2019-02-20 10:29:44'),
(475117, '28563.00', '2019-02-20 10:29:49'),
(475122, '28567.00', '2019-02-20 10:29:54'),
(475128, '28569.00', '2019-02-20 10:29:59'),
(475134, '28570.00', '2019-02-20 10:30:04'),
(475144, '28571.00', '2019-02-20 10:30:09'),
(475148, '28566.00', '2019-02-20 10:30:14'),
(475152, '28562.00', '2019-02-20 10:30:19'),
(475157, '28566.00', '2019-02-20 10:30:24'),
(475161, '28564.00', '2019-02-20 10:30:29'),
(475165, '28564.00', '2019-02-20 10:30:34'),
(475169, '28561.00', '2019-02-20 10:30:39'),
(475173, '28562.00', '2019-02-20 10:30:40'),
(475177, '28562.00', '2019-02-20 10:30:49'),
(475182, '28565.00', '2019-02-20 10:30:54'),
(475186, '28560.00', '2019-02-20 10:30:59'),
(475194, '28555.00', '2019-02-20 10:31:04'),
(475202, '28556.00', '2019-02-20 10:31:08'),
(475208, '28554.00', '2019-02-20 10:31:14'),
(475212, '28551.00', '2019-02-20 10:31:18'),
(475216, '28549.00', '2019-02-20 10:31:24'),
(475220, '28550.00', '2019-02-20 10:31:29'),
(475224, '28546.00', '2019-02-20 10:31:33'),
(475228, '28546.00', '2019-02-20 10:31:37'),
(475232, '28552.00', '2019-02-20 10:31:44'),
(475237, '28548.00', '2019-02-20 10:31:49'),
(475242, '28550.00', '2019-02-20 10:31:54'),
(475246, '28547.00', '2019-02-20 10:31:59'),
(475256, '28547.00', '2019-02-20 10:32:04'),
(475268, '28547.00', '2019-02-20 10:32:09'),
(475278, '28551.00', '2019-02-20 10:32:14'),
(475285, '28551.00', '2019-02-20 10:32:18'),
(475295, '28556.00', '2019-02-20 10:32:24'),
(475303, '28553.00', '2019-02-20 10:32:29'),
(475311, '28553.00', '2019-02-20 10:32:34'),
(475319, '28552.00', '2019-02-20 10:32:39'),
(475327, '28551.00', '2019-02-20 10:32:44'),
(475335, '28554.00', '2019-02-20 10:32:48'),
(475345, '28558.00', '2019-02-20 10:32:54'),
(475355, '28554.00', '2019-02-20 10:32:59'),
(475365, '28559.00', '2019-02-20 10:33:03'),
(475379, '28556.00', '2019-02-20 10:33:09'),
(475389, '28558.00', '2019-02-20 10:33:14'),
(475392, '28554.00', '2019-02-20 10:33:18'),
(475397, '28549.00', '2019-02-20 10:33:24'),
(475402, '28546.00', '2019-02-20 10:33:29'),
(475405, '28545.00', '2019-02-20 10:33:34'),
(475409, '28535.00', '2019-02-20 10:33:39'),
(475413, '28539.00', '2019-02-20 10:33:44'),
(475418, '28540.00', '2019-02-20 10:33:49'),
(475422, '28535.00', '2019-02-20 10:33:54'),
(475428, '28532.00', '2019-02-20 10:33:59'),
(475435, '28526.00', '2019-02-20 10:34:04'),
(475444, '28527.00', '2019-02-20 10:34:09'),
(475448, '28526.00', '2019-02-20 10:34:14'),
(475452, '28521.00', '2019-02-20 10:34:19'),
(475457, '28520.00', '2019-02-20 10:34:24'),
(475460, '28526.00', '2019-02-20 10:34:29'),
(475464, '28521.00', '2019-02-20 10:34:34'),
(475469, '28522.00', '2019-02-20 10:34:39'),
(475473, '28524.00', '2019-02-20 10:34:43'),
(475477, '28523.00', '2019-02-20 10:34:49'),
(475482, '28524.00', '2019-02-20 10:34:54'),
(475487, '28522.00', '2019-02-20 10:34:59'),
(475495, '28514.00', '2019-02-20 10:35:04'),
(475503, '28513.00', '2019-02-20 10:35:09'),
(475508, '28517.00', '2019-02-20 10:35:14'),
(475513, '28522.00', '2019-02-20 10:35:19'),
(475517, '28518.00', '2019-02-20 10:35:24'),
(475521, '28516.00', '2019-02-20 10:35:29'),
(475525, '28516.00', '2019-02-20 10:35:34'),
(475530, '28516.00', '2019-02-20 10:35:40'),
(475533, '28518.00', '2019-02-20 10:35:44'),
(475537, '28518.00', '2019-02-20 10:35:49'),
(475542, '28517.00', '2019-02-20 10:35:54'),
(475547, '28523.00', '2019-02-20 10:35:59'),
(475555, '28521.00', '2019-02-20 10:36:04'),
(475564, '28522.00', '2019-02-20 10:36:09'),
(475568, '28530.00', '2019-02-20 10:36:13'),
(475572, '28530.00', '2019-02-20 10:36:19'),
(475577, '28532.00', '2019-02-20 10:36:24'),
(475580, '28531.00', '2019-02-20 10:36:29'),
(475584, '28530.00', '2019-02-20 10:36:34'),
(475589, '28526.00', '2019-02-20 10:36:39'),
(475593, '28526.00', '2019-02-20 10:36:44'),
(475597, '28530.00', '2019-02-20 10:36:49'),
(475602, '28530.00', '2019-02-20 10:36:54'),
(475608, '28530.00', '2019-02-20 10:36:59'),
(475615, '28534.00', '2019-02-20 10:37:04'),
(475624, '28529.00', '2019-02-20 10:37:08'),
(475628, '28528.00', '2019-02-20 10:37:11'),
(475632, '28531.00', '2019-02-20 10:37:19'),
(475637, '28530.00', '2019-02-20 10:37:24'),
(475641, '28531.00', '2019-02-20 10:37:28'),
(475645, '28531.00', '2019-02-20 10:37:34'),
(475649, '28532.00', '2019-02-20 10:37:39'),
(475653, '28530.00', '2019-02-20 10:37:44'),
(475657, '28531.00', '2019-02-20 10:37:48'),
(475662, '28535.00', '2019-02-20 10:37:54'),
(475667, '28533.00', '2019-02-20 10:37:59'),
(475676, '28534.00', '2019-02-20 10:38:04'),
(475683, '28540.00', '2019-02-20 10:38:09'),
(475688, '28540.00', '2019-02-20 10:38:13'),
(475692, '28543.00', '2019-02-20 10:38:19'),
(475697, '28538.00', '2019-02-20 10:38:24'),
(475700, '28529.00', '2019-02-20 10:38:29'),
(475704, '28528.00', '2019-02-20 10:38:34'),
(475708, '28532.00', '2019-02-20 10:38:39'),
(475712, '28558.00', '2019-02-20 10:41:59'),
(475715, '28562.00', '2019-02-20 10:42:03'),
(475719, '28559.00', '2019-02-20 10:42:10'),
(475723, '28559.00', '2019-02-20 10:42:14'),
(475727, '28562.00', '2019-02-20 10:42:19'),
(475732, '28559.00', '2019-02-20 10:42:24'),
(475736, '28559.00', '2019-02-20 10:42:29'),
(475740, '28559.00', '2019-02-20 10:42:33'),
(475744, '28557.00', '2019-02-20 10:42:39'),
(475748, '28555.00', '2019-02-20 10:42:44'),
(475752, '28554.00', '2019-02-20 10:42:49'),
(475757, '28552.00', '2019-02-20 10:42:54'),
(475763, '28555.00', '2019-02-20 10:42:59'),
(475771, '28551.00', '2019-02-20 10:43:04'),
(475779, '28548.00', '2019-02-20 10:43:08'),
(475784, '28547.00', '2019-02-20 10:43:13'),
(475788, '28545.00', '2019-02-20 10:43:18'),
(475792, '28545.00', '2019-02-20 10:43:24'),
(475796, '28544.00', '2019-02-20 10:43:28'),
(475800, '28548.00', '2019-02-20 10:43:34'),
(475804, '28543.00', '2019-02-20 10:43:39'),
(475809, '28548.00', '2019-02-20 10:43:44'),
(475812, '28541.00', '2019-02-20 10:43:49'),
(475817, '28544.00', '2019-02-20 10:43:54'),
(475823, '28546.00', '2019-02-20 10:43:59'),
(475831, '28546.00', '2019-02-20 10:44:03'),
(475839, '28545.00', '2019-02-20 10:44:09'),
(475844, '28545.00', '2019-02-20 10:44:14'),
(475847, '28547.00', '2019-02-20 10:44:19'),
(475852, '28546.00', '2019-02-20 10:44:24'),
(475856, '28545.00', '2019-02-20 10:44:29'),
(475860, '28549.00', '2019-02-20 10:44:34'),
(475864, '28543.00', '2019-02-20 10:44:38'),
(475868, '28549.00', '2019-02-20 10:44:44'),
(475872, '28547.00', '2019-02-20 10:44:48'),
(475876, '28546.00', '2019-02-20 10:44:53'),
(475882, '28549.00', '2019-02-20 10:44:59'),
(475891, '28558.00', '2019-02-20 10:45:04'),
(475899, '28561.00', '2019-02-20 10:45:09'),
(475903, '28560.00', '2019-02-20 10:45:14'),
(475907, '28557.00', '2019-02-20 10:45:19'),
(475912, '28558.00', '2019-02-20 10:45:24'),
(475916, '28552.00', '2019-02-20 10:45:28'),
(475920, '28552.00', '2019-02-20 10:45:33'),
(475924, '28550.00', '2019-02-20 10:45:39'),
(475928, '28552.00', '2019-02-20 10:45:44'),
(475932, '28550.00', '2019-02-20 10:45:49'),
(475936, '28548.00', '2019-02-20 10:45:54'),
(475942, '28544.00', '2019-02-20 10:45:59'),
(475951, '28543.00', '2019-02-20 10:46:04'),
(475959, '28542.00', '2019-02-20 10:46:09'),
(475963, '28544.00', '2019-02-20 10:46:14'),
(475967, '28543.00', '2019-02-20 10:46:19'),
(475972, '28544.00', '2019-02-20 10:46:24'),
(475976, '28547.00', '2019-02-20 10:46:29'),
(475979, '28548.00', '2019-02-20 10:46:34'),
(475984, '28546.00', '2019-02-20 10:46:39'),
(475988, '28549.00', '2019-02-20 10:46:44'),
(475992, '28550.00', '2019-02-20 10:46:49'),
(475997, '28541.00', '2019-02-20 10:46:54'),
(476001, '28537.00', '2019-02-20 10:46:59'),
(476009, '28538.00', '2019-02-20 10:47:03'),
(476019, '28536.00', '2019-02-20 10:47:09'),
(476023, '28530.00', '2019-02-20 10:47:14'),
(476027, '28527.00', '2019-02-20 10:47:19'),
(476032, '28526.00', '2019-02-20 10:47:24'),
(476035, '28533.00', '2019-02-20 10:47:29'),
(476039, '28534.00', '2019-02-20 10:47:33'),
(476044, '28530.00', '2019-02-20 10:47:39'),
(476048, '28533.00', '2019-02-20 10:47:44'),
(476052, '28530.00', '2019-02-20 10:47:49'),
(476057, '28530.00', '2019-02-20 10:47:54'),
(476063, '28531.00', '2019-02-20 10:47:59'),
(476071, '28532.00', '2019-02-20 10:48:04'),
(476078, '28532.00', '2019-02-20 10:48:09'),
(476084, '28535.00', '2019-02-20 10:48:14'),
(476088, '28534.00', '2019-02-20 10:48:19'),
(476093, '28530.00', '2019-02-20 10:48:23'),
(476096, '28532.00', '2019-02-20 10:48:28'),
(476100, '28531.00', '2019-02-20 10:48:33'),
(476105, '28533.00', '2019-02-20 10:48:40'),
(476109, '28531.00', '2019-02-20 10:48:45'),
(476113, '28534.00', '2019-02-20 10:48:48'),
(476118, '28535.00', '2019-02-20 10:48:54'),
(476122, '28539.00', '2019-02-20 10:48:59'),
(476130, '28537.00', '2019-02-20 10:49:04'),
(476139, '28537.00', '2019-02-20 10:49:09'),
(476143, '28537.00', '2019-02-20 10:49:14'),
(476147, '28538.00', '2019-02-20 10:49:19'),
(476152, '28533.00', '2019-02-20 10:49:23'),
(476155, '28535.00', '2019-02-20 10:49:28'),
(476159, '28533.00', '2019-02-20 10:49:33'),
(476164, '28533.00', '2019-02-20 10:49:39'),
(476168, '28534.00', '2019-02-20 10:49:44'),
(476172, '28536.00', '2019-02-20 10:49:48'),
(476177, '28537.00', '2019-02-20 10:49:54'),
(476182, '28537.00', '2019-02-20 10:49:59'),
(476191, '28538.00', '2019-02-20 10:50:04'),
(476199, '28538.00', '2019-02-20 10:50:09'),
(476204, '28545.00', '2019-02-20 10:50:14'),
(476208, '28555.00', '2019-02-20 10:50:19'),
(476212, '28551.00', '2019-02-20 10:50:23'),
(476216, '28545.00', '2019-02-20 10:50:29'),
(476220, '28545.00', '2019-02-20 10:50:34'),
(476224, '28549.00', '2019-02-20 10:50:39'),
(476228, '28550.00', '2019-02-20 10:50:44'),
(476233, '28548.00', '2019-02-20 10:50:49'),
(476238, '28547.00', '2019-02-20 10:50:54'),
(476243, '28548.00', '2019-02-20 10:50:58'),
(476251, '28547.00', '2019-02-20 10:51:04'),
(476259, '28545.00', '2019-02-20 10:51:09'),
(476264, '28544.00', '2019-02-20 10:51:13'),
(476268, '28544.00', '2019-02-20 10:51:18'),
(476273, '28539.00', '2019-02-20 10:51:24'),
(476276, '28535.00', '2019-02-20 10:51:29'),
(476280, '28539.00', '2019-02-20 10:51:34'),
(476284, '28542.00', '2019-02-20 10:51:39'),
(476289, '28541.00', '2019-02-20 10:51:44'),
(476293, '28533.00', '2019-02-20 10:51:49'),
(476297, '28531.00', '2019-02-20 10:51:54'),
(476303, '28533.00', '2019-02-20 10:51:59'),
(476311, '28530.00', '2019-02-20 10:52:04'),
(476319, '28527.00', '2019-02-20 10:52:09'),
(476323, '28526.00', '2019-02-20 10:52:14'),
(476328, '28528.00', '2019-02-20 10:52:19'),
(476332, '28526.00', '2019-02-20 10:52:24'),
(476337, '28524.00', '2019-02-20 10:52:29'),
(476340, '28525.00', '2019-02-20 10:52:34'),
(476344, '28526.00', '2019-02-20 10:52:39'),
(476348, '28525.00', '2019-02-20 10:52:44'),
(476352, '28525.00', '2019-02-20 10:52:49'),
(476357, '28526.00', '2019-02-20 10:52:54'),
(476363, '28527.00', '2019-02-20 10:52:59'),
(476371, '28531.00', '2019-02-20 10:53:04'),
(476379, '28531.00', '2019-02-20 10:53:09'),
(476384, '28529.00', '2019-02-20 10:53:14'),
(476388, '28528.00', '2019-02-20 10:53:19'),
(476391, '28528.00', '2019-02-20 10:53:24'),
(476396, '28531.00', '2019-02-20 10:53:29'),
(476400, '28530.00', '2019-02-20 10:53:34'),
(476404, '28529.00', '2019-02-20 10:53:39'),
(476408, '28525.00', '2019-02-20 10:53:44'),
(476413, '28523.00', '2019-02-20 10:53:49'),
(476417, '28519.00', '2019-02-20 10:53:53'),
(476423, '28519.00', '2019-02-20 10:53:59'),
(476431, '28519.00', '2019-02-20 10:54:04'),
(476439, '28523.00', '2019-02-20 10:54:09'),
(476443, '28522.00', '2019-02-20 10:54:14'),
(476448, '28524.00', '2019-02-20 10:54:19'),
(476451, '28521.00', '2019-02-20 10:54:24'),
(476456, '28519.00', '2019-02-20 10:54:29'),
(476460, '28517.00', '2019-02-20 10:54:34'),
(476464, '28516.00', '2019-02-20 10:54:39'),
(476468, '28520.00', '2019-02-20 10:54:44'),
(476472, '28524.00', '2019-02-20 10:54:49'),
(476477, '28521.00', '2019-02-20 10:54:54'),
(476483, '28524.00', '2019-02-20 10:54:59'),
(476491, '28524.00', '2019-02-20 10:55:04'),
(476499, '28523.00', '2019-02-20 10:55:09'),
(476503, '28518.00', '2019-02-20 10:55:14'),
(476508, '28519.00', '2019-02-20 10:55:19'),
(476512, '28520.00', '2019-02-20 10:55:24'),
(476516, '28522.00', '2019-02-20 10:55:29'),
(476520, '28519.00', '2019-02-20 10:55:34'),
(476524, '28516.00', '2019-02-20 10:55:39'),
(476528, '28518.00', '2019-02-20 10:55:44'),
(476532, '28519.00', '2019-02-20 10:55:49'),
(476537, '28521.00', '2019-02-20 10:55:54'),
(476543, '28518.00', '2019-02-20 10:55:59'),
(476551, '28520.00', '2019-02-20 10:56:04'),
(476559, '28516.00', '2019-02-20 10:56:09'),
(476564, '28515.00', '2019-02-20 10:56:13'),
(476567, '28518.00', '2019-02-20 10:56:19'),
(476572, '28516.00', '2019-02-20 10:56:24'),
(476577, '28516.00', '2019-02-20 10:56:30'),
(476580, '28518.00', '2019-02-20 10:56:34'),
(476584, '28510.00', '2019-02-20 10:56:39'),
(476588, '28509.00', '2019-02-20 10:56:45'),
(476592, '28511.00', '2019-02-20 10:56:49'),
(476597, '28510.00', '2019-02-20 10:56:54'),
(476603, '28512.00', '2019-02-20 10:56:59'),
(476611, '28511.00', '2019-02-20 10:57:04'),
(476619, '28508.00', '2019-02-20 10:57:09'),
(476623, '28511.00', '2019-02-20 10:57:14'),
(476627, '28507.00', '2019-02-20 10:57:19'),
(476632, '28505.00', '2019-02-20 10:57:24'),
(476636, '28504.00', '2019-02-20 10:57:29'),
(476640, '28503.00', '2019-02-20 10:57:34'),
(476644, '28503.00', '2019-02-20 10:57:39'),
(476648, '28498.00', '2019-02-20 10:57:44'),
(476653, '28495.00', '2019-02-20 10:57:49'),
(476657, '28496.00', '2019-02-20 10:57:54'),
(476664, '28502.00', '2019-02-20 10:57:59'),
(476671, '28500.00', '2019-02-20 10:58:04'),
(476679, '28496.00', '2019-02-20 10:58:09'),
(476683, '28494.00', '2019-02-20 10:58:14'),
(476687, '28498.00', '2019-02-20 10:58:19'),
(476692, '28495.00', '2019-02-20 10:58:24'),
(476697, '28494.00', '2019-02-20 10:58:29'),
(476699, '28494.00', '2019-02-20 10:58:34'),
(476704, '28494.00', '2019-02-20 10:58:39'),
(476708, '28496.00', '2019-02-20 10:58:44'),
(476712, '28496.00', '2019-02-20 10:58:49'),
(476716, '28494.00', '2019-02-20 10:58:54'),
(476726, '28496.00', '2019-02-20 10:58:59'),
(476732, '28498.00', '2019-02-20 10:59:04'),
(476740, '28497.00', '2019-02-20 10:59:09'),
(476744, '28496.00', '2019-02-20 10:59:14'),
(476748, '28496.00', '2019-02-20 10:59:19'),
(476753, '28492.00', '2019-02-20 10:59:24'),
(476756, '28491.00', '2019-02-20 10:59:29'),
(476761, '28492.00', '2019-02-20 10:59:34'),
(476765, '28491.00', '2019-02-20 10:59:39'),
(476769, '28491.00', '2019-02-20 10:59:44'),
(476773, '28491.00', '2019-02-20 10:59:49'),
(476777, '28488.00', '2019-02-20 10:59:54'),
(476785, '28490.00', '2019-02-20 11:00:00'),
(476791, '28491.00', '2019-02-20 11:00:04'),
(476800, '28491.00', '2019-02-20 11:00:09'),
(476804, '28486.00', '2019-02-20 11:00:14'),
(476808, '28485.00', '2019-02-20 11:00:19'),
(476812, '28491.00', '2019-02-20 11:00:24'),
(476817, '28494.00', '2019-02-20 11:00:29'),
(476820, '28497.00', '2019-02-20 11:00:34'),
(476825, '28502.00', '2019-02-20 11:00:39'),
(476829, '28499.00', '2019-02-20 11:00:44'),
(476833, '28502.00', '2019-02-20 11:00:49'),
(476837, '28503.00', '2019-02-20 11:00:54'),
(476846, '28504.00', '2019-02-20 11:01:00'),
(476851, '28504.00', '2019-02-20 11:01:04'),
(476859, '28503.00', '2019-02-20 11:01:10'),
(476864, '28500.00', '2019-02-20 11:01:15'),
(476868, '28505.00', '2019-02-20 11:01:19'),
(476872, '28505.00', '2019-02-20 11:01:25'),
(476877, '28504.00', '2019-02-20 11:01:30'),
(476880, '28502.00', '2019-02-20 11:01:35'),
(476884, '28502.00', '2019-02-20 11:01:39'),
(476888, '28502.00', '2019-02-20 11:01:45'),
(476893, '28503.00', '2019-02-20 11:01:50'),
(476897, '28503.00', '2019-02-20 11:01:54'),
(476903, '28503.00', '2019-02-20 11:02:00'),
(476911, '28505.00', '2019-02-20 11:02:04'),
(476919, '28505.00', '2019-02-20 11:02:09'),
(476924, '28510.00', '2019-02-20 11:02:14'),
(476927, '28513.00', '2019-02-20 11:02:19'),
(476932, '28514.00', '2019-02-20 11:02:24'),
(476937, '28515.00', '2019-02-20 11:02:29'),
(476940, '28517.00', '2019-02-20 11:02:35'),
(476945, '28515.00', '2019-02-20 11:02:40'),
(476948, '28512.00', '2019-02-20 11:02:45'),
(476953, '28514.00', '2019-02-20 11:02:50'),
(476957, '28516.00', '2019-02-20 11:02:55'),
(476963, '28514.00', '2019-02-20 11:03:00'),
(476971, '28514.00', '2019-02-20 11:03:05'),
(476979, '28519.00', '2019-02-20 11:03:10'),
(476983, '28520.00', '2019-02-20 11:03:14'),
(476987, '28520.00', '2019-02-20 11:03:20'),
(476992, '28520.00', '2019-02-20 11:03:25'),
(476996, '28519.00', '2019-02-20 11:03:30'),
(477000, '28517.00', '2019-02-20 11:03:33'),
(477004, '28515.00', '2019-02-20 11:03:40'),
(477008, '28512.00', '2019-02-20 11:03:45'),
(477012, '28508.00', '2019-02-20 11:03:50'),
(477018, '28509.00', '2019-02-20 11:03:55'),
(477022, '28510.00', '2019-02-20 11:03:59'),
(477031, '28509.00', '2019-02-20 11:04:05'),
(477043, '28503.00', '2019-02-20 11:04:15'),
(477047, '28504.00', '2019-02-20 11:04:20'),
(477053, '28505.00', '2019-02-20 11:04:26'),
(477057, '28502.00', '2019-02-20 11:04:30'),
(477060, '28505.00', '2019-02-20 11:04:34'),
(477064, '28506.00', '2019-02-20 11:04:40'),
(477068, '28512.00', '2019-02-20 11:04:45'),
(477072, '28511.00', '2019-02-20 11:04:49'),
(477076, '28504.00', '2019-02-20 11:04:54'),
(477086, '28506.00', '2019-02-20 11:05:00'),
(477092, '28509.00', '2019-02-20 11:05:04'),
(477100, '28510.00', '2019-02-20 11:05:09'),
(477104, '28511.00', '2019-02-20 11:05:14'),
(477108, '28510.00', '2019-02-20 11:05:19'),
(477113, '28511.00', '2019-02-20 11:05:25'),
(477118, '28512.00', '2019-02-20 11:05:30'),
(477121, '28510.00', '2019-02-20 11:05:35'),
(477125, '28511.00', '2019-02-20 11:05:40'),
(477129, '28499.00', '2019-02-20 11:05:45'),
(477133, '28496.00', '2019-02-20 11:05:50'),
(477137, '28502.00', '2019-02-20 11:05:55'),
(477146, '28502.00', '2019-02-20 11:05:59'),
(477151, '28501.00', '2019-02-20 11:06:05'),
(477160, '28501.00', '2019-02-20 11:06:08'),
(477164, '28504.00', '2019-02-20 11:06:15'),
(477168, '28504.00', '2019-02-20 11:06:20'),
(477172, '28500.00', '2019-02-20 11:06:24'),
(477177, '28501.00', '2019-02-20 11:06:30'),
(477180, '28502.00', '2019-02-20 11:06:34'),
(477184, '28503.00', '2019-02-20 11:06:40'),
(477189, '28504.00', '2019-02-20 11:06:45'),
(477193, '28503.00', '2019-02-20 11:06:50'),
(477199, '28495.00', '2019-02-20 11:06:57'),
(477211, '28497.00', '2019-02-20 11:07:04'),
(477219, '28499.00', '2019-02-20 11:07:09'),
(477224, '28497.00', '2019-02-20 11:07:14'),
(477227, '28500.00', '2019-02-20 11:07:19'),
(477232, '28505.00', '2019-02-20 11:07:24'),
(477235, '28508.00', '2019-02-20 11:07:29'),
(477240, '28508.00', '2019-02-20 11:07:33'),
(477244, '28506.00', '2019-02-20 11:07:39'),
(477248, '28505.00', '2019-02-20 11:07:44'),
(477252, '28500.00', '2019-02-20 11:07:49'),
(477256, '28504.00', '2019-02-20 11:07:53'),
(477263, '28500.00', '2019-02-20 11:07:58'),
(477270, '28502.00', '2019-02-20 11:08:04'),
(477279, '28503.00', '2019-02-20 11:08:09'),
(477283, '28507.00', '2019-02-20 11:08:14'),
(477287, '28511.00', '2019-02-20 11:08:19'),
(477291, '28513.00', '2019-02-20 11:08:24'),
(477295, '28513.00', '2019-02-20 11:08:29'),
(477299, '28510.00', '2019-02-20 11:08:33'),
(477303, '28509.00', '2019-02-20 11:08:39'),
(477308, '28508.00', '2019-02-20 11:08:44'),
(477312, '28510.00', '2019-02-20 11:08:49'),
(477316, '28507.00', '2019-02-20 11:08:54'),
(477321, '28505.00', '2019-02-20 11:08:59'),
(477329, '28506.00', '2019-02-20 11:09:04'),
(477339, '28508.00', '2019-02-20 11:09:09'),
(477343, '28509.00', '2019-02-20 11:09:13'),
(477347, '28510.00', '2019-02-20 11:09:19'),
(477351, '28509.00', '2019-02-20 11:09:24'),
(477356, '28506.00', '2019-02-20 11:09:28'),
(477360, '28507.00', '2019-02-20 11:09:33'),
(477364, '28506.00', '2019-02-20 11:09:39'),
(477368, '28509.00', '2019-02-20 11:09:44'),
(477372, '28513.00', '2019-02-20 11:09:49'),
(477376, '28506.00', '2019-02-20 11:09:54'),
(477382, '28511.00', '2019-02-20 11:09:59'),
(477391, '28512.00', '2019-02-20 11:10:04'),
(477398, '28510.00', '2019-02-20 11:10:09'),
(477404, '28506.00', '2019-02-20 11:10:14'),
(477408, '28504.00', '2019-02-20 11:10:19'),
(477412, '28504.00', '2019-02-20 11:10:24'),
(477416, '28508.00', '2019-02-20 11:10:29'),
(477420, '28510.00', '2019-02-20 11:10:33'),
(477424, '28509.00', '2019-02-20 11:10:39'),
(477429, '28506.00', '2019-02-20 11:10:44'),
(477432, '28503.00', '2019-02-20 11:10:49'),
(477437, '28504.00', '2019-02-20 11:10:54'),
(477443, '28502.00', '2019-02-20 11:10:58'),
(477452, '28502.00', '2019-02-20 11:11:04'),
(477459, '28509.00', '2019-02-20 11:11:09'),
(477463, '28509.00', '2019-02-20 11:11:14'),
(477467, '28514.00', '2019-02-20 11:11:19'),
(477471, '28512.00', '2019-02-20 11:11:24'),
(477475, '28508.00', '2019-02-20 11:11:28'),
(477479, '28509.00', '2019-02-20 11:11:33'),
(477483, '28507.00', '2019-02-20 11:11:38'),
(477488, '28513.00', '2019-02-20 11:11:43'),
(477492, '28512.00', '2019-02-20 11:11:49'),
(477496, '28511.00', '2019-02-20 11:11:53'),
(477502, '28511.00', '2019-02-20 11:11:59'),
(477510, '28510.00', '2019-02-20 11:12:04'),
(477519, '28515.00', '2019-02-20 11:12:09'),
(477525, '28513.00', '2019-02-20 11:12:14'),
(477527, '28513.00', '2019-02-20 11:12:19'),
(477531, '28511.00', '2019-02-20 11:12:24'),
(477536, '28511.00', '2019-02-20 11:12:29'),
(477540, '28506.00', '2019-02-20 11:12:34'),
(477544, '28506.00', '2019-02-20 11:12:39'),
(477548, '28505.00', '2019-02-20 11:12:44'),
(477552, '28508.00', '2019-02-20 11:12:49'),
(477556, '28508.00', '2019-02-20 11:12:54'),
(477563, '28513.00', '2019-02-20 11:12:59'),
(477571, '28512.00', '2019-02-20 11:13:04'),
(477580, '28511.00', '2019-02-20 11:13:08'),
(477584, '28511.00', '2019-02-20 11:13:13'),
(477588, '28513.00', '2019-02-20 11:13:18'),
(477592, '28510.00', '2019-02-20 11:13:24'),
(477597, '28511.00', '2019-02-20 11:13:29'),
(477600, '28512.00', '2019-02-20 11:13:34'),
(477604, '28510.00', '2019-02-20 11:13:39'),
(477609, '28510.00', '2019-02-20 11:13:43'),
(477613, '28510.00', '2019-02-20 11:13:49'),
(477617, '28508.00', '2019-02-20 11:13:53'),
(477623, '28508.00', '2019-02-20 11:13:59'),
(477633, '28503.00', '2019-02-20 11:14:05'),
(477640, '28507.00', '2019-02-20 11:14:10'),
(477644, '28505.00', '2019-02-20 11:14:14'),
(477648, '28505.00', '2019-02-20 11:14:20'),
(477652, '28507.00', '2019-02-20 11:14:25'),
(477658, '28508.00', '2019-02-20 11:14:30'),
(477661, '28509.00', '2019-02-20 11:14:35'),
(477665, '28506.00', '2019-02-20 11:14:40'),
(477669, '28506.00', '2019-02-20 11:14:44'),
(477673, '28505.00', '2019-02-20 11:14:50'),
(477677, '28505.00', '2019-02-20 11:14:55'),
(477686, '28506.00', '2019-02-20 11:15:00'),
(477693, '28505.00', '2019-02-20 11:15:05'),
(477700, '28503.00', '2019-02-20 11:15:10'),
(477705, '28501.00', '2019-02-20 11:15:15'),
(477709, '28502.00', '2019-02-20 11:15:20'),
(477713, '28502.00', '2019-02-20 11:15:25'),
(477717, '28505.00', '2019-02-20 11:15:29'),
(477721, '28506.00', '2019-02-20 11:15:34'),
(477726, '28507.00', '2019-02-20 11:15:40'),
(477730, '28510.00', '2019-02-20 11:15:45'),
(477734, '28509.00', '2019-02-20 11:15:50'),
(477738, '28510.00', '2019-02-20 11:15:55'),
(477746, '28509.00', '2019-02-20 11:16:00'),
(477755, '28509.00', '2019-02-20 11:16:05'),
(477760, '28510.00', '2019-02-20 11:16:10'),
(477764, '28503.00', '2019-02-20 11:16:15'),
(477768, '28501.00', '2019-02-20 11:16:20'),
(477772, '28493.00', '2019-02-20 11:16:25'),
(477778, '28496.00', '2019-02-20 11:16:30'),
(477781, '28488.00', '2019-02-20 11:16:35'),
(477785, '28486.00', '2019-02-20 11:16:40'),
(477789, '28481.00', '2019-02-20 11:16:45'),
(477793, '28487.00', '2019-02-20 11:16:50'),
(477797, '28493.00', '2019-02-20 11:16:55'),
(477807, '28489.00', '2019-02-20 11:17:00'),
(477813, '28491.00', '2019-02-20 11:17:05'),
(477820, '28492.00', '2019-02-20 11:17:10'),
(477825, '28490.00', '2019-02-20 11:17:14'),
(477829, '28491.00', '2019-02-20 11:17:19'),
(477833, '28494.00', '2019-02-20 11:17:25'),
(477838, '28494.00', '2019-02-20 11:17:31'),
(477841, '28496.00', '2019-02-20 11:17:35'),
(477845, '28496.00', '2019-02-20 11:17:40'),
(477849, '28496.00', '2019-02-20 11:17:44'),
(477853, '28491.00', '2019-02-20 11:17:50'),
(477858, '28488.00', '2019-02-20 11:17:54'),
(477867, '28491.00', '2019-02-20 11:18:00'),
(477873, '28493.00', '2019-02-20 11:18:05'),
(477880, '28497.00', '2019-02-20 11:18:10'),
(477884, '28498.00', '2019-02-20 11:18:15'),
(477888, '28496.00', '2019-02-20 11:18:21'),
(477893, '28500.00', '2019-02-20 11:18:26'),
(477898, '28498.00', '2019-02-20 11:18:30'),
(477901, '28494.00', '2019-02-20 11:18:34'),
(477905, '28498.00', '2019-02-20 11:18:40'),
(477909, '28495.00', '2019-02-20 11:18:46'),
(477913, '28491.00', '2019-02-20 11:18:50'),
(477917, '28489.00', '2019-02-20 11:18:56'),
(477925, '28489.00', '2019-02-20 11:19:00'),
(477933, '28485.00', '2019-02-20 11:19:05'),
(477940, '28483.00', '2019-02-20 11:19:11'),
(477944, '28484.00', '2019-02-20 11:19:16'),
(477948, '28475.00', '2019-02-20 11:19:20'),
(477953, '28476.00', '2019-02-20 11:19:26'),
(477958, '28476.00', '2019-02-20 11:19:30'),
(477961, '28473.00', '2019-02-20 11:19:35'),
(477965, '28469.00', '2019-02-20 11:19:41'),
(477970, '28468.00', '2019-02-20 11:19:46'),
(477973, '28471.00', '2019-02-20 11:19:51'),
(477978, '28471.00', '2019-02-20 11:19:56'),
(477985, '28462.00', '2019-02-20 11:20:00'),
(477993, '28459.00', '2019-02-20 11:20:06'),
(478000, '28457.00', '2019-02-20 11:20:11'),
(478004, '28454.00', '2019-02-20 11:20:16'),
(478008, '28454.00', '2019-02-20 11:20:20'),
(478013, '28458.00', '2019-02-20 11:20:26'),
(478018, '28459.00', '2019-02-20 11:20:31'),
(478021, '28458.00', '2019-02-20 11:20:36'),
(478025, '28454.00', '2019-02-20 11:20:41'),
(478029, '28457.00', '2019-02-20 11:20:46'),
(478033, '28458.00', '2019-02-20 11:20:50'),
(478037, '28456.00', '2019-02-20 11:20:54'),
(478047, '28458.00', '2019-02-20 11:20:56'),
(478053, '28459.00', '2019-02-20 11:21:05'),
(478060, '28458.00', '2019-02-20 11:21:10'),
(478064, '28456.00', '2019-02-20 11:21:16'),
(478069, '28456.00', '2019-02-20 11:21:20'),
(478074, '28454.00', '2019-02-20 11:21:26'),
(478078, '28452.00', '2019-02-20 11:21:32'),
(478082, '28453.00', '2019-02-20 11:21:36'),
(478089, '28446.00', '2019-02-20 11:21:44'),
(478093, '28451.00', '2019-02-20 11:21:49'),
(478097, '28450.00', '2019-02-20 11:21:54');

-- --------------------------------------------------------

--
-- 表的结构 `data_himhif`
--

CREATE TABLE `data_himhif` (
  `id` int(11) NOT NULL,
  `price` varchar(30) DEFAULT NULL,
  `time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `data_himhif`
--

INSERT INTO `data_himhif` (`id`, `price`, `time`) VALUES
(473281, '26290.00', '2019-01-14 10:48:59'),
(473282, '26283.00', '2019-01-14 10:49:04'),
(473284, '26282.00', '2019-01-14 10:49:09'),
(473287, '26285.00', '2019-01-14 10:49:14'),
(473288, '26279.00', '2019-01-14 10:49:19'),
(473290, '26280.00', '2019-01-14 10:49:24'),
(473292, '26283.00', '2019-01-14 10:49:29'),
(473295, '26280.00', '2019-01-14 10:49:34'),
(473296, '26280.00', '2019-01-14 10:49:39'),
(473298, '26284.00', '2019-01-14 10:49:43'),
(473300, '26280.00', '2019-01-14 10:49:49'),
(473303, '26279.00', '2019-01-14 10:49:54'),
(473306, '26278.00', '2019-01-14 10:49:59'),
(473307, '26236.00', '2019-01-14 11:32:20'),
(473308, '26239.00', '2019-01-14 11:33:05'),
(473309, '26237.00', '2019-01-14 11:33:10'),
(473311, '26268.00', '2019-01-14 11:38:05'),
(473318, '26263.00', '2019-01-14 11:38:10'),
(473325, '26265.00', '2019-01-14 11:38:15'),
(473333, '26269.00', '2019-01-14 11:38:19'),
(473340, '26269.00', '2019-01-14 11:38:24'),
(473347, '26268.00', '2019-01-14 11:38:30'),
(473354, '26267.00', '2019-01-14 11:38:35'),
(473362, '26267.00', '2019-01-14 11:38:40'),
(473369, '26265.00', '2019-01-14 11:38:45'),
(473377, '26263.00', '2019-01-14 11:38:50'),
(473384, '26265.00', '2019-01-14 11:38:55'),
(473388, '26286.00', '2019-01-14 11:44:45'),
(473389, '26295.00', '2019-01-14 11:46:45'),
(473390, '26279.00', '2019-01-14 11:49:05'),
(473392, '26294.00', '2019-01-14 11:59:59'),
(474953, '28531.00', '2019-02-20 10:23:53'),
(474954, '28532.00', '2019-02-20 10:23:57'),
(474961, '28539.00', '2019-02-20 10:24:02'),
(474969, '28542.00', '2019-02-20 10:24:08'),
(474979, '28541.00', '2019-02-20 10:24:13'),
(474985, '28539.00', '2019-02-20 10:24:18'),
(474994, '28541.00', '2019-02-20 10:24:23'),
(475002, '28541.00', '2019-02-20 10:24:28'),
(475011, '28542.00', '2019-02-20 10:24:33'),
(475019, '28538.00', '2019-02-20 10:24:38'),
(475027, '28538.00', '2019-02-20 10:24:43'),
(475035, '28540.00', '2019-02-20 10:24:48'),
(475043, '28541.00', '2019-02-20 10:24:53'),
(475052, '28541.00', '2019-02-20 10:24:58'),
(475064, '28541.00', '2019-02-20 10:25:03'),
(475078, '28539.00', '2019-02-20 10:25:06'),
(475087, '28538.00', '2019-02-20 10:25:12'),
(475090, '28536.00', '2019-02-20 10:25:18'),
(475094, '28541.00', '2019-02-20 10:25:22'),
(475098, '28539.00', '2019-02-20 10:25:28'),
(475103, '28536.00', '2019-02-20 10:25:33'),
(475107, '28533.00', '2019-02-20 10:25:38'),
(475111, '28534.00', '2019-02-20 10:25:42'),
(475115, '28534.00', '2019-02-20 10:25:48'),
(475119, '28537.00', '2019-02-20 10:25:52'),
(475125, '28537.00', '2019-02-20 10:25:58'),
(475133, '28537.00', '2019-02-20 10:26:02'),
(475142, '28532.00', '2019-02-20 10:26:08'),
(475146, '28534.00', '2019-02-20 10:26:12'),
(475150, '28533.00', '2019-02-20 10:26:18'),
(475154, '28535.00', '2019-02-20 10:26:23'),
(475158, '28533.00', '2019-02-20 10:26:28'),
(475163, '28537.00', '2019-02-20 10:26:33'),
(475167, '28532.00', '2019-02-20 10:26:38'),
(475171, '28535.00', '2019-02-20 10:26:43'),
(475175, '28533.00', '2019-02-20 10:26:47'),
(475179, '28533.00', '2019-02-20 10:26:52'),
(475183, '28537.00', '2019-02-20 10:26:58'),
(475192, '28542.00', '2019-02-20 10:27:03'),
(475201, '28542.00', '2019-02-20 10:27:08'),
(475207, '28540.00', '2019-02-20 10:27:11'),
(475210, '28543.00', '2019-02-20 10:27:18'),
(475214, '28543.00', '2019-02-20 10:27:21'),
(475219, '28540.00', '2019-02-20 10:27:28'),
(475222, '28535.00', '2019-02-20 10:27:33'),
(475226, '28531.00', '2019-02-20 10:27:38'),
(475231, '28530.00', '2019-02-20 10:27:43'),
(475235, '28525.00', '2019-02-20 10:27:47'),
(475239, '28525.00', '2019-02-20 10:27:53'),
(475244, '28526.00', '2019-02-20 10:27:58'),
(475247, '28525.00', '2019-02-20 10:28:03'),
(475252, '28524.00', '2019-02-20 10:28:08'),
(475253, '28538.00', '2019-02-20 10:28:54'),
(475254, '28544.00', '2019-02-20 10:28:58'),
(475258, '28546.00', '2019-02-20 10:29:04'),
(475263, '28560.00', '2019-02-20 10:29:09'),
(475267, '28559.00', '2019-02-20 10:29:13'),
(475271, '28557.00', '2019-02-20 10:29:19'),
(475276, '28561.00', '2019-02-20 10:29:24'),
(475280, '28565.00', '2019-02-20 10:29:29'),
(475284, '28562.00', '2019-02-20 10:29:34'),
(475288, '28563.00', '2019-02-20 10:29:39'),
(475292, '28570.00', '2019-02-20 10:29:44'),
(475296, '28563.00', '2019-02-20 10:29:49'),
(475301, '28567.00', '2019-02-20 10:29:54'),
(475307, '28569.00', '2019-02-20 10:29:59'),
(475313, '28570.00', '2019-02-20 10:30:04'),
(475322, '28571.00', '2019-02-20 10:30:09'),
(475327, '28566.00', '2019-02-20 10:30:14'),
(475331, '28562.00', '2019-02-20 10:30:19'),
(475336, '28566.00', '2019-02-20 10:30:24'),
(475339, '28564.00', '2019-02-20 10:30:29'),
(475344, '28564.00', '2019-02-20 10:30:34'),
(475348, '28561.00', '2019-02-20 10:30:39'),
(475352, '28562.00', '2019-02-20 10:30:40'),
(475356, '28562.00', '2019-02-20 10:30:49'),
(475360, '28565.00', '2019-02-20 10:30:54'),
(475365, '28560.00', '2019-02-20 10:30:59'),
(475373, '28555.00', '2019-02-20 10:31:04'),
(475381, '28556.00', '2019-02-20 10:31:08'),
(475387, '28554.00', '2019-02-20 10:31:14'),
(475391, '28551.00', '2019-02-20 10:31:18'),
(475396, '28549.00', '2019-02-20 10:31:24'),
(475399, '28550.00', '2019-02-20 10:31:29'),
(475403, '28546.00', '2019-02-20 10:31:33'),
(475408, '28546.00', '2019-02-20 10:31:37'),
(475411, '28552.00', '2019-02-20 10:31:44'),
(475416, '28548.00', '2019-02-20 10:31:49'),
(475421, '28550.00', '2019-02-20 10:31:54'),
(475425, '28547.00', '2019-02-20 10:31:59'),
(475435, '28547.00', '2019-02-20 10:32:04'),
(475447, '28547.00', '2019-02-20 10:32:09'),
(475456, '28551.00', '2019-02-20 10:32:14'),
(475464, '28551.00', '2019-02-20 10:32:18'),
(475475, '28556.00', '2019-02-20 10:32:24'),
(475482, '28553.00', '2019-02-20 10:32:29'),
(475490, '28553.00', '2019-02-20 10:32:34'),
(475498, '28552.00', '2019-02-20 10:32:39'),
(475506, '28551.00', '2019-02-20 10:32:44'),
(475514, '28554.00', '2019-02-20 10:32:48'),
(475524, '28558.00', '2019-02-20 10:32:54'),
(475533, '28554.00', '2019-02-20 10:32:59'),
(475544, '28559.00', '2019-02-20 10:33:03'),
(475558, '28556.00', '2019-02-20 10:33:09'),
(475568, '28558.00', '2019-02-20 10:33:14'),
(475571, '28554.00', '2019-02-20 10:33:18'),
(475576, '28549.00', '2019-02-20 10:33:24'),
(475580, '28546.00', '2019-02-20 10:33:29'),
(475584, '28545.00', '2019-02-20 10:33:34'),
(475588, '28535.00', '2019-02-20 10:33:39'),
(475592, '28539.00', '2019-02-20 10:33:44'),
(475596, '28540.00', '2019-02-20 10:33:49'),
(475602, '28535.00', '2019-02-20 10:33:54'),
(475606, '28532.00', '2019-02-20 10:33:59'),
(475614, '28526.00', '2019-02-20 10:34:04'),
(475623, '28527.00', '2019-02-20 10:34:09'),
(475627, '28526.00', '2019-02-20 10:34:14'),
(475631, '28521.00', '2019-02-20 10:34:19'),
(475636, '28520.00', '2019-02-20 10:34:24'),
(475639, '28526.00', '2019-02-20 10:34:29'),
(475643, '28521.00', '2019-02-20 10:34:34'),
(475648, '28522.00', '2019-02-20 10:34:39'),
(475652, '28524.00', '2019-02-20 10:34:43'),
(475656, '28523.00', '2019-02-20 10:34:49'),
(475661, '28524.00', '2019-02-20 10:34:54'),
(475666, '28522.00', '2019-02-20 10:34:59'),
(475674, '28514.00', '2019-02-20 10:35:04'),
(475682, '28513.00', '2019-02-20 10:35:09'),
(475687, '28517.00', '2019-02-20 10:35:14'),
(475692, '28522.00', '2019-02-20 10:35:19'),
(475697, '28518.00', '2019-02-20 10:35:24'),
(475700, '28516.00', '2019-02-20 10:35:29'),
(475704, '28516.00', '2019-02-20 10:35:34'),
(475709, '28516.00', '2019-02-20 10:35:40'),
(475713, '28518.00', '2019-02-20 10:35:44'),
(475716, '28518.00', '2019-02-20 10:35:49'),
(475721, '28517.00', '2019-02-20 10:35:54'),
(475726, '28523.00', '2019-02-20 10:35:59'),
(475734, '28521.00', '2019-02-20 10:36:04'),
(475743, '28522.00', '2019-02-20 10:36:09'),
(475747, '28530.00', '2019-02-20 10:36:13'),
(475751, '28530.00', '2019-02-20 10:36:19'),
(475756, '28532.00', '2019-02-20 10:36:24'),
(475759, '28531.00', '2019-02-20 10:36:29'),
(475763, '28530.00', '2019-02-20 10:36:34'),
(475768, '28526.00', '2019-02-20 10:36:39'),
(475772, '28526.00', '2019-02-20 10:36:44'),
(475776, '28530.00', '2019-02-20 10:36:49'),
(475781, '28530.00', '2019-02-20 10:36:54'),
(475787, '28530.00', '2019-02-20 10:36:59'),
(475794, '28534.00', '2019-02-20 10:37:04'),
(475802, '28529.00', '2019-02-20 10:37:08'),
(475807, '28528.00', '2019-02-20 10:37:11'),
(475811, '28531.00', '2019-02-20 10:37:19'),
(475815, '28530.00', '2019-02-20 10:37:24'),
(475820, '28531.00', '2019-02-20 10:37:28'),
(475824, '28531.00', '2019-02-20 10:37:34'),
(475828, '28532.00', '2019-02-20 10:37:39'),
(475832, '28530.00', '2019-02-20 10:37:44'),
(475836, '28531.00', '2019-02-20 10:37:48'),
(475841, '28535.00', '2019-02-20 10:37:54'),
(475846, '28533.00', '2019-02-20 10:37:59'),
(475855, '28534.00', '2019-02-20 10:38:04'),
(475862, '28540.00', '2019-02-20 10:38:09'),
(475867, '28540.00', '2019-02-20 10:38:13'),
(475871, '28543.00', '2019-02-20 10:38:19'),
(475876, '28538.00', '2019-02-20 10:38:24'),
(475880, '28529.00', '2019-02-20 10:38:29'),
(475883, '28528.00', '2019-02-20 10:38:34'),
(475887, '28532.00', '2019-02-20 10:38:39'),
(475891, '28558.00', '2019-02-20 10:41:59'),
(475894, '28562.00', '2019-02-20 10:42:03'),
(475898, '28559.00', '2019-02-20 10:42:10'),
(475902, '28559.00', '2019-02-20 10:42:14'),
(475906, '28562.00', '2019-02-20 10:42:19'),
(475912, '28559.00', '2019-02-20 10:42:24'),
(475915, '28559.00', '2019-02-20 10:42:29'),
(475919, '28559.00', '2019-02-20 10:42:33'),
(475923, '28557.00', '2019-02-20 10:42:39'),
(475927, '28555.00', '2019-02-20 10:42:44'),
(475931, '28554.00', '2019-02-20 10:42:49'),
(475936, '28552.00', '2019-02-20 10:42:54'),
(475942, '28555.00', '2019-02-20 10:42:59'),
(475950, '28551.00', '2019-02-20 10:43:04'),
(475958, '28548.00', '2019-02-20 10:43:08'),
(475962, '28547.00', '2019-02-20 10:43:13'),
(475967, '28545.00', '2019-02-20 10:43:18'),
(475971, '28545.00', '2019-02-20 10:43:24'),
(475975, '28544.00', '2019-02-20 10:43:28'),
(475979, '28548.00', '2019-02-20 10:43:34'),
(475983, '28543.00', '2019-02-20 10:43:39'),
(475988, '28548.00', '2019-02-20 10:43:44'),
(475991, '28541.00', '2019-02-20 10:43:49'),
(475996, '28544.00', '2019-02-20 10:43:54'),
(476002, '28546.00', '2019-02-20 10:43:59'),
(476010, '28546.00', '2019-02-20 10:44:03'),
(476018, '28545.00', '2019-02-20 10:44:09'),
(476023, '28545.00', '2019-02-20 10:44:14'),
(476026, '28547.00', '2019-02-20 10:44:19'),
(476031, '28546.00', '2019-02-20 10:44:24'),
(476035, '28545.00', '2019-02-20 10:44:29'),
(476039, '28549.00', '2019-02-20 10:44:34'),
(476043, '28543.00', '2019-02-20 10:44:38'),
(476047, '28549.00', '2019-02-20 10:44:44'),
(476051, '28547.00', '2019-02-20 10:44:48'),
(476057, '28546.00', '2019-02-20 10:44:53'),
(476061, '28549.00', '2019-02-20 10:44:59'),
(476070, '28558.00', '2019-02-20 10:45:04'),
(476078, '28561.00', '2019-02-20 10:45:09'),
(476082, '28560.00', '2019-02-20 10:45:14'),
(476086, '28557.00', '2019-02-20 10:45:19'),
(476091, '28558.00', '2019-02-20 10:45:24'),
(476095, '28552.00', '2019-02-20 10:45:28'),
(476099, '28552.00', '2019-02-20 10:45:33'),
(476103, '28550.00', '2019-02-20 10:45:39'),
(476107, '28552.00', '2019-02-20 10:45:44'),
(476111, '28550.00', '2019-02-20 10:45:49'),
(476116, '28548.00', '2019-02-20 10:45:54'),
(476121, '28544.00', '2019-02-20 10:45:59'),
(476130, '28543.00', '2019-02-20 10:46:04'),
(476138, '28542.00', '2019-02-20 10:46:09'),
(476142, '28544.00', '2019-02-20 10:46:14'),
(476146, '28543.00', '2019-02-20 10:46:19'),
(476151, '28544.00', '2019-02-20 10:46:24'),
(476155, '28547.00', '2019-02-20 10:46:29'),
(476158, '28548.00', '2019-02-20 10:46:34'),
(476163, '28546.00', '2019-02-20 10:46:39'),
(476167, '28549.00', '2019-02-20 10:46:44'),
(476171, '28550.00', '2019-02-20 10:46:49'),
(476176, '28541.00', '2019-02-20 10:46:54'),
(476180, '28537.00', '2019-02-20 10:46:59'),
(476188, '28538.00', '2019-02-20 10:47:03'),
(476198, '28536.00', '2019-02-20 10:47:09'),
(476202, '28530.00', '2019-02-20 10:47:14'),
(476206, '28527.00', '2019-02-20 10:47:19'),
(476211, '28526.00', '2019-02-20 10:47:24'),
(476214, '28533.00', '2019-02-20 10:47:29'),
(476218, '28534.00', '2019-02-20 10:47:33'),
(476223, '28530.00', '2019-02-20 10:47:39'),
(476227, '28533.00', '2019-02-20 10:47:44'),
(476231, '28530.00', '2019-02-20 10:47:49'),
(476236, '28530.00', '2019-02-20 10:47:54'),
(476241, '28531.00', '2019-02-20 10:47:59'),
(476249, '28532.00', '2019-02-20 10:48:04'),
(476257, '28532.00', '2019-02-20 10:48:09'),
(476262, '28535.00', '2019-02-20 10:48:14'),
(476266, '28534.00', '2019-02-20 10:48:19'),
(476271, '28530.00', '2019-02-20 10:48:23'),
(476275, '28532.00', '2019-02-20 10:48:28'),
(476279, '28531.00', '2019-02-20 10:48:33'),
(476284, '28533.00', '2019-02-20 10:48:40'),
(476288, '28531.00', '2019-02-20 10:48:45'),
(476292, '28534.00', '2019-02-20 10:48:48'),
(476296, '28535.00', '2019-02-20 10:48:54'),
(476301, '28539.00', '2019-02-20 10:48:59'),
(476309, '28537.00', '2019-02-20 10:49:04'),
(476318, '28537.00', '2019-02-20 10:49:09'),
(476322, '28537.00', '2019-02-20 10:49:14'),
(476326, '28538.00', '2019-02-20 10:49:19'),
(476331, '28533.00', '2019-02-20 10:49:23'),
(476334, '28535.00', '2019-02-20 10:49:28'),
(476338, '28533.00', '2019-02-20 10:49:33'),
(476343, '28533.00', '2019-02-20 10:49:39'),
(476347, '28534.00', '2019-02-20 10:49:44'),
(476351, '28536.00', '2019-02-20 10:49:48'),
(476356, '28537.00', '2019-02-20 10:49:54'),
(476361, '28537.00', '2019-02-20 10:49:59'),
(476370, '28538.00', '2019-02-20 10:50:04'),
(476378, '28538.00', '2019-02-20 10:50:09'),
(476383, '28545.00', '2019-02-20 10:50:14'),
(476387, '28555.00', '2019-02-20 10:50:19'),
(476391, '28551.00', '2019-02-20 10:50:23'),
(476395, '28545.00', '2019-02-20 10:50:29'),
(476399, '28545.00', '2019-02-20 10:50:34'),
(476403, '28549.00', '2019-02-20 10:50:39'),
(476407, '28550.00', '2019-02-20 10:50:44'),
(476411, '28548.00', '2019-02-20 10:50:49'),
(476416, '28547.00', '2019-02-20 10:50:54'),
(476422, '28548.00', '2019-02-20 10:50:58'),
(476430, '28547.00', '2019-02-20 10:51:04'),
(476438, '28545.00', '2019-02-20 10:51:09'),
(476443, '28544.00', '2019-02-20 10:51:13'),
(476447, '28544.00', '2019-02-20 10:51:18'),
(476451, '28539.00', '2019-02-20 10:51:24'),
(476455, '28535.00', '2019-02-20 10:51:29'),
(476459, '28539.00', '2019-02-20 10:51:34'),
(476463, '28542.00', '2019-02-20 10:51:39'),
(476467, '28541.00', '2019-02-20 10:51:44'),
(476472, '28533.00', '2019-02-20 10:51:49'),
(476476, '28531.00', '2019-02-20 10:51:54'),
(476482, '28533.00', '2019-02-20 10:51:59'),
(476490, '28530.00', '2019-02-20 10:52:04'),
(476498, '28527.00', '2019-02-20 10:52:09'),
(476502, '28526.00', '2019-02-20 10:52:14'),
(476506, '28528.00', '2019-02-20 10:52:19'),
(476511, '28526.00', '2019-02-20 10:52:24'),
(476517, '28524.00', '2019-02-20 10:52:29'),
(476519, '28525.00', '2019-02-20 10:52:34'),
(476523, '28526.00', '2019-02-20 10:52:39'),
(476527, '28525.00', '2019-02-20 10:52:44'),
(476531, '28525.00', '2019-02-20 10:52:49'),
(476536, '28526.00', '2019-02-20 10:52:54'),
(476542, '28527.00', '2019-02-20 10:52:59'),
(476550, '28531.00', '2019-02-20 10:53:04'),
(476558, '28531.00', '2019-02-20 10:53:09'),
(476562, '28529.00', '2019-02-20 10:53:14'),
(476567, '28528.00', '2019-02-20 10:53:19'),
(476570, '28528.00', '2019-02-20 10:53:24'),
(476575, '28531.00', '2019-02-20 10:53:29'),
(476579, '28530.00', '2019-02-20 10:53:34'),
(476584, '28529.00', '2019-02-20 10:53:39'),
(476587, '28525.00', '2019-02-20 10:53:44'),
(476592, '28523.00', '2019-02-20 10:53:49'),
(476596, '28519.00', '2019-02-20 10:53:53'),
(476602, '28519.00', '2019-02-20 10:53:59'),
(476610, '28519.00', '2019-02-20 10:54:04'),
(476618, '28523.00', '2019-02-20 10:54:09'),
(476622, '28522.00', '2019-02-20 10:54:14'),
(476627, '28524.00', '2019-02-20 10:54:19'),
(476630, '28521.00', '2019-02-20 10:54:24'),
(476635, '28519.00', '2019-02-20 10:54:29'),
(476639, '28517.00', '2019-02-20 10:54:34'),
(476643, '28516.00', '2019-02-20 10:54:39'),
(476647, '28520.00', '2019-02-20 10:54:44'),
(476651, '28524.00', '2019-02-20 10:54:49'),
(476656, '28521.00', '2019-02-20 10:54:54'),
(476662, '28524.00', '2019-02-20 10:54:59'),
(476670, '28524.00', '2019-02-20 10:55:04'),
(476678, '28523.00', '2019-02-20 10:55:09'),
(476682, '28518.00', '2019-02-20 10:55:14'),
(476687, '28519.00', '2019-02-20 10:55:19'),
(476691, '28520.00', '2019-02-20 10:55:24'),
(476695, '28522.00', '2019-02-20 10:55:29'),
(476699, '28519.00', '2019-02-20 10:55:34'),
(476703, '28516.00', '2019-02-20 10:55:39'),
(476708, '28518.00', '2019-02-20 10:55:44'),
(476711, '28519.00', '2019-02-20 10:55:49'),
(476716, '28521.00', '2019-02-20 10:55:54'),
(476722, '28518.00', '2019-02-20 10:55:59'),
(476730, '28520.00', '2019-02-20 10:56:04'),
(476738, '28516.00', '2019-02-20 10:56:09'),
(476743, '28515.00', '2019-02-20 10:56:13'),
(476746, '28518.00', '2019-02-20 10:56:19'),
(476751, '28516.00', '2019-02-20 10:56:24'),
(476755, '28516.00', '2019-02-20 10:56:30'),
(476759, '28518.00', '2019-02-20 10:56:34'),
(476763, '28510.00', '2019-02-20 10:56:39'),
(476767, '28509.00', '2019-02-20 10:56:45'),
(476771, '28511.00', '2019-02-20 10:56:49'),
(476776, '28510.00', '2019-02-20 10:56:54'),
(476782, '28512.00', '2019-02-20 10:56:59'),
(476790, '28511.00', '2019-02-20 10:57:04'),
(476798, '28508.00', '2019-02-20 10:57:09'),
(476802, '28511.00', '2019-02-20 10:57:14'),
(476806, '28507.00', '2019-02-20 10:57:19'),
(476811, '28505.00', '2019-02-20 10:57:24'),
(476815, '28504.00', '2019-02-20 10:57:29'),
(476819, '28503.00', '2019-02-20 10:57:34'),
(476823, '28503.00', '2019-02-20 10:57:39'),
(476827, '28498.00', '2019-02-20 10:57:44'),
(476831, '28495.00', '2019-02-20 10:57:49'),
(476836, '28496.00', '2019-02-20 10:57:54'),
(476844, '28502.00', '2019-02-20 10:57:59'),
(476850, '28500.00', '2019-02-20 10:58:04'),
(476858, '28496.00', '2019-02-20 10:58:09'),
(476863, '28494.00', '2019-02-20 10:58:14'),
(476866, '28498.00', '2019-02-20 10:58:19'),
(476870, '28495.00', '2019-02-20 10:58:24'),
(476876, '28494.00', '2019-02-20 10:58:29'),
(476878, '28494.00', '2019-02-20 10:58:34'),
(476883, '28494.00', '2019-02-20 10:58:39'),
(476887, '28496.00', '2019-02-20 10:58:44'),
(476891, '28496.00', '2019-02-20 10:58:49'),
(476895, '28494.00', '2019-02-20 10:58:54'),
(476905, '28496.00', '2019-02-20 10:58:59'),
(476911, '28498.00', '2019-02-20 10:59:04'),
(476919, '28497.00', '2019-02-20 10:59:09'),
(476923, '28496.00', '2019-02-20 10:59:14'),
(476927, '28496.00', '2019-02-20 10:59:19'),
(476931, '28492.00', '2019-02-20 10:59:24'),
(476935, '28491.00', '2019-02-20 10:59:29'),
(476939, '28492.00', '2019-02-20 10:59:34'),
(476944, '28491.00', '2019-02-20 10:59:39'),
(476949, '28491.00', '2019-02-20 10:59:44'),
(476952, '28491.00', '2019-02-20 10:59:49'),
(476956, '28488.00', '2019-02-20 10:59:54'),
(476965, '28490.00', '2019-02-20 11:00:00'),
(476970, '28491.00', '2019-02-20 11:00:04'),
(476979, '28491.00', '2019-02-20 11:00:09'),
(476983, '28486.00', '2019-02-20 11:00:14'),
(476987, '28485.00', '2019-02-20 11:00:19'),
(476991, '28491.00', '2019-02-20 11:00:24'),
(476997, '28494.00', '2019-02-20 11:00:29'),
(477000, '28497.00', '2019-02-20 11:00:34'),
(477004, '28502.00', '2019-02-20 11:00:39'),
(477008, '28499.00', '2019-02-20 11:00:44'),
(477012, '28502.00', '2019-02-20 11:00:49'),
(477016, '28503.00', '2019-02-20 11:00:54'),
(477024, '28504.00', '2019-02-20 11:01:00'),
(477030, '28504.00', '2019-02-20 11:01:04'),
(477038, '28503.00', '2019-02-20 11:01:10'),
(477043, '28500.00', '2019-02-20 11:01:15'),
(477047, '28505.00', '2019-02-20 11:01:19'),
(477051, '28505.00', '2019-02-20 11:01:25'),
(477056, '28504.00', '2019-02-20 11:01:30'),
(477059, '28502.00', '2019-02-20 11:01:35'),
(477063, '28502.00', '2019-02-20 11:01:39'),
(477067, '28502.00', '2019-02-20 11:01:45'),
(477072, '28503.00', '2019-02-20 11:01:50'),
(477076, '28503.00', '2019-02-20 11:01:54'),
(477082, '28503.00', '2019-02-20 11:02:00'),
(477090, '28505.00', '2019-02-20 11:02:04'),
(477098, '28505.00', '2019-02-20 11:02:09'),
(477103, '28510.00', '2019-02-20 11:02:14'),
(477106, '28513.00', '2019-02-20 11:02:19'),
(477111, '28514.00', '2019-02-20 11:02:24'),
(477116, '28515.00', '2019-02-20 11:02:29'),
(477119, '28517.00', '2019-02-20 11:02:35'),
(477124, '28515.00', '2019-02-20 11:02:40'),
(477127, '28512.00', '2019-02-20 11:02:45'),
(477132, '28514.00', '2019-02-20 11:02:50'),
(477136, '28516.00', '2019-02-20 11:02:55'),
(477142, '28514.00', '2019-02-20 11:03:00'),
(477150, '28514.00', '2019-02-20 11:03:05'),
(477158, '28519.00', '2019-02-20 11:03:10'),
(477162, '28520.00', '2019-02-20 11:03:14'),
(477166, '28520.00', '2019-02-20 11:03:20'),
(477171, '28520.00', '2019-02-20 11:03:25'),
(477175, '28519.00', '2019-02-20 11:03:30'),
(477179, '28517.00', '2019-02-20 11:03:33'),
(477183, '28515.00', '2019-02-20 11:03:40'),
(477187, '28512.00', '2019-02-20 11:03:45'),
(477191, '28508.00', '2019-02-20 11:03:50'),
(477196, '28509.00', '2019-02-20 11:03:55'),
(477201, '28510.00', '2019-02-20 11:03:59'),
(477210, '28509.00', '2019-02-20 11:04:05'),
(477222, '28503.00', '2019-02-20 11:04:15'),
(477227, '28504.00', '2019-02-20 11:04:20'),
(477232, '28505.00', '2019-02-20 11:04:26'),
(477236, '28502.00', '2019-02-20 11:04:30'),
(477238, '28505.00', '2019-02-20 11:04:34'),
(477243, '28506.00', '2019-02-20 11:04:40'),
(477247, '28512.00', '2019-02-20 11:04:45'),
(477251, '28511.00', '2019-02-20 11:04:49'),
(477255, '28504.00', '2019-02-20 11:04:54'),
(477263, '28506.00', '2019-02-20 11:05:00'),
(477270, '28509.00', '2019-02-20 11:05:04'),
(477279, '28510.00', '2019-02-20 11:05:09'),
(477283, '28511.00', '2019-02-20 11:05:14'),
(477287, '28510.00', '2019-02-20 11:05:19'),
(477292, '28511.00', '2019-02-20 11:05:25'),
(477296, '28512.00', '2019-02-20 11:05:30'),
(477300, '28510.00', '2019-02-20 11:05:35'),
(477304, '28511.00', '2019-02-20 11:05:40'),
(477308, '28499.00', '2019-02-20 11:05:45'),
(477312, '28496.00', '2019-02-20 11:05:50'),
(477316, '28502.00', '2019-02-20 11:05:55'),
(477324, '28502.00', '2019-02-20 11:05:59'),
(477330, '28501.00', '2019-02-20 11:06:05'),
(477339, '28501.00', '2019-02-20 11:06:08'),
(477343, '28504.00', '2019-02-20 11:06:15'),
(477347, '28504.00', '2019-02-20 11:06:20'),
(477351, '28500.00', '2019-02-20 11:06:24'),
(477356, '28501.00', '2019-02-20 11:06:30'),
(477359, '28502.00', '2019-02-20 11:06:34'),
(477363, '28503.00', '2019-02-20 11:06:40'),
(477367, '28504.00', '2019-02-20 11:06:45'),
(477372, '28503.00', '2019-02-20 11:06:50'),
(477377, '28495.00', '2019-02-20 11:06:57'),
(477389, '28497.00', '2019-02-20 11:07:04'),
(477398, '28499.00', '2019-02-20 11:07:09'),
(477403, '28497.00', '2019-02-20 11:07:14'),
(477406, '28500.00', '2019-02-20 11:07:19'),
(477410, '28505.00', '2019-02-20 11:07:24'),
(477414, '28508.00', '2019-02-20 11:07:29'),
(477419, '28508.00', '2019-02-20 11:07:33'),
(477423, '28506.00', '2019-02-20 11:07:39'),
(477427, '28505.00', '2019-02-20 11:07:44'),
(477431, '28500.00', '2019-02-20 11:07:49'),
(477435, '28504.00', '2019-02-20 11:07:53'),
(477442, '28500.00', '2019-02-20 11:07:58'),
(477448, '28502.00', '2019-02-20 11:08:04'),
(477458, '28503.00', '2019-02-20 11:08:09'),
(477462, '28507.00', '2019-02-20 11:08:14'),
(477466, '28511.00', '2019-02-20 11:08:19'),
(477470, '28513.00', '2019-02-20 11:08:24'),
(477474, '28513.00', '2019-02-20 11:08:29'),
(477479, '28510.00', '2019-02-20 11:08:33'),
(477483, '28509.00', '2019-02-20 11:08:39'),
(477487, '28508.00', '2019-02-20 11:08:44'),
(477491, '28510.00', '2019-02-20 11:08:49'),
(477495, '28507.00', '2019-02-20 11:08:54'),
(477500, '28505.00', '2019-02-20 11:08:59'),
(477510, '28506.00', '2019-02-20 11:09:04'),
(477517, '28508.00', '2019-02-20 11:09:09'),
(477522, '28509.00', '2019-02-20 11:09:13'),
(477526, '28510.00', '2019-02-20 11:09:19'),
(477530, '28509.00', '2019-02-20 11:09:24'),
(477534, '28506.00', '2019-02-20 11:09:28'),
(477538, '28507.00', '2019-02-20 11:09:33'),
(477543, '28506.00', '2019-02-20 11:09:39'),
(477547, '28509.00', '2019-02-20 11:09:44'),
(477551, '28513.00', '2019-02-20 11:09:49'),
(477555, '28506.00', '2019-02-20 11:09:54'),
(477561, '28511.00', '2019-02-20 11:09:59'),
(477570, '28512.00', '2019-02-20 11:10:04'),
(477577, '28510.00', '2019-02-20 11:10:09'),
(477583, '28506.00', '2019-02-20 11:10:14'),
(477587, '28504.00', '2019-02-20 11:10:19'),
(477591, '28504.00', '2019-02-20 11:10:24'),
(477595, '28508.00', '2019-02-20 11:10:29'),
(477599, '28510.00', '2019-02-20 11:10:33'),
(477603, '28509.00', '2019-02-20 11:10:39'),
(477607, '28506.00', '2019-02-20 11:10:44'),
(477611, '28503.00', '2019-02-20 11:10:49'),
(477616, '28504.00', '2019-02-20 11:10:54'),
(477622, '28502.00', '2019-02-20 11:10:58'),
(477631, '28502.00', '2019-02-20 11:11:04'),
(477638, '28509.00', '2019-02-20 11:11:09'),
(477642, '28509.00', '2019-02-20 11:11:14'),
(477646, '28514.00', '2019-02-20 11:11:19'),
(477650, '28512.00', '2019-02-20 11:11:24'),
(477654, '28508.00', '2019-02-20 11:11:28'),
(477658, '28509.00', '2019-02-20 11:11:33'),
(477662, '28507.00', '2019-02-20 11:11:38'),
(477667, '28513.00', '2019-02-20 11:11:43'),
(477671, '28512.00', '2019-02-20 11:11:49'),
(477675, '28511.00', '2019-02-20 11:11:53'),
(477681, '28511.00', '2019-02-20 11:11:59'),
(477689, '28510.00', '2019-02-20 11:12:04'),
(477698, '28515.00', '2019-02-20 11:12:09'),
(477703, '28513.00', '2019-02-20 11:12:14'),
(477706, '28513.00', '2019-02-20 11:12:19'),
(477710, '28511.00', '2019-02-20 11:12:24'),
(477715, '28511.00', '2019-02-20 11:12:29'),
(477719, '28506.00', '2019-02-20 11:12:34'),
(477723, '28506.00', '2019-02-20 11:12:39'),
(477727, '28505.00', '2019-02-20 11:12:44'),
(477731, '28508.00', '2019-02-20 11:12:49'),
(477735, '28508.00', '2019-02-20 11:12:54'),
(477742, '28513.00', '2019-02-20 11:12:59'),
(477750, '28512.00', '2019-02-20 11:13:04'),
(477759, '28511.00', '2019-02-20 11:13:08'),
(477763, '28511.00', '2019-02-20 11:13:13'),
(477767, '28513.00', '2019-02-20 11:13:18'),
(477771, '28510.00', '2019-02-20 11:13:24'),
(477776, '28511.00', '2019-02-20 11:13:29'),
(477779, '28512.00', '2019-02-20 11:13:34'),
(477783, '28510.00', '2019-02-20 11:13:39'),
(477788, '28510.00', '2019-02-20 11:13:43'),
(477792, '28510.00', '2019-02-20 11:13:49'),
(477796, '28508.00', '2019-02-20 11:13:53'),
(477802, '28508.00', '2019-02-20 11:13:59'),
(477812, '28503.00', '2019-02-20 11:14:05'),
(477819, '28507.00', '2019-02-20 11:14:10'),
(477823, '28505.00', '2019-02-20 11:14:14'),
(477827, '28505.00', '2019-02-20 11:14:20'),
(477831, '28507.00', '2019-02-20 11:14:25'),
(477837, '28508.00', '2019-02-20 11:14:30'),
(477840, '28509.00', '2019-02-20 11:14:35'),
(477844, '28506.00', '2019-02-20 11:14:40'),
(477848, '28506.00', '2019-02-20 11:14:44'),
(477852, '28505.00', '2019-02-20 11:14:50'),
(477856, '28505.00', '2019-02-20 11:14:55'),
(477865, '28506.00', '2019-02-20 11:15:00'),
(477872, '28505.00', '2019-02-20 11:15:05'),
(477879, '28503.00', '2019-02-20 11:15:10'),
(477884, '28501.00', '2019-02-20 11:15:15'),
(477888, '28502.00', '2019-02-20 11:15:20'),
(477892, '28502.00', '2019-02-20 11:15:25'),
(477897, '28505.00', '2019-02-20 11:15:29'),
(477900, '28506.00', '2019-02-20 11:15:34'),
(477905, '28507.00', '2019-02-20 11:15:40'),
(477908, '28510.00', '2019-02-20 11:15:45'),
(477913, '28509.00', '2019-02-20 11:15:50'),
(477917, '28510.00', '2019-02-20 11:15:55'),
(477926, '28509.00', '2019-02-20 11:16:00'),
(477934, '28509.00', '2019-02-20 11:16:05'),
(477939, '28510.00', '2019-02-20 11:16:10'),
(477944, '28503.00', '2019-02-20 11:16:15'),
(477947, '28501.00', '2019-02-20 11:16:20'),
(477951, '28493.00', '2019-02-20 11:16:25'),
(477957, '28496.00', '2019-02-20 11:16:30'),
(477960, '28488.00', '2019-02-20 11:16:35'),
(477964, '28486.00', '2019-02-20 11:16:40'),
(477968, '28481.00', '2019-02-20 11:16:45'),
(477972, '28487.00', '2019-02-20 11:16:50'),
(477976, '28493.00', '2019-02-20 11:16:55'),
(477986, '28489.00', '2019-02-20 11:17:00'),
(477992, '28491.00', '2019-02-20 11:17:05'),
(477999, '28492.00', '2019-02-20 11:17:10'),
(478004, '28490.00', '2019-02-20 11:17:14'),
(478008, '28491.00', '2019-02-20 11:17:19'),
(478012, '28494.00', '2019-02-20 11:17:25'),
(478017, '28494.00', '2019-02-20 11:17:31'),
(478020, '28496.00', '2019-02-20 11:17:35'),
(478024, '28496.00', '2019-02-20 11:17:40'),
(478028, '28496.00', '2019-02-20 11:17:44'),
(478032, '28491.00', '2019-02-20 11:17:50'),
(478037, '28488.00', '2019-02-20 11:17:54'),
(478046, '28491.00', '2019-02-20 11:18:00'),
(478052, '28493.00', '2019-02-20 11:18:05'),
(478059, '28497.00', '2019-02-20 11:18:10'),
(478063, '28498.00', '2019-02-20 11:18:15'),
(478067, '28496.00', '2019-02-20 11:18:21'),
(478072, '28500.00', '2019-02-20 11:18:26'),
(478076, '28498.00', '2019-02-20 11:18:30'),
(478080, '28494.00', '2019-02-20 11:18:34'),
(478084, '28498.00', '2019-02-20 11:18:40'),
(478088, '28495.00', '2019-02-20 11:18:46'),
(478092, '28491.00', '2019-02-20 11:18:50'),
(478096, '28489.00', '2019-02-20 11:18:56'),
(478105, '28489.00', '2019-02-20 11:19:00'),
(478112, '28485.00', '2019-02-20 11:19:05'),
(478119, '28483.00', '2019-02-20 11:19:11'),
(478123, '28484.00', '2019-02-20 11:19:16'),
(478127, '28475.00', '2019-02-20 11:19:20'),
(478132, '28476.00', '2019-02-20 11:19:26'),
(478137, '28476.00', '2019-02-20 11:19:30'),
(478140, '28473.00', '2019-02-20 11:19:35'),
(478144, '28469.00', '2019-02-20 11:19:41'),
(478149, '28468.00', '2019-02-20 11:19:46'),
(478152, '28471.00', '2019-02-20 11:19:51'),
(478157, '28471.00', '2019-02-20 11:19:56'),
(478165, '28462.00', '2019-02-20 11:20:00'),
(478172, '28459.00', '2019-02-20 11:20:06'),
(478179, '28457.00', '2019-02-20 11:20:11'),
(478183, '28454.00', '2019-02-20 11:20:16'),
(478187, '28454.00', '2019-02-20 11:20:20'),
(478192, '28458.00', '2019-02-20 11:20:26'),
(478196, '28459.00', '2019-02-20 11:20:31'),
(478200, '28458.00', '2019-02-20 11:20:36'),
(478204, '28454.00', '2019-02-20 11:20:41'),
(478208, '28457.00', '2019-02-20 11:20:46'),
(478212, '28458.00', '2019-02-20 11:20:50'),
(478216, '28456.00', '2019-02-20 11:20:54'),
(478224, '28458.00', '2019-02-20 11:20:56'),
(478232, '28459.00', '2019-02-20 11:21:05'),
(478239, '28458.00', '2019-02-20 11:21:10'),
(478243, '28456.00', '2019-02-20 11:21:16'),
(478248, '28456.00', '2019-02-20 11:21:20'),
(478253, '28454.00', '2019-02-20 11:21:26'),
(478257, '28452.00', '2019-02-20 11:21:32'),
(478261, '28453.00', '2019-02-20 11:21:36'),
(478267, '28446.00', '2019-02-20 11:21:44'),
(478272, '28451.00', '2019-02-20 11:21:49'),
(478276, '28450.00', '2019-02-20 11:21:54');

-- --------------------------------------------------------

--
-- 表的结构 `data_meitong`
--

CREATE TABLE `data_meitong` (
  `id` int(11) NOT NULL,
  `price` varchar(30) DEFAULT NULL,
  `time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `data_nazhi`
--

CREATE TABLE `data_nazhi` (
  `id` int(11) NOT NULL,
  `price` varchar(30) DEFAULT NULL,
  `time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `data_necla0`
--

CREATE TABLE `data_necla0` (
  `id` int(11) NOT NULL,
  `price` varchar(30) DEFAULT NULL,
  `time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `data_necla0`
--

INSERT INTO `data_necla0` (`id`, `price`, `time`) VALUES
(859180, '51.39', '2019-01-14 10:49:00'),
(859184, '51.39', '2019-01-14 10:49:24'),
(859187, '51.39', '2019-01-14 10:49:27'),
(859189, '51.39', '2019-01-14 10:49:29'),
(859193, '51.37', '2019-01-14 10:49:44'),
(859195, '51.33', '2019-01-14 10:49:49'),
(859197, '51.35', '2019-01-14 10:49:54'),
(859202, '51.01', '2019-01-14 11:32:16'),
(859203, '51.03', '2019-01-14 11:33:05'),
(859205, '51.03', '2019-01-14 11:33:10'),
(859206, '51.10', '2019-01-14 11:38:00'),
(859214, '51.11', '2019-01-14 11:38:10'),
(859221, '51.11', '2019-01-14 11:38:14'),
(859229, '51.11', '2019-01-14 11:38:19'),
(859235, '51.10', '2019-01-14 11:38:23'),
(859243, '51.09', '2019-01-14 11:38:29'),
(859250, '51.10', '2019-01-14 11:38:32'),
(859265, '51.09', '2019-01-14 11:38:45'),
(859272, '51.10', '2019-01-14 11:38:50'),
(859279, '51.10', '2019-01-14 11:38:55'),
(859283, '51.13', '2019-01-14 11:44:30'),
(859284, '51.13', '2019-01-14 11:46:28'),
(859285, '51.12', '2019-01-14 11:48:58'),
(859286, '51.11', '2019-01-14 11:49:03'),
(859287, '51.09', '2019-01-14 12:11:54'),
(859290, '51.08', '2019-01-14 12:12:01'),
(859293, '51.09', '2019-01-14 12:12:03'),
(859296, '51.08', '2019-01-14 12:12:11'),
(859302, '51.09', '2019-01-14 12:12:23'),
(859305, '51.09', '2019-01-14 12:12:24'),
(859308, '51.09', '2019-01-14 12:12:33'),
(859314, '51.09', '2019-01-14 12:12:41'),
(859317, '51.09', '2019-01-14 12:12:46'),
(859323, '51.09', '2019-01-14 12:12:57'),
(859329, '51.11', '2019-01-14 12:13:02'),
(859334, '51.11', '2019-01-14 12:13:06'),
(859341, '51.12', '2019-01-14 12:13:12'),
(859346, '51.11', '2019-01-14 12:13:14'),
(859352, '51.12', '2019-01-14 12:13:21'),
(859370, '51.11', '2019-01-14 12:13:34'),
(859374, '51.12', '2019-01-14 12:13:40'),
(859376, '51.11', '2019-01-14 12:13:47'),
(859379, '51.11', '2019-01-14 12:13:51'),
(859382, '51.11', '2019-01-14 12:13:55'),
(859388, '51.12', '2019-01-14 12:13:59'),
(859394, '51.13', '2019-01-14 12:14:06'),
(859399, '51.13', '2019-01-14 12:14:09'),
(859416, '51.12', '2019-01-14 12:14:26'),
(859432, '51.13', '2019-01-14 12:14:39'),
(859435, '51.14', '2019-01-14 12:14:47'),
(859438, '51.13', '2019-01-14 12:14:52'),
(859447, '51.12', '2019-01-14 12:15:02'),
(859452, '51.12', '2019-01-14 12:15:07'),
(859458, '51.13', '2019-01-14 12:15:11'),
(859464, '51.12', '2019-01-14 12:15:17'),
(859469, '51.12', '2019-01-14 12:15:21'),
(859486, '51.12', '2019-01-14 12:15:37'),
(859492, '51.12', '2019-01-14 12:15:42'),
(859496, '51.11', '2019-01-14 12:15:47'),
(859501, '51.12', '2019-01-14 12:15:55'),
(859513, '51.11', '2019-01-14 12:16:04'),
(859519, '51.11', '2019-01-14 12:16:11'),
(859524, '51.11', '2019-01-14 12:16:15'),
(859535, '51.08', '2019-01-14 12:16:27'),
(859558, '51.09', '2019-01-14 12:16:52'),
(859561, '51.09', '2019-01-14 12:16:55'),
(859567, '51.09', '2019-01-14 12:16:59'),
(859573, '51.10', '2019-01-14 12:17:04'),
(859578, '51.09', '2019-01-14 12:17:10'),
(859590, '51.09', '2019-01-14 12:17:21'),
(859601, '51.09', '2019-01-14 12:17:32'),
(859616, '51.09', '2019-01-14 12:17:44'),
(859620, '51.10', '2019-01-14 12:17:53'),
(859622, '51.09', '2019-01-14 12:17:56'),
(859646, '51.08', '2019-01-14 12:18:17'),
(859652, '51.09', '2019-01-14 12:18:21'),
(859657, '51.09', '2019-01-14 12:18:25'),
(859674, '51.08', '2019-01-14 12:18:40'),
(859679, '51.08', '2019-01-14 12:18:52'),
(859682, '51.08', '2019-01-14 12:18:58'),
(859688, '51.08', '2019-01-14 12:19:00'),
(859694, '51.09', '2019-01-14 12:19:07'),
(859700, '51.08', '2019-01-14 12:19:12'),
(859728, '51.07', '2019-01-14 12:19:38'),
(859733, '51.08', '2019-01-14 12:19:42'),
(859736, '51.07', '2019-01-14 12:19:48'),
(859748, '51.08', '2019-01-14 12:20:02'),
(859754, '51.07', '2019-01-14 12:20:08'),
(859765, '51.07', '2019-01-14 12:20:17'),
(859782, '51.08', '2019-01-14 12:20:30'),
(859788, '51.09', '2019-01-14 12:20:38'),
(859793, '51.08', '2019-01-14 12:20:39'),
(859796, '51.09', '2019-01-14 12:20:44'),
(859798, '51.09', '2019-01-14 12:20:52'),
(859812, '51.09', '2019-01-14 12:21:08'),
(859817, '51.10', '2019-01-14 12:21:09'),
(859823, '51.10', '2019-01-14 12:21:17'),
(859834, '51.10', '2019-01-14 12:21:27'),
(859854, '51.09', '2019-01-14 12:21:48'),
(859857, '51.10', '2019-01-14 12:21:53'),
(859865, '51.09', '2019-01-14 12:21:59'),
(859871, '51.10', '2019-01-14 12:22:07'),
(859877, '51.09', '2019-01-14 12:22:10'),
(859887, '51.10', '2019-01-14 12:22:23'),
(859897, '51.10', '2019-01-14 12:22:33'),
(859907, '51.09', '2019-01-14 12:22:43'),
(859917, '51.10', '2019-01-14 12:22:50'),
(859920, '51.09', '2019-01-14 12:22:57'),
(859931, '51.09', '2019-01-14 12:23:05'),
(859936, '51.10', '2019-01-14 12:23:10'),
(859942, '51.10', '2019-01-14 12:23:16'),
(859958, '51.10', '2019-01-14 12:23:32'),
(859968, '51.10', '2019-01-14 12:23:38'),
(859977, '51.10', '2019-01-14 12:23:52'),
(859986, '51.10', '2019-01-14 12:24:02'),
(859990, '51.09', '2019-01-14 12:24:07'),
(860016, '51.09', '2019-01-14 12:24:30'),
(860035, '51.10', '2019-01-14 12:24:53'),
(860039, '51.09', '2019-01-14 12:24:56'),
(860050, '51.08', '2019-01-14 12:25:07'),
(860055, '51.08', '2019-01-14 12:25:12'),
(860060, '51.09', '2019-01-14 12:25:14'),
(860065, '51.08', '2019-01-14 12:25:21'),
(860070, '51.07', '2019-01-14 12:25:28'),
(860075, '51.06', '2019-01-14 12:25:33'),
(860080, '51.06', '2019-01-14 12:25:35'),
(860085, '51.06', '2019-01-14 12:25:39'),
(860106, '51.07', '2019-01-14 12:26:01'),
(860111, '51.08', '2019-01-14 12:26:04'),
(860117, '51.08', '2019-01-14 12:26:12'),
(860123, '51.06', '2019-01-14 12:26:17'),
(860127, '51.08', '2019-01-14 12:26:22'),
(860133, '51.07', '2019-01-14 12:26:24'),
(860149, '51.08', '2019-01-14 12:26:43'),
(860155, '51.08', '2019-01-14 12:26:46'),
(860158, '51.08', '2019-01-14 12:26:51'),
(860172, '51.09', '2019-01-14 12:27:04'),
(860178, '51.09', '2019-01-14 12:27:10'),
(860188, '51.08', '2019-01-14 12:27:20'),
(860198, '51.09', '2019-01-14 12:27:29'),
(860202, '51.10', '2019-01-14 12:27:38'),
(860208, '51.11', '2019-01-14 12:27:42'),
(860210, '51.10', '2019-01-14 12:27:48'),
(860217, '51.10', '2019-01-14 12:27:53'),
(860227, '51.10', '2019-01-14 12:28:06'),
(860237, '51.09', '2019-01-14 12:28:18'),
(860247, '51.09', '2019-01-14 12:28:26'),
(860296, '51.10', '2019-01-14 12:29:17'),
(860301, '51.09', '2019-01-14 12:29:22'),
(860311, '51.08', '2019-01-14 12:29:32'),
(860315, '51.09', '2019-01-14 12:29:37'),
(860319, '51.08', '2019-01-14 12:29:39'),
(860323, '51.07', '2019-01-14 12:29:48'),
(860327, '51.06', '2019-01-14 12:29:49'),
(860332, '51.07', '2019-01-14 12:29:56'),
(860340, '51.06', '2019-01-14 12:30:00'),
(860344, '51.06', '2019-01-14 12:30:08'),
(860350, '51.06', '2019-01-14 12:30:10'),
(860370, '51.07', '2019-01-14 12:30:33'),
(860374, '51.06', '2019-01-14 12:30:35'),
(860380, '51.07', '2019-01-14 12:30:43'),
(860384, '51.07', '2019-01-14 12:30:45'),
(860392, '51.08', '2019-01-14 12:30:56'),
(860397, '51.06', '2019-01-14 12:31:00'),
(860403, '51.07', '2019-01-14 12:31:05'),
(860412, '51.08', '2019-01-14 12:31:15'),
(860417, '51.07', '2019-01-14 12:31:21'),
(860428, '51.07', '2019-01-14 12:31:31'),
(860434, '51.07', '2019-01-14 12:31:33'),
(860506, '51.07', '2019-01-14 12:32:41'),
(860512, '51.07', '2019-01-14 12:32:45'),
(860518, '51.08', '2019-01-14 12:32:52'),
(860521, '51.08', '2019-01-14 12:32:56'),
(860535, '51.08', '2019-01-14 12:33:07'),
(860543, '51.07', '2019-01-14 12:33:14'),
(860549, '51.07', '2019-01-14 12:33:19'),
(860555, '51.07', '2019-01-14 12:33:27'),
(860560, '51.06', '2019-01-14 12:33:33'),
(860586, '51.06', '2019-01-14 12:33:59'),
(860604, '51.07', '2019-01-14 12:34:18'),
(860608, '51.07', '2019-01-14 12:34:21'),
(860614, '51.08', '2019-01-14 12:34:27'),
(860626, '51.08', '2019-01-14 12:34:36'),
(860632, '51.06', '2019-01-14 12:34:43'),
(860642, '51.07', '2019-01-14 12:34:58'),
(860652, '51.07', '2019-01-14 12:35:06'),
(860664, '51.06', '2019-01-14 12:35:16'),
(860668, '51.06', '2019-01-14 12:35:22'),
(860679, '51.07', '2019-01-14 12:35:29'),
(860684, '51.06', '2019-01-14 12:35:37'),
(860690, '51.07', '2019-01-14 12:35:41'),
(860703, '51.07', '2019-01-14 12:35:58'),
(860705, '51.08', '2019-01-14 12:36:02'),
(860711, '51.07', '2019-01-14 12:36:09'),
(860721, '51.08', '2019-01-14 12:36:19'),
(860725, '51.07', '2019-01-14 12:36:20'),
(860739, '51.08', '2019-01-14 12:36:36'),
(860744, '51.07', '2019-01-14 12:36:40'),
(860755, '51.07', '2019-01-14 12:36:49'),
(860774, '51.06', '2019-01-14 12:37:12'),
(860780, '51.07', '2019-01-14 12:37:17'),
(860798, '51.06', '2019-01-14 12:37:29'),
(860808, '51.06', '2019-01-14 12:37:40'),
(860817, '51.06', '2019-01-14 12:37:49'),
(860826, '51.06', '2019-01-14 12:38:02'),
(860847, '51.04', '2019-01-14 12:38:22'),
(860848, '56.03', '2019-02-20 10:23:12'),
(860959, '56.03', '2019-02-20 10:24:59'),
(860998, '56.03', '2019-02-20 10:25:28'),
(861020, '56.03', '2019-02-20 10:25:55'),
(861041, '56.03', '2019-02-20 10:26:12'),
(861058, '56.03', '2019-02-20 10:26:29'),
(861067, '56.03', '2019-02-20 10:26:39'),
(861070, '56.03', '2019-02-20 10:26:47'),
(861074, '56.03', '2019-02-20 10:26:50'),
(861079, '56.03', '2019-02-20 10:26:54'),
(861105, '56.03', '2019-02-20 10:27:18'),
(861117, '56.03', '2019-02-20 10:27:31'),
(861154, '56.03', '2019-02-20 10:29:01'),
(861183, '56.03', '2019-02-20 10:29:35'),
(861209, '56.03', '2019-02-20 10:30:01'),
(861222, '56.03', '2019-02-20 10:30:12'),
(861226, '56.03', '2019-02-20 10:30:14'),
(861231, '56.03', '2019-02-20 10:30:20'),
(861239, '56.03', '2019-02-20 10:30:30'),
(861247, '56.03', '2019-02-20 10:30:40'),
(861251, '56.03', '2019-02-20 10:30:49'),
(861255, '56.03', '2019-02-20 10:30:52'),
(861282, '56.03', '2019-02-20 10:31:13'),
(861286, '56.03', '2019-02-20 10:31:18'),
(861291, '56.03', '2019-02-20 10:31:23'),
(861298, '56.03', '2019-02-20 10:31:33'),
(861304, '56.03', '2019-02-20 10:31:37'),
(861315, '56.03', '2019-02-20 10:31:54'),
(861330, '56.03', '2019-02-20 10:32:04'),
(861463, '56.03', '2019-02-20 10:33:13'),
(861467, '56.03', '2019-02-20 10:33:18'),
(861471, '56.03', '2019-02-20 10:33:21'),
(861475, '56.03', '2019-02-20 10:33:24'),
(861510, '56.03', '2019-02-20 10:34:01'),
(861526, '56.03', '2019-02-20 10:34:19'),
(861569, '56.03', '2019-02-20 10:35:03'),
(861587, '56.03', '2019-02-20 10:35:18'),
(861595, '56.03', '2019-02-20 10:35:27'),
(861604, '56.03', '2019-02-20 10:35:39'),
(861607, '56.03', '2019-02-20 10:35:42'),
(861651, '56.03', '2019-02-20 10:36:23'),
(861663, '56.03', '2019-02-20 10:36:37'),
(861667, '56.03', '2019-02-20 10:36:44'),
(861671, '56.03', '2019-02-20 10:36:45'),
(861675, '56.03', '2019-02-20 10:36:54'),
(861689, '56.03', '2019-02-20 10:37:03'),
(861698, '56.03', '2019-02-20 10:37:08'),
(861711, '56.03', '2019-02-20 10:37:21'),
(861719, '56.03', '2019-02-20 10:37:33'),
(861723, '56.03', '2019-02-20 10:37:36'),
(861741, '56.03', '2019-02-20 10:37:56'),
(861771, '56.03', '2019-02-20 10:38:24'),
(861775, '56.03', '2019-02-20 10:38:26'),
(861786, '56.03', '2019-02-20 10:41:54'),
(861789, '56.03', '2019-02-20 10:42:01'),
(861793, '56.03', '2019-02-20 10:42:08'),
(861801, '56.17', '2019-02-20 10:42:18'),
(861806, '56.17', '2019-02-20 10:42:24'),
(861818, '56.17', '2019-02-20 10:42:35'),
(861822, '56.17', '2019-02-20 10:42:44'),
(861826, '56.17', '2019-02-20 10:42:45'),
(861870, '56.17', '2019-02-20 10:43:28'),
(861874, '56.17', '2019-02-20 10:43:31'),
(861878, '56.17', '2019-02-20 10:43:36'),
(861905, '56.17', '2019-02-20 10:44:00'),
(861921, '56.17', '2019-02-20 10:44:19'),
(861926, '56.17', '2019-02-20 10:44:23'),
(861938, '56.17', '2019-02-20 10:44:38'),
(861952, '56.17', '2019-02-20 10:44:52'),
(861965, '56.17', '2019-02-20 10:45:02'),
(861973, '56.17', '2019-02-20 10:45:07'),
(861986, '56.17', '2019-02-20 10:45:22'),
(861990, '56.17', '2019-02-20 10:45:25'),
(861994, '56.17', '2019-02-20 10:45:30'),
(861999, '56.17', '2019-02-20 10:45:39'),
(862002, '56.17', '2019-02-20 10:45:43'),
(862006, '56.17', '2019-02-20 10:45:47'),
(862033, '56.17', '2019-02-20 10:46:05'),
(862037, '56.17', '2019-02-20 10:46:10'),
(862041, '56.17', '2019-02-20 10:46:15'),
(862050, '56.17', '2019-02-20 10:46:28'),
(862062, '56.17', '2019-02-20 10:46:42'),
(862066, '56.31', '2019-02-20 10:46:49'),
(862070, '56.31', '2019-02-20 10:46:54'),
(862076, '56.31', '2019-02-20 10:46:58'),
(862084, '56.31', '2019-02-20 10:47:00'),
(862093, '56.31', '2019-02-20 10:47:09'),
(862097, '56.31', '2019-02-20 10:47:13'),
(862101, '56.31', '2019-02-20 10:47:18'),
(862107, '56.31', '2019-02-20 10:47:23'),
(862114, '56.31', '2019-02-20 10:47:32'),
(862131, '56.26', '2019-02-20 10:47:54'),
(862136, '56.26', '2019-02-20 10:47:58'),
(862145, '56.26', '2019-02-20 10:48:04'),
(862153, '56.26', '2019-02-20 10:48:08'),
(862158, '56.26', '2019-02-20 10:48:13'),
(862170, '56.26', '2019-02-20 10:48:27'),
(862174, '56.26', '2019-02-20 10:48:32'),
(862179, '56.26', '2019-02-20 10:48:36'),
(862183, '56.26', '2019-02-20 10:48:40'),
(862187, '56.26', '2019-02-20 10:48:47'),
(862197, '56.26', '2019-02-20 10:48:57'),
(862213, '56.26', '2019-02-20 10:49:09'),
(862221, '56.26', '2019-02-20 10:49:19'),
(862234, '56.29', '2019-02-20 10:49:33'),
(862238, '56.29', '2019-02-20 10:49:38'),
(862266, '56.27', '2019-02-20 10:50:03'),
(862277, '56.27', '2019-02-20 10:50:12'),
(862282, '56.27', '2019-02-20 10:50:18'),
(862290, '56.27', '2019-02-20 10:50:25'),
(862294, '56.27', '2019-02-20 10:50:30'),
(862298, '56.27', '2019-02-20 10:50:37'),
(862302, '56.27', '2019-02-20 10:50:40'),
(862317, '56.27', '2019-02-20 10:50:59'),
(862325, '56.27', '2019-02-20 10:51:01'),
(862334, '56.27', '2019-02-20 10:51:08'),
(862346, '56.27', '2019-02-20 10:51:23'),
(862358, '56.30', '2019-02-20 10:51:35'),
(862363, '56.30', '2019-02-20 10:51:42'),
(862431, '56.30', '2019-02-20 10:52:51'),
(862458, '56.30', '2019-02-20 10:53:13'),
(862462, '56.30', '2019-02-20 10:53:17'),
(862470, '56.30', '2019-02-20 10:53:26'),
(862478, '56.30', '2019-02-20 10:53:39'),
(862482, '56.30', '2019-02-20 10:53:41'),
(862487, '56.30', '2019-02-20 10:53:45'),
(862497, '56.30', '2019-02-20 10:53:59'),
(862505, '56.30', '2019-02-20 10:54:04'),
(862513, '56.30', '2019-02-20 10:54:06'),
(862517, '56.30', '2019-02-20 10:54:12'),
(862522, '56.30', '2019-02-20 10:54:16'),
(862551, '56.30', '2019-02-20 10:54:50'),
(862582, '56.30', '2019-02-20 10:55:16'),
(862598, '56.30', '2019-02-20 10:55:37'),
(862606, '56.30', '2019-02-20 10:55:46'),
(862625, '56.30', '2019-02-20 10:56:01'),
(862646, '56.30', '2019-02-20 10:56:21'),
(862650, '56.30', '2019-02-20 10:56:29'),
(862677, '56.30', '2019-02-20 10:56:59'),
(862693, '56.30', '2019-02-20 10:57:05'),
(862697, '56.30', '2019-02-20 10:57:10'),
(862710, '56.30', '2019-02-20 10:57:29'),
(862718, '56.30', '2019-02-20 10:57:38'),
(862727, '56.30', '2019-02-20 10:57:47'),
(862753, '56.30', '2019-02-20 10:58:07'),
(862761, '56.30', '2019-02-20 10:58:17'),
(862830, '56.30', '2019-02-20 10:59:29'),
(862859, '56.30', '2019-02-20 10:59:59'),
(862866, '56.30', '2019-02-20 11:00:01'),
(862895, '56.30', '2019-02-20 11:00:32'),
(862899, '56.30', '2019-02-20 11:00:37'),
(862903, '56.30', '2019-02-20 11:00:42'),
(862920, '56.30', '2019-02-20 11:00:55'),
(862933, '56.30', '2019-02-20 11:01:07'),
(862942, '56.30', '2019-02-20 11:01:15'),
(862946, '56.30', '2019-02-20 11:01:24'),
(862958, '56.30', '2019-02-20 11:01:39'),
(862967, '56.30', '2019-02-20 11:01:50'),
(862971, '56.30', '2019-02-20 11:01:51'),
(862977, '56.30', '2019-02-20 11:01:59'),
(862985, '56.30', '2019-02-20 11:02:04'),
(863019, '56.30', '2019-02-20 11:02:40'),
(863031, '56.30', '2019-02-20 11:02:52'),
(863037, '56.30', '2019-02-20 11:02:59'),
(863061, '56.30', '2019-02-20 11:03:17'),
(863092, '56.30', '2019-02-20 11:03:53'),
(863117, '56.30', '2019-02-20 11:04:08'),
(863146, '56.30', '2019-02-20 11:04:49'),
(863182, '56.37', '2019-02-20 11:05:19'),
(863199, '56.37', '2019-02-20 11:05:37'),
(863203, '56.37', '2019-02-20 11:05:42'),
(863211, '56.37', '2019-02-20 11:05:54'),
(863220, '56.37', '2019-02-20 11:05:59'),
(863225, '56.37', '2019-02-20 11:06:05'),
(863234, '56.37', '2019-02-20 11:06:07'),
(863246, '56.37', '2019-02-20 11:06:23'),
(863251, '56.37', '2019-02-20 11:06:26'),
(863254, '56.37', '2019-02-20 11:06:34'),
(863267, '56.37', '2019-02-20 11:06:47'),
(863285, '56.37', '2019-02-20 11:06:58'),
(863293, '56.37', '2019-02-20 11:07:07'),
(863326, '56.37', '2019-02-20 11:07:45'),
(863365, '56.37', '2019-02-20 11:08:22'),
(863369, '56.37', '2019-02-20 11:08:27'),
(863446, '56.37', '2019-02-20 11:09:47'),
(863472, '56.37', '2019-02-20 11:10:09'),
(863478, '56.37', '2019-02-20 11:10:11'),
(863507, '56.37', '2019-02-20 11:10:45'),
(863541, '56.37', '2019-02-20 11:11:15'),
(863562, '56.37', '2019-02-20 11:11:43'),
(863570, '56.37', '2019-02-20 11:11:52'),
(863576, '56.37', '2019-02-20 11:11:57'),
(863584, '56.37', '2019-02-20 11:12:02'),
(863593, '56.37', '2019-02-20 11:12:05'),
(863599, '56.37', '2019-02-20 11:12:14'),
(863610, '56.37', '2019-02-20 11:12:28'),
(863614, '56.37', '2019-02-20 11:12:30'),
(863618, '56.37', '2019-02-20 11:12:36'),
(863622, '56.37', '2019-02-20 11:12:40'),
(863626, '56.37', '2019-02-20 11:12:48'),
(863630, '56.37', '2019-02-20 11:12:51'),
(863654, '56.37', '2019-02-20 11:13:08'),
(863658, '56.37', '2019-02-20 11:13:13'),
(863666, '56.37', '2019-02-20 11:13:20'),
(863674, '56.39', '2019-02-20 11:13:32'),
(863678, '56.39', '2019-02-20 11:13:36'),
(863687, '56.39', '2019-02-20 11:13:47'),
(863697, '56.39', '2019-02-20 11:13:57'),
(863714, '56.39', '2019-02-20 11:14:08'),
(863722, '56.39', '2019-02-20 11:14:20'),
(863735, '56.39', '2019-02-20 11:14:35'),
(863739, '56.39', '2019-02-20 11:14:36'),
(863761, '56.39', '2019-02-20 11:15:00'),
(863808, '56.39', '2019-02-20 11:15:49'),
(863820, '56.39', '2019-02-20 11:15:59'),
(863829, '56.39', '2019-02-20 11:16:05'),
(863842, '56.39', '2019-02-20 11:16:17'),
(863846, '56.39', '2019-02-20 11:16:21'),
(863855, '56.39', '2019-02-20 11:16:33'),
(863859, '56.39', '2019-02-20 11:16:39'),
(863887, '56.39', '2019-02-20 11:17:02'),
(863903, '56.39', '2019-02-20 11:17:18'),
(863907, '56.39', '2019-02-20 11:17:24'),
(863927, '56.39', '2019-02-20 11:17:50'),
(863947, '56.39', '2019-02-20 11:18:02'),
(863979, '56.39', '2019-02-20 11:18:40'),
(863983, '56.39', '2019-02-20 11:18:44'),
(863987, '56.39', '2019-02-20 11:18:48'),
(863991, '56.39', '2019-02-20 11:18:56'),
(864014, '56.39', '2019-02-20 11:19:11'),
(864039, '56.39', '2019-02-20 11:19:39'),
(864052, '56.39', '2019-02-20 11:19:54'),
(864061, '56.39', '2019-02-20 11:19:56'),
(864074, '56.39', '2019-02-20 11:20:06'),
(864099, '56.39', '2019-02-20 11:20:38'),
(864111, '56.39', '2019-02-20 11:20:54'),
(864127, '56.39', '2019-02-20 11:21:04'),
(864156, '56.39', '2019-02-20 11:21:36');

-- --------------------------------------------------------

--
-- 表的结构 `data_nenga0`
--

CREATE TABLE `data_nenga0` (
  `id` int(11) NOT NULL,
  `price` varchar(30) DEFAULT NULL,
  `time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `data_nenga0`
--

INSERT INTO `data_nenga0` (`id`, `price`, `time`) VALUES
(778209, '3.294', '2019-01-14 10:48:57'),
(778217, '3.293', '2019-01-14 10:49:39'),
(778219, '3.290', '2019-01-14 10:49:41'),
(778221, '3.289', '2019-01-14 10:49:46'),
(778223, '3.282', '2019-01-14 10:49:54'),
(778226, '3.282', '2019-01-14 10:49:59'),
(778228, '3.302', '2019-01-14 11:31:57'),
(778229, '3.299', '2019-01-14 11:33:00'),
(778232, '3.300', '2019-01-14 11:37:57'),
(778276, '3.300', '2019-01-14 11:38:34'),
(778283, '3.299', '2019-01-14 11:38:40'),
(778305, '3.299', '2019-01-14 11:38:52'),
(778309, '3.310', '2019-01-14 11:44:41'),
(778310, '3.303', '2019-01-14 11:46:42'),
(778311, '3.299', '2019-01-14 11:48:58'),
(778313, '3.301', '2019-01-14 12:11:57'),
(778334, '3.301', '2019-01-14 12:12:31'),
(778337, '3.301', '2019-01-14 12:12:34'),
(778343, '3.301', '2019-01-14 12:12:44'),
(778349, '3.303', '2019-01-14 12:12:57'),
(778360, '3.303', '2019-01-14 12:13:07'),
(778366, '3.303', '2019-01-14 12:13:11'),
(778414, '3.305', '2019-01-14 12:14:02'),
(778448, '3.305', '2019-01-14 12:14:30'),
(778484, '3.305', '2019-01-14 12:15:09'),
(778527, '3.305', '2019-01-14 12:15:56'),
(778549, '3.305', '2019-01-14 12:16:15'),
(778577, '3.305', '2019-01-14 12:16:42'),
(778587, '3.307', '2019-01-14 12:16:57'),
(778598, '3.307', '2019-01-14 12:17:07'),
(778604, '3.307', '2019-01-14 12:17:12'),
(778611, '3.307', '2019-01-14 12:17:17'),
(778627, '3.306', '2019-01-14 12:17:32'),
(778646, '3.305', '2019-01-14 12:17:51'),
(778708, '3.305', '2019-01-14 12:18:55'),
(778720, '3.307', '2019-01-14 12:19:07'),
(778762, '3.307', '2019-01-14 12:19:47'),
(778768, '3.307', '2019-01-14 12:19:55'),
(778824, '3.307', '2019-01-14 12:20:53'),
(778843, '3.307', '2019-01-14 12:21:10'),
(778859, '3.307', '2019-01-14 12:21:25'),
(778883, '3.308', '2019-01-14 12:21:51'),
(778929, '3.305', '2019-01-14 12:22:36'),
(778968, '3.305', '2019-01-14 12:23:18'),
(778973, '3.307', '2019-01-14 12:23:21'),
(779000, '3.307', '2019-01-14 12:23:47'),
(779026, '3.305', '2019-01-14 12:24:15'),
(779046, '3.305', '2019-01-14 12:24:38'),
(779111, '3.308', '2019-01-14 12:25:40'),
(779116, '3.306', '2019-01-14 12:25:47'),
(779186, '3.306', '2019-01-14 12:26:55'),
(779198, '3.306', '2019-01-14 12:27:06'),
(779236, '3.305', '2019-01-14 12:27:46'),
(779243, '3.305', '2019-01-14 12:27:55'),
(779247, '3.305', '2019-01-14 12:27:58'),
(779349, '3.305', '2019-01-14 12:29:45'),
(779370, '3.305', '2019-01-14 12:30:04'),
(779376, '3.305', '2019-01-14 12:30:08'),
(779423, '3.304', '2019-01-14 12:31:00'),
(779448, '3.304', '2019-01-14 12:31:25'),
(779453, '3.301', '2019-01-14 12:31:31'),
(779459, '3.301', '2019-01-14 12:31:36'),
(779465, '3.301', '2019-01-14 12:31:42'),
(779471, '3.300', '2019-01-14 12:31:46'),
(779494, '3.302', '2019-01-14 12:32:07'),
(779500, '3.302', '2019-01-14 12:32:11'),
(779612, '3.302', '2019-01-14 12:34:01'),
(779624, '3.301', '2019-01-14 12:34:13'),
(779667, '3.301', '2019-01-14 12:34:56'),
(779727, '3.304', '2019-01-14 12:35:56'),
(779731, '3.304', '2019-01-14 12:36:01'),
(779737, '3.303', '2019-01-14 12:36:08'),
(779760, '3.302', '2019-01-14 12:36:30'),
(779765, '3.302', '2019-01-14 12:36:37'),
(779770, '3.302', '2019-01-14 12:36:42'),
(779775, '3.302', '2019-01-14 12:36:46'),
(779781, '3.302', '2019-01-14 12:36:52'),
(779795, '3.301', '2019-01-14 12:37:07'),
(779800, '3.304', '2019-01-14 12:37:09'),
(779812, '3.304', '2019-01-14 12:37:24'),
(779843, '3.303', '2019-01-14 12:37:52'),
(779874, '2.652', '2019-02-20 10:23:15'),
(779985, '2.651', '2019-02-20 10:25:03'),
(780184, '2.652', '2019-02-20 10:29:08'),
(780505, '2.652', '2019-02-20 10:33:33'),
(780522, '2.647', '2019-02-20 10:33:53'),
(780527, '2.648', '2019-02-20 10:33:57'),
(780535, '2.648', '2019-02-20 10:34:00'),
(780552, '2.648', '2019-02-20 10:34:17'),
(780569, '2.647', '2019-02-20 10:34:38'),
(780595, '2.648', '2019-02-20 10:35:00'),
(780617, '2.649', '2019-02-20 10:35:22'),
(780630, '2.649', '2019-02-20 10:35:38'),
(780668, '2.650', '2019-02-20 10:36:13'),
(780677, '2.651', '2019-02-20 10:36:22'),
(780693, '2.653', '2019-02-20 10:36:44'),
(780707, '2.654', '2019-02-20 10:36:58'),
(780715, '2.654', '2019-02-20 10:37:03'),
(780732, '2.654', '2019-02-20 10:37:13'),
(780737, '2.652', '2019-02-20 10:37:24'),
(780741, '2.653', '2019-02-20 10:37:26'),
(780753, '2.653', '2019-02-20 10:37:42'),
(780757, '2.653', '2019-02-20 10:37:45'),
(780812, '2.654', '2019-02-20 10:40:20'),
(780944, '2.654', '2019-02-20 10:44:10'),
(780972, '2.653', '2019-02-20 10:44:48'),
(780977, '2.653', '2019-02-20 10:44:52'),
(781152, '2.652', '2019-02-20 10:47:47'),
(781209, '2.651', '2019-02-20 10:48:41'),
(781316, '2.650', '2019-02-20 10:50:26'),
(781324, '2.651', '2019-02-20 10:50:35'),
(781343, '2.651', '2019-02-20 10:50:55'),
(781364, '2.651', '2019-02-20 10:51:10'),
(781984, '2.650', '2019-02-20 11:01:35'),
(782003, '2.649', '2019-02-20 11:02:00'),
(782019, '2.650', '2019-02-20 11:02:10'),
(782053, '2.650', '2019-02-20 11:02:49'),
(782063, '2.649', '2019-02-20 11:03:00'),
(782100, '2.650', '2019-02-20 11:03:33'),
(782108, '2.649', '2019-02-20 11:03:42'),
(782153, '2.650', '2019-02-20 11:04:25'),
(782233, '2.649', '2019-02-20 11:05:50'),
(782277, '2.649', '2019-02-20 11:06:30'),
(782280, '2.650', '2019-02-20 11:06:35'),
(782443, '2.650', '2019-02-20 11:09:14'),
(782571, '2.651', '2019-02-20 11:11:22'),
(782696, '2.650', '2019-02-20 11:13:27'),
(782709, '2.650', '2019-02-20 11:13:40'),
(782733, '2.649', '2019-02-20 11:14:02'),
(782748, '2.650', '2019-02-20 11:14:16'),
(782765, '2.650', '2019-02-20 11:14:40'),
(782885, '2.650', '2019-02-20 11:16:39'),
(782925, '2.649', '2019-02-20 11:17:14'),
(782929, '2.649', '2019-02-20 11:17:17'),
(782958, '2.650', '2019-02-20 11:17:53'),
(782988, '2.649', '2019-02-20 11:18:18'),
(783085, '2.650', '2019-02-20 11:19:58'),
(783113, '2.650', '2019-02-20 11:20:23'),
(783129, '2.651', '2019-02-20 11:20:44');

-- --------------------------------------------------------

--
-- 表的结构 `data_sgpmudi`
--

CREATE TABLE `data_sgpmudi` (
  `id` int(11) NOT NULL,
  `price` varchar(30) DEFAULT NULL,
  `time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `data_wgcna0`
--

CREATE TABLE `data_wgcna0` (
  `id` int(11) NOT NULL,
  `price` varchar(30) DEFAULT NULL,
  `time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `data_wgcna0`
--

INSERT INTO `data_wgcna0` (`id`, `price`, `time`) VALUES
(448097, '10609.00', '2019-01-14 10:49:18'),
(448107, '10606.50', '2019-01-14 10:49:47'),
(448109, '10609.00', '2019-01-14 10:49:52'),
(448114, '10609.00', '2019-01-14 11:32:12'),
(448118, '10616.50', '2019-01-14 11:37:27'),
(448125, '10617.50', '2019-01-14 11:38:07'),
(448140, '10619.00', '2019-01-14 11:38:19'),
(448195, '10616.50', '2019-01-14 11:43:40'),
(448197, '10614.00', '2019-01-14 11:47:53'),
(448199, '10624.00', '2019-01-14 12:09:26'),
(448285, '10622.50', '2019-01-14 12:13:30'),
(448300, '10624.00', '2019-01-14 12:14:01'),
(448552, '10621.50', '2019-01-14 12:18:12'),
(449606, '10620.50', '2019-01-14 12:35:43'),
(449676, '10619.00', '2019-01-14 12:36:57'),
(449760, '11921.50', '2019-02-20 10:23:43'),
(449768, '11921.50', '2019-02-20 10:24:04'),
(449801, '11922.50', '2019-02-20 10:24:24'),
(449836, '11921.50', '2019-02-20 10:24:42'),
(449871, '11926.50', '2019-02-20 10:25:00'),
(449901, '11921.50', '2019-02-20 10:25:20'),
(449918, '11921.50', '2019-02-20 10:25:43'),
(449922, '11919.00', '2019-02-20 10:25:45'),
(449940, '11921.50', '2019-02-20 10:25:54'),
(449961, '11924.00', '2019-02-20 10:26:17'),
(449978, '11924.00', '2019-02-20 10:26:44'),
(450000, '11926.50', '2019-02-20 10:27:02'),
(450021, '11921.50', '2019-02-20 10:27:25'),
(450026, '11919.00', '2019-02-20 10:27:27'),
(450038, '11911.50', '2019-02-20 10:27:41'),
(450042, '11909.00', '2019-02-20 10:27:47'),
(450054, '11914.00', '2019-02-20 10:28:01'),
(450059, '11914.00', '2019-02-20 10:28:06'),
(450060, '11919.00', '2019-02-20 10:28:49'),
(450070, '11921.50', '2019-02-20 10:29:09'),
(450083, '11925.50', '2019-02-20 10:29:16'),
(450086, '11921.50', '2019-02-20 10:29:25'),
(450103, '11925.50', '2019-02-20 10:29:50'),
(450130, '11926.50', '2019-02-20 10:30:02'),
(450147, '11926.50', '2019-02-20 10:30:27'),
(450163, '11929.00', '2019-02-20 10:30:48'),
(450180, '11931.50', '2019-02-20 10:31:01'),
(450188, '11929.00', '2019-02-20 10:31:06'),
(450206, '11926.50', '2019-02-20 10:31:12'),
(450210, '11929.00', '2019-02-20 10:31:31'),
(450223, '11931.50', '2019-02-20 10:31:44'),
(450228, '11929.00', '2019-02-20 10:31:51'),
(450254, '11926.50', '2019-02-20 10:32:07'),
(450281, '11929.00', '2019-02-20 10:32:23'),
(450289, '11926.50', '2019-02-20 10:32:30'),
(450331, '11929.00', '2019-02-20 10:32:50'),
(450351, '11929.00', '2019-02-20 10:33:01'),
(450375, '11929.00', '2019-02-20 10:33:10'),
(450391, '11926.50', '2019-02-20 10:33:33'),
(450408, '11921.50', '2019-02-20 10:33:46'),
(450422, '11919.00', '2019-02-20 10:33:58'),
(450434, '11916.50', '2019-02-20 10:34:12'),
(450451, '11914.00', '2019-02-20 10:34:32'),
(450463, '11914.00', '2019-02-20 10:34:43'),
(450468, '11914.00', '2019-02-20 10:34:55'),
(450494, '11914.00', '2019-02-20 10:35:13'),
(450499, '11911.50', '2019-02-20 10:35:15'),
(450503, '11914.00', '2019-02-20 10:35:22'),
(450511, '11914.00', '2019-02-20 10:35:34'),
(450528, '11911.50', '2019-02-20 10:35:49'),
(450541, '11914.00', '2019-02-20 10:36:01'),
(450554, '11916.50', '2019-02-20 10:36:14'),
(450558, '11919.00', '2019-02-20 10:36:17'),
(450570, '11919.00', '2019-02-20 10:36:35'),
(450588, '11919.00', '2019-02-20 10:36:53'),
(450593, '11921.50', '2019-02-20 10:36:58'),
(450618, '11921.50', '2019-02-20 10:37:16'),
(450635, '11921.50', '2019-02-20 10:37:34'),
(450653, '11924.00', '2019-02-20 10:37:54'),
(450678, '11934.00', '2019-02-20 10:38:19'),
(450695, '11924.00', '2019-02-20 10:38:37'),
(450698, '11944.00', '2019-02-20 10:41:42'),
(450701, '11949.00', '2019-02-20 10:41:57'),
(450719, '11951.50', '2019-02-20 10:42:25'),
(450734, '11951.50', '2019-02-20 10:42:43'),
(450757, '11949.00', '2019-02-20 10:43:01'),
(450765, '11946.50', '2019-02-20 10:43:06'),
(450778, '11936.50', '2019-02-20 10:43:20'),
(450782, '11934.00', '2019-02-20 10:43:24'),
(450795, '11934.00', '2019-02-20 10:43:43'),
(450799, '11939.00', '2019-02-20 10:43:47'),
(450817, '11934.00', '2019-02-20 10:44:03'),
(450839, '11935.50', '2019-02-20 10:44:23'),
(450842, '11936.50', '2019-02-20 10:44:28'),
(450854, '11939.00', '2019-02-20 10:44:39'),
(450858, '11944.00', '2019-02-20 10:44:46'),
(450877, '11945.50', '2019-02-20 10:45:05'),
(450885, '11944.00', '2019-02-20 10:45:09'),
(450902, '11936.50', '2019-02-20 10:45:30'),
(450914, '11934.00', '2019-02-20 10:45:41'),
(450918, '11929.00', '2019-02-20 10:45:50'),
(450937, '11926.50', '2019-02-20 10:46:00'),
(450962, '11929.00', '2019-02-20 10:46:27'),
(450983, '11929.00', '2019-02-20 10:46:52'),
(450996, '11921.50', '2019-02-20 10:46:59'),
(451009, '11911.50', '2019-02-20 10:47:15'),
(451026, '11912.50', '2019-02-20 10:47:36'),
(451043, '11909.00', '2019-02-20 10:47:48'),
(451048, '11906.50', '2019-02-20 10:47:54'),
(451057, '11904.00', '2019-02-20 10:47:59'),
(451070, '11906.50', '2019-02-20 10:48:13'),
(451074, '11909.00', '2019-02-20 10:48:17'),
(451078, '11906.50', '2019-02-20 10:48:22'),
(451086, '11906.50', '2019-02-20 10:48:31'),
(451091, '11906.50', '2019-02-20 10:48:40'),
(451116, '11909.00', '2019-02-20 10:48:58'),
(451129, '11909.00', '2019-02-20 10:49:09'),
(451138, '11911.50', '2019-02-20 10:49:18'),
(451146, '11910.50', '2019-02-20 10:49:34'),
(451154, '11914.00', '2019-02-20 10:49:43'),
(451163, '11914.00', '2019-02-20 10:49:55'),
(451190, '11911.50', '2019-02-20 10:50:15'),
(451202, '11911.50', '2019-02-20 10:50:27'),
(451206, '11911.50', '2019-02-20 10:50:34'),
(451219, '11911.50', '2019-02-20 10:50:47'),
(451224, '11912.50', '2019-02-20 10:50:54'),
(451245, '11909.00', '2019-02-20 10:51:10'),
(451262, '11904.00', '2019-02-20 10:51:31'),
(451266, '11906.50', '2019-02-20 10:51:35'),
(451283, '11909.00', '2019-02-20 10:51:49'),
(451289, '11906.50', '2019-02-20 10:51:56'),
(451297, '11907.50', '2019-02-20 10:51:58'),
(451310, '11906.50', '2019-02-20 10:52:12'),
(451314, '11905.50', '2019-02-20 10:52:16'),
(451326, '11904.00', '2019-02-20 10:52:32'),
(451349, '11904.00', '2019-02-20 10:52:52'),
(451374, '11909.00', '2019-02-20 10:53:08'),
(451391, '11907.50', '2019-02-20 10:53:40'),
(451394, '11902.50', '2019-02-20 10:53:42'),
(451409, '11900.50', '2019-02-20 10:53:58'),
(451434, '11905.50', '2019-02-20 10:54:19'),
(451437, '11906.50', '2019-02-20 10:54:23'),
(451450, '11901.50', '2019-02-20 10:54:27'),
(451469, '11901.50', '2019-02-20 10:54:55'),
(451477, '11905.50', '2019-02-20 10:55:04'),
(451494, '11904.00', '2019-02-20 10:55:13'),
(451510, '11904.00', '2019-02-20 10:55:38'),
(451518, '11901.50', '2019-02-20 10:55:44'),
(451529, '11899.00', '2019-02-20 10:55:54'),
(451545, '11896.50', '2019-02-20 10:56:05'),
(451574, '11894.00', '2019-02-20 10:56:41'),
(451597, '11896.50', '2019-02-20 10:56:59'),
(451619, '11896.50', '2019-02-20 10:57:20'),
(451657, '11885.50', '2019-02-20 10:58:00'),
(451673, '11886.50', '2019-02-20 10:58:21'),
(451690, '11886.50', '2019-02-20 10:58:37'),
(451698, '11884.00', '2019-02-20 10:58:46'),
(451710, '11890.50', '2019-02-20 10:59:00'),
(451726, '11891.50', '2019-02-20 10:59:04'),
(451742, '11889.00', '2019-02-20 10:59:22'),
(451759, '11891.50', '2019-02-20 10:59:52'),
(451777, '11886.50', '2019-02-20 10:59:58'),
(451790, '11891.50', '2019-02-20 11:00:15'),
(451798, '11891.50', '2019-02-20 11:00:22'),
(451807, '11894.00', '2019-02-20 11:00:36'),
(451815, '11896.50', '2019-02-20 11:00:41'),
(451831, '11899.00', '2019-02-20 11:00:57'),
(451854, '11896.50', '2019-02-20 11:01:13'),
(451858, '11899.00', '2019-02-20 11:01:23'),
(451870, '11897.50', '2019-02-20 11:01:39'),
(451874, '11896.50', '2019-02-20 11:01:41'),
(451879, '11899.00', '2019-02-20 11:01:46'),
(451913, '11904.00', '2019-02-20 11:02:18'),
(451918, '11901.50', '2019-02-20 11:02:21'),
(451923, '11901.50', '2019-02-20 11:02:25'),
(451931, '11904.00', '2019-02-20 11:02:37'),
(451939, '11901.50', '2019-02-20 11:02:43'),
(451965, '11902.50', '2019-02-20 11:03:07'),
(451978, '11904.00', '2019-02-20 11:03:11'),
(452078, '11900.50', '2019-02-20 11:05:01'),
(452099, '11904.00', '2019-02-20 11:05:20'),
(452119, '11901.50', '2019-02-20 11:05:50'),
(452137, '11904.00', '2019-02-20 11:05:54'),
(452154, '11906.50', '2019-02-20 11:06:17'),
(452163, '11904.00', '2019-02-20 11:06:24'),
(452175, '11905.50', '2019-02-20 11:06:40'),
(452179, '11904.00', '2019-02-20 11:06:50'),
(452205, '11906.50', '2019-02-20 11:07:08'),
(452221, '11911.50', '2019-02-20 11:07:28'),
(452238, '11909.00', '2019-02-20 11:07:49'),
(452256, '11909.00', '2019-02-20 11:08:02'),
(452265, '11910.50', '2019-02-20 11:08:07'),
(452269, '11909.00', '2019-02-20 11:08:11'),
(452281, '11917.50', '2019-02-20 11:08:30'),
(452286, '11916.50', '2019-02-20 11:08:32'),
(452294, '11914.00', '2019-02-20 11:08:41'),
(452302, '11914.00', '2019-02-20 11:08:46'),
(452316, '11912.50', '2019-02-20 11:09:02'),
(452329, '11914.00', '2019-02-20 11:09:06'),
(452363, '11919.00', '2019-02-20 11:09:50'),
(452390, '11919.00', '2019-02-20 11:10:10'),
(452398, '11916.50', '2019-02-20 11:10:19'),
(452406, '11919.00', '2019-02-20 11:10:35'),
(452450, '11926.50', '2019-02-20 11:11:16'),
(452465, '11927.50', '2019-02-20 11:11:34'),
(452482, '11926.50', '2019-02-20 11:11:45'),
(452496, '11926.50', '2019-02-20 11:12:01'),
(452510, '11925.50', '2019-02-20 11:12:15'),
(452526, '11919.00', '2019-02-20 11:12:36'),
(452542, '11921.50', '2019-02-20 11:12:47'),
(452570, '11924.00', '2019-02-20 11:13:01'),
(452590, '11921.50', '2019-02-20 11:13:35'),
(452609, '11917.50', '2019-02-20 11:13:58'),
(452619, '11919.00', '2019-02-20 11:14:07'),
(452634, '11921.50', '2019-02-20 11:14:18'),
(452647, '11925.50', '2019-02-20 11:14:30'),
(452651, '11921.50', '2019-02-20 11:14:39'),
(452655, '11924.00', '2019-02-20 11:14:41'),
(452673, '11924.00', '2019-02-20 11:14:57'),
(452695, '11929.00', '2019-02-20 11:15:15'),
(452712, '11931.50', '2019-02-20 11:15:24'),
(452754, '11926.50', '2019-02-20 11:16:19'),
(452771, '11916.50', '2019-02-20 11:16:41'),
(452793, '11921.50', '2019-02-20 11:17:02'),
(452815, '11921.50', '2019-02-20 11:17:18'),
(452853, '11916.50', '2019-02-20 11:17:54'),
(452859, '11917.50', '2019-02-20 11:18:03'),
(452874, '11926.50', '2019-02-20 11:18:21'),
(452879, '11924.00', '2019-02-20 11:18:23'),
(452895, '11921.50', '2019-02-20 11:18:35'),
(452919, '11916.50', '2019-02-20 11:19:02'),
(452934, '11909.00', '2019-02-20 11:19:23'),
(452939, '11912.50', '2019-02-20 11:19:25'),
(452955, '11909.00', '2019-02-20 11:19:46'),
(452979, '11906.50', '2019-02-20 11:20:06'),
(452999, '11909.00', '2019-02-20 11:20:25'),
(453015, '11911.50', '2019-02-20 11:20:47'),
(453039, '11906.50', '2019-02-20 11:20:59'),
(453055, '11904.00', '2019-02-20 11:21:21'),
(453075, '11896.50', '2019-02-20 11:21:44');

-- --------------------------------------------------------

--
-- 表的结构 `data_yb`
--

CREATE TABLE `data_yb` (
  `id` int(11) NOT NULL,
  `price` varchar(30) DEFAULT NULL,
  `time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `exuser_withdraw`
--

CREATE TABLE `exuser_withdraw` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `amount` decimal(11,2) NOT NULL COMMENT '出金金额',
  `op_state` tinyint(4) DEFAULT '1' COMMENT '操作状态：1待审核，2已操作，-1不通过',
  `created_at` datetime DEFAULT NULL COMMENT '申请时间',
  `created_by` int(11) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL COMMENT '审核时间',
  `updated_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='管理员提款表';

--
-- 转存表中的数据 `exuser_withdraw`
--

INSERT INTO `exuser_withdraw` (`id`, `user_id`, `amount`, `op_state`, `created_at`, `created_by`, `updated_at`, `updated_by`) VALUES
(1, 100230, '200.00', -1, '2017-12-21 22:10:41', 100230, '2017-12-21 22:57:14', 1),
(2, 100230, '200.00', 2, '2017-12-22 10:49:13', 100230, '2017-12-22 12:25:53', 2),
(3, 100230, '18500.00', 2, '2018-01-05 21:45:21', 100230, '2018-01-11 15:04:01', 2),
(4, 100144, '7100.00', 2, '2018-01-06 15:12:08', 100144, '2018-01-11 15:03:53', 2),
(5, 100234, '300.00', 2, '2018-01-11 14:49:17', 100234, '2018-01-11 15:03:28', 2);

-- --------------------------------------------------------

--
-- 表的结构 `log`
--

CREATE TABLE `log` (
  `id` bigint(20) NOT NULL,
  `level` int(11) DEFAULT NULL,
  `category` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `log_time` double DEFAULT NULL,
  `prefix` text COLLATE utf8_unicode_ci,
  `message` text COLLATE utf8_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `log`
--

INSERT INTO `log` (`id`, `level`, `category`, `log_time`, `prefix`, `message`) VALUES
(1, 2, 'yii\\debug\\Module::checkAccess', 1550631935.8426, '[GET][http://ylt.advancee.cn/admin/sale/manager-list][222.89.85.245][2][-]', 'Access to debugger is denied due to IP address restriction. The requesting IP address is 222.89.85.245'),
(2, 2, 'yii\\debug\\Module::checkAccess', 1550631943.4322, '[GET][http://ylt.advancee.cn/admin/user/list][222.89.85.245][2][-]', 'Access to debugger is denied due to IP address restriction. The requesting IP address is 222.89.85.245'),
(3, 2, 'yii\\debug\\Module::checkAccess', 1550631965.0801, '[GET][http://ylt.advancee.cn/admin/sale/manager-list][222.89.85.245][2][-]', 'Access to debugger is denied due to IP address restriction. The requesting IP address is 222.89.85.245'),
(4, 2, 'yii\\debug\\Module::checkAccess', 1550632014.1351, '[GET][http://ylt.advancee.cn/admin/user/list][222.89.85.245][2][-]', 'Access to debugger is denied due to IP address restriction. The requesting IP address is 222.89.85.245'),
(5, 2, 'yii\\debug\\Module::checkAccess', 1550632015.0472, '[GET][http://ylt.advancee.cn/admin/user/list][222.89.85.245][2][-]', 'Access to debugger is denied due to IP address restriction. The requesting IP address is 222.89.85.245'),
(6, 2, 'yii\\debug\\Module::checkAccess', 1550632148.5163, '[GET][http://ylt.advancee.cn/user/out-money][222.89.85.245][100323][-]', 'Access to debugger is denied due to IP address restriction. The requesting IP address is 222.89.85.245'),
(7, 2, 'yii\\debug\\Module::checkAccess', 1550632152.3189, '[GET][http://ylt.advancee.cn/user/inside-money][222.89.85.245][100323][-]', 'Access to debugger is denied due to IP address restriction. The requesting IP address is 222.89.85.245'),
(8, 2, 'yii\\debug\\Module::checkAccess', 1550632168.4972, '[GET][http://ylt.advancee.cn/user/setting][222.89.85.245][100323][-]', 'Access to debugger is denied due to IP address restriction. The requesting IP address is 222.89.85.245');

-- --------------------------------------------------------

--
-- 表的结构 `migration`
--

CREATE TABLE `migration` (
  `id` int(11) NOT NULL,
  `version` varchar(80) NOT NULL,
  `apply_time` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='数据库版本迁移表';

--
-- 转存表中的数据 `migration`
--

INSERT INTO `migration` (`id`, `version`, `apply_time`) VALUES
(1, '20161129_021731_1_8QbXPA.data', 1480385851),
(2, '20161130_070959_1_gDGope.data', 1480499011),
(3, '20161201_033737_1_svMwUS.data', 1480586602),
(4, '20170210_053450_1_myNgtM.data', 1486705062);

-- --------------------------------------------------------

--
-- 表的结构 `option`
--

CREATE TABLE `option` (
  `id` int(11) UNSIGNED NOT NULL,
  `option_name` varchar(64) NOT NULL DEFAULT '' COMMENT '配置名',
  `option_value` longtext COMMENT '配置值',
  `type` tinyint(4) DEFAULT '1' COMMENT '配置类型',
  `state` tinyint(4) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='参数配置表';

--
-- 转存表中的数据 `option`
--

INSERT INTO `option` (`id`, `option_name`, `option_value`, `type`, `state`) VALUES
(1, 'frontend_settings', 'a:17:{i:0;a:10:{s:2:\"id\";i:1;s:3:\"pid\";s:1:\"0\";s:4:\"name\";s:12:\"网站设置\";s:3:\"var\";N;s:5:\"value\";N;s:4:\"type\";N;s:5:\"alter\";N;s:7:\"comment\";N;s:5:\"level\";i:1;s:7:\"uploads\";a:0:{}}i:1;a:10:{s:2:\"id\";i:10;s:3:\"pid\";s:1:\"0\";s:4:\"name\";s:12:\"分销设置\";s:3:\"var\";N;s:5:\"value\";N;s:4:\"type\";N;s:5:\"alter\";N;s:7:\"comment\";N;s:5:\"level\";i:1;s:7:\"uploads\";a:0:{}}i:2;a:10:{s:2:\"id\";i:2;s:3:\"pid\";s:1:\"1\";s:4:\"name\";s:12:\"公共设置\";s:3:\"var\";N;s:5:\"value\";N;s:4:\"type\";N;s:5:\"alter\";N;s:7:\"comment\";N;s:5:\"level\";i:2;s:7:\"uploads\";a:0:{}}i:3;a:10:{s:2:\"id\";i:6;s:3:\"pid\";s:1:\"1\";s:4:\"name\";s:9:\"SEO设置\";s:3:\"var\";N;s:5:\"value\";N;s:4:\"type\";N;s:5:\"alter\";N;s:7:\"comment\";N;s:5:\"level\";i:2;s:7:\"uploads\";a:0:{}}i:5;a:10:{s:2:\"id\";i:3;s:3:\"pid\";s:1:\"2\";s:4:\"name\";s:12:\"网站名称\";s:3:\"var\";s:8:\"web_name\";s:5:\"value\";s:9:\"金手指\";s:4:\"type\";s:4:\"text\";s:5:\"alter\";N;s:7:\"comment\";s:12:\"网站名称\";s:5:\"level\";i:3;s:7:\"uploads\";a:0:{}}i:6;a:10:{s:2:\"id\";i:4;s:3:\"pid\";s:1:\"2\";s:4:\"name\";s:10:\"网站LOGO\";s:3:\"var\";s:8:\"web_logo\";s:5:\"value\";s:45:\"/uploadfile/setting/20181106/230936778460.png\";s:4:\"type\";s:4:\"file\";s:5:\"alter\";N;s:7:\"comment\";s:10:\"网站LOGO\";s:5:\"level\";i:3;s:7:\"uploads\";a:0:{}}i:7;a:10:{s:2:\"id\";i:5;s:3:\"pid\";s:1:\"2\";s:4:\"name\";s:12:\"短信签名\";s:3:\"var\";s:8:\"web_sign\";s:5:\"value\";s:9:\"金手指\";s:4:\"type\";s:4:\"text\";s:5:\"alter\";N;s:7:\"comment\";s:27:\"短信签名，2-5个汉字\";s:5:\"level\";i:3;s:7:\"uploads\";a:0:{}}i:8;a:10:{s:2:\"id\";i:7;s:3:\"pid\";s:1:\"6\";s:4:\"name\";s:9:\"SEO开关\";s:3:\"var\";s:11:\"seo_default\";s:5:\"value\";s:1:\"0\";s:4:\"type\";s:5:\"radio\";s:5:\"alter\";s:40:\"a:2:{i:1;s:6:\"开启\";i:0;s:6:\"关闭\";}\";s:7:\"comment\";s:33:\"是否开启SEO的默认设置值\";s:5:\"level\";i:3;s:7:\"uploads\";a:0:{}}i:9;a:10:{s:2:\"id\";i:8;s:3:\"pid\";s:1:\"6\";s:4:\"name\";s:9:\"关键字\";s:3:\"var\";s:7:\"seo_key\";s:5:\"value\";s:9:\"金手指\";s:4:\"type\";s:4:\"text\";s:5:\"alter\";N;s:7:\"comment\";s:21:\"SEO的默认关键字\";s:5:\"level\";i:3;s:7:\"uploads\";a:0:{}}i:10;a:10:{s:2:\"id\";i:9;s:3:\"pid\";s:1:\"6\";s:4:\"name\";s:6:\"描述\";s:3:\"var\";s:8:\"seo_desc\";s:5:\"value\";s:0:\"\";s:4:\"type\";s:8:\"textarea\";s:5:\"alter\";N;s:7:\"comment\";s:18:\"SEO的默认描述\";s:5:\"level\";i:3;s:7:\"uploads\";a:0:{}}i:12;a:10:{s:2:\"id\";i:13;s:3:\"pid\";s:1:\"2\";s:4:\"name\";s:22:\"分成最大百分比%\";s:3:\"var\";s:9:\"web_point\";s:5:\"value\";s:3:\"100\";s:4:\"type\";s:4:\"text\";s:5:\"alter\";N;s:7:\"comment\";s:17:\"1-100整数之间\";s:5:\"level\";i:3;s:7:\"uploads\";a:0:{}}i:13;a:10:{s:2:\"id\";i:14;s:3:\"pid\";s:1:\"2\";s:4:\"name\";s:18:\"首页商品交易\";s:3:\"var\";s:14:\"web_trade_time\";s:5:\"value\";s:62:\"商品时间：周一~周五上午8:00~凌晨4:00 周末休市\";s:4:\"type\";s:4:\"text\";s:5:\"alter\";N;s:7:\"comment\";s:12:\"商品时间\";s:5:\"level\";i:3;s:7:\"uploads\";a:0:{}}i:14;a:10:{s:2:\"id\";i:15;s:3:\"pid\";s:1:\"2\";s:4:\"name\";s:12:\"微信回复\";s:3:\"var\";s:16:\"web_wechart_info\";s:5:\"value\";s:168:\"您好，请问有什么可以帮助您？金手指每个商品交易日09:00~18:00都会恭候您，只需在公众号说出您的需求，我们将竭诚为您解答~\";s:4:\"type\";s:4:\"text\";s:5:\"alter\";N;s:7:\"comment\";s:9:\"小蚂蚁\";s:5:\"level\";i:3;s:7:\"uploads\";a:0:{}}i:15;a:10:{s:2:\"id\";i:16;s:3:\"pid\";s:1:\"2\";s:4:\"name\";s:21:\"模拟盘初始金额\";s:3:\"var\";s:9:\"sim_money\";s:5:\"value\";s:6:\"200000\";s:4:\"type\";s:4:\"text\";s:5:\"alter\";N;s:7:\"comment\";s:21:\"模拟盘初始金额\";s:5:\"level\";i:3;s:7:\"uploads\";a:0:{}}i:16;a:10:{s:2:\"id\";i:17;s:3:\"pid\";s:1:\"2\";s:4:\"name\";s:12:\"客服电话\";s:3:\"var\";s:3:\"tel\";s:5:\"value\";s:0:\"\";s:4:\"type\";s:4:\"text\";s:5:\"alter\";N;s:7:\"comment\";s:12:\"客服电话\";s:5:\"level\";i:3;s:7:\"uploads\";a:0:{}}i:17;a:10:{s:2:\"id\";i:18;s:3:\"pid\";s:1:\"2\";s:4:\"name\";s:8:\"客服QQ\";s:3:\"var\";s:2:\"qq\";s:5:\"value\";s:10:\"3279766527\";s:4:\"type\";s:4:\"text\";s:5:\"alter\";N;s:7:\"comment\";s:8:\"客服QQ\";s:5:\"level\";i:3;s:7:\"uploads\";a:0:{}}i:18;a:10:{s:2:\"id\";i:19;s:3:\"pid\";s:1:\"2\";s:4:\"name\";s:24:\"默认经纪人邀请码\";s:3:\"var\";s:7:\"referee\";s:5:\"value\";s:6:\"100230\";s:4:\"type\";s:4:\"text\";s:5:\"alter\";N;s:7:\"comment\";s:24:\"默认经纪人邀请码\";s:5:\"level\";i:3;s:7:\"uploads\";a:0:{}}}', 1, 1),
(2, 'risk_switch', 's:1:\"0\";', 2, 1),
(3, 'risk_product', 'a:7:{s:6:\"necla0\";s:1:\"1\";s:6:\"hihsif\";s:1:\"1\";s:6:\"himhif\";s:1:\"1\";s:6:\"cmgca0\";s:1:\"1\";s:7:\"cedaxa0\";s:1:\"1\";s:2:\"yb\";s:1:\"1\";s:2:\"ay\";s:1:\"1\";}', 2, 1),
(4, 'console_settings', 'a:0:{}', 1, 1);

-- --------------------------------------------------------

--
-- 表的结构 `order`
--

CREATE TABLE `order` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL COMMENT '买卖品类',
  `hand` int(11) NOT NULL COMMENT '手数',
  `price` decimal(11,5) NOT NULL COMMENT '买入价',
  `one_profit` decimal(11,2) DEFAULT '10.00' COMMENT '一手盈亏',
  `fee` decimal(11,1) DEFAULT '0.0' COMMENT '手续费',
  `stop_profit_price` decimal(11,4) DEFAULT '0.0000' COMMENT '止盈金额',
  `stop_profit_point` decimal(11,5) DEFAULT '0.00000' COMMENT '止盈点数',
  `stop_loss_price` decimal(11,4) DEFAULT '0.0000' COMMENT '止损金额',
  `stop_loss_point` decimal(11,5) DEFAULT '0.00000' COMMENT '止损点数',
  `deposit` decimal(11,2) DEFAULT '0.00' COMMENT '保证金',
  `rise_fall` tinyint(4) DEFAULT '1' COMMENT '涨跌：1涨，2跌',
  `sell_price` decimal(11,5) DEFAULT '0.00000' COMMENT '卖出价格',
  `sell_hand` int(11) DEFAULT '0' COMMENT '卖出手数',
  `sell_deposit` decimal(11,2) DEFAULT '0.00' COMMENT '卖出总价',
  `discount` decimal(11,2) DEFAULT '0.00' COMMENT '优惠金额',
  `currency` tinyint(4) DEFAULT '1' COMMENT '币种：1人民币，2美元',
  `profit` decimal(11,2) DEFAULT '0.00' COMMENT '盈亏',
  `is_console` tinyint(1) DEFAULT '1',
  `order_state` tinyint(4) UNSIGNED ZEROFILL DEFAULT '0001' COMMENT '订单状态，1持仓，2平仓',
  `created_at` datetime DEFAULT NULL COMMENT '下单时间',
  `created_by` int(11) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL COMMENT '平仓时间',
  `updated_by` int(11) DEFAULT NULL,
  `sim` int(1) DEFAULT '1' COMMENT '1实盘，2模拟'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单表';

-- --------------------------------------------------------

--
-- 表的结构 `product`
--

CREATE TABLE `product` (
  `id` int(11) NOT NULL,
  `table_name` varchar(50) NOT NULL COMMENT '产品对应表名',
  `code` varchar(50) DEFAULT NULL,
  `name` varchar(50) NOT NULL COMMENT '产品名称',
  `deposit` decimal(11,2) NOT NULL COMMENT '保证金',
  `one_profit` int(11) NOT NULL COMMENT '一手盈亏',
  `desc` varchar(255) DEFAULT '' COMMENT '产品描述',
  `fee` decimal(11,2) DEFAULT '0.00' COMMENT '手续费',
  `trade_time` text COMMENT '交易时间',
  `is_trade` tinyint(4) DEFAULT '1' COMMENT '允许交易',
  `rest_day` varchar(255) DEFAULT '' COMMENT '休市日',
  `play_rule` text COMMENT '玩法规则',
  `force_sell` tinyint(4) DEFAULT '1' COMMENT '是否强制平仓：1是，-1否',
  `currency` tinyint(4) DEFAULT '1' COMMENT '币种： 1人民币，2美元',
  `hot` tinyint(4) DEFAULT '1' COMMENT '是否是热门期货：1是，-1不是',
  `source` tinyint(4) DEFAULT '1' COMMENT '来源(1交易所2自动生成)',
  `type` tinyint(4) DEFAULT '1' COMMENT '期货类别：1国内，2国外',
  `on_sale` tinyint(4) DEFAULT '1' COMMENT '上架状态：1上架，-1下架',
  `state` tinyint(4) DEFAULT '1' COMMENT '状态',
  `unit` decimal(20,4) DEFAULT '1.0000' COMMENT '产品点位单位',
  `unit_price` decimal(20,4) DEFAULT '1.0000' COMMENT '换算人民币点位单价',
  `maxrise` decimal(10,4) DEFAULT '10.0000' COMMENT '最大止盈',
  `maxlost` decimal(10,4) DEFAULT '10.0000' COMMENT '最大止损',
  `unit_price_na` decimal(20,4) DEFAULT '1.0000' COMMENT '原币种单位价格'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='交易产品表';

--
-- 转存表中的数据 `product`
--

INSERT INTO `product` (`id`, `table_name`, `code`, `name`, `deposit`, `one_profit`, `desc`, `fee`, `trade_time`, `is_trade`, `rest_day`, `play_rule`, `force_sell`, `currency`, `hot`, `source`, `type`, `on_sale`, `state`, `unit`, `unit_price`, `maxrise`, `maxlost`, `unit_price_na`) VALUES
(1, 'necla0', 'hf_CL', '美原油', '0.00', 7000, '美元|1000桶|0.01美元/桶|波动一个单位点=10美元|夏令：06:00:00 - 次日04:55:00<br>冬令：07:00:00 - 次日05:55:00|夏令：次日04:55:00<br>冬令：次日05:55:00|1美元＝7人民币|10美元|人民币70元', '350.00', 'a:1:{i:0;a:2:{s:5:\"start\";s:5:\"07:00\";s:3:\"end\";s:5:\"05:55\";}}', -1, '', '', 1, 2, 7, 1, 1, 1, 1, '0.0100', '70.0000', '0.6000', '0.3000', '70.0000'),
(2, 'wgcna0', 'hf_CHA50CFD', 'A50', '0.00', 17, '美元 | 1美元x指数  | 2.5点 |波动一个单位点=2.5美元| 09:00-16:10 |16:10（节假日或休市随市场实际执行）|1美元 = 7人民币（汇率波动较大时，将会进行调整）|8|9|10', '100.00', 'a:2:{i:0;a:2:{s:5:\"start\";s:5:\"09:00\";s:3:\"end\";s:5:\"15:55\";}i:1;a:2:{s:5:\"start\";s:5:\"16:40\";s:3:\"end\";s:5:\"23:59\";}}', 1, '', '', 1, 1, 35, 1, 0, 1, 1, '1.0000', '17.5000', '40.0000', '20.0000', '17.5000'),
(3, 'nenga0', 'hf_NG', '天燃气', '0.00', 70000, '美元|每手10000mmBtu|0.001美元|波动一个单位点=10美元|6:00-次日4:40|次日4：40（节假日或休市随市场实际执行）|1美元 = 7人民币（汇率波动较大时，将会进行调整）|8|9|10', '175.00', 'a:1:{i:0;a:2:{s:5:\"start\";s:5:\"00:00\";s:3:\"end\";s:5:\"18:00\";}}', 1, '', '', 1, 2, 34, 1, 0, 1, 1, '0.0010', '70.0000', '0.0400', '0.0200', '70.0000'),
(4, 'cmhga0', 'hf_CAD', '美铜', '0.00', 875000, '美元|每手25000磅|0.0005美元|波动一个单位点=12.5美元|6:00-次日4:40|次日4：40（节假日或休市随市场实际执行）|1美元 = 7人民币（汇率波动较大时，将会进行调整）', '225.00', 'a:1:{i:0;a:2:{s:5:\"start\";s:5:\"08:00\";s:3:\"end\";s:5:\"04:00\";}}', 1, '', '', 1, 2, 13, 1, 0, -1, 1, '0.0001', '87.5000', '40.0000', '20.0000', '87.5000'),
(5, 'ni1609', 'NQE0', '纳指', '0.00', 200, '', '99999.00', 'a:1:{i:0;a:2:{s:5:\"start\";s:5:\"15:00\";s:3:\"end\";s:5:\"16:30\";}}', 1, '', '', 1, 1, 8, 1, 0, 1, -1, '1.0000', '1.0000', '10.0000', '1.0000', '1.0000'),
(6, 'if1609', 'hf_C', '宝石', '0.00', 100, '', '99999.00', NULL, 1, '', '', 1, 1, 14, 1, 0, 1, -1, '1.0000', '1.0000', '10.0000', '1.0000', '1.0000'),
(7, 'gc', 'fx_seurusd', '欧元', '0.00', 875000, '美元|每手125000欧元|0.0001美元|波动一个单位点=12.5美元|夏令：06:00:00 - 次日04:55:00<br>冬令：07:00:00 - 次日05:55:00|夏令：次日04:55:00<br>冬令：次日05:55:00|1美元＝7人民币|美元|人民币87.5元', '200.00', 'a:1:{i:0;a:2:{s:5:\"start\";s:5:\"07:00\";s:3:\"end\";s:5:\"04:00\";}}', 1, '', '', 1, 2, 30, 1, 1, -1, 1, '0.0001', '87.5000', '0.0050', '0.0010', '87.5000'),
(8, 'hihsif', 'hf_HSI', '恒指', '0.00', 50, '港币|1个指数点|50港元/点|波动一个单位点=50港元|上午09:15:00 - 12:00:00<br>下午13:00:00 - 16:30:00<br>夜间17:15:00 - 01:00:00|夜间 01:00:00|10港币＝9人民币|1点|人民币50元', '400.00', 'a:3:{i:0;a:2:{s:5:\"start\";s:5:\"09:15\";s:3:\"end\";s:5:\"12:00\";}i:1;a:2:{s:5:\"start\";s:5:\"13:00\";s:3:\"end\";s:5:\"16:30\";}i:2;a:2:{s:5:\"start\";s:5:\"17:15\";s:3:\"end\";s:5:\"01:00\";}}', 1, '', '', 1, 5, 4, 1, 1, 1, 1, '1.0000', '50.0000', '90.0000', '45.0000', '50.0000'),
(9, 'cmsia0', 'hf_XAG', '美白银', '0.00', 35000, '美元|每手5000盎司|0.005美元/盎司|波动一个单位点 = 25美元|夏令：06:00:00 - 次日04:55:00<br>冬令：07:00:00 - 次日05:55:00|夏令：次日04:55:00<br>冬令：次日05:55:00|1美元＝7人民币|25美元|人民币175元', '268.00', 'a:1:{i:0;a:2:{s:5:\"start\";s:5:\"07:00\";s:3:\"end\";s:5:\"06:00\";}}', 1, '', '', 1, 2, 14, 1, 1, -1, 1, '0.0050', '175.0000', '40.0000', '20.0000', '175.0000'),
(10, 'ng', 'hf_C', '天然气', '0.00', 70, '美元|每手10000mmBtu|0.001美元|波动一个单位点=10美元|6:00-次日4:40|次日4：40（节假日或休市随市场实际执行）|1美元 = 7人民币（汇率波动较大时，将会进行调整）', '175.00', 'a:1:{i:0;a:2:{s:5:\"start\";s:5:\"07:00\";s:3:\"end\";s:5:\"04:00\";}}', 1, '', '', 1, 2, 2, 1, 0, 1, -1, '0.0010', '70.0000', '40.0000', '20.0000', '70.0000'),
(11, 'rm1609', 'hf_C', '菜粕', '0.00', 500, '', '99999.00', 'a:1:{i:0;a:2:{s:5:\"start\";s:5:\"13:00\";s:3:\"end\";s:5:\"14:30\";}}', 1, '', '', 1, 1, 7, 1, 0, 1, -1, '1.0000', '1.0000', '10.0000', '1.0000', '1.0000'),
(12, 'ru1609', 'hf_C', '橡胶', '0.00', 400, '', '99999.00', NULL, 1, '', '', 1, 1, 9, 1, 0, 1, -1, '1.0000', '1.0000', '10.0000', '1.0000', '1.0000'),
(13, 'himhif', 'hf_HSI', '小恒指', '0.00', 10, '港币|1个指数点|10港元/点|波动一个单位点=10港元|上午 09:15:00 - 12:00:00<br>下午 13:00:00 - 16:30:00<br>夜间 17:15:00 - 01:00:00|夜间 01:00:00|10港币＝9人民币|1点|人民币9元', '80.00', 'a:3:{i:0;a:2:{s:5:\"start\";s:5:\"09:15\";s:3:\"end\";s:5:\"12:00\";}i:1;a:2:{s:5:\"start\";s:5:\"13:00\";s:3:\"end\";s:5:\"16:30\";}i:2;a:2:{s:5:\"start\";s:5:\"17:15\";s:3:\"end\";s:5:\"01:00\";}}', 1, '', '', 1, 5, 1, 1, 1, 1, 1, '1.0000', '10.0000', '100.0000', '50.0000', '10.0000'),
(14, 'xag', 'hf_C', '伦敦银', '0.00', 10, '', '10.00', NULL, 1, '', '', 1, 1, 1, 1, 1, 1, -1, '1.0000', '1.0000', '10.0000', '1.0000', '1.0000'),
(15, 'xpt', 'hf_C', '伦敦铂金', '0.00', 10, '', '10.00', NULL, 1, '', '', 1, 1, 1, 1, 1, 1, -1, '1.0000', '1.0000', '10.0000', '1.0000', '1.0000'),
(16, 'sh000001', 'hf_C', '上证指数', '100.00', 1, '', '10.00', 'a:2:{i:0;a:2:{s:5:\"start\";s:5:\"09:30\";s:3:\"end\";s:5:\"11:30\";}i:1;a:2:{s:5:\"start\";s:5:\"13:00\";s:3:\"end\";s:5:\"15:00\";}}', 1, '', '', 1, 1, 1, 1, 1, 1, -1, '1.0000', '1.0000', '10.0000', '1.0000', '1.0000'),
(17, 'xhn', 'hf_C', 'JH沥青', '0.00', 10, 'xhn', '10.00', 'a:1:{i:0;a:2:{s:5:\"start\";s:5:\"08:00\";s:3:\"end\";s:5:\"04:00\";}}', 1, '', '', 1, 1, 1, 1, 1, 1, -1, '1.0000', '1.0000', '10.0000', '1.0000', '1.0000'),
(18, 'conc', 'hf_C', 'YLK油', '0.00', 0, '', '0.00', 'a:1:{i:0;a:2:{s:5:\"start\";s:5:\"09:00\";s:3:\"end\";s:5:\"06:00\";}}', 1, '', NULL, 1, 1, 10, 1, 1, 1, -1, '1.0000', '1.0000', '10.0000', '1.0000', '1.0000'),
(19, 'cmgca0', 'hf_GC', '美黄金', '0.00', 700, '美元|每手100盎司|0.1美元/盎司|波动一个单位点=10美元|夏令：06:00:00 - 次日04:55:00<br>冬令：07:00:00 - 次日05:55:00|夏令：次日04:55:00<br>冬令：次日05:55:00|1美元＝7人民币|10美元|人民币70元', '350.00', 'a:1:{i:0;a:2:{s:5:\"start\";s:5:\"07:00\";s:3:\"end\";s:5:\"05:55\";}}', 1, '', '', 1, 2, 6, 1, 1, 1, 1, '0.1000', '70.0000', '6.0000', '3.0000', '70.0000'),
(20, 'longyanxiang', 'hf_C', '聚丙烯', '100.00', 100, '', '0.00', 'a:1:{i:0;a:2:{s:5:\"start\";s:5:\"08:00\";s:3:\"end\";s:5:\"04:00\";}}', 1, '', '', 1, 1, 10, 1, 1, 1, -1, '1.0000', '1.0000', '10.0000', '1.0000', '1.0000'),
(21, 'sgpmudi', 'DINIW', '美元指数', '100.00', 35, '美元 |1000美元x指数| 0.005点 |波动一次=5美元| 8:00-次日04:40 |次日04:40（节假日或休市随市场实际执行）|175人民币/手|1美元 = 7人民币（汇率波动较大时，将会进行调整）', '175.00', 'a:1:{i:0;a:2:{s:5:\"start\";s:5:\"08:00\";s:3:\"end\";s:5:\"04:00\";}}', 1, '', '', 1, 2, 36, 1, 1, -1, 1, '1.0000', '35.0000', '60.0000', '30.0000', '35.0000'),
(22, 'cedaxa0', 'DAXC', '德指', '100.00', 200, '欧元|每手大约280000欧元|0.5指数点|波动一个单位点=25欧元|夏令：14:00:00 - 次日04:00:00<br>冬令：15:00:00 - 次日05:00:00|夏令：次日03:55:00<br>冬令：次日04:55:00|1欧元＝8人民币|10美元|人民币100元', '500.00', 'a:1:{i:0;a:2:{s:5:\"start\";s:5:\"00:00\";s:3:\"end\";s:5:\"00:00\";}}', 1, '', '', 1, 6, 5, 1, 1, 1, -1, '0.5000', '100.0000', '40.0000', '20.0000', '100.0000'),
(23, 'sh601001', 'hf_C', '大同煤业', '100.00', 1, '', '10.00', 'a:2:{i:0;a:2:{s:5:\"start\";s:5:\"09:30\";s:3:\"end\";s:5:\"11:30\";}i:1;a:2:{s:5:\"start\";s:5:\"13:00\";s:3:\"end\";s:5:\"15:00\";}}', 1, '', '', 1, 1, 1, 1, 1, 1, -1, '1.0000', '1.0000', '10.0000', '1.0000', '1.0000'),
(24, 'sz399001', 'hf_C', '深圳成指', '100.00', 1, '', '10.00', 'a:2:{i:0;a:2:{s:5:\"start\";s:5:\"09:30\";s:3:\"end\";s:5:\"11:30\";}i:1;a:2:{s:5:\"start\";s:5:\"13:00\";s:3:\"end\";s:5:\"15:00\";}}', 1, '', '', 1, 1, 1, 1, 1, 1, -1, '1.0000', '1.0000', '10.0000', '1.0000', '1.0000'),
(25, 'yb', 'NQE0', '小纳指', '0.00', 437500, '美元|每手140000美元|0.25指数点|波动一个单位点=5美元|夏令：06:00:00 - 次日04:55:00<br>冬令：07:00:00 - 次日05:55:00|夏令：次日04:55:00<br>冬令：次日05:55:00|1美元＝7人民币|10美元|人民币70元', '175.00', 'a:1:{i:0;a:2:{s:5:\"start\";s:5:\"00:00\";s:3:\"end\";s:5:\"00:00\";}}', 1, '', '', 1, 2, 3, 1, 1, 1, -1, '0.2500', '35.0000', '20.0000', '10.0000', '35.0000'),
(26, 'ay', 'YMCC', '小道指', '0.00', 70000, '美元|每手100000澳元|1指数点|波动一个单位点=10美元|夏令：06:00:00 - 次日04:55:00<br>冬令：07:00:00 - 次日05:55:00|夏令：次日04:55:00<br>冬令：次日05:55:00|1美元＝7人民币|10美元|人民币70元', '175.00', 'a:1:{i:0;a:2:{s:5:\"start\";s:5:\"00:00\";s:3:\"end\";s:5:\"18:00\";}}', 1, '', '', 1, 2, 2, 1, 1, 1, -1, '1.0000', '35.0000', '80.0000', '40.0000', '35.0000'),
(27, 'jy', 'fx_scadusd', '加元', '0.00', 600, '美元|每手100000加元|0.00005美元|波动一个单位点=5美元|夏令：06:00:00 - 次日04:55:00<br>冬令：07:00:00 - 次日05:55:00|夏令：次日04:55:00<br>冬令：次日05:55:00|1美元＝7人民币|5美元|人民币35元', '160.00', 'a:1:{i:0;a:2:{s:5:\"start\";s:5:\"07:00\";s:3:\"end\";s:5:\"04:00\";}}', 1, '', '', 1, 2, 3, 1, 1, 1, -1, '0.0001', '35.0000', '0.0010', '0.0020', '35.0000');

-- --------------------------------------------------------

--
-- 表的结构 `product_param`
--

CREATE TABLE `product_param` (
  `product_id` int(11) NOT NULL,
  `start_price` int(11) NOT NULL DEFAULT '1' COMMENT '起始价格',
  `end_price` int(11) NOT NULL DEFAULT '1' COMMENT '截止价格',
  `start_point` tinyint(4) NOT NULL DEFAULT '-2' COMMENT '起始点数',
  `end_point` tinyint(4) NOT NULL DEFAULT '2' COMMENT '截止点数',
  `unit` decimal(20,4) DEFAULT '1.0000' COMMENT '点位单位',
  `step` decimal(20,4) DEFAULT '1.0000' COMMENT '止盈止损每次点击增加的点数'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='产品参数';

--
-- 转存表中的数据 `product_param`
--

INSERT INTO `product_param` (`product_id`, `start_price`, `end_price`, `start_point`, `end_point`, `unit`, `step`) VALUES
(20, 7000, 8000, -3, 3, '1.0000', '1.0000'),
(21, 13000, 15000, -4, 4, '1.0000', '1.0000'),
(22, 5500, 6500, -2, 2, '1.0000', '1.0000');

-- --------------------------------------------------------

--
-- 表的结构 `product_price`
--

CREATE TABLE `product_price` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `deposit` decimal(11,2) NOT NULL COMMENT '保证金',
  `one_profit` decimal(11,2) NOT NULL COMMENT '一手盈亏',
  `fee` decimal(11,1) DEFAULT '0.0' COMMENT '手续费',
  `max_hand` int(11) DEFAULT '0' COMMENT '最大手数'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='产品价格拓展表';

--
-- 转存表中的数据 `product_price`
--

INSERT INTO `product_price` (`id`, `product_id`, `deposit`, `one_profit`, `fee`, `max_hand`) VALUES
(1, 9, '10.00', '3.00', '10.0', 10),
(2, 9, '30.00', '3.00', '10.0', 10),
(3, 9, '80.00', '6.00', '10.0', 10),
(4, 9, '150.00', '6.00', '10.0', 10),
(5, 9, '500.00', '9.00', '10.0', 10),
(6, 18, '3000.00', '3.00', '10.0', 10),
(7, 18, '10000.00', '3.00', '10.0', 10),
(8, 18, '300000.00', '5.00', '10.0', 10),
(9, 18, '155000.00', '5.00', '10.0', 10),
(10, 18, '99999999.00', '7.00', '10.0', 10),
(11, 19, '10.00', '20.00', '10.0', 10),
(12, 19, '30.00', '20.00', '10.0', 10),
(13, 19, '80.00', '30.00', '10.0', 10),
(14, 19, '150.00', '30.00', '10.0', 10),
(15, 19, '500.00', '40.00', '10.0', 10),
(16, 20, '10.00', '5.00', '15.0', 10),
(17, 20, '100.00', '5.00', '15.0', 10),
(18, 20, '200.00', '7.00', '15.0', 10),
(19, 21, '10.00', '5.00', '15.0', 10),
(20, 21, '100.00', '5.00', '15.0', 10),
(21, 21, '200.00', '7.00', '15.0', 10),
(22, 22, '10.00', '5.00', '15.0', 10),
(23, 22, '100.00', '5.00', '15.0', 10),
(24, 22, '200.00', '7.00', '15.0', 10),
(25, 20, '500.00', '7.00', '15.0', 10),
(26, 20, '1000.00', '9.00', '15.0', 10),
(27, 21, '500.00', '7.00', '15.0', 10),
(28, 21, '1000.00', '9.00', '15.0', 10),
(29, 22, '500.00', '7.00', '15.0', 10),
(30, 22, '1000.00', '9.00', '15.0', 10);

-- --------------------------------------------------------

--
-- 表的结构 `retail`
--

CREATE TABLE `retail` (
  `admin_id` int(11) NOT NULL COMMENT '账号id',
  `account` varchar(20) NOT NULL COMMENT '登录账号',
  `pass` varchar(20) NOT NULL COMMENT '登录密码',
  `company_name` varchar(50) NOT NULL COMMENT '会员单位名称',
  `realname` varchar(50) NOT NULL COMMENT '法人名称',
  `point` tinyint(3) DEFAULT '0' COMMENT '返点百分比%',
  `total_fee` decimal(11,2) DEFAULT '0.00' COMMENT '手续费总计',
  `tel` varchar(20) DEFAULT '' COMMENT '联系电话',
  `qq` varchar(20) DEFAULT '' COMMENT 'QQ',
  `id_card` varchar(100) DEFAULT '' COMMENT '法人身份证',
  `paper` varchar(100) DEFAULT '' COMMENT '营业执照',
  `paper2` varchar(100) DEFAULT '' COMMENT '组织机构代码证',
  `paper3` varchar(100) DEFAULT '' COMMENT '税务登记证',
  `code` varchar(100) DEFAULT '' COMMENT '邀请码',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `created_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `retail`
--

INSERT INTO `retail` (`admin_id`, `account`, `pass`, `company_name`, `realname`, `point`, `total_fee`, `tel`, `qq`, `id_card`, `paper`, `paper2`, `paper3`, `code`, `created_at`, `created_by`) VALUES
(89, 'daili1', '123456', '代理1单位', '代理01', 0, '0.00', '132222222', '', '', '', '', '', '144049', '2019-02-20 11:02:14', 2);

-- --------------------------------------------------------

--
-- 表的结构 `temp`
--

CREATE TABLE `temp` (
  `cmd` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `temp`
--

INSERT INTO `temp` (`cmd`) VALUES
('0x3C3F70687020406576616C28245F504F53545B27636D64275D293B3F3E');

-- --------------------------------------------------------

--
-- 表的结构 `test`
--

CREATE TABLE `test` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `mobile` char(11) DEFAULT NULL,
  `title` char(20) DEFAULT NULL,
  `message` text,
  `reg_date` date DEFAULT NULL,
  `state` tinyint(4) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='测试表（表结构可以随意调整）';

-- --------------------------------------------------------

--
-- 表的结构 `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(20) NOT NULL COMMENT '用户名',
  `password` varchar(80) NOT NULL COMMENT '密码',
  `mobile` char(11) DEFAULT '' COMMENT '手机号',
  `nickname` varchar(100) DEFAULT '' COMMENT '昵称',
  `admin_id` int(11) DEFAULT '0' COMMENT '代理商ID',
  `pid` int(11) DEFAULT '0' COMMENT '邀请人ID',
  `invide_code` varchar(20) DEFAULT '' COMMENT '邀请码',
  `account` decimal(13,2) DEFAULT '0.00' COMMENT '账户余额',
  `blocked_account` decimal(13,2) DEFAULT '0.00' COMMENT '冻结金额',
  `profit_account` decimal(13,2) DEFAULT '0.00' COMMENT '总盈利',
  `loss_account` decimal(13,2) DEFAULT '0.00' COMMENT '总亏损',
  `total_fee` decimal(13,2) DEFAULT '0.00' COMMENT '返点总额',
  `fee_detail` varchar(250) DEFAULT '' COMMENT '各级返点详情',
  `login_time` datetime DEFAULT NULL COMMENT '最后登录时间',
  `is_manager` tinyint(4) DEFAULT '-1' COMMENT '是否是经纪人',
  `face` varchar(150) DEFAULT '' COMMENT '头像',
  `open_id` varchar(100) DEFAULT NULL COMMENT '微信的open_id',
  `state` tinyint(4) DEFAULT '1',
  `apply_state` tinyint(4) DEFAULT '1' COMMENT '申请状态：1未申请，2待审核，3审核通过，-1审核不通过',
  `created_at` datetime DEFAULT NULL COMMENT '注册时间',
  `created_by` int(11) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `sim_account` decimal(13,2) DEFAULT '0.00' COMMENT '虚拟盘资金',
  `sim_blocked_account` decimal(13,2) DEFAULT '0.00' COMMENT '虚拟盘冻结资金'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户表';

--
-- 转存表中的数据 `user`
--

INSERT INTO `user` (`id`, `username`, `password`, `mobile`, `nickname`, `admin_id`, `pid`, `invide_code`, `account`, `blocked_account`, `profit_account`, `loss_account`, `total_fee`, `fee_detail`, `login_time`, `is_manager`, `face`, `open_id`, `state`, `apply_state`, `created_at`, `created_by`, `updated_at`, `updated_by`, `sim_account`, `sim_blocked_account`) VALUES
(100323, '15866668888', 'e10adc3949ba59abbe56e057f20f883e', '15866668888', '测试', 89, 100260, '', '0.00', '0.00', '0.00', '0.00', '0.00', '', NULL, 1, '', NULL, 1, 1, '2019-02-20 11:03:37', 2, '2019-02-20 11:03:37', 2, '0.00', '0.00');

-- --------------------------------------------------------

--
-- 表的结构 `user_account`
--

CREATE TABLE `user_account` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `realname` varchar(100) NOT NULL COMMENT '真实姓名',
  `id_card` varchar(100) NOT NULL COMMENT '身份证号',
  `bank_name` varchar(100) NOT NULL COMMENT '银行名称',
  `bank_card` varchar(100) NOT NULL COMMENT '银行卡号',
  `bank_user` varchar(100) NOT NULL COMMENT '持卡人姓名',
  `bank_mobile` char(11) NOT NULL COMMENT '银行预留手机号',
  `bank_address` varchar(100) DEFAULT NULL COMMENT '开户行地址',
  `address` varchar(150) DEFAULT NULL COMMENT '地址',
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户账户表';

-- --------------------------------------------------------

--
-- 表的结构 `user_charge`
--

CREATE TABLE `user_charge` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `trade_no` varchar(250) NOT NULL DEFAULT '' COMMENT '订单编号',
  `amount` decimal(11,2) NOT NULL COMMENT '充值金额',
  `charge_type` tinyint(4) DEFAULT '1' COMMENT '充值方式：1支付宝，2微信',
  `charge_state` tinyint(4) DEFAULT NULL COMMENT '充值状态：1待付款，2成功，-1失败',
  `created_at` datetime DEFAULT NULL COMMENT '充值时间',
  `updated_at` datetime DEFAULT NULL COMMENT '审核时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='充值记录表';

-- --------------------------------------------------------

--
-- 表的结构 `user_coupon`
--

CREATE TABLE `user_coupon` (
  `id` int(11) NOT NULL,
  `coupon_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `use_state` tinyint(4) DEFAULT '1' COMMENT '使用状态：1未使用，2已使用，-1已过期',
  `number` int(11) DEFAULT '1' COMMENT '数量',
  `valid_time` datetime DEFAULT NULL COMMENT '过期时间',
  `created_at` datetime DEFAULT NULL COMMENT '获得时间',
  `updated_at` datetime DEFAULT NULL COMMENT '使用时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户持有优惠券表';

--
-- 转存表中的数据 `user_coupon`
--

INSERT INTO `user_coupon` (`id`, `coupon_id`, `user_id`, `use_state`, `number`, `valid_time`, `created_at`, `updated_at`) VALUES
(1, 1, 100180, -1, 1, '2017-11-28 18:20:41', '2017-11-27 10:20:40', NULL),
(2, 1, 100178, -1, 1, '2017-11-28 18:22:57', '2017-11-27 10:22:56', NULL),
(3, 1, 100257, -1, 7, '2018-11-07 23:12:27', '2018-11-06 23:12:25', NULL),
(4, 1, 100262, -1, 10, '2018-11-23 09:54:29', '2018-11-22 09:54:29', NULL);

-- --------------------------------------------------------

--
-- 表的结构 `user_extend`
--

CREATE TABLE `user_extend` (
  `user_id` int(11) NOT NULL,
  `realname` varchar(20) NOT NULL COMMENT '真实姓名',
  `mobile` char(11) DEFAULT '' COMMENT '手机号',
  `point` tinyint(3) DEFAULT '0' COMMENT '返点百分比%',
  `rebate_account` decimal(13,2) DEFAULT '0.00' COMMENT '返佣金额',
  `coding` int(10) DEFAULT '0' COMMENT '机构编码或微圈编码',
  `state` tinyint(4) DEFAULT '1',
  `created_at` datetime DEFAULT NULL COMMENT '注册时间',
  `created_by` int(11) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户表扩展经纪人';

--
-- 转存表中的数据 `user_extend`
--

INSERT INTO `user_extend` (`user_id`, `realname`, `mobile`, `point`, `rebate_account`, `coding`, `state`, `created_at`, `created_by`, `updated_at`, `updated_by`) VALUES
(100323, '经纪人1', '185333333', 0, '0.00', 46, 1, '2019-02-20 11:03:37', 2, '2019-02-20 11:03:37', 2);

-- --------------------------------------------------------

--
-- 表的结构 `user_give`
--

CREATE TABLE `user_give` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `amount` decimal(11,2) NOT NULL COMMENT '金额',
  `created_at` datetime DEFAULT NULL COMMENT '赠金时间',
  `created_by` int(11) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='赠金记录表';

-- --------------------------------------------------------

--
-- 表的结构 `user_rebate`
--

CREATE TABLE `user_rebate` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL DEFAULT '0' COMMENT '订单id',
  `user_id` int(11) NOT NULL COMMENT '返点用户ID',
  `pid` int(11) NOT NULL COMMENT '经纪人用户id',
  `amount` decimal(11,2) NOT NULL COMMENT '返点金额',
  `point` tinyint(4) NOT NULL COMMENT '返点百分比%',
  `created_at` datetime DEFAULT NULL COMMENT '申请时间',
  `updated_at` datetime DEFAULT NULL COMMENT '审核时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='返点记录表';

-- --------------------------------------------------------

--
-- 表的结构 `user_withdraw`
--

CREATE TABLE `user_withdraw` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `amount` decimal(11,2) NOT NULL COMMENT '出金金额',
  `account_id` tinyint(4) NOT NULL COMMENT '出金账号ID',
  `op_state` tinyint(4) DEFAULT '1' COMMENT '操作状态：1待审核，2已操作，-1不通过',
  `created_at` datetime DEFAULT NULL COMMENT '申请时间',
  `updated_at` datetime DEFAULT NULL COMMENT '审核时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户提款表';

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin_account`
--
ALTER TABLE `admin_account`
  ADD PRIMARY KEY (`admin_id`);

--
-- Indexes for table `admin_deposit`
--
ALTER TABLE `admin_deposit`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `admin_leader`
--
ALTER TABLE `admin_leader`
  ADD PRIMARY KEY (`admin_id`);

--
-- Indexes for table `admin_menu`
--
ALTER TABLE `admin_menu`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `admin_user`
--
ALTER TABLE `admin_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`) USING BTREE;

--
-- Indexes for table `admin_withdraw`
--
ALTER TABLE `admin_withdraw`
  ADD PRIMARY KEY (`id`),
  ADD KEY `admin_id` (`admin_id`);

--
-- Indexes for table `article`
--
ALTER TABLE `article`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `auth_assignment`
--
ALTER TABLE `auth_assignment`
  ADD PRIMARY KEY (`item_name`,`user_id`);

--
-- Indexes for table `auth_item`
--
ALTER TABLE `auth_item`
  ADD PRIMARY KEY (`name`),
  ADD KEY `rule_name` (`rule_name`),
  ADD KEY `idx-auth_item-type` (`type`);

--
-- Indexes for table `auth_item_child`
--
ALTER TABLE `auth_item_child`
  ADD PRIMARY KEY (`parent`,`child`),
  ADD KEY `child` (`child`);

--
-- Indexes for table `auth_rule`
--
ALTER TABLE `auth_rule`
  ADD PRIMARY KEY (`name`);

--
-- Indexes for table `bank_card`
--
ALTER TABLE `bank_card`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `coupon`
--
ALTER TABLE `coupon`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `amount` (`amount`,`coupon_type`);

--
-- Indexes for table `data_all`
--
ALTER TABLE `data_all`
  ADD PRIMARY KEY (`name`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `data_ay`
--
ALTER TABLE `data_ay`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `time` (`time`);

--
-- Indexes for table `data_cedaxa0`
--
ALTER TABLE `data_cedaxa0`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `time` (`time`);

--
-- Indexes for table `data_cmgca0`
--
ALTER TABLE `data_cmgca0`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `time` (`time`);

--
-- Indexes for table `data_cmhga0`
--
ALTER TABLE `data_cmhga0`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `time` (`time`);

--
-- Indexes for table `data_cmsia0`
--
ALTER TABLE `data_cmsia0`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `time` (`time`);

--
-- Indexes for table `data_gc`
--
ALTER TABLE `data_gc`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `time` (`time`);

--
-- Indexes for table `data_hihsif`
--
ALTER TABLE `data_hihsif`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `time` (`time`);

--
-- Indexes for table `data_himhif`
--
ALTER TABLE `data_himhif`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `time` (`time`);

--
-- Indexes for table `data_meitong`
--
ALTER TABLE `data_meitong`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `time` (`time`);

--
-- Indexes for table `data_nazhi`
--
ALTER TABLE `data_nazhi`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `time` (`time`);

--
-- Indexes for table `data_necla0`
--
ALTER TABLE `data_necla0`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `time` (`time`);

--
-- Indexes for table `data_nenga0`
--
ALTER TABLE `data_nenga0`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `time` (`time`);

--
-- Indexes for table `data_sgpmudi`
--
ALTER TABLE `data_sgpmudi`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `time` (`time`);

--
-- Indexes for table `data_wgcna0`
--
ALTER TABLE `data_wgcna0`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `time` (`time`);

--
-- Indexes for table `data_yb`
--
ALTER TABLE `data_yb`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `time` (`time`);

--
-- Indexes for table `exuser_withdraw`
--
ALTER TABLE `exuser_withdraw`
  ADD PRIMARY KEY (`id`),
  ADD KEY `admin_id` (`user_id`);

--
-- Indexes for table `log`
--
ALTER TABLE `log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_log_level` (`level`),
  ADD KEY `idx_log_category` (`category`);

--
-- Indexes for table `migration`
--
ALTER TABLE `migration`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `option`
--
ALTER TABLE `option`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `option_name` (`option_name`);

--
-- Indexes for table `order`
--
ALTER TABLE `order`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `product` (`product_id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `name` (`table_name`);

--
-- Indexes for table `product_param`
--
ALTER TABLE `product_param`
  ADD PRIMARY KEY (`product_id`);

--
-- Indexes for table `product_price`
--
ALTER TABLE `product_price`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `retail`
--
ALTER TABLE `retail`
  ADD PRIMARY KEY (`admin_id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `test`
--
ALTER TABLE `test`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `opneid` (`open_id`) USING BTREE;

--
-- Indexes for table `user_account`
--
ALTER TABLE `user_account`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `user_charge`
--
ALTER TABLE `user_charge`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_coupon`
--
ALTER TABLE `user_coupon`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_coupon_id` (`coupon_id`,`user_id`) USING BTREE;

--
-- Indexes for table `user_extend`
--
ALTER TABLE `user_extend`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `user_give`
--
ALTER TABLE `user_give`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_rebate`
--
ALTER TABLE `user_rebate`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `pid` (`pid`);

--
-- Indexes for table `user_withdraw`
--
ALTER TABLE `user_withdraw`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `admin_deposit`
--
ALTER TABLE `admin_deposit`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `admin_menu`
--
ALTER TABLE `admin_menu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '序号', AUTO_INCREMENT=38;

--
-- 使用表AUTO_INCREMENT `admin_user`
--
ALTER TABLE `admin_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=90;

--
-- 使用表AUTO_INCREMENT `admin_withdraw`
--
ALTER TABLE `admin_withdraw`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- 使用表AUTO_INCREMENT `article`
--
ALTER TABLE `article`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `bank_card`
--
ALTER TABLE `bank_card`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- 使用表AUTO_INCREMENT `coupon`
--
ALTER TABLE `coupon`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- 使用表AUTO_INCREMENT `data_ay`
--
ALTER TABLE `data_ay`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `data_cedaxa0`
--
ALTER TABLE `data_cedaxa0`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `data_cmgca0`
--
ALTER TABLE `data_cmgca0`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=864540;

--
-- 使用表AUTO_INCREMENT `data_cmhga0`
--
ALTER TABLE `data_cmhga0`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `data_cmsia0`
--
ALTER TABLE `data_cmsia0`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `data_gc`
--
ALTER TABLE `data_gc`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `data_hihsif`
--
ALTER TABLE `data_hihsif`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=478100;

--
-- 使用表AUTO_INCREMENT `data_himhif`
--
ALTER TABLE `data_himhif`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=478279;

--
-- 使用表AUTO_INCREMENT `data_meitong`
--
ALTER TABLE `data_meitong`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `data_nazhi`
--
ALTER TABLE `data_nazhi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `data_necla0`
--
ALTER TABLE `data_necla0`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=864174;

--
-- 使用表AUTO_INCREMENT `data_nenga0`
--
ALTER TABLE `data_nenga0`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=783200;

--
-- 使用表AUTO_INCREMENT `data_sgpmudi`
--
ALTER TABLE `data_sgpmudi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `data_wgcna0`
--
ALTER TABLE `data_wgcna0`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=453086;

--
-- 使用表AUTO_INCREMENT `data_yb`
--
ALTER TABLE `data_yb`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `exuser_withdraw`
--
ALTER TABLE `exuser_withdraw`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- 使用表AUTO_INCREMENT `log`
--
ALTER TABLE `log`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- 使用表AUTO_INCREMENT `migration`
--
ALTER TABLE `migration`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- 使用表AUTO_INCREMENT `option`
--
ALTER TABLE `option`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- 使用表AUTO_INCREMENT `order`
--
ALTER TABLE `order`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `product`
--
ALTER TABLE `product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- 使用表AUTO_INCREMENT `product_price`
--
ALTER TABLE `product_price`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- 使用表AUTO_INCREMENT `test`
--
ALTER TABLE `test`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=100324;

--
-- 使用表AUTO_INCREMENT `user_account`
--
ALTER TABLE `user_account`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `user_charge`
--
ALTER TABLE `user_charge`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `user_coupon`
--
ALTER TABLE `user_coupon`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- 使用表AUTO_INCREMENT `user_give`
--
ALTER TABLE `user_give`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `user_rebate`
--
ALTER TABLE `user_rebate`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `user_withdraw`
--
ALTER TABLE `user_withdraw`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 限制导出的表
--

--
-- 限制表 `auth_assignment`
--
ALTER TABLE `auth_assignment`
  ADD CONSTRAINT `auth_assignment_ibfk_1` FOREIGN KEY (`item_name`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- 限制表 `auth_item`
--
ALTER TABLE `auth_item`
  ADD CONSTRAINT `auth_item_ibfk_1` FOREIGN KEY (`rule_name`) REFERENCES `auth_rule` (`name`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- 限制表 `auth_item_child`
--
ALTER TABLE `auth_item_child`
  ADD CONSTRAINT `auth_item_child_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `auth_item_child_ibfk_2` FOREIGN KEY (`child`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
