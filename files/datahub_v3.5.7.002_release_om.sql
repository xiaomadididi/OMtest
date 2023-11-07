/**
                TODO : STEP01: 建表 ---- start
 */
CREATE SCHEMA IF NOT EXISTS `${database}` DEFAULT CHARACTER SET utf8mb4;
USE `${database}`;
--   01 建表 ecc_translate [业务系统翻译表]
CREATE TABLE IF NOT EXISTS `ecc_translate`
(
    `id`            bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
    `status`        tinyint(4)          DEFAULT NULL COMMENT '状态',
    `created_by`    bigint(20)          DEFAULT NULL COMMENT '创建人',
    `created_time`  datetime            DEFAULT NULL COMMENT '创建时间',
    `updated_by`    bigint(20)          DEFAULT NULL COMMENT '更新人',
    `updated_time`  datetime            DEFAULT NULL COMMENT '更新时间',
    `source_value`  varchar(1024)       DEFAULT NULL COMMENT '源文',
    `target_value`  varchar(1024)       DEFAULT NULL COMMENT '译文',
    `language`      varchar(255)        DEFAULT NULL COMMENT '语言',
    `sub_system_id` bigint(20) unsigned DEFAULT '0' COMMENT '子系统Id',
    `module_id`     bigint(20) unsigned DEFAULT '0' COMMENT '模块Id',
    `resource_id`   bigint(20) unsigned DEFAULT '0' COMMENT '资源id',
    PRIMARY KEY (`id`) USING BTREE
)
    ENGINE = InnoDB
    AUTO_INCREMENT = 4
    DEFAULT CHARSET = utf8
    ROW_FORMAT = DYNAMIC COMMENT ='业务系统翻译表';
--   02 建表 mds_active_history [状态变更记录表]
CREATE TABLE IF NOT EXISTS `mds_active_history`
(
    `id`           bigint(20)    NOT NULL COMMENT '主键',
    `created_by`   bigint(20)    NOT NULL COMMENT '创建人',
    `created_time` datetime      NOT NULL COMMENT '创建时间',
    `type`         int(1)        NOT NULL COMMENT '类型 1/项目 2/中心',
    `active`       int(1)        NOT NULL COMMENT '业务状态',
    `business_id`  bigint(20)    NOT NULL COMMENT '业务主键',
    `reason`       varchar(1024) NOT NULL COMMENT '状态变更原因',
    PRIMARY KEY (`id`)
)
    ENGINE = InnoDB
    DEFAULT CHARSET = utf8mb4 COMMENT ='状态变更记录表';
--   03 建表 mds_dept [部门管理表]
CREATE TABLE IF NOT EXISTS `mds_dept`
(
    `id`           bigint(20)   NOT NULL COMMENT '部门id',
    `status`       tinyint(4)   NOT NULL COMMENT '软删除状态（1存在 2删除）',
    `created_by`   bigint(20)            DEFAULT NULL COMMENT '创建人',
    `created_time` datetime              DEFAULT NULL COMMENT '创建时间',
    `updated_by`   bigint(20)            DEFAULT NULL COMMENT '更新人',
    `updated_time` datetime              DEFAULT NULL COMMENT '更新时间',
    `parent_id`    bigint(20)            DEFAULT NULL COMMENT '父部门id',
    `dept_name`    varchar(128) NOT NULL COMMENT '部门名称',
    `order_num`    int(11)      NOT NULL COMMENT '显示顺序',
    `leader_id`    bigint(20)            DEFAULT NULL COMMENT '负责人id',
    `dept_active`  tinyint(4)   NOT NULL COMMENT '部门状态（1正常，2停用）',
    `dept_level`   int(11)               DEFAULT NULL COMMENT '部门层级(1-5)',
    `del_flag`     int(1)       NOT NULL DEFAULT '1',
    PRIMARY KEY (`id`) USING BTREE
)
    ENGINE = InnoDB
    DEFAULT CHARSET = utf8mb4
    ROW_FORMAT = COMPACT COMMENT ='部门管理表';
--   04 建表 mds_dept_user [部门与人员关联中间表]
CREATE TABLE IF NOT EXISTS `mds_dept_user`
(
    `id`           bigint(20) NOT NULL COMMENT '主键',
    `created_time` datetime            DEFAULT NULL COMMENT '创建时间',
    `dept_id`      bigint(20) NOT NULL COMMENT '部门id',
    `user_id`      bigint(20) NOT NULL COMMENT '人员id',
    `type`         tinyint(4) NOT NULL COMMENT '成员类型（1普通成员，2领导）',
    `del_flag`     int(1)     NOT NULL DEFAULT '1',
    PRIMARY KEY (`id`) USING BTREE,
    KEY `idx_mdu_user_id` (`user_id`),
    KEY `idx_mdu_dept_id` (`dept_id`)
)
    ENGINE = InnoDB
    DEFAULT CHARSET = utf8mb4
    ROW_FORMAT = DYNAMIC COMMENT ='部门与人员关联中间表 ';
--   04 建表 mds_env [环境表]
CREATE TABLE IF NOT EXISTS `mds_env`
(
    `id`           bigint(20)   NOT NULL COMMENT '主键',
    `created_by`   bigint(20)   NOT NULL COMMENT '创建人',
    `created_time` datetime     NOT NULL COMMENT '创建时间',
    `updated_by`   bigint(20)            DEFAULT NULL COMMENT '更新人',
    `updated_time` datetime              DEFAULT NULL COMMENT '更新时间',
    `status`       int(1)       NOT NULL COMMENT '状态（1/正常 2/停用）',
    `name`         varchar(128) NOT NULL COMMENT '名称 环境名称',
    `study_id`     bigint(20)   NOT NULL COMMENT '项目id',
    `type`         varchar(32)  NOT NULL COMMENT '类型（prod/生产 test/测试 dev/开发 other/其它）',
    `standard`     int(1)       NOT NULL COMMENT '是否为标准（1/标准 2/非标准）',
    `sort`         int(4)       NOT NULL COMMENT '排序',
    `del_flag`     int(1)       NOT NULL DEFAULT '1',
    PRIMARY KEY (`id`)
)
    ENGINE = InnoDB
    DEFAULT CHARSET = utf8mb4 COMMENT ='环境表';
--   05 建表 mds_org [组织信息]
CREATE TABLE IF NOT EXISTS `mds_org`
(
    `id`              bigint(20) NOT NULL COMMENT '主键',
    `created_by`      bigint(20)          DEFAULT NULL COMMENT '创建人',
    `created_time`    datetime            DEFAULT NULL COMMENT '创建时间',
    `updated_by`      bigint(20)          DEFAULT NULL COMMENT '更新人',
    `updated_time`    datetime            DEFAULT NULL COMMENT '更新时间',
    `status`          int(1)     NOT NULL DEFAULT '1' COMMENT '状态（1/正常 2/停用）',
    `org_code`        varchar(32)         DEFAULT NULL COMMENT '组织编号',
    `name`            varchar(512)        DEFAULT NULL COMMENT '组织名称',
    `type`            varchar(128)        DEFAULT NULL COMMENT '组织类型(平台字典code)',
    `country_id`      bigint(20)          DEFAULT NULL COMMENT '国家地区',
    `province_id`     bigint(20)          DEFAULT NULL COMMENT '州省',
    `city_id`         bigint(20)          DEFAULT NULL COMMENT '城市',
    `address`         varchar(512)        DEFAULT NULL COMMENT '主要地址',
    `zipcode`         varchar(128)        DEFAULT NULL COMMENT '邮编',
    `main_phone`      varchar(128)        DEFAULT NULL COMMENT '主要电话',
    `other_phone`     varchar(128)        DEFAULT NULL COMMENT '其他电话',
    `main_email`      varchar(128)        DEFAULT NULL COMMENT '主要邮件',
    `other_email`     varchar(128)        DEFAULT NULL COMMENT '其他邮件',
    `uplink_org_id`   bigint(20)          DEFAULT NULL COMMENT '上级组织',
    `plt_standorg_id` bigint(20)          DEFAULT NULL COMMENT '标准组织id',
    `active`          int(1)              DEFAULT '1' COMMENT '活动状态',
    `del_flag`        int(1)     NOT NULL DEFAULT '1',
    PRIMARY KEY (`id`)
)
    ENGINE = InnoDB
    DEFAULT CHARSET = utf8mb4 COMMENT ='组织信息';
