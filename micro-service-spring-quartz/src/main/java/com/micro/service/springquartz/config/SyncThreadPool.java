package com.micro.service.springquartz.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.concurrent.CustomizableThreadFactory;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

/**
 * @ClassName TestThreadPool
 * @Description TODO
 * @Author zxl
 * @Date 2020/8/15 10:33
 * @Version 1.0.0
 */
@Configuration
public class SyncThreadPool {

    public static final int corePoolSize = Runtime.getRuntime().availableProcessors() + 1;

    public static final int maxPoolSize = 30;

    public static final int keepAliveSeconds = 3600;

    public static final int queueCapacity = 50;

    @Bean
    public ExecutorService syncExecutorService() {
        CustomizableThreadFactory customizableThreadFactory = new CustomizableThreadFactory();
        customizableThreadFactory.setThreadGroupName("SyncThread");
        customizableThreadFactory.setThreadNamePrefix("sync-");
        ThreadPoolExecutor executor = new ThreadPoolExecutor(
                corePoolSize,
                maxPoolSize,
                keepAliveSeconds,
                TimeUnit.SECONDS,
                new LinkedBlockingQueue(queueCapacity),
                customizableThreadFactory,
                new ThreadPoolExecutor.CallerRunsPolicy()
        );
        return executor;
    }
}
