package com.micro.service.springquartz.syncapi;


import com.github.benmanes.caffeine.cache.Cache;
import com.micro.service.springquartz.clientapi.TableDBVersionClient;
import com.micro.service.springquartz.mapper.target.SyncDicDSMapper;
import com.micro.service.springquartz.mapper.target.SyncRangeMapper;
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

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentMap;
import java.util.stream.Collectors;


/**
 * @Description
 * @Author zxl
 * @Date 2020-10-28  16:29:09
 **/
@Slf4j
@Service("aaSyncDicDSService")
@AllArgsConstructor
public class SyncDicDSService implements IFaspClientScheduler {

    SyncDicDSMapper syncDicDSMapper;
    TableDBVersionClient client;
    FaspAuthenticateUtils faspAuthenticateUtils;
    Cache<String, List<String>> caffeineCache;
    DBChangeService changeService;
    SyncRangeMapper syncRangeMapper;
    CaffeineCacheService caffeineCacheService;

    @Override
    public void start(String origin, String target) {
        /**
         * 查询数据源用户当前拥有的表和视图名
         */
        try {
            changeService.changeDb(target);
        } catch (Exception e) {
            e.printStackTrace();
        }
        caffeineCacheService.saveUserTableViewNotNull(target);
        syncDs(target);
        syncDicTable(target);
        syncDicColumns(target);
    }

    private void syncDs(String target) {

        try {
            if (!exitsDs(target)) {
                syncDicDSMapper.createDs();
            }
            String tokenid = faspAuthenticateUtils.getFaspToken();
            String version = syncDicDSMapper.queryDSMaxVersion();
            version = StringUtils.isEmpty(version) ? SyncDataUtils.DEFAULT_DBVERSION : version;
            RestClientResultDTO<List<Map<String, Object>>> rsdto = null;
            Boolean isdelete = true;
            int page = 1;
            Integer syncCount = null;
            do {
                rsdto = client.queryTableData1KByDBVersion("fasp_t_dicds",
                        version, page++, tokenid);
                if (rsdto == null) {
                    return;
                }

                List<Map<String, Object>> dsDatas = rsdto.getData();
                if (CollectionUtils.isEmpty(dsDatas)) {
                    return;
                }
                if (CollectionUtils.isEmpty(dsDatas)) {
                    return;
                }
                dsDatas = dsDatas.stream().filter(
                        x -> {
                            if ("MOFDIV".equals(x.get("ELEMENTCODE"))) {
                                return false;
                            }
                            return true;
                        }
                ).map(y -> {
                            if ("ADMDIV".equals(y.get("ELEMENTCODE"))) {
                                y.put("ELEMENTCODE", "MOFDIV");
                                y.put("CODE", "VD08001");
                            }
                            return y;
                        }
                ).collect(Collectors.toList());

                if (version.equals(SyncDataUtils.DEFAULT_DBVERSION)) {
                    /**
                     * 首次同步清表批量写入
                     */
                    if (isdelete) {
                        syncDicDSMapper.deleteAllData("fasp_t_dicds");
                        isdelete = false;
                    }
                    Map<String, Object> param = new HashMap<>(2);
                    param.put("list", dsDatas);
                    syncDicDSMapper.batchInsertDicdsString(param);
                } else {
                    for (Map<String, Object> data : dsDatas) {
                        syncDicDSMapper.deleteDS(data.get("GUID").toString());
                        syncDicDSMapper.insertDSString(data);
                    }
                }
                syncCount = dsDatas.size();
                log.info("TABLENAME :[ FASP_T_DICDS ] DBVERSION :[" + version + "  data size=" + (syncCount + 1000 * (page - 2)) + " ]");
            } while (1000 == syncCount);
        } catch (Exception e) {
            log.info("TARGET:" + target + "TABLENAME :[ FASP_T_DICDS ] INFO :[" + e.getCause() + "]");
            if (e instanceof BadSqlGrammarException) {
                try {
                    caffeineCacheService.saveUserTableView(target);
                } catch (Exception exception) {
                    log.error("TARGET:" + target + "TABLENAME :[ FASP_T_DICDS ] ERROR :[" + exception.getCause() + "]");
                }
            }
        }
    }

