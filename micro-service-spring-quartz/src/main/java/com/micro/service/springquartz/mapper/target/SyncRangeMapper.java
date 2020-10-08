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
 * @Date 2020-09-01 15:17
 */
public interface SyncRangeMapper {

    Integer exitsView(@Param("viewName") String viewName);

    void deleteView(@Param("viewName") String viewName);

    Integer exitsTable(@Param("tableName") String tableName);

    void insertData(Map<String, Object> data);

    void insertDataString(Map<String, Object> data);

    void createTable(@Param("tableName") String tableName);

    void deleteData(Map<String, Object> data);

    boolean batchInsertData(Map<String, Object> map);

    boolean deleteAllData(@Param("tablename") String tablename);


    List<Dic3SyncDSPO> querySyncElements();

    void updateSyncElementDateTime(@Param("elementcode") String elementcode, @Param("datetime") String datetime);
    void updateSyncElementDateTimeByTableName(@Param("elementcode") String elementcode,
                                   @Param("datetime") String datetime,
                                   @Param("tablename") String tablename);

    List<String> queryElementcodeView(@Param("elementcode") String elementcode);

    void createElementcodeView(@Param("table") String table, @Param("view") String view);

    void updateElementcodeView(@Param("elementcode") String elementcode, @Param("tablecode") String tablecode);

    void createDic3syncdsTable();

    List<Dic3SyncDSPO> querySyncElementsFromDS();

    void insertSyncElements(Dic3SyncDSPO pos);

    void deleteSyncElements();
}
