package com.micro.service.springquartz.model;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;


/**
 * @Description
 * @Author zxl
 * @Date  2020-10-28  16:22:30
 **/
@Data
@ToString
public class DataSourceInfo {
    String guId;
    String datasourceid;
    String driverclassname;
    String url;
    String username;
    String password;
//    String publickey;
    String databasetype;
    String businesstype;
    String businessname;
    Integer delete;
    String createtime;
    String createuser;
    String updatetime;
    String updateuser;
//    Integer sync;
    String province;
    String year;
}