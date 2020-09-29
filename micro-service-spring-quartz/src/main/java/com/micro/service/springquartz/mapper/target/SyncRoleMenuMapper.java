package com.micro.service.springquartz.mapper.target;

import com.micro.service.springquartz.model.ClientApiRoleMenuRestDTO;
import org.apache.ibatis.annotations.Param;

import java.util.Map;

/**
 * @Description
 * @Project pushdata
 * @Package gov.mof.pushdata.fasp3client.ca3.sync.dao.SyncRoleMenuMapper
 * @Author Administrator
 * @Date 2020-09-01 13:13
 */
public interface SyncRoleMenuMapper {
    Integer exitsMenuRoleTable();

    String queryRoleMenuVersion();

    void createMenuRoleTable();

    Integer insertMenuRole(ClientApiRoleMenuRestDTO menu);

    Integer deleteMenuRole(Map<String, Object> menu);

    Integer deleteMenuRoles(@Param("menuguid") String menuguid);

    boolean batchInsertMenuRole(Map<String, Object> map);

    boolean deleteAllData(@Param("tablename") String tablename);
}
