package com.micro.service.springquartz.sync;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.micro.service.springquartz.mapper.origin.OriginMapper;
import com.micro.service.springquartz.mapper.target.SyncRoleMapper;
import com.micro.service.springquartz.service.DBChangeService;
import com.micro.service.springquartz.utils.SyncDataUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
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
public class SyncRoleService implements IFaspClientScheduler {
    public static final String DEFAULT_DBVERSION = "20000101000000";
    @Autowired
    OriginMapper originMapper;
    @Autowired
    DBChangeService changeService;
    @Autowired
    SyncRoleMapper syncRoleMapper;

    @Override
    public void start(String origin, String target) {
        if (StringUtils.isEmpty(origin) || StringUtils.isEmpty(target)) {
            return;
        }

        /**
         * 切换到目标库
         */
        try {
            changeService.changeDb(target);
        } catch (Exception e) {
            e.printStackTrace();
        }
        String version = syncRoleMapper.queryRoleVersion();
        version = StringUtils.isEmpty(version) ? SyncDataUtils.DEFAULT_DBVERSION : version;
        Integer syncCount = null;
        Integer page = 1;
        do {
            /**
             * 切换到源库
             */
            try {
                changeService.changeDb(origin);
            } catch (Exception e) {
                e.printStackTrace();
            }
            PageHelper.startPage(page++, 10);
            List<Map<String, Object>> datas = originMapper.queryTableDataByDBVersion("FASP_T_CAROLE", version);

            if (CollectionUtils.isEmpty(datas)) {
                break;
            }

            /**
             * 切换到目标库 写入数据
             */
            try {
                changeService.changeDb(target);
            } catch (Exception e) {
                e.printStackTrace();
            }
            for (Map<String, Object> role : datas) {
                syncData(role);
            }

            syncCount = datas.size();
            log.info("TABLENAME :[ FASP_T_CAUSER ] DBVERSION :[" + version + "] DATA SIZE: [ " + (syncCount + 10 * (page - 2)) + " ]");
        }
        while (10 == syncCount);

    }

    @Transactional(rollbackFor = Exception.class)
    Object syncData(Map<String, Object> role) {
        toLowerMapKey(role);
        Object dbversion = role.get("dbversion");
        syncRoleMapper.deleteRoleData(role);
        syncRoleMapper.insertRoleData(role);
        return dbversion;
    }
}
