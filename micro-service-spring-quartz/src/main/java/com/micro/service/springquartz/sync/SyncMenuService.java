package com.micro.service.springquartz.sync;


import com.github.pagehelper.PageHelper;
import com.micro.service.springquartz.clientapi.CaRoleClient;
import com.micro.service.springquartz.clientapi.TableDBVersionClient;
import com.micro.service.springquartz.mapper.origin.OriginMapper;
import com.micro.service.springquartz.mapper.target.SyncMenuMapper;
import com.micro.service.springquartz.mapper.target.SyncRoleMenuMapper;
import com.micro.service.springquartz.model.ClientApiRoleMenuRestDTO;
import com.micro.service.springquartz.model.RestClientResultDTO;
import com.micro.service.springquartz.service.DBChangeService;
import com.micro.service.springquartz.utils.SyncDataUtils;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;

import java.util.List;
import java.util.Map;


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
public class SyncMenuService implements SyncScheduler {
    SyncMenuMapper syncMenuMapper;
    SyncRoleMenuMapper syncRoleMenuMapper;
    TableDBVersionClient client;
    CaRoleClient roleClient;
    DBChangeService changeService;
    OriginMapper originMapper;

    @Override
    public void start(String origin, String target) {
        try {
            changeService.changeDb(target);
        } catch (Exception e) {
            e.printStackTrace();
        }
        checkMenuTable();
        checkMenuRoleTable();
        String userVersion = syncMenuMapper.queryMenuVersion();
        userVersion = StringUtils.isEmpty(userVersion) ? SyncDataUtils.DEFAULT_DBVERSION : userVersion;
        Integer syncCount = null;

        try {
            // 获取平台认证
            RestClientResultDTO<List<Map<String, Object>>> rs = null;
            int page = 1;

            do {
                changeService.changeDb(origin);
                PageHelper.startPage(page++, 1000);
                List<Map<String, Object>> dsDatas = originMapper.queryTableDataByDBVersion("FASP_T_PUBMENU", userVersion);
                if (CollectionUtils.isEmpty(dsDatas)) {
                    break;
                }

                for (Map<String, Object> menu : dsDatas) {
                    syncData(menu, origin, target);
                    syncMenuRoleMapper((String) menu.get("GUID"), origin, target);
                }
                syncCount = dsDatas.size();
                log.info("TABLENAME :[ FASP_T_PUBMENU ] DBVERSION :[" + userVersion + "] DATA SIZE: [ " + (syncCount + 1000 * (page - 2)) + " ]");
            }
            while (1000 == syncCount);

        } catch (Exception e) {
            log.error("同步用户数据失败。", e);
        }
    }

    @Transactional(rollbackFor = Exception.class)
    void syncData(Map<String, Object> menu, String origin, String target) throws Exception {
        changeService.changeDb(target);
        syncMenuMapper.deleteMenuData(menu);
        syncMenuMapper.insertMenuData(menu);
    }


    Boolean exitsMenuTable() {
        if (syncMenuMapper.exitsMenuTable() > 0) {
            return true;
        }
        return false;
//        List<String> tableList = TableContextHolder.getTableData().get("tableList");
//        return CollectionUtils.isEmpty(tableList) ? false : tableList.contains("FASP_T_PUBMENU");
    }

    Boolean exitsMenuRoleTable() {

        if (syncRoleMenuMapper.exitsMenuRoleTable() > 0) {
            return true;
        }
        return false;
//        List<String> tableList = TableContextHolder.getTableData().get("tableList");
//        return CollectionUtils.isEmpty(tableList) ? false : tableList.contains("FASP_T_CAROLEMENU");
    }


    private void checkMenuRoleTable() {
        String tablename = "fasp_t_carolemenu";
        log.debug("check table [" + tablename + "] exits ");
        if (exitsMenuRoleTable()) {
            return;
        }
        log.debug("create table " + tablename);
        syncRoleMenuMapper.createMenuRoleTable();
    }

    private void checkMenuTable() {
        String tablename = "fasp_t_pubmenu";
        log.debug("check table [" + tablename + "] exits ");
        if (exitsMenuTable()) {
            return;
        }
        log.debug("create table " + tablename);
        syncMenuMapper.createMenuTable();
    }

    private void syncMenuRoleMapper(String menuguid, String origin, String target) throws Exception {
        changeService.changeDb(target);
        syncRoleMenuMapper.deleteMenuRoles(menuguid);
        changeService.changeDb(origin);
        List<ClientApiRoleMenuRestDTO> mappers = originMapper.queryRoleMenuMapping(menuguid);
        if (CollectionUtils.isEmpty(mappers)) {
            return;
        }
        changeService.changeDb(target);
        for (ClientApiRoleMenuRestDTO dto : mappers) {
            syncRoleMenuMapper.insertMenuRole(dto);
        }
    }
}
