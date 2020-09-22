package com.micro.service.springquartz.sync;

import com.github.pagehelper.PageHelper;
import com.micro.service.springquartz.config.TableContextHolder;
import com.micro.service.springquartz.mapper.origin.OriginMapper;
import com.micro.service.springquartz.mapper.target.SyncRoleMapper;
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

import static com.micro.service.springquartz.utils.MapUtils.toLowerMapKey;

/**
 * 同步用户表内容
 * Created by wengy on 2019/11/20.
 */
@Service
@Slf4j
@AllArgsConstructor
public class SyncRoleService implements IFaspClientScheduler {

    OriginMapper originMapper;
    DBChangeService changeService;
    SyncRoleMapper syncRoleMapper;

    @Override
    public void start(String origin, String target) {
        if (StringUtils.isEmpty(origin) || StringUtils.isEmpty(target)) {
            return;
        }
        try {
            /**
             * 切换到目标库
             */
            changeService.changeDb(target);
            checkRoleTable();
            String version = syncRoleMapper.queryRoleVersion();
            version = StringUtils.isEmpty(version) ? SyncDataUtils.DEFAULT_DBVERSION : version;
            Integer syncCount;
            Integer page = 1;
            do {
                /**
                 * 切换到源库
                 */
                changeService.changeDb(origin);
                PageHelper.startPage(page++, 1000);
                List<Map<String, Object>> datas = originMapper.queryTableDataByDBVersion("FASP_T_CAROLE", version);

                if (CollectionUtils.isEmpty(datas)) {
                    break;
                }

                /**
                 * 切换到目标库 写入数据
                 */
                changeService.changeDb(target);
                for (Map<String, Object> role : datas) {
                    syncData(role);
                }

                syncCount = datas.size();
                log.info("TABLENAME :[ FASP_T_CAROLE ] DBVERSION :[" + version + "] DATA SIZE: [ " + (syncCount + 1000 * (page - 2)) + " ]");
            }
            while (1000 == syncCount);
        } catch (Exception e) {
            log.error("TABLENAME :[ FASP_T_CAROLE ] 数据同步失败");
        }

    }

    @Transactional(rollbackFor = Exception.class)
    Object syncData(Map<String, Object> role) {
        toLowerMapKey(role);
        Object dbversion = role.get("dbversion");
        syncRoleMapper.deleteRoleData(role);
        syncRoleMapper.insertRoleData(role);
        return dbversion;
    }

    private void checkRoleTable() {
        if (exitsRoleTable()) {
            return;
        }
        syncRoleMapper.createRoleTable();
    }

    private Boolean exitsRoleTable() {
        List<String> tableList = TableContextHolder.getTableData().get("tableList");
        return CollectionUtils.isEmpty(tableList) ? false : tableList.contains("FASP_T_CAROLE");
    }


}
