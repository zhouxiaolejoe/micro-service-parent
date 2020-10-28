package com.micro.service.springquartz.syncapi;


import com.github.benmanes.caffeine.cache.Cache;
import com.micro.service.springquartz.clientapi.TableDBVersionClient;
import com.micro.service.springquartz.config.fasp3client.FaspClientException;
import com.micro.service.springquartz.mapper.target.SyncDicDEMapper;
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


/**
 * @Description
 * @Author zxl
 * @Date 2020-10-28  16:28:59
 **/
@Service("bSyncDicDEService")
@Slf4j
@AllArgsConstructor
public class SyncDicDEService implements IFaspClientScheduler {

    SyncDicDEMapper syncDicDEMapper;
    TableDBVersionClient client;
    FaspAuthenticateUtils faspAuthenticateUtils;
    DBChangeService changeService;
    CaffeineCacheService caffeineCacheService;
    Cache<String, List<String>> caffeineCache;

    @Override
    public void start(String origin, String target) {
        try {
            changeService.changeDb(target);
            if (!exitsDeTable(target)) {
                syncDicDEMapper.createDeTable();
            }

            // 获取平台认证
            String tokenid = faspAuthenticateUtils.getFaspToken();
            String version = syncDicDEMapper.queryDEMaxVersion();
            version = StringUtils.isEmpty(version) ? SyncDataUtils.DEFAULT_DBVERSION : version;
            RestClientResultDTO<List<Map<String, Object>>> rsdto = null;
            int page = 1;
            Integer syncCount = null;
            Boolean isdelete = true;

            do {
                rsdto = client.queryTableData1KByDBVersion("fasp_t_dicde",
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
                        syncDicDEMapper.deleteAllData("fasp_t_dicde");
                        isdelete = false;
                    }
                    Map<String, Object> param = new HashMap<>(2);
                    param.put("list", dsDatas);
                    syncDicDEMapper.batchInsertDicDEString(param);
                } else {
                    for (Map<String, Object> data : dsDatas) {
                        syncDicDEMapper.deleteDE(data.get("guid").toString());
                        syncDicDEMapper.insertDEString(data);
                    }
                }
                syncCount = dsDatas.size();
                log.info("TABLENAME :[ FASP_T_DICDE ] DBVERSION :[" + version + "  data size=" + (syncCount + 1000 * (page - 2)) + " ]");
            }
            while (1000 == syncCount);
        } catch (Exception e) {
            log.info("TABLENAME :[ FASP_T_DICDE ] INFO :[" + e.getCause() + "]");
            if (e instanceof BadSqlGrammarException) {
                try {
                    caffeineCacheService.saveUserTableView(target);
                } catch (Exception exception) {
                    log.error("TABLENAME :[ FASP_T_DICDE ] ERROR :[" + exception.getCause() + "]");
                }
            }
        }
    }

    Boolean exitsDeTable(String target) {
        ConcurrentMap<String, List<String>> concurrentMap = caffeineCache.asMap();
        if (!StringUtils.isEmpty(concurrentMap)) {
            List<String> tableList = concurrentMap.get("tableList_" + target);
            return tableList.contains("FASP_T_DICDE");
        }
        return false;
    }
}
