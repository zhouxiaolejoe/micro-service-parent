package com.micro.service.springquartz.controller;

import com.micro.service.springquartz.model.QuartzJobDTO;
import com.micro.service.springquartz.service.JobService;
import com.micro.service.springquartz.utils.ResultBuilder;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import org.quartz.SchedulerException;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

/**
 * @ClassName SchedulerController
 * @Description TODO
 * @Author ZhouXiaoLe
 * @Date 2019/7/31 11:10
 * @Version 1.0.0
 */
@RestController
@Api(tags = "任务调度")
@AllArgsConstructor
public class SchedulerController {
    JobService jobService;

    @GetMapping("/getJobList")
    @ApiOperation(value = "任务列表", produces = MediaType.APPLICATION_JSON_VALUE, httpMethod = "GET")
    public ResultBuilder getJobList(){
        return ResultBuilder.success(jobService.getJobList(null));
    }

    @PostMapping("/addJob")
    @ApiOperation(value = "新增任务", produces = MediaType.APPLICATION_JSON_VALUE, httpMethod = "POST")
    public ResultBuilder addJob(@RequestBody QuartzJobDTO quartzJobDTO) throws SchedulerException {
        QuartzJobDTO quartzJobDTO1 = QuartzJobDTO.builder()
                .cronExpression("0/10 * * * * ?")
                .description("任务1")
                .jobGroup("group")
                .jobName("job1")
                .triggerGroup("group1")
                .triggerNmae("trigger1")
                .build();
        jobService.addJob(quartzJobDTO);
        return ResultBuilder.success();
    }
    @GetMapping("/jobStatus")
    @ApiOperation(value = "任务状态", produces = MediaType.APPLICATION_JSON_VALUE, httpMethod = "GET")
    public ResultBuilder jobStatus(@RequestParam("triggerName")String triggerName,@RequestParam("triggerGroup")String triggerGroup) throws SchedulerException {
        return jobService.jobStatus(triggerName,triggerGroup);
    }
    @PostMapping("/triggerJob")
    @ApiOperation(value = "触发任务", produces = MediaType.APPLICATION_JSON_VALUE, httpMethod = "POST")
    public ResultBuilder triggerJob(@RequestParam("jobName")String jobName,@RequestParam("jobGroup")String jobGroup) throws SchedulerException {
        jobService.triggerJob(jobName,jobGroup);
        return ResultBuilder.success();
    }

    @PostMapping("/pauseJob")
    @ApiOperation(value = "暂停任务", produces = MediaType.APPLICATION_JSON_VALUE, httpMethod = "POST")
    public ResultBuilder pauseJob(@RequestParam("jobName")String jobName,@RequestParam("jobGroup")String jobGroup) throws SchedulerException {
        jobService.pauseJob(jobName,jobGroup);
        return ResultBuilder.success();
    }
    @PostMapping("/resumeJob")
    @ApiOperation(value = "恢复任务", produces = MediaType.APPLICATION_JSON_VALUE, httpMethod = "POST")
    public ResultBuilder resumeJob(@RequestParam("jobName")String jobName,@RequestParam("jobGroup")String jobGroup) throws SchedulerException {
        jobService.resumeJob(jobName,jobGroup);
        return ResultBuilder.success();
    }
    @DeleteMapping("/removeJob")
    @ApiOperation(value = "删除任务", produces = MediaType.APPLICATION_JSON_VALUE, httpMethod = "DELETE")
    public ResultBuilder removeJob(@RequestParam("jobName")String jobName,@RequestParam("jobGroup")String jobGroup) throws SchedulerException {
        jobService.removeJob(jobName,jobGroup);
        return ResultBuilder.success();
    }

    @PostMapping("/rescheduleJob")
    @ApiOperation(value = "重新编排任务", produces = MediaType.APPLICATION_JSON_VALUE, httpMethod = "POST")
    public ResultBuilder rescheduleJob(@RequestBody QuartzJobDTO quartzJobDTO) throws SchedulerException {
        jobService.rescheduleJob(quartzJobDTO);
        return ResultBuilder.success();
    }



}
