package com.micro.service.springquartz.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Description
 * @Project micro-service-parent
 * @Package com.micro.service.springquartz.model
 * @Author Administrator
 * @Date 2020-09-20 16:11
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class QrtzJobDetails {
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
    private String schedName;

    private String jobName;

    private String jobGroup;

    private String description;

    private String jobClassName;

    private String isDurable;

    private String isNonconcurrent;

    private String isUpdateData;

    private String requestsRecovery;

    private byte[] jobData;
}