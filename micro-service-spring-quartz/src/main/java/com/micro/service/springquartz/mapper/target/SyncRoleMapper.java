package com.micro.service.springquartz.mapper.target;

import java.util.Map;

/**
 * @Description
 * @Project syncdata
 * @Package gov.mof.pushdata.fasp3client.ca3.sync.dao.SyncRoleMapper
 * @Author zhouxiaole
 * @Date 2020-08-30 10:58
 */
public interface SyncRoleMapper {

    String queryRoleVersion();

    Integer exitsRoleTable();

    void createRoleTable();

    Integer deleteRoleData(Map<String, Object> role);

    Integer insertRoleData(Map<String, Object> role);
}
