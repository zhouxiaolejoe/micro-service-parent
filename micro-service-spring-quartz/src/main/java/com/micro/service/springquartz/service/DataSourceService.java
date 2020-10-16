package com.micro.service.springquartz.service;

import com.micro.service.springquartz.model.DataSourceInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @Description
 * @Project micro-service-parent
 * @Package com.micro.service.springquartz.service
 * @Author Administrator
 * @Date 2020-10-13 15:29
 */
public interface DataSourceService {
    Map<String, Object> get(Integer pageNo, Integer pageSize);

    int insertDatasourceInfo(DataSourceInfo dataSourceInfo);

    int deleteDataSourceByDatasourceId(@Param("datasourceId") String datasourceId);
}
