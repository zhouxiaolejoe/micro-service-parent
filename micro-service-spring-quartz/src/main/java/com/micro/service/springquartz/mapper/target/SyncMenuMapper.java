package com.micro.service.springquartz.mapper.target;

import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @Description
 * @Project pushdata
 * @Package gov.mof.pushdata.fasp3client.ca3.sync.dao.SyncMenuMapper
 * @Author Administrator
 * @Date 2020-09-01 13:13
 */
public interface SyncMenuMapper {
    Integer exitsMenuTable();

    String queryMenuVersion();

    void createMenuTable();

    Integer insertMenuData(Map<String, Object> menu);

    Integer deleteMenuData(Map<String, Object> menu);

    boolean batchInsertMenu(Map<String, Object> map);

    boolean deleteAllData(@Param("tablename") String tablename);

    List<Map<String, Object>> selectAllByGuid(@Param("guid") String guid);
}
