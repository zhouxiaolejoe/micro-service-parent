package com.micro.service.springquartz.syncapi;


import com.github.benmanes.caffeine.cache.Cache;
import com.micro.service.springquartz.clientapi.CaRoleClient;
import com.micro.service.springquartz.clientapi.TableDBVersionClient;
import com.micro.service.springquartz.mapper.DataSourceMapper;
import com.micro.service.springquartz.mapper.target.SyncMenuMapper;
import com.micro.service.springquartz.mapper.target.SyncRoleMenuMapper;
import com.micro.service.springquartz.model.ClientApiRoleMenuRestDTO;
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
public class MenuService implements IFaspClientScheduler {
    SyncMenuMapper syncMenuMapper;
    SyncRoleMenuMapper syncRoleMenuMapper;
    FaspAuthenticateUtils faspAuthenticateUtils;
    TableDBVersionClient client;
    CaRoleClient roleClient;
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
            checkMenuTable(target);
            checkMenuRoleTable(target);
            String userVersion = syncMenuMapper.queryMenuVersion();
            userVersion = StringUtils.isEmpty(userVersion) ? SyncDataUtils.DEFAULT_DBVERSION : userVersion;
            Integer syncCount = null;

            String tokenid = faspAuthenticateUtils.getFaspToken();
            RestClientResultDTO<List<Map<String, Object>>> rs = null;
            int page = 1;

            do {
                if (StringUtils.isEmpty(province) && StringUtils.isEmpty(year)) {
                    rs = client.queryTableData1KByDBVersion("FASP_T_PUBMENU", userVersion, page++, tokenid);
                    log.debug("TABLENAME: FASP_T_PUBMENU" + " PROVINCE: " + province + " YEAR: " + year + " 用户菜单不分区划: " + rs);
                } else {
                    rs = client.queryTableData1KByProvinceYearDBVersion(province, year, "FASP_T_PUBMENU", userVersion, page++, tokenid);
                    log.debug("TABLENAME: FASP_T_PUBMENU" + " PROVINCE: " + province + " YEAR: " + year + " 用户菜单: " + rs);
                }
                if (rs == null) {
                    break;
                }

                List<Map<String, Object>> datas = rs.getData();

                if (CollectionUtils.isEmpty(datas)) {
                    break;
                }

                for (Map<String, Object> menu : datas) {
                    syncData(menu);
                    syncMenuRoleMapper((String) menu.get("GUID"));
                }
                syncCount = datas.size();
                log.info("PROVINCE: " + province + " YEAR: " + year + " TABLENAME :[ FASP_T_PUBMENU ] DBVERSION :[" + userVersion + "] DATA SIZE: [ " + (syncCount + 1000 * (page - 2)) + " ]");
            }
            while (1000 == syncCount);
        } catch (Exception e) {
            log.info("TARGET:" + target + " TABLENAME :[ FASP_T_PUBMENU ] INFO :[" + e.getCause() + "]");
            if (e instanceof Exception) {
                try {
                    caffeineCacheService.saveUserTableView(target);
                } catch (Exception exception) {
                    log.error("TARGET:" + target + " TABLENAME :[ FASP_T_PUBMENU ] ERROR :[" + exception.getCause() + "]");
                }
            }
        }
    }

    @Transactional(rollbackFor = Exception.class)
    String syncData(Map<String, Object> menu) {
        String dbversion = (String) menu.get("DBVERSION");
        syncMenuMapper.deleteMenuData(menu);
        syncMenuMapper.insertMenuDataString(menu);
        return dbversion;
    }


    Boolean exitsMenuTable(String target) {
        ConcurrentMap<String, List<String>> concurrentMap = caffeineCache.asMap();
        if (!StringUtils.isEmpty(concurrentMap)) {
            List<String> tableList = concurrentMap.get("tableList_" + target);
            return tableList.contains("FASP_T_PUBMENU");
        }
        return false;
    }

    Boolean exitsMenuRoleTable(String target) {
        ConcurrentMap<String, List<String>> concurrentMap = caffeineCache.asMap();
        if (!StringUtils.isEmpty(concurrentMap)) {
            List<String> tableList = concurrentMap.get("tableList_" + target);
            return tableList.contains("FASP_T_CAROLEMENU");
        }
        return false;
    }


    private void checkMenuRoleTable(String target) {
        String tablename = "fasp_t_carolemenu";
        if (exitsMenuRoleTable(target)) {
            return;
        }
        syncRoleMenuMapper.createMenuRoleTable();
    }

    private void checkMenuTable(String target) {
        if (exitsMenuTable(target)) {
            return;
        }
        syncMenuMapper.createMenuTable();
    }

    private void syncMenuRoleMapper(String menuguid) {
        syncRoleMenuMapper.deleteMenuRoles(menuguid);
        RestClientResultDTO<List<ClientApiRoleMenuRestDTO>> rs = roleClient.getRoleMenuMapping(menuguid);
        if (rs == null) {
            return;
        }
        List<ClientApiRoleMenuRestDTO> mappers = rs.getData();
        if (CollectionUtils.isEmpty(mappers)) {
            return;
        }
        for (ClientApiRoleMenuRestDTO dto : mappers) {
            syncRoleMenuMapper.insertMenuRole(dto);
        }
    }
}
