package com.micro.service.springquartz.mapper.target;

import com.micro.service.springquartz.model.ClientApiRoleUserRestDTO;
import org.apache.ibatis.annotations.Param;

import java.util.Map;

/**
 * @Description
 * @Project syncdata
 * @Package gov.mof.pushdata.fasp3client.ca3.sync.dao.SyncUserRoleMapper
 * @Author zxl
 * @Date 2020-08-30 13:16
 */
public interface SyncUserRoleMapper {

    String queryUserRoleVersion();

    Integer exitsUserRoleTable();

    Integer createUserRoleTable();

    Integer insertUserRole(ClientApiRoleUserRestDTO userRole);

    Integer deleteUserRole(Map<String, Object> userRole);

    Integer deleteUserRoles(@Param("userguid") String userguid);

    boolean batchInsertUserRole(Map<String, Object> map);

    boolean deleteAllData(@Param("tablename") String tablename);
}
