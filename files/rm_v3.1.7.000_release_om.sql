-- ----------------------------
-- Table structure for rm_approval_record
-- ----------------------------
DROP TABLE IF EXISTS `rm_approval_record`;
CREATE TABLE `rm_approval_record`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态',
  `created_by` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_by` bigint(20) NULL DEFAULT NULL COMMENT '更新人',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `event_id` bigint(20) NULL DEFAULT NULL COMMENT '事务id',
  `approval_id` bigint(20) NULL DEFAULT NULL COMMENT '审批流id',
  `approval_node_id` bigint(20) NULL DEFAULT NULL COMMENT '审批流节点id',
  `approval_times` int(10) NULL DEFAULT NULL COMMENT '审批流轮次',
  `role_id` bigint(20) NULL DEFAULT NULL COMMENT '当前节点操作人角色id',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '当前节点操作人id',
  `approval_type` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '审批流操作结果类型(见码表approval_type)',
  `opinion` varchar(2048) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '审批意见',
  `dpet_user_id` bigint(20) NULL DEFAULT NULL COMMENT '组织架构审批人',
  `operator_user_id` bigint(20) NULL DEFAULT NULL COMMENT '下一节点操作人(审批人)id',
  `operator_role_id` bigint(20) NULL DEFAULT NULL COMMENT '下一节点操作人(审批人)角色id',
  `is_over` tinyint(4) NOT NULL DEFAULT 1 COMMENT '是否完接 1-未完结 2-已完结',
  `function_type` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '审批功能类型(码表approval_function_type)',
  `pass_by_default` tinyint(4) NULL DEFAULT NULL COMMENT '是否为默认通过 ',
  `working_hours` double(10, 2) NULL DEFAULT NULL COMMENT '该条工时审批流的工时数量 ',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `approval_id`(`event_id`, `approval_id`, `approval_node_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '审批记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for rm_associated_hours
-- ----------------------------
DROP TABLE IF EXISTS `rm_associated_hours`;
CREATE TABLE `rm_associated_hours`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态',
  `created_by` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_by` bigint(20) NULL DEFAULT NULL COMMENT '更新人',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `associated_hours` double(10, 2) NULL DEFAULT NULL COMMENT '被关联工时数量',
  `be_associated_id` bigint(20) NULL DEFAULT NULL COMMENT '被关联的工时Id（项目中的被关联的工时Id）',
  `working_hours_id` bigint(20) NULL DEFAULT NULL COMMENT '使用工时的id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '工时关联中间表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for rm_cfg_approval
-- ----------------------------
DROP TABLE IF EXISTS `rm_cfg_approval`;
CREATE TABLE `rm_cfg_approval`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态',
  `created_by` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_by` bigint(20) NULL DEFAULT NULL COMMENT '更新人',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `study_id` bigint(20) NULL DEFAULT NULL COMMENT '项目id 为空时表示是公司级',
  `function_type` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '审批功能类型(码表approval_function_type)',
  `role_id` bigint(20) NULL DEFAULT NULL COMMENT '发起人角色id',
  `parent_id` bigint(20) NULL DEFAULT NULL COMMENT '所属公司级审批流id',
  `is_release` tinyint(4) NULL DEFAULT NULL COMMENT '发布(1-已发布 2-未发布)',
  `no_approval` tinyint(4) NOT NULL DEFAULT '2' COMMENT '无需审批开关：1=启用 2=停用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '审批流主表-设置' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for rm_cfg_approval_node
-- ----------------------------
DROP TABLE IF EXISTS `rm_cfg_approval_node`;
CREATE TABLE `rm_cfg_approval_node`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态',
  `created_by` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_by` bigint(20) NULL DEFAULT NULL COMMENT '更新人',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `approval_id` bigint(20) NULL DEFAULT NULL COMMENT '审批流主表id',
  `node_type` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '审批节点类型(见码表approval_node_type)',
  `node_times` int(10) NULL DEFAULT NULL COMMENT '节点顺序/轮次(从1开始)',
  `can_update` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '是否可以修改(公司级配置的不可修改 码表approval_update_type) 1-可以 2-不可以',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `approval_id`(`approval_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '审批流节点详情表-设置' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for rm_cfg_approval_role
-- ----------------------------
DROP TABLE IF EXISTS `rm_cfg_approval_role`;
CREATE TABLE `rm_cfg_approval_role`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态',
  `created_by` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_by` bigint(20) NULL DEFAULT NULL COMMENT '更新人',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `approval_node_id` bigint(20) NULL DEFAULT NULL COMMENT '审批流节点表id',
  `role_id` bigint(20) NULL DEFAULT NULL COMMENT '审批流节点角色id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `approval_node_id`(`approval_node_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '审批流角色详情表-设置' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for rm_company_project_task
