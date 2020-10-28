package com.micro.service.springquartz.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @ClassName QrtzTriggerDetails
 * @Description TODO
 * @Author zxl
 * @Date 2020/9/27 9:16
 * @Version 1.0.0
 */

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class QrtzTriggerDetails {
    private String jobName;
    private String triggerState;
    private byte[] jobData;
    private String triggerType;
    private String cronExpression;
    private String startTime;
    private String prevFireTime;
    private String nextFireTime;
    private String endTime;
    private String jobClassName;
    private String description;
    private String origin;
    private String target;

}