--   06 建表 mds_permissions [权限信息]
CREATE TABLE IF NOT EXISTS `mds_permissions`
(
    `id`           bigint(20) NOT NULL COMMENT '主键',
    `created_by`   bigint(20) NOT NULL COMMENT '创建人',
    `created_time` datetime   NOT NULL COMMENT '创建时间',
    `updated_by`   bigint(20)          DEFAULT NULL COMMENT '更新人',
    `updated_time` datetime            DEFAULT NULL COMMENT '更新时间',
    `status`       int(1)     NOT NULL DEFAULT 1 COMMENT '状态（1/正常 2/停用）',
    `user_id`      bigint(20) NOT NULL COMMENT '用户主键',
    `role_id`      bigint(20) NOT NULL COMMENT '角色主键',
    `study_id`     bigint(20)          DEFAULT NULL COMMENT '项目主键',
    `env_id`       bigint(20)          DEFAULT NULL COMMENT '环境主键',
    `site_id`      bigint(20)          DEFAULT NULL COMMENT '试验中心主键',
    `del_flag`     int(1)     NOT NULL DEFAULT '1',
    `group_no`     varchar(64)         DEFAULT NULL,
    `dept_id`      BIGINT(20) NULL     DEFAULT NULL COMMENT '部门id',
    `history_flag` INT(5)              DEFAULT 1 COMMENT '历史记录标志，1：归为历史记录，2：不作为历史记录',
    PRIMARY KEY (`id`),
    KEY `idx_mp_user_id` (`user_id`),
    KEY `idx_mp_study_id` (`study_id`),
    KEY `idx_mp_group_no` (`group_no`)
)
    ENGINE = InnoDB
    DEFAULT CHARSET = utf8mb4 COMMENT ='权限信息';
--   07 建表 mds_resource [资源表]
CREATE TABLE IF NOT EXISTS `mds_resource`
(
    `id`           bigint(20)   NOT NULL COMMENT '主键',
    `created_by`   bigint(20)   NOT NULL DEFAULT 1 COMMENT '创建人',
    `created_time` datetime     NOT NULL DEFAULT NOW() COMMENT '创建时间',
    `updated_by`   bigint(20)            DEFAULT NULL COMMENT '更新人',
    `updated_time` datetime              DEFAULT NULL COMMENT '更新时间',
    `status`       int(1)                DEFAULT 1 NOT NULL COMMENT '状态（1/正常 2/停用）',
    `parent_id`    bigint(20)   NOT NULL COMMENT '父级',
    `name`         varchar(128) NOT NULL COMMENT '名称',
    `icon`         varchar(128)          DEFAULT NULL COMMENT '图标',
    `sort`         varchar(128) NOT NULL COMMENT '排序',
    `res_code`     varchar(128) NOT NULL COMMENT '模块code',
    `path`         varchar(128) NOT NULL COMMENT '路由',
    `component`    varchar(128)          DEFAULT NULL COMMENT '组件',
    `type`         varchar(8)   NOT NULL COMMENT '资源类型 系统sys 菜单menu、按钮button',
    `sys_id`       bigint(20)            DEFAULT NULL,
    `group_no`     varchar(16)           DEFAULT NULL,
    `disabled`     INT(1)       NULL     DEFAULT 0 COMMENT '是否默认勾选并且不可变更：1：是，0：否',
    `del_flag`     int(1)       NOT NULL DEFAULT 1,
    PRIMARY KEY (`id`)
)
    ENGINE = InnoDB
    DEFAULT CHARSET = utf8mb4 COMMENT ='资源表';
--   08 建表 mds_role [角色表]
CREATE TABLE IF NOT EXISTS `mds_role`
(
    id              bigint           NOT NULL COMMENT '主键'
        PRIMARY KEY,
    created_by      bigint           NOT NULL COMMENT '创建人',
    created_time    datetime         NOT NULL COMMENT '创建时间',
    updated_by      bigint           NULL COMMENT '更新人',
    updated_time    datetime         NULL COMMENT '更新时间',
    status          int(1) DEFAULT 1 NOT NULL COMMENT '状态（1/正常 2/停用）',
    name            varchar(512)     NOT NULL COMMENT '名称',
    code            varchar(128)     NULL COMMENT '编码',
    description     varchar(500)     NULL COMMENT '描述',
    sys_id          bigint           NOT NULL COMMENT '所属系统id',
    open_label      int(1) DEFAULT 3 NOT NULL COMMENT '非盲标识（1/盲态角色 2/非盲角色 3/不受限角色）',
    type            int(1)           NOT NULL COMMENT '角色类型（1/内置角色 2/标准角色 3/自定义角色）',
    data_visit_type varchar(8)       NOT NULL COMMENT '数据访问类型编码（20021/不可访问数据 20051/应用级 20052/项目级 20053/中心级）',
    std_role_id     bigint           NULL COMMENT '角色组(标准角色)id',
    del_flag        int(1) DEFAULT 1 NOT NULL COMMENT '删除标识 1= 未删除 2 = 已删除',
    person_type     int(1) DEFAULT 1 NULL COMMENT '1=研究人员 2 = 受试者'
)
    ENGINE = InnoDB
    DEFAULT CHARSET = utf8mb4 COMMENT ='角色表';

--   09 建表 mds_role_resource [角色资源中间表]
CREATE TABLE IF NOT EXISTS `mds_role_resource`
(
    `id`           bigint(20) NOT NULL COMMENT '主键',
    `created_by`   bigint     NOT NULL DEFAULT 1 COMMENT '创建人',
    `created_time` datetime   NOT NULL DEFAULT NOW() COMMENT '创建时间',
    `role_id`      bigint(20) NOT NULL COMMENT '角色主键',
    `resource_id`  bigint(20) NOT NULL COMMENT '资源主键',
    `del_flag`     int(1)     NOT NULL DEFAULT '1',
    PRIMARY KEY (`id`),
    KEY `idx_mrr_role_id` (`role_id`)
)
    ENGINE = InnoDB
    DEFAULT CHARSET = utf8mb4 COMMENT ='角色资源中间表';
--   10 建表 mds_site [试验中心]
CREATE TABLE IF NOT EXISTS `mds_site`
(
    `id`           bigint(20) NOT NULL COMMENT '主键',
    `created_by`   bigint(20) NOT NULL COMMENT '创建人',
    `created_time` datetime   NOT NULL COMMENT '创建时间',
    `updated_by`   bigint(20)          DEFAULT NULL COMMENT '更新人',
    `updated_time` datetime            DEFAULT NULL COMMENT '更新时间',
    `status`       int(1)     NOT NULL COMMENT '状态（1/正常 2/停用）',
    `org_id`       bigint(20) NOT NULL COMMENT '组织id',
    `site_code`    varchar(128)        DEFAULT NULL,
    `country_id`   bigint(20) NOT NULL COMMENT '国家id',
    `study_id`     bigint(20) NOT NULL COMMENT '项目id',
    `env_id`       bigint(20) NOT NULL COMMENT '环境id',
    `active`       int(1)     NOT NULL COMMENT '中心状态',
    `del_flag`     int(1)     NOT NULL DEFAULT '1',
    PRIMARY KEY (`id`),
    KEY `idx_ms_study_id` (`study_id`)
)
    ENGINE = InnoDB
    DEFAULT CHARSET = utf8mb4 COMMENT ='试验中心';
--   11 建表 mds_site_pi [试验中心与PI的中间表]
CREATE TABLE IF NOT EXISTS `mds_site_pi`
(
    `id`                 bigint(20)           NOT NULL COMMENT '主键',
    `created_by`         bigint(20)           NOT NULL COMMENT '创建人',
    `created_time`       datetime             NOT NULL COMMENT '创建时间',
    `site_id`            bigint(20) DEFAULT NULL COMMENT '中心主键',
    `user_id`            bigint(20) DEFAULT NULL COMMENT '临床试验研究者',
    `duty_start_time`    datetime             NULL COMMENT '任职开始时间',
    `duty_end_time`      datetime             NULL COMMENT '任职结束时间',
    `select_flag`        tinyint    default 1 null comment '被选择状态 1=被选择 2=未被选择',
    `pi_role_code`       tinyint    default 1 null comment '1=PI 2=CRC 3 =其他角色',
    `pi_role_extra_name` varchar(100)         null comment '当pi_role_code为空时有值',
    `pi_remark`          varchar(100)         null comment 'pi备注',
    `updated_by`         bigint               null comment '更新人',
    `updated_time`       datetime             null comment '更新时间',
    `del_flag`           int(1)               NOT NULL DEFAULT '1',
    PRIMARY KEY (`id`),
    KEY `idx_msp_site_id` (`site_id`),
    KEY `idx_msp_user_id` (`user_id`)
)
    ENGINE = InnoDB
    DEFAULT CHARSET = utf8mb4 COMMENT ='试验中心与PI的中间表';
--   12 建表 tenant_email_template [邮箱模板]
CREATE TABLE IF NOT EXISTS `tenant_email_template`
(
    `id`           bigint(20)   NOT NULL COMMENT '主键',
    `created_by`   bigint(20)   NOT NULL COMMENT '创建人',
    `created_time` datetime     NOT NULL COMMENT '创建时间',
    `updated_by`   bigint(20)            DEFAULT NULL COMMENT '更新人',
    `updated_time` datetime              DEFAULT NULL COMMENT '更新时间',
    `status`       int(1)       NOT NULL COMMENT '状态（1/正常 2/停用）',
    `language`     varchar(8)   NOT NULL COMMENT '语言类型',
    `content`      text         NOT NULL COMMENT '模板内容',
    `code`         varchar(128) NOT NULL COMMENT '编码',
    `name`         varchar(128) NOT NULL COMMENT '名称',
    `title`        varchar(128) NOT NULL COMMENT '模板标题',
    `del_flag`     int(1)       NOT NULL DEFAULT 1,
    PRIMARY KEY (`id`)
)
    ENGINE = InnoDB
    DEFAULT CHARSET = utf8mb4 COMMENT ='邮箱模板';
