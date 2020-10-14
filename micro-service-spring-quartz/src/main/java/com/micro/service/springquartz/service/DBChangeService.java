package com.micro.service.springquartz.service;


import com.micro.service.springquartz.model.DataSourceInfo;

import java.util.List;
import java.util.Map;

/**
 * @Author : JCccc
 * @CreateTime : 2019/10/22
 * @Description :
 **/
 
public interface DBChangeService {
 
    List<DataSourceInfo> get();
    List<Map<String,Object>> get1();

    boolean changeDb(String datasourceId) throws Exception;
    boolean deleteDb(String datasourceId) throws Exception;

}