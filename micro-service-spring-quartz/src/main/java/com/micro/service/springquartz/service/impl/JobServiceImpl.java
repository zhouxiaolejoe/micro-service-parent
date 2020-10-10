package com.micro.service.springquartz.service.impl;

import com.micro.service.springquartz.job.ApiJob;
import com.micro.service.springquartz.job.DSJob;
import com.micro.service.springquartz.job.TableJob;
import com.micro.service.springquartz.mapper.QrtzJobDetailsMapper;
import com.micro.service.springquartz.model.QrtzTriggerDetails;
import com.micro.service.springquartz.model.QuartzJobDTO;
import com.micro.service.springquartz.service.DBChangeService;
import com.micro.service.springquartz.service.JobService;
import com.micro.service.springquartz.utils.ResultBuilder;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.quartz.*;
import org.springframework.stereotype.Service;

import java.util.List;


/**
 * @ClassName JobServiceImpl
 * @Description TODO
 * @Author ZhouXiaoLe
 * @Date 2019/7/31 10:10
 * @Version 1.0.0
 */
@Slf4j
@Service
@AllArgsConstructor
public class JobServiceImpl implements JobService {


    QrtzJobDetailsMapper qrtzJobDetailsMapper;
    DBChangeService dbChangeService;
    Scheduler scheduler;

    @Override
    public List<QrtzTriggerDetails> getJobList(QuartzJobDTO quartzJobDTO) {
        try {
            dbChangeService.changeDb("quartz");
        } catch (Exception e) {
            e.printStackTrace();
        }

        return qrtzJobDetailsMapper.selectAll();
    }

    private JobDetail changJodPattern(QuartzJobDTO quartzJobDTO) {
        JobDetail job = null;
        switch (quartzJobDTO.getType()) {
            case 1:
                job = JobBuilder
                        .newJob(DSJob.class)
                        .withIdentity(quartzJobDTO.getJobName(), quartzJobDTO.getJobName())
                        .withDescription(quartzJobDTO.getDescription())
                        .build();
                break;
            case 2:
                job = JobBuilder
                        .newJob(ApiJob.class)
                        .withIdentity(quartzJobDTO.getJobName(), quartzJobDTO.getJobName())
                        .withDescription(quartzJobDTO.getDescription())
                        .build();
                break;
            case 3:
                job = JobBuilder
                        .newJob(TableJob.class)
                        .withIdentity(quartzJobDTO.getJobName(), quartzJobDTO.getJobName())
                        .withDescription(quartzJobDTO.getDescription())
                        .build();
                break;
            default:
                job = null;

        }
        return job;
    }

    @Override
    public ResultBuilder addJob(QuartzJobDTO quartzJobDTO) throws SchedulerException {

        /**
         *  1.创建jobDetail
         */
        JobDetail job = changJodPattern(quartzJobDTO);
        JobDataMap map = job.getJobDataMap();
        map.put("origin", quartzJobDTO.getOrigin());
        map.put("target", quartzJobDTO.getTarget());
        map.put("tableName", quartzJobDTO.getTableName());

        /**
         *  2.创建触发器
         */
        Trigger trigger = TriggerBuilder
                .newTrigger()
                .withDescription(quartzJobDTO.getDescription())
//                .startNow() // 设置立刻启动
                .startAt(DateBuilder.futureDate(2, DateBuilder.IntervalUnit.SECOND))
                .withIdentity(quartzJobDTO.getJobName(), quartzJobDTO.getJobName())
                .withSchedule(CronScheduleBuilder
                        .cronSchedule(quartzJobDTO.getCronExpression())
                        .withMisfireHandlingInstructionDoNothing())
                .build();
        /**
         * withMisfireHandlingInstructionFireAndProceed任务超时立即触发
         * withMisfireHandlingInstructionDoNothing任务超时等下一次执行
         */
        /**
         * 3.关联job 和 触发器
         */
        this.scheduler.scheduleJob(job, trigger);
        return ResultBuilder.success();
    }

    @Override
    public ResultBuilder triggerJob(String jobName) throws SchedulerException {
        scheduler.triggerJob(JobKey.jobKey(jobName, jobName));
        return ResultBuilder.success();
    }

    @Override
    public ResultBuilder pauseJob(String jobName) throws SchedulerException {
        scheduler.pauseJob(JobKey.jobKey(jobName, jobName));
        return ResultBuilder.success();
    }

    @Override
    public ResultBuilder resumeJob(String jobName) throws SchedulerException {
        scheduler.resumeJob(JobKey.jobKey(jobName, jobName));
        return ResultBuilder.success();
    }

    @Override
    public ResultBuilder removeJob(String jobName) throws SchedulerException {

        TriggerKey triggerKey = TriggerKey.triggerKey(jobName, jobName);

        scheduler.pauseTrigger(triggerKey);

        scheduler.unscheduleJob(triggerKey);

        scheduler.deleteJob(JobKey.jobKey(jobName, jobName));

        return ResultBuilder.success();
    }

    @Override
    public ResultBuilder jobStatus(String jobName) throws SchedulerException {
        JobKey jobkey = JobKey.jobKey(jobName, jobName);
        TriggerKey triggerKey = scheduler.getTriggersOfJob(jobkey).get(0).getKey();
        Trigger.TriggerState triggerState = scheduler.getTriggerState(triggerKey);
        return ResultBuilder.success(triggerState);
    }

    @Override
    public ResultBuilder rescheduleJob(QuartzJobDTO quartzJobDTO) throws SchedulerException {
        /**
         *  注意此处 TriggerKey 封装是触发器名称和触发器组
         */
        TriggerKey triggerKey = TriggerKey.triggerKey(quartzJobDTO.getJobName(), quartzJobDTO.getJobName());
        Trigger trigger = TriggerBuilder
                .newTrigger()
                .startAt(DateBuilder.futureDate(5, DateBuilder.IntervalUnit.SECOND))
                .withDescription(quartzJobDTO.getDescription())
                .withIdentity(quartzJobDTO.getJobName(), quartzJobDTO.getJobName())
                .withSchedule(CronScheduleBuilder
                        .cronSchedule(quartzJobDTO.getCronExpression())
                        .withMisfireHandlingInstructionDoNothing())
                .build();
        scheduler.rescheduleJob(triggerKey, trigger);
        return ResultBuilder.success();
    }

    @Override
    public ResultBuilder pauseJobAll() throws SchedulerException {
        try {
            dbChangeService.changeDb("quartz");
        } catch (Exception e) {
            e.printStackTrace();
        }
        List<QrtzTriggerDetails> qrtzTriggerDetails = qrtzJobDetailsMapper.selectAll();
        for (QrtzTriggerDetails qg : qrtzTriggerDetails) {
            scheduler.pauseJob(JobKey.jobKey(qg.getJobName(), qg.getJobName()));
        }
        return ResultBuilder.success();
    }

    @Override
    public ResultBuilder resumeJobAll() throws SchedulerException {

        try {
            dbChangeService.changeDb("quartz");
        } catch (Exception e) {
            e.printStackTrace();
        }
        List<QrtzTriggerDetails> qrtzTriggerDetails = qrtzJobDetailsMapper.selectAll();
        for (QrtzTriggerDetails qg : qrtzTriggerDetails) {
            scheduler.resumeJob(JobKey.jobKey(qg.getJobName(), qg.getJobName()));
        }
        return ResultBuilder.success();
    }

    @Override
    public ResultBuilder removeJobAll() throws SchedulerException {
        try {
            dbChangeService.changeDb("quartz");
        } catch (Exception e) {
            e.printStackTrace();
        }
        List<QrtzTriggerDetails> qrtzTriggerDetails = qrtzJobDetailsMapper.selectAll();
        for (QrtzTriggerDetails qg : qrtzTriggerDetails) {
            TriggerKey triggerKey = TriggerKey.triggerKey(qg.getJobName(), qg.getJobName());
            scheduler.pauseTrigger(triggerKey);
            scheduler.unscheduleJob(triggerKey);
            scheduler.deleteJob(JobKey.jobKey(qg.getJobName(), qg.getJobName()));
        }
        return ResultBuilder.success();
    }
}
