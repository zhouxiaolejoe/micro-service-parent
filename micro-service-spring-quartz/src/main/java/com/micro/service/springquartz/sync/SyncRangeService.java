package com.micro.service.springquartz.sync;


import com.github.benmanes.caffeine.cache.Cache;
import com.github.pagehelper.PageHelper;
import com.micro.service.springquartz.mapper.origin.OriginMapper;
import com.micro.service.springquartz.mapper.target.SyncDicDSMapper;
import com.micro.service.springquartz.mapper.target.SyncRangeMapper;
import com.micro.service.springquartz.model.Dic3SyncDSPO;
import com.micro.service.springquartz.service.DBChangeService;
import com.micro.service.springquartz.utils.SyncDataUtils;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import oracle.sql.TIMESTAMP;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;
import sun.misc.BASE64Encoder;

import java.lang.reflect.Method;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import static com.micro.service.springquartz.utils.SyncDataUtils.sortSyncDataByDBVersion;

/**
 * @Description
 * @Author zxl
 * @Date 2020-10-28  16:27:22
 **/
@Service
@Slf4j
@AllArgsConstructor
public class SyncRangeService implements SyncScheduler {
    private static final String DEFAULT_DATE_TIME_FROMAT = "yyyyMMddHHmmss";
    DBChangeService changeService;
    OriginMapper originMapper;
    SyncRangeMapper syncRangeMapper;
    SyncDicDSMapper syncDicDSMapper;
    Cache<String, List<String>> caffeineCache;
    private static int count = 0;

    @Override
    public void start(String origin, String target) {
//        log.info("TO START SYNC RANGE");
        try {
            changeService.changeDb(target);
            saveUserTableView(origin, null, target);
        } catch (Exception e) {
            e.printStackTrace();
        }
        List<Dic3SyncDSPO> syncDSPOS = syncRangeMapper.querySyncElements();
        for (Dic3SyncDSPO po : syncDSPOS) {
            try {
                String elementcode = po.getElementcode();
                if (!StringUtils.isEmpty(elementcode) && !("AGENCY").equals(elementcode.toUpperCase())) {
                    syncElement(po, origin, target);
                }
            } catch (Exception e) {
                log.error("同步基础数据出错," + po, e);
            }
        }
    }


    public String syncElementData(Dic3SyncDSPO po, List<Map<String, Object>> datas) {

        if (CollectionUtils.isEmpty(datas)) {
            return null;
        }
        datas = datas.stream().sorted((s1, s2) -> {
            TIMESTAMP dbversion1 = (TIMESTAMP) s1.get("DBVERSION");
            TIMESTAMP dbversion2 = (TIMESTAMP) s2.get("DBVERSION");
            Timestamp oracleTimestamp1 = getOracleTimestamp(dbversion1);
            Timestamp oracleTimestamp2 = getOracleTimestamp(dbversion2);
            return oracleTimestamp1.compareTo(oracleTimestamp2);
        }).collect(Collectors.toList());
        // 按DBVersion排序
        sortSyncDataByDBVersion(datas);
        String tablename = po.getTablename().toUpperCase();
        Map param = new HashMap();
        param.put("tablename", tablename);
        String dbversion = null;
        for (Map<String, Object> data : datas) {
            param.put("data", data);
            dbversion = getStringValue(data.get("DBVERSION"));
            syncRangeMapper.deleteData(param);
            syncRangeMapper.insertData(param);
        }
        return dbversion;

    }

    private Integer syncElement(Dic3SyncDSPO po, String origin, String target) throws Exception {
        changeService.changeDb(target);
        checkTable(po, origin, target);
        checkTableVeiws(po, origin, target);
        Integer syncCount = null;
        try {
            int page = 1;
            do {
                String version = po.getSyncdatetime();
                if (StringUtils.isEmpty(version)) {
                    version = SyncDataUtils.DEFAULT_DBVERSION;
                }
                if (SyncDataUtils.parentVersion(version) == null) {
                    version = SyncDataUtils.DEFAULT_DBVERSION;
                }
                /**
                 * 切换到源库
                 */
                changeService.changeDb(origin);
                PageHelper.startPage(page++, 1000);
//                List<Map<String, Object>> data =null;
                List<Map<String, Object>> data = originMapper.queryTableDataByDBVersion(po.getTablename(), version);
                if (CollectionUtils.isEmpty(data)) {
                    syncCount = 0;
                    break;
                }
                /**
                 * 切换目标库
                 */
                changeService.changeDb(target);
                String dbVersion = syncElementData(po, data);

                updateSyncElementDateTime(po, dbVersion);
                syncCount = data.size();
                log.info("TABLENAME :[ " + po.getTablename() + " ] DBVERSION :[" + po.getSyncdatetime() + "] DATA SIZE: [ " + (syncCount + 1000 * (page - 2)) + " ]");
            }
            while (1000 == syncCount);

        } catch (Throwable e) {
            log.error("同步基础数据失败。" + po, e);
        }
        return syncCount;
    }

