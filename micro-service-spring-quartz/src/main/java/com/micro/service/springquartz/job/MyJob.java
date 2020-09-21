package com.micro.service.springquartz.job;

import com.micro.service.springquartz.mapper.FaspTPubmenuMapper;
import com.micro.service.springquartz.model.FaspTPubmenu;
import com.micro.service.springquartz.service.DBChangeService;
import com.micro.service.springquartz.sync.IFaspClientScheduler;
import com.micro.service.springquartz.sync.SyncRoleService;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.quartz.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.scheduling.quartz.QuartzJobBean;
import org.springframework.stereotype.Component;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;
import java.util.TreeMap;

/**
 * @ClassName MyJob
 * @Description TODO
 * @Author ZhouXiaoLe
 * @Date 2019/7/31 9:30
 * @Version 1.0.0
 */
@Slf4j
@Component
//禁止相同任务并发执行
@DisallowConcurrentExecution
@AllArgsConstructor
public class MyJob extends QuartzJobBean {
    public static final String ORIGIN = "origin";
    public static final String TARGET = "target";
    DBChangeService changeService;
    FaspTPubmenuMapper pubmenuMapper;
    SyncRoleService syncRoleService;
    ApplicationContext faspContext;

    @SneakyThrows
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
                    scheduler.start(origin, target);
                } catch (Exception e) {
                    log.error("IFaspClientScheduler run error " + scheduler.getClass().getName(), e);
                }
            }
        }
        SimpleDateFormat format = new SimpleDateFormat("yyyy-mm-dd HH:mm:ss");
        String time = format.format(System.currentTimeMillis());
        JobKey jobKey = context.getJobDetail().getKey();
        log.debug(String.format("[%s]正在执行,时间: %s", jobKey, time));
    }
}
