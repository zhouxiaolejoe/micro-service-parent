package com.micro.service.springquartz.mapper;


import com.micro.service.springquartz.model.DataSourceInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @Author : JCccc
 * @CreateTime : 2019/10/23
 * @Description :
 **/
public interface DataSourceMapper {
    List<DataSourceInfo> get();

    List<Map<String, Object>> get1();

    List<DataSourceInfo> selectAllByDatasourceid(@Param("datasourceid") String datasourceid);

    int insertDatasourceInfo(DataSourceInfo dataSourceInfo);

    int deleteDataSourceByDatasourceId(@Param("datasourceId") String datasourceId);
}