package com.micro.service.springquartz.sync;

import com.github.benmanes.caffeine.cache.Cache;
import com.github.pagehelper.PageHelper;
import com.micro.service.springquartz.mapper.origin.OriginMapper;
import com.micro.service.springquartz.mapper.target.SyncAgencyMapper;
import com.micro.service.springquartz.mapper.target.SyncRangeMapper;
import com.micro.service.springquartz.model.Dic3SyncDSPO;
import com.micro.service.springquartz.service.DBChangeService;
import com.micro.service.springquartz.utils.SyncDataUtils;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import oracle.sql.TIMESTAMP;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
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

/**
 * @ClassName SyncAgencyService
 * @Description TODO
 * @Author zxl
 * @Date 2020/9/27 17:36
 * @Version 1.0.0
 */

@Service
@Slf4j
@AllArgsConstructor
public class SyncAgencyService implements SyncScheduler {
    private static final String DEFAULT_DATE_TIME_FROMAT = "yyyyMMddHHmmss";
    SyncAgencyMapper syncAgencyMapper;
    Cache<String, List<String>> caffeineCache;
    DBChangeService changeService;
    OriginMapper originMapper;
    SyncRangeMapper syncRangeMapper;

    @Override
    public void start(String origin, String target) {
        String tableName = null;
        try {
            changeService.changeDb(target);
            String agencyCode = syncAgencyMapper.queryAgencyDsCodes();
            if (StringUtils.isEmpty(agencyCode)) {
                return;
            }
            String agencyTableName = "FASP_T_PUP" + agencyCode.toUpperCase();
            tableName = agencyTableName;
            checkAgencyTable(agencyTableName);
            String agencyVersion = syncAgencyMapper.queryAgencyVersion(agencyTableName);
            agencyVersion = StringUtils.isEmpty(agencyVersion) ? SyncDataUtils.DEFAULT_DBVERSION : agencyVersion;
            Dic3SyncDSPO dic3SyncDSPO = new Dic3SyncDSPO();
            dic3SyncDSPO.setElementcode("AGENCY");
            dic3SyncDSPO.setTablename(agencyTableName);
            dic3SyncDSPO.setSyncdatetime(agencyVersion);
            checkTableVeiws(dic3SyncDSPO);

            int page = 1;
            Integer syncCount = null;
            Boolean isdelete = true;

            do {
                /**
                 * 切换到源库
                 */
                changeService.changeDb(origin);
                PageHelper.startPage(page++, 1000);
                List<Map<String, Object>> dsDatas = originMapper.queryTableDataByDBVersion(agencyTableName, agencyVersion);
                if (CollectionUtils.isEmpty(dsDatas)) {
                    syncCount = 0;
                    return;
                }
                String dbversion = syncAgencyData(agencyTableName, dsDatas, target);
                syncCount = dsDatas.size();
                log.info("TABLENAME :[ " + agencyTableName + " ] DBVERSION :[" + dbversion + "] DATA SIZE: [ " + (syncCount + 1000 * (page - 2)) + " ]");
            } while (syncCount == 1000);
        } catch (Exception e) {
            log.error("TABLENAME :[ " + tableName + " ] 数据同步失败 [ " + e + " ]");
        }


    }

    private void checkAgencyTable(String tablename) {
        log.debug("check table [" + tablename + "] exits ");
        if (syncAgencyMapper.exitsAgencyTable(tablename) > 0) {
            return;
        }
        log.debug("create table " + tablename);
        syncAgencyMapper.createAgencyTable(tablename);
    }


    private void checkTableVeiws(Dic3SyncDSPO po) {
        String tablename = po.getTablename();
        tablename = tablename.toUpperCase().replace("P#", "");
        if (tablename.length() > 30) {
            tablename = tablename.substring(0, 30);
        }
        String view = tablename.toUpperCase().replace("P#", "").replace("_T_", "_V_");
        if (view.length() > 30) {
            view = view.substring(0, 30);
        }

        log.debug("create or replace view " + view + " from tablename " + tablename);
        if (syncRangeMapper.exitsView(view.trim().toLowerCase()) <= 0) {
            syncRangeMapper.createElementcodeView(tablename, view);
            syncRangeMapper.updateElementcodeView(po.getElementcode(), view);
        }
    }

    @Transactional
    public String syncAgencyData(String tablename, List<Map<String, Object>> datas, String target) throws Exception {
        changeService.changeDb(target);
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
        Map<String, Object> param = new HashMap(2);
        param.put("tablename", tablename);
        String dbversion = null;
        for (Map<String, Object> data : datas) {
            param.put("data", data);
            dbversion = getStringValue(data.get("DBVERSION"));
            syncAgencyMapper.deleteAgencyData(param);
            syncAgencyMapper.insertAgencyData(param);
        }
        return dbversion;
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
