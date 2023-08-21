/*
 Navicat Premium Data Transfer

 Source Server         : node01
 Source Server Type    : MySQL
 Source Server Version : 50741
 Source Host           : node01:3306
 Source Schema         : db_datalight

 Target Server Type    : MySQL
 Target Server Version : 50741
 File Encoding         : 65001

 Date: 04/08/2023 14:35:13
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_dl_cluster
-- ----------------------------
DROP TABLE IF EXISTS `t_dl_cluster`;
CREATE TABLE `t_dl_cluster`  (
  `id` bigint(20) NOT NULL COMMENT '分布式 ID',
  `create_time` bigint(20) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` bigint(20) NULL DEFAULT NULL COMMENT '修改时间',
  `version` bigint(20) NOT NULL DEFAULT 0 COMMENT '乐观锁版本',
  `dlc_version` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '服务组件版本 当前服务组件套装的版本：DataLightComponents',
  `cluster_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主机名',
  `cluster_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '集群类型 存储、计算、混合，枚举见代码',
  `cluster_state` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '集群状态 枚举值，见代码',
  `cluster_desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '集群描述',
  `relative_cluster_id` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '关联集群 ID 只有计算集群可以关联存储或混合集群',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '集群信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for t_dl_component
-- ----------------------------
DROP TABLE IF EXISTS `t_dl_component`;
CREATE TABLE `t_dl_component`  (
  `id` bigint(20) NOT NULL COMMENT '分布式 ID',
  `create_time` bigint(20) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` bigint(20) NULL DEFAULT NULL COMMENT '修改时间',
  `version` bigint(20) NOT NULL DEFAULT 0 COMMENT '乐观锁版本',
  `cluster_id` bigint(20) NOT NULL COMMENT '集群 ID',
  `node_id` bigint(20) NOT NULL COMMENT '节点 ID',
  `service_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '服务名称',
  `component_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '组件名称',
  `component_state` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '组件状态',
  `priority` bigint(20) NOT NULL COMMENT '优先级 数字越小，优先级越高',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '组件信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for t_dl_config
-- ----------------------------
DROP TABLE IF EXISTS `t_dl_config`;
CREATE TABLE `t_dl_config`  (
  `id` bigint(20) NOT NULL COMMENT '分布式 ID',
  `create_time` bigint(20) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` bigint(20) NULL DEFAULT NULL COMMENT '修改时间',
  `version` bigint(20) NOT NULL DEFAULT 0 COMMENT '乐观锁版本',
  `cluster_id` bigint(20) NOT NULL COMMENT '集群 ID',
  `node_id` bigint(20) NOT NULL COMMENT '节点 ID',
  `service_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '服务名称',
  `component_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '组件名称',
  `config_content_id` bigint(20) NOT NULL COMMENT '配置文件内容 ID',
  `filename` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '配置文件名称',
  `config_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '配置文件路径',
  `config_version` bigint(20) NOT NULL DEFAULT 1 COMMENT '当前版本号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '配置信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for t_dl_config_content
-- ----------------------------
DROP TABLE IF EXISTS `t_dl_config_content`;
CREATE TABLE `t_dl_config_content`  (
  `id` bigint(20) NOT NULL COMMENT '分布式 ID',
  `create_time` bigint(20) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` bigint(20) NULL DEFAULT NULL COMMENT '修改时间',
  `version` bigint(20) NOT NULL DEFAULT 0 COMMENT '乐观锁版本',
  `cluster_id` bigint(20) NOT NULL COMMENT '集群 ID',
  `filename` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '配置文件名称',
  `config_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '配置文件内容 配置文件内容的 Base64',
  `sha256` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '文件内容摘要 256 位摘要算法，极低碰撞概率，用于比较文件内容是否相同(文件内容+文件绝对路径）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '配置文件内容信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for t_dl_config_pre
-- ----------------------------
DROP TABLE IF EXISTS `t_dl_config_pre`;
CREATE TABLE `t_dl_config_pre`  (
  `id` bigint(20) NOT NULL COMMENT '分布式 ID',
  `create_time` bigint(20) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` bigint(20) NULL DEFAULT NULL COMMENT '修改时间',
  `version` bigint(20) NOT NULL DEFAULT 0 COMMENT '乐观锁版本',
  `cluster_id` bigint(20) NOT NULL COMMENT '集群 ID',
  `service_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '服务名称',
  `placeholder` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '配置文件占位符 templated 中各类被{{}}包括的占位项',
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '占位符修改后的值',
  `default_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '占位符的默认值',
  `templated_config_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '配置模板文件路径 绝对路径',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '服务组件预配置信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for t_dl_init_procedure
-- ----------------------------
DROP TABLE IF EXISTS `t_dl_init_procedure`;
CREATE TABLE `t_dl_init_procedure`  (
  `id` bigint(20) NOT NULL COMMENT '分布式 ID',
  `create_time` bigint(20) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` bigint(20) NULL DEFAULT NULL COMMENT '修改时间',
  `version` bigint(20) NOT NULL DEFAULT 0 COMMENT '乐观锁版本',
  `cluster_id` bigint(20) NOT NULL COMMENT '集群 ID',
  `tag` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '本次进度唯一编码',
  `procedure_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '进度名称',
  `procedure_state` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '进度状态 枚举，具体见代码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '初始化步骤缓存信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for t_dl_job
-- ----------------------------
DROP TABLE IF EXISTS `t_dl_job`;
CREATE TABLE `t_dl_job`  (
  `id` bigint(20) NOT NULL COMMENT '分布式 ID',
  `create_time` bigint(20) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` bigint(20) NULL DEFAULT NULL COMMENT '修改时间',
  `version` bigint(20) NOT NULL DEFAULT 0 COMMENT '乐观锁版本',
  `tag` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '同批任务唯一标识',
  `cluster_id` bigint(20) NOT NULL COMMENT '集群 ID',
  `job_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Job 名称',
  `job_state` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Job 状态 枚举值：见代码',
  `start_time` bigint(20) NULL DEFAULT NULL COMMENT '执行起始时间 毫秒时间戳',
  `end_time` bigint(20) NULL DEFAULT NULL COMMENT '执行结束时间 毫秒时间戳',
  `duration` bigint(20) NULL DEFAULT NULL COMMENT '耗时 毫秒时间戳',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'Job 信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for t_dl_job_log
-- ----------------------------
DROP TABLE IF EXISTS `t_dl_job_log`;
CREATE TABLE `t_dl_job_log`  (
  `id` bigint(20) NOT NULL COMMENT '分布式 ID',
  `create_time` bigint(20) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` bigint(20) NULL DEFAULT NULL COMMENT '修改时间',
  `version` bigint(20) NOT NULL DEFAULT 0 COMMENT '乐观锁版本',
  `tag` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '同批任务唯一标识',
  `cluster_id` bigint(20) NOT NULL COMMENT '集群 ID',
  `job_id` bigint(20) NOT NULL COMMENT 'Job ID',
  `stage_id` bigint(20) NOT NULL COMMENT 'Stage ID',
  `task_id` bigint(20) NOT NULL COMMENT 'Task ID',
  `step_id` bigint(20) NOT NULL COMMENT 'Step ID',
  `log_stdout` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '标准日志',
  `log_errout` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '错误日志',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'Job 工作日志信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for t_dl_login_event
-- ----------------------------
DROP TABLE IF EXISTS `t_dl_login_event`;
CREATE TABLE `t_dl_login_event`  (
  `id` bigint(20) NOT NULL COMMENT '分布式 ID',
  `create_time` bigint(20) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` bigint(20) NULL DEFAULT NULL COMMENT '修改时间',
  `version` bigint(20) NOT NULL DEFAULT 0 COMMENT '乐观锁版本',
  `user_id` bigint(20) NOT NULL COMMENT '用户 ID',
  `last_login` bigint(20) NOT NULL COMMENT '最近一次登录时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for t_dl_node
-- ----------------------------
DROP TABLE IF EXISTS `t_dl_node`;
CREATE TABLE `t_dl_node`  (
  `id` bigint(20) NOT NULL COMMENT '分布式 ID',
  `create_time` bigint(20) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` bigint(20) NULL DEFAULT NULL COMMENT '修改时间',
  `version` bigint(20) NOT NULL DEFAULT 0 COMMENT '乐观锁版本',
  `cluster_id` bigint(20) NOT NULL COMMENT '集群 ID',
  `hostname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主机名',
  `ipv4` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'IPV4 地址',
  `ipv6` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'IPV6 地址',
  `ssh_port` bigint(20) NULL DEFAULT 22 COMMENT 'SSH 端口 默认为 22 端口，可自定义修改',
  `cpu_arch` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'CPU 架构',
  `cpu_cores` bigint(20) NOT NULL COMMENT 'CPU 核心数 单位：个',
  `ram` bigint(20) NOT NULL COMMENT '内存总大小 单位：K-bytes',
  `disk` bigint(20) NOT NULL COMMENT '磁盘总容量 单位：K-bytes',
  `node_state` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '节点状态 状态枚举，见代码',
  `os_version` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '系统版本',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '节点信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for t_dl_node_init
-- ----------------------------
DROP TABLE IF EXISTS `t_dl_node_init`;
CREATE TABLE `t_dl_node_init`  (
  `id` bigint(20) NOT NULL COMMENT '分布式 ID',
  `create_time` bigint(20) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` bigint(20) NULL DEFAULT NULL COMMENT '修改时间',
  `version` bigint(20) NOT NULL DEFAULT 0 COMMENT '乐观锁版本',
  `cluster_id` bigint(20) NOT NULL COMMENT '集群 ID',
  `hostname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主机名',
  `ipv4` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'IPV4 地址',
  `ipv6` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'IPV6 地址',
  `ssh_port` bigint(20) NULL DEFAULT 22 COMMENT 'SSH 端口 默认为 22 端口，可自定义修改',
  `cpu_arch` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'CPU 架构',
  `cpu_cores` bigint(20) NOT NULL COMMENT 'CPU 核心数 单位：个',
  `ram` bigint(20) NOT NULL COMMENT '内存总大小 单位：K-bytes',
  `disk` bigint(20) NOT NULL COMMENT '磁盘总容量 单位：K-bytes',
  `os_version` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '系统版本',
  `node_init_state` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '当前初始状态 枚举，见代码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '节点初始化信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for t_dl_node_job
-- ----------------------------
DROP TABLE IF EXISTS `t_dl_node_job`;
CREATE TABLE `t_dl_node_job`  (
  `id` bigint(20) NOT NULL COMMENT '分布式 ID',
  `create_time` bigint(20) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` bigint(20) NULL DEFAULT NULL COMMENT '修改时间',
  `version` bigint(20) NOT NULL DEFAULT 0 COMMENT '乐观锁版本',
  `tag` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '同批任务唯一标识',
  `cluster_id` bigint(20) NOT NULL COMMENT '集群 ID',
  `node_job_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Job 名称',
  `node_job_state` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Job 状态 枚举值：见代码',
  `start_time` bigint(20) NULL DEFAULT NULL COMMENT '执行起始时间 毫秒时间戳',
  `end_time` bigint(20) NULL DEFAULT NULL COMMENT '执行结束时间 毫秒时间戳',
  `duration` bigint(20) NULL DEFAULT NULL COMMENT '耗时 毫秒时间戳',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'Job 节点工作信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for t_dl_node_job_log
-- ----------------------------
DROP TABLE IF EXISTS `t_dl_node_job_log`;
CREATE TABLE `t_dl_node_job_log`  (
  `id` bigint(20) NOT NULL COMMENT '分布式 ID',
  `create_time` bigint(20) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` bigint(20) NULL DEFAULT NULL COMMENT '修改时间',
  `version` bigint(20) NOT NULL DEFAULT 0 COMMENT '乐观锁版本',
  `tag` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '同批任务唯一标识',
  `cluster_id` bigint(20) NOT NULL COMMENT '集群 ID',
  `node_job_id` bigint(20) NOT NULL COMMENT 'NodeJob ID',
  `node_task_id` bigint(20) NOT NULL COMMENT 'NodeTask ID',
  `node_step_id` bigint(20) NOT NULL COMMENT 'NodeStep ID',
  `log_stdout` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '标准日志',
  `log_errout` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '错误日志',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'Job 节点工作日志信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for t_dl_node_step
-- ----------------------------
DROP TABLE IF EXISTS `t_dl_node_step`;
CREATE TABLE `t_dl_node_step`  (
  `id` bigint(20) NOT NULL COMMENT '分布式 ID',
  `create_time` bigint(20) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` bigint(20) NULL DEFAULT NULL COMMENT '修改时间',
  `version` bigint(20) NOT NULL DEFAULT 0 COMMENT '乐观锁版本',
  `tag` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '同批任务唯一标识',
  `cluster_id` bigint(20) NOT NULL COMMENT '集群 ID',
  `node_job_id` bigint(20) NOT NULL COMMENT 'Job ID',
  `node_task_id` bigint(20) NOT NULL COMMENT 'Task ID',
  `node_step_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Step 名称',
  `node_step_state` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Step 状态 枚举值：见代码',
  `node_step_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Step 类型 枚举值：见代码',
  `start_time` bigint(20) NULL DEFAULT NULL COMMENT '执行起始时间 毫秒时间戳',
  `end_time` bigint(20) NULL DEFAULT NULL COMMENT '执行结束时间 毫秒时间戳',
  `duration` bigint(20) NULL DEFAULT NULL COMMENT '耗时 毫秒时间戳',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'Step 节点步骤信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for t_dl_node_task
-- ----------------------------
DROP TABLE IF EXISTS `t_dl_node_task`;
CREATE TABLE `t_dl_node_task`  (
  `id` bigint(20) NOT NULL COMMENT '分布式 ID',
  `create_time` bigint(20) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` bigint(20) NULL DEFAULT NULL COMMENT '修改时间',
  `version` bigint(20) NOT NULL DEFAULT 0 COMMENT '乐观锁版本',
  `cluster_id` bigint(20) NOT NULL COMMENT '集群 ID',
  `tag` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '同批任务唯一标识',
  `node_job_id` bigint(20) NOT NULL COMMENT 'Job ID',
  `node_id` bigint(20) NOT NULL COMMENT '节点 ID',
  `hostname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '节点主机名',
  `node_ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'IPV4 地址 内网地址',
  `node_task_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Task 名称',
  `node_task_state` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Task 状态 枚举值：见代码',
  `node_action_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '操作类型 枚举值：见代码',
  `start_time` bigint(20) NULL DEFAULT NULL COMMENT '执行起始时间 毫秒时间戳',
  `end_time` bigint(20) NULL DEFAULT NULL COMMENT '执行结束时间 毫秒时间戳',
  `duration` bigint(20) NULL DEFAULT NULL COMMENT '耗时 毫秒时间戳',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'Task 节点任务信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for t_dl_service
-- ----------------------------
DROP TABLE IF EXISTS `t_dl_service`;
CREATE TABLE `t_dl_service`  (
  `id` bigint(20) NOT NULL COMMENT '分布式 ID',
  `create_time` bigint(20) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` bigint(20) NULL DEFAULT NULL COMMENT '修改时间',
  `version` bigint(20) NOT NULL DEFAULT 0 COMMENT '乐观锁版本',
  `cluster_id` bigint(20) NOT NULL COMMENT '集群 ID',
  `service_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '服务名称',
  `service_state` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '服务状态',
  `priority` bigint(20) NOT NULL COMMENT '优先级 数字越小，优先级越高',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '服务信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for t_dl_stage
-- ----------------------------
DROP TABLE IF EXISTS `t_dl_stage`;
CREATE TABLE `t_dl_stage`  (
  `id` bigint(20) NOT NULL COMMENT '分布式 ID',
  `create_time` bigint(20) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` bigint(20) NULL DEFAULT NULL COMMENT '修改时间',
  `version` bigint(20) NOT NULL DEFAULT 0 COMMENT '乐观锁版本',
  `tag` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '同批任务唯一标识',
  `cluster_id` bigint(20) NOT NULL COMMENT '集群 ID',
  `job_id` bigint(20) NOT NULL COMMENT 'Job ID',
  `stage_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Stage 名称',
  `stage_state` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Stage 状态 枚举值：见代码',
  `service_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '服务名称 全大写英文命名法，可以唯一 标识服务',
  `start_time` bigint(20) NULL DEFAULT NULL COMMENT '执行起始时间 毫秒时间戳',
  `end_time` bigint(20) NULL DEFAULT NULL COMMENT '执行结束时间 毫秒时间戳',
  `duration` bigint(20) NULL DEFAULT NULL COMMENT '耗时 毫秒时间戳',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'Stage 信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for t_dl_step
-- ----------------------------
DROP TABLE IF EXISTS `t_dl_step`;
CREATE TABLE `t_dl_step`  (
  `id` bigint(20) NOT NULL COMMENT '分布式 ID',
  `create_time` bigint(20) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` bigint(20) NULL DEFAULT NULL COMMENT '修改时间',
  `version` bigint(20) NOT NULL DEFAULT 0 COMMENT '乐观锁版本',
  `tag` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '同批任务唯一标识',
  `cluster_id` bigint(20) NOT NULL COMMENT '集群 ID',
  `job_id` bigint(20) NOT NULL COMMENT 'Job ID',
  `stage_id` bigint(20) NOT NULL COMMENT 'Stage ID',
  `task_id` bigint(20) NOT NULL COMMENT 'Task ID',
  `step_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Step 名称',
  `step_state` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Step 状态 枚举值：见代码',
  `step_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Step 类型 枚举值：见代码',
  `start_time` bigint(20) NULL DEFAULT NULL COMMENT '执行起始时间 毫秒时间戳',
  `end_time` bigint(20) NULL DEFAULT NULL COMMENT '执行结束时间 毫秒时间戳',
  `duration` bigint(20) NULL DEFAULT NULL COMMENT '耗时 毫秒时间戳',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'Step 信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for t_dl_task
-- ----------------------------
DROP TABLE IF EXISTS `t_dl_task`;
CREATE TABLE `t_dl_task`  (
  `id` bigint(20) NOT NULL COMMENT '分布式 ID',
  `create_time` bigint(20) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` bigint(20) NULL DEFAULT NULL COMMENT '修改时间',
  `version` bigint(20) NOT NULL DEFAULT 0 COMMENT '乐观锁版本',
  `cluster_id` bigint(20) NOT NULL COMMENT '集群 ID',
  `tag` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '同批任务唯一标识',
  `job_id` bigint(20) NOT NULL COMMENT 'Job ID',
  `stage_id` bigint(20) NOT NULL COMMENT 'Stage ID',
  `node_id` bigint(20) NOT NULL COMMENT '节点 ID',
  `hostname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '节点主机名',
  `node_ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'IPV4 地址 内网地址',
  `task_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Task 名称',
  `task_state` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Task 状态 枚举值：见代码',
  `action_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '操作类型 枚举值：见代码',
  `service_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '服务名称 全大写英文命名法，可以唯一 标识服务',
  `component_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '组件名称 帕斯卡命名法，可以唯一组件',
  `start_time` bigint(20) NULL DEFAULT NULL COMMENT '执行起始时间 毫秒时间戳',
  `end_time` bigint(20) NULL DEFAULT NULL COMMENT '执行结束时间 毫秒时间戳',
  `duration` bigint(20) NULL DEFAULT NULL COMMENT '耗时 毫秒时间戳',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'Task 信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for t_dl_user
-- ----------------------------
DROP TABLE IF EXISTS `t_dl_user`;
CREATE TABLE `t_dl_user`  (
  `id` bigint(20) NOT NULL COMMENT '分布式 ID',
  `create_time` bigint(20) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` bigint(20) NULL DEFAULT NULL COMMENT '修改时间',
  `version` bigint(20) NOT NULL DEFAULT 0 COMMENT '乐观锁版本',
  `nickname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户昵称',
  `realname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '真实姓名',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '头像',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户基础信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for t_dl_user_auth
-- ----------------------------
DROP TABLE IF EXISTS `t_dl_user_auth`;
CREATE TABLE `t_dl_user_auth`  (
  `id` bigint(20) NOT NULL COMMENT '分布式 ID',
  `create_time` bigint(20) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` bigint(20) NULL DEFAULT NULL COMMENT '修改时间',
  `version` bigint(20) NOT NULL DEFAULT 0 COMMENT '乐观锁版本',
  `user_id` bigint(20) NOT NULL COMMENT '用户 ID 用户基础表主键 ID',
  `identity_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '账户类型 枚举：EMAIL, PHONE, USERNAME',
  `principal` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '认证主体 登录的账户名',
  `credential` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '认证凭证 认证凭证，密码 或 Token',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户认证信息表' ROW_FORMAT = DYNAMIC;

SET FOREIGN_KEY_CHECKS = 1;