package com.micro.service.springquartz.sync;

import com.github.benmanes.caffeine.cache.Cache;
import com.micro.service.springquartz.mapper.target.SyncDicDSMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;

import java.util.List;

/**
 * @ClassName SyncCaffeineCache
 * @Description TODO
 * @Author zxl
 * @Date 2020/9/22 19:38
 * @Version 1.0.0
 */
@EnableScheduling
@Configuration
public class SyncCaffeineCache {

    private static final Logger logger = LoggerFactory.getLogger(SyncCaffeineCache.class);
    @Autowired
    Cache<String, List<String>> caffeineCache;

    @Autowired
    SyncDicDSMapper dao;

    /**
     * 每天执行一次用户数据表
     */
    @Scheduled(cron = "0 0 0 1/1 * ? ")
    public void tableViewSync() {
        caffeineCache.invalidateAll();
        List<String> tableList = dao.queryTableList();
        caffeineCache.put("tableList", tableList);
        List<String> viewList = dao.queryViewList();
        caffeineCache.put("viewList", viewList);
        logger.info("用户表更新");
    }

}
