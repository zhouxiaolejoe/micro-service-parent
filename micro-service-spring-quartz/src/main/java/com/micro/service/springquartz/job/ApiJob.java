package com.micro.service.springquartz.job;/**
 * @Description
 * @Project micro-service-parent
 * @Package com.micro.service.springquartz.job
 * @Author Administrator
 * @Date 2020-10-07 14:23
 */

import com.micro.service.springquartz.sync.SyncScheduler;
import com.micro.service.springquartz.syncapi.IFaspClientScheduler;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.quartz.DisallowConcurrentExecution;
import org.quartz.JobDataMap;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.context.ApplicationContext;
import org.springframework.scheduling.quartz.QuartzJobBean;
import org.springframework.stereotype.Component;

import java.util.Map;
import java.util.TreeMap;

/**
 * @ClassName ApiJob
 * @Description TODO
 * @Author Administrator
 * @Date 2020/10/7 14:23
 * @Version 1.0.0
 */

@Slf4j
@Component//quartz使用反射可以自动注入
//禁止相同任务并发执行
@DisallowConcurrentExecution
@AllArgsConstructor
public class ApiJob extends QuartzJobBean {
    ApplicationContext faspContext;
    public static final String ORIGIN = "origin";
    public static final String TARGET = "target";

    @Override
    protected void executeInternal(JobExecutionContext context) {
        JobDataMap jobDataMap = context.getJobDetail().getJobDataMap();
        String origin = jobDataMap.getString(ORIGIN);
        String target = jobDataMap.getString(TARGET);
        if (faspContext != null) {
            Map<String, IFaspClientScheduler> m = faspContext.getBeansOfType(IFaspClientScheduler.class);
            Map<String, IFaspClientScheduler> treeMap = new TreeMap<>(String::compareTo);
            treeMap.putAll(m);
            for (IFaspClientScheduler scheduler : treeMap.values()) {
                try {
                    scheduler.start(origin,target);
                } catch (Exception e) {
                    log.error("IFaspClientScheduler run error " + scheduler.getClass().getName(), e);
                    JobExecutionException e2 = new JobExecutionException(e);
                    e2.setRefireImmediately(true);
                }
            }
        }
    }
}
