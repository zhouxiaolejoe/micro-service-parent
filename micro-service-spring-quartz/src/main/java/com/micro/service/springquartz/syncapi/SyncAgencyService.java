package com.micro.service.springquartz.syncapi;


import com.github.benmanes.caffeine.cache.Cache;
import com.micro.service.springquartz.clientapi.TableDBVersionClient;
import com.micro.service.springquartz.mapper.target.SyncAgencyMapper;
import com.micro.service.springquartz.mapper.target.SyncDicDSMapper;
import com.micro.service.springquartz.mapper.target.SyncRangeMapper;
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
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentMap;

import static com.micro.service.springquartz.utils.MapUtils.toLowerMapKey;
import static com.micro.service.springquartz.utils.SyncDataUtils.sortSyncDataByDBVersion;


/**
 * @ClassName SyncAgencyService
 * @Description TODO
 * @Author Administrator
 * @Date 2020/9/1 14:14
 * @Version 1.0.0
 */
@Service("sSyncAgencyService")
@Slf4j
@AllArgsConstructor
public class SyncAgencyService implements IFaspClientScheduler {

    FaspAuthenticateUtils faspAuthenticateUtils;
    TableDBVersionClient client;
    SyncAgencyMapper syncAgencyMapper;
    SyncRangeMapper syncRangeMapper;
    SyncDicDSMapper syncDicDSMapper;
    DBChangeService changeService;
    Cache<String, List<String>> caffeineCache;
    CaffeineCacheService caffeineCacheService;

    @Override
    public void start(String target) {
        try {
            changeService.changeDb(target);
        } catch (Exception e) {
            e.printStackTrace();
        }
        String agencyCode = syncAgencyMapper.queryAgencyDsCodes();
        if (StringUtils.isEmpty(agencyCode)) {
            return;
        }
        String agencyTableName = "FASP_T_PUP" + agencyCode.toUpperCase();

        checkAgencyTable(agencyTableName, target);
        String agencyVersion = syncAgencyMapper.queryAgencyVersion(agencyTableName);
        agencyVersion = StringUtils.isEmpty(agencyVersion) ? SyncDataUtils.DEFAULT_DBVERSION : agencyVersion;
        Dic3SyncDSPO dic3SyncDSPO = new Dic3SyncDSPO();
        dic3SyncDSPO.setElementcode("AGENCY");
        dic3SyncDSPO.setTablename(agencyTableName);
        dic3SyncDSPO.setSyncdatetime(agencyVersion);
        checkTableVeiws(dic3SyncDSPO, target);
        Integer syncCount = null;
        try {
            String tokenid = faspAuthenticateUtils.getFaspToken();
            RestClientResultDTO<List<Map<String, Object>>> rs = null;
            int page = 1;
            Boolean isdelete = true;
            do {
                if (StringUtils.isEmpty(agencyVersion)) {
                    agencyVersion = SyncDataUtils.DEFAULT_DBVERSION;
                }
                rs = client.queryTableData1KByDBVersion(agencyTableName, agencyVersion, page++, tokenid);
                if (rs == null) {
                    log.error("从服务端获取单位数据为空！");
                    break;
                }

                List<Map<String, Object>> data = rs.getData();
                if (CollectionUtils.isEmpty(data)) {
                    break;
                }
                if (agencyVersion.equals(SyncDataUtils.DEFAULT_DBVERSION)) {
                    /**
                     * 首次同步清表批量写入
                     */
                    if (isdelete) {
                        syncAgencyMapper.deleteAllData(agencyTableName);
                        isdelete = false;
                    }
                    Map<String, Object> param = new HashMap<>(2);
                    param.put("tablename", agencyTableName);
                    param.put("list", data);
                    syncAgencyMapper.batchInsertAgencyString(param);
                } else {
                    syncAgencyData(agencyTableName, data);
                }

                syncCount = data.size();
                log.info("TABLENAME :[ " + agencyTableName + " ] DBVERSION :[" + agencyVersion + "] DATA: [ " + (syncCount + 1000 * (page - 2)) + " ]");
            }
            while (1000 == syncCount);

        } catch (Throwable e) {
            log.info("TABLENAME :[ FASP_T_PUPVD00010 ] INFO :[" + e.getCause() + "]");
            if (e instanceof BadSqlGrammarException) {
                try {
                    caffeineCacheService.saveUserTableView(target);
                } catch (Exception exception) {
                    log.error("TABLENAME :[ FASP_T_PUPVD00010 ] ERROR :[" + exception.getCause() + "]");
                }
            }
        }
    }

    private void checkAgencyTable(String tablename, String target) {
        log.debug("check table [" + tablename + "] exits ");
        if (exitsTable(tablename, target)) {
            return;
        }
        log.debug("create table " + tablename);
        syncAgencyMapper.createAgencyTable(tablename);
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
        if (exitsView(view.trim().toLowerCase(), target)) {
            syncRangeMapper.createElementcodeView(tablename, view);
            syncRangeMapper.updateElementcodeView(po.getElementcode(), view);
        }
    }


    @Transactional
    public String syncAgencyData(String tablename, List<Map<String, Object>> datas) {
        if (CollectionUtils.isEmpty(datas)) {
            return null;
        }
        sortSyncDataByDBVersion(datas);
        Map<String, Object> param = new HashMap(2);
        param.put("tablename", tablename);
        String dbversion = null;
        for (Map<String, Object> data : datas) {
            param.put("data", toLowerMapKey(data));
            dbversion = (String) data.get("dbversion");
            syncAgencyMapper.deleteAgencyData(param);
            syncAgencyMapper.insertAgencyData(param);
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