-- ----------------------------
DROP TABLE IF EXISTS `rm_company_project_task`;
CREATE TABLE `rm_company_project_task`  (
  `id` bigint(50) NOT NULL COMMENT '主键',
  `status` tinyint(4) NULL DEFAULT 1 COMMENT '状态',
  `created_by` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_by` bigint(20) NULL DEFAULT NULL COMMENT '修改人',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `task_name` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务名称',
  `remarks` varchar(1024) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '备注',
  `active` tinyint(4) NULL DEFAULT NULL COMMENT '启停状态1-启用 2-停用',
  `not_removable` tinyint(4) DEFAULT '1' COMMENT' 1 可以  0不可删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '公司非项目工时' ROW_FORMAT = Dynamic;


-- ----------------------------
-- Table structure for rm_cost_attribution
-- ----------------------------
DROP TABLE IF EXISTS `rm_cost_attribution`;
CREATE TABLE `rm_cost_attribution`  (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '归属名称',
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '描述',
  `sort` tinyint(3) NULL DEFAULT NULL COMMENT '排序号',
  `status` tinyint(4) NULL DEFAULT 1 COMMENT '状态',
  `created_by` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_by` bigint(20) NULL DEFAULT NULL COMMENT '更新人',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `dept_id` bigint(20) DEFAULT NULL COMMENT '部门ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '基础设置-费用归属表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for rm_cost_setting
-- ----------------------------
DROP TABLE IF EXISTS `rm_cost_setting`;
CREATE TABLE `rm_cost_setting`  (
  `id` bigint(20) NOT NULL,
  `tax_rate_status` tinyint(3) NULL DEFAULT NULL COMMENT '汇率/税率状态 0不启用  1启用',
  `discount_rate_status` tinyint(3) NULL DEFAULT NULL COMMENT '折扣率状态 0不启用  1启用',
  `discount_amount_status` tinyint(3) NULL DEFAULT NULL COMMENT '折扣金额状态 0不启用  1启用',
  `status` tinyint(4) NULL DEFAULT 1 COMMENT '状态',
  `created_by` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_by` bigint(20) NULL DEFAULT NULL COMMENT '更新人',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `exchange_rate_status` tinyint(3) DEFAULT 1 COMMENT '汇率状态 0不启用  1启用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '费用项设置表' ROW_FORMAT = Dynamic;


INSERT INTO `rm_cost_setting` VALUES (-1, 1, 1, 1, 1, NULL, '2022-06-15 18:00:00', NULL, NULL , 1);
-- ----------------------------
-- Table structure for rm_currency
-- ----------------------------
DROP TABLE IF EXISTS `rm_currency`;
CREATE TABLE `rm_currency`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '币种名称',
  `created_by` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_by` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `status` int(11) NULL DEFAULT 1 COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '币种表 ' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for rm_custom
-- ----------------------------
DROP TABLE IF EXISTS `rm_custom`;
CREATE TABLE `rm_custom`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态',
  `created_by` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_by` bigint(20) NULL DEFAULT NULL COMMENT '更新人',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '用户id',
  `domian` int(20) NULL DEFAULT NULL COMMENT '个性化域',
  `subdomain` int(20) NULL DEFAULT NULL COMMENT '个性化子域',
  `content` text CHARACTER SET utf8 COLLATE utf8_bin NULL COMMENT '值',
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '个性化表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for rm_manpower_application
-- ----------------------------
DROP TABLE IF EXISTS `rm_manpower_application`;
CREATE TABLE `rm_manpower_application`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `study_id` bigint(20) NOT NULL COMMENT '项目id',
  `version_id` bigint(20) NOT NULL COMMENT '版本id',
  `fte` double(10, 2) NULL DEFAULT NULL COMMENT 'FET',
  `position_fte` double(10, 2) NULL DEFAULT NULL COMMENT '职位FTE',
  `old_position_fte` double(10,2) DEFAULT NULL COMMENT '历史职位FTE',
  `raw_fte` double(10,2) DEFAULT NULL COMMENT '原始FTE',
  `raw_position_fte` double(10,2) DEFAULT NULL COMMENT '原始职位FTE',
  `position_id` bigint(20) NULL DEFAULT NULL COMMENT '职位id',
  `position_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '职位名称',
  `parent_role_id` bigint(20) NULL DEFAULT NULL COMMENT '角色id',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '描述',
  `num` int(10) NULL DEFAULT NULL COMMENT '人数',
  `dept_ids` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '部门id数组',
  `dept_names` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '部门名称数组',
  `dept_ids_tree` json NULL COMMENT '部门id菜单树',
  `site_ids` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '实验中心id数组',
  `site_names` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '中心数组名称',
  `application_status` tinyint(3) NULL DEFAULT NULL COMMENT '申请状态',
  `group_id` bigint(20) NULL DEFAULT NULL COMMENT '组id',
  `upgrade_delete` tinyint(1) DEFAULT NULL COMMENT '申请删除标志',
  `created_by` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_by` bigint(20) NULL DEFAULT NULL COMMENT '更新人',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `status` int(11) NULL DEFAULT 1 COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_role_dept_id`(`parent_role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1534861365148852227 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = ' 人力申请表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for rm_manpower_distribution
-- ----------------------------
DROP TABLE IF EXISTS `rm_manpower_distribution`;
CREATE TABLE `rm_manpower_distribution`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `study_id` bigint(20) NOT NULL COMMENT '项目id',
  `version_id` bigint(20) NOT NULL COMMENT '版本id',
  `manpower_application_id` bigint(20) NOT NULL COMMENT '人力申请id',
  `parent_role_id` bigint(20) NOT NULL COMMENT '角色组id',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '用户id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `dept_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '部门名称',
  `dept_id` bigint(20) NULL DEFAULT NULL COMMENT '部门id',
  `is_distribute` tinyint(3) NULL DEFAULT 0 COMMENT '是否分配 0不分配 1分配',
  `distribution_status` tinyint(3) NULL DEFAULT 0 COMMENT '分配状态',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '描述',
  `upgrade_delete` tinyint(1) DEFAULT NULL COMMENT '申请删除标志',
  `created_by` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_by` bigint(20) NULL DEFAULT NULL COMMENT '更新人',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `status` tinyint(3) NULL DEFAULT 1 COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_study_version_id`(`study_id`, `version_id`, `parent_role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1534861366390366211 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = ' 人力分配表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for rm_manpower_log
-- ----------------------------
DROP TABLE IF EXISTS `rm_manpower_log`;
CREATE TABLE `rm_manpower_log`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `created_by` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_by` bigint(20) NULL DEFAULT NULL COMMENT '更新人',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `status` int(11) NULL DEFAULT 1 COMMENT '状态',
  `operator` bigint(20) NULL DEFAULT NULL COMMENT '操作人',
  `action` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作',
  `study_id` bigint(20) NULL DEFAULT NULL COMMENT '项目id',
  `version_id` bigint(20) NULL DEFAULT NULL COMMENT '版本id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1534861367086620674 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = ' 人力申请表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for rm_manpower_pool
-- ----------------------------
DROP TABLE IF EXISTS `rm_manpower_pool`;
CREATE TABLE `rm_manpower_pool` (
    `id` bigint(20) NOT NULL COMMENT '主键',
    `status` tinyint(4) DEFAULT '1' COMMENT '状态',
    `created_by` bigint(20) DEFAULT '-1' COMMENT '创建人',
    `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
    `updated_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `obj_id` bigint(20) NOT NULL COMMENT '对象id(用户/部门/标准角色id)',
    `obj_type` tinyint(1) DEFAULT NULL COMMENT '对象类型(1用户2部门3标准角色)',
    `lock_fte` decimal(4,2) DEFAULT NULL COMMENT '锁定职位fte',
    `lock_role_fte` decimal(4,2) DEFAULT NULL COMMENT '锁定角色fte',
    `used_fte` decimal(4,2) DEFAULT NULL COMMENT '已用职位fte',
    `used_role_fte` decimal(4,2) DEFAULT NULL COMMENT '已用角色fte',
    `remain_fte` decimal(10,2) DEFAULT NULL COMMENT '剩余职位fte',
    `remain_role_fte` decimal(10,2) DEFAULT NULL COMMENT '剩余角色fte',
    `distribution_info` text COLLATE utf8_bin COMMENT '人力分配信息',
    `month` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '月',
    PRIMARY KEY (`obj_id`,`month`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='人力资源池';

-- ----------------------------
-- Table structure for rm_manpower_study
-- ----------------------------
DROP TABLE IF EXISTS `rm_manpower_study`;
CREATE TABLE `rm_manpower_study` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
    `study_id` bigint(20) NOT NULL COMMENT '项目id',
    `study_no` varchar(255) DEFAULT NULL COMMENT '项目编号',
    `version_id` bigint(20) NOT NULL COMMENT '版本id',
    `manpower_application_id` bigint(20) NOT NULL COMMENT '人力申请id',
    `manpower_distribution_id` bigint(20) NOT NULL COMMENT '人力分配id',
    `manpower_receive_id` bigint(20) NOT NULL COMMENT '人力接收id',
    `parent_role_id` bigint(20) NOT NULL COMMENT '标准角色组id',
    `role_name` varchar(255) DEFAULT NULL COMMENT '标准角色组名称',
    `position_id` bigint(20) DEFAULT NULL COMMENT '职位id',
    `position_name` varchar(255) DEFAULT NULL COMMENT '职位名称',
    `use_fte` decimal(10,2) DEFAULT NULL COMMENT '使用职位fte',
    `use_position_fte` decimal(10,2) DEFAULT NULL COMMENT '使用角色fte',
    `obj_id` bigint(20) DEFAULT NULL COMMENT '资源池obj_id',
    `dept_id` bigint(20) DEFAULT NULL COMMENT '部门id',
    `dept_name` varchar(255) DEFAULT NULL COMMENT '部门名称',
    `month` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '月',
    `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
    `created_time` datetime DEFAULT NULL COMMENT '创建时间',
    `updated_by` bigint(20) NULL DEFAULT NULL COMMENT '更新人',
    `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
    `status` tinyint(3) DEFAULT '1' COMMENT '状态',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT=' 人力接收表';

-- ----------------------------
-- Table structure for rm_manpower_receive
-- ----------------------------
DROP TABLE IF EXISTS `rm_manpower_receive`;
CREATE TABLE `rm_manpower_receive`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `study_id` bigint(20) NOT NULL COMMENT '项目id',
  `version_id` bigint(20) NOT NULL COMMENT '版本id',
  `manpower_application_id` bigint(20) NOT NULL COMMENT '人力申请id',
  `manpower_distribution_id` bigint(20) NOT NULL COMMENT '人力分配id',
  `parent_role_id` bigint(20) NOT NULL COMMENT '角色组id',
  `receive_status` tinyint(3) NULL DEFAULT 0 COMMENT '接收状态',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '描述',
  `created_by` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_by` bigint(20) NULL DEFAULT NULL COMMENT '更新人',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `status` tinyint(3) NULL DEFAULT 1 COMMENT '状态',
  `is_receive` tinyint(3) NULL DEFAULT 0 COMMENT '是否接收 0 不接收 1接收',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1534812187379048451 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = ' 人力接收表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for rm_model
-- ----------------------------
DROP TABLE IF EXISTS `rm_model`;
CREATE TABLE `rm_model` (
`id` bigint(20) NOT NULL COMMENT '主键',
`status` tinyint(4) DEFAULT '1' COMMENT '状态',
`created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
`created_time` datetime DEFAULT NULL COMMENT '创建时间',
`updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
`updated_time` datetime DEFAULT NULL COMMENT '更新时间',
`remark` varchar(2048) COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
`name` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '任务名称',
`is_release` tinyint(4) DEFAULT NULL COMMENT '是否发布(1-未发布 2-已发布)',
`sort` int(10) DEFAULT NULL COMMENT '排序',
`domain` int(10) DEFAULT '1' COMMENT '合同设置类型1合同模板2合同类型',
`tax_rate` double(10,8) DEFAULT NULL COMMENT '税率',
`standard_type` tinyint(4) DEFAULT '0' COMMENT  '是否为标准项目',
`in_use` tinyint(4) DEFAULT '0' COMMENT  '1为正在使用 0为取消使用',
PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='合同模板/类型设置';

-- ----------------------------
-- Table structure for rm_model_manpower
-- ----------------------------
DROP TABLE IF EXISTS `rm_model_manpower`;
CREATE TABLE `rm_model_manpower`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态',
  `created_by` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_by` bigint(20) NULL DEFAULT NULL COMMENT '更新人',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `position_id` bigint(20) NULL DEFAULT NULL COMMENT '角色id',
  `std_role_id` bigint(20) NULL DEFAULT NULL COMMENT '角色组（标准角色）id',
  `fte_factor` decimal(4, 2) NULL DEFAULT NULL COMMENT '工时系数',
  `factor` decimal(4, 2) NULL DEFAULT NULL COMMENT '对照系数',
  `remark` varchar(2048) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1530117575618445315 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '人力设置-标准工时表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for rm_model_task
-- ----------------------------
DROP TABLE IF EXISTS `rm_model_task`;
CREATE TABLE `rm_model_task`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态',
  `created_by` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_by` bigint(20) NULL DEFAULT NULL COMMENT '更新人',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `type_id` bigint(20) NULL DEFAULT NULL COMMENT '任务类别id',
  `name` varchar(1024) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '任务名称',
  `dict_type_code` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `task_times` double(10, 2) NULL DEFAULT NULL COMMENT '合同次数',
  `need_remarks` tinyint(4) NULL DEFAULT NULL COMMENT '是否需要备注 1-勾选需要 2-未勾选不需要',
  `need_annex` tinyint(4) NULL DEFAULT NULL COMMENT '是否需要附件 1-勾选需要 2-未勾选不需要',
  `sort` int(10) NULL DEFAULT NULL COMMENT '排序',
  `code` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '编号',
  `code_type` tinyint(4) DEFAULT '1' COMMENT  '1可以编辑 0 不可编辑',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `type_id_index` (`type_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '合同管理实体表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for rm_model_task_category
-- ----------------------------
DROP TABLE IF EXISTS `rm_model_task_category`;
CREATE TABLE `rm_model_task_category`  (
 `id` bigint(50) NOT NULL COMMENT '任务类别ID',
 `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
 `updated_by` bigint(20) DEFAULT NULL COMMENT '修改人',
 `created_time` datetime DEFAULT NULL COMMENT '创建时间',
 `updated_time` datetime DEFAULT NULL COMMENT '修改时间',
 `status` tinyint(4) DEFAULT '1' COMMENT '状态',
 `name` varchar(1024) CHARACTER SET utf8 DEFAULT NULL COMMENT '任务类别名称',
 `model_id` bigint(20) DEFAULT NULL COMMENT '模板id',
 `sort` int(10) DEFAULT NULL,
 `discount_rate` double(20,7) DEFAULT NULL COMMENT '折扣率',
 `discount_amount` double(20,7) DEFAULT NULL COMMENT '折扣金额',
 `cost_attribution_id` bigint(20) DEFAULT NULL COMMENT '费用归属',
 `tax_rate` double(20,7) DEFAULT NULL COMMENT '税率',
    PRIMARY KEY (`id`) USING BTREE,
    KEY `model_id_index` (`model_id`) USING BTREE COMMENT '项目Id索引'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '项目任务模板 - 任务类别' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for rm_model_task_info
-- ----------------------------
DROP TABLE IF EXISTS `rm_model_task_info`;
CREATE TABLE `rm_model_task_info`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态',
  `created_by` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_by` bigint(20) NULL DEFAULT NULL COMMENT '更新人',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `task_id` bigint(20) NULL DEFAULT NULL COMMENT '任务id(rm_task.id)',
  `role_id` bigint(20) NULL DEFAULT NULL COMMENT '角色id',
  `working_hours` double(10, 2) NULL DEFAULT NULL COMMENT '合同工时',
  `role_price` double(20, 2) NULL DEFAULT NULL,
  `tax_rate` double(20, 7) NULL DEFAULT NULL COMMENT '税率',
    `discount_rate` double(20,7) DEFAULT NULL COMMENT '折扣率',
  `dict_type_code` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '合同任务角色类型单位(见码表rm_model.id)',
  `task_times` decimal(10,2) DEFAULT NULL COMMENT '单角色次数',
  `need_remarks` varchar(1024) COLLATE utf8_bin DEFAULT NULL COMMENT '备注内容',
  `dept_id` bigint(20) DEFAULT NULL COMMENT '部门id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `task_id_index` (`task_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '任务详情表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for rm_non_approval_record
-- ----------------------------
DROP TABLE IF EXISTS `rm_non_approval_record`;
CREATE TABLE `rm_non_approval_record`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `created_by` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_by` bigint(20) NULL DEFAULT NULL COMMENT '修改人',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `status` tinyint(4) NULL DEFAULT 1 COMMENT '状态',
  `non_task_id` bigint(20) NULL DEFAULT NULL COMMENT '非项目工时填报记录id',
  `approval_type` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '审批流操作结果类型(见码表approval_type)',
  `approval_user_id` bigint(20) NULL DEFAULT NULL COMMENT '审批人id',
  `opinion` varchar(1024) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '意见',
  `approval_times` tinyint(4) NULL DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '非项目工时-审批记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for rm_non_project_task
-- ----------------------------
DROP TABLE IF EXISTS `rm_non_project_task`;
CREATE TABLE `rm_non_project_task`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `created_by` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_by` bigint(20) NULL DEFAULT NULL COMMENT '修改人',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `status` tinyint(4) NULL DEFAULT 1 COMMENT '状态',
  `compay_task_id` bigint(11) NULL DEFAULT NULL COMMENT '公司非项目工时ID',
  `task_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务名称',
  `task_type` tinyint(4) NULL DEFAULT NULL COMMENT '任务类型: 1计划  2自定义',
  `approval_status` tinyint(4) NULL DEFAULT NULL COMMENT '任务状态:  0待审批 1已批准  2已退回',
  `actual_time` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '实际工时',
  `complete_time_start` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '完成开始时间',
  `complete_time_end` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '完成结束时间',
  `remarks` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '备注',
  `file_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '附件地址',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '填报人ID',
  `user_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '填报人姓名',
  `department_id` bigint(50) NULL DEFAULT NULL COMMENT '部门ID',
  `department_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '部门',
  `role_id` bigint(20) NULL DEFAULT NULL COMMENT '角色ID',
  `role_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '角色名',
  `email` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '邮箱',
  `study_id` bigint(20) NULL DEFAULT NULL COMMENT '项目id',
  `task_id` bigint(20) NULL DEFAULT NULL COMMENT '任务id',
  `approval_user_id` bigint(20) NULL DEFAULT NULL COMMENT '审批人id',
  `member_type` int(10) NULL DEFAULT NULL COMMENT '成员类型（1普通成员，2领导）',
  `mark` varchar(1024) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '非项目工时表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for rm_notice
-- ----------------------------
DROP TABLE IF EXISTS `rm_notice`;
CREATE TABLE `rm_notice`  (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `status` tinyint(4) NULL DEFAULT NULL COMMENT '是否已读',
  `created_by` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_by` bigint(20) NULL DEFAULT NULL COMMENT '更新人',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '用户Id',
  `content` varchar(2048) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '提醒内容',
  `setting_id` bigint(20) NULL DEFAULT NULL COMMENT '提醒设置的id',
  `setting_time` datetime(0) NULL DEFAULT NULL COMMENT '提醒时间',
  `study_id` bigint(20) NULL DEFAULT NULL COMMENT '项目Id 在实际进度提醒中需要',
  `role_id` bigint(20) NULL DEFAULT NULL COMMENT '角色Id',
  `remove_on` tinyint(4) NULL DEFAULT NULL COMMENT '是否清空',
  `en_content`  varchar(2048) COLLATE utf8_bin DEFAULT NULL COMMENT '提醒内容',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '通知代办的通知表  ' ROW_FORMAT = Dynamic;

CREATE TABLE `rm_approval_study`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态',
  `created_by` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_by` bigint(20) NULL DEFAULT NULL COMMENT '更新人',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
	`study_id` bigint(20) NULL DEFAULT NULL COMMENT '项目Id',
	`approval_id` bigint(20) NULL DEFAULT NULL COMMENT '审批流Id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '审批流项目' ROW_FORMAT = Dynamic;


-- ----------------------------
-- Table structure for rm_progress_confirm
-- ----------------------------
DROP TABLE IF EXISTS `rm_progress_confirm`;
CREATE TABLE `rm_progress_confirm`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态',
  `created_by` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_by` bigint(20) NULL DEFAULT NULL COMMENT '更新人',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `task_id` bigint(20) NULL DEFAULT NULL COMMENT '任务id',
  `actual_times` double(10, 2) NULL DEFAULT NULL COMMENT '实际次数',
  `period_date` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '实际月份',
  `description` varchar(1024) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '备注',
  `annex_id` bigint(20) NULL DEFAULT NULL COMMENT '附件id',
  `annex_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '附件名字',
  `co_on` tinyint(4) NULL DEFAULT NULL COMMENT '是否CO',
  `edited` tinyint(4) DEFAULT NULL COMMENT '是否编辑过（提交后清空）',
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色id',
  `task_info_id` bigint(20) DEFAULT NULL COMMENT '任务详情ID',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `task_id_index`(`task_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '实际进度表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for rm_progress_confirm_site_user
-- ----------------------------
DROP TABLE IF EXISTS `rm_progress_confirm_site_user`;
CREATE TABLE `rm_progress_confirm_site_user`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态',
  `created_by` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_by` bigint(20) NULL DEFAULT NULL COMMENT '更新人',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `site_id` bigint(20) NULL DEFAULT NULL COMMENT '中心Id',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '用户Id',
  `confirm_id` bigint(20) NULL DEFAULT NULL COMMENT '实际进度任务ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for rm_progress_confirm_url
-- ----------------------------
DROP TABLE IF EXISTS `rm_progress_confirm_url`;
CREATE TABLE `rm_progress_confirm_url`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态',
  `created_by` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_by` bigint(20) NULL DEFAULT NULL COMMENT '更新人',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `annex_id` bigint(20) NULL DEFAULT NULL,
  `confirm_id` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for rm_progress_estimate
-- ----------------------------
DROP TABLE IF EXISTS `rm_progress_estimate`;
CREATE TABLE `rm_progress_estimate`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态',
  `created_by` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_by` bigint(20) NULL DEFAULT NULL COMMENT '更新人',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `task_id` bigint(20) NULL DEFAULT NULL COMMENT '任务id',
  `period_start` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '周期开始',
  `period_end` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '周期结束',
  `description` varchar(1024) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '备注内容',
  `annex_id` bigint(20) NULL DEFAULT NULL COMMENT '附件Id',
  `annex_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '附件名字',
  `co_on` tinyint(4) NULL DEFAULT NULL COMMENT '是否Co',
  `verify` tinyint(4) NULL DEFAULT NULL COMMENT '是否需要跳过计划进度大于合同数量的验证 ',
  `edited` tinyint(4) DEFAULT NULL COMMENT '是否编辑过（提交后清空） ',
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色id',
  `task_info_id` bigint(20) DEFAULT NULL COMMENT '任务详情ID',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `task_id_index`(`task_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for rm_progress_estimate_info
-- ----------------------------
DROP TABLE IF EXISTS `rm_progress_estimate_info`;
CREATE TABLE `rm_progress_estimate_info`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态',
  `created_by` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_by` bigint(20) NULL DEFAULT NULL COMMENT '更新人',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `task_id` bigint(20) NULL DEFAULT NULL COMMENT '任务id(rm_task.id)',
  `sort` int(10) NULL DEFAULT NULL COMMENT '排序',
  `period_date` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '计划月份',
  `plan_times` double(10, 2) NULL DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `annex_id` bigint(20) NULL DEFAULT NULL,
  `annex_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `disable` tinyint(4) DEFAULT NULL COMMENT '是否禁用编辑 ',
  `start_up` tinyint(4) DEFAULT NULL COMMENT '是否启用 ',
  `rpe_id` bigint(20) DEFAULT NULL COMMENT '父类Id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for rm_project_task
-- ----------------------------
DROP TABLE IF EXISTS `rm_project_task`;
CREATE TABLE `rm_project_task`  (
  `id` bigint(50) NOT NULL COMMENT '主键',
  `created_by` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_by` bigint(20) NULL DEFAULT NULL COMMENT '修改人',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `status` tinyint(4) NULL DEFAULT 1 COMMENT '状态',
  `task_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务名称',
  `task_type` tinyint(4) NULL DEFAULT NULL COMMENT '任务类型: 1计划  2自定义',
  `task_category_id` bigint(20) NULL DEFAULT NULL COMMENT '任务类别ID',
  `task_category_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '任务类别名称',
  `approval_status` tinyint(4) NULL DEFAULT NULL COMMENT '任务状态:  0待审批 1已批准  2已退回',
  `actual_time` double(32, 2) NULL DEFAULT NULL COMMENT '实际工时',
  `complete_time_start` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '完成开始时间',
  `complete_time_end` varchar(255) CHARACTER SET sjis COLLATE sjis_japanese_ci NULL DEFAULT NULL COMMENT '完成结束时间',
  `remarks` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '备注',
  `file_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '附件地址',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '填报人ID',
  `user_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '填报人姓名',
  `department_id` bigint(50) NULL DEFAULT NULL COMMENT '部门ID',
  `department_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '部门',
  `role_id` bigint(50) NULL DEFAULT NULL COMMENT '角色ID',
  `role_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '角色名',
  `email` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '邮箱',
  `task_id` bigint(20) NULL DEFAULT NULL COMMENT '任务id',
  `task_info_id` bigint(20) NULL DEFAULT NULL,
  `study_id` bigint(20) NULL DEFAULT NULL,
  `site_id` bigint(20) NULL DEFAULT NULL,
  `member_type` int(10) NULL DEFAULT NULL COMMENT '成员类型（1普通成员，2领导）',
  `billable` tinyint(4) NULL DEFAULT NULL COMMENT 'billable 1-billable 2-unbillable',
  `mark` varchar(1024) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '备注',
  `need_count` tinyint(4) NULL DEFAULT NULL COMMENT '是否需要计数(1-需要 2-不需要)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = sjis COLLATE = sjis_japanese_ci COMMENT = '项目工时表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for rm_reminder
-- ----------------------------
DROP TABLE IF EXISTS `rm_reminder`;
CREATE TABLE `rm_reminder`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态',
  `created_by` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_by` bigint(20) NULL DEFAULT NULL COMMENT '更新人',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `content` varchar(2048) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '用户输入的提醒文字',
  `en_content` varchar(2048) COLLATE utf8_bin DEFAULT NULL COMMENT '用户输入的提醒文字',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '页面提醒' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for rm_reminder_role
-- ----------------------------
DROP TABLE IF EXISTS `rm_reminder_role`;
CREATE TABLE `rm_reminder_role`  (
  `id` bigint(20) NOT NULL COMMENT '提醒对象Id',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态',
  `role_id` bigint(20) NULL DEFAULT NULL COMMENT '角色Id',
  `reminder_settings_id` bigint(20) NULL DEFAULT NULL COMMENT '审批表ID',
  `created_by` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_by` bigint(20) NULL DEFAULT NULL COMMENT '更新人',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '提醒角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for rm_reminder_role_content
-- ----------------------------
DROP TABLE IF EXISTS `rm_reminder_role_content`;
CREATE TABLE `rm_reminder_role_content`  (
  `id` bigint(50) NOT NULL COMMENT '主键',
  `created_by` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_by` bigint(20) NULL DEFAULT NULL COMMENT '修改人',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `status` tinyint(4) NULL DEFAULT 1 COMMENT '状态',
  `role_id` bigint(20) NULL DEFAULT NULL COMMENT '提醒角色Id',
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '提醒的具体内容',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '提醒角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for rm_reminder_settings
-- ----------------------------
DROP TABLE IF EXISTS `rm_reminder_settings`;
CREATE TABLE `rm_reminder_settings`  (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态',
  `created_by` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_by` bigint(20) NULL DEFAULT NULL COMMENT '更新人',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `start_up` tinyint(4) NULL DEFAULT NULL COMMENT '启停状态',
  `type_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '类型名',
  `reminder_content` varchar(1024) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '备注内容',
  `reminder_template` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '提醒模板',
  `trigger_event` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '触发事件（写死）',
  `trigger_event_id` bigint(20) NULL DEFAULT NULL COMMENT '触发时间表Id',
  `notice_or_handling` tinyint(4) NULL DEFAULT NULL COMMENT '是通知还是代办',
  `edit_scheme` tinyint(4) NULL DEFAULT NULL COMMENT '哪一种编辑',
  `en_reminder_content` varchar(2048) COLLATE utf8_bin DEFAULT NULL COMMENT '用户输入的提醒文字',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '提醒设置主表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for rm_task
-- ----------------------------
DROP TABLE IF EXISTS `rm_task`;
CREATE TABLE `rm_task`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态',
  `created_by` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_by` bigint(20) NULL DEFAULT NULL COMMENT '更新人',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `task_category_id` bigint(20) NULL DEFAULT NULL COMMENT '任务类别id（t_task_category.id）',
  `task_name` varchar(1024)  CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '任务名称',
  `task_times` decimal(10, 2) NULL DEFAULT NULL COMMENT '合同次数',
  `last_version_task_id` bigint(20) NULL DEFAULT NULL COMMENT '上一版本对应的任务id',
  `group_id` bigint(20) NULL DEFAULT NULL COMMENT '组id(用以区分是同一个任务类别)',
  `dict_type_code` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '合同任务类型(见码表rm_model.id)',
  `sort` int(10) NULL DEFAULT NULL COMMENT '排序',
  `upload_id` bigint(20) NULL DEFAULT NULL COMMENT '上传文件地址的Id',
  `need_remarks` varchar(1024) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '备注内容',
  `need_annex` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '是否需要附件 1-勾选需要 2-未勾选不需要',
  `edited` tinyint(4) NULL DEFAULT NULL COMMENT '是否编辑过  提交后清空',
  `code` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '编号',
  `code_type` tinyint(4) DEFAULT '1' COMMENT  '1可以编辑 0 不可编辑',
  `relevance_type` tinyint(4) DEFAULT '0' COMMENT  '1 已关联过 0 未关联过',
  `relevance_task_id` bigint(20) DEFAULT NULL COMMENT '关联的哪一条任务  id',
  `relevance_way` int(10) DEFAULT NULL COMMENT '1自动关联 2手动关联 3未关联',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `task_category_id_index`(`task_category_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '合同管理实体表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for rm_task_category
-- ----------------------------
DROP TABLE IF EXISTS `rm_task_category`;
CREATE TABLE `rm_task_category`  (
  `id` bigint(50) NOT NULL COMMENT '任务类别ID',
  `created_by` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  `updated_by` bigint(20) NULL DEFAULT NULL COMMENT '修改人',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `status` tinyint(4) NULL DEFAULT 1 COMMENT '状态',
  `name` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务类别名称',
  `study_id` bigint(20) NULL DEFAULT NULL COMMENT '项目id',
  `period_start` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '周期开始',
  `period_end` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '周期结束',
  `version_id` bigint(20) NULL DEFAULT NULL COMMENT '版本id',
  `group_id` bigint(20) NULL DEFAULT NULL COMMENT '组id(用以区分是同一个任务类别)',
  `last_type_id` bigint(20) NULL DEFAULT NULL,
  `sort` int(10) NULL DEFAULT NULL,
  `cost_attribution_id` bigint(20) NULL DEFAULT NULL COMMENT '费用归属id',
  `discount_rate` double(20, 7) NULL DEFAULT NULL COMMENT '折扣率',
  `discount_amount` double(20, 7) NULL DEFAULT NULL COMMENT '折扣金额',
  `clicked`  tinyint(4) DEFAULT '0' COMMENT  '是否点击过',
  `tax_rate` double(20,7) DEFAULT NULL COMMENT '税率',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `version_id_index`(`version_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for rm_task_info
-- ----------------------------
DROP TABLE IF EXISTS `rm_task_info`;
CREATE TABLE `rm_task_info`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态',
  `created_by` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_by` bigint(20) NULL DEFAULT NULL COMMENT '更新人',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `task_id` bigint(20) NULL DEFAULT NULL COMMENT '任务id(rm_task.id)',
  `role_id` bigint(20) NULL DEFAULT NULL COMMENT '角色id',
  `working_hours` double(10, 4) NULL DEFAULT NULL COMMENT '合同工时',
  `role_price` double(10, 4) NULL DEFAULT NULL COMMENT '角色单价',
  `last_info_id` bigint(20) NULL DEFAULT NULL,
  `tax_rate` double(20, 7) NULL DEFAULT NULL COMMENT '税率',
  `discount_rate` double(20, 7) NULL DEFAULT NULL COMMENT '折扣率',
  `parent_task_info_id` bigint(20) DEFAULT NULL COMMENT '上一版本任务id',
  `task_times` decimal(10,2) DEFAULT NULL COMMENT '单角色次数',
  `dict_type_code` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '合同任务角色类型单位(见码表rm_model.id)',
  `need_remarks` varchar(1024) COLLATE utf8_bin DEFAULT NULL COMMENT '备注内容',
  `dept_id` bigint(20) DEFAULT NULL COMMENT '部门id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `task_id_index`(`task_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '任务详情表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for rm_task_user_delete
-- ----------------------------
DROP TABLE IF EXISTS `rm_task_user_delete`;
CREATE TABLE `rm_task_user_delete`  (
  `id` bigint(50) NOT NULL COMMENT '主键',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态',
  `created_by` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_by` bigint(20) NULL DEFAULT NULL COMMENT '修改人',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `task_id` bigint(20) NULL DEFAULT NULL COMMENT '任务Id',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '用户Id',
  `study_id` bigint(20) NULL DEFAULT NULL COMMENT '项目Id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci COMMENT = '当周不展示该人员的任务中间表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for rm_trigger_event
-- ----------------------------
DROP TABLE IF EXISTS `rm_trigger_event`;
CREATE TABLE `rm_trigger_event`  (
  `id` bigint(20) NOT NULL COMMENT 'Trigger event_id',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态',
  `created_by` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_by` bigint(20) NULL DEFAULT NULL COMMENT '更新人',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `reminder_time_start` int(10) NULL DEFAULT NULL COMMENT '提醒时间开始',
  `reminder_time_end` int(10) NULL DEFAULT NULL COMMENT '提醒时间结束',
  `reminder_frequency` int(10) NULL DEFAULT NULL COMMENT '提醒频次',
  `reminder_date_minute` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '频次中的提醒时间_分钟',
  `reminder_date_hour` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '频次中的提醒时间_小时',
  `reminder_text` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '提醒的具体内容',
  `job_id` char(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '定时任务Id',
  `time_refresh` datetime(0) NULL DEFAULT NULL COMMENT '刷新的时间',
  `refresh_on` tinyint(4) NULL DEFAULT NULL COMMENT '是否已经刷新了',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '触发事件的设置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for rm_unlocked_actual
-- ----------------------------
DROP TABLE IF EXISTS `rm_unlocked_actual`;
CREATE TABLE `rm_unlocked_actual`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态',
  `created_by` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_by` bigint(20) NULL DEFAULT NULL COMMENT '更新人',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `study_id` bigint(20) NULL DEFAULT NULL COMMENT '解锁项目',
  `version_id` bigint(20) NULL DEFAULT NULL COMMENT '项目版本Id',
  `unlocked_time` varchar(225) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '解锁的月份',
  `remark` varchar(512) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '备注',
  `type` tinyint(4) NULL DEFAULT NULL COMMENT '状态  1-已解锁  2-手动锁定 3-自动锁定',
  `unlock_day` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '解锁操作时间的时间',
  `operate_time` datetime(0) NULL DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for rm_unlocked_plan
-- ----------------------------
DROP TABLE IF EXISTS `rm_unlocked_plan`;
CREATE TABLE `rm_unlocked_plan`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态',
  `created_by` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_by` bigint(20) NULL DEFAULT NULL COMMENT '更新人',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `study_id` bigint(20) NULL DEFAULT NULL COMMENT '解锁项目',
  `version_id` bigint(20) NULL DEFAULT NULL COMMENT '项目版本Id',
  `unlocked_time_open` varchar(225) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '解锁的月份开始',
  `unlocked_time_end` varchar(225) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '解锁月份末尾',
  `remark` varchar(512) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '备注',
  `type` tinyint(4) NULL DEFAULT NULL COMMENT '状态  1-已解锁  2-手动锁定 3-自动锁定',
  `unlock_day` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '解锁操作时间的时间',
  `operate_time` datetime(0) NULL DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for rm_unlocked_working_hours
-- ----------------------------
DROP TABLE IF EXISTS `rm_unlocked_working_hours`;
CREATE TABLE `rm_unlocked_working_hours`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态',
  `created_by` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_by` bigint(20) NULL DEFAULT NULL COMMENT '更新人',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '解锁人',
  `unlocked_time` varchar(225) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '解锁的月份',
  `remark` varchar(512) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '备注',
  `type` tinyint(4) NULL DEFAULT NULL COMMENT '状态  1-已解锁  2-手动锁定 3-自动锁定',
  `unlock_day` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '解锁天的时间',
  `operate_time` datetime(0) NULL DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for rm_upload
-- ----------------------------
DROP TABLE IF EXISTS `rm_upload`;
CREATE TABLE `rm_upload`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '文件名称',
  `name_alias` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '文件别名',
  `file_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '类型见 plt_dict',
  `source_id` bigint(20) NULL DEFAULT NULL COMMENT '来源所属层级主键',
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '上传路径',
  `old_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '文件名称',
  `status` tinyint(4) NULL DEFAULT 1 COMMENT '状态',
  `created_by` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_by` bigint(20) NULL DEFAULT NULL COMMENT '修改人',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '上传文件/图片/资料表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for rm_version
-- ----------------------------
DROP TABLE IF EXISTS `rm_version`;
CREATE TABLE `rm_version`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态',
  `created_by` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_by` bigint(20) NULL DEFAULT NULL COMMENT '更新人',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `study_id` bigint(20) NULL DEFAULT NULL COMMENT '项目id',
  `version` int(10) NULL DEFAULT NULL COMMENT '版本',
  `is_release` tinyint(4) NULL DEFAULT NULL COMMENT '发布(1-未发布(展示发布按钮) 2-已发布(不展示发布按钮))',
  `is_upgrade` tinyint(4) NULL DEFAULT NULL COMMENT '升级(1-未升级(展示版本升级按钮) 2-已升级(不展示版本升级按钮))',
  `estimate_active` tinyint(4) NULL DEFAULT NULL COMMENT '合同进度预估审批状态(1-待提交 2-已提交、待审批 3-已批准)',
  `confirm_active` tinyint(4) NULL DEFAULT NULL COMMENT '合同进度确认审批状态(1-待提交 2-已提交、待审批 3-已批准)',
  `approval_type` tinyint(4) NULL DEFAULT NULL COMMENT '见码表approval_type',
  `contract_date` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '合同签署日期',
  `valid_period_start` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '有效期开始',
  `valid_period_end` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '有效期结束',
  `plan_date_start` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '计划开始日期',
  `plan_date_end` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '计划结束日期',
  `signing_event` tinyint(4) NULL DEFAULT NULL COMMENT '是否可以选择签署时间',
  `plan_date_unlock_start` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '计划解锁开始日期',
  `plan_date_unlock_end` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '计划解锁结束日期',
  `plan_edit` tinyint(4) NULL DEFAULT NULL COMMENT '计划进度是否可以编辑',
  `approval_edit` tinyint(4) NULL DEFAULT NULL COMMENT '是否为审批后编辑',
  `estimate_approval_type` tinyint(4) NULL DEFAULT NULL COMMENT '该版本的计划进度是否通过过审批',
  `tax_rate` double(20, 7) NULL DEFAULT NULL COMMENT '税率',
  `discount_rate` double(20, 7) NULL DEFAULT NULL COMMENT '折扣率',
  `discount_amount` double(20, 7) NULL DEFAULT NULL COMMENT '折扣金额',
  `currency_id` bigint(20) NULL DEFAULT NULL COMMENT '币种id',
  `contract_period` int(10) NULL DEFAULT NULL COMMENT '合同周期',
  `manpower` json DEFAULT NULL COMMENT '合同人力',
  `exchange_rate` DOUBLE ( 20, 7 ) DEFAULT NULL COMMENT '汇率',
  `contract_submit_time`  datetime DEFAULT NULL COMMENT '合同更新时间',
  `plan_submit_time`  datetime DEFAULT NULL COMMENT '计划进度更新时间',
  `actual_submit_time`  datetime DEFAULT NULL COMMENT '实际进度更新时间',
  `manpower_submit_time`  datetime DEFAULT NULL COMMENT '人力更新时间',
  `relevance_type` tinyint(4) DEFAULT '0' COMMENT  '1进行过关联  0 未进行过关联',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '版本' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for rm_version_date
-- ----------------------------
DROP TABLE IF EXISTS `rm_version_date`;
CREATE TABLE `rm_version_date`  (
  `id` bigint(50) NOT NULL COMMENT '主键',
  `created_by` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_by` bigint(20) NULL DEFAULT NULL COMMENT '修改人',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `status` tinyint(4) NULL DEFAULT 1 COMMENT '状态',
  `version_id` bigint(20) NULL DEFAULT NULL COMMENT '版本id',
  `version_date` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '日期',
  `exchange_rate` DOUBLE ( 20, 7 ) DEFAULT NULL COMMENT '实际进度汇率',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for rm_version_roles
-- ----------------------------
DROP TABLE IF EXISTS `rm_version_roles`;
CREATE TABLE `rm_version_roles`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `study_id` bigint(20) NULL DEFAULT NULL COMMENT '项目id',
  `version_id` bigint(20) NULL DEFAULT NULL COMMENT '版本id',
  `role_id` bigint(20) NULL DEFAULT NULL COMMENT '角色id',
  `role_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '角色名称',
  `num` int(10) NULL DEFAULT NULL COMMENT '人数',
  `created_by` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_by` bigint(20) NULL DEFAULT NULL COMMENT '更新人',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `status` tinyint(3) NULL DEFAULT 1 COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_study_version_id`(`study_id`, `version_id`, `status`) USING BTREE,
  INDEX `index_version_id`(`version_id`, `status`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1534844092551995395 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '合同版本 角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for rm_working_hours
-- ----------------------------
DROP TABLE IF EXISTS `rm_working_hours`;
CREATE TABLE `rm_working_hours`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态',
  `created_by` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_by` bigint(20) NULL DEFAULT NULL COMMENT '更新人',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `resource_type` tinyint(4) NULL DEFAULT NULL COMMENT '工时类型(1-项目工时 2-非项目工时)',
  `task_category` bigint(20) NULL DEFAULT NULL COMMENT '工时类别(rm_task_category.id)',
  `task_type` tinyint(4) NULL DEFAULT NULL COMMENT '任务类型(1-计划任务 2-自定义任务)',
  `task_id` bigint(20) NULL DEFAULT NULL COMMENT '任务id',
  `task_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '任务名称',
  `study_id` bigint(20) NULL DEFAULT NULL COMMENT '项目id',
  `dept_id` bigint(20) NULL DEFAULT NULL COMMENT '部门id',
  `role_id` bigint(20) NULL DEFAULT NULL COMMENT '角色id',
  `site_id` bigint(20) NULL DEFAULT NULL COMMENT '中心id',
  `working_hours` double(10, 2) NULL DEFAULT NULL COMMENT '工时',
  `remark` varchar(1024) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '备注',
  `task_approval_status` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '审批状态(task_approval_status)',
  `date_start` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '开始时间',
  `date_end` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '结束时间',
  `times_id` bigint(20) NULL DEFAULT NULL COMMENT '保存轮次id',
  `times_time` datetime(0) NULL DEFAULT NULL COMMENT '轮次时序',
  `member_type` tinyint(4) NULL DEFAULT NULL COMMENT '成员类型（1普通成员，2领导）',
  `need_count` tinyint(4) NULL DEFAULT NULL COMMENT '是否需要计数(1-需要 2-不需要)',
  `submit_time` datetime(0) NULL DEFAULT NULL COMMENT '提交时间',
  `approval_user_id` bigint(20) NULL DEFAULT NULL COMMENT '审批人id',
  `approval_role_id` bigint(20) NULL DEFAULT NULL COMMENT '审批人角色id',
  `version_id` bigint(20) NULL DEFAULT NULL COMMENT '版本id',
  `approval_id` bigint(20) NULL DEFAULT NULL COMMENT '审批流id',
  `approval_node_id` bigint(20) NULL DEFAULT NULL COMMENT '审批流节点id',
  `working_hours_created_by` bigint(20) NULL DEFAULT NULL COMMENT '工时创建人 ',
  `working_hours_created_role_id` bigint(20) DEFAULT NULL COMMENT '完成人角色',
  `associated_hours` double(10, 2) NULL DEFAULT NULL COMMENT '被关联工时数量（只存在自定义工时批准状态）',
  `is_edit` tinyint(4) NULL DEFAULT NULL COMMENT '是否可以编辑',
  `daily_fill_in` tinyint(4) DEFAULT '0' COMMENT' 1为每日填报  0为周填报',
  `template_filling` tinyint(4) DEFAULT '0' COMMENT' 1 模板类型  0为合同类型',
  `business_opportunity_code` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '商机编号',
  `association_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否已关联：1=关联 0=未关联',
  `association_working_hours_id` BIGINT ( 4 ) DEFAULT NULL COMMENT '关联的工时ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '工时记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for rm_working_hours_fill_in
-- ----------------------------
DROP TABLE IF EXISTS `rm_working_hours_fill_in`;
CREATE TABLE `rm_working_hours_fill_in`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态',
  `created_by` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_by` bigint(20) NULL DEFAULT NULL COMMENT '更新人',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `study_id` bigint(20) NULL DEFAULT NULL COMMENT '项目id',
  `version_id` bigint(20) NULL DEFAULT NULL COMMENT '版本Id',
  `task_category` bigint(20) NULL DEFAULT NULL COMMENT '工时类别(rm_task_category.id)',
  `task_id` bigint(20) NULL DEFAULT NULL COMMENT '任务id',
  `task_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '任务名称（在没有保存任务ID是保存此）',
  `role_id` bigint(20) NULL DEFAULT NULL COMMENT '角色',
  `dept_id` bigint(20) NULL DEFAULT NULL COMMENT '部门Id',
  `site_id` bigint(20) NULL DEFAULT NULL COMMENT '中心id',
  `date_start` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '开始时间',
  `date_end` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '结束时间',
  `code_task_type` int(10) NULL DEFAULT NULL COMMENT '编号 类型',
  `code_task` int(10) NULL DEFAULT NULL COMMENT '编号 任务',
  `working_hours` double(20, 2) NULL DEFAULT NULL COMMENT '工时',
  `working_hours_created_by` bigint(20) NULL DEFAULT NULL COMMENT '工时完成人',
  `working_hours_created_role_id` bigint(20) DEFAULT NULL COMMENT '完成人角色',
  `working_hours_id` bigint(20) NULL DEFAULT NULL COMMENT '如果有工时 那么该条工时的记录ID是多少',
  `approval_user_id` bigint(20) NULL DEFAULT NULL COMMENT '审批人Id',
  `approval_role_id` bigint(20) NULL DEFAULT NULL COMMENT '审批人角色',
  `submit_type` tinyint(4) NULL DEFAULT NULL COMMENT '提交状态  1为提交 2 为未提交',
  `checked` tinyint(4) NULL DEFAULT NULL COMMENT '是否可以保存  前端需要',
  `is_edit` tinyint(4) NULL DEFAULT NULL COMMENT '前端需要字段',
  `submitted` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否提交过  false为未提交  true 为进入过审批流   未提交状态的可以直接删除',
  `approval_id` bigint(20) DEFAULT NULL COMMENT '审批流id',
  `approval_node_id` bigint(20) DEFAULT NULL COMMENT '审批流节点id',
  `need_count` tinyint(4) NULL DEFAULT NULL COMMENT '是否需要计数(1-需要 2-不需要)',
  `remark` varchar(1024) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  `daily_fill_in` tinyint(4) DEFAULT '0' COMMENT' 1为每日填报  0为周填报',
  `template_filling` tinyint(4) DEFAULT '0' COMMENT' 1 模板类型  0为合同类型',
  `business_opportunity_code` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '商机编号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `study_id_index`(`study_id`) USING BTREE COMMENT '项目Id索引',
  INDEX `version_id_index`(`version_id`) USING BTREE COMMENT '版本Id索引',
  INDEX `date_start_index`(`date_start`) USING BTREE COMMENT '开始时间索引',
  INDEX `date_end_index`(`date_end`) USING BTREE COMMENT '结束时间索引'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '填报页面的数据备份' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for rm_position
-- ----------------------------
DROP TABLE IF EXISTS `rm_position`;
CREATE TABLE `rm_position` (
    `id` bigint(20) NOT NULL COMMENT '主键',
    `name` varchar(512) NOT NULL COMMENT '名称',
    `name_short` varchar(512) DEFAULT NULL COMMENT '简称',
    `alias` varchar(512) DEFAULT NULL COMMENT '别名',
    `description` varchar(1024) DEFAULT NULL COMMENT '描述',
    `sys_id` bigint(20) NOT NULL COMMENT '所属系统id（pub_resource）',
    `status` tinyint(4) NOT NULL COMMENT '状态（1/是 2/否）',
    `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
    `created_time` datetime NOT NULL COMMENT '创建时间',
    `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
    `updated_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`,`name`) USING BTREE,
    KEY `pub_role_sys_id_IDX` (`sys_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='职位表';


DROP TABLE IF EXISTS `rm_top_study`;
CREATE TABLE `rm_top_study`  (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `status` tinyint(4) NULL DEFAULT NULL COMMENT '做逻辑删除分辨字段',
  `created_by` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_by` bigint(20) NULL DEFAULT NULL COMMENT '更新人',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `study_id` bigint(20) NULL DEFAULT NULL COMMENT '项目Id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

DROP TABLE IF EXISTS `rm_study_info`;
CREATE TABLE `rm_study_info`  (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `status` tinyint(4) NULL DEFAULT NULL COMMENT '做逻辑删除分辨字段',
  `created_by` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_by` bigint(20) NULL DEFAULT NULL COMMENT '更新人',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `study_id` bigint(20) NULL DEFAULT NULL COMMENT '项目Id',
	`org_id` bigint(20) NULL DEFAULT NULL COMMENT '实验中心Id（组织）',
	`test_methods_code` bigint(20) NULL DEFAULT NULL COMMENT '试验方法',
	`test_type_code` bigint(20) NULL DEFAULT NULL COMMENT '试验类型',
	`contract_type_code` bigint(20) NULL DEFAULT NULL COMMENT '合同类型',
	`client_type_code` bigint(20) NULL DEFAULT NULL COMMENT '客户类型',
	`business_type_code` bigint(20) NULL DEFAULT NULL COMMENT '业务类型',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;


DROP TABLE IF EXISTS `rm_dept_estimated_investment`;
CREATE TABLE `rm_dept_estimated_investment`  (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `status` int(10) NULL DEFAULT NULL,
  `type` int(10) NULL DEFAULT NULL COMMENT '类型 根据枚举',
  `january` double(20, 2) NULL DEFAULT NULL COMMENT '一月',
  `february` double(20, 2) NULL DEFAULT NULL,
  `march` double(20, 2) NULL DEFAULT NULL,
  `april` double(20, 2) NULL DEFAULT NULL,
  `may` double(20, 2) NULL DEFAULT NULL,
  `june` double(20, 2) NULL DEFAULT NULL,
  `july` double(20, 2) NULL DEFAULT NULL,
  `august` double(20, 2) NULL DEFAULT NULL,
  `september` double(20, 2) NULL DEFAULT NULL,
  `october` double(20, 2) NULL DEFAULT NULL,
  `november` double(20, 2) NULL DEFAULT NULL,
  `december` double(20, 2) NULL DEFAULT NULL COMMENT '十二月',
  `event_id` bigint(20) NULL DEFAULT NULL COMMENT '主体id',
  `date_year` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '设定时间',
  `indicator` int(10) DEFAULT NULL COMMENT '指标',
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色Id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

DROP TABLE IF EXISTS `rm_daily_fill`;
CREATE TABLE `rm_daily_fill`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态',
  `created_by` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_by` bigint(20) NULL DEFAULT NULL COMMENT '更新人',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
	`daily_fill_in` tinyint(4) null DEFAULT NULL COMMENT '1为每日填报  0为周填报',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '填报设置' ROW_FORMAT = Dynamic;


DROP TABLE IF EXISTS `rm_role_position`;
-- ----------------------------
-- View structure for count_non_project_task
-- ----------------------------
DROP VIEW IF EXISTS `count_non_project_task`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `count_non_project_task` AS select `rm_non_project_task`.`task_id` AS `task_id`,count(`rm_non_project_task`.`id`) AS `count`,date_format(`rm_non_project_task`.`complete_time_start`,'%Y-%m-%d') AS `date`,`rm_non_project_task`.`role_id` AS `role_id`,`rm_non_project_task`.`department_id` AS `dept_id`,`rm_non_project_task`.`task_type` AS `task_type`,`rm_non_project_task`.`user_id` AS `user_id`,`rm_non_project_task`.`task_name` AS `task_name`,sum(`rm_non_project_task`.`actual_time`) AS `sum` from `rm_non_project_task` where ((`rm_non_project_task`.`status` = 1) and (`rm_non_project_task`.`approval_status` = 2)) group by `date`,`rm_non_project_task`.`role_id`,`rm_non_project_task`.`task_id`,`rm_non_project_task`.`user_id`,`rm_non_project_task`.`task_name`,`rm_non_project_task`.`task_type`,`rm_non_project_task`.`department_id`;

-- ----------------------------
-- View structure for count_project_task
-- ----------------------------
DROP VIEW IF EXISTS `count_project_task`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `count_project_task` AS select `rm_project_task`.`task_info_id` AS `info_id`,`rm_project_task`.`task_id` AS `task_id`,`rm_project_task`.`task_category_id` AS `type_id`,count(`rm_project_task`.`id`) AS `count`,date_format(`rm_project_task`.`complete_time_start`,'%Y-%m-%d') AS `date`,`rm_project_task`.`role_id` AS `role_id`,`rm_project_task`.`study_id` AS `study_id`,`rm_project_task`.`user_id` AS `user_id`,`rm_project_task`.`task_name` AS `task_name`,`rm_project_task`.`department_id` AS `dept_id`,`rm_project_task`.`task_type` AS `task_type`,sum(`rm_project_task`.`actual_time`) AS `sum` from `rm_project_task` where ((`rm_project_task`.`status` = 1) and (`rm_project_task`.`approval_status` = 2)) group by `rm_project_task`.`role_id`,`rm_project_task`.`task_info_id`,`rm_project_task`.`task_id`,`rm_project_task`.`study_id`,`rm_project_task`.`user_id`,`rm_project_task`.`department_id`,`rm_project_task`.`task_name`,`rm_project_task`.`task_category_id`,`date`,`rm_project_task`.`task_type`;

-- ----------------------------
-- View structure for count_study_task
-- ----------------------------
DROP VIEW IF EXISTS `count_study_task`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `count_study_task` AS select `ttc`.`id` AS `type_id`,`ttc`.`name` AS `type_name`,`tt`.`id` AS `task_id`,(case when (`tpt`.`task_type` = 1) then `tt`.`task_name` else `tpt`.`task_name` end) AS `task_name`,`tti`.`role_id` AS `task_info_role_id`,`tpt`.`task_type` AS `task_type`,`tpt`.`task_id` AS `project_task_id`,`pu`.`name` AS `role_name`,`tpt`.`role_id` AS `project_task_role_id`,`tpt`.`task_info_id` AS `project_task_info_id`,`ttc`.`version_id` AS `version_id`,`tti`.`working_hours` AS `working_hours` from ((((`rm_task_category` `ttc` left join `rm_task` `tt` on((`tt`.`task_category_id` = `ttc`.`id`))) left join `rm_task_info` `tti` on((`tt`.`id` = `tti`.`task_id`))) left join `rm_project_task` `tpt` on((`tpt`.`task_category_id` = `ttc`.`id`))) left join `mds_role` `pu` on((`tti`.`role_id` = `pu`.`id`))) where (`tpt`.`approval_status` = 2) group by `ttc`.`version_id`,`ttc`.`id`,`ttc`.`name`,`tt`.`id`,`tt`.`task_name`,`tti`.`role_id`,`tpt`.`task_name`,`tpt`.`task_type`,`tpt`.`task_id`,`pu`.`name`,`tpt`.`role_id`,`tti`.`working_hours`,`tpt`.`task_info_id`;

SET FOREIGN_KEY_CHECKS = 1;

-- ----------------------------
-- Records of rm_cost_setting
-- ----------------------------


-- ----------------------------
-- Table structure for rm_return_record_working_hours
-- ----------------------------
DROP TABLE IF EXISTS `rm_return_record_working_hours`;
CREATE TABLE `rm_return_record_working_hours`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `status` tinyint(4) NULL DEFAULT 1 COMMENT '状态',
  `created_by` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_by` bigint(20) NULL DEFAULT NULL COMMENT '更新人',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `resource_type` tinyint(4) NULL DEFAULT NULL COMMENT '工时类型(1-项目工时 2-非项目工时)',
  `task_category` bigint(20) NULL DEFAULT NULL COMMENT '工时类别(rm_task_category.id)',
  `task_type` tinyint(4) NULL DEFAULT NULL COMMENT '任务类型(1-计划任务 2-自定义任务)',
  `task_id` bigint(20) NULL DEFAULT NULL COMMENT '任务id',
  `task_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '任务名称',
  `study_id` bigint(20) NULL DEFAULT NULL COMMENT '项目id',
  `dept_id` bigint(20) NULL DEFAULT NULL COMMENT '部门id',
  `role_id` bigint(20) NULL DEFAULT NULL COMMENT '角色id',
  `site_id` bigint(20) NULL DEFAULT NULL COMMENT '中心id',
  `working_hours` double(10, 2) NULL DEFAULT NULL COMMENT '工时',
  `remark` varchar(1024) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '备注',
  `task_approval_status` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '审批状态(task_approval_status)',
  `date_start` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '开始时间',
  `date_end` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '结束时间',
  `times_id` bigint(20) NULL DEFAULT NULL COMMENT '保存轮次id',
  `times_time` datetime(0) NULL DEFAULT NULL COMMENT '轮次时序',
  `member_type` tinyint(4) NULL DEFAULT NULL COMMENT '成员类型（1普通成员，2领导）',
  `need_count` tinyint(4) NULL DEFAULT NULL COMMENT '是否需要计数(1-需要 2-不需要)',
  `submit_time` datetime(0) NULL DEFAULT NULL COMMENT '提交时间',
  `approval_user_id` bigint(20) NULL DEFAULT NULL COMMENT '审批人id',
  `approval_role_id` bigint(20) NULL DEFAULT NULL COMMENT '审批人角色id',
  `version_id` bigint(20) NULL DEFAULT NULL COMMENT '版本id',
  `approval_id` bigint(20) NULL DEFAULT NULL COMMENT '审批流id',
  `approval_node_id` bigint(20) NULL DEFAULT NULL COMMENT '审批流节点id',
  `working_hours_created_by` bigint(20) NULL DEFAULT NULL COMMENT '工时创建人 ',
  `associated_hours` double(10, 2) NULL DEFAULT NULL COMMENT '被关联工时数量（只存在自定义工时批准状态）',
  `is_edit` tinyint(4) NULL DEFAULT NULL COMMENT '是否可以编辑',
  `working_hours_created_role_id` bigint(20) NULL DEFAULT NULL COMMENT '完成人角色',
  `working_hours_id` bigint(20) NULL DEFAULT NULL COMMENT '该条工时记录Id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index`(`working_hours_id`) USING BTREE COMMENT '工时ID索引'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

CREATE TABLE `rm_dept_working_hours_config` (
  `id` bigint(20) NOT NULL COMMENT '主键id',
  `dept_id` bigint(20) NOT NULL COMMENT '部门id',
  `status` tinyint(3) NOT NULL COMMENT '状态（1=开启，2=停用）',
  `type` tinyint(3) NOT NULL DEFAULT '1' COMMENT '工时类型（1=标准工时，2=非标准工时）',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建者',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '修改者',
  `created_time` datetime NOT NULL COMMENT '创建时间',
  `updated_time` datetime NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `uk_dept_id` (`dept_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='部门工时显示配置表';


CREATE TABLE `rm_non_project_task_dept` (
  `id` bigint(20) NOT NULL COMMENT '主键id',
  `dept_id` bigint(20) NOT NULL COMMENT '部门id',
  `task_id` bigint(20) NOT NULL COMMENT '任务id',
  `created_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='非项目任务部门关联表';
-- ----------------------------
-- Table structure for rm_audit
-- ----------------------------
DROP TABLE IF EXISTS `rm_audit`;
CREATE TABLE `rm_audit`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `status` tinyint(4) NULL DEFAULT 1 COMMENT '状态',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '用户ID',
  `type` int(10) NULL DEFAULT NULL COMMENT '稽查的操作',
  `old_obj` json NULL COMMENT '老值',
  `new_obj` json NULL COMMENT '新值',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

DROP TABLE IF EXISTS `rm_download_center`;
CREATE TABLE `rm_download_center` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `file_name` varchar(255) DEFAULT NULL COMMENT '名称',
  `url` varchar(255) DEFAULT NULL COMMENT '文件地址',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色id',
  `complete_flag` tinyint(4) DEFAULT '1' COMMENT '1 = 下载中, 2 = 下载完成 ,-1 = 异常',
  `complete_time` datetime DEFAULT NULL COMMENT '后台下载完成时间',
  `study_id` bigint(20) DEFAULT NULL COMMENT '项目id（对应项目）',
  `download_type` int(10) DEFAULT null COMMENT '下载类型 看枚举',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `created_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '修改人',
  `updated_time` datetime DEFAULT NULL COMMENT '修改时间',
  `del_flag` tinyint(4) DEFAULT '1' COMMENT '1 = 未删除, 2 = 已删除',
  `file_size` bigint(20) DEFAULT NULL COMMENT '文件大小',
  `type` int(10) DEFAULT NULL COMMENT '比例',
  `dept_id` bigint(20) DEFAULT NULL COMMENT '部门',
  `downloaded_type` tinyint(4) DEFAULT '1' COMMENT '是否下载过',
  `dept_ids` json DEFAULT NULL COMMENT '部门改为复选后以json格式存储deptids',
  `year_screen` VARCHAR(10) DEFAULT null COMMENT '下载内容筛选年',
  `type_screen` int(10) DEFAULT null COMMENT '下载内容筛选时间段',
  `study_ids` JSON DEFAULT NULL COMMENT '项目改为复选后以json格式存储studyIds',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='rm下载中心';

DROP TABLE IF EXISTS `rm_staff_dept`;
CREATE TABLE `rm_staff_dept`  (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `status` int(10) NULL DEFAULT NULL COMMENT '状态',
  `position_id` bigint(20) NULL DEFAULT NULL COMMENT '职位ID',
  `staff_structure` varchar(255) DEFAULT NULL COMMENT '结构名称',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `dept_id` bigint(20) DEFAULT NULL COMMENT '部门ID',
  `proportion` int(10) DEFAULT NULL COMMENT '比例',
  dept_group  BIGINT(20) DEFAULT NULL COMMENT '部门组ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;


CREATE TABLE `rm_staff_structure_dept`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态',
  `created_by` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_by` bigint(20) NULL DEFAULT NULL COMMENT '更新人',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `dept_group` bigint(20) NULL DEFAULT NULL COMMENT '部门组Id',
  `structure_group` bigint(20) NULL DEFAULT NULL COMMENT '人力结构组Id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='人员结构与部门中间表';

CREATE TABLE `rm_staff_structure`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态',
  `created_by` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_by` bigint(20) NULL DEFAULT NULL COMMENT '更新人',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `proportion` int(10) NULL DEFAULT NULL COMMENT '人员结构比例比例',
  `structure_group` bigint(20) NULL DEFAULT NULL COMMENT '人力结构组Id',
  `staff_structure` varchar(255) DEFAULT NULL COMMENT '结构名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='人员结构表';

CREATE TABLE `rm_staff_structure_info`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态',
  `created_by` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_by` bigint(20) NULL DEFAULT NULL COMMENT '更新人',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `position_id` bigint(20) NULL DEFAULT NULL COMMENT '职位ID',
  `structure_id` bigint(20) NULL DEFAULT NULL COMMENT '人力结构组Id',
  `structure_group` bigint(20) NULL DEFAULT NULL COMMENT '人力结构组ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='人员结构表';

SET FOREIGN_KEY_CHECKS = 1;


CREATE TABLE `rm_cfg_custom_fields` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `created_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  `updated_time` datetime DEFAULT NULL COMMENT '更新时间',
  `field_name` varchar(255) DEFAULT NULL COMMENT '字段名称',
  `field_type_code` varchar(20) DEFAULT NULL COMMENT '字段类型code',
  `field_size` bigint(20) DEFAULT NULL COMMENT '字段大小',
  `sort` int(10) DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='工时-公司设置-自定义表单设置-自定义字段表主表';

CREATE TABLE `rm_cfg_custom_fields_option` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `created_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  `updated_time` datetime DEFAULT NULL COMMENT '更新时间',
  `custom_fields_id` bigint(20) DEFAULT NULL COMMENT '字段id(rm_cfg_custom_fields.id)',
  `option_name` varchar(255) DEFAULT NULL COMMENT '选项名称(内容)',
  `sort` int(10) DEFAULT NULL COMMENT '选项排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='工时-公司设置-自定义表单设置-自定义字段选项表';

CREATE TABLE `rm_study_custom_fields` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `created_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  `updated_time` datetime DEFAULT NULL COMMENT '更新时间',
  `custom_fields_id` bigint(20) DEFAULT NULL COMMENT '字段id(rm_cfg_custom_fields.id)',
  `study_id` bigint(20) DEFAULT NULL COMMENT '项目id',
  `answer` varchar(512) DEFAULT NULL COMMENT '答案',
  `option_id` bigint(20) DEFAULT NULL COMMENT '选项id rm_custom_fields_option.id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='工时-项目信息-自定义字段、项目、选项关系表';


CREATE TABLE `rm_monthly_backup_dept` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `created_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  `updated_time` datetime DEFAULT NULL COMMENT '更新时间',
  `dept_id` bigint(20) DEFAULT NULL COMMENT '部门Id',
  `number` int(20) DEFAULT NULL COMMENT '人数',
  `month_year` varchar(255) DEFAULT NULL COMMENT '时间月份',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
CREATE TABLE `rm_exchange_rate` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `created_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  `updated_time` datetime DEFAULT NULL COMMENT '更新时间',
  `month_year` varchar(255) DEFAULT NULL COMMENT '年-月',
  `currency_id` bigint(20) DEFAULT NULL COMMENT '币种ID',
  `exchange_rate` double(20,7) DEFAULT NULL COMMENT '汇率',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='月汇率表';

CREATE TABLE `rm_theoretical_working_hours` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `created_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  `updated_time` datetime DEFAULT NULL COMMENT '更新时间',
  `month_year` varchar(255) DEFAULT NULL COMMENT '理论时间',
  `working_hour` bigint(20) DEFAULT NULL COMMENT '工时数量',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='理论工时配置';
CREATE TABLE `rm_filling_time_setting` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `created_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  `updated_time` datetime DEFAULT NULL COMMENT '更新时间',
	`filling_time` int(10) DEFAULT NULL COMMENT '补填时间',
	`date_of_filling_in` int(10) DEFAULT NULL COMMENT '被补填时间',
	`filled_in_month` tinyint(4) DEFAULT NULL COMMENT '本月填写',
	`filled_in_following_month` tinyint(4) DEFAULT NULL COMMENT '次月填写状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='任务详情表';


CREATE TABLE `rm_version_fallback` (
  `id` bigint(20) NOT NULL COMMENT 'id',
	`status` int(10) DEFAULT NULL,
	`created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `created_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  `updated_time` datetime DEFAULT NULL COMMENT '更新时间',
	`version_id`  bigint(20) NOT NULL COMMENT '版本ID',
	`study_id` bigint(20) DEFAULT NULL COMMENT '项目id',
  `version` int(10) DEFAULT NULL COMMENT '版本',
  `is_release` tinyint(4) DEFAULT NULL COMMENT '发布(1-未发布(展示发布按钮) 2-已发布(不展示发布按钮))',
  `is_upgrade` tinyint(4) DEFAULT NULL COMMENT '升级(1-未升级(展示版本升级按钮) 2-已升级(不展示版本升级按钮))',
  `estimate_active` tinyint(4) DEFAULT NULL COMMENT '合同进度预估审批状态(1-待提交 2-已提交、待审批 3-已批准)',
  `confirm_active` tinyint(4) DEFAULT NULL COMMENT '合同进度确认审批状态(1-待提交 2-已提交、待审批 3-已批准)',
  `approval_type` tinyint(4) DEFAULT NULL COMMENT '见码表approval_type',
  `contract_date` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '合同签署日期',
  `valid_period_start` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '有效期开始',
  `valid_period_end` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '有效期结束',
  `plan_date_start` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '计划开始日期',
  `plan_date_end` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '计划结束日期',
  `signing_event` tinyint(4) DEFAULT NULL COMMENT '是否可以选择签署时间',
  `plan_date_unlock_start` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '计划解锁开始日期',
  `plan_date_unlock_end` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '计划解锁结束日期',
  `plan_edit` tinyint(4) DEFAULT NULL COMMENT '计划进度是否可以编辑',
  `approval_edit` tinyint(4) DEFAULT NULL COMMENT '是否为审批后编辑',
  `estimate_approval_type` tinyint(4) DEFAULT NULL COMMENT '该版本的计划进度是否通过过审批',
  `discount_rate` double(20,7) DEFAULT NULL COMMENT '折扣率',
  `discount_amount` double(20,7) DEFAULT NULL COMMENT '折扣金额',
  `currency_id` bigint(20) DEFAULT NULL COMMENT '币种id',
  `contract_period` int(10) DEFAULT NULL COMMENT '合同周期',
  `manpower` json DEFAULT NULL COMMENT '合同人力',
  `exchange_rate` double(20,7) DEFAULT NULL COMMENT '汇率',
  `contract_submit_time` datetime DEFAULT NULL COMMENT '合同更新时间',
  `plan_submit_time` datetime DEFAULT NULL COMMENT '计划进度更新时间',
  `actual_submit_time` datetime DEFAULT NULL COMMENT '实际进度更新时间',
  `manpower_submit_time` datetime DEFAULT NULL COMMENT '人力更新时间',
  `relevance_type` tinyint(4) DEFAULT '0' COMMENT '1进行过关联  0 未进行过关联',
  `tax_rate` double(20,10) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;



INSERT INTO `rm_company_project_task`(`id`, `status`, `created_by`, `created_time`, `updated_by`, `updated_time`, `task_name`, `remarks`, `active`, `not_removable`)
VALUES
(1, 1, NULL, '2022-08-29 03:23:11', NULL, '2022-08-29 03:23:47', '竞标工时', '竞标工时', 1, 0);
-- ----------------------------
-- Records of rm_model
-- ----------------------------
DELETE FROM `rm_model`;

INSERT INTO `rm_model` VALUES (1, 1, 1,  '2022-06-15 18:00:00', NULL, NULL, '', '会议', 1, 1, 2, NULL , 0 , 0);
INSERT INTO `rm_model` VALUES (2, 1, 1,  '2022-06-15 18:00:00', NULL, NULL, '', '方案', 1, 2, 2, NULL ,0 , 0);
INSERT INTO `rm_model` VALUES (3, 1, 1,  '2022-06-15 18:00:00', NULL, NULL, '', 'IB', 1, 3, 2, NULL ,0 , 0);
INSERT INTO `rm_model` VALUES (4, 1, 1,  '2022-06-15 18:00:00', NULL, NULL, '', '修订', 1, 4, 2, NULL ,0 , 0);
INSERT INTO `rm_model` VALUES (5, 1, 1,  '2022-06-15 18:00:00', NULL, NULL, '', 'ICF', 1, 5, 2, NULL ,0 , 0);
INSERT INTO `rm_model` VALUES (6, 1, 1,  '2022-06-15 18:00:00', NULL, NULL, '', '日志', 1, 6, 2, NULL ,0 , 0);
INSERT INTO `rm_model` VALUES (7, 1, 1,  '2022-06-15 18:00:00', NULL, NULL, '', '信息卡', 1, 7, 2, NULL ,0 , 0);
INSERT INTO `rm_model` VALUES (8, 1, 1,  '2022-06-15 18:00:00', NULL, NULL, '', '列表', 1, 8, 2, NULL ,0 , 0);
INSERT INTO `rm_model` VALUES (9, 1, 1,  '2022-06-15 18:00:00', NULL, NULL, '', '广告', 1, 9, 2, NULL ,0 , 0);
INSERT INTO `rm_model` VALUES (10, 1, 1, '2022-06-15 18:00:00', NULL, NULL, '', '研究者会', 1, 10, 2, NULL ,0 , 0);
INSERT INTO `rm_model` VALUES (11, 1, 1, '2022-06-15 18:00:00', NULL, NULL, '', '递交', 1, 11, 2, NULL ,0 , 0);
INSERT INTO `rm_model` VALUES (12, 1, 1, '2022-06-15 18:00:00', NULL, NULL, '', '批件', 1, 12, 2, NULL ,0 , 0);
INSERT INTO `rm_model` VALUES (13, 1, 1, '2022-06-15 18:00:00', NULL, NULL, '', '备案', 1, 13, 2, NULL ,0 , 0);
INSERT INTO `rm_model` VALUES (14, 1, 1, '2022-06-15 18:00:00', NULL, NULL, '', '合同', 1, 14, 2, NULL ,0 , 0);
INSERT INTO `rm_model` VALUES (15, 1, 1, '2022-06-15 18:00:00', NULL, NULL, '', '付款', 1, 15, 2, NULL ,0 , 0);
INSERT INTO `rm_model` VALUES (16, 1, 1, '2022-06-15 18:00:00', NULL, NULL, '', '中心', 1, 16, 2, NULL ,0 , 0);
INSERT INTO `rm_model` VALUES (17, 1, 1, '2022-06-15 18:00:00', NULL, NULL, '', 'SAE', 1, 17, 2, NULL ,0 , 0);
INSERT INTO `rm_model` VALUES (18, 1, 1, '2022-06-15 18:00:00', NULL, NULL, '', '培训', 1, 18, 2, NULL ,0 , 0);
INSERT INTO `rm_model` VALUES (19, 1, 1, '2022-06-15 18:00:00', NULL, NULL, '', 'PMP', 1, 19, 2, NULL ,0 , 0);
INSERT INTO `rm_model` VALUES (20, 1, 1, '2022-06-15 18:00:00', NULL, NULL, '', 'MVP', 1, 20, 2, NULL ,0 , 0);
INSERT INTO `rm_model` VALUES (21, 1, 1, '2022-06-15 18:00:00', NULL, NULL, '', '协同监查', 1, 21, 2, NULL ,0 , 0);
INSERT INTO `rm_model` VALUES (22, 1, 1, '2022-06-15 18:00:00', NULL, NULL, '', '月', 1, 22, 2, NULL ,0 , 0);
INSERT INTO `rm_model` VALUES (23, 1, 1, '2022-06-15 18:00:00', NULL, NULL, '', '交接', 1, 23, 2, NULL ,0 , 0);
INSERT INTO `rm_model` VALUES (24, 1, 1, '2022-06-15 18:00:00', NULL, NULL, '', '报告', 1, 24, 2, NULL ,0 , 0);
INSERT INTO `rm_model` VALUES (25, 1, 1, '2022-06-15 18:00:00', NULL, NULL, '', '附件', 1, 25, 2, NULL ,0 , 0);
INSERT INTO `rm_model` VALUES (26, 1, 1, '2022-06-15 18:00:00', NULL, NULL, '', '审阅', 1, 26, 2, NULL ,0 , 0);
INSERT INTO `rm_model` VALUES (27, 1, 1, '2022-06-15 18:00:00', NULL, NULL, '', '质控', 1, 27, 2, NULL ,0 , 0);
INSERT INTO `rm_model` VALUES (28, 1, 1, '2022-06-15 18:00:00', NULL, NULL, '', '次', 1, 28, 2, NULL ,0 , 0);
INSERT INTO `rm_model` VALUES (33, 1, 1, '2022-06-15 18:00:00', NULL, NULL, '', '周', 1, 33, 2, NULL ,0 , 0);
INSERT INTO `rm_model` VALUES (34, 1, 1, '2022-06-15 18:00:00', NULL, NULL, '', '份', 1, 34, 2, NULL ,0 , 0);
INSERT INTO `rm_model` VALUES (35, 1, 1, '2022-06-15 18:00:00', NULL, NULL, '', '项目', 1, 35, 2, NULL ,0 , 0);
INSERT INTO `rm_model` VALUES (36, 1, 1, '2022-06-15 18:00:00', NULL, NULL, '', '个', 1, 36, 2, NULL ,0 , 0);
INSERT INTO `rm_model` VALUES (37, 1, 1, '2022-06-15 18:00:00', NULL, NULL, '', '例', 1, 37, 2, NULL ,0 , 0);
INSERT INTO `rm_model` VALUES (38, 1, 1, '2022-06-15 18:00:00', NULL, NULL, '', '供应商', 1, 38, 2, NULL ,0 , 0);
INSERT INTO `rm_model` VALUES (39, 1, 1, '2022-06-15 18:00:00', NULL, NULL, '', '类', 1, 39, 2, NULL ,0 , 0);
INSERT INTO `rm_model` VALUES (40, 1, 1, '2022-06-15 18:00:00', NULL, NULL, '', '家', 1, 40, 2, NULL ,0 , 0);
INSERT INTO `rm_model` VALUES (41, 1, 1, '2022-06-15 18:00:00', NULL, NULL, '', '人', 1, 41, 2, NULL ,0 , 0);
INSERT INTO `rm_model` VALUES (42, 1, 1, '2022-06-15 18:00:00', NULL, NULL, '', '方案沟通会', 1, 42, 2, NULL ,0 , 0);
INSERT INTO `rm_model` VALUES (43, 1, 1, '2022-06-15 18:00:00', NULL, NULL, '', '稽查', 1, 43, 2, NULL ,0 , 0);
INSERT INTO `rm_model` VALUES (44, 1, 1, '2022-06-15 18:00:00', NULL, NULL, '', '批次', 1, 44, 2, NULL ,0 , 0);
INSERT INTO `rm_model` VALUES (45, 1, 1, '2022-06-15 18:00:00', NULL, NULL, '', '监查', 1, 45, 2, NULL ,0 , 0);
INSERT INTO `rm_model` VALUES (46, 1, 1, '2022-06-15 18:00:00', NULL, NULL, '', '省', 1, 46, 2, NULL ,0 , 0);
INSERT INTO `rm_model` VALUES (47, 1, 1, '2022-06-15 18:00:00', NULL, NULL, '', '清单', 1, 47, 2, NULL ,0 , 0);
INSERT INTO `rm_model` VALUES (48, 1, 1, '2022-06-15 18:00:00', NULL, NULL, '', '沟通', 1, 48, 2, NULL ,0 , 0);
INSERT INTO `rm_model` VALUES (49, 1, 1, '2022-06-15 18:00:00', NULL, NULL, '', '设置', 1, 49, 2, NULL ,0 , 0);
INSERT INTO `rm_model` VALUES (50, 1, 1, '2022-06-15 18:00:00', NULL, NULL, '', '测试', 1, 50, 2, NULL ,0 , 0);
INSERT INTO `rm_model` VALUES (51, 1, 1, '2022-06-15 18:00:00', NULL, NULL, '', '小时', 1, 51, 2, NULL ,0 , 0);
INSERT INTO `rm_model` VALUES (52, 1, 1, '2022-06-15 18:00:00', NULL, NULL, '', '季度', 1, 52, 2, NULL ,0 , 0);
INSERT INTO `rm_model` VALUES (53, 1, 1, '2022-06-15 18:00:00', NULL, NULL, '', '审核', 1, 53, 2, NULL ,0 , 0);
INSERT INTO `rm_model` VALUES (54, 1, 1, '2022-06-15 18:00:00', NULL, NULL, '', '日记卡', 1, 54, 2, NULL ,0 , 0);
INSERT INTO `rm_model` VALUES (55, 1, 1, '2022-06-15 18:00:00', NULL, NULL, '', '核查', 1, 55, 2, NULL ,0 , 0);
INSERT INTO `rm_model` VALUES (56, 1, 1, '2022-06-15 18:00:00', NULL, NULL, '', '访视', 1, 56, 2, NULL ,0 , 0);
INSERT INTO `rm_model` VALUES (29, 1, 1, '2022-06-15 18:00:00', NULL, NULL, '', '/', 1, 29, 2, NULL ,0 , 0);
INSERT INTO `rm_model` VALUES (30, 1, 1, '2022-06-15 18:00:00', NULL, NULL, '', '计划', 1, 30, 2, NULL ,0 , 0);
INSERT INTO `rm_model` VALUES (31, 1, 1, '2022-06-15 18:00:00', NULL, NULL, '', '手册', 1, 31, 2, NULL ,0 , 0);
INSERT INTO `rm_model` VALUES (32, 1, 1, '2022-06-15 18:00:00', NULL, NULL, '', 'AD表', 1, 32, 2, NULL ,0 , 0);
INSERT INTO `rm_model` VALUES (57, 1, 1, '2022-06-15 18:00:00', NULL, NULL, '', '组', 1, 57, 2, NULL ,0 , 0);

-- ----------------------------
-- Records of rm_reminder_settings
-- ----------------------------
DELETE FROM `rm_reminder_settings`;
INSERT INTO `rm_reminder_settings` VALUES (1,  1, NULL, '2022-06-15 18:00:00', NULL, NULL, 2, '工时填报', '请及时填报工时！', '(每月XXX日~XXX日完成填报)', '每月XX日~XX日，每X天X点', NULL, 1, 1, "");
INSERT INTO `rm_reminder_settings` VALUES (2,  1, NULL, '2022-06-15 18:00:00', NULL, NULL, 2, '工时审批', '您有新的工时需要审批，请及时处理！', '(项目编号XXX)', '提交工时', NULL, 1, 3, "");
INSERT INTO `rm_reminder_settings` VALUES (3,  1, NULL, '2022-06-15 18:00:00', NULL, NULL, 2, '工时退回', '您提交工时已被退回，请确认工时！', '(项目编号XXX，审批意见：XXX)', '退回工时', NULL, 1, 3, "");
INSERT INTO `rm_reminder_settings` VALUES (4,  1, NULL, '2022-06-15 18:00:00', NULL, NULL, 2, '工时批准', '您提交的工时已通过批准！', '(项目编号XXX，审批意见：XXX)', '批准工时', NULL, 1, 3, "");
INSERT INTO `rm_reminder_settings` VALUES (5,  1, NULL, '2022-06-15 18:00:00', NULL, NULL, 2, '已批准工时被删除', '您有通过的工时被删除！', '(项目编号XXX，由角色XX删除)', '删除已批准工时', NULL, 1, 3, "");
INSERT INTO `rm_reminder_settings` VALUES (6,  1, NULL, '2022-06-15 18:00:00', NULL, NULL, 2, '合同审批', '您有新的合同需要审批，请及时处理！', '(项目编号XXX)', '提交合同', NULL, 1, 3, "");
INSERT INTO `rm_reminder_settings` VALUES (7,  1, NULL, '2022-06-15 18:00:00', NULL, NULL, 2, '合同审批通过', '您提交的合同已通过审批！', '(项目编号XXX_版本XXX，审批意见：XXX)', '批准合同', NULL, 1, 3, "");
INSERT INTO `rm_reminder_settings` VALUES (8,  1, NULL, '2022-06-15 18:00:00', NULL, NULL, 2, '合同退回', '您提交的合同已被退回！', '(项目编号XXX_版本XXX，审批意见：XXX)', '退回合同', NULL, 1, 3, "");
INSERT INTO `rm_reminder_settings` VALUES (9,  1, NULL, '2022-06-15 18:00:00', NULL, NULL, 2, '计划进度', '请及时完成当月的计划进度！', '(项目编号XXX_版本XXX)', '发布合同', NULL, 1, 3, "");
INSERT INTO `rm_reminder_settings` VALUES (10, 1, NULL, '2022-06-15 18:00:00', NULL, NULL, 2, '计划进度审批', '修改提示：您有新的计划进度需要审批！', '(项目编号XXX_版本XXX)', '提交计划进度', NULL, 1, 3, "");
INSERT INTO `rm_reminder_settings` VALUES (11, 1, NULL, '2022-06-15 18:00:00', NULL, NULL, 2, '计划进度审批通过', '您提交的计划进度已通过审批！', '(项目编号XXX_版本XXX，审批意见：XXX)', '批准计划进度', NULL, 1, 3, "");
INSERT INTO `rm_reminder_settings` VALUES (12, 1, NULL, '2022-06-15 18:00:00', NULL, NULL, 2, '计划进度退回', '您提交的计划进度已被退回！', '(项目编号XXX_版本XXX，审批意见：XXX)', '退回计划进度', NULL, 1, 3, "");
INSERT INTO `rm_reminder_settings` VALUES (13, 1, NULL, '2022-06-15 18:00:00', NULL, NULL, 2, '计划进度解锁', '您提交的计划进度已被解锁！', '(项目编号XXX_版本XXX)', '解锁计划进度', NULL, 1, 2, "");
INSERT INTO `rm_reminder_settings` VALUES (14, 1, NULL, '2022-06-15 18:00:00', NULL, NULL, 2, '实际进度确认', '请完成实际进度！', '(项目编号XXX_版本XXX_XX月)', '每月XX日~XX日，每X天X点', NULL, 1, 1, "");
INSERT INTO `rm_reminder_settings` VALUES (15, 1, NULL, '2022-06-15 18:00:00', NULL, NULL, 2, '实际进度审批', '您有新的实际进度需要审批，请及时处理！', '(项目编号XXX_版本XXX)', '提交实际进度', NULL, 1, 3, "");
INSERT INTO `rm_reminder_settings` VALUES (16, 1, NULL, '2022-06-15 18:00:00', NULL, NULL, 2, '实际进度审批通过', '您提交的实际进度通过审批！', '(项目编号XXX_版本XXX，审批意见：XXX)', '批准实际进度', NULL, 1, 3, "");
INSERT INTO `rm_reminder_settings` VALUES (17, 1, NULL, '2022-06-15 18:00:00', NULL, NULL, 2, '实际进度退回', '您提交的实际进度已被退回！', '(项目编号XXX_版本XXX，审批意见：XXX)', '退回实际进度', NULL, 1, 3, "");
INSERT INTO `rm_reminder_settings` VALUES (18, 1, NULL, '2022-06-15 18:00:00', NULL, NULL, 2, '实际进度解锁', '您提交的实际进度已被解锁！', '(项目编号XXX_版本XXX)', '解锁实际进度', NULL, 1, 2, "");
-- ----------------------------
-- Records of rm_position
-- ----------------------------
-- RM系统定义的职位表
DELETE FROM `rm_position`;

INSERT INTO `rm_position` VALUES (801, '高级项目经理', NULL, NULL, NULL, 8, 1, -1, '2022-05-27 10:00:00', NULL, NULL);
INSERT INTO `rm_position` VALUES (802, '助理项目经理', NULL, NULL, NULL, 8, 1, -1, '2022-05-27 10:00:00', NULL, NULL);
INSERT INTO `rm_position` VALUES (803, '高级临床研究经理', NULL, NULL, NULL, 8, 1, -1, '2022-05-27 10:00:00', NULL, NULL);
INSERT INTO `rm_position` VALUES (804, '助理临床研究经理', NULL, NULL, NULL, 8, 1, -1, '2022-05-27 10:00:00', NULL, NULL);
INSERT INTO `rm_position` VALUES (805, '高级临床试验监查员II', NULL, NULL, NULL, 8, 1, -1, '2022-05-27 10:00:00', NULL, NULL);
INSERT INTO `rm_position` VALUES (806, '高级临床试验监查员I', NULL, NULL, NULL, 8, 1, -1, '2022-05-27 10:00:00', NULL, NULL);
INSERT INTO `rm_position` VALUES (807, '临床试验监查员III', NULL, NULL, NULL, 8, 1, -1, '2022-05-27 10:00:00', NULL, NULL);
INSERT INTO `rm_position` VALUES (808, '临床试验监查员II', NULL, NULL, NULL, 8, 1, -1, '2022-05-27 10:00:00', NULL, NULL);
INSERT INTO `rm_position` VALUES (809, '临床试验监查员I', NULL, NULL, NULL, 8, 1, -1, '2022-05-27 10:00:00', NULL, NULL);
INSERT INTO `rm_position` VALUES (810, '质量合规总监', NULL, NULL, NULL, 8, 1, -1, '2022-05-27 10:00:00', NULL, NULL);
INSERT INTO `rm_position` VALUES (811, '高级质量合规经理', NULL, NULL, NULL, 8, 1, -1, '2022-05-27 10:00:00', NULL, NULL);
INSERT INTO `rm_position` VALUES (812, '质量合规主管', NULL, NULL, NULL, 8, 1, -1, '2022-05-27 10:00:00', NULL, NULL);
INSERT INTO `rm_position` VALUES (813, '高级临床试验支持经理', NULL, NULL, NULL, 8, 1, -1, '2022-05-27 10:00:00', NULL, NULL);
INSERT INTO `rm_position` VALUES (814, '助理临床支持经理', NULL, NULL, NULL, 8, 1, -1, '2022-05-27 10:00:00', NULL, NULL);
INSERT INTO `rm_position` VALUES (815, '高级临床试验助理II', NULL, NULL, NULL, 8, 1, -1, '2022-05-27 10:00:00', NULL, NULL);
INSERT INTO `rm_position` VALUES (816, '高级临床试验助理I', NULL, NULL, NULL, 8, 1, -1, '2022-05-27 10:00:00', NULL, NULL);
INSERT INTO `rm_position` VALUES (817, '临床试验助理II', NULL, NULL, NULL, 8, 1, -1, '2022-05-27 10:00:00', NULL, NULL);
INSERT INTO `rm_position` VALUES (818, '临床试验助理I', NULL, NULL, NULL, 8, 1, -1, '2022-05-27 10:00:00', NULL, NULL);
INSERT INTO `rm_position` VALUES (819, '实习生', NULL, NULL, NULL, 8, 1, -1, '2022-05-27 10:00:00', NULL, NULL);
INSERT INTO `rm_position` VALUES (820, '高级供应链管理专员', NULL, NULL, NULL, 8, 1, -1, '2022-05-27 10:00:00', NULL, NULL);
INSERT INTO `rm_position` VALUES (821, '供应链管理专员', NULL, NULL, NULL, 8, 1, -1, '2022-05-27 10:00:00', NULL, NULL);
INSERT INTO `rm_position` VALUES (822, '供应商管理专员', NULL, NULL, NULL, 8, 1, -1, '2022-05-27 10:00:00', NULL, NULL);
INSERT INTO `rm_position` VALUES (823, '合同进度管理专员', NULL, NULL, NULL, 8, 1, -1, '2022-05-27 10:00:00', NULL, NULL);
INSERT INTO `rm_position` VALUES (824, '竞标支持经理', NULL, NULL, NULL, 8, 1, -1, '2022-05-27 10:00:00', NULL, NULL);
INSERT INTO `rm_position` VALUES (825, '竞标支持专员', NULL, NULL, NULL, 8, 1, -1, '2022-05-27 10:00:00', NULL, NULL);
INSERT INTO `rm_position` VALUES (826, '高级副总裁', NULL, NULL, NULL, 8, 1, -1, '2022-05-27 10:00:00', NULL, NULL);
INSERT INTO `rm_position` VALUES (827, '临床运营总监', NULL, NULL, NULL, 8, 1, -1, '2022-05-27 10:00:00', NULL, NULL);
INSERT INTO `rm_position` VALUES (828, '商业运营总监', NULL, NULL, NULL, 8, 1, -1, '2022-05-27 10:00:00', NULL, NULL);
INSERT INTO `rm_position` VALUES (829, '高级临床试验文档管理专员I', NULL, NULL, NULL, 8, 1, -1, '2022-05-27 10:00:00', NULL, NULL);


-- ----------------------------
-- Records of mds_role
-- ----------------------------

REPLACE INTO `mds_role` VALUES (8,   -1, '2022-06-15 18:00:00', NULL, NULL, 1, '管理员', 'RM-Admin', 'RM-ADMIN',NULL, 8, 3, 2, '20051', NULL, 1 , 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai") ;

REPLACE INTO `mds_role` VALUES (8001,-1, '2022-06-15 18:00:00', NULL, NULL, 1, '人力资源管理员', 'HRMgr', NULL,'资源管理人员', 8, 3, 2, '20051', NULL, 1 , 1 ,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai");

REPLACE INTO `mds_role` VALUES (8002,-1, '2022-06-15 18:00:00', NULL, NULL, 1, '项目经理', 'ProjMgr',NULL, NULL, 8, 3, 2, '20052', NULL, 1 , 1 ,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role` VALUES (8003,-1, '2022-06-15 18:00:00', NULL, NULL, 1, '临床试验监查员', 'ClinResAsct', NULL,NULL, 8, 3, 2, '20052', NULL, 1 , 1 ,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role` VALUES (8004,-1, '2022-06-15 18:00:00', NULL, NULL, 1, '合同进度管理人员', 'ConProMgr',NULL, NULL, 8, 3, 2, '20051', NULL, 1 , 1 ,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role` VALUES (8005,-1, '2022-06-15 18:00:00', NULL, NULL, 1, '统计师', 'AudiMgr',NULL, NULL, 8, 3, 3, '20052', NULL, 1 , 1 ,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role` VALUES (8006,-1, '2022-06-15 18:00:00', NULL, NULL, 1, '临床试验助理', 'ClinTriAst', NULL,NULL, 8, 3, 2, '20052', NULL, 1 , 1 ,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role` VALUES (8007,-1, '2022-06-15 18:00:00', NULL, NULL, 1, '数据经理', 'DataMgr', NULL,NULL, 8, 3, 3, '20052', NULL, 1 , 1 ,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role` VALUES (8008,-1, '2022-06-15 18:00:00', NULL, NULL, 1, '医学监查员', 'MediExam', NULL,NULL, 8, 3, 3, '20052', NULL, 1 , 1 ,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role` VALUES (8009,-1, '2022-06-15 18:00:00', NULL, NULL, 1, '财务', 'Finance', NULL,NULL, 8, 3, 3, '20052', NULL, 1 , 1 ,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role` VALUES (8010,-1, '2022-06-15 18:00:00', NULL, NULL, 1, '供应链管理经理', 'SupChnMgmtMgr',NULL, NULL, 8, 3, 2, '20052', NULL, 1 , 1 ,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role` VALUES (8011,-1, '2022-06-15 18:00:00', NULL, NULL, 1, '供应商管理经理', 'SupMgmtMgr',NULL, NULL, 8, 3, 2, '20052', NULL, 1 , 1 ,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role` VALUES (8012,-1, '2022-06-15 18:00:00', NULL, NULL, 1, '临床运营副总监', 'DepDirecOfClinOpe',NULL, NULL, 8, 3, 3, '20052', NULL, 1 , 1 ,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role` VALUES (8013,-1, '2022-06-15 18:00:00', NULL, NULL, 1, '药品管理员', 'DrugMgr',NULL, NULL, 8, 3, 3, '20052', NULL, 1 , 1 ,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role` VALUES (8014,-1, '2022-06-15 18:00:00', NULL, NULL, 1, '质量合规经理', 'QuaCompMgr', NULL,NULL, 8, 3, 2, '20052', NULL, 1 , 1 ,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role` VALUES (8015,-1, '2022-06-15 18:00:00', NULL, NULL, 0, '供应商经理', NULL, NULL,NULL, 8, 3, 3, '20052', NULL, 1 , 1 ,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role` VALUES (8016,-1, '2022-06-15 18:00:00', NULL, NULL, 0, '供应链经理', NULL, NULL,NULL, 8, 3, 3, '20052', NULL, 1 , 1 ,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role` VALUES (8017,-1, '2022-06-15 18:00:00', NULL, NULL, 1, '医学写作经理', 'MediWriMgr', NULL,NULL, 8, 3, 3, '20052', NULL, 1 , 1 ,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role` VALUES (8018,-1, '2022-06-15 18:00:00', NULL, NULL, 1, '医学审阅', 'MediReview', NULL,NULL, 8, 3, 3, '20052', NULL, 1 , 1 ,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role` VALUES (8019,-1, '2022-06-15 18:00:00', NULL, NULL, 1, '质量控制', 'QuaCtrl', NULL,NULL, 8, 3, 3, '20052', NULL, 1 , 1 ,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role` VALUES (8020,-1, '2022-06-15 18:00:00', NULL, NULL, 1, '质量保证', 'QuaAssu', NULL,NULL, 8, 3, 3, '20052', NULL, 1 , 1 ,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role` VALUES (8021,-1, '2022-06-15 18:00:00', NULL, NULL, 1, '遗传办负责人', 'HeadOfGenOffi',NULL, NULL, 8, 3, 3, '20052', NULL, 1 , 1 ,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role` VALUES (8022,-1, '2022-06-15 18:00:00', NULL, NULL, 1, '遗传办专员', 'GenOffiSpe', NULL,NULL, 8, 3, 3, '20052', NULL, 1 , 1 ,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role` VALUES (8023,-1, '2022-06-15 18:00:00', NULL, NULL, 1, '注册总监', 'RegisDirec', NULL,NULL, 8, 3, 3, '20052', NULL, 1 , 1 ,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role` VALUES (8024,-1, '2022-06-15 18:00:00', NULL, NULL, 1, '注册经理', 'RegisMgr', NULL,NULL, 8, 3, 3, '20052', NULL, 1 , 1 ,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role` VALUES (8025,-1, '2022-06-15 18:00:00', NULL, NULL, 1, '注册专员', 'RegisSpe', NULL,NULL, 8, 3, 3, '20052', NULL, 1 , 1 ,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role` VALUES (8026,-1, '2022-06-15 18:00:00', NULL, NULL, 1, '供应链专员', 'SupChnCot', NULL,NULL, 8, 3, 3, '20052', NULL, 1 , 1 ,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role` VALUES (8027,-1, '2022-06-15 18:00:00', NULL, NULL, 1, '临床研究经理', 'ClinResMgr',NULL, NULL, 8, 3, 2, '20052', NULL, 1 , 1 ,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role` VALUES (8028,-1, '2022-06-15 18:00:00', NULL, NULL, 1, '项目总监', 'ProjDirec', NULL,NULL, 8, 3, 3, '20052', NULL, 1 , 1 ,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role` VALUES (8029,-1, '2022-06-15 18:00:00', NULL, NULL, 1, '区域中心管理', 'RegCentMgmt',NULL, NULL, 8, 3, 3, '20052', NULL, 1 , 1 ,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role` VALUES (8030,-1, '2022-06-15 18:00:00', NULL, NULL, 1, '项目副总监', 'DepProjDirec', NULL,NULL, 8, 3, 3, '20052', NULL, 1 , 1 ,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role` VALUES (8031,-1, '2022-06-15 18:00:00', NULL, NULL, 1, '临床质量合规与培训助理', 'ClinQuaCompAndTraAst', NULL,NULL, 8, 3, 3, '20052', NULL, 1 , 1 ,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role` VALUES (8032,-1, '2022-06-15 18:00:00', NULL, NULL, 1, '部门助理', 'DepartAst', NULL,NULL, 8, 3, 3, '20052', NULL, 1 , 1 ,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role` VALUES (8033,-1, '2022-06-15 18:00:00', NULL, NULL, 1, '培训经理', 'TraMgr', NULL,NULL, 8, 3, 3, '20052', NULL, 1 , 1 ,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role` VALUES (8034,-1, '2022-06-15 18:00:00', NULL, NULL, 1, '稽查员', 'Inspector', NULL,NULL, 8, 3, 3, '20052', NULL, 1 , 1 ,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role` VALUES (8035,-1, '2022-06-15 18:00:00', NULL, NULL, 1, '稽查经理', 'AudiMgr',NULL, NULL, 8, 3, 3, '20052', NULL, 1 , 1 ,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role` VALUES (8036,-1, '2022-06-15 18:00:00', NULL, NULL, 1, '系统支持专员', 'SysSuSpe', NULL,NULL, 8, 3, 3, '20052', NULL, 1 , 1 ,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role` VALUES (8037,-1, '2022-06-15 18:00:00', NULL, NULL, 1, '系统支持经理', 'SysSuMgr', NULL,NULL, 8, 3, 2, '20052', NULL, 1 , 1 ,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role` VALUES (8038,-1, '2022-06-15 18:00:00', NULL, NULL, 1, '非盲态项目经理', 'UnProjMgr', NULL,NULL, 8, 3, 3, '20052', NULL, 1 , 1 ,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role` VALUES (8039,-1, '2022-06-15 18:00:00', NULL, NULL, 1, '非盲态临床监查员', 'UnClinResAsct', NULL,NULL, 8, 3, 3, '20052', NULL, 1 , 1 ,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role` VALUES (8040,-1, '2022-06-15 18:00:00', NULL, NULL, 1, '非盲态临床试验助理', 'UnClinTriAst', NULL,NULL, 8, 3, 3, '20052', NULL, 1 , 1 ,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role` VALUES (8041,-1, '2022-06-15 18:00:00', NULL, NULL, 1, '文件经理', 'DocMgr', NULL,NULL, 8, 3, 3, '20052', NULL, 1 , 1 ,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role` VALUES (8042,-1, '2022-06-15 18:00:00', NULL, NULL, 1, '直线经理', 'LineMgr', NULL,'', 8, 3, 2, '20052', NULL, 1 , 1 ,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role` VALUES (8043,-1, '2022-06-15 18:00:00', NULL, NULL, 1, '临床支持经理', 'ClinSuMgr', NULL,NULL, 8, 3, 2, '20052', NULL, 1 , 1 ,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role` VALUES (8044,-1, '2022-06-15 18:00:00', NULL, NULL, 1, '遗传办经理', 'MgrOfGenOffi', NULL,NULL, 8, 3, 2, '20052', NULL, 1 , 1 ,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai");

DELETE FROM `mds_resource` WHERE sys_id = 8;

REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8, 1, '2022-06-15 18:00:00', NULL, NULL, 1, -1, 'Resource Management', '', '8', '', '', '', 'sys', 8, NULL, 0, 1 ,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);

REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8001, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8, '公司设置', '', '8001', '8001', '', '', 'button', 8, NULL, 0, 1 ,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8002, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8, '项目管理', 'icon-xiangmu', '8002', '', '/home/index', '', 'menu', 8, NULL, 0, 1 ,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8003, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8, '工时管理', 'icon-shijigongshi', '8003', '', '', '', 'menu', 8, NULL, 0, 1 ,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8004, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8, '审批管理', 'icon-shenhe', '8004', '', '/approvalManage/index', '', 'menu', 8, NULL, 0, 1 ,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8005, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8, '报表管理', 'icon-baobiao', '8005', '', '/statistical/index', '', 'menu', 8, NULL, 0, 1 ,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8001001, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8001, '合同设置', 'icon-hetongguanli', '8001001', '', '/companySet/contractSet', '', 'menu', 8, NULL, 0, 1 ,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8001002, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8001, '人力设置', 'icon-renyuanguanli', '8001002', '', '/companySet/humanSet', '', 'menu', 8, NULL, 0, 1 ,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8001003, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8001, '流程设置', 'icon-neibushenpi', '8001003', '', '/companySet/processManagement', '', 'menu', 8, NULL, 0, 1 ,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8001004, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8001, '解锁设置', 'icon-jiesuo', '8001004', '', '/companySet/unlockSettings', '', 'menu', 8, NULL, 0, 1 ,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8001005, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8001, '报表设置', 'icon-baobiao', '8001005', '', '/companySet/reportSetting', '', 'menu', 8, NULL, 0, 1 ,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8001006, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8001, '稽查轨迹', 'icon-jichaguiji', '8001006', '', '/companySet/auditTrack', '', 'menu', 8, NULL, 0, 1 ,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8001007, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8001, '填报设置', 'icon-jibenxinxi', '8001007', '', '/companySet/fillingSet', '', 'menu', 8, NULL, 0, 1 ,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8002001, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8002, '合同详情', '', '8002001', '8002001', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8002002, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8002, '计划进度', '', '8002002', '8002002', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8002003, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8002, '实际进度', '', '8002003', '8002003', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8002004, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8002, '人力申请', '', '8002004', '8002004', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8002005, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8002, '人力分配', '', '8002005', '8002005', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8002006, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8002, '人力接收', '', '8002006', '8002006', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8002007, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8002, '编辑项目详情', '', '8002007', '8002007', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8003002, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8003, '工时填报', '', '8003001', '', '/fillTime/index', '', 'menu', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8003001, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8003, '工时记录', '', '8003002', '', '/fillTime/record', '', 'menu', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8003003, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8003, '人力资源池', '', '8003003', '', '/fillTime/resource', '', 'menu', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8005001, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8005, '部门报表', '', '8005001', '', '/statistical/deptReport', '', 'menu', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8005002, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8005, '项目报表', '', '8005002', '', '/statistical/projectReport', '', 'menu', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8005003, 1, '2022-06-15 18:00:00', NULL, NULL, 0, 8005, '角色报表', '', '8005003', '', '/statistical/roleReport', '', 'menu', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8005004, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8005, '个人报表', '', '8005004', '', '/statistical/personalReport', '', 'menu', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8005005, 1, '2022-06-15 18:00:00', NULL, NULL, 0, 8005, '预测报表', '', '8005005', '', '/statistical/forecastReport', '', 'menu', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8005006, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8005, '监管报表', '', '8005006', '', '/statistical/superviseReport', '', 'menu', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8005007, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8005, '业务报表', '', '8005007', '', '/statistical/businessReport', '', 'menu', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8001001001, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8001001, '合同模板', '', '8001001001', '8001001001', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8001001002, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8001001, '类型', '', '8001001002', '8001001002', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8001001003, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8001001, '费用归属', '', '8001001003', '8001001003', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8001001004, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8001001, '合同信息', '', '8001001004', '8001001004', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8001002001, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8001002, '标准工时', '', '8001002001', '8001002001', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8001002002, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8001002, '分配管理员', '', '8001002002', '8001002002', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8001003001, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8001003, '审批设置', '', '8001003001', '8001003001', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8001003002, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8001003, '提醒设置', '', '8001003002', '8001003002', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);

REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8001004001, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8001004, '填报工时', '', '8001004001', '8001004001', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8001004002, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8001004, '计划进度', '', '8001004002', '8001004002', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8001004003, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8001004, '实际进度', '', '8001004003', '8001004003', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);

REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8001001005, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8001007, '非项目任务', '', '8001001005', '8001001005', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8001003003, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8001007, '页面提醒', '', '8001003003', '8001003003', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8001007001, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8001007, '字段设置', '', '8001007001', '8001007001', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);

REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8001001006, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8001001, '月汇率', '', '8001001006', '8001001006', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8001001007, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8001001, '项目设置', '', '8001001007', '8001001007', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);

REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8002001001, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8002001, '发布', '', '8002001001', '8002001001', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8002001002, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8002001, '引用模板', '', '8002001002', '8002001002', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8002001003, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8002001, '导出', '', '8002001003', '8002001003', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8002001004, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8002001, '导入', '', '8002001004', '8002001004', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8002001005, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8002001, '版本升级', '', '8002001005', '8002001005', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8002001006, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8002001, '编辑', '', '8002001006', '8002001006', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8002001007, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8002001, '提交', '', '8002001007', '8002001007', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8002001008, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8002001, '添加任务类别/费用归属', '', '8002001008', '8002001008', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8002001009, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8002001, '展示价格', '', '8002001009', '8002001009', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8002001010, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8002001, '编辑任务类别', '', '8002001010', '8002001010', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8002001011, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8002001, '撤回升级', '', '8002001011', '8002001011', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);

REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8002002001, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8002002, '编辑计划次数', '', '8002002001', '8002002001', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8002003001, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8002003, '编辑实际次数', '', '8002003001', '8002003001', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8002004001, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8002004, '编辑', '', '8002004001', '8002004001', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8002005001, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8002005, '编辑', '', '8002005001', '8002005001', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8002006001, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8002006, '编辑', '', '8002006001', '8002006001', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8003001001, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8003001, '我的工时', '', '8003001001', '8003001001', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8003001002, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8003001, '部门工时', '', '8003001002', '8003001002', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8003001003, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8003001, '项目工时', '', '8003001003', '8003001003', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8003001004, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8003001, '全部工时', '', '8003001004', '8003001004', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8003001005, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8003001, '已删除工时', '', '8003001005', '8003001005', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8003002001, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8003002, '编辑', '', '8003002001', '8003002001', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8003003001, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8003003, '移除项目', '', '8003003001', '8003003001', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8005001001, 1, '2022-06-15 18:00:00', NULL, NULL, 0, 8005001, '查看', '', '8005001001', '8005001001', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8005001002, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8005001, '导出', '', '8005001002', '8005001002', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8005002001, 1, '2022-06-15 18:00:00', NULL, NULL, 0, 8005002, '查看', '', '8005002001', '8005002001', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8005002002, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8005002, '导出', '', '8005002002', '8005002002', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8005003001, 1, '2022-06-15 18:00:00', NULL, NULL, 0, 8005003, '查看', '', '8005003001', '8005003001', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8005003002, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8005003, '导出', '', '8005003002', '8005003002', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8005004001, 1, '2022-06-15 18:00:00', NULL, NULL, 0, 8005004, '查看', '', '8005004001', '8005004001', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8005004002, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8005004, '导出', '', '8005004002', '8005004002', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8005005001, 1, '2022-06-15 18:00:00', NULL, NULL, 0, 8005005, '查看', '', '8005005001', '8005005001', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8005005002, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8005005, '导出', '', '8005005002', '8005005002', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8005005001, 1, '2022-06-15 18:00:00', NULL, NULL, 0, 8005006, '查看', '', '8005005001', '8005005001', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8005005002, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8005006, '导出', '', '8005005002', '8005005002', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);

REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8001001001001, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8001001001, '新增', '', '8001001001001', '8001001001001', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8001001001002, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8001001001, '复制', '', '8001001001002', '8001001001002', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8001001001003, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8001001001, '编辑', '', '8001001001003', '8001001001003', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8001001001004, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8001001001, '删除', '', '8001001001004', '8001001001004', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8001001002001, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8001001002, '添加', '', '8001001002001', '8001001002001', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8001001002002, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8001001002, '编辑', '', '8001001002002', '8001001002002', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8001001002003, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8001001002, '删除', '', '8001001002003', '8001001002003', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8001001003001, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8001001003, '添加', '', '8001001003001', '8001001003001', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8001001003002, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8001001003, '编辑', '', '8001001003002', '8001001003002', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8001001003003, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8001001003, '删除', '', '8001001003003', '8001001003003', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8001001004001, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8001001004, '勾选', '', '8001001004001', '8001001004001', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8001001005001, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8001001005, '添加', '', '8001001005001', '8001001005001', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8001001005002, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8001001005, '编辑', '', '8001001005002', '8001001005002', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8001001005003, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8001001005, '删除', '', '8001001005003', '8001001005003', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8001001005004, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8001001005, '启停', '', '8001001005004', '8001001005004', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8001002001001, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8001002001, '编辑', '', '8001002001001', '8001002001001', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8001002002001, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8001002002, '添加', '', '8001002002001', '8001002002001', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8001002002002, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8001002002, '编辑', '', '8001002002002', '8001002002002', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8001002002003, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8001002002, '删除', '', '8001002002003', '8001002002003', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8001003001001, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8001003001, '添加', '', '8001003001001', '8001003001001', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8001003001002, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8001003001, '编辑', '', '8001003001002', '8001003001002', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8001003001003, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8001003001, '删除', '', '8001003001003', '8001003001003', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8001003002001, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8001003002, '启停', '', '8001003002001', '8001003002001', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8001003002002, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8001003002, '编辑', '', '8001003002002', '8001003002002', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8001003003001, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8001003003, '编辑', '', '8001003003001', '8001003003001', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8001004001001, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8001004001, '解锁', '', '8001004001001', '8001004001001', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8001004001002, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8001004001, '锁定', '', '8001004001002', '8001004001002', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8001004002001, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8001004002, '解锁', '', '8001004002001', '8001004002001', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8001004002002, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8001004002, '锁定', '', '8001004002002', '8001004002002', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8001004003001, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8001004003, '解锁', '', '8001004003001', '8001004003001', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8001004003002, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8001004003, '锁定', '', '8001004003002', '8001004003002', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8003001001001, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8003001001, '导出', '', '8003001001001', '8003001001001', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8003001002001, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8003001002, '导出', '', '8003001002001', '8003001002001', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8003001002002, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8003001002, '驳回', '', '8003001002002', '8003001002002', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8003001002003, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8003001002, '删除', '', '8003001002003', '8003001002003', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8003001003001, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8003001003, '导出', '', '8003001003001', '8003001003001', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8003001003002, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8003001003, '驳回', '', '8003001003002', '8003001003002', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8003001003003, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8003001003, '删除', '', '8003001003003', '8003001003003', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8003001004001, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8003001004, '导出', '', '8003001004001', '8003001004001', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8003001004002, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8003001004, '驳回', '', '8003001004002', '8003001004002', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);
REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8003001004003, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8003001004, '删除', '', '8003001004003', '8003001004003', '', '', 'button', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);

REPLACE INTO `mds_resource`(`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `status`, `parent_id`, `name`, `icon`, `sort`, `res_code`, `path`, `component`, `type`, `sys_id`, `group_no`, `disabled`, `internal_flag`, `created_time_tz`, `created_time_ctz`, `updated_time_tz`, `updated_time_ctz`, `del_flag`) VALUES (8005008, 1, '2022-06-15 18:00:00', NULL, NULL, 1, 8005, '专题报表', '', '8005008', '', '/statistical/specialReport', '', 'menu', 8, NULL, 0, 1,"UTC" , "Asia/Shanghai","UTC" , "Asia/Shanghai", 1);

-- 超管-1
REPLACE INTO `mds_role_resource` VALUES (8, 1, '2022-06-15 18:00:00', -1, 8, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8001, 1, '2022-06-15 18:00:00', -1, 8001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8002, 1, '2022-06-15 18:00:00', -1, 8002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8003, 1, '2022-06-15 18:00:00', -1, 8003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8004, 1, '2022-06-15 18:00:00', -1, 8004, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8005, 1, '2022-06-15 18:00:00', -1, 8005, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8001001, 1, '2022-06-15 18:00:00', -1, 8001001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8001002, 1, '2022-06-15 18:00:00', -1, 8001002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8001003, 1, '2022-06-15 18:00:00', -1, 8001003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8001004, 1, '2022-06-15 18:00:00', -1, 8001004, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8001005, 1, '2022-06-15 18:00:00', -1, 8001005, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8001006, 1, '2022-06-15 18:00:00', -1, 8001006, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8002001, 1, '2022-06-15 18:00:00', -1, 8002001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8002002, 1, '2022-06-15 18:00:00', -1, 8002002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8002003, 1, '2022-06-15 18:00:00', -1, 8002003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8002004, 1, '2022-06-15 18:00:00', -1, 8002004, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8002005, 1, '2022-06-15 18:00:00', -1, 8002005, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8002006, 1, '2022-06-15 18:00:00', -1, 8002006, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8002007, 1, '2022-06-15 18:00:00', -1, 8002007, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8003001, 1, '2022-06-15 18:00:00', -1, 8003001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8003002, 1, '2022-06-15 18:00:00', -1, 8003002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8003003, 1, '2022-06-15 18:00:00', -1, 8003003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8005001, 1, '2022-06-15 18:00:00', -1, 8005001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8005002, 1, '2022-06-15 18:00:00', -1, 8005002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8005003, 1, '2022-06-15 18:00:00', -1, 8005003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8005004, 1, '2022-06-15 18:00:00', -1, 8005004, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8005005, 1, '2022-06-15 18:00:00', -1, 8005005, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8005006, 1, '2022-06-15 18:00:00', -1, 8005006, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8005007, 1, '2022-06-15 18:00:00', -1, 8005007, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8001001001, 1, '2022-06-15 18:00:00', -1, 8001001001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8001001002, 1, '2022-06-15 18:00:00', -1, 8001001002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8001001003, 1, '2022-06-15 18:00:00', -1, 8001001003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8001001004, 1, '2022-06-15 18:00:00', -1, 8001001004, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8001001005, 1, '2022-06-15 18:00:00', -1, 8001001005, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8001002001, 1, '2022-06-15 18:00:00', -1, 8001002001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8001002002, 1, '2022-06-15 18:00:00', -1, 8001002002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8001003001, 1, '2022-06-15 18:00:00', -1, 8001003001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8001003002, 1, '2022-06-15 18:00:00', -1, 8001003002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8001003003, 1, '2022-06-15 18:00:00', -1, 8001003003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8001004001, 1, '2022-06-15 18:00:00', -1, 8001004001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8001004002, 1, '2022-06-15 18:00:00', -1, 8001004002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8001004003, 1, '2022-06-15 18:00:00', -1, 8001004003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8002001001, 1, '2022-06-15 18:00:00', -1, 8002001001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8002001002, 1, '2022-06-15 18:00:00', -1, 8002001002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8002001003, 1, '2022-06-15 18:00:00', -1, 8002001003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8002001004, 1, '2022-06-15 18:00:00', -1, 8002001004, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8002001005, 1, '2022-06-15 18:00:00', -1, 8002001005, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8002001006, 1, '2022-06-15 18:00:00', -1, 8002001006, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8002001007, 1, '2022-06-15 18:00:00', -1, 8002001007, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8002001008, 1, '2022-06-15 18:00:00', -1, 8002001008, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8002001009, 1, '2022-06-15 18:00:00', -1, 8002001009, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8002001010, 1, '2022-06-15 18:00:00', -1, 8002001010, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8002002001, 1, '2022-06-15 18:00:00', -1, 8002002001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8002003001, 1, '2022-06-15 18:00:00', -1, 8002003001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8002004001, 1, '2022-06-15 18:00:00', -1, 8002004001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8002005001, 1, '2022-06-15 18:00:00', -1, 8002005001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8002006001, 1, '2022-06-15 18:00:00', -1, 8002006001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8003001001, 1, '2022-06-15 18:00:00', -1, 8003001001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8003001002, 1, '2022-06-15 18:00:00', -1, 8003001002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8003001003, 1, '2022-06-15 18:00:00', -1, 8003001003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8003001004, 1, '2022-06-15 18:00:00', -1, 8003001004, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8003001005, 1, '2022-06-15 18:00:00', -1, 8003001005, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8003002001, 1, '2022-06-15 18:00:00', -1, 8003002001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8003003001, 1, '2022-06-15 18:00:00', -1, 8003003001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8005001001, 1, '2022-06-15 18:00:00', -1, 8005001001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8005001002, 1, '2022-06-15 18:00:00', -1, 8005001002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8005002001, 1, '2022-06-15 18:00:00', -1, 8005002001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8005002002, 1, '2022-06-15 18:00:00', -1, 8005002002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8005003001, 1, '2022-06-15 18:00:00', -1, 8005003001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8005003002, 1, '2022-06-15 18:00:00', -1, 8005003002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8005004001, 1, '2022-06-15 18:00:00', -1, 8005004001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8005004002, 1, '2022-06-15 18:00:00', -1, 8005004002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8005005001, 1, '2022-06-15 18:00:00', -1, 8005005001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8005005002, 1, '2022-06-15 18:00:00', -1, 8005005002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8001001001001, 1, '2022-06-15 18:00:00', -1, 8001001001001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8001001001002, 1, '2022-06-15 18:00:00', -1, 8001001001002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8001001001003, 1, '2022-06-15 18:00:00', -1, 8001001001003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8001001001004, 1, '2022-06-15 18:00:00', -1, 8001001001004, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8001001002001, 1, '2022-06-15 18:00:00', -1, 8001001002001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8001001002002, 1, '2022-06-15 18:00:00', -1, 8001001002002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8001001002003, 1, '2022-06-15 18:00:00', -1, 8001001002003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8001001003001, 1, '2022-06-15 18:00:00', -1, 8001001003001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8001001003002, 1, '2022-06-15 18:00:00', -1, 8001001003002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8001001003003, 1, '2022-06-15 18:00:00', -1, 8001001003003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8001001004001, 1, '2022-06-15 18:00:00', -1, 8001001004001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8001001005001, 1, '2022-06-15 18:00:00', -1, 8001001005001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8001001005002, 1, '2022-06-15 18:00:00', -1, 8001001005002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8001001005003, 1, '2022-06-15 18:00:00', -1, 8001001005003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8001001005004, 1, '2022-06-15 18:00:00', -1, 8001001005004, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8001002001001, 1, '2022-06-15 18:00:00', -1, 8001002001001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8001002002001, 1, '2022-06-15 18:00:00', -1, 8001002002001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8001002002002, 1, '2022-06-15 18:00:00', -1, 8001002002002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8001002002003, 1, '2022-06-15 18:00:00', -1, 8001002002003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8001003001001, 1, '2022-06-15 18:00:00', -1, 8001003001001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8001003001002, 1, '2022-06-15 18:00:00', -1, 8001003001002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8001003001003, 1, '2022-06-15 18:00:00', -1, 8001003001003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8001003002001, 1, '2022-06-15 18:00:00', -1, 8001003002001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8001003002002, 1, '2022-06-15 18:00:00', -1, 8001003002002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8001003003001, 1, '2022-06-15 18:00:00', -1, 8001003003001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8001004001001, 1, '2022-06-15 18:00:00', -1, 8001004001001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8001004001002, 1, '2022-06-15 18:00:00', -1, 8001004001002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8001004002001, 1, '2022-06-15 18:00:00', -1, 8001004002001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8001004002002, 1, '2022-06-15 18:00:00', -1, 8001004002002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8001004003001, 1, '2022-06-15 18:00:00', -1, 8001004003001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8001004003002, 1, '2022-06-15 18:00:00', -1, 8001004003002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8003001001001, 1, '2022-06-15 18:00:00', -1, 8003001001001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8003001002001, 1, '2022-06-15 18:00:00', -1, 8003001002001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8003001002002, 1, '2022-06-15 18:00:00', -1, 8003001002002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8003001002003, 1, '2022-06-15 18:00:00', -1, 8003001002003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8003001003001, 1, '2022-06-15 18:00:00', -1, 8003001003001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8003001003002, 1, '2022-06-15 18:00:00', -1, 8003001003002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8003001003003, 1, '2022-06-15 18:00:00', -1, 8003001003003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8003001004001, 1, '2022-06-15 18:00:00', -1, 8003001004001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8003001004002, 1, '2022-06-15 18:00:00', -1, 8003001004002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8003001004003, 1, '2022-06-15 18:00:00', -1, 8003001004003, 1 ,"UTC" , "Asia/Shanghai");

REPLACE INTO `mds_role_resource` VALUES (8005008, 1, '2022-06-15 18:00:00', -1, 8005008, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8001007, 1, '2022-06-15 18:00:00', -1, 8001007, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8001007001, 1, '2022-06-15 18:00:00', -1, 8001007001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8001001006, 1, '2022-06-15 18:00:00', -1, 8001001006, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8001001007, 1, '2022-06-15 18:00:00', -1, 8001001007, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8002001011, 1, '2022-06-15 18:00:00', -1, 8002001011, 1 ,"UTC" , "Asia/Shanghai");


DELETE FROM `mds_role_resource` WHERE resource_id in (SELECT id FROM `mds_resource` WHERE sys_id = 8);

-- 管理 ,"UTC员 , "Asia/Shanghai8
REPLACE INTO `mds_role_resource` VALUES (88, 1, '2022-06-15 18:00:00', 8, 8, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88001, 1, '2022-06-15 18:00:00', 8, 8001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88002, 1, '2022-06-15 18:00:00', 8, 8002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88003, 1, '2022-06-15 18:00:00', 8, 8003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88004, 1, '2022-06-15 18:00:00', 8, 8004, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88005, 1, '2022-06-15 18:00:00', 8, 8005, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88001001, 1, '2022-06-15 18:00:00', 8, 8001001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88001002, 1, '2022-06-15 18:00:00', 8, 8001002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88001003, 1, '2022-06-15 18:00:00', 8, 8001003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88001004, 1, '2022-06-15 18:00:00', 8, 8001004, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88001005, 1, '2022-06-15 18:00:00', 8, 8001005, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88001006, 1, '2022-06-15 18:00:00', 8, 8001006, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88002001, 1, '2022-06-15 18:00:00', 8, 8002001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88002002, 1, '2022-06-15 18:00:00', 8, 8002002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88002003, 1, '2022-06-15 18:00:00', 8, 8002003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88002004, 1, '2022-06-15 18:00:00', 8, 8002004, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88002005, 1, '2022-06-15 18:00:00', 8, 8002005, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88002006, 1, '2022-06-15 18:00:00', 8, 8002006, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88002007, 1, '2022-06-15 18:00:00', 8, 8002007, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88003001, 1, '2022-06-15 18:00:00', 8, 8003001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88003002, 1, '2022-06-15 18:00:00', 8, 8003002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88003003, 1, '2022-06-15 18:00:00', 8, 8003003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88005001, 1, '2022-06-15 18:00:00', 8, 8005001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88005002, 1, '2022-06-15 18:00:00', 8, 8005002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88005003, 1, '2022-06-15 18:00:00', 8, 8005003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88005004, 1, '2022-06-15 18:00:00', 8, 8005004, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88005005, 1, '2022-06-15 18:00:00', 8, 8005005, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88005006, 1, '2022-06-15 18:00:00', 8, 8005006, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88005007, 1, '2022-06-15 18:00:00', 8, 8005007, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88001001001, 1, '2022-06-15 18:00:00', 8, 8001001001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88001001002, 1, '2022-06-15 18:00:00', 8, 8001001002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88001001003, 1, '2022-06-15 18:00:00', 8, 8001001003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88001001004, 1, '2022-06-15 18:00:00', 8, 8001001004, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88001001005, 1, '2022-06-15 18:00:00', 8, 8001001005, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88001002001, 1, '2022-06-15 18:00:00', 8, 8001002001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88001002002, 1, '2022-06-15 18:00:00', 8, 8001002002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88001003001, 1, '2022-06-15 18:00:00', 8, 8001003001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88001003002, 1, '2022-06-15 18:00:00', 8, 8001003002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88001003003, 1, '2022-06-15 18:00:00', 8, 8001003003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88001004001, 1, '2022-06-15 18:00:00', 8, 8001004001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88001004002, 1, '2022-06-15 18:00:00', 8, 8001004002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88001004003, 1, '2022-06-15 18:00:00', 8, 8001004003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88002001001, 1, '2022-06-15 18:00:00', 8, 8002001001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88002001002, 1, '2022-06-15 18:00:00', 8, 8002001002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88002001003, 1, '2022-06-15 18:00:00', 8, 8002001003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88002001004, 1, '2022-06-15 18:00:00', 8, 8002001004, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88002001005, 1, '2022-06-15 18:00:00', 8, 8002001005, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88002001006, 1, '2022-06-15 18:00:00', 8, 8002001006, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88002001007, 1, '2022-06-15 18:00:00', 8, 8002001007, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88002001008, 1, '2022-06-15 18:00:00', 8, 8002001008, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88002001009, 1, '2022-06-15 18:00:00', 8, 8002001009, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88002001010, 1, '2022-06-15 18:00:00', 8, 8002001010, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88002002001, 1, '2022-06-15 18:00:00', 8, 8002002001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88002003001, 1, '2022-06-15 18:00:00', 8, 8002003001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88002004001, 1, '2022-06-15 18:00:00', 8, 8002004001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88002005001, 1, '2022-06-15 18:00:00', 8, 8002005001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88002006001, 1, '2022-06-15 18:00:00', 8, 8002006001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88003001001, 1, '2022-06-15 18:00:00', 8, 8003001001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88003001002, 1, '2022-06-15 18:00:00', 8, 8003001002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88003001003, 1, '2022-06-15 18:00:00', 8, 8003001003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88003001004, 1, '2022-06-15 18:00:00', 8, 8003001004, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88003001005, 1, '2022-06-15 18:00:00', 8, 8003001005, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88003002001, 1, '2022-06-15 18:00:00', 8, 8003002001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88003003001, 1, '2022-06-15 18:00:00', 8, 8003003001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88005001001, 1, '2022-06-15 18:00:00', 8, 8005001001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88005001002, 1, '2022-06-15 18:00:00', 8, 8005001002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88005002001, 1, '2022-06-15 18:00:00', 8, 8005002001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88005002002, 1, '2022-06-15 18:00:00', 8, 8005002002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88005003001, 1, '2022-06-15 18:00:00', 8, 8005003001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88005003002, 1, '2022-06-15 18:00:00', 8, 8005003002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88005004001, 1, '2022-06-15 18:00:00', 8, 8005004001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88005004002, 1, '2022-06-15 18:00:00', 8, 8005004002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88005005001, 1, '2022-06-15 18:00:00', 8, 8005005001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88005005002, 1, '2022-06-15 18:00:00', 8, 8005005002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88001001001001, 1, '2022-06-15 18:00:00', 8, 8001001001001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88001001001002, 1, '2022-06-15 18:00:00', 8, 8001001001002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88001001001003, 1, '2022-06-15 18:00:00', 8, 8001001001003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88001001001004, 1, '2022-06-15 18:00:00', 8, 8001001001004, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88001001002001, 1, '2022-06-15 18:00:00', 8, 8001001002001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88001001002002, 1, '2022-06-15 18:00:00', 8, 8001001002002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88001001002003, 1, '2022-06-15 18:00:00', 8, 8001001002003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88001001003001, 1, '2022-06-15 18:00:00', 8, 8001001003001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88001001003002, 1, '2022-06-15 18:00:00', 8, 8001001003002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88001001003003, 1, '2022-06-15 18:00:00', 8, 8001001003003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88001001004001, 1, '2022-06-15 18:00:00', 8, 8001001004001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88001001005001, 1, '2022-06-15 18:00:00', 8, 8001001005001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88001001005002, 1, '2022-06-15 18:00:00', 8, 8001001005002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88001001005003, 1, '2022-06-15 18:00:00', 8, 8001001005003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88001001005004, 1, '2022-06-15 18:00:00', 8, 8001001005004, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88001002001001, 1, '2022-06-15 18:00:00', 8, 8001002001001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88001002002001, 1, '2022-06-15 18:00:00', 8, 8001002002001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88001002002002, 1, '2022-06-15 18:00:00', 8, 8001002002002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88001002002003, 1, '2022-06-15 18:00:00', 8, 8001002002003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88001003001001, 1, '2022-06-15 18:00:00', 8, 8001003001001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88001003001002, 1, '2022-06-15 18:00:00', 8, 8001003001002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88001003001003, 1, '2022-06-15 18:00:00', 8, 8001003001003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88001003002001, 1, '2022-06-15 18:00:00', 8, 8001003002001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88001003002002, 1, '2022-06-15 18:00:00', 8, 8001003002002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88001003003001, 1, '2022-06-15 18:00:00', 8, 8001003003001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88001004001001, 1, '2022-06-15 18:00:00', 8, 8001004001001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88001004001002, 1, '2022-06-15 18:00:00', 8, 8001004001002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88001004002001, 1, '2022-06-15 18:00:00', 8, 8001004002001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88001004002002, 1, '2022-06-15 18:00:00', 8, 8001004002002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88001004003001, 1, '2022-06-15 18:00:00', 8, 8001004003001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88001004003002, 1, '2022-06-15 18:00:00', 8, 8001004003002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88003001001001, 1, '2022-06-15 18:00:00', 8, 8003001001001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88003001002001, 1, '2022-06-15 18:00:00', 8, 8003001002001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88003001002002, 1, '2022-06-15 18:00:00', 8, 8003001002002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88003001002003, 1, '2022-06-15 18:00:00', 8, 8003001002003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88003001003001, 1, '2022-06-15 18:00:00', 8, 8003001003001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88003001003002, 1, '2022-06-15 18:00:00', 8, 8003001003002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88003001003003, 1, '2022-06-15 18:00:00', 8, 8003001003003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88003001004001, 1, '2022-06-15 18:00:00', 8, 8003001004001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88003001004002, 1, '2022-06-15 18:00:00', 8, 8003001004002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88003001004003, 1, '2022-06-15 18:00:00', 8, 8003001004003, 1 ,"UTC" , "Asia/Shanghai");

REPLACE INTO `mds_role_resource` VALUES (88005008, 1, '2022-06-15 18:00:00', 8, 8005008, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88001007, 1, '2022-06-15 18:00:00', 8, 8001007, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88001007001, 1, '2022-06-15 18:00:00', 8, 8001007001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88001001006, 1, '2022-06-15 18:00:00', 8, 8001001006, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (88001001007, 1, '2022-06-15 18:00:00', 8, 8001001007, 1 ,"UTC" , "Asia/Shanghai")  ;
REPLACE INTO `mds_role_resource` VALUES (88002001011, 1, '2022-06-15 18:00:00', 8, 8002001011, 1 ,"UTC" , "Asia/Shanghai");



-- 人力资源管理员80 ,"UTC0 , "Asia/Shanghai1
REPLACE INTO `mds_role_resource` VALUES (818001, 1, '2022-06-15 18:00:00', 8001, 8001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (818001002, 1, '2022-06-15 18:00:00', 8001, 8001002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (818001002001, 1, '2022-06-15 18:00:00', 8001, 8001002001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (818001002001001, 1, '2022-06-15 18:00:00', 8001, 8001002001001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (818001002002, 1, '2022-06-15 18:00:00', 8001, 8001002002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (818001002002001, 1, '2022-06-15 18:00:00', 8001, 8001002002001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (818001002002002, 1, '2022-06-15 18:00:00', 8001, 8001002002002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (818001002002003, 1, '2022-06-15 18:00:00', 8001, 8001002002003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (818001003, 1, '2022-06-15 18:00:00', 8001, 8001003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (818001003001, 1, '2022-06-15 18:00:00', 8001, 8001003001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (818001003001001, 1, '2022-06-15 18:00:00', 8001, 8001003001001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (818001003001002, 1, '2022-06-15 18:00:00', 8001, 8001003001002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (818001003002, 1, '2022-06-15 18:00:00', 8001, 8001003002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (818001003002001, 1, '2022-06-15 18:00:00', 8001, 8001003002001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (818001003002002, 1, '2022-06-15 18:00:00', 8001, 8001003002002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (818002, 1, '2022-06-15 18:00:00', 8001, 8002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (818002001, 1, '2022-06-15 18:00:00', 8001, 8002001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (818002001003, 1, '2022-06-15 18:00:00', 8001, 8002001003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (818002004, 1, '2022-06-15 18:00:00', 8001, 8002004, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (818002004001, 1, '2022-06-15 18:00:00', 8001, 8002004001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (818002007, 1, '2022-06-15 18:00:00', 8001, 8002007, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (818003, 1, '2022-06-15 18:00:00', 8001, 8003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (818003001, 1, '2022-06-15 18:00:00', 8001, 8003001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (818003001001, 1, '2022-06-15 18:00:00', 8001, 8003001001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (818003001001001, 1, '2022-06-15 18:00:00', 8001, 8003001001001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (818003002, 1, '2022-06-15 18:00:00', 8001, 8003002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (818003002001, 1, '2022-06-15 18:00:00', 8001, 8003002001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (818003003, 1, '2022-06-15 18:00:00', 8001, 8003003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (818004, 1, '2022-06-15 18:00:00', 8001, 8004, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (818, 1, '2022-06-15 18:00:00', 8001, 8, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80018005, 1, '2022-06-15 18:00:00', 8001, 8005, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80018005001, 1, '2022-06-15 18:00:00', 8001, 8005001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80018005002, 1, '2022-06-15 18:00:00', 8001, 8005002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80018005003, 1, '2022-06-15 18:00:00', 8001, 8005003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80018005004, 1, '2022-06-15 18:00:00', 8001, 8005004, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80018005005, 1, '2022-06-15 18:00:00', 8001, 8005005, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80018005006, 1, '2022-06-15 18:00:00', 8001, 8005006, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80018005007, 1, '2022-06-15 18:00:00', 8001, 8005007, 1 ,"UTC" , "Asia/Shanghai");

-- 合同进度管理人员80 ,"UTC0 , "Asia/Shanghai4
REPLACE INTO `mds_role_resource` VALUES (848001, 1, '2022-06-15 18:00:00', 8004, 8001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848001001, 1, '2022-06-15 18:00:00', 8004, 8001001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848001001001, 1, '2022-06-15 18:00:00', 8004, 8001001001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848001001001001, 1, '2022-06-15 18:00:00', 8004, 8001001001001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848001001001002, 1, '2022-06-15 18:00:00', 8004, 8001001001002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848001001001003, 1, '2022-06-15 18:00:00', 8004, 8001001001003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848001001001004, 1, '2022-06-15 18:00:00', 8004, 8001001001004, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848001001002, 1, '2022-06-15 18:00:00', 8004, 8001001002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848001001002001, 1, '2022-06-15 18:00:00', 8004, 8001001002001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848001001002002, 1, '2022-06-15 18:00:00', 8004, 8001001002002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848001001002003, 1, '2022-06-15 18:00:00', 8004, 8001001002003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848001001003, 1, '2022-06-15 18:00:00', 8004, 8001001003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848001001003001, 1, '2022-06-15 18:00:00', 8004, 8001001003001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848001001003002, 1, '2022-06-15 18:00:00', 8004, 8001001003002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848001001003003, 1, '2022-06-15 18:00:00', 8004, 8001001003003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848001001004, 1, '2022-06-15 18:00:00', 8004, 8001001004, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848001001004001, 1, '2022-06-15 18:00:00', 8004, 8001001004001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848001001005, 1, '2022-06-15 18:00:00', 8004, 8001001005, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848001001005001, 1, '2022-06-15 18:00:00', 8004, 8001001005001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848001001005002, 1, '2022-06-15 18:00:00', 8004, 8001001005002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848001001005003, 1, '2022-06-15 18:00:00', 8004, 8001001005003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848001001005004, 1, '2022-06-15 18:00:00', 8004, 8001001005004, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848001003, 1, '2022-06-15 18:00:00', 8004, 8001003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848001003001, 1, '2022-06-15 18:00:00', 8004, 8001003001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848001003001001, 1, '2022-06-15 18:00:00', 8004, 8001003001001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848001003001002, 1, '2022-06-15 18:00:00', 8004, 8001003001002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848001003002, 1, '2022-06-15 18:00:00', 8004, 8001003002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848001003002001, 1, '2022-06-15 18:00:00', 8004, 8001003002001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848001003002002, 1, '2022-06-15 18:00:00', 8004, 8001003002002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848001003003, 1, '2022-06-15 18:00:00', 8004, 8001003003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848001003003001, 1, '2022-06-15 18:00:00', 8004, 8001003003001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848001004, 1, '2022-06-15 18:00:00', 8004, 8001004, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848001004002, 1, '2022-06-15 18:00:00', 8004, 8001004002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848001004002001, 1, '2022-06-15 18:00:00', 8004, 8001004002001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848001004002002, 1, '2022-06-15 18:00:00', 8004, 8001004002002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848001004003, 1, '2022-06-15 18:00:00', 8004, 8001004003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848001004003001, 1, '2022-06-15 18:00:00', 8004, 8001004003001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848001004003002, 1, '2022-06-15 18:00:00', 8004, 8001004003002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848002, 1, '2022-06-15 18:00:00', 8004, 8002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848002001, 1, '2022-06-15 18:00:00', 8004, 8002001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848002001001, 1, '2022-06-15 18:00:00', 8004, 8002001001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848002001002, 1, '2022-06-15 18:00:00', 8004, 8002001002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848002001003, 1, '2022-06-15 18:00:00', 8004, 8002001003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848002001004, 1, '2022-06-15 18:00:00', 8004, 8002001004, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848002001005, 1, '2022-06-15 18:00:00', 8004, 8002001005, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848002001006, 1, '2022-06-15 18:00:00', 8004, 8002001006, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848002001007, 1, '2022-06-15 18:00:00', 8004, 8002001007, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848002001008, 1, '2022-06-15 18:00:00', 8004, 8002001008, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848002001009, 1, '2022-06-15 18:00:00', 8004, 8002001009, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848002001010, 1, '2022-06-15 18:00:00', 8004, 8002001010, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848002002, 1, '2022-06-15 18:00:00', 8004, 8002002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848002002001, 1, '2022-06-15 18:00:00', 8004, 8002002001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848002003, 1, '2022-06-15 18:00:00', 8004, 8002003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848002003001, 1, '2022-06-15 18:00:00', 8004, 8002003001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848002007, 1, '2022-06-15 18:00:00', 8004, 8002007, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848003, 1, '2022-06-15 18:00:00', 8004, 8003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848003001, 1, '2022-06-15 18:00:00', 8004, 8003001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848003001001, 1, '2022-06-15 18:00:00', 8004, 8003001001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848003001001001, 1, '2022-06-15 18:00:00', 8004, 8003001001001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848003002, 1, '2022-06-15 18:00:00', 8004, 8003002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848003002001, 1, '2022-06-15 18:00:00', 8004, 8003002001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848003003, 1, '2022-06-15 18:00:00', 8004, 8003003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848004, 1, '2022-06-15 18:00:00', 8004, 8004, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (848, 1, '2022-06-15 18:00:00', 8004, 8, 1 ,"UTC" , "Asia/Shanghai");


REPLACE INTO `mds_role_resource` VALUES (80048005, 1, '2022-06-15 18:00:00', 8004, 8005, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80048005001, 1, '2022-06-15 18:00:00', 8004, 8005001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80048005002, 1, '2022-06-15 18:00:00', 8004, 8005002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80048005003, 1, '2022-06-15 18:00:00', 8004, 8005003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80048005004, 1, '2022-06-15 18:00:00', 8004, 8005004, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80048005005, 1, '2022-06-15 18:00:00', 8004, 8005005, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80048005006, 1, '2022-06-15 18:00:00', 8004, 8005006, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80048005007, 1, '2022-06-15 18:00:00', 8004, 8005007, 1 ,"UTC" , "Asia/Shanghai");

REPLACE INTO `mds_role_resource` VALUES (80048001007, 1, '2022-06-15 18:00:00', 8004, 8001007, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80048001007001, 1, '2022-06-15 18:00:00', 8004, 8001007001, 1 ,"UTC" , "Asia/Shanghai");


-- 项目总监80 ,"UTC2 , "Asia/Shanghai8
REPLACE INTO `mds_role_resource` VALUES (8288002, 1, '2022-06-15 18:00:00', 8028, 8002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8288002001, 1, '2022-06-15 18:00:00', 8028, 8002001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8288002001007, 1, '2022-06-15 18:00:00', 8028, 8002001007, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8288002002, 1, '2022-06-15 18:00:00', 8028, 8002002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8288002002001, 1, '2022-06-15 18:00:00', 8028, 8002002001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8288002003, 1, '2022-06-15 18:00:00', 8028, 8002003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8288002003001, 1, '2022-06-15 18:00:00', 8028, 8002003001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8288002006, 1, '2022-06-15 18:00:00', 8028, 8002006,+ 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8288002006001, 1, '2022-06-15 18:00:00', 8028, 8002006001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8288003, 1, '2022-06-15 18:00:00', 8028, 8003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8288003001, 1, '2022-06-15 18:00:00', 8028, 8003001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8288003001001, 1, '2022-06-15 18:00:00', 8028, 8003001001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8288003001001001, 1, '2022-06-15 18:00:00', 8028, 8003001001001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8288003001003, 1, '2022-06-15 18:00:00', 8028, 8003001003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8288003001003001, 1, '2022-06-15 18:00:00', 8028, 8003001003001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8288003002, 1, '2022-06-15 18:00:00', 8028, 8003002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8288003002001, 1, '2022-06-15 18:00:00', 8028, 8003002001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8288003003, 1, '2022-06-15 18:00:00', 8028, 8003003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8288003003001, 1, '2022-06-15 18:00:00', 8028, 8003003001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8288004, 1, '2022-06-15 18:00:00', 8028, 8004, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8288, 1, '2022-06-15 18:00:00', 8028, 8, 1 ,"UTC" , "Asia/Shanghai");


-- 项目副总监80 ,"UTC3 , "Asia/Shanghai0
REPLACE INTO `mds_role_resource` VALUES (8308002, 1, '2022-06-15 18:00:00', 8030, 8002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8308002006, 1, '2022-06-15 18:00:00', 8030, 8002006, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8308002006001, 1, '2022-06-15 18:00:00', 8030, 8002006001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8308003, 1, '2022-06-15 18:00:00', 8030, 8003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8308003001, 1, '2022-06-15 18:00:00', 8030, 8003001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8308003001001, 1, '2022-06-15 18:00:00', 8030, 8003001001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8308003001001001, 1, '2022-06-15 18:00:00', 8030, 8003001001001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8308003002, 1, '2022-06-15 18:00:00', 8030, 8003002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8308003002001, 1, '2022-06-15 18:00:00', 8030, 8003002001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8308003003, 1, '2022-06-15 18:00:00', 8030, 8003003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8308004, 1, '2022-06-15 18:00:00', 8030, 8004, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8308, 1, '2022-06-15 18:00:00', 8030, 8, 1 ,"UTC" , "Asia/Shanghai");

-- 项目经理80 ,"UTC0 , "Asia/Shanghai2
REPLACE INTO `mds_role_resource` VALUES (828002, 1, '2022-06-15 18:00:00', 8002, 8002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (828002001, 1, '2022-06-15 18:00:00', 8002, 8002001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (828002001007, 1, '2022-06-15 18:00:00', 8002, 8002001007, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (828002002, 1, '2022-06-15 18:00:00', 8002, 8002002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (828002002001, 1, '2022-06-15 18:00:00', 8002, 8002002001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (828002003, 1, '2022-06-15 18:00:00', 8002, 8002003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (828002003001, 1, '2022-06-15 18:00:00', 8002, 8002003001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (828002004, 1, '2022-06-15 18:00:00', 8002, 8002004, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (828002004001, 1, '2022-06-15 18:00:00', 8002, 8002004001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (828002006, 1, '2022-06-15 18:00:00', 8002, 8002006, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (828002006001, 1, '2022-06-15 18:00:00', 8002, 8002006001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (828003, 1, '2022-06-15 18:00:00', 8002, 8003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (828003001, 1, '2022-06-15 18:00:00', 8002, 8003001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (828003001001, 1, '2022-06-15 18:00:00', 8002, 8003001001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (828003001001001, 1, '2022-06-15 18:00:00', 8002, 8003001001001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (828003001003, 1, '2022-06-15 18:00:00', 8002, 8003001003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (828003001003001, 1, '2022-06-15 18:00:00', 8002, 8003001003001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (828003002, 1, '2022-06-15 18:00:00', 8002, 8003002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (828003002001, 1, '2022-06-15 18:00:00', 8002, 8003002001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (828003003, 1, '2022-06-15 18:00:00', 8002, 8003003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (828004, 1, '2022-06-15 18:00:00', 8002, 8004, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (828, 1, '2022-06-15 18:00:00', 8002, 8, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80028005, 1, '2022-06-15 18:00:00', 8002, 8005, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80028005002, 1, '2022-06-15 18:00:00', 8002, 8005002, 1 ,"UTC" , "Asia/Shanghai");

-- 临床试验助理80 ,"UTC0 , "Asia/Shanghai6
REPLACE INTO `mds_role_resource` VALUES (868002, 1, '2022-06-15 18:00:00', 8006, 8002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (868002006, 1, '2022-06-15 18:00:00', 8006, 8002006, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (868002006001, 1, '2022-06-15 18:00:00', 8006, 8002006001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (868003, 1, '2022-06-15 18:00:00', 8006, 8003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (868003001, 1, '2022-06-15 18:00:00', 8006, 8003001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (868003001001, 1, '2022-06-15 18:00:00', 8006, 8003001001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (868003001001001, 1, '2022-06-15 18:00:00', 8006, 8003001001001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (868003002, 1, '2022-06-15 18:00:00', 8006, 8003002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (868003002001, 1, '2022-06-15 18:00:00', 8006, 8003002001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (868, 1, '2022-06-15 18:00:00', 8006, 8, 1 ,"UTC" , "Asia/Shanghai");

-- 临床试验监查员80 ,"UTC0 , "Asia/Shanghai3
REPLACE INTO `mds_role_resource` VALUES (838002, 1, '2022-06-15 18:00:00', 8003, 8002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (838003, 1, '2022-06-15 18:00:00', 8003, 8003, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (838003001, 1, '2022-06-15 18:00:00', 8003, 8003001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (838003001001, 1, '2022-06-15 18:00:00', 8003, 8003001001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (838003001001001, 1, '2022-06-15 18:00:00', 8003, 8003001001001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (838003002, 1, '2022-06-15 18:00:00', 8003, 8003002, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (838003002001, 1, '2022-06-15 18:00:00', 8003, 8003002001, 1 ,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (838, 1, '2022-06-15 18:00:00', 8003, 8, 1 ,"UTC" , "Asia/Shanghai");

-- 非盲态项目经理8038
REPLACE INTO `mds_role_resource` VALUES (8388002, 1, '2022-06-15 18:00:00', 8038, 8002, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8388002001, 1, '2022-06-15 18:00:00', 8038, 8002001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8388002001007, 1, '2022-06-15 18:00:00', 8038, 8002001007, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8388002002, 1, '2022-06-15 18:00:00', 8038, 8002002, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8388002002001, 1, '2022-06-15 18:00:00', 8038, 8002002001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8388002003, 1, '2022-06-15 18:00:00', 8038, 8002003, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8388002003001, 1, '2022-06-15 18:00:00', 8038, 8002003001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8388003, 1, '2022-06-15 18:00:00', 8038, 8003, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8388003001, 1, '2022-06-15 18:00:00', 8038, 8003001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8388003001001, 1, '2022-06-15 18:00:00', 8038, 8003001001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8388003001001001, 1, '2022-06-15 18:00:00', 8038, 8003001001001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8388003001002, 1, '2022-06-15 18:00:00', 8038, 8003001002, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8388003001002001, 1, '2022-06-15 18:00:00', 8038, 8003001002001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8388003001003, 1, '2022-06-15 18:00:00', 8038, 8003001003, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8388003001003001, 1, '2022-06-15 18:00:00', 8038, 8003001003001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8388003002, 1, '2022-06-15 18:00:00', 8038, 8003002, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8388003002001, 1, '2022-06-15 18:00:00', 8038, 8003002001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8388004, 1, '2022-06-15 18:00:00', 8038, 8004, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8388, 1, '2022-06-15 18:00:00', 8038, 8, 1,"UTC" , "Asia/Shanghai");

-- 非盲态临床监查员80,"UTC" , "Asia/Shanghai"39
REPLACE INTO `mds_role_resource` VALUES (8398002, 1, '2022-06-15 18:00:00', 8039, 8002, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8398003, 1, '2022-06-15 18:00:00', 8039, 8003, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8398003001, 1, '2022-06-15 18:00:00', 8039, 8003001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8398003001001, 1, '2022-06-15 18:00:00', 8039, 8003001001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8398003001001001, 1, '2022-06-15 18:00:00', 8039, 8003001001001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8398003002, 1, '2022-06-15 18:00:00', 8039, 8003002, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8398003002001, 1, '2022-06-15 18:00:00', 8039, 8003002001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8398, 1, '2022-06-15 18:00:00', 8039, 8, 1,"UTC" , "Asia/Shanghai");

-- 非盲态临床试验助理80,"UTC" , "Asia/Shanghai"40
REPLACE INTO `mds_role_resource` VALUES (8408002, 1, '2022-06-15 18:00:00', 8040, 8002, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8408003, 1, '2022-06-15 18:00:00', 8040, 8003, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8408003001, 1, '2022-06-15 18:00:00', 8040, 8003001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8408003001001, 1, '2022-06-15 18:00:00', 8040, 8003001001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8408003001001001, 1, '2022-06-15 18:00:00', 8040, 8003001001001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8408003002, 1, '2022-06-15 18:00:00', 8040, 8003002, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8408003002001, 1, '2022-06-15 18:00:00', 8040, 8003002001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8408, 1, '2022-06-15 18:00:00', 8040, 8, 1,"UTC" , "Asia/Shanghai");

-- 供应链管理经理80,"UTC" , "Asia/Shanghai"10
REPLACE INTO `mds_role_resource` VALUES (8108002, 1, '2022-06-15 18:00:00', 8010, 8002, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8108003, 1, '2022-06-15 18:00:00', 8010, 8003, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8108003001, 1, '2022-06-15 18:00:00', 8010, 8003001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8108003001001, 1, '2022-06-15 18:00:00', 8010, 8003001001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8108003001001001, 1, '2022-06-15 18:00:00', 8010, 8003001001001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8108003002, 1, '2022-06-15 18:00:00', 8010, 8003002, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8108003002001, 1, '2022-06-15 18:00:00', 8010, 8003002001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8108, 1, '2022-06-15 18:00:00', 8010, 8, 1,"UTC" , "Asia/Shanghai") ;

-- 供应链专员8026
REPLACE INTO `mds_role_resource` VALUES (8268002, 1, '2022-06-15 18:00:00', 8026, 8002, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8268003, 1, '2022-06-15 18:00:00', 8026, 8003, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8268003001, 1, '2022-06-15 18:00:00', 8026, 8003001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8268003001001, 1, '2022-06-15 18:00:00', 8026, 8003001001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8268003001001001, 1, '2022-06-15 18:00:00', 8026, 8003001001001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8268003002, 1, '2022-06-15 18:00:00', 8026, 8003002, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8268003002001, 1, '2022-06-15 18:00:00', 8026, 8003002001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8268, 1, '2022-06-15 18:00:00', 8026, 8, 1,"UTC" , "Asia/Shanghai") ;

-- 药品管理员8013
REPLACE INTO `mds_role_resource` VALUES (8138002, 1, '2022-06-15 18:00:00', 8013, 8002, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8138003, 1, '2022-06-15 18:00:00', 8013, 8003, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8138003001, 1, '2022-06-15 18:00:00', 8013, 8003001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8138003001001, 1, '2022-06-15 18:00:00', 8013, 8003001001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8138003001001001, 1, '2022-06-15 18:00:00', 8013, 8003001001001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8138003002, 1, '2022-06-15 18:00:00', 8013, 8003002, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8138003002001, 1, '2022-06-15 18:00:00', 8013, 8003002001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8138, 1, '2022-06-15 18:00:00', 8013, 8, 1,"UTC" , "Asia/Shanghai");

-- 供应商管理经理80,"UTC" , "Asia/Shanghai"11
REPLACE INTO `mds_role_resource` VALUES (8118002, 1, '2022-06-15 18:00:00', 8011, 8002, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8118003, 1, '2022-06-15 18:00:00', 8011, 8003, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8118003001, 1, '2022-06-15 18:00:00', 8011, 8003001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8118003001001, 1, '2022-06-15 18:00:00', 8011, 8003001001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8118003001001001, 1, '2022-06-15 18:00:00', 8011, 8003001001001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8118003002, 1, '2022-06-15 18:00:00', 8011, 8003002, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8118003002001, 1, '2022-06-15 18:00:00', 8011, 8003002001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8118, 1, '2022-06-15 18:00:00', 8011, 8, 1,"UTC" , "Asia/Shanghai");

-- 临床运营副总监80,"UTC" , "Asia/Shanghai"12
REPLACE INTO `mds_role_resource` VALUES (8128002, 1, '2022-06-15 18:00:00', 8012, 8002, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8128003, 1, '2022-06-15 18:00:00', 8012, 8003, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8128003001, 1, '2022-06-15 18:00:00', 8012, 8003001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8128003001001, 1, '2022-06-15 18:00:00', 8012, 8003001001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8128003001001001, 1, '2022-06-15 18:00:00', 8012, 8003001001001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8128003002, 1, '2022-06-15 18:00:00', 8012, 8003002, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8128003002001, 1, '2022-06-15 18:00:00', 8012, 8003002001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8128, 1, '2022-06-15 18:00:00', 8012, 8, 1,"UTC" , "Asia/Shanghai");

-- 质量合规经理80,"UTC" , "Asia/Shanghai"12
REPLACE INTO `mds_role_resource` VALUES (8148002, 1, '2022-06-15 18:00:00', 8014, 8002, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8148003, 1, '2022-06-15 18:00:00', 8014, 8003, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8148003001, 1, '2022-06-15 18:00:00', 8014, 8003001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8148003001001, 1, '2022-06-15 18:00:00', 8014, 8003001001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8148003001001001, 1, '2022-06-15 18:00:00', 8014, 8003001001001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8148003002, 1, '2022-06-15 18:00:00', 8014, 8003002, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8148003002001, 1, '2022-06-15 18:00:00', 8014, 8003002001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8148, 1, '2022-06-15 18:00:00', 8014, 8, 1,"UTC" , "Asia/Shanghai");

-- 质量控制8019
REPLACE INTO `mds_role_resource` VALUES (8198002, 1, '2022-06-15 18:00:00', 8019, 8002, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8198003, 1, '2022-06-15 18:00:00', 8019, 8003, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8198003001, 1, '2022-06-15 18:00:00', 8019, 8003001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8198003001001, 1, '2022-06-15 18:00:00', 8019, 8003001001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8198003001001001, 1, '2022-06-15 18:00:00', 8019, 8003001001001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8198003002, 1, '2022-06-15 18:00:00', 8019, 8003002, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8198003002001, 1, '2022-06-15 18:00:00', 8019, 8003002001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8198, 1, '2022-06-15 18:00:00', 8019, 8, 1,"UTC" , "Asia/Shanghai");

-- 质量保证8020
REPLACE INTO `mds_role_resource` VALUES (8208002, 1, '2022-06-15 18:00:00', 8020, 8002, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8208003, 1, '2022-06-15 18:00:00', 8020, 8003, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8208003001, 1, '2022-06-15 18:00:00', 8020, 8003001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8208003001001, 1, '2022-06-15 18:00:00', 8020, 8003001001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8208003001001001, 1, '2022-06-15 18:00:00', 8020, 8003001001001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8208003002, 1, '2022-06-15 18:00:00', 8020, 8003002, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8208003002001, 1, '2022-06-15 18:00:00', 8020, 8003002001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8208, 1, '2022-06-15 18:00:00', 8020, 8, 1,"UTC" , "Asia/Shanghai");

-- 临床质量合规与培训助理80,"UTC" , "Asia/Shanghai"31
REPLACE INTO `mds_role_resource` VALUES (8318002, 1, '2022-06-15 18:00:00', 8031, 8002, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8318003, 1, '2022-06-15 18:00:00', 8031, 8003, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8318003001, 1, '2022-06-15 18:00:00', 8031, 8003001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8318003001001, 1, '2022-06-15 18:00:00', 8031, 8003001001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8318003001001001, 1, '2022-06-15 18:00:00', 8031, 8003001001001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8318003002, 1, '2022-06-15 18:00:00', 8031, 8003002, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8318003002001, 1, '2022-06-15 18:00:00', 8031, 8003002001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8318, 1, '2022-06-15 18:00:00', 8031, 8, 1,"UTC" , "Asia/Shanghai");

-- 培训经理8033
REPLACE INTO `mds_role_resource` VALUES (8338002, 1, '2022-06-15 18:00:00', 8033, 8002, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8338003, 1, '2022-06-15 18:00:00', 8033, 8003, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8338003001, 1, '2022-06-15 18:00:00', 8033, 8003001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8338003001001, 1, '2022-06-15 18:00:00', 8033, 8003001001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8338003001001001, 1, '2022-06-15 18:00:00', 8033, 8003001001001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8338003002, 1, '2022-06-15 18:00:00', 8033, 8003002, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8338003002001, 1, '2022-06-15 18:00:00', 8033, 8003002001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8338, 1, '2022-06-15 18:00:00', 8033, 8, 1,"UTC" , "Asia/Shanghai");

-- 遗传办负责人80,"UTC" , "Asia/Shanghai"21
REPLACE INTO `mds_role_resource` VALUES (8218002, 1, '2022-06-15 18:00:00', 8021, 8002, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8218003, 1, '2022-06-15 18:00:00', 8021, 8003, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8218003001, 1, '2022-06-15 18:00:00', 8021, 8003001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8218003001001, 1, '2022-06-15 18:00:00', 8021, 8003001001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8218003001001001, 1, '2022-06-15 18:00:00', 8021, 8003001001001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8218003002, 1, '2022-06-15 18:00:00', 8021, 8003002, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8218003002001, 1, '2022-06-15 18:00:00', 8021, 8003002001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8218, 1, '2022-06-15 18:00:00', 8021, 8, 1,"UTC" , "Asia/Shanghai") ;

-- 遗传办专员8022
REPLACE INTO `mds_role_resource` VALUES (8228002, 1, '2022-06-15 18:00:00', 8022, 8002, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8228003, 1, '2022-06-15 18:00:00', 8022, 8003, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8228003001, 1, '2022-06-15 18:00:00', 8022, 8003001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8228003001001, 1, '2022-06-15 18:00:00', 8022, 8003001001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8228003001001001, 1, '2022-06-15 18:00:00', 8022, 8003001001001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8228003002, 1, '2022-06-15 18:00:00', 8022, 8003002, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8228003002001, 1, '2022-06-15 18:00:00', 8022, 8003002001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8228, 1, '2022-06-15 18:00:00', 8022, 8, 1,"UTC" , "Asia/Shanghai");

-- 临床研究经理80,"UTC" , "Asia/Shanghai"27
REPLACE INTO `mds_role_resource` VALUES (8278002, 1, '2022-06-15 18:00:00', 8027, 8002, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8278003, 1, '2022-06-15 18:00:00', 8027, 8003, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8278003001, 1, '2022-06-15 18:00:00', 8027, 8003001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8278003001001, 1, '2022-06-15 18:00:00', 8027, 8003001001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8278003001001001, 1, '2022-06-15 18:00:00', 8027, 8003001001001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8278003002, 1, '2022-06-15 18:00:00', 8027, 8003002, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8278003002001, 1, '2022-06-15 18:00:00', 8027, 8003002001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8278, 1, '2022-06-15 18:00:00', 8027, 8, 1,"UTC" , "Asia/Shanghai");

-- 区域中心管理80,"UTC" , "Asia/Shanghai"29
REPLACE INTO `mds_role_resource` VALUES (8298002, 1, '2022-06-15 18:00:00', 8029, 8002, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8298003, 1, '2022-06-15 18:00:00', 8029, 8003, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8298003001, 1, '2022-06-15 18:00:00', 8029, 8003001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8298003001001, 1, '2022-06-15 18:00:00', 8029, 8003001001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8298003001001001, 1, '2022-06-15 18:00:00', 8029, 8003001001001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8298003002, 1, '2022-06-15 18:00:00', 8029, 8003002, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8298003002001, 1, '2022-06-15 18:00:00', 8029, 8003002001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8298, 1, '2022-06-15 18:00:00', 8029, 8, 1,"UTC" , "Asia/Shanghai");

-- 系统支持专员80,"UTC" , "Asia/Shanghai"36
REPLACE INTO `mds_role_resource` VALUES (8368002, 1, '2022-06-15 18:00:00', 8036, 8002, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8368003, 1, '2022-06-15 18:00:00', 8036, 8003, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8368003001, 1, '2022-06-15 18:00:00', 8036, 8003001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8368003001001, 1, '2022-06-15 18:00:00', 8036, 8003001001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8368003001001001, 1, '2022-06-15 18:00:00', 8036, 8003001001001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8368003002, 1, '2022-06-15 18:00:00', 8036, 8003002, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8368003002001, 1, '2022-06-15 18:00:00', 8036, 8003002001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8368, 1, '2022-06-15 18:00:00', 8036, 8, 1,"UTC" , "Asia/Shanghai");

-- 系统支持经理80,"UTC" , "Asia/Shanghai"37
REPLACE INTO `mds_role_resource` VALUES (8378002, 1, '2022-06-15 18:00:00', 8037, 8002, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8378003, 1, '2022-06-15 18:00:00', 8037, 8003, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8378003001, 1, '2022-06-15 18:00:00', 8037, 8003001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8378003001001, 1, '2022-06-15 18:00:00', 8037, 8003001001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8378003001001001, 1, '2022-06-15 18:00:00', 8037, 8003001001001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8378003002, 1, '2022-06-15 18:00:00', 8037, 8003002, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8378003002001, 1, '2022-06-15 18:00:00', 8037, 8003002001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8378, 1, '2022-06-15 18:00:00', 8037, 8, 1,"UTC" , "Asia/Shanghai");

-- 文件经理8041
REPLACE INTO `mds_role_resource` VALUES (8418002, 1, '2022-06-15 18:00:00', 8041, 8002, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8418003, 1, '2022-06-15 18:00:00', 8041, 8003, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8418003001, 1, '2022-06-15 18:00:00', 8041, 8003001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8418003001001, 1, '2022-06-15 18:00:00', 8041, 8003001001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8418003001001001, 1, '2022-06-15 18:00:00', 8041, 8003001001001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8418003002, 1, '2022-06-15 18:00:00', 8041, 8003002, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8418003002001, 1, '2022-06-15 18:00:00', 8041, 8003002001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8418, 1, '2022-06-15 18:00:00', 8041, 8, 1,"UTC" , "Asia/Shanghai");

-- 部门助理8032
REPLACE INTO `mds_role_resource` VALUES (8328002, 1, '2022-06-15 18:00:00', 8032, 8002, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8328003, 1, '2022-06-15 18:00:00', 8032, 8003, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8328003001, 1, '2022-06-15 18:00:00', 8032, 8003001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8328003001001, 1, '2022-06-15 18:00:00', 8032, 8003001001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8328003001001001, 1, '2022-06-15 18:00:00', 8032, 8003001001001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8328003002, 1, '2022-06-15 18:00:00', 8032, 8003002, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8328003002001, 1, '2022-06-15 18:00:00', 8032, 8003002001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8328, 1, '2022-06-15 18:00:00', 8032, 8, 1,"UTC" , "Asia/Shanghai");

-- 临床支持经理80,"UTC" , "Asia/Shanghai"43
REPLACE INTO `mds_role_resource` VALUES (8438002, 1, '2022-06-15 18:00:00', 8043, 8002, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8438003, 1, '2022-06-15 18:00:00', 8043, 8003, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8438003001, 1, '2022-06-15 18:00:00', 8043, 8003001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8438003001001, 1, '2022-06-15 18:00:00', 8043, 8003001001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8438003001001001, 1, '2022-06-15 18:00:00', 8043, 8003001001001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8438003002, 1, '2022-06-15 18:00:00', 8043, 8003002, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8438003002001, 1, '2022-06-15 18:00:00', 8043, 8003002001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8438, 1, '2022-06-15 18:00:00', 8043, 8, 1,"UTC" , "Asia/Shanghai") ;

-- 遗传办经理8044
REPLACE INTO `mds_role_resource` VALUES (8448002, 1, '2022-06-15 18:00:00', 8044, 8002, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8448003, 1, '2022-06-15 18:00:00', 8044, 8003, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8448003001, 1, '2022-06-15 18:00:00', 8044, 8003001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8448003001001, 1, '2022-06-15 18:00:00', 8044, 8003001001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8448003001001001, 1, '2022-06-15 18:00:00', 8044, 8003001001001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8448003002, 1, '2022-06-15 18:00:00', 8044, 8003002, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8448003002001, 1, '2022-06-15 18:00:00', 8044, 8003002001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8448, 1, '2022-06-15 18:00:00', 8044, 8, 1,"UTC" , "Asia/Shanghai");

-- 直线经理8042
REPLACE INTO `mds_role_resource` VALUES (8428002, 1, '2022-07-04 06:04:59', 8042, 8002, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8428002005, 1, '2022-07-04 06:04:59', 8042, 8002005, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8428002005001, 1, '2022-07-04 06:04:59', 8042, 8002005001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8428003, 1, '2022-07-04 06:04:59', 8042, 8003, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8428003001, 1, '2022-07-04 06:04:59', 8042, 8003001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8428003001001, 1, '2022-07-04 06:04:59', 8042, 8003001001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8428003001001001, 1, '2022-07-04 06:04:59', 8042, 8003001001001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8428003001002, 1, '2022-07-04 06:04:59', 8042, 8003001002, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8428003001002001, 1, '2022-07-04 06:04:59', 8042, 8003001002001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8428003001002002, 1, '2022-07-04 06:04:59', 8042, 8003001002002, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8428003001002003, 1, '2022-07-04 06:04:59', 8042, 8003001002003, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8428003002, 1, '2022-07-04 06:04:59', 8042, 8003002, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8428003002001, 1, '2022-07-04 06:04:59', 8042, 8003002001, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8428003003, 1, '2022-07-04 06:04:59', 8042, 8003003, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8428004, 1, '2022-07-04 06:04:59', 8042, 8004, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (8428, 1, '2022-07-04 06:04:59', 8042, 8, 1,"UTC" , "Asia/Shanghai");





REPLACE INTO `mds_role_resource` VALUES (80018005004, 1, '2022-07-04 06:04:59', 8001, 8005004, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80028005004, 1, '2022-07-04 06:04:59', 8002, 8005004, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80038005004, 1, '2022-07-04 06:04:59', 8003, 8005004, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80048005004, 1, '2022-07-04 06:04:59', 8004, 8005004, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80058005004, 1, '2022-07-04 06:04:59', 8005, 8005004, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80068005004, 1, '2022-07-04 06:04:59', 8006, 8005004, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80078005004, 1, '2022-07-04 06:04:59', 8007, 8005004, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80088005004, 1, '2022-07-04 06:04:59', 8008, 8005004, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80098005004, 1, '2022-07-04 06:04:59', 8009, 8005004, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80108005004, 1, '2022-07-04 06:04:59', 8010, 8005004, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80118005004, 1, '2022-07-04 06:04:59', 8011, 8005004, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80128005004, 1, '2022-07-04 06:04:59', 8012, 8005004, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80138005004, 1, '2022-07-04 06:04:59', 8013, 8005004, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80148005004, 1, '2022-07-04 06:04:59', 8014, 8005004, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80158005004, 1, '2022-07-04 06:04:59', 8015, 8005004, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80168005004, 1, '2022-07-04 06:04:59', 8016, 8005004, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80178005004, 1, '2022-07-04 06:04:59', 8017, 8005004, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80188005004, 1, '2022-07-04 06:04:59', 8018, 8005004, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80198005004, 1, '2022-07-04 06:04:59', 8019, 8005004, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80208005004, 1, '2022-07-04 06:04:59', 8020, 8005004, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80218005004, 1, '2022-07-04 06:04:59', 8021, 8005004, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80228005004, 1, '2022-07-04 06:04:59', 8022, 8005004, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80238005004, 1, '2022-07-04 06:04:59', 8023, 8005004, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80248005004, 1, '2022-07-04 06:04:59', 8024, 8005004, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80258005004, 1, '2022-07-04 06:04:59', 8025, 8005004, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80268005004, 1, '2022-07-04 06:04:59', 8026, 8005004, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80278005004, 1, '2022-07-04 06:04:59', 8027, 8005004, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80288005004, 1, '2022-07-04 06:04:59', 8028, 8005004, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80298005004, 1, '2022-07-04 06:04:59', 8029, 8005004, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80308005004, 1, '2022-07-04 06:04:59', 8030, 8005004, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80318005004, 1, '2022-07-04 06:04:59', 8031, 8005004, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80328005004, 1, '2022-07-04 06:04:59', 8032, 8005004, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80338005004, 1, '2022-07-04 06:04:59', 8033, 8005004, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80348005004, 1, '2022-07-04 06:04:59', 8034, 8005004, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80358005004, 1, '2022-07-04 06:04:59', 8035, 8005004, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80368005004, 1, '2022-07-04 06:04:59', 8036, 8005004, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80378005004, 1, '2022-07-04 06:04:59', 8037, 8005004, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80388005004, 1, '2022-07-04 06:04:59', 8038, 8005004, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80398005004, 1, '2022-07-04 06:04:59', 8039, 8005004, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80408005004, 1, '2022-07-04 06:04:59', 8040, 8005004, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80418005004, 1, '2022-07-04 06:04:59', 8041, 8005004, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80428005004, 1, '2022-07-04 06:04:59', 8042, 8005004, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80438005004, 1, '2022-07-04 06:04:59', 8043, 8005004, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80448005004, 1, '2022-07-04 06:04:59', 8044, 8005004, 1,"UTC" , "Asia/Shanghai");


REPLACE INTO `mds_role_resource` VALUES (80018005, 1, '2022-07-04 06:04:59', 8001, 8005, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80028005, 1, '2022-07-04 06:04:59', 8002, 8005, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80038005, 1, '2022-07-04 06:04:59', 8003, 8005, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80048005, 1, '2022-07-04 06:04:59', 8004, 8005, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80058005, 1, '2022-07-04 06:04:59', 8005, 8005, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80068005, 1, '2022-07-04 06:04:59', 8006, 8005, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80078005, 1, '2022-07-04 06:04:59', 8007, 8005, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80088005, 1, '2022-07-04 06:04:59', 8008, 8005, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80098005, 1, '2022-07-04 06:04:59', 8009, 8005, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80108005, 1, '2022-07-04 06:04:59', 8010, 8005, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80118005, 1, '2022-07-04 06:04:59', 8011, 8005, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80128005, 1, '2022-07-04 06:04:59', 8012, 8005, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80138005, 1, '2022-07-04 06:04:59', 8013, 8005, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80148005, 1, '2022-07-04 06:04:59', 8014, 8005, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80158005, 1, '2022-07-04 06:04:59', 8015, 8005, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80168005, 1, '2022-07-04 06:04:59', 8016, 8005, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80178005, 1, '2022-07-04 06:04:59', 8017, 8005, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80188005, 1, '2022-07-04 06:04:59', 8018, 8005, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80198005, 1, '2022-07-04 06:04:59', 8019, 8005, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80208005, 1, '2022-07-04 06:04:59', 8020, 8005, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80218005, 1, '2022-07-04 06:04:59', 8021, 8005, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80228005, 1, '2022-07-04 06:04:59', 8022, 8005, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80238005, 1, '2022-07-04 06:04:59', 8023, 8005, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80248005, 1, '2022-07-04 06:04:59', 8024, 8005, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80258005, 1, '2022-07-04 06:04:59', 8025, 8005, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80268005, 1, '2022-07-04 06:04:59', 8026, 8005, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80278005, 1, '2022-07-04 06:04:59', 8027, 8005, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80288005, 1, '2022-07-04 06:04:59', 8028, 8005, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80298005, 1, '2022-07-04 06:04:59', 8029, 8005, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80308005, 1, '2022-07-04 06:04:59', 8030, 8005, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80318005, 1, '2022-07-04 06:04:59', 8031, 8005, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80328005, 1, '2022-07-04 06:04:59', 8032, 8005, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80338005, 1, '2022-07-04 06:04:59', 8033, 8005, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80348005, 1, '2022-07-04 06:04:59', 8034, 8005, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80358005, 1, '2022-07-04 06:04:59', 8035, 8005, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80368005, 1, '2022-07-04 06:04:59', 8036, 8005, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80378005, 1, '2022-07-04 06:04:59', 8037, 8005, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80388005, 1, '2022-07-04 06:04:59', 8038, 8005, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80398005, 1, '2022-07-04 06:04:59', 8039, 8005, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80408005, 1, '2022-07-04 06:04:59', 8040, 8005, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80418005, 1, '2022-07-04 06:04:59', 8041, 8005, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80428005, 1, '2022-07-04 06:04:59', 8042, 8005, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80438005, 1, '2022-07-04 06:04:59', 8043, 8005, 1,"UTC" , "Asia/Shanghai");
REPLACE INTO `mds_role_resource` VALUES (80448005, 1, '2022-07-04 06:04:59', 8044, 8005, 1,"UTC" , "Asia/Shanghai");

-- 在 初始化时需要执行该sql查询  在执行该sql的查询结果  来自--彭国平
SELECT CONCAT('INSERT INTO rm_dept_working_hours_config(`id`,`dept_id`,`status`,`type`,`created_time`,`updated_time`)  VALUES(',id,", ",id,", ",1,", ",1,", '",NOW(),"', ","'",NOW(),"');") FROM (SELECT id FROM `mds_dept` WHERE del_flag = 1 AND dept_level = 1 AND dept_active = 1 AND parent_id IS NULL) a ;