--   13 建表 audit_log [稽查日志记录]
CREATE TABLE IF NOT EXISTS `audit_log`
(
    `id`            bigint(20)                                               NOT NULL COMMENT '日志主键',
    `business_obj`  varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '业务属性（如果为系统，存储code，细化到按钮级别，如果为项目存储项目id）',
    `business_type` int(2)                                                   NOT NULL DEFAULT 0 COMMENT '业务类型（0 其它 1 系统 2项目）',
    `app_id`        bigint(20)                                               NOT NULL COMMENT '应用ID  (对应子系统 主数据 ETMF ECOA CTMS 等系统)',
    `request_url`   varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci  NOT NULL COMMENT '请求uri',
    `oper_ip`       varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci   NOT NULL COMMENT 'ip地址',
    `language_type` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci  NOT NULL COMMENT '语言类型',
    `oper_param`    longtext CHARACTER SET utf8 COLLATE utf8_general_ci      NULL COMMENT '请求参数',
    `result_code`   int(11)                                                  NOT NULL COMMENT '消息code',
    `result_msg`    varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci  NOT NULL COMMENT '消息',
    `created_by`    bigint(20)                                               NOT NULL COMMENT '创建人',
    `oper_status`   int(1)                                                   NULL     DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
    `oper_type`     varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci   NOT NULL DEFAULT '0' COMMENT '操作类型 (码表获取)',
    `idx_name`      text CHARACTER SET utf8 COLLATE utf8_general_ci          NULL COMMENT '索引',
    `created_time`  datetime                                                 NOT NULL COMMENT '创建时间',
    `study_id`      bigint(20)                                               NULL     DEFAULT NULL COMMENT '研究项目id',
    `field1`        varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci  NULL     DEFAULT NULL COMMENT '备用字段1',
    `field2`        varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci  NULL     DEFAULT NULL COMMENT '备用字段2',
    `field3`        varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci  NULL     DEFAULT NULL COMMENT '备用字段3',
    `first_name`    varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci  NULL     DEFAULT NULL COMMENT '创建人姓氏（避免过多查询，冗余字段）',
    `last_name`     varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci  NULL     DEFAULT NULL COMMENT '创建人名称（避免过多查询，冗余字段）',
    `email`         varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci  NULL     DEFAULT NULL COMMENT '创建人邮箱（避免过多查询，冗余字段）',
    `role_id`       bigint(20)                                               NULL     DEFAULT NULL COMMENT '操作人角色id',
    `role_name`     varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci  NULL     DEFAULT NULL COMMENT '操作人角色名称（避免过多查询，冗余字段）',
    PRIMARY KEY (`id`) USING BTREE,
    INDEX `idx_auditlist` (`app_id`, `result_code`, `created_time`) USING BTREE
)
    ENGINE = InnoDB
    CHARACTER SET = utf8
    COLLATE = utf8_general_ci COMMENT = '稽查日志记录'
    ROW_FORMAT = DYNAMIC;
--   14 建表 audit_log_detail [操作日志记录]
CREATE TABLE IF NOT EXISTS `audit_log_detail`
(
    `id`              bigint(20)                                                    NOT NULL COMMENT '日志主键',
    `audit_id`        bigint(20)                                                    NOT NULL COMMENT '稽查日志主键',
    `attribute_name`  varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '属性名称（操作字段名称）',
    `attribute_alias` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '属性别名（字段显示名称）',
    `old_value`       longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci     NULL COMMENT '属性的旧值',
    `new_value`       longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci     NULL COMMENT '属性的新值',
    `attribute_type`  int(1)                                                        NOT NULL DEFAULT 0 COMMENT '扩展类型 （0 正常 1 文本 2 其它 ）',
    `diff_value`      longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci     NULL COMMENT '属性的差异值（现在不实现，后期扩展)',
    `return_type`     varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NULL     DEFAULT NULL COMMENT '回显类型（前端自定义）',
    `select_type`     varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci       NULL     DEFAULT NULL COMMENT '码表类型',
    `file_id`         varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL     DEFAULT NULL COMMENT '存储操作文件id',
    `sort`            int(11)                                                       NULL     DEFAULT NULL COMMENT '稽查明细属性排序',
    PRIMARY KEY (`id`) USING BTREE,
    INDEX `idx_audit_id` (`audit_id`) USING BTREE
)
    ENGINE = InnoDB
    CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_general_ci COMMENT = '操作日志记录'
    ROW_FORMAT = DYNAMIC;

--   15 建表 sys_todo [待办表]
CREATE TABLE IF NOT EXISTS `sys_todo`
(
    id            bigint        not null comment '主键'
        primary key,
    status        tinyint       null comment '状态',
    created_by    bigint        null comment '创建人',
    created_time  datetime      null comment '创建时间',
    updated_by    bigint        null comment '更新人',
    updated_time  datetime      null comment '更新时间',
    todo_tpl_code varchar(1024) null comment '内容模板',
    submit_by     bigint        null comment '提交人',
    type          int           null comment '模块标识 详见ModelTypeEnum',
    state         tinyint       null comment '待办状态  1/已办 2/待办',
    study_id      bigint        null comment '项目主键',
    is_check      tinyint       null comment '是否已读 1/是 2/否',
    role_id       bigint        null comment '审批人对应的角色主键',
    param         text          null comment '参数',
    business_id   bigint        null comment '业务主键',
    param_content text          null comment '参数',
    user_id       bigint        null comment '用户id',
    app_id        int           null comment '应用ID'

)
    ENGINE = InnoDB
    CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_general_ci comment '待办表'
    ROW_FORMAT = DYNAMIC;
--   16 建表 sys_message [待办表]
CREATE TABLE IF NOT EXISTS `sys_message`
(
    id           bigint        not null comment '主键'
        primary key,
    status       tinyint       null comment '状态',
    created_by   bigint        null comment '创建人',
    created_time datetime      null comment '创建时间',
    updated_by   bigint        null comment '更新人',
    updated_time datetime      null comment '更新时间',
    msg_tpl_code varchar(1024) null comment '消息模板code',
    study_id     bigint        null comment '项目主键',
    is_check     tinyint       null comment '是否已读 1/是 2/否',
    user_id      bigint        null comment '用户主键',
    role_id      bigint        null comment '对应角色主键',
    business_id  bigint        null comment '业务主键',
    param        text          null comment '参数',
    type         int           null comment '模块标识 详见ModelTypeEnum',
    app_id       int           null comment '应用ID'
)
    ENGINE = InnoDB
    CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_general_ci comment '通知消息表'
    ROW_FORMAT = DYNAMIC;
--   17 建表 mds_data_change_notice [数据变更同步表]
CREATE TABLE IF NOT EXISTS `mds_data_change_notice`
(
    `id`           bigint(20)  NOT NULL AUTO_INCREMENT COMMENT '主键',
    `status`       tinyint(4)  NULL DEFAULT 1 COMMENT '状态:1:启用，2：禁用',
    `created_by`   bigint(20)  NULL DEFAULT NULL COMMENT '创建人',
    `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
    `deal_status`  tinyint(4)  NOT NULL COMMENT '处理状态:1:未处理，2：已处理',
    `updated_by`   bigint(20)  NULL DEFAULT NULL COMMENT '更新人',
    `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
    `data`         text        NOT NULL COMMENT '同步数据',
    `main_type`    varchar(32) NOT NULL COMMENT '主类型',
    `sub_type`     varchar(32) NOT NULL COMMENT '子类型',
    `app_id`       int(5)      NOT NULL comment '子系统ID',
    `business_id`  bigint(20)  NOT NULL COMMENT '业务ID',
    `tenant_id`    bigint(20)  NOT NULL COMMENT '租户ID',
    `del_flag`     int(1)      NULL DEFAULT 1 COMMENT '1 =未删除 2 = 已删除 默认1',
    PRIMARY KEY (`id`) USING BTREE,
    INDEX `idx_data_notice_created_time` (`created_time`) USING BTREE,
    INDEX `idx_data_notice_business_id` (`business_id`) USING BTREE
)
    ENGINE = InnoDB COMMENT = '数据变更同步表'
    ROW_FORMAT = DYNAMIC;
--   18 建表 mds_position [职位表]
CREATE TABLE IF NOT EXISTS `mds_position`
(
    `id`            bigint(20)   NOT NULL,
    `position_name` varchar(255) NOT NULL COMMENT '职位名称',
    `created_by`    bigint(20) DEFAULT NULL,
    `created_time`  datetime   DEFAULT NULL,
    `updated_by`    bigint(20) DEFAULT NULL,
    `updated_time`  datetime   DEFAULT NULL,
    `del_flag`      tinyint(4) DEFAULT NULL COMMENT '删除标识(1/未删除 2/已删除)',
    PRIMARY KEY (`id`) USING BTREE
)
    ENGINE = InnoDB
    CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_general_ci comment '职位表'
    ROW_FORMAT = DYNAMIC;
