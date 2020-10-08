package com.micro.service.springquartz.mapper.target;

import com.micro.service.springquartz.model.Dic3SyncDSPO;
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

    Integer insertDSString(Map<String, Object> data);

    Integer insertTable(Map<String, Object> data);

    Integer insertTableString(Map<String, Object> data);

    Integer insertColumn(Map<String, Object> data);

    Integer insertColumnString(Map<String, Object> data);

    Integer createDicTable();

    Integer createDicColumn();

    Integer deleteDS(@Param("guid") String guid);

    Integer deleteTable(@Param("tablecode") String tablecode);

    Integer deleteColumn(@Param("tablecode") String tablecode, @Param("columncode") String columncode);

    Integer deleteColumnByColumnId(@Param("columnid") String columnid);

    Integer tableExitsData(@Param("tablename") String tablename);

    boolean batchInsertDicds(Map<String, Object> map);

    boolean batchInsertDicdsString(Map<String, Object> map);

    boolean batchInsertDicTable(Map<String, Object> map);

    boolean batchInsertDicTableString(Map<String, Object> map);

    boolean batchInsertDicColumn(Map<String, Object> map);

    boolean batchInsertDicColumnString(Map<String, Object> map);

    boolean deleteAllData(@Param("tablename") String tablename);

    List<String> queryTableList();

    List<String> queryViewList();

    Integer createDic3syncdsTable();

    List<Dic3SyncDSPO> querySyncElementsFromDS();

    void insertSyncElements(Dic3SyncDSPO dic3SyncDSPO);

    void deleteSyncElements();

    List<Map<String, Object>> selectDicColumnData(@Param("tablecode") String tablecode);

    void createTableDynamic(@Param("tablename") String tablename, @Param("sql") String sql);

    void createElementcodeView(@Param("table") String table, @Param("view") String view);

    void updateElementcodeView(@Param("tablecode") String tablecode, @Param("elementcode") String elementcode);

    List<Dic3SyncDSPO> querySyncElementsFromDSByElementcodes(Map<String, Object> data);
}
