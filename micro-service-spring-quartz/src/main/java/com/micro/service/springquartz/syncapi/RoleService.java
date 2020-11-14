package com.micro.service.springquartz.syncapi;

import com.github.benmanes.caffeine.cache.Cache;
import com.micro.service.springquartz.clientapi.TableDBVersionClient;
import com.micro.service.springquartz.mapper.DataSourceMapper;
import com.micro.service.springquartz.mapper.target.SyncRoleMapper;
import com.micro.service.springquartz.model.DataSourceInfo;
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

import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentMap;


/**
 * @Description
 * @Author zxl
 * @Date 2020-10-28  16:28:35
 **/
@Service
@Slf4j
@AllArgsConstructor
public class RoleService implements IFaspClientScheduler {
    SyncRoleMapper syncRoleMapper;
    FaspAuthenticateUtils faspAuthenticateUtils;
    TableDBVersionClient client;
    DBChangeService changeService;
    Cache<String, List<String>> caffeineCache;
    CaffeineCacheService caffeineCacheService;
    DataSourceMapper dataSourceMapper;

    @Override
    public void start(String origin, String target) {
        try {
            changeService.changeDb("mainDataSource");
            DataSourceInfo dataSourceInfo = dataSourceMapper.getOne(target);
            String province = dataSourceInfo.getProvince();
            String year = dataSourceInfo.getYear();

            changeService.changeDb(target);
            checkUserTable(target);
            String userVersion = syncRoleMapper.queryRoleVersion();
            userVersion = StringUtils.isEmpty(userVersion) ? SyncDataUtils.DEFAULT_DBVERSION : userVersion;
            Integer syncCount = null;
            String tokenid = faspAuthenticateUtils.getFaspToken();
            RestClientResultDTO<List<Map<String, Object>>> rs = null;
            int page = 1;

            do {
                if (StringUtils.isEmpty(province) && StringUtils.isEmpty(year)) {
                    rs = client.queryTableData1KByDBVersion("FASP_T_CAROLE", userVersion, page++, tokenid);
                } else {
                    rs = client.queryTableData1KByProvinceYearDBVersion(province, year, "FASP_T_CAROLE", userVersion, page++, tokenid);
                }
                if (rs == null) {
                    break;
                }
                List<Map<String, Object>> datas = rs.getData();

                if (CollectionUtils.isEmpty(datas)) {
                    break;
                }
                for (Map<String, Object> role : datas) {
                    syncData(role);
                }
                syncCount = datas.size();
                log.info("TABLENAME :[ FASP_T_CAROLE ] DBVERSION :[" + userVersion + "] DATA SIZE: [ " + (syncCount + 1000 * (page - 2)) + " ]");
            }
            while (1000 == syncCount);

        } catch (Exception e) {
            log.info("TARGET:" + target + " TABLENAME :[ FASP_T_CAROLE ] INFO :[" + e.getCause() + "]");
            if (e instanceof BadSqlGrammarException) {
                try {
                    caffeineCacheService.saveUserTableView(target);
                } catch (Exception exception) {
                    log.error("TARGET:" + target + " TABLENAME :[ FASP_T_CAROLE ] ERROR :[" + exception.getCause() + "]");
                }
            }
        }
    }


    private void checkUserTable(String target) {
        if (exitsRoleTable(target)) {
            return;
        }
        syncRoleMapper.createRoleTable();
    }

    @Transactional(rollbackFor = Exception.class)
    String syncData(Map<String, Object> role) {
        String dbversion = (String) role.get("DBVERSION");
        syncRoleMapper.deleteRoleData(role);
        syncRoleMapper.insertRoleData(role);
        return dbversion;
    }

    Boolean exitsRoleTable(String target) {
        ConcurrentMap<String, List<String>> concurrentMap = caffeineCache.asMap();
        if (!StringUtils.isEmpty(concurrentMap)) {
            List<String> tableList = concurrentMap.get("tableList_" + target);
            return tableList.contains("FASP_T_CAROLE");
        }
        return false;
    }
}