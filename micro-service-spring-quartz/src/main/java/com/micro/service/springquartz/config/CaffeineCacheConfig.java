package com.micro.service.springquartz.config;

import com.github.benmanes.caffeine.cache.Cache;
import com.github.benmanes.caffeine.cache.Caffeine;
import com.micro.service.springquartz.model.DataSourceInfo;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.List;
import java.util.concurrent.TimeUnit;


/**
* @Description 缓存
* @Author zxl
* @Date  2020-10-28  16:14:49
**/
@Configuration
public class CaffeineCacheConfig {

    @Bean
    public Cache<String, List<String>> caffeineCache() {
        return Caffeine.newBuilder()
                // 设置最后一次写入或访问后经过固定时间过期
                .expireAfterWrite(60, TimeUnit.DAYS)
                // 初始的缓存空间大小
                .initialCapacity(500)
                // 缓存的最大条数
                .maximumSize(2000)
                .build();
    }

    @Bean
    public Cache<String,List<DataSourceInfo>> dataCaffeineCache() {
        return Caffeine.newBuilder()
                // 设置最后一次写入或访问后经过固定时间过期
                .expireAfterWrite(60, TimeUnit.DAYS)
                // 初始的缓存空间大小
                .initialCapacity(500)
                // 缓存的最大条数
                .maximumSize(2000)
                .build();
    }
}
