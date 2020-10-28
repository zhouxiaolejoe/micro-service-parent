package com.micro.service.springquartz.mapper.target;

import java.util.Map;

/**
 * @Description
 * @Project syncdata
 * @Package gov.mof.pushdata.fasp3client.ca3.sync.dao.SyncUserMapper
 * @Author zxl
 * @Date 2020-08-30 13:16
 */
public interface SyncUserMapper {

    String queryUserVersion();

    Integer exitsUserTable();

    Integer exitsUserRoleTable();

    void createUserTable();

    Integer deleteUserData(Map<String, Object> user);

    Integer insertUserData(Map<String, Object> user);
    Integer insertUserDataString(Map<String, Object> user);
}
