package com.micro.service.springquartz.syncapi;

import com.github.benmanes.caffeine.cache.Cache;
import com.micro.service.springquartz.config.fasp3client.FaspDic3ClientSetting;
import com.micro.service.springquartz.mapper.target.SyncDicDSMapper;
import com.micro.service.springquartz.mapper.target.SyncRangeMapper;
import com.micro.service.springquartz.model.Dic3SyncDSPO;
import com.micro.service.springquartz.service.CaffeineCacheService;
import com.micro.service.springquartz.service.DBChangeService;
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
 * @Date 2020-10-28  16:28:51
 **/
@Service("ccSyncConfigService")
@Slf4j
@AllArgsConstructor
public class SyncConfigService implements IFaspClientScheduler {

    SyncDicDSMapper syncDicDSMapper;
    SyncRangeMapper syncRangeMapper;
    private FaspDic3ClientSetting dic3ClientSetting;
    DBChangeService changeService;
    Cache<String, List<String>> caffeineCache;
    CaffeineCacheService caffeineCacheService;

    @Override
    public void start(String origin, String target) {
        try {
            changeService.changeDb(target);
            if (!existDic3syncdsTable(target)) {
                syncDicDSMapper.createDic3syncdsTable();
            }
            String syncCode = dic3ClientSetting.getSyncElementcode();
            List<Dic3SyncDSPO> pos = null;
            if (StringUtils.isEmpty(syncCode)) {
                pos = querySyncElementsFromDS();
            } else {
                pos = querySyncElementsFromDSByElementcodes(syncCode.split(","));
            }

            if (CollectionUtils.isEmpty(pos)) {
                return;
            }
            log.info("TABLENAME :[ FASP_T_DIC3SYNCDS ] data size=" + (pos.size()) + " ]");

            insertSyncElements(pos);
            syncDicDSMapper.deleteSyncElements();

        } catch (Throwable e) {
            log.info("TARGET:" + target + " TABLENAME :[ FASP_T_DIC3SYNCDS ] INFO :[" + e.getCause() + "]");
            if (e instanceof Exception) {
                try {
                    caffeineCacheService.saveUserTableView(target);
                } catch (Exception exception) {
                    log.error("TARGET:" + target + " TABLENAME :[ FASP_T_DIC3SYNCDS ] ERROR :[" + exception.getCause() + "]");
                }
            }
        }
    }

    void insertSyncElements(List<Dic3SyncDSPO> pos) {
        for (Dic3SyncDSPO po : pos) {
            po.setTablename(po.getTablename().toLowerCase().trim());
            syncDicDSMapper.insertSyncElements(po);
        }
    }

    List<Dic3SyncDSPO> querySyncElementsFromDS() {
        List<Dic3SyncDSPO> pos = syncDicDSMapper.querySyncElementsFromDS();
        for (Dic3SyncDSPO po : pos) {
            po.setTablename(dic3ClientSetting.getSyncTablenamePrefix() + po.getTablename().toLowerCase().trim());
        }
        return pos;
    }

    List<Dic3SyncDSPO> querySyncElementsFromDSByElementcodes(String[] elementcodes) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("elementcodes", elementcodes);
        List<Dic3SyncDSPO> pos = syncDicDSMapper.querySyncElementsFromDSByElementcodes(params);
        for (Dic3SyncDSPO po : pos) {
            po.setTablename(dic3ClientSetting.getSyncTablenamePrefix() + po.getTablename().toLowerCase().trim());
        }
        return pos;
    }

    Boolean existDic3syncdsTable(String target) {
        ConcurrentMap<String, List<String>> concurrentMap = caffeineCache.asMap();
        if (!StringUtils.isEmpty(concurrentMap)) {
            List<String> tableList = concurrentMap.get("tableList_" + target);
            return tableList.contains("FASP_T_DIC3SYNCDS");
        }
        return false;
    }
}