--   19 建表 mds_position_user [职位用户中间表]
CREATE TABLE IF NOT EXISTS `mds_position_user`
(
    `id`           bigint(20) NOT NULL,
    `position_id`  bigint(20) NOT NULL,
    `user_id`      bigint(20) NOT NULL,
    `sort`         int(255)            DEFAULT NULL,
    `created_by`   bigint(20)          DEFAULT NULL,
    `created_time` datetime            DEFAULT NULL,
    `del_flag`     tinyint(4) NOT NULL DEFAULT '1' COMMENT '删除标识(1/未删除 2/已删除)',
    PRIMARY KEY (`id`) USING BTREE
)
    ENGINE = InnoDB
    CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_general_ci comment '职位表'
    ROW_FORMAT = DYNAMIC;

--   20 建表 mds_study_org [项目组织表]
CREATE TABLE IF NOT EXISTS `mds_study_org`
(
    `id`           bigint(20) NOT NULL,
    `study_id`     bigint(20) NOT NULL,
    `org_id`       bigint(20) NOT NULL,
    `created_by`   bigint(20)   DEFAULT NULL,
    `created_time` datetime     DEFAULT NULL,
    `updated_by`   bigint(20)   DEFAULT NULL,
    `updated_time` datetime     DEFAULT NULL,
    `remark`       varchar(255) DEFAULT NULL,
    `del_flag`     int(255)     DEFAULT NULL,
    PRIMARY KEY (`id`)
)
    ENGINE = InnoDB
    CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_general_ci comment '项目组织表'
    ROW_FORMAT = DYNAMIC;

