package com.micro.service.springquartz.syncapi;

import com.github.benmanes.caffeine.cache.Cache;
import com.google.common.base.Joiner;
import com.google.common.collect.Maps;
import com.micro.service.springquartz.clientapi.TableDBVersionClient;
import com.micro.service.springquartz.mapper.origin.OriginMapper;
import com.micro.service.springquartz.mapper.target.SyncRangeMapper;
import com.micro.service.springquartz.mapper.target.TargetMapper;
import com.micro.service.springquartz.model.Dic3SyncDSPO;
import com.micro.service.springquartz.model.RestClientResultDTO;
import com.micro.service.springquartz.service.CaffeineCacheService;
import com.micro.service.springquartz.service.DBChangeService;
import com.micro.service.springquartz.utils.FaspAuthenticateUtils;
import com.micro.service.springquartz.utils.SyncDataUtils;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.jdbc.BadSqlGrammarException;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;

import java.text.SimpleDateFormat;
import java.util.*;
import java.util.concurrent.ConcurrentMap;

import static com.micro.service.springquartz.utils.SyncDataUtils.sortSyncDataByDBVersion;


/**
 * Created by wengy on 2019/11/20.
 */
@Service("sSyncRangeService")
@Slf4j
@AllArgsConstructor
public class SyncRangeService implements IFaspClientScheduler {

    private static final String DEFAULT_DATE_TIME_FROMAT = "yyyyMMddHHmmss";
    private static final String DEFAULT_DIC3SYNCDS_DATE = "20100101000000";
    SyncRangeMapper syncRangeMapper;
    DBChangeService changeService;
    TargetMapper targetMapper;
    TableDBVersionClient client;
    OriginMapper originMapper;
    FaspAuthenticateUtils faspAuthenticateUtils;
    Cache<String, List<String>> caffeineCache;
    CaffeineCacheService caffeineCacheService;

    @Override
    public void start(String origin, String target) {
        try {
            changeService.changeDb(target);
        } catch (Exception e) {
            e.printStackTrace();
        }
        List<Dic3SyncDSPO> syncDSPOS = syncRangeMapper.querySyncElements();
        if (StringUtils.isEmpty(syncDSPOS)) {
            return;
        }
        for (Dic3SyncDSPO po : syncDSPOS) {
            try {
                String elementcode = po.getElementcode();
                if (!StringUtils.isEmpty(elementcode) && !("AGENCY").equals(elementcode.toUpperCase())) {
                    if (!checkTable(po, origin, target)) {
                        continue;
                    }
                    syncElement(po, target);
                }
            } catch (Exception e) {
                log.info("TABLENAME :[ " + po.getTablename() + " ] INFO :[" + e.getCause() + "]");
                if (e instanceof BadSqlGrammarException) {
                    try {
                        if (e.getCause().toString().contains("ORA-00942")) {
                            changeService.changeDb(target);
                            syncRangeMapper.updateSyncElementDateTimeByTableName(po.getElementcode(), DEFAULT_DIC3SYNCDS_DATE, po.getTablename());
                        }
                        caffeineCacheService.saveUserTableView(target);
                    } catch (Exception exception) {
                        log.error("TABLENAME :[ " + po.getTablename() + " ] ERROR :[" + exception.getCause() + "]");
                    }
                }

            }
        }
    }

    private Boolean checkTable(Dic3SyncDSPO po, String origin, String target) throws Exception {
        String tablename = po.getTablename().toLowerCase();
        if (tablename.length() > 30) {
            tablename = tablename.substring(0, 30);
        }
        log.debug("check table [" + tablename + "] exits ");
        if (!exitsTable(tablename.trim().toUpperCase(), target)) {
            log.debug("create table " + tablename);
            if (!exitsView(tablename.trim().toUpperCase(), target)) {
                changeService.changeDb(origin);
                List<Map<String, Object>> sqlData = originMapper.selectTableColumn(tablename.trim().toUpperCase());
                if (CollectionUtils.isEmpty(sqlData)) {
                    return false;
                }

                createTableDynamic(tablename, sqlData, target);
//                syncRangeMapper.createTable(tablename.trim());
            }
        }
        checkTableVeiws(po, target);
        return true;
    }

