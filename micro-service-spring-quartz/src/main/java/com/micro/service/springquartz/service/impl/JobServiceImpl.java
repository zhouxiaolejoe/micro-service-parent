package com.micro.service.springquartz.service.impl;

import com.micro.service.springquartz.job.ApiJob;
import com.micro.service.springquartz.job.DSJob;
import com.micro.service.springquartz.job.TableJob;
import com.micro.service.springquartz.mapper.DataSourceMapper;
import com.micro.service.springquartz.mapper.QrtzJobDetailsMapper;
import com.micro.service.springquartz.model.DataSourceInfo;
import com.micro.service.springquartz.model.QrtzTriggerDetails;
import com.micro.service.springquartz.model.QuartzJobDTO;
import com.micro.service.springquartz.service.DBChangeService;
import com.micro.service.springquartz.service.JobService;
import com.micro.service.springquartz.utils.ResultBuilder;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.quartz.*;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.io.InputStream;
import java.sql.Blob;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import static org.quartz.SimpleScheduleBuilder.simpleSchedule;
import static org.quartz.TriggerBuilder.newTrigger;


/**
 * @ClassName JobServiceImpl
 * @Description TODO
 * @Author zxl
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
    DataSourceMapper dataSourceMapper;

    public static String timeStamp2Date(String seconds, String format) {
        if (seconds == null || seconds.isEmpty() || seconds.equals("null")) {
            return "";
        }
        if (format == null || format.isEmpty()) {
            format = "yyyy-MM-dd HH:mm:ss";
        }
        SimpleDateFormat sdf = new SimpleDateFormat(format);
        return sdf.format(new Date(Long.valueOf(seconds)));
    }

    public static String blobToString(Blob blob) {
        String blobToStr = "";
        if (blob != null) {
            try {
                InputStream inStream = blob.getBinaryStream();
                long nLen = blob.length();
                int nSize = (int) nLen;
                byte[] data = new byte[nSize];
                inStream.read(data);
                inStream.close();
                blobToStr = new String(data, "GBK");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return blobToStr;
    }

    @Override
    public Map<String, Object> getJobList(Integer pageNo, Integer pageSize) {
        try {
            dbChangeService.changeDb("mainDataSource");
        } catch (Exception e) {
            e.printStackTrace();
        }
//        PageHelper.startPage(pageNo,pageSize);
        List<QrtzTriggerDetails> qrtzTriggerDetails = qrtzJobDetailsMapper.selectAll();
//        PageInfo<QrtzTriggerDetails> pageInfo = PageInfo.of(qrtzTriggerDetails);


        qrtzTriggerDetails = qrtzTriggerDetails.stream().filter(x -> {
            x.setStartTime(timeStamp2Date(x.getStartTime(), null));
            x.setPrevFireTime(timeStamp2Date(x.getPrevFireTime(), null));
            x.setNextFireTime(timeStamp2Date(x.getNextFireTime(), null));
            JobDetail jobDetail = null;
            try {
                jobDetail = scheduler.getJobDetail(JobKey.jobKey(x.getJobName(), x.getJobName()));
            } catch (SchedulerException e) {
                e.printStackTrace();
            }
            JobDataMap jobDataMap = jobDetail.getJobDataMap();
            x.setOrigin((String) jobDataMap.get("origin"));
            x.setTarget((String) jobDataMap.get("target"));

            if (Integer.parseInt(x.getEndTime()) == 0) {
                x.setEndTime(null);
            }
            return true;
        }).collect(Collectors.toList());


        Map<String, Object> result = new HashMap<>();
        result.put("code", "1");
        result.put("msg", "sucess");
//        result.put("count",pageInfo.getTotal());
        result.put("pageNO", pageNo);
        result.put("pageSize", pageSize);
//        result.put("total",pageInfo.getTotal());
        result.put("data", qrtzTriggerDetails);
        return result;
    }

    private JobDetail changJodPattern(QuartzJobDTO quartzJobDTO) {
        JobBuilder jobBuilder;
        switch (quartzJobDTO.getType()) {
            case 1:
                jobBuilder = JobBuilder.newJob(DSJob.class);
                break;
            case 2:
                jobBuilder = JobBuilder.newJob(ApiJob.class);
                break;
            case 3:
                jobBuilder = JobBuilder.newJob(TableJob.class);
                break;
            default:
                jobBuilder = null;

        }
        return jobBuilder
                .withIdentity(quartzJobDTO.getJobName(), quartzJobDTO.getJobName())
                .withDescription(quartzJobDTO.getDescription())
                .build();
    }

    @Override
    public ResultBuilder addJob(QuartzJobDTO quartzJobDTO) throws SchedulerException {
        List<DataSourceInfo> origin = dataSourceMapper.selectAllByDatasourceid(quartzJobDTO.getOrigin());
        if (CollectionUtils.isEmpty(origin)) {
            return ResultBuilder.fail(null, "源库不存在");
        }
        List<DataSourceInfo> target = dataSourceMapper.selectAllByDatasourceid(quartzJobDTO.getTarget());
        if (CollectionUtils.isEmpty(target)) {
            return ResultBuilder.fail(null, "目标库不存在");
        }

        /**
         *  1.创建jobDetail
         */
        JobDetail job = changJodPattern(quartzJobDTO);
        JobDataMap map = job.getJobDataMap();
        map.put("origin", quartzJobDTO.getOrigin());
        map.put("target", quartzJobDTO.getTarget());
        map.put("tableName", quartzJobDTO.getTableName());
        String minute = quartzJobDTO.getCronExpression();
        int i = 1;
        try {
            i = Integer.parseInt(minute);
        } catch (NumberFormatException e) {
            return ResultBuilder.fail(null, "请输入数字");
        }
        String cronExpression = "0 0/placeholder * * * ? ".replace("placeholder", minute);
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
                        .cronSchedule(cronExpression)
                        .withMisfireHandlingInstructionDoNothing())
                .build();


//        SimpleTrigger trigger = newTrigger().withIdentity(quartzJobDTO.getJobName(), quartzJobDTO.getJobName())
//                .withDescription(quartzJobDTO.getDescription())
////                .startNow()
//                .startAt(DateBuilder.futureDate(2, DateBuilder.IntervalUnit.SECOND))
//                .withSchedule(simpleSchedule()
//                .withIntervalInMinutes(i)
//                .repeatForever()
//                .withMisfireHandlingInstructionFireNow())
//                .build();
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
