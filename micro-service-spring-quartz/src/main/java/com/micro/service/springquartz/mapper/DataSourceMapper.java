package com.micro.service.springquartz.mapper;


import com.micro.service.springquartz.model.DataSourceInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
* @Description
* @Author zxl
* @Date  2020-10-28  16:22:12
**/
public interface DataSourceMapper {
    List<DataSourceInfo> get();

    DataSourceInfo getOne(@Param("datasourceid")String datasourceid);

    List<DataSourceInfo> selectAllByDatasourceid(@Param("datasourceid") String datasourceid);

    int insertDatasourceInfo(DataSourceInfo dataSourceInfo);

    int deleteDataSourceByDatasourceId(@Param("datasourceId") String datasourceId);
}