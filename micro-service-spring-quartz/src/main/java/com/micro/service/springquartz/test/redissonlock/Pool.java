package com.micro.service.springquartz.test.redissonlock;

import lombok.Data;

/**
 * @Description
 * @Project microfasp-jiangsu
 * @Package gov.mof.fasp3.masterdata.test.redissonlock
 * @Author zxl
 * @Date 2022-11-03 10:48
 */
@Data
public class Pool {
    private int size = 64;
    private int minIdle = 24;
    private int connTimeout = 10000;
    private int soTimeout = 10000;
}
