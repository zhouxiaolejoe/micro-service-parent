package com.micro.service.springquartz.config;


import com.micro.service.springquartz.mapper.DataSourceMapper;
import com.micro.service.springquartz.model.DataSourceInfo;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.ApplicationListener;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.core.annotation.Order;
import org.springframework.util.CollectionUtils;

import java.util.List;


/**
* @Description
* @Author zxl
* @Date  2020-10-28  16:16:31
**/
@Order(-1)
@Configuration
@Slf4j
@AllArgsConstructor
public class InitDataSource implements ApplicationListener<ContextRefreshedEvent> {
    DynamicDataSource dynamicDataSource;
    DataSourceMapper dataSourceMapper;

    @Override
    public void onApplicationEvent(ContextRefreshedEvent contextRefreshedEvent) {
        List<DataSourceInfo> dataSources = dataSourceMapper.get();
        if (CollectionUtils.isEmpty(dataSources)){
            log.info("当前数据源列表为空");
            return;
        }
        for (DataSourceInfo dataSource : dataSources) {
            log.debug(String.format("初始化数据源,datasourceId是: [ %s ]", dataSource.getDatasourceid()));
            try {
                dynamicDataSource.createDataSourceWithCheck(dataSource);
            } catch (Exception e) {
                log.debug("创建数据源失败......");
            }
        }

    }
}
