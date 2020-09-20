package com.micro.service.springquartz.mapper;


import com.micro.service.springquartz.model.DataSourceInfo;

import java.util.List;

/**
 * @Author : JCccc
 * @CreateTime : 2019/10/23
 * @Description :
 **/
public interface DataSourceMapper {
    List<DataSourceInfo> get();
}