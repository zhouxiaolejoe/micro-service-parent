package com.micro.service.springquartz.test.redissonlock;

import lombok.Data;

/**
 * @Description
 * @Project microfasp-jiangsu
 * @Package gov.mof.fasp3.masterdata.test.redissonlock
 * @Author zxl
 * @Date 2022-11-03 10:58
 */
@Data
public class Sentinel {
    private String nodes;
    private String master;
    private String failMax;

}
