package com.micro.service.springquartz.controller;

import com.micro.service.springquartz.model.DataSourceDTO;
import com.micro.service.springquartz.model.DataSourceInfo;
import com.micro.service.springquartz.model.QuartzJobDTO;
import com.micro.service.springquartz.service.DBChangeService;
import com.micro.service.springquartz.service.DataSourceService;
import com.micro.service.springquartz.service.JobService;
import com.micro.service.springquartz.utils.ResultBuilder;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import org.quartz.SchedulerException;
import org.springframework.beans.BeanUtils;
import org.springframework.context.ApplicationContext;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

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
    DataSourceService dataSourceService;
    ApplicationContext ctx;

    @GetMapping("/getJobList")
    @ApiOperation(value = "任务列表", produces = MediaType.APPLICATION_JSON_VALUE, httpMethod = "GET")
    public Map<String, Object> getJobList(@RequestParam("page") Integer page, @RequestParam("limit") Integer limit) {
        return jobService.getJobList(page, limit);
    }

    @PostMapping("/addJob")
    @ApiOperation(value = "新增任务", produces = MediaType.APPLICATION_JSON_VALUE, httpMethod = "POST")
    public ResultBuilder addJob(@RequestBody QuartzJobDTO quartzJobDTO) throws SchedulerException {
        if (quartzJobDTO.getOrigin().equalsIgnoreCase(quartzJobDTO.getTarget())) {
            return ResultBuilder.fail(null, "源库与目标库相同");
        }
        return jobService.addJob(quartzJobDTO);
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
        jobService.resumeJobAll();
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
        if (quartzJobDTO.getOrigin().equalsIgnoreCase(quartzJobDTO.getTarget())) {
            return ResultBuilder.fail(null, "源库与目标库相同");
        }
        jobService.rescheduleJob(quartzJobDTO);
        return ResultBuilder.success();
    }

    @GetMapping("/getDataSourceList")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "page", value = "page", required = true, dataType = "Integer", paramType = "query"),
            @ApiImplicitParam(name = "limit", value = "limit", required = true, dataType = "Integer", paramType = "query")
    })
    @ApiOperation(value = "获取数据源列表", produces = MediaType.APPLICATION_JSON_VALUE, httpMethod = "GET")
    public Map<String, Object> getDataSourceList(@RequestParam("page") Integer page, @RequestParam("limit") Integer limit) {
        return dataSourceService.get(page, limit);
    }

    @PostMapping("/insertDataSourceInfo")
    @ApiOperation(value = "新增数据源", produces = MediaType.APPLICATION_JSON_VALUE, httpMethod = "POST")
    public ResultBuilder insertDataSourceInfo(@RequestBody DataSourceDTO dataSourceDTO) {
        DataSourceInfo dataSourceInfo = new DataSourceInfo();
        BeanUtils.copyProperties(dataSourceDTO, dataSourceInfo);
        dataSourceService.insertDatasourceInfo(dataSourceInfo);
        return ResultBuilder.success();
    }

    @DeleteMapping("/deleteDataSourceInfo")
    @ApiOperation(value = "删除数据源", httpMethod = "DELETE")
    public ResultBuilder deleteDataSourceInfo(@RequestParam("datasourceid") String datasourceid) {
        dataSourceService.deleteDataSourceByDatasourceId(datasourceid);
        return ResultBuilder.success();
    }

    @GetMapping("/testFreemarker")
    @ApiOperation(value = "testFreemarker", httpMethod = "GET")
    public ResultBuilder testFreemarker() {
        dataSourceService.testFreemarker();
        return ResultBuilder.success();
    }


    @GetMapping("/readLogFile")
    @ApiOperation(value = "readLogFile", httpMethod = "GET")
    public ResultBuilder readLogFile() {
        return dataSourceService.readLogFile();
    }
}
