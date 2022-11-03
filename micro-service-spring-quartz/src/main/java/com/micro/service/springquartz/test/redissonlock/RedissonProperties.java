package com.micro.service.springquartz.test.redissonlock;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;

/**
 * @Description
 * @Project microfasp-jiangsu
 * @Package gov.mof.fasp3.masterdata.test.redissonlock
 * @Author zxl
 * @Date 2022-11-03 10:44
 */
@Data
@ConfigurationProperties(prefix = "redisson.lock")
public class RedissonProperties {
    private Single single = new Single();
    private String mode;
    private Sentinel sentinel = new Sentinel();
    private Cluster cluster = new Cluster();
    private Pool pool = new Pool();
    private String password;
    private int database = 10;
    private int timeout = 10000;
    private int failedSlaveCheckInterval = 180000;
    private int failedSlaveReconnectionInterval = 3000;
}

