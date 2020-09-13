package com.micro.service.springwebsocket.config.schedule;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;

import java.util.concurrent.Executor;

@Configuration
@EnableAsync
@EnableScheduling
public class AsyncTaskConfig {

    @Value("${task.corePoolSize}")
    private int corePoolSize;
    @Value("${task.maxPoolSize}")
    private int maxPoolSize;
    @Value("${task.queueCapacity}")
    private int queueCapacity;

    /**
     * @return java.util.concurrent.Executor
     * @Description 线程池配置
     * @Author ZhouXiaoLe
     * @Date 2019/7/17  17:29
     * @Param []
     **/
    @Bean
    public Executor taskExecutor() {
        ThreadPoolTaskExecutor executor = new ThreadPoolTaskExecutor();
        executor.setCorePoolSize(corePoolSize);
        executor.setMaxPoolSize(maxPoolSize);
        executor.setQueueCapacity(queueCapacity);
        executor.initialize();
        return executor;
    }
}
