package com.micro.service.springquartz.syncapi;


import com.github.benmanes.caffeine.cache.Cache;
import com.micro.service.springquartz.clientapi.CaRoleClient;
import com.micro.service.springquartz.clientapi.TableDBVersionClient;
import com.micro.service.springquartz.mapper.DataSourceMapper;
import com.micro.service.springquartz.mapper.target.SyncUserMapper;
import com.micro.service.springquartz.mapper.target.SyncUserRoleMapper;
import com.micro.service.springquartz.model.ClientApiRoleUserRestDTO;
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
 * @ClassName UserService
 * @Description TODO
 * @Author zxl
 * @Date 2020/8/30 13:19
 * @Version 1.0.0
 */
@Service
@Slf4j
@AllArgsConstructor
public class UserService implements IFaspClientScheduler {
    SyncUserMapper syncUserMapper;
    FaspAuthenticateUtils faspAuthenticateUtils;
    TableDBVersionClient client;
    CaRoleClient roleClient;
    SyncUserRoleMapper syncUserRoleMapper;
    DBChangeService changeService;
    Cache<String, List<String>> caffeineCache;
    CaffeineCacheService caffeineCacheService;
    DataSourceMapper dataSourceMapper;

    @Override
    public void start(String origin, String target) {
        try {
            /**
             * 获取数据源年度区划
             */
            changeService.changeDb("mainDataSource");
            DataSourceInfo dataSourceInfo = dataSourceMapper.getOne(target);
            String province = dataSourceInfo.getProvince();
            String year = dataSourceInfo.getYear();

            changeService.changeDb(target);
            checkUserTable(target);
            checkUserRoleTable(target);
            String userVersion = syncUserMapper.queryUserVersion();
            userVersion = StringUtils.isEmpty(userVersion) ? SyncDataUtils.DEFAULT_DBVERSION : userVersion;
            Integer syncCount = null;

            String tokenid = faspAuthenticateUtils.getFaspToken();
            RestClientResultDTO<List<Map<String, Object>>> rs = null;
            int page = 1;
            do {
                if(StringUtils.isEmpty(province)&&StringUtils.isEmpty(year)){
                    rs = client.queryTableData1KByDBVersion("FASP_T_CAUSER", userVersion, page++, tokenid);
                }else {
                    rs = client.queryTableData1KByProvinceYearDBVersion(province,year,"FASP_T_CAUSER", userVersion, page++, tokenid);
                }
                if (rs == null) {
                    break;
                }

                List<Map<String, Object>> datas = rs.getData();

                if (CollectionUtils.isEmpty(datas)) {
                    break;
                }

                for (Map<String, Object> user : datas) {
                    syncData(user);
                    syncUserRoleMapper((String) user.get("GUID"));
                }
                syncCount = datas.size();
                log.info("TABLENAME :[ FASP_T_CAUSER ] DBVERSION :[" + userVersion + "] DATA SIZE: [ " + (syncCount + 1000 * (page - 2)) + " ]");
            }
            while (1000 == syncCount);
        } catch (Exception e) {
            log.info("TARGET:" + target + " TABLENAME :[ FASP_T_CAUSER ] INFO :[" + e.getCause() + "]");
            if (e instanceof BadSqlGrammarException) {
                try {
                    caffeineCacheService.saveUserTableView(target);
                } catch (Exception exception) {
                    log.error("TARGET:" + target + " TABLENAME :[ FASP_T_CAUSER ] ERROR :[" + exception.getCause() + "]");
                }
            }
        }
    }

    private void checkUserTable(String target) {
        String tablename = "fasp_t_causer";
        log.debug("check table [" + tablename + "] exits ");
        if (exitsUserTable(target)) {
            return;
        }
        log.debug("create table " + tablename);
        syncUserMapper.createUserTable();
    }

    @Transactional(rollbackFor = Exception.class)
    String syncData(Map<String, Object> user) {
        String dbversion = (String) user.get("DBVERSION");
        syncUserMapper.deleteUserData(user);
        syncUserMapper.insertUserDataString(user);
        return dbversion;
    }

    private void checkUserRoleTable(String target) {
        String tablename = "fasp_t_causerrole";
        log.debug("check table [" + tablename + "] exits ");

        if (exitsUserRoleTable(target)) {
            return;
        }
        log.debug("create table " + tablename);
        syncUserRoleMapper.createUserRoleTable();
    }

    Boolean exitsUserTable(String target) {
        ConcurrentMap<String, List<String>> concurrentMap = caffeineCache.asMap();
        if (!StringUtils.isEmpty(concurrentMap)) {
            List<String> tableList = concurrentMap.get("tableList_" + target);
            return tableList.contains("FASP_T_CAUSER");
        }
        return false;
    }

    Boolean exitsUserRoleTable(String target) {
        ConcurrentMap<String, List<String>> concurrentMap = caffeineCache.asMap();
        if (!StringUtils.isEmpty(concurrentMap)) {
            List<String> tableList = concurrentMap.get("tableList_" + target);
            return tableList.contains("FASP_T_CAUSERROLE");
        }
        return false;
    }


    private void syncUserRoleMapper(String userguid) {
        syncUserRoleMapper.deleteUserRoles(userguid);
        RestClientResultDTO<List<ClientApiRoleUserRestDTO>> rs = roleClient.getRoleUserMapping(userguid);
        if (rs == null) {
            return;
        }

        List<ClientApiRoleUserRestDTO> mappers = rs.getData();
        if (CollectionUtils.isEmpty(mappers)) {
            return;
        }
        for (ClientApiRoleUserRestDTO dto : mappers) {
            syncUserRoleMapper.insertUserRole(dto);
        }
    }
}
