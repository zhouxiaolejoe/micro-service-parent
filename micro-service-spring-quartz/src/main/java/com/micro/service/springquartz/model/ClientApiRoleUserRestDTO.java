package com.micro.service.springquartz.model;

import lombok.Data;
import lombok.ToString;

/**
 * Created by wengy on 2019/12/9.
 */
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
