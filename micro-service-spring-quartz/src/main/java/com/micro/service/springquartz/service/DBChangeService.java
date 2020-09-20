package com.micro.service.springquartz.service;


import com.micro.service.springquartz.model.DataSourceInfo;

import java.util.List;

/**
 * @Author : JCccc
 * @CreateTime : 2019/10/22
 * @Description :
 **/
 
public interface DBChangeService {
 
    List<DataSourceInfo> get();
 
    boolean changeDb(String datasourceId) throws Exception;
 
}