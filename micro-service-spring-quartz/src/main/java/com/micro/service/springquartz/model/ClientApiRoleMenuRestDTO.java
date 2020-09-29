package com.micro.service.springquartz.model;

import lombok.Data;
import lombok.ToString;

/**
 * Created by wengy on 2019/12/9.
 */
@Data
@ToString
public class ClientApiRoleMenuRestDTO {
    String guid;
    String menuguid;
    String roleguid;
    String province;
    String year;
    String version;
}