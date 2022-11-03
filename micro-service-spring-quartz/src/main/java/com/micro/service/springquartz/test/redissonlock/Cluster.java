package com.micro.service.springquartz.test.redissonlock;

import lombok.Data;

/**
 * @Description
 * @Project microfasp-jiangsu
 * @Package gov.mof.fasp3.masterdata.test.redissonlock
 * @Author zxl
 * @Date 2022-11-03 11:02
 */
@Data
public class Cluster {

    private String nodes;
    private int retryInterval;
    private int masterConnectionPoolSize;
    private int slaveConnectionPoolSize;

}
