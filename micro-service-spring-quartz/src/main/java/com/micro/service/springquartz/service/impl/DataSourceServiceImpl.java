package com.micro.service.springquartz.service.impl;/**
 * @Description
 * @Project micro-service-parent
 * @Package com.micro.service.springquartz.service.impl
 * @Author Administrator
 * @Date 2020-10-13 15:29
 */

import com.github.benmanes.caffeine.cache.Cache;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.micro.service.springquartz.config.DynamicDataSource;
import com.micro.service.springquartz.mapper.DataSourceMapper;
import com.micro.service.springquartz.model.DataSourceInfo;
import com.micro.service.springquartz.service.DBChangeService;
import com.micro.service.springquartz.service.DataSourceService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
    Cache<String, List<DataSourceInfo>> dataCaffeineCache;

    @Override
    public Map<String, Object> get(Integer pageNo, Integer pageSize) {
        try {
            changeService.changeDb("mainDataSource");
        } catch (Exception e) {
            e.printStackTrace();
        }
        PageHelper.startPage(pageNo,pageSize);
        List<DataSourceInfo> dataSourceInfos = dataSourceMapper.get();
        PageInfo<DataSourceInfo> pageInfo = PageInfo.of(dataSourceInfos);
        Map<String, Object> result = new HashMap<>();
        result.put("code","1");
        result.put("msg","sucess");
        result.put("count",pageInfo.getTotal());
        result.put("pageNO",pageNo);
        result.put("pageSize",pageSize);
        result.put("total",pageInfo.getTotal());
        result.put("data",pageInfo.getList());
        return result;
    }

    @Override
    public int insertDatasourceInfo(DataSourceInfo dataSourceInfo) {
        int flag = 0;
        try {

            changeService.changeDb("mainDataSource");
            flag = dataSourceMapper.insertDatasourceInfo(dataSourceInfo);
            List<DataSourceInfo> dataSourcesList = dataCaffeineCache.asMap().get("dataSourceInfos");
            if (!CollectionUtils.isEmpty(dataSourcesList)) {
                dataSourcesList = dataSourceMapper.get();
                dataSourcesList.add(dataSourceInfo);
                dataCaffeineCache.asMap().put("dataSourceInfos", dataSourcesList);
            }
            changeService.changeDb(dataSourceInfo.getDatasourceid());
        } catch (Exception e) {
            e.printStackTrace();
        }

        return flag;
    }

    @Override
    public int deleteDataSourceByDatasourceId(String datasourceId) {
        int flag = 0;
        try {

            changeService.changeDb("mainDataSource");
            flag = dataSourceMapper.deleteDataSourceByDatasourceId(datasourceId);
            List<DataSourceInfo> dataSourcesList = dataCaffeineCache.asMap().get("dataSourceInfos");
            if (!CollectionUtils.isEmpty(dataSourcesList)) {
                dataSourcesList = dataSourceMapper.get();
                dataSourcesList.remove(datasourceId);
                dataCaffeineCache.asMap().put("dataSourceInfos", dataSourcesList);
            }
            changeService.deleteDb(datasourceId);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return flag;
    }
}
