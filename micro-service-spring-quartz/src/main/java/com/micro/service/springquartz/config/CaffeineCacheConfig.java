package com.micro.service.springquartz.config;/**
 * @Description
 * @Project root
 * @Package gov.mof.pushdata.fasp3client.autoconfigure
 * @Author Administrator
 * @Date 2020-09-09 16:08
 */


import com.github.benmanes.caffeine.cache.Cache;
import com.github.benmanes.caffeine.cache.Caffeine;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.List;
import java.util.concurrent.TimeUnit;


/**
 * @ClassName GuavaCacheConfig
 * @Description TODO
 * @Author Administrator
 * @Date 2020/9/9 16:08
 * @Version 1.0.0
 */
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
}