    public void createTableDynamic(String tablename, List<Map<String, Object>> list, String target) throws Exception {
        StringBuffer sqlData = new StringBuffer();
        for (int i = 0; i < list.size(); i++) {
            String dbcolumncode = list.get(i).get("NAME").toString();
            String datatype = list.get(i).get("TYPE").toString();
            String datalength = list.get(i).get("LENGTH").toString();
            sqlData.append(dbcolumncode);
            sqlData.append(" ");
            sqlData.append(datatype);
            if (!datatype.toLowerCase().contains("timestamp")) {
                sqlData.append("(");
                sqlData.append(datalength);
                sqlData.append(")");
            }
            if (i < list.size() - 1) {
                sqlData.append(",");
            }
        }
        changeService.changeDb(target);
        targetMapper.createTableDynamic(tablename, sqlData.toString());
    }

    private void checkTableVeiws(Dic3SyncDSPO po, String target) {
        String tablename = po.getTablename();
        tablename = tablename.toUpperCase().replace("P#", "");
        if (tablename.length() > 30) {
            tablename = tablename.substring(0, 30);
        }
        String view = tablename.toUpperCase().replace("P#", "").replace("_T_", "_V_");
        if (view.length() > 30) {
            view = view.substring(0, 30);
        }
        log.debug("create or replace view " + view + " from tablename " + tablename);
        if (!exitsView(view.trim().toUpperCase(), target)) {
            syncRangeMapper.createElementcodeView(tablename, view);
            syncRangeMapper.updateElementcodeView(po.getElementcode(), view);
        }
    }

    private Boolean saveBatchTableTable(String tablename, List<Map<String, Object>> datas, String target, Boolean isdelete) throws Exception {
        changeService.changeDb(target);
        if (isdelete) {
            targetMapper.deleteAllData(tablename);
            isdelete = false;
        }
        datas.stream().forEach(x -> {
            x.remove("ROW_ID");
        });
        Map<String, Object> treeMap = new TreeMap<>(String::compareTo);
        treeMap.putAll(datas.get(0));
        String sql = Joiner.on(",").join(treeMap.keySet());
        String values = batchCreatValues(treeMap, sql);
        Map<String, Object> param = Maps.newHashMap();
        param.put("tablename", tablename);
        param.put("sql", sql);
        param.put("values", values);
        param.put("datas", datas);
        targetMapper.batchInsertDataDynamic(param);
        return isdelete;
    }

    private String batchCreatValues(Map<String, Object> data, String sql) {
        String[] columns = sql.split(",");
        StringBuilder sb = new StringBuilder("");
        for (int i = 0; i < columns.length; i++) {
            String col = findKey(columns[i], data.keySet());
            if ("DBVERSION".equalsIgnoreCase(col)) {
                sb.append("to_date(#{item." + col + ",jdbcType=VARCHAR},'yyyymmddhh24miss'),");
                continue;
            }
            if ("LEVELNO".equalsIgnoreCase(col) || "ISLEAF".equalsIgnoreCase(col)) {
                sb.append("#{item." + col + "   ,jdbcType=INTEGER},");
            } else {
                sb.append("#{item." + col + "   ,jdbcType=VARCHAR},");
            }
        }
        String s = sb.toString();
        return s.substring(0, s.length() - 1);

    }

    private String findKey(String column, Set<String> keys) {
        for (String key : keys) {
            if (column.equalsIgnoreCase(key)) {
                return key;
            }
        }
        return column;
    }

