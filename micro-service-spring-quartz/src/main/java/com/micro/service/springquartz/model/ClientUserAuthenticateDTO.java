package com.micro.service.springquartz.model;

import lombok.Data;

/**
 * @Description
 * @Author zxl
 * @Date  2020-10-28  16:22:30
 **/
@Data
public class ClientUserAuthenticateDTO {
    String userCode;
    String password;

}
