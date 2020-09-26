package com.micro.service.springquartz.mapper.target;

import org.apache.ibatis.annotations.Param;

import java.util.Map;

/**
 * @Description
 * @Project pushdata
 * @Package gov.mof.pushdata.fasp3client.dic3.sync.dao
 * @Author Administrator
 * @Date 2020-09-01 15:17
 */
public interface SyncRangeMapper {

    Integer exitsView(@Param("viewName") String viewName);

    void deleteView(@Param("viewName") String viewName);

    Integer exitsTable(@Param("tableName") String tableName);

    void insertData(Map<String, Object> data);

    void createTable(@Param("tableName") String tableName);

    void deleteData(Map<String, Object> data);

    boolean batchInsertData(Map<String, Object> map);

    boolean deleteAllData(@Param("tablename") String tablename);
}