CREATE TABLE IF NOT EXISTS `mds_download_center`
(
    `id`           bigint(20) NOT NULL COMMENT '主键',
    `status`       int(4)        DEFAULT NULL COMMENT '状态',
    `created_by`   bigint(20)    DEFAULT NULL COMMENT '创建人',
    `created_time` datetime      DEFAULT NULL COMMENT '创建时间',
    `updated_by`   bigint(20)    DEFAULT NULL COMMENT '修改人',
    `updated_time` datetime      DEFAULT NULL COMMENT '修改时间',
    `file_name`    varchar(500)  DEFAULT NULL COMMENT '名称',
    `url`          varchar(1000) DEFAULT NULL COMMENT '文件地址',
    `del_flag`     tinyint(4)    DEFAULT '1' COMMENT '1 = 未删除, 2 = 已删除',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='DataHub下载中心';
/**
    TODO : STEP01: 建表 ---- end
 */


/**
    TODO: STEP02: 向角色表中插入 超管,主数据 [管理员,项目经理,临床试验助理,地方（区域）项目经理]    ---- start
 */

--  01 初始化  超级管理员 角色数据
REPLACE INTO `mds_role` (`id`, `created_by`, `created_time`, `name`, `sys_id`, `type`, `data_visit_type`)
VALUES (-1, '-1', NOW(), '超级管理员', -1, 1, '20051');
--  02 初始化 主数据标准角色
REPLACE INTO `mds_role` (`id`, `created_by`, `created_time`, `name`, `sys_id`, `type`, `data_visit_type`)
VALUES
    -- 主数据管理员
    (1, '-1', NOW(), '管理员', 1, 2, '20051'),
    -- 主数据项目经理
    (1001, '-1', NOW(), '项目经理', 1, 2, '20052'),
    -- 主数据临床试验助理
    (1003, '-1', NOW(), '临床试验助理', 1, 2, '20052'),
    -- 地方（区域）项目经理
    (1004, '-1', NOW(), '地方（区域）项目经理', 1, 2, '20052');

/**
    TODO: STEP02: 向角色表中插入 超管,主数据 [管理员,项目经理,临床试验助理,地方（区域）项目经理] ---- end
 */

/**
    TODO: STEP03: 插入组织信息 ------start
 */
REPLACE INTO `mds_org` (`id`, `created_by`, `created_time`,
                        `org_code`, `name`, `type`, `country_id`,
                        `province_id`, `city_id`, `address`)
VALUES (1000000000000000000, 1, NOW(),
        'ORG000000', '${tenant.companyName}', '${tenant.orgType}', ${tenant.countryId},
        ${tenant.provinceId}, ${tenant.cityId}, '${tenant.address}');
/**
    TODO: STEP03: 插入组织信息 ---------end
 */


/**
    TODO: STEP04: 插入资源表数据 --------start
 */

REPLACE INTO `mds_resource` (`id`, `created_by`, `created_time`, `parent_id`, `name`, `icon`, `sort`, `res_code`,
                             `path`,
                             `component`, `type`, `sys_id`, `group_no`)
VALUES
    --  00 一级菜单共同的父亲, 应该是没啥用
    (1, 1, NOW(), -1, '主数据', 'icon-jibenxinxi', '1', 'basic_info', '/', '', 'sys', 1, ''),
    --  01  基本信息
    (1002, 1, NOW(), 1, '基本信息', 'icon-jibenxinxi', '1', 'BASIC_INFO', '/csr_mds/customer', '', 'menu', 1, '1'),
    (1021, 1, NOW(), 1002, '编辑', '', '21', 'BASIC_INFO_EDIT', '', '', 'button', 1, '1'),
    --  02 部门管理
    (1003, 1, NOW(), 1, '部门管理', 'icon-bumenguanli', '2', 'DEPARTMENT_MANAGEMENT', '/csr_mds/department', '', 'menu',
     1, '1'),
    (1022, 1, NOW(), 1003, '添加', '', '22', 'DEPARTMENT_MANAGEMENT_ADD', '', '', 'button', 1, '1'),
    (1023, 1, NOW(), 1003, '编辑', '', '23', 'DEPARTMENT_MANAGEMENT_EDIT', '', '', 'button', 1, '1'),
    (1024, 1, NOW(), 1003, '删除', '', '24', 'DEPARTMENT_MANAGEMENT_DELETE', '', '', 'button', 1, '1'),
    (1054, 1, NOW(), 1003, '导出', '', '54', 'DEPARTMENT_MANAGEMENT_EXPORT', '', '', 'button', 1, '1'),
    --  03 研究项目
    (1004, 1, NOW(), 1, '研究项目', 'icon-yanjiuxiangmu', '6', 'STUDY_MANAGEMENT', '/csr_mds/study', '', 'menu', 1,
     '1'),
    (1041, 1, NOW(), 1004, '项目概览', 'icon-xiangmugailan1', '8', 'STUDY_OVERVIEW', '/csr_mds/study/preview1', '',
     'menu', 1, '3'),
    (1042, 1, NOW(), 1004, '导出', '', '42', 'STUDY_MANAGEMENT_EXPORT', '', '', 'button', 1, '1'),
    (1043, 1, NOW(), 1004, '试验中心', 'icon-shiyanzhongxin2', '9', 'STUDY_CENTER', '/csr_mds/study/studyCenter', '',
     'menu', 1, '3'),
    (1044, 1, NOW(), 1004, '项目成员', 'icon-xiangmuchengyuan', '10', 'STUDY_MEMBER', '/csr_mds/study/studyPermission',
     '', 'menu', 1, '3'),
    (1071, 1, NOW(), 1004, '添加', '', '41', 'STUDY_MANAGEMENT_ADD', '', '', 'button', 1, '1'),
    (1063, 1, NOW(), 1004, '编辑项目信息', '', '43', 'STUDY_OVERVIEW_INFO_EDIT', '', '', 'button', 1, '1'),
    (1072, 1, NOW(), 1004, '字段排序', '', '45', 'STUDY_MANAGEMENT_FIELD_SORT', '', '', 'button', 1, '1'),
    --  03---01 研究项目下的试验中心
    (1045, 1, NOW(), 1043, '添加', '', '45', 'STUDY_CENTER_ADD', '', '', 'button', 1, '1'),
    (1046, 1, NOW(), 1043, '编辑中心信息', '', '46', 'STUDY_CENTER_INFO_EDIT', '', '', 'button', 1, '1'),
    (1047, 1, NOW(), 1043, '编辑中心状态', '', '47', 'STUDY_CENTER_STATUS_EDIT', '', '', 'button', 1, '1'),
    (1048, 1, NOW(), 1043, '导出', '', '48', 'STUDY_CENTER_EXPORT', '', '', 'button', 1, '1'),
    -- 管理员需要任意修改中心状态
    (104301, 1, NOW(), 1043, '中心状态任意修改', '', '49', 'STUDY_CENTER_RANDOM_UPDATE', '', '', 'button', 1, '1'),
    --  03---02 研究项目下的 项目成员
    (1049, 1, NOW(), 1044, '成员挑选', '', '49', 'STUDY_MEMBER_SELECT', '', '', 'button', 1, '1'),
    (1050, 1, NOW(), 1044, '编辑角色权限', '', '50', 'STUDY_MEMBER_ROLE_EDIT', '', '', 'button', 1, '1'),
    (1051, 1, NOW(), 1044, '删除', '', '51', 'STUDY_MEMBER_DELETE', '', '', 'button', 1, '1'),
    (1052, 1, NOW(), 1044, '导出', '', '52', 'STUDY_MEMBER_EXPORT', '', '', 'button', 1, '1'),
    --  03--03 研究项目下的 编辑项目信息与状态
    (1064, 1, NOW(), 1041, '编辑项目状态', '', '44', 'STUDY_OVERVIEW_STATUS_EDIT', '', '', 'button', 1, '1'),

    --  04 职位管理
    (1005, 1, NOW(), 1, '职位管理', 'icon-xiangmuchengyuan', '2', 'POSITION_MANAGEMENT', '/csr_mds/position', '',
     'menu', 1, '1'),
    (1005001, 1, NOW(), 1005, '添加', '', '1', 'POSITION_MANAGEMENT_ADD', '', '', 'button', 1, '1'),
    (1005002, 1, NOW(), 1005, '编辑', '', '2', 'POSITION_MANAGEMENT_EDIT', '', '', 'button', 1, '1'),
    (1005003, 1, NOW(), 1005, '删除', '', '3', 'POSITION_MANAGEMENT_DELETE', '', '', 'button', 1, '1'),

    --  05 组织管理
    (1009, 1, NOW(), 1, '组织管理', 'icon-zuzhiguanli', '3', 'ORGANIZATION_MANAGEMENT', '/csr_mds/organiztion', '',
     'menu', 1, '1'),
    (1025, 1, NOW(), 1009, '添加', '', '25', 'ORGANIZATION_MANAGEMENT_ADD', '', '', 'button', 1, '1'),
    (1026, 1, NOW(), 1009, '编辑', '', '26', 'ORGANIZATION_MANAGEMENT_EDIT', '', '', 'button', 1, '1'),
    (1027, 1, NOW(), 1009, '启用停用', '', '27', 'ORGANIZATION_MANAGEMENT_ABLE', '', '', 'button', 1, '1'),
    (1028, 1, NOW(), 1009, '导出', '', '28', 'ORGANIZATION_MANAGEMENT_EXPORT', '', '', 'button', 1, '1'),
    (1029, 1, NOW(), 1009, '导入', '', '29', 'ORGANIZATION_MANAGEMENT_IMPORT', '', '', 'button', 1, '1'),

    --  06 角色管理
    (1010, 1, NOW(), 1, '角色管理', 'icon-jiaoseguanli', '4', 'ROLE_MANAGEMENT', '/csr_mds/role', '', 'menu', 1, '1'),
    (1030, 1, NOW(), 1010, '添加', '', '30', 'ROLE_MANAGEMENT_ADD', '', '', 'button', 1, '1'),
    (1031, 1, NOW(), 1010, '编辑', '', '31', 'ROLE_MANAGEMENT_EDIT', '', '', 'button', 1, '1'),
    (1032, 1, NOW(), 1010, '删除', '', '32', 'ROLE_MANAGEMENT_DELETE', '', '', 'button', 1, '1'),
    (1055, 1, NOW(), 1010, '导出', '', '55', 'ROLE_MANAGEMENT_EXPORT', '', '', 'button', 1, '1'),
    --  07 人员管理
    (1011, 1, NOW(), 1, '人员管理', 'icon-renyuanguanli', '5', 'USER_MANAGEMENT', '/csr_mds/user', '', 'menu', 1, '1'),
    (1033, 1, NOW(), 1011, '添加', '', '33', 'USER_MANAGEMENT_ADD', '', '', 'button', 1, '1'),
    (1034, 1, NOW(), 1011, '邀请', '', '34', 'USER_MANAGEMENT_INVITATION', '', '', 'button', 1, '1'),
    (1035, 1, NOW(), 1011, '身份确认', '', '35', 'USER_MANAGEMENT_IDENTIFICATION', '', '', 'button', 1, '1'),
    (1036, 1, NOW(), 1011, '编辑人员信息', '', '36', 'USER_MANAGEMENT_EDIT', '', '', 'button', 1, '1'),
    (1037, 1, NOW(), 1011, '启停', '', '37', 'USER_MANAGEMENT_CHANGE_STATUS', '', '', 'button', 1, '1'),
    (1038, 1, NOW(), 1011, '重发邮件', '', '38', 'USER_MANAGEMENT_RESEND_EMAIL', '', '', 'button', 1, '1'),
    (1039, 1, NOW(), 1011, '编辑角色权限', '', '39', 'USER_MANAGEMENT_ROLE_EDIT', '', '', 'button', 1, '1'),
    (1040, 1, NOW(), 1011, '导出', '', '40', 'USER_MANAGEMENT_EXPORT', '', '', 'button', 1, '1'),

    --  08 稽查轨迹
    (1012, 1, NOW(), 1, '稽查轨迹', 'icon-jichaguiji', '7', 'AUDIT_TRAIL', '/csr_mds/sudit', '', 'menu', 1, '1');


--  09 调整菜单 默认显示状态
UPDATE mds_resource
SET disabled = 1
WHERE id in (
    -- 基本信息
             1002,
    -- 项目概览
             1041
    );

/**
    TODO: STEP04: 插入资源表数据 ---------end
 */

/**
    TODO: STEP05: 配置 [超管,主数据管理员,项目经理,临床试验助理,地方（区域）项目经理] 菜单 ---------start
 */
-- 配置 超管   菜单
REPLACE INTO `mds_role_resource` (`id`, `created_by`, `created_time`, `role_id`, `resource_id`)
VALUES (1, 1, NOW(), -1, 1),
       (50002, 1, NOW(), -1, 1002),
       (50003, 1, NOW(), -1, 1009),
       (50004, 1, NOW(), -1, 1010),
       (50005, 1, NOW(), -1, 1011),
       (50006, 1, NOW(), -1, 1004),
       (50007, 1, NOW(), -1, 1071),
       (50008, 1, NOW(), -1, 1041),
       (50009, 1, NOW(), -1, 1043),
       (50010, 1, NOW(), -1, 1044),
       (50011, 1, NOW(), -1, 1003),
       (50012, 1, NOW(), -1, 1021),
       (50013, 1, NOW(), -1, 1022),
       (50014, 1, NOW(), -1, 1023),
       (50015, 1, NOW(), -1, 1024),
       (50016, 1, NOW(), -1, 1025),
       (50017, 1, NOW(), -1, 1026),
       (50018, 1, NOW(), -1, 1027),
       (50019, 1, NOW(), -1, 1028),
       (50020, 1, NOW(), -1, 1029),
       (50021, 1, NOW(), -1, 1030),
       (50022, 1, NOW(), -1, 1031),
       (50023, 1, NOW(), -1, 1032),
       (50024, 1, NOW(), -1, 1033),
       (50025, 1, NOW(), -1, 1034),
       (50026, 1, NOW(), -1, 1035),
       (50027, 1, NOW(), -1, 1036),
       (50028, 1, NOW(), -1, 1037),
       (50029, 1, NOW(), -1, 1038),
       (50030, 1, NOW(), -1, 1039),
       (50031, 1, NOW(), -1, 1040),
       (50032, 1, NOW(), -1, 1041),
       (50033, 1, NOW(), -1, 1042),
       (50034, 1, NOW(), -1, 1063),
       (50035, 1, NOW(), -1, 1064),
       (50036, 1, NOW(), -1, 1045),
       (50037, 1, NOW(), -1, 1046),
       (50038, 1, NOW(), -1, 1047),
       (50039, 1, NOW(), -1, 1048),
       (50040, 1, NOW(), -1, 1049),
       (50041, 1, NOW(), -1, 1050),
       (50042, 1, NOW(), -1, 1051),
       (50043, 1, NOW(), -1, 1052),
       (50044, 1, NOW(), -1, 1012),
       (50045, 1, NOW(), -1, 1054),
       (50046, 1, NOW(), -1, 1055),
       (120017, 1, NOW(), -1, 1005),
       (120021, 1, NOW(), -1, 1005003),
       (120019, 1, NOW(), -1, 1005001),
       (120020, 1, NOW(), -1, 1005002);
-- 配置  主数据管理员 菜单
REPLACE INTO `mds_role_resource` (`id`, `created_by`, `created_time`, `role_id`, `resource_id`)
VALUES (40001, 1, NOW(), 1, 1),
       (40002, 1, NOW(), 1, 1002),
       (40003, 1, NOW(), 1, 1009),
       (40004, 1, NOW(), 1, 1010),
       (40005, 1, NOW(), 1, 1011),
       (40006, 1, NOW(), 1, 1004),
       (40007, 1, NOW(), 1, 1071),
       (40008, 1, NOW(), 1, 1041),
       (40009, 1, NOW(), 1, 1043),
       (40010, 1, NOW(), 1, 1044),
       (40011, 1, NOW(), 1, 1003),
       (40012, 1, NOW(), 1, 1021),
       (40013, 1, NOW(), 1, 1022),
       (40014, 1, NOW(), 1, 1023),
       (40015, 1, NOW(), 1, 1024),
       (40016, 1, NOW(), 1, 1025),
       (40017, 1, NOW(), 1, 1026),
       (40018, 1, NOW(), 1, 1027),
       (40019, 1, NOW(), 1, 1028),
       (40020, 1, NOW(), 1, 1029),
       (40021, 1, NOW(), 1, 1030),
       (40022, 1, NOW(), 1, 1031),
       (40023, 1, NOW(), 1, 1032),
       (40024, 1, NOW(), 1, 1033),
       (40025, 1, NOW(), 1, 1034),
       (40026, 1, NOW(), 1, 1035),
       (40027, 1, NOW(), 1, 1036),
       (40028, 1, NOW(), 1, 1037),
       (40029, 1, NOW(), 1, 1038),
       (40030, 1, NOW(), 1, 1039),
       (40031, 1, NOW(), 1, 1040),
       (40032, 1, NOW(), 1, 1041),
       (40033, 1, NOW(), 1, 1042),
       (40034, 1, NOW(), 1, 1063),
       (40035, 1, NOW(), 1, 1064),
       (40036, 1, NOW(), 1, 1045),
       (40037, 1, NOW(), 1, 1046),
       (40038, 1, NOW(), 1, 1047),
       (40039, 1, NOW(), 1, 1048),
       (40040, 1, NOW(), 1, 1049),
       (40041, 1, NOW(), 1, 1050),
       (40042, 1, NOW(), 1, 1051),
       (40043, 1, NOW(), 1, 1052),
       (40044, 1, NOW(), 1, 1012),
       (40045, 1, NOW(), 1, 1054),
       (40046, 1, NOW(), 1, 1055),
       (120018, 1, NOW(), 1, 1005),
       (120022, 1, NOW(), 1, 1005001),
       (120023, 1, NOW(), 1, 1005002),
       (120024, 1, NOW(), 1, 1005003),
       -- 管理强制修改试验中心状态
       (120025, 1, NOW(), 1, 104301),
       -- 项目管理-字段排序
       (120026, 1, NOW(), 1, 1072);
-- 配置 项目经理 菜单
REPLACE INTO `mds_role_resource` (`id`, `created_by`, `created_time`, `role_id`, `resource_id`)
VALUES (10001, 1, NOW(), 1001, 1),
       (10002, 1, NOW(), 1001, 1002),
       (10006, 1, NOW(), 1001, 1004),
       (10007, 1, NOW(), 1001, 1071),
       (10008, 1, NOW(), 1001, 1041),
       (10009, 1, NOW(), 1001, 1043),
       (10010, 1, NOW(), 1001, 1044),
       (10011, 1, NOW(), 1001, 1003),
       (10012, 1, NOW(), 1001, 1021),
       (10032, 1, NOW(), 1001, 1041),
       (10033, 1, NOW(), 1001, 1042),
       (10034, 1, NOW(), 1001, 1063),
       (10035, 1, NOW(), 1001, 1064),
       (10036, 1, NOW(), 1001, 1045),
       (10037, 1, NOW(), 1001, 1046),
       (10038, 1, NOW(), 1001, 1047),
       (10039, 1, NOW(), 1001, 1048),
       (10040, 1, NOW(), 1001, 1049),
       (10041, 1, NOW(), 1001, 1050),
       (10042, 1, NOW(), 1001, 1051),
       (10043, 1, NOW(), 1001, 1052);
-- 配置 临床试验助理 菜单
REPLACE INTO `mds_role_resource` (`id`, `created_by`, `created_time`, `role_id`, `resource_id`)
VALUES (20001, 1, NOW(), 1003, 1),
       (20002, 1, NOW(), 1003, 1002),
       (20006, 1, NOW(), 1003, 1004),
       (20007, 1, NOW(), 1003, 1071),
       (20008, 1, NOW(), 1003, 1041),
       (20009, 1, NOW(), 1003, 1043),
       (20010, 1, NOW(), 1003, 1044),
       (20011, 1, NOW(), 1003, 1003),
       (20012, 1, NOW(), 1003, 1021),
       (20032, 1, NOW(), 1003, 1041),
       (20033, 1, NOW(), 1003, 1042),
       (20034, 1, NOW(), 1003, 1063),
       (20035, 1, NOW(), 1003, 1064),
       (20036, 1, NOW(), 1003, 1045),
       (20037, 1, NOW(), 1003, 1046),
       (20038, 1, NOW(), 1003, 1047),
       (20039, 1, NOW(), 1003, 1048),
       (20040, 1, NOW(), 1003, 1049),
       (20041, 1, NOW(), 1003, 1050),
       (20042, 1, NOW(), 1003, 1051),
       (20043, 1, NOW(), 1003, 1052);
-- 配置 地方（区域）项目经理 菜单
REPLACE INTO `mds_role_resource` (`id`, `created_by`, `created_time`, `role_id`, `resource_id`)
VALUES (30001, 1, NOW(), 1004, 1),
       (30002, 1, NOW(), 1004, 1002),
       (30006, 1, NOW(), 1004, 1004),
       (30007, 1, NOW(), 1004, 1071),
       (30008, 1, NOW(), 1004, 1041),
       (30009, 1, NOW(), 1004, 1043),
       (30010, 1, NOW(), 1004, 1044),
       (30011, 1, NOW(), 1004, 1003),
       (30012, 1, NOW(), 1004, 1021),
       (30032, 1, NOW(), 1004, 1041),
       (30033, 1, NOW(), 1004, 1042),
       (30034, 1, NOW(), 1004, 1063),
       (30035, 1, NOW(), 1004, 1064),
       (30036, 1, NOW(), 1004, 1045),
       (30037, 1, NOW(), 1004, 1046),
       (30038, 1, NOW(), 1004, 1047),
       (30039, 1, NOW(), 1004, 1048),
       (30040, 1, NOW(), 1004, 1049),
       (30041, 1, NOW(), 1004, 1050),
       (30042, 1, NOW(), 1004, 1051),
       (30043, 1, NOW(), 1004, 1052);
/**
    TODO: STEP05: 配置 [超管,主数据管理员,项目经理,临床试验助理,地方（区域）项目经理] 菜单 ---------end
 */


/**
    TODO: STEP06:  给用户配超级管理员角色 ---------start
 */
REPLACE INTO `mds_permissions` (`id`, `created_by`, `created_time`, `user_id`, `role_id`)
VALUES (1, 1, NOW(), ${userId}, -1);
/**
    TODO: STEP06:  给用户配超级管理员角色 -----------end
 */

 /**
     新增时区相关字段
 */
ALTER TABLE `audit_log`
ADD COLUMN `created_time_tz` VARCHAR(64) NULL DEFAULT 'UTC' COMMENT '创建时间服务端时区' AFTER `role_name`,
ADD COLUMN `created_time_ctz` VARCHAR(64) NULL DEFAULT 'Asia/Shanghai' COMMENT '创建时间客户端时区' AFTER `created_time_tz`;
ALTER TABLE `mds_active_history`
ADD COLUMN `created_time_tz` VARCHAR(64) NULL DEFAULT 'UTC' COMMENT '创建时间服务端时区' AFTER `reason`,
ADD COLUMN `created_time_ctz` VARCHAR(64) NULL DEFAULT 'Asia/Shanghai' COMMENT '创建时间客户端时区' AFTER `created_time_tz`;
ALTER TABLE `mds_data_change_notice`
ADD COLUMN `created_time_tz` VARCHAR(64) NULL DEFAULT 'UTC' COMMENT '创建时间服务端时区' AFTER `del_flag`,
ADD COLUMN `created_time_ctz` VARCHAR(64) NULL DEFAULT 'Asia/Shanghai' COMMENT '创建时间客户端时区' AFTER `created_time_tz`,
ADD COLUMN `updated_time_tz` VARCHAR(64) NULL DEFAULT 'UTC' COMMENT '更新时间服务端时区' AFTER `created_time_ctz`,
ADD COLUMN `updated_time_ctz` VARCHAR(64) NULL DEFAULT 'Asia/Shanghai' COMMENT '更新时间客户端时区' AFTER `updated_time_tz`;

ALTER TABLE `mds_download_center`
ADD COLUMN `created_time_tz` VARCHAR(64) NULL DEFAULT 'UTC' COMMENT '创建时间服务端时区' AFTER `del_flag`,
ADD COLUMN `created_time_ctz` VARCHAR(64) NULL DEFAULT 'Asia/Shanghai' COMMENT '创建时间客户端时区' AFTER `created_time_tz`,
ADD COLUMN `updated_time_tz` VARCHAR(64) NULL DEFAULT 'UTC' COMMENT '更新时间服务端时区' AFTER `created_time_ctz`,
ADD COLUMN `updated_time_ctz` VARCHAR(64) NULL DEFAULT 'Asia/Shanghai' COMMENT '更新时间客户端时区' AFTER `updated_time_tz`;


ALTER TABLE `mds_dept`
ADD COLUMN `created_time_tz` VARCHAR(64) NULL DEFAULT 'UTC' COMMENT '创建时间服务端时区' AFTER `del_flag`,
ADD COLUMN `created_time_ctz` VARCHAR(64) NULL DEFAULT 'Asia/Shanghai' COMMENT '创建时间客户端时区' AFTER `created_time_tz`,
ADD COLUMN `updated_time_tz` VARCHAR(64) NULL DEFAULT 'UTC' COMMENT '更新时间服务端时区' AFTER `created_time_ctz`,
ADD COLUMN `updated_time_ctz` VARCHAR(64) NULL DEFAULT 'Asia/Shanghai' COMMENT '更新时间客户端时区' AFTER `updated_time_tz`;

ALTER TABLE `mds_dept_user`
ADD COLUMN `created_time_tz` VARCHAR(64) NULL DEFAULT 'UTC' COMMENT '创建时间服务端时区' AFTER `del_flag`,
ADD COLUMN `created_time_ctz` VARCHAR(64) NULL DEFAULT 'Asia/Shanghai' COMMENT '创建时间客户端时区' AFTER `created_time_tz`;

ALTER TABLE `mds_env`
ADD COLUMN `created_time_tz` VARCHAR(64) NULL DEFAULT 'UTC' COMMENT '创建时间服务端时区' AFTER `del_flag`,
ADD COLUMN `created_time_ctz` VARCHAR(64) NULL DEFAULT 'Asia/Shanghai' COMMENT '创建时间客户端时区' AFTER `created_time_tz`,
ADD COLUMN `updated_time_tz` VARCHAR(64) NULL DEFAULT 'UTC' COMMENT '更新时间服务端时区' AFTER `created_time_ctz`,
ADD COLUMN `updated_time_ctz` VARCHAR(64) NULL DEFAULT 'Asia/Shanghai' COMMENT '更新时间客户端时区' AFTER `updated_time_tz`;

ALTER TABLE `mds_org`
ADD COLUMN `created_time_tz` VARCHAR(64) NULL DEFAULT 'UTC' COMMENT '创建时间服务端时区' AFTER `del_flag`,
ADD COLUMN `created_time_ctz` VARCHAR(64) NULL DEFAULT 'Asia/Shanghai' COMMENT '创建时间客户端时区' AFTER `created_time_tz`,
ADD COLUMN `updated_time_tz` VARCHAR(64) NULL DEFAULT 'UTC' COMMENT '更新时间服务端时区' AFTER `created_time_ctz`,
ADD COLUMN `updated_time_ctz` VARCHAR(64) NULL DEFAULT 'Asia/Shanghai' COMMENT '更新时间客户端时区' AFTER `updated_time_tz`;

ALTER TABLE `mds_permissions`
ADD COLUMN `created_time_tz` VARCHAR(64) NULL DEFAULT 'UTC' COMMENT '创建时间服务端时区' AFTER `history_flag`,
ADD COLUMN `created_time_ctz` VARCHAR(64) NULL DEFAULT 'Asia/Shanghai' COMMENT '创建时间客户端时区' AFTER `created_time_tz`,
ADD COLUMN `updated_time_tz` VARCHAR(64) NULL DEFAULT 'UTC' COMMENT '更新时间服务端时区' AFTER `created_time_ctz`,
ADD COLUMN `updated_time_ctz` VARCHAR(64) NULL DEFAULT 'Asia/Shanghai' COMMENT '更新时间客户端时区' AFTER `updated_time_tz`;

ALTER TABLE `mds_position`
ADD COLUMN `status` tinyint(2) NULL DEFAULT '1' COMMENT '状态：1启用/2停用' AFTER `del_flag`,
ADD COLUMN `created_time_tz` VARCHAR(64) NULL DEFAULT 'UTC' COMMENT '创建时间服务端时区' AFTER `status`,
ADD COLUMN `created_time_ctz` VARCHAR(64) NULL DEFAULT 'Asia/Shanghai' COMMENT '创建时间客户端时区' AFTER `created_time_tz`,
ADD COLUMN `updated_time_tz` VARCHAR(64) NULL DEFAULT 'UTC' COMMENT '更新时间服务端时区' AFTER `created_time_ctz`,
ADD COLUMN `updated_time_ctz` VARCHAR(64) NULL DEFAULT 'Asia/Shanghai' COMMENT '更新时间客户端时区' AFTER `updated_time_tz`;

ALTER TABLE `mds_position_user`
ADD COLUMN `created_time_tz` VARCHAR(64) NULL DEFAULT 'UTC' COMMENT '创建时间服务端时区' AFTER `del_flag`,
ADD COLUMN `created_time_ctz` VARCHAR(64) NULL DEFAULT 'Asia/Shanghai' AFTER `created_time_tz`;

ALTER TABLE `mds_resource`
ADD COLUMN `internal_flag` int(2) NULL DEFAULT '1' COMMENT '是否内置菜单:1是/2否' AFTER `disabled`,
ADD COLUMN `created_time_tz` VARCHAR(64) NULL DEFAULT 'UTC' COMMENT '创建时间服务端时区' AFTER `internal_flag`,
ADD COLUMN `created_time_ctz` VARCHAR(64) NULL DEFAULT 'Asia/Shanghai' COMMENT '创建时间客户端时区' AFTER `created_time_tz`,
ADD COLUMN `updated_time_tz` VARCHAR(64) NULL DEFAULT 'UTC' COMMENT '更新时间服务端时区' AFTER `created_time_ctz`,
ADD COLUMN `updated_time_ctz` VARCHAR(64) NULL DEFAULT 'Asia/Shanghai' COMMENT '更新时间客户端时区' AFTER `updated_time_tz`;

ALTER TABLE `mds_role`
ADD COLUMN `name_en` VARCHAR(512) NULL COMMENT '英文名称' AFTER `name`,
ADD COLUMN `created_time_tz` VARCHAR(64) NULL DEFAULT 'UTC' COMMENT '创建时间服务端时区' AFTER `person_type`,
ADD COLUMN `created_time_ctz` VARCHAR(64) NULL DEFAULT 'Asia/Shanghai' COMMENT '创建时间客户端时区' AFTER `created_time_tz`,
ADD COLUMN `updated_time_tz` VARCHAR(64) NULL DEFAULT 'UTC' COMMENT '更新时间服务端时区' AFTER `created_time_ctz`,
ADD COLUMN `updated_time_ctz` VARCHAR(64) NULL DEFAULT 'Asia/Shanghai' COMMENT '更新时间客户端时区' AFTER `updated_time_tz`;

ALTER TABLE `mds_role_resource`
ADD COLUMN `created_time_tz` VARCHAR(64) NULL DEFAULT 'UTC' COMMENT '创建时间服务端时区' AFTER `del_flag`,
ADD COLUMN `created_time_ctz` VARCHAR(64) NULL DEFAULT 'Asia/Shanghai' COMMENT '创建时间客户端时区' AFTER `created_time_tz`;
ALTER TABLE `mds_site`
ADD COLUMN `created_time_tz` VARCHAR(64) NULL DEFAULT 'UTC' COMMENT '创建时间服务端时区' AFTER `del_flag`,
ADD COLUMN `created_time_ctz` VARCHAR(64) NULL DEFAULT 'Asia/Shanghai' COMMENT '创建时间客户端时区' AFTER `created_time_tz`,
ADD COLUMN `updated_time_tz` VARCHAR(64) NULL DEFAULT 'UTC' COMMENT '更新时间服务端时区' AFTER `created_time_ctz`,
ADD COLUMN `updated_time_ctz` VARCHAR(64) NULL DEFAULT 'Asia/Shanghai' COMMENT '更新时间客户端时区' AFTER `updated_time_tz`;

ALTER TABLE `mds_site_pi`
ADD COLUMN `status` tinyint(2) NULL DEFAULT '1' COMMENT '状态：1启用/2停用' AFTER `del_flag`,
ADD COLUMN `duty_start_time_tz` VARCHAR(64) NULL DEFAULT 'UTC' COMMENT '开始时间服务端时区' AFTER `status`,
ADD COLUMN `duty_start_time_ctz` VARCHAR(64) NULL DEFAULT 'Asia/Shanghai' COMMENT '开始时间客户端时区' AFTER `duty_start_time_tz`,
ADD COLUMN `duty_end_time_tz` VARCHAR(64) NULL DEFAULT 'UTC' COMMENT '结束时间服务端时区' AFTER `duty_start_time_ctz`,
ADD COLUMN `duty_end_time_ctz` VARCHAR(64) NULL DEFAULT 'Asia/Shanghai' COMMENT '结束时间客户端时区' AFTER `duty_end_time_tz`,
ADD COLUMN `created_time_tz` VARCHAR(64) NULL DEFAULT 'UTC' COMMENT '创建时间服务端时区' AFTER `duty_end_time_ctz`,
ADD COLUMN `created_time_ctz` VARCHAR(64) NULL DEFAULT 'Asia/Shanghai' COMMENT '创建时间客户端时区' AFTER `created_time_tz`,
ADD COLUMN `updated_time_tz` VARCHAR(64) NULL DEFAULT 'UTC' COMMENT '更新时间服务端时区' AFTER `created_time_ctz`,
ADD COLUMN `updated_time_ctz` VARCHAR(64) NULL DEFAULT 'Asia/Shanghai' COMMENT '更新时间客户端时区' AFTER `updated_time_tz`;

ALTER TABLE `mds_study_org`
ADD COLUMN `created_time_tz` VARCHAR(64) NULL DEFAULT 'UTC' COMMENT '创建时间服务端时区' AFTER `del_flag`,
ADD COLUMN `created_time_ctz` VARCHAR(64) NULL DEFAULT 'Asia/Shanghai' COMMENT '创建时间客户端时区' AFTER `created_time_tz`,
ADD COLUMN `updated_time_tz` VARCHAR(64) NULL DEFAULT 'UTC' COMMENT '更新时间服务端时区' AFTER `created_time_ctz`,
ADD COLUMN `updated_time_ctz` VARCHAR(64) NULL DEFAULT 'Asia/Shanghai' COMMENT '更新时间客户端时区' AFTER `updated_time_tz`;

ALTER TABLE `sys_message`
ADD COLUMN `created_time_tz` VARCHAR(64) NULL DEFAULT 'UTC' COMMENT '创建时间服务端时区' AFTER `app_id`,
ADD COLUMN `created_time_ctz` VARCHAR(64) NULL DEFAULT 'Asia/Shanghai' COMMENT '创建时间客户端时区' AFTER `created_time_tz`,
ADD COLUMN `updated_time_tz` VARCHAR(64) NULL DEFAULT 'UTC' COMMENT '更新时间服务端时区' AFTER `created_time_ctz`,
ADD COLUMN `updated_time_ctz` VARCHAR(64) NULL DEFAULT 'Asia/Shanghai' COMMENT '更新时间客户端时区' AFTER `updated_time_tz`;

ALTER TABLE `sys_todo`
ADD COLUMN `created_time_tz` VARCHAR(64) NULL DEFAULT 'UTC' COMMENT '创建时间服务端时区' AFTER `app_id`,
ADD COLUMN `created_time_ctz` VARCHAR(64) NULL DEFAULT 'Asia/Shanghai' COMMENT '创建时间客户端时区' AFTER `created_time_tz`,
ADD COLUMN `updated_time_tz` VARCHAR(64) NULL DEFAULT 'UTC' COMMENT '更新时间服务端时区' AFTER `created_time_ctz`,
ADD COLUMN `updated_time_ctz` VARCHAR(64) NULL DEFAULT 'Asia/Shanghai' COMMENT '更新时间客户端时区' AFTER `updated_time_tz`;

-- 3.5.6版本新增脚本
ALTER TABLE `mds_position`
ADD COLUMN `parent_id` BIGINT(20) NULL COMMENT '上级职位ID' AFTER `updated_time_ctz`,
ADD COLUMN `order_num` INT(5) NULL DEFAULT 0 COMMENT '排序号' AFTER `parent_id`;

-- 3.5.7版本新增脚本 

ALTER TABLE `mds_site` 
ADD COLUMN `hospital_dept_id` BIGINT(20) NULL COMMENT '科室ID' AFTER `updated_time_ctz`,
ADD COLUMN `address` VARCHAR(1024) NULL DEFAULT NULL COMMENT '主要地址' AFTER `hospital_dept_id`;


ALTER TABLE `mds_site_pi` 
ADD COLUMN `hospital_dept_id` BIGINT(20) NULL COMMENT '科室ID' AFTER `user_id`;


ALTER TABLE `mds_org` 
ADD COLUMN `name_en` VARCHAR(512) NULL COMMENT '英文名称' AFTER `name`,
ADD COLUMN `legal_man` VARCHAR(128) NULL COMMENT '法人' AFTER `name_en`;

DROP TABLE IF EXISTS `mds_org_ethics`;
CREATE TABLE `mds_org_ethics` (
  `id` BIGINT(20) NOT NULL COMMENT '主键ID',
  `created_by` BIGINT(20) NOT NULL DEFAULT 1 COMMENT '创建人',
  `created_time` DATETIME NULL DEFAULT current_timestamp COMMENT '创建时间',
  `created_time_tz` VARCHAR(64) NULL DEFAULT 'UTC' COMMENT '创建时间服务端时区',
  `created_time_ctz` VARCHAR(64) NULL DEFAULT 'Asia/Shanghai' COMMENT '创建时间客户端时区',
  `updated_by` BIGINT(20) NOT NULL DEFAULT 1 COMMENT '最后更新人',
  `updated_time` DATETIME NULL DEFAULT current_timestamp COMMENT '最后更新时间',
  `updated_time_tz` VARCHAR(64) NULL DEFAULT 'UTC' COMMENT '最后更新时间服务端时区',
  `updated_time_ctz` VARCHAR(64) NULL DEFAULT 'Asia/Shanghai' COMMENT '最后更新时间客户端时区',
  `status` INT(2) NULL DEFAULT 1 COMMENT '启停状态:1/启用，2/禁用',
  `org_id` BIGINT(20) NOT NULL COMMENT '组织ID',
  `need_cde_approval` INT(2) NULL  COMMENT '机构立项是否需要CDE批件或CDE受理通知书，1：是，2：不是',
  `is_pre_ethics` INT(2) NULL COMMENT '是否伦理前置，1：是，2：不是',
  `need_tmu_approval` INT(2) NULL  COMMENT '是否需要组长单位批件，1：是，2：不是',
  `is_fast_ethics` INT(2) NULL  COMMENT '是否有快速伦理，1：是，2：不是',
  `project_approval_time` INT(6) NULL COMMENT '立项时所需时间/时限，单位周',
  `ethics_meeting_rate` INT(6) NULL  COMMENT '伦理会频率，单位周',
  `ethics_approval_time` INT(6) NULL COMMENT '伦理批件获得时间/时限，单位周',
  `gos_approval_time` INT(6) NULL COMMENT '遗传办承诺书获得时间/时限，单位周',
  `contact_sign_time` INT(6) NULL COMMENT '合同签署时限，单位周',
  `project_flow_file_name` varchar(2048) NULL  COMMENT '立项流程文件名称',
  `project_flow_file_url` varchar(2048) NULL  COMMENT '立项流程文件路径',
  `del_flag` INT(2) NULL DEFAULT 1  COMMENT '逻辑删除标志，1/正常，2/已删除',
  KEY `idx_mom_org_id` (`org_id`),
  PRIMARY KEY (`id`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='组织伦理信息';
  

DROP TABLE IF EXISTS `mds_org_member`;
CREATE TABLE `mds_org_member` (
  `id` BIGINT(20) NOT NULL COMMENT '主键ID',
  `created_by` BIGINT(20) NOT NULL DEFAULT 1 COMMENT '创建人',
  `created_time` DATETIME NULL DEFAULT current_timestamp COMMENT '创建时间',
  `created_time_tz` VARCHAR(64) NULL DEFAULT 'UTC' COMMENT '创建时间服务端时区',
  `created_time_ctz` VARCHAR(64) NULL DEFAULT 'Asia/Shanghai' COMMENT '创建时间客户端时区',
  `updated_by` BIGINT(20) NOT NULL DEFAULT 1 COMMENT '最后更新人',
  `updated_time` DATETIME NULL DEFAULT current_timestamp COMMENT '最后更新时间',
  `updated_time_tz` VARCHAR(64) NULL DEFAULT 'UTC' COMMENT '最后更新时间服务端时区',
  `updated_time_ctz` VARCHAR(64) NULL DEFAULT 'Asia/Shanghai' COMMENT '最后更新时间客户端时区',
  `status` INT(2) NULL DEFAULT 1 COMMENT '启停状态:1/启用，2/禁用',
  `member_type` INT(5) NULL DEFAULT 1 COMMENT '成员类型：1：机构成员，2：伦理委员会成员',
  `org_id` BIGINT(20) NOT NULL COMMENT '组织ID',
  `name` varchar(128) NULL DEFAULT '' COMMENT '联系人姓名',
  `position` varchar(128) NULL DEFAULT '' COMMENT '联系人职位',
  `link_way` varchar(128) NULL DEFAULT '' COMMENT '联系方式',
  `email` varchar(200) NULL DEFAULT '' COMMENT '联系人邮箱地址',
  `del_flag` INT(2) NULL DEFAULT 1  COMMENT '逻辑删除标志，1/正常，2/已删除',
  KEY `idx_mom_org_id` (`org_id`),
  PRIMARY KEY (`id`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='机构（组织）成员表';
  
DROP TABLE IF EXISTS `mds_hospital_dept`;  
CREATE TABLE `mds_hospital_dept` (
`id` bigint(20) NOT NULL COMMENT '科室id',
`status` tinyint(4) NOT NULL COMMENT '软删除状态（1存在 2删除）',
`created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
`created_time` datetime DEFAULT NULL COMMENT '创建时间',
`updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
`updated_time` datetime DEFAULT NULL COMMENT '更新时间',
`parent_id` bigint(20) DEFAULT NULL COMMENT '上级科室id',
`dept_name` varchar(128) NOT NULL COMMENT '科室名称',
`dept_name_en` varchar(128) NULL COMMENT '科室英文名称',
`order_num` int(11) NOT NULL DEFAULT 1 COMMENT '显示顺序',
`org_id` bigint(20) NOT NULL COMMENT '所属医院/组织id',
`dept_active` tinyint(4) NOT NULL COMMENT '科室状态（1正常，2停用）',
`dept_level` int(11) DEFAULT NULL COMMENT '科室层级(1-5)',
`del_flag` int(1) NOT NULL DEFAULT '1',
`created_time_tz` varchar(64) DEFAULT 'UTC' COMMENT '创建时间服务端时区',
`created_time_ctz` varchar(64) DEFAULT 'Asia/Shanghai' COMMENT '创建时间客户端时区',
`updated_time_tz` varchar(64) DEFAULT 'UTC' COMMENT '更新时间服务端时区',
`updated_time_ctz` varchar(64) DEFAULT 'Asia/Shanghai' COMMENT '更新时间客户端时区',
KEY `idx_mhd_org_id` (`org_id`),
PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 ROW_FORMAT = COMPACT COMMENT = '医院科室表';

 
