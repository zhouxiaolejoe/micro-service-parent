package com.micro.service.springquartz.sync;


import com.github.pagehelper.PageHelper;
import com.micro.service.springquartz.clientapi.CaRoleClient;
import com.micro.service.springquartz.clientapi.TableDBVersionClient;
import com.micro.service.springquartz.mapper.origin.OriginMapper;
import com.micro.service.springquartz.mapper.target.SyncUserMapper;
import com.micro.service.springquartz.mapper.target.SyncUserRoleMapper;
import com.micro.service.springquartz.model.ClientApiRoleUserRestDTO;
import com.micro.service.springquartz.model.RestClientResultDTO;
import com.micro.service.springquartz.service.DBChangeService;
import com.micro.service.springquartz.utils.FaspAuthenticateUtils;
import com.micro.service.springquartz.utils.SyncDataUtils;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;

import java.util.List;
import java.util.Map;

import static com.micro.service.springquartz.utils.MapUtils.toLowerMapKey;


/**
 * @ClassName UserService
 * @Description TODO
 * @Author zhouxiaole
 * @Date 2020/8/30 13:19
 * @Version 1.0.0
 */
@Service
@Slf4j
@AllArgsConstructor
public class SyncUserService implements IFaspClientScheduler {
    SyncUserMapper syncUserMapper;
    FaspAuthenticateUtils faspAuthenticateUtils;
    TableDBVersionClient client;
    CaRoleClient roleClient;
    OriginMapper originMapper;
    SyncUserRoleMapper syncUserRoleMapper;
    DBChangeService changeService;

    @Override
    public void start(String origin, String target) {
        try {
            changeService.changeDb(target);
        } catch (Exception e) {
            e.printStackTrace();
        }
        checkUserTable();
        checkUserRoleTable();
        String userVersion = syncUserMapper.queryUserVersion();
        userVersion = StringUtils.isEmpty(userVersion) ? SyncDataUtils.DEFAULT_DBVERSION : userVersion;
        Integer syncCount = null;

        try {
            // 获取平台认证
            String tokenid = faspAuthenticateUtils.getFaspToken();
            RestClientResultDTO<List<Map<String, Object>>> rs = null;
            int page = 1;
            do {
                changeService.changeDb(origin);
                PageHelper.startPage(page++, 1000);
                List<Map<String, Object>> dsDatas = originMapper.queryTableDataByDBVersion("FASP_T_CAUSER", userVersion);
                if (CollectionUtils.isEmpty(dsDatas)) {
                    break;
                }

                for (Map<String, Object> user : dsDatas) {
                    syncData(user, origin, target);
                    syncUserRoleMapper((String) user.get("GUID"), origin, target);
                }
                syncCount = dsDatas.size();
                log.info("TABLENAME :[ FASP_T_CAUSER ] DBVERSION :[" + userVersion + "] DATA SIZE: [ " + (syncCount + 1000 * (page - 2)) + " ]");
            }
            while (1000 == syncCount);

        } catch (Exception e) {
            log.error("同步用户数据失败。", e);
        }
    }

    private void checkUserTable() {
        String tablename = "fasp_t_causer";
        log.debug("check table [" + tablename + "] exits ");
        if (exitsUserTable()) {
            return;
        }
        log.debug("create table " + tablename);
        syncUserMapper.createUserTable();
    }

    @Transactional(rollbackFor = Exception.class)
    void syncData(Map<String, Object> user,String origin, String target) throws Exception {
        changeService.changeDb(target);
        syncUserMapper.deleteUserData(user);
        syncUserMapper.insertUserData(user);
    }

    private void checkUserRoleTable() {
        String tablename = "fasp_t_causerrole";
        log.debug("check table [" + tablename + "] exits ");

        if (exitsUserRoleTable()) {
            return;
        }
        log.debug("create table " + tablename);
        syncUserRoleMapper.createUserRoleTable();
    }

    Boolean exitsUserTable() {

        if (syncUserMapper.exitsUserTable() > 0) {
            return true;
        }
        return false;
//        List<String> tableList = TableContextHolder.getTableData().get("tableList");
//        return CollectionUtils.isEmpty(tableList)?false:tableList.contains("FASP_T_CAUSER");
    }

    Boolean exitsUserRoleTable() {
//        List<String> tableList = TableContextHolder.getTableData().get("tableList");
//        return CollectionUtils.isEmpty(tableList)?false:tableList.contains("FASP_T_CAUSERROLE");
        if (syncUserRoleMapper.exitsUserRoleTable() > 0) {
            return true;
        }
        return false;
    }


    private void syncUserRoleMapper(String userguid, String origin, String target) throws Exception {
        changeService.changeDb(target);
        syncUserRoleMapper.deleteUserRoles(userguid);
        changeService.changeDb(origin);
        List<ClientApiRoleUserRestDTO> mappers = originMapper.queryUserRolemapping(userguid);
        if (CollectionUtils.isEmpty(mappers)) {
            return;
        }
        changeService.changeDb(target);
        for (ClientApiRoleUserRestDTO dto : mappers) {
            syncUserRoleMapper.insertUserRole(dto);
        }
    }
}
