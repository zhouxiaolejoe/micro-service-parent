package com.micro.service.springquartz.config.fasp3client;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.EnvironmentAware;
import org.springframework.core.env.Environment;
import org.springframework.util.StringUtils;

/**
* @Description
* @Author zxl
* @Date  2020-10-28  16:12:38
**/
@ConfigurationProperties(prefix = FaspClientSetting.FASPCLIENT_PREFIX, ignoreUnknownFields = true)
//@Data
public class FaspClientSetting implements EnvironmentAware {
    private static final Logger logger = LoggerFactory.getLogger(FaspClientSetting.class);

    private Environment environment;

    public static final String FASPCLIENT_PREFIX = "faspclient";

    public static final String faspServer = "${faspclient.fasp_server_id:fasp3-common}";

    /**
     * 扫描时间间隔，单位秒
     */
    private int idleTime = 5;

    private String tokenCookieName = "tokenid";

    private String faspServerId = "fasp3-common";

    private String faspUser = "fasp_client";

    private String password = "fasp_client";

    private boolean syncStart = true;


    public int getIdleTime() {
        return idleTime;
    }

    public void setIdleTime(int idleTime) {
        this.idleTime = idleTime;
    }

    public String getTokenCookieName() {
        return tokenCookieName;
    }

    public void setTokenCookieName(String tokenCookieName) {
        this.tokenCookieName = tokenCookieName;
    }

    public String getFaspServerId() {
        logger.info("获取网关地址：["+faspServerId+" ]");
        return faspServerId;
    }
    public void setFaspServerId(String faspServerId) {
        logger.info("设置网关地址：["+faspServerId+" ]");
        String exist = environment.getProperty("faspServerId");
        if (!StringUtils.isEmpty(exist)) {
            this.syncStart = Boolean.parseBoolean(exist);
            return;
        }
        this.faspServerId = faspServerId;
    }

    public String getFaspUser() {
        return faspUser;
    }

    public void setFaspUser(String faspUser) {
        this.faspUser = faspUser;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public boolean isSyncStart() {
        return syncStart;
    }

    public void setSyncStart(boolean syncStart) {
        String exist = environment.getProperty("syncStart");
        if (!StringUtils.isEmpty(exist)) {
            this.syncStart = Boolean.parseBoolean(exist);
            return;
        }
        this.syncStart = syncStart;
    }


    @Override
    public void setEnvironment(Environment environment) {
        this.environment =environment;
    }
}
