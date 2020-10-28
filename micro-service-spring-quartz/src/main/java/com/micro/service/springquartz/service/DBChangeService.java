package com.micro.service.springquartz.service;


import com.micro.service.springquartz.model.DataSourceInfo;

import java.util.List;

/**
 * @Description
 * @Author zxl
 * @Date 2020-10-28  16:25:44
 **/

public interface DBChangeService {

    List<DataSourceInfo> get();

    DataSourceInfo getOne(String datasourceid);

    boolean changeDb(String datasourceId) throws Exception;

    boolean deleteDb(String datasourceId) throws Exception;

}