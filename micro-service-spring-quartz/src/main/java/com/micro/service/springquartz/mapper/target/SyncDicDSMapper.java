package com.micro.service.springquartz.mapper.target;

import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @Description
 * @Project pushdata
 * @Package gov.mof.pushdata.fasp3client.dic3.sync.dao
 * @Author Administrator
 * @Date 2020-09-01 15:08
 */
public interface SyncDicDSMapper {

    String queryDSMaxVersion();

    String queryTableMaxVersion();

    String queryColumnMaxVersion();

    Integer exitsDicTable();

    Integer exitsDicColumn();

    Integer exitsDs();

    Integer createDs();

    Integer insertDS(Map<String, Object> data);

    Integer insertTable(Map<String, Object> data);

    Integer insertColumn(Map<String, Object> data);

    Integer createDicTable();

    Integer createDicColumn();

    Integer deleteDS(@Param("guid") String guid);

    Integer deleteTable(@Param("tablecode") String tablecode);

    Integer deleteColumn(@Param("tablecode") String tablecode, @Param("columncode") String columncode);

    Integer tableExitsData(@Param("tablename") String tablename);

    boolean batchInsertDicds(Map<String, Object> map);

    boolean batchInsertDicTable(Map<String, Object> map);

    boolean batchInsertDicColumn(Map<String, Object> map);

    boolean deleteAllData(@Param("tablename") String tablename);


    List<String> queryTableList();
    List<String> queryViewList();
}
