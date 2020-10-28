package com.micro.service.springquartz.service.impl;

import com.github.benmanes.caffeine.cache.Cache;
import com.micro.service.springquartz.mapper.target.SyncDicDSMapper;
import com.micro.service.springquartz.mapper.target.SyncRangeMapper;
import com.micro.service.springquartz.service.CaffeineCacheService;
import com.micro.service.springquartz.service.DBChangeService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.List;
import java.util.concurrent.ConcurrentMap;

/**
 * @ClassName CaffeineCacheServiceImpl
 * @Description TODO
 * @Author zxl
 * @Date 2020/10/7 16:34
 * @Version 1.0.0
 */
@Service
@AllArgsConstructor
public class CaffeineCacheServiceImpl implements CaffeineCacheService {

    DBChangeService changeService;
    SyncRangeMapper syncRangeMapper;
    Cache<String, List<String>> caffeineCache;
    SyncDicDSMapper syncDicDSMapper;


    @Override
    public void saveUserTableViewNotNull(String target) {
        ConcurrentMap<String, List<String>> concurrentMap = caffeineCache.asMap();
        List<String> tableList = concurrentMap.get("tableList_" + target);
        List<String> viewList = concurrentMap.get("viewList_" + target);
        if (StringUtils.isEmpty(tableList) && StringUtils.isEmpty(viewList)) {
            tableList = syncDicDSMapper.queryTableList();
            viewList = syncDicDSMapper.queryViewList();
            concurrentMap.put("tableList_" + target, tableList);
            concurrentMap.put("viewList_" + target, viewList);
        }

    }

    @Override
    public void saveUserTableView(String target) {
        ConcurrentMap<String, List<String>> concurrentMap = caffeineCache.asMap();
        concurrentMap.remove("tableList_" + target);
        concurrentMap.remove("viewList_" + target);
        List<String> tableList = syncDicDSMapper.queryTableList();
        List<String> viewList = syncDicDSMapper.queryViewList();
        concurrentMap.put("tableList_" + target, tableList);
        concurrentMap.put("viewList_" + target, viewList);
    }
}
