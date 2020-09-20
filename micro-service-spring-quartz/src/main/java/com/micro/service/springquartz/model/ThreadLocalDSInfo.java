package com.micro.service.springquartz.model;

import lombok.Data;
import lombok.ToString;

/**
 * @ClassName ThreadLocalDataSource
 * @Description TODO
 * @Author zxl
 * @Date 2020/9/4 9:30
 * @Version 1.0.0
 */
@Data
@ToString
public class ThreadLocalDSInfo {
    String datasourceId;
    String businesstype;
}
