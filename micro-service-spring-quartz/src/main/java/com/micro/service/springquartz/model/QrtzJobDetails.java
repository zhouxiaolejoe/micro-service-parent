package com.micro.service.springquartz.model;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Description
 * @Project micro-service-parent
 * @Package com.micro.service.springquartz.model
 * @Author Administrator
 * @Date 2020-09-20 12:10
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@TableName(value = "QRTZ_JOB_DETAILS")
public class QrtzJobDetails {
    @TableId(value = "SCHED_NAME", type = IdType.INPUT)
    private String schedName;

    @TableId(value = "JOB_NAME", type = IdType.INPUT)
    private String jobName;

    @TableId(value = "JOB_GROUP", type = IdType.INPUT)
    private String jobGroup;

    @TableField(value = "DESCRIPTION")
    private String description;

    @TableField(value = "JOB_CLASS_NAME")
    private String jobClassName;

    @TableField(value = "IS_DURABLE")
    private String isDurable;

    @TableField(value = "IS_NONCONCURRENT")
    private String isNonconcurrent;

    @TableField(value = "IS_UPDATE_DATA")
    private String isUpdateData;

    @TableField(value = "REQUESTS_RECOVERY")
    private String requestsRecovery;

    @TableField(value = "JOB_DATA")
    private byte[] jobData;

    public static final String COL_SCHED_NAME = "SCHED_NAME";

    public static final String COL_JOB_NAME = "JOB_NAME";

    public static final String COL_JOB_GROUP = "JOB_GROUP";

    public static final String COL_DESCRIPTION = "DESCRIPTION";

    public static final String COL_JOB_CLASS_NAME = "JOB_CLASS_NAME";

    public static final String COL_IS_DURABLE = "IS_DURABLE";

    public static final String COL_IS_NONCONCURRENT = "IS_NONCONCURRENT";

    public static final String COL_IS_UPDATE_DATA = "IS_UPDATE_DATA";

    public static final String COL_REQUESTS_RECOVERY = "REQUESTS_RECOVERY";

    public static final String COL_JOB_DATA = "JOB_DATA";
}