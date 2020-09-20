package com.micro.service.springquartz.job;

import lombok.extern.slf4j.Slf4j;
import org.quartz.JobDataMap;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.quartz.JobKey;
import org.springframework.scheduling.quartz.QuartzJobBean;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @ClassName MyJob
 * @Description TODO
 * @Author ZhouXiaoLe
 * @Date 2019/7/31 9:30
 * @Version 1.0.0
 */
@Slf4j
public class MyJob extends QuartzJobBean {
    @Override
    protected void executeInternal(JobExecutionContext context) throws JobExecutionException {
        Date time1 = context.getFireTime();
        long runTime = context.getJobRunTime();
        Date nextFireTime = context.getNextFireTime();
        Date previousFireTime = context.getPreviousFireTime();
        Object result = context.getResult();
        JobDataMap jobDataMap = context.getJobDetail().getJobDataMap();
        String string = jobDataMap.getString("");

        SimpleDateFormat format = new SimpleDateFormat("yyyy-mm-dd HH:mm:ss");
        String time = format.format(System.currentTimeMillis());
//        String result = OkHttpUtil.getStringFromServer("http://127.0.0.1:8082/getTime/"+time);
        JobKey jobKey = context.getJobDetail().getKey();
        log.warn(String.format("[%s]正在执行,时间: %s", jobKey,time));
    }
}
