package com.micro.service.springquartz.job;

import com.micro.service.springquartz.sync.SyncTableScheduler;
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
 * @ClassName TableJob
 * @Description TODO
 * @Author Administrator
 * @Date 2020/9/23 9:59
 * @Version 1.0.0
 */
@Slf4j
@Component
@DisallowConcurrentExecution
@AllArgsConstructor
public class TableJob extends QuartzJobBean {

    public static final String ORIGIN = "origin";
    public static final String TARGET = "target";
    public static final String TABLE_NAME = "tableName";
    ApplicationContext tableContext;

    @Override
    protected void executeInternal(JobExecutionContext context) {
        JobDataMap jobDataMap = context.getJobDetail().getJobDataMap();
        String origin = jobDataMap.getString(ORIGIN);
        String target = jobDataMap.getString(TARGET);
        String tableName = jobDataMap.getString(TABLE_NAME);
        if (tableContext != null) {
            Map<String, SyncTableScheduler> m = tableContext.getBeansOfType(SyncTableScheduler.class);
            Map<String, SyncTableScheduler> treeMap = new TreeMap<>(String::compareTo);
            treeMap.putAll(m);
            for (SyncTableScheduler scheduler : treeMap.values()) {
                try {
                    scheduler.syncTable(origin, tableName, target);
                } catch (Exception e) {
                    log.error("IFaspClientScheduler run error " + scheduler.getClass().getName(), e);
                    JobExecutionException e2 = new JobExecutionException(e);
                    e2.setRefireImmediately(true);
                }
            }
        }
    }

}
