package com.micro.service.springquartz.job;

import com.micro.service.springquartz.mapper.FaspTPubmenuMapper;
import com.micro.service.springquartz.model.FaspTPubmenu;
import com.micro.service.springquartz.service.DBChangeService;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.quartz.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.quartz.QuartzJobBean;
import org.springframework.stereotype.Component;

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
@Component
//禁止相同任务并发执行
@DisallowConcurrentExecution
public class MyJob extends QuartzJobBean {
    public static final String MESSAGE = "msg";
    public static final String ID = "guid";
    public static final String DATASOURCEID = "datasourceid";
    @Autowired
    DBChangeService changeService;
    @Autowired
    FaspTPubmenuMapper pubmenuMapper;

    @SneakyThrows
    @Override
    protected void executeInternal(JobExecutionContext context) {
        JobDataMap jobDataMap = context.getJobDetail().getJobDataMap();
        String guid = jobDataMap.getString(ID);
        String datasourceid = jobDataMap.getString(DATASOURCEID);
        changeService.changeDb(datasourceid);
        FaspTPubmenu faspTPubmenu = pubmenuMapper.selectOneByGuid(guid);
        System.err.println(datasourceid + ": " + faspTPubmenu);
        SimpleDateFormat format = new SimpleDateFormat("yyyy-mm-dd HH:mm:ss");
        String time = format.format(System.currentTimeMillis());
        JobKey jobKey = context.getJobDetail().getKey();
        log.info(String.format("[%s]正在执行,时间: %s", jobKey, time));
    }
}
