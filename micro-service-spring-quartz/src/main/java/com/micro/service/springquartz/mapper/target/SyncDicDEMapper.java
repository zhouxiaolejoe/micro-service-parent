package com.micro.service.springquartz.mapper.target;

import org.apache.ibatis.annotations.Param;

import java.util.Map;

/**
 * @Description
 * @Project pushdata
 * @Package gov.mof.pushdata.fasp3client.dic3.sync.dao
 * @Author Administrator
 * @Date 2020-09-01 14:27
 */
public interface SyncDicDEMapper {

    String queryDEMaxVersion();

    Integer exitsDeTable();

    void insertDE(Map<String, Object> data);

    void createDeTable();

    void deleteDE(@Param("guid") String guid);

    boolean batchInsertDicDE(Map<String, Object> map);

    boolean deleteAllData(@Param("tablename") String tablename);
}
