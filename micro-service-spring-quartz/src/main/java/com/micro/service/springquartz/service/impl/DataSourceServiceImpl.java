package com.micro.service.springquartz.service.impl;/**
 * @Description
 * @Project micro-service-parent
 * @Package com.micro.service.springquartz.service.impl
 * @Author Administrator
 * @Date 2020-10-13 15:29
 */

import com.micro.service.springquartz.config.DynamicDataSource;
import com.micro.service.springquartz.mapper.DataSourceMapper;
import com.micro.service.springquartz.model.DataSourceInfo;
import com.micro.service.springquartz.service.DBChangeService;
import com.micro.service.springquartz.service.DataSourceService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @ClassName DataSourceServiceImpl
 * @Description TODO
 * @Author Administrator
 * @Date 2020/10/13 15:29
 * @Version 1.0.0
 */
@Service
@AllArgsConstructor
public class DataSourceServiceImpl implements DataSourceService {
    DataSourceMapper dataSourceMapper;
    DynamicDataSource dynamicDataSource;
    DBChangeService changeService;

    @Override
    public List<DataSourceInfo> get() {
        try {
            changeService.changeDb("mainDataSource");
        } catch (Exception e) {
            e.printStackTrace();
        }
        List<DataSourceInfo> dataSourceInfos = dataSourceMapper.get();
        return dataSourceInfos;
    }

    @Override
    public int insertDatasourceInfo(DataSourceInfo dataSourceInfo) {
        try {
            changeService.changeDb(dataSourceInfo.getDatasourceId());
            changeService.changeDb("mainDataSource");
        } catch (Exception e) {
            e.printStackTrace();
        }

        return dataSourceMapper.insertDatasourceInfo(dataSourceInfo);
    }

    @Override
    public int deleteDataSourceByDatasourceId(String datasourceId) {
        try {
            changeService.changeDb("mainDataSource");
            changeService.deleteDb(datasourceId);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return dataSourceMapper.deleteDataSourceByDatasourceId(datasourceId);
    }
}
