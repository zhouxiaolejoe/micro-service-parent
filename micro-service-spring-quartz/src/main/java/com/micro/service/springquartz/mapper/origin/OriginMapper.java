package com.micro.service.springquartz.mapper.origin;

import com.micro.service.springquartz.model.ClientApiRoleMenuRestDTO;
import com.micro.service.springquartz.model.ClientApiRoleUserRestDTO;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @ClassName OriginMapper
 * @Description TODO
 * @Author zxl
 * @Date 2020/9/21 17:06
 * @Version 1.0.0
 */
public interface OriginMapper {

    List<Map<String, Object>> queryTableDataByDBVersion(@Param("tablename") String tablename, @Param("dbversion") String dbversion);

    List<Map<String, Object>> selectTableColumn(@Param("tablename") String tablename);

    List<ClientApiRoleUserRestDTO> queryUserRolemapping(@Param("userguid") String userguid);

    List<ClientApiRoleMenuRestDTO> queryRoleMenuMapping(@Param("menuguid") String menuguid);
}
