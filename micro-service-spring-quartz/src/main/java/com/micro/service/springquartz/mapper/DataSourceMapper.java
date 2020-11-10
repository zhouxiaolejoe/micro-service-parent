package com.micro.service.springquartz.mapper;


import com.micro.service.springquartz.model.DataSourceInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @Description
 * @Author zxl
 * @Date 2020-10-28  16:22:12
 **/
public interface DataSourceMapper {
    List<DataSourceInfo> get();

    List<DataSourceInfo> getServerId(@Param("serverid") String serverid);

    List<DataSourceInfo> getDatasourceId(@Param("datasourceid") String datasourceid);

    DataSourceInfo getOne(@Param("datasourceid") String datasourceid);

    List<DataSourceInfo> selectAllByDatasourceid(@Param("datasourceid") String datasourceid);

    int insertDatasourceInfo(DataSourceInfo dataSourceInfo);

    int deleteDataSourceByDatasourceId(@Param("datasourceId") String datasourceId);
}