package com.micro.service.springquartz.mapper.target;

import org.apache.ibatis.annotations.Param;

import java.util.Map;

/**
 * @Description
 * @Project pushdata
 * @Package gov.mof.pushdata.fasp3client.dic3.sync.dao
 * @Author Administrator
 * @Date 2020-09-01 14:06
 */
public interface SyncAgencyMapper {
    String queryAgencyDsCodes();

    Integer exitsAgencyTable(@Param("tablename") String tablename);

    String queryAgencyVersion(@Param("tablename") String tablename);

    Integer insertAgencyData(Map<String, Object> agency);

    void createAgencyTable(@Param("tablename") String tablename);

    Integer deleteAgencyData(Map<String, Object> agency);

    boolean batchInsertAgency(Map<String, Object> map);

    boolean batchInsertAgencyString(Map<String, Object> map);

    boolean deleteAllData(@Param("tablename") String tablename);
}
