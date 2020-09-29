package com.micro.service.springquartz.model;

import lombok.Data;

/**
 * Created by wengy on 2019/4/22.
 */
@Data
public class ClientUserAuthenticateDTO {
    String userCode;
    String password;

}
