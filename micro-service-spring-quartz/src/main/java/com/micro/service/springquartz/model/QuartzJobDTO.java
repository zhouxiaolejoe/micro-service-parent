package com.micro.service.springquartz.model;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.*;

/**
 * @ClassName QuartzJobDTO
 * @Description TODO
 * @Author ZhouXiaoLe
 * @Date 2019/7/31 10:15
 * @Version 1.0.0
 */
@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
@ApiModel("com.hiynn.spring.quartz.DTO.QuartzJobDTO")
@Builder
public class QuartzJobDTO {
    @ApiModelProperty(value = "任务名称",required = true)
    private String jobName;
    @ApiModelProperty(value = "任务分组",required = true)
    private String jobGroup;
    @ApiModelProperty(value = "触发器名称",required = true)
    private String triggerNmae;
    @ApiModelProperty(value = "触发器分组",required = true)
    private String triggerGroup;
    @ApiModelProperty(value = "任务描述")
    private String description;
    @ApiModelProperty(value = "任务执行时间")
    private String cronExpression;

}
