package com.micro.service.springquartz.service.impl;


import com.github.benmanes.caffeine.cache.Cache;
import com.micro.service.springquartz.config.DBContextHolder;
import com.micro.service.springquartz.config.DynamicDataSource;
import com.micro.service.springquartz.mapper.DataSourceMapper;
import com.micro.service.springquartz.model.DataSourceInfo;
import com.micro.service.springquartz.model.ThreadLocalDSInfo;
import com.micro.service.springquartz.service.DBChangeService;
import javafx.scene.effect.Bloom;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.BadSqlGrammarException;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.List;
import java.util.Map;

/**
 * @Author : JCccc
 * @CreateTime : 2019/10/22
 * @Description :
 **/
@Service
@Slf4j
@AllArgsConstructor
public class DBChangeServiceImpl implements DBChangeService {

    DataSourceMapper dataSourceMapper;
    Cache<String, List<DataSourceInfo>> dataCaffeineCache;
    DynamicDataSource dynamicDataSource;

    @Override
    public List<DataSourceInfo> get() {
        return dataSourceMapper.get();
    }
    @Override
    public List<Map<String,Object>> get1() {
        return dataSourceMapper.get1();
    }
    @Override
    public boolean changeDb(String datasourceId) throws Exception {

        //默认切换到主数据源,进行整体资源的查找
        DBContextHolder.clearDataSource();

        List<DataSourceInfo> dataSourcesList = dataCaffeineCache.asMap().get("dataSourceInfos");
        if (StringUtils.isEmpty(dataSourcesList)) {
            /**
             * 注意新增删除更新缓存
             */
            dataSourcesList = dataSourceMapper.get();
            dataCaffeineCache.asMap().put("dataSourceInfos", dataSourcesList);
        }
        for (DataSourceInfo dataSource : dataSourcesList) {
            if (dataSource.getDatasourceId().equals(datasourceId)) {
                //创建数据源连接&检查 若存在则不需重新创建
                dynamicDataSource.createDataSourceWithCheck(dataSource);
                //切换到该数据源
                ThreadLocalDSInfo threadLocalDSInfo = new ThreadLocalDSInfo();
                BeanUtils.copyProperties(dataSource, threadLocalDSInfo);
                DBContextHolder.setDataSource(threadLocalDSInfo);
                return true;
            }
        }
        return false;

    }

    @Override
    public boolean deleteDb(String datasourceId) throws Exception {
       return dynamicDataSource.delDatasources(datasourceId);
    }

}