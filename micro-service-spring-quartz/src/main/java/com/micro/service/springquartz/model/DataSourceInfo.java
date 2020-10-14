package com.micro.service.springquartz.model;

import lombok.Data;
import lombok.ToString;


/**
 * @author Administrator
 */
@Data
@ToString
public class DataSourceInfo {
    String guId;
    String datasourceId;
    String driverclassname;
    String url;
    String userName;
    String passWord;
    String publickey;
    String databasetype;
    String businesstype;
    String businesname;
    Integer delete;
    Integer sync;
}