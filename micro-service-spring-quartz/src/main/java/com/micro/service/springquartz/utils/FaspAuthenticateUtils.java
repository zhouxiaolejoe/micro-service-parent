package com.micro.service.springquartz.utils;


import com.micro.service.springquartz.clientapi.SecServiceClient;
import com.micro.service.springquartz.config.fasp3client.FaspClientException;
import com.micro.service.springquartz.config.fasp3client.FaspClientSetting;
import com.micro.service.springquartz.model.ClientUserAuthenticateDTO;
import com.micro.service.springquartz.model.RestClientResultDTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;

/**
 * Created by wengy on 2019/11/27.
 */
@Component
public class FaspAuthenticateUtils {

    private static final Logger logger = LoggerFactory.getLogger(FaspAuthenticateUtils.class);

    @Resource
    FaspClientSetting setting;

    @Autowired
    SecServiceClient secClient;

    private static String tokenid = null;

    /**
     * 获取平台有效token
     *
     * @return
     */
    public String getFaspToken() {
        if (true) {
            return "faspclient-token";
        }
        // 检查token是否有效
        if (!StringUtils.isEmpty(tokenid)) {
            RestClientResultDTO<Boolean> rs = secClient.checkTokenID(tokenid);
            if (rs == null) {
                throw new FaspClientException("connect fasp server error: ");
            }
            if (rs.getData()) {
                return tokenid;
            }
        }

        // 登录平台获取tokenid
        ClientUserAuthenticateDTO dto = new ClientUserAuthenticateDTO();
        dto.setPassword(setting.getPassword());
        dto.setUserCode(setting.getFaspUser());
        RestClientResultDTO<String> result = secClient.authenticate(dto);
        if (result == null) {
            throw new FaspClientException("get fasp token error: " + dto);
        }
        tokenid = result.getData();
        logger.info("get Fasp Tokendi is " + tokenid);
        return tokenid;
    }
}
