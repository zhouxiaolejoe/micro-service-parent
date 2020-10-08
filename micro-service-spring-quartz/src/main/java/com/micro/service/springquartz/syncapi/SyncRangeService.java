package com.micro.service.springquartz.syncapi;

import com.github.benmanes.caffeine.cache.Cache;
import com.micro.service.springquartz.clientapi.TableDBVersionClient;
import com.micro.service.springquartz.mapper.target.SyncRangeMapper;
import com.micro.service.springquartz.model.Dic3SyncDSPO;
import com.micro.service.springquartz.model.RestClientResultDTO;
import com.micro.service.springquartz.service.CaffeineCacheService;
import com.micro.service.springquartz.utils.FaspAuthenticateUtils;
import com.micro.service.springquartz.utils.SyncDataUtils;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.jdbc.BadSqlGrammarException;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
    SyncRangeMapper syncRangeMapper;
    TableDBVersionClient client;
    FaspAuthenticateUtils faspAuthenticateUtils;
    Cache<String, List<String>> caffeineCache;
    CaffeineCacheService caffeineCacheService;

    @Override
    public void start(String target) {
        List<Dic3SyncDSPO> syncDSPOS = syncRangeMapper.querySyncElements();
        if(StringUtils.isEmpty(syncDSPOS)){
            return;
        }
        for (Dic3SyncDSPO po : syncDSPOS) {
            try {
                String elementcode = po.getElementcode();
                if (!StringUtils.isEmpty(elementcode) && !("AGENCY").equals(elementcode.toUpperCase())) {
                    checkTable(po, target);
                    syncElement(po);
                }
            } catch (Exception e) {
                log.info("TABLENAME :[ " + po.getTablename() + " ] INFO :[" + e.getCause() + "]");
                if (e instanceof BadSqlGrammarException) {
                    try {
                        if (e.getCause().toString().contains("ORA-00942")) {
                            syncRangeMapper.updateSyncElementDateTimeByTableName(po.getElementcode(), SyncDataUtils.DEFAULT_DBVERSION, po.getTablename());
                        }
                        caffeineCacheService.saveUserTableView(target);
                    } catch (Exception exception) {
                        log.error("TABLENAME :[ " + po.getTablename() + " ] ERROR :[" + exception.getCause() + "]");
                    }
                }

            }
        }
    }

    private void checkTable(Dic3SyncDSPO po, String target) {
        String tablename = po.getTablename().toLowerCase();
        if (tablename.length() > 30) {
            tablename = tablename.substring(0, 30);
        }

        log.debug("check table [" + tablename + "] exits ");
        if (!exitsTable(tablename.trim().toUpperCase(), target)) {
            log.debug("create table " + tablename);
            if (!exitsView(tablename.trim().toUpperCase(), target)) {
                syncRangeMapper.createTable(tablename.trim());
            }
        }
        checkTableVeiws(po, target);
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

    private Integer syncElement(Dic3SyncDSPO po) throws Exception {
        Integer syncCount = null;
        String tokenid = faspAuthenticateUtils.getFaspToken();
        RestClientResultDTO<List<Map<String, Object>>> rs = null;

        int page = 1;
        do {
            String version = po.getSyncdatetime();
            if (StringUtils.isEmpty(version)) {
                version = SyncDataUtils.DEFAULT_DBVERSION;
            }
            if (SyncDataUtils.parentVersion(version) == null) {
                version = SyncDataUtils.DEFAULT_DBVERSION;
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
            String dbVersion = syncElementData(po, data);
            if (dbVersion == null) {
                dbVersion = version;
            }
            updateSyncElementDateTime(po, dbVersion);
            syncCount = data.size();
            log.info("TABLENAME :[ " + po.getTablename() + " ] DBVERSION :[" + po.getSyncdatetime() + "] DATA SIZE: [ " + (syncCount + 1000 * (page - 2)) + " ]");
        }
        while (1000 == syncCount);
        return syncCount;
    }

    public void updateSyncElementDateTime(Dic3SyncDSPO po, String dbversion) throws Exception {
        if (StringUtils.isEmpty(dbversion)) {
            return;
        }

        try {
            SimpleDateFormat format = new SimpleDateFormat(DEFAULT_DATE_TIME_FROMAT);
            format.parse(dbversion);
        } catch (Exception e) {
            return;
        }

        Map<String, String> params = new HashMap<>();
        params.put("datetime", dbversion);
        params.put("elementcode", po.getElementcode());
        syncRangeMapper.updateSyncElementDateTimeByTableName(po.getElementcode(), dbversion, po.getTablename());
    }

    public String syncElementData(Dic3SyncDSPO po, List<Map<String, Object>> datas) {

        if (CollectionUtils.isEmpty(datas)) {
            return null;
        }

        // 按DBVersion排序
        sortSyncDataByDBVersion(datas);
        String tablename = po.getTablename();
        Map param = new HashMap();
        param.put("tablename", tablename);
        String dbversion = null;
        for (Map<String, Object> data : datas) {
            param.put("data", data);
            dbversion = (String) data.get("DBVERSION");
            syncRangeMapper.deleteData(param);
            syncRangeMapper.insertDataString(param);
        }
        return dbversion;
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
}
