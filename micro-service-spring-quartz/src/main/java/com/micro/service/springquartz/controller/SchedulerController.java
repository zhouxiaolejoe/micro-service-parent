package com.micro.service.springquartz.controller;

import com.micro.service.springquartz.model.DataSourceInfo;
import com.micro.service.springquartz.model.QuartzJobDTO;
import com.micro.service.springquartz.service.DBChangeService;
import com.micro.service.springquartz.service.JobService;
import com.micro.service.springquartz.utils.ResultBuilder;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import org.quartz.SchedulerException;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

import java.util.List;

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
    DBChangeService dbChangeService;


    @GetMapping("/getJobList")
    @ApiOperation(value = "任务列表", produces = MediaType.APPLICATION_JSON_VALUE, httpMethod = "GET")
    public ResultBuilder getJobList() {
        return ResultBuilder.success(jobService.getJobList(null));
    }

    @PostMapping("/addJob")
    @ApiOperation(value = "新增任务", produces = MediaType.APPLICATION_JSON_VALUE, httpMethod = "POST")
    public ResultBuilder addJob(@RequestBody QuartzJobDTO quartzJobDTO) throws SchedulerException {
        jobService.addJob(quartzJobDTO);
        return ResultBuilder.success();
    }

    @GetMapping("/jobStatus")
    @ApiOperation(value = "任务状态", produces = MediaType.APPLICATION_JSON_VALUE, httpMethod = "GET")
    public ResultBuilder jobStatus(@RequestParam("jobName") String jobName) throws SchedulerException {
        return jobService.jobStatus(jobName);
    }

    @PostMapping("/triggerJob")
    @ApiOperation(value = "触发任务", produces = MediaType.APPLICATION_JSON_VALUE, httpMethod = "POST")
    public ResultBuilder triggerJob(@RequestParam("jobName") String jobName) throws SchedulerException {
        jobService.triggerJob(jobName);
        return ResultBuilder.success();
    }

    @PostMapping("/pauseJobAll")
    @ApiOperation(value = "暂停所有任务", produces = MediaType.APPLICATION_JSON_VALUE, httpMethod = "POST")
    public ResultBuilder pauseJobAll() throws SchedulerException {
        jobService.pauseJobAll();
        return ResultBuilder.success();
    }

    @PostMapping("/pauseJob")
    @ApiOperation(value = "暂停任务", produces = MediaType.APPLICATION_JSON_VALUE, httpMethod = "POST")
    public ResultBuilder pauseJob(@RequestParam("jobName") String jobName) throws SchedulerException {
        jobService.pauseJob(jobName);
        return ResultBuilder.success();
    }


    @PostMapping("/resumeJob")
    @ApiOperation(value = "恢复任务", produces = MediaType.APPLICATION_JSON_VALUE, httpMethod = "POST")
    public ResultBuilder resumeJob(@RequestParam("jobName") String jobName) throws SchedulerException {
        jobService.resumeJob(jobName);
        return ResultBuilder.success();
    }

    @PostMapping("/resumeJobAll")
    @ApiOperation(value = "恢复所有任务", produces = MediaType.APPLICATION_JSON_VALUE, httpMethod = "POST")
    public ResultBuilder resumeJobAll() throws SchedulerException {
        jobService.removeJobAll();
        return ResultBuilder.success();
    }

    @DeleteMapping("/removeJob")
    @ApiOperation(value = "删除任务", produces = MediaType.APPLICATION_JSON_VALUE, httpMethod = "DELETE")
    public ResultBuilder removeJob(@RequestParam("jobName") String jobName) throws SchedulerException {
        jobService.removeJob(jobName);
        return ResultBuilder.success();
    }

    @DeleteMapping("/removeJobAll")
    @ApiOperation(value = "删除所有任务", produces = MediaType.APPLICATION_JSON_VALUE, httpMethod = "DELETE")
    public ResultBuilder removeJobAll() throws SchedulerException {
        jobService.removeJobAll();
        return ResultBuilder.success();
    }


    @PostMapping("/rescheduleJob")
    @ApiOperation(value = "重新编排任务", produces = MediaType.APPLICATION_JSON_VALUE, httpMethod = "POST")
    public ResultBuilder rescheduleJob(@RequestBody QuartzJobDTO quartzJobDTO) throws SchedulerException {
        jobService.rescheduleJob(quartzJobDTO);
        return ResultBuilder.success();
    }
    @PostMapping("/test1")
    @ApiOperation(value = "重新编排任务", produces = MediaType.APPLICATION_JSON_VALUE, httpMethod = "POST")
    public ResultBuilder test(@RequestBody QuartzJobDTO quartzJobDTO) throws SchedulerException {
        List<DataSourceInfo> dataSourceInfos = dbChangeService.get();
        return ResultBuilder.success(dataSourceInfos);
    }

}
