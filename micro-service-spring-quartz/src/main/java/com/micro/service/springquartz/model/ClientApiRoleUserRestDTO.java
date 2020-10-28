package com.micro.service.springquartz.model;

import lombok.Data;
import lombok.ToString;

/**
 * @Description
 * @Author zxl
 * @Date  2020-10-28  16:22:30
 **/
@Data
@ToString
public class ClientApiRoleUserRestDTO {
    String guid;
    String userguid;
    String roleguid;
    String version;
    String year;
    String province;
}
