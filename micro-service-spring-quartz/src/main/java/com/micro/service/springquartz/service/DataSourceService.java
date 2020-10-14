package com.micro.service.springquartz.service;

import com.micro.service.springquartz.model.DataSourceInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @Description
 * @Project micro-service-parent
 * @Package com.micro.service.springquartz.service
 * @Author Administrator
 * @Date 2020-10-13 15:29
 */
public interface DataSourceService {
    List<DataSourceInfo> get();
    int insertDatasourceInfo(DataSourceInfo dataSourceInfo);
    int deleteDataSourceByDatasourceId(@Param("datasourceId")String datasourceId);
}