    private void syncDicTable(String target) {
        try {
            if (!exitsDicTable(target)) {
                syncDicDSMapper.createDicTable();
            }
            // 获取平台认证
            String tokenid = faspAuthenticateUtils.getFaspToken();
            String version = syncDicDSMapper.queryTableMaxVersion();
            version = StringUtils.isEmpty(version) ? SyncDataUtils.DEFAULT_DBVERSION : version;
            RestClientResultDTO<List<Map<String, Object>>> rsdto = null;
            Boolean isdelete = true;
            int page = 1;
            Integer syncCount = null;
            do {

                rsdto = client.queryTableData1KByDBVersion("fasp_t_dictable",
                        version, page++, tokenid);
                if (rsdto == null) {
                    return;
                }

                List<Map<String, Object>> dsDatas = rsdto.getData();
                if (CollectionUtils.isEmpty(dsDatas)) {
                    return;
                }
                if (version.equals(SyncDataUtils.DEFAULT_DBVERSION)) {
                    /**
                     * 首次同步清表批量写入
                     */
                    if (isdelete) {
                        syncDicDSMapper.deleteAllData("fasp_t_mgdictable");
                        isdelete = false;
                    }
                    Map<String, Object> param = new HashMap<>(2);
                    param.put("list", dsDatas);
                    syncDicDSMapper.batchInsertDicTableString(param);
                } else {
                    for (Map<String, Object> data : dsDatas) {
                        syncDicDSMapper.deleteTable(data.get("TABLECODE").toString());
                        syncDicDSMapper.insertTableString(data);
                    }
                }
                syncCount = dsDatas.size();
                log.info("TABLENAME :[ FASP_T_MGDICTABLE ] DBVERSION :[" + version + "  data size=" + (syncCount + 1000 * (page - 2)) + " ]");
            } while (1000 == syncCount);
        } catch (Exception e) {
            log.info("TARGET:" + target + "TABLENAME :[ FASP_T_MGDICTABLE ] ERROR :[" + e.getCause() + "]");
            if (e instanceof BadSqlGrammarException) {
                try {
                    caffeineCacheService.saveUserTableView(target);
                } catch (Exception exception) {
                    log.error("TARGET:" + target + "TABLENAME :[ FASP_T_MGDICTABLE ] ERROR :[" + exception.getCause() + "]");
                }
            }

        }
    }

    private void syncDicColumns(String target) {
        try {
            if (!exitsDicColumn(target)) {
                syncDicDSMapper.createDicColumn();
            }

            // 获取平台认证
            String tokenid = faspAuthenticateUtils.getFaspToken();
            String version = syncDicDSMapper.queryColumnMaxVersion();
            version = StringUtils.isEmpty(version) ? SyncDataUtils.DEFAULT_DBVERSION : version;
            log.debug("query fasp_t_diccolumn DBVersion " + version);

            RestClientResultDTO<List<Map<String, Object>>> rsdto = null;
            int page = 1;
            Integer syncCount = null;
            Boolean isdelete = true;

            do {
                rsdto = client.queryTableData1KByDBVersion("fasp_t_diccolumn", version, page++, tokenid);
                if (rsdto == null) {
                    return;
                }

                List<Map<String, Object>> dsDatas = rsdto.getData();
                if (CollectionUtils.isEmpty(dsDatas)) {
                    return;
                }

                if (version.equals(SyncDataUtils.DEFAULT_DBVERSION)) {
                    /**
                     * 首次同步清表批量写入
                     */
                    if (isdelete) {
                        syncDicDSMapper.deleteAllData("fasp_t_mgdiccolumn");
                        isdelete = false;
                    }
                    Map<String, Object> param = new HashMap<>(2);
                    param.put("list", dsDatas);
                    syncDicDSMapper.batchInsertDicColumnString(param);
                } else {
                    for (Map<String, Object> data : dsDatas) {
                        syncDicDSMapper.deleteColumnByColumnId(data.get("COLUMNID").toString());
                        syncDicDSMapper.insertColumnString(data);
                    }
                }
                syncCount = dsDatas.size();
                log.info("TABLENAME :[ FASP_T_MGDICCOLUMN ] DBVERSION :[" + version + "  data size=" + (syncCount + 1000 * (page - 2)) + " ]");
            }
            while (1000 == syncCount);
        } catch (Throwable e) {
            log.info("TARGET:" + target + " TABLENAME :[ FASP_T_MGDICCOLUMN ] ERROR :[" + e.getCause() + "]");
            if (e instanceof BadSqlGrammarException) {
                try {
                    caffeineCacheService.saveUserTableView(target);
                } catch (Exception exception) {
                    log.error("TARGET:" + target + " TABLENAME :[ FASP_T_MGDICCOLUMN ] ERROR :[" + exception.getCause() + "]");
                }
            }

        }
    }


    Boolean exitsDs(String target) {
        ConcurrentMap<String, List<String>> concurrentMap = caffeineCache.asMap();
        if (!StringUtils.isEmpty(concurrentMap)) {
            List<String> tableList = caffeineCache.asMap().get("tableList_" + target);
            return tableList.contains("FASP_T_DICDS");
        }
        return false;
    }

    Boolean exitsDicTable(String target) {
        ConcurrentMap<String, List<String>> concurrentMap = caffeineCache.asMap();
        if (!StringUtils.isEmpty(concurrentMap)) {
            List<String> tableList = caffeineCache.asMap().get("tableList_" + target);
            return tableList.contains("FASP_T_MGDICTABLE");
        }
        return false;
    }

    Boolean exitsDicColumn(String target) {
        ConcurrentMap<String, List<String>> concurrentMap = caffeineCache.asMap();
        if (!StringUtils.isEmpty(concurrentMap)) {
            List<String> tableList = caffeineCache.asMap().get("tableList_" + target);
            return tableList.contains("FASP_T_MGDICCOLUMN");
        }
        return false;
    }
}