    private Integer syncElement(Dic3SyncDSPO po, String target) throws Exception {
        Integer syncCount = null;
        String tokenid = faspAuthenticateUtils.getFaspToken();
        RestClientResultDTO<List<Map<String, Object>>> rs = null;
        int page = 1;
        Boolean isdelete = true;
        do {
            String version = po.getSyncdatetime();
            if (StringUtils.isEmpty(version)) {
                version = DEFAULT_DIC3SYNCDS_DATE;
            }
            if (SyncDataUtils.parentVersion(version) == null) {
                version = DEFAULT_DIC3SYNCDS_DATE;
            }

            rs = client.queryTableData1KByDBVersion(po.getTablename(),
                    version, page++, tokenid);
            if (rs == null) {
                syncCount = 0;
                break;
            }

            List<Map<String, Object>> data = rs.getData();

            if (CollectionUtils.isEmpty(data)) {
                syncCount = 0;
                break;
            }

            String dbVersion = null;
            if (DEFAULT_DIC3SYNCDS_DATE.equals(version)) {
                isdelete = saveBatchTableTable(po.getTablename(), data, target, isdelete);
                dbVersion = targetMapper.queryTableMaxVersion(po.getTablename());
            } else {
                dbVersion = syncElementData(po.getTablename(), data, target);
            }
            if (dbVersion == null) {
                dbVersion = version;
            }

            updateSyncElementDateTime(po, dbVersion, target);
            syncCount = data.size();
            log.info("TABLENAME :[ " + po.getTablename() + " ] DBVERSION :[" + po.getSyncdatetime() + "] DATA SIZE: [ " + (syncCount + 1000 * (page - 2)) + " ]");
        }
        while (1000 == syncCount);
        return syncCount;
    }

    public void updateSyncElementDateTime(Dic3SyncDSPO po, String dbversion, String target) throws Exception {
        if (StringUtils.isEmpty(dbversion)) {
            return;
        }

        try {
            SimpleDateFormat format = new SimpleDateFormat(DEFAULT_DATE_TIME_FROMAT);
            format.parse(dbversion);
        } catch (Exception e) {
            return;
        }
        changeService.changeDb(target);
        syncRangeMapper.updateSyncElementDateTimeByTableName(po.getElementcode(), dbversion, po.getTablename());
    }

    Boolean exitsView(String viewName, String target) {
        ConcurrentMap<String, List<String>> concurrentMap = caffeineCache.asMap();
        if (!StringUtils.isEmpty(concurrentMap)) {
            List<String> viewList = concurrentMap.get("viewList_" + target);
            return viewList.contains(viewName);
        }
        return false;
    }

    private Boolean exitsTable(String tablename, String target) {
        ConcurrentMap<String, List<String>> concurrentMap = caffeineCache.asMap();
        if (!StringUtils.isEmpty(concurrentMap)) {
            List<String> tableList = concurrentMap.get("tableList_" + target);
            return tableList.contains(tablename);
        }
        return false;
    }


    public String syncElementData(String tablename, List<Map<String, Object>> datas, String target) throws Exception {

        if ("fasp_t_pupvc01004".equalsIgnoreCase(tablename)) {
            System.err.println();
        }
        if (CollectionUtils.isEmpty(datas)) {
            return SyncDataUtils.DEFAULT_DBVERSION;
        }
        String dbversion = null;
        for (Map<String, Object> data : datas) {
            data.remove("ROW_ID");
            Map<String, Object> treeMap = new TreeMap<>(String::compareTo);
            treeMap.putAll(data);
            String sql = Joiner.on(",").join(treeMap.keySet());
            String values = creatValues(treeMap, sql);
            dbversion = (String) data.get("DBVERSION");
            changeService.changeDb(target);
            targetMapper.deleteData(tablename, data);
            targetMapper.insertDataDynamic(tablename, sql, values, data);
        }
        return dbversion;
    }

    private String creatValues(Map<String, Object> data, String sql) {
        String[] columns = sql.split(",");
        StringBuilder sb = new StringBuilder("");
        for (int i = 0; i < columns.length; i++) {
            String col = findKey(columns[i], data.keySet());
            if ("DBVERSION".equalsIgnoreCase(col)) {
                sb.append("to_date(#{data." + col + ",jdbcType=VARCHAR},'yyyymmddhh24miss'),");
                continue;
            }
            if ("LEVELNO".equalsIgnoreCase(col) || "ISLEAF".equalsIgnoreCase(col)) {
                sb.append("#{data." + col + "   ,jdbcType=INTEGER},");
            } else {
                sb.append("#{data." + col + "   ,jdbcType=VARCHAR},");
            }
        }
        String s = sb.toString();
        return s.substring(0, s.length() - 1);

    }
}
