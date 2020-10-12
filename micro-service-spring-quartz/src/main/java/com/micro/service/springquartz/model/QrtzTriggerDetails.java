package com.micro.service.springquartz.model;/**
 * @Description
 * @Project micro-service-parent
 * @Package com.micro.service.springquartz.model
 * @Author Administrator
 * @Date 2020-09-27 09:16
 */

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @ClassName QrtzTriggerDetails
 * @Description TODO
 * @Author Administrator
 * @Date 2020/9/27 9:16
 * @Version 1.0.0
 */

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class QrtzTriggerDetails {
    private String jobName;
//    private String jobGroup;
//    private String triggerName;
//    private String triggerGroup;
    private String description;
    private String jobClassName;
    private String priority;
    private String triggerType;
    private String triggerState;
    private String cronExpression;
    private String timeZoneId;

}
