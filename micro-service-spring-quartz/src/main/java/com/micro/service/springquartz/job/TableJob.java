package com.micro.service.springquartz.job;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.quartz.DisallowConcurrentExecution;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;
import org.springframework.stereotype.Component;

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
    public static final String ORIGIN_TABLE = "originTable";
    public static final String TARGET_TABLE = "targetTable";


    @Override
    protected void executeInternal(JobExecutionContext jobExecutionContext) throws JobExecutionException {

    }
}