    private static int i = 0;

    private void checkTable(Dic3SyncDSPO po, String origin, String target) {
        String tablename = po.getTablename().toLowerCase();
        if (tablename.length() > 30) {
            tablename = tablename.substring(0, 30);
        }
        if (!exitsTable(origin, tablename, target)) {
            if (!exitsView(po, origin, target)) {
                syncRangeMapper.createTable(tablename);
            }
        }
    }


    public void updateSyncElementDateTime(Dic3SyncDSPO po, String dbversion) {
        if (StringUtils.isEmpty(dbversion)) {
            return;
        }
        syncRangeMapper.updateSyncElementDateTime(po.getElementcode(), dbversion);
    }


    private void checkTableVeiws(Dic3SyncDSPO po, String origin, String target) {
        String tablename = po.getTablename();
        tablename = tablename.toUpperCase().replace("P#", "");
        if (tablename.length() > 30) {
            tablename = tablename.substring(0, 30);
        }
        List<String> views = syncRangeMapper.queryElementcodeView(po.getElementcode());
        String view = tablename.toUpperCase().replace("P#", "").replace("_T_", "_V_");
        if (!CollectionUtils.isEmpty(views)) {
            view = views.get(0).toUpperCase().replace("#", "").replace("_T_", "_V_");
        }
        if (view.length() > 30) {
            view = view.substring(0, 30);
        }
        log.debug("create or replace view " + view + " from tablename " + tablename);
        if (!exitsView(po, origin, target)) {
            syncRangeMapper.createElementcodeView(tablename, view);
            syncRangeMapper.updateElementcodeView(po.getElementcode(), view);
        }
    }

    private Boolean exitsTable(String origin, String tablename, String target) {
//        tablename = tablename.toUpperCase();
//        List<String> tableList = caffeineCache.asMap().get(origin + "_" + target + "_tableList");
//        if (!CollectionUtils.isEmpty(tableList) && tableList.contains(tablename)) {
//            return true;
//        }
//        tableList = new ArrayList<>();
//        tableList.add(tablename);
//        caffeineCache.asMap().put(origin + "_" + target + "_tableList", tableList);
//        return false;


        if (syncRangeMapper.exitsTable(tablename.toUpperCase()) > 0) {
            return true;
        }
        return false;
    }

    private Boolean exitsView(Dic3SyncDSPO po, String origin, String target) {
//        po.setTablename(po.getTablename().toUpperCase());
//        List<String> tableList = caffeineCache.asMap().get(origin + "_" + target + "_viewList");
//        if (!CollectionUtils.isEmpty(tableList) && tableList.contains(po.getTablename())) {
//            return true;
//        }
//        tableList = new ArrayList<>();
//        tableList.add(po.getTablename());
//        caffeineCache.asMap().put(origin + "_" + target + "_viewList", tableList);
//        return false;
        if (syncRangeMapper.exitsView(po.getTablename().toUpperCase()) > 0) {
            return true;
        }
        return false;
    }

    /**
     * 保存用户拥有的表 视图
     */
    private void saveUserTableView(String origin, String tablename, String target) throws Exception {
        int max = 1000;
        if (count >= max) {
            return;
        }
        changeService.changeDb(target);
        List<String> tableList = syncDicDSMapper.queryTableList();
        List<String> viewList = syncDicDSMapper.queryViewList();
        caffeineCache.asMap().put(origin + "_" + target + "_tableList", tableList);
        caffeineCache.asMap().put(origin + "_" + target + "_viewList", viewList);
        count++;
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
            String time = new SimpleDateFormat(DEFAULT_DATE_TIME_FROMAT).format(timestamp);
            return time;
        }
        return obj.toString();
    }

    private Timestamp getOracleTimestamp(Object value) {
        try {
            Class clz = value.getClass();
            Method method = clz.getMethod("timestampValue", new Class[0]);
            return (Timestamp) method.invoke(value, new Class[0]);
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        }
    }
}
