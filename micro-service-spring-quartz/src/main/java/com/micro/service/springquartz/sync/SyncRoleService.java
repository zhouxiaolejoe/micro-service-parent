package com.micro.service.springquartz.sync;

import com.github.benmanes.caffeine.cache.Cache;
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
import sun.misc.BASE64Encoder;

import java.lang.reflect.Method;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

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
    Cache<String, List<String>> caffeineCache;

    @Override
    public void start(String origin, String target) {
        if (StringUtils.isEmpty(origin) || StringUtils.isEmpty(target)) {
            return;
        }
        try {
            String version = getRoleVersion(target);
            Integer syncCount;
            Integer page = 1;
            Boolean isdelete = true;
            do {
                /**
                 * 切换到源库
                 */
                changeService.changeDb(origin);
                PageHelper.startPage(page++, 1000);
                List<Map<String, Object>> dsDatas = originMapper.queryTableDataByDBVersion("FASP_T_CAROLE", version);

                if (CollectionUtils.isEmpty(dsDatas)) {
                    break;
                }

                /**
                 * 切换到目标库 写入数据
                 */
                changeService.changeDb(target);
                dsDatas = getFilterRoleTable(dsDatas);
                if (version.equals(SyncDataUtils.DEFAULT_DBVERSION)) {
                    isdelete = saveBatchRoles(isdelete, dsDatas);
                } else {
                    for (Map<String, Object> role : dsDatas) {
                        saveOneRole(role);
                    }
                }
                syncCount = dsDatas.size();
                log.info("TABLENAME :[ FASP_T_CAROLE ] DBVERSION :[" + version + "] DATA SIZE: [ " + (syncCount + 1000 * (page - 2)) + " ]");
            }
            while (1000 == syncCount);
        } catch (Exception e) {
            log.error("TABLENAME :[ FASP_T_CAROLE ] 数据同步失败");
        }

    }

    private String getRoleVersion(String target) throws Exception {
        /**
         * 切换到目标库
         */
        changeService.changeDb(target);
        checkRoleTable();
        String version = syncRoleMapper.queryRoleVersion();
        version = StringUtils.isEmpty(version) ? SyncDataUtils.DEFAULT_DBVERSION : version;
        return version;
    }

    @Transactional(rollbackFor = Exception.class)
    Object saveOneRole(Map<String, Object> role) {
        toLowerMapKey(role);
        Object dbversion = role.get("dbversion");
        syncRoleMapper.deleteRoleData(role);
        syncRoleMapper.insertRoleData(role);
        return dbversion;
    }

    private Boolean saveBatchRoles(Boolean isdelete, List<Map<String, Object>> dsDatas) {
        /**
         * 首次同步清表批量写入
         */
        if (isdelete) {
            syncRoleMapper.deleteAllData("FASP_T_CAROLE");
            isdelete = false;
        }
        Map<String, Object> param = new HashMap<>(1);
        param.put("list", dsDatas);
        syncRoleMapper.batchInsertRoleTable(param);
        return isdelete;
    }

    private void checkRoleTable() {
        if (exitsRoleTable()) {
            return;
        }
        syncRoleMapper.createRoleTable();
    }

    private Boolean exitsRoleTable() {
        List<String> tableList = caffeineCache.asMap().get("tableList");
        if (!CollectionUtils.isEmpty(tableList) && tableList.contains("FASP_T_CAROLE")) {
            return true;
        }
        tableList = new ArrayList<>();
        tableList.add("FASP_T_CAROLE");
        Map<String, List<String>> map = new HashMap<>(1);
        map.put("tableList", tableList);
        TableContextHolder.setTableData(map);
        return false;
    }

    private List<Map<String, Object>> getFilterRoleTable(List<Map<String, Object>> dsDatas) {
        return dsDatas.stream().map(x -> {
            String dbversion = getStringValue(x.get("DBVERSION"));
            x.put("DBVERSION", dbversion);
            return x;
        }).collect(Collectors.toList());
    }

    /**
     * 转换 ORACLE TIMESTAMP
     */
    private String getStringValue(Object obj) {
        if (null == obj) {
            return "";
        } else if (obj instanceof byte[]) {
            return new BASE64Encoder().encode((byte[]) obj);
        } else if (obj instanceof oracle.sql.TIMESTAMP) {
            Timestamp timestamp = getOracleTimestamp(obj);
            String time = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(timestamp);
            return time;
        }
        return obj.toString();
    }

    private Timestamp getOracleTimestamp(Object value) {
        try {
            Class clz = value.getClass();
            Method method = clz.getMethod("timestampValue", null);
            return (Timestamp) method.invoke(value, null);
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        }
    }
}
