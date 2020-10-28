package com.micro.service.springquartz.config.fasp3client;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;

/**
* @Description
* @Author zxl
* @Date  2020-10-28  16:13:08
**/
@ConfigurationProperties(prefix = FaspDic3ClientSetting.FASPCLIENT_DIC3_PREFIX, ignoreUnknownFields = true)
@Data
public class FaspDic3ClientSetting {

    public static final String FASPCLIENT_DIC3_PREFIX = "faspclient.dic3";

    /**
     * 需要同步的基础数据Elementcode，多个是用逗号分隔，不配置则同步所有基础数据
     */
    private String syncElementcode = null;

    private String syncTablenamePrefix = "fasp_t_pup";

}
