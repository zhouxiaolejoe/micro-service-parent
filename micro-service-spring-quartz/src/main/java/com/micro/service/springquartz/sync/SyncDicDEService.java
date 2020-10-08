package com.micro.service.springquartz.sync;

import com.github.benmanes.caffeine.cache.Cache;
import com.github.pagehelper.PageHelper;
import com.micro.service.springquartz.mapper.origin.OriginMapper;
import com.micro.service.springquartz.mapper.target.SyncDicDEMapper;
import com.micro.service.springquartz.service.DBChangeService;
import com.micro.service.springquartz.utils.SyncDataUtils;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
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

/**
 * @ClassName SyncDicDEService
 * @Description TODO
 * @Author Administrator
 * @Date 2020/9/24 14:38
 * @Version 1.0.0
 */

@Service
@Slf4j
@AllArgsConstructor
public class SyncDicDEService implements SyncScheduler {

    SyncDicDEMapper syncDicDEMapper;
    Cache<String, List<String>> caffeineCache;
    DBChangeService changeService;
    OriginMapper originMapper;
    public static final String FASP_T_DICDE = "FASP_T_DICDE";

    @Override
    public void start(String origin, String target) {
//        List<String> tableList = caffeineCache.asMap().get("tableList_" + target);
//        log.warn("tableList_" + target + " : " + tableList);
//        List<String> viewList = caffeineCache.asMap().get("viewList_" + target);
//        log.warn("viewList_" + target + " : " + viewList);
        try {
            String version = getDicdeVersion(target);
            int page = 1;
            Integer syncCount;
            Boolean isdelete = true;

            do {
                /**
                 * 切换到源库
                 */
                changeService.changeDb(origin);
                PageHelper.startPage(page++, 1000);
                List<Map<String, Object>> dsDatas = originMapper.queryTableDataByDBVersion(FASP_T_DICDE, version);
                if (CollectionUtils.isEmpty(dsDatas)) {
                    return;
                }

                /**
                 * 切换到目标库 写入数据
                 */
                changeService.changeDb(target);
                //使用typeHandler替换
//                dsDatas = getFilterDicDe(dsDatas);
                if (version.equals(SyncDataUtils.DEFAULT_DBVERSION)) {
                    isdelete = saveBatchDicde(isdelete, dsDatas);
                } else {
                    saveOneDicde(dsDatas);
                }
                syncCount = dsDatas.size();
                log.info("TABLENAME :[ FASP_T_DICDE ] DBVERSION :[" + version + "  data size=" + (syncCount + 1000 * (page - 2)) + " ]");

            } while (syncCount == 1000);


        } catch (Exception e) {
            log.error("TABLENAME :[ FASP_T_DICDE ] 数据同步失败 [ " + e + " ]");
        }

    }

    /**
     * 检查FASP_T_DICDE是否存在 否则创建
     */
    private void checkDicde() {
        if (exitsDicde()) {
            return;
        }
        syncDicDEMapper.createDeTable();
    }

    /**
     * 判断FASP_T_DICDE是否存在
     */
    private Boolean exitsDicde() {
//        Map<String, List<String>> tableData = TableContextHolder.getTableData();
//        Map<String, List<String>> map = new HashMap<>(1);
//        List<String> tableList =null;
//        if(!CollectionUtils.isEmpty(tableData)){
//            tableList = tableData.get("tableList");
//            if (!CollectionUtils.isEmpty(tableList) && tableList.contains(FASP_T_DICDE)) {
//                return true;
//            }
//            tableList.add(FASP_T_DICDE);
//            map.put("tableList", tableList);
//            TableContextHolder.setTableData(map);
//            return false;
//        }
//        tableList = new ArrayList<>();
//        tableList.add(FASP_T_DICDE);
//        map.put("tableList", tableList);
//        TableContextHolder.setTableData(map);
//        return false;
        if (syncDicDEMapper.exitsDeTable() > 0) {
            return true;
        }
        return false;
    }


    private void saveOneDicde(List<Map<String, Object>> dsDatas) {
        for (Map<String, Object> data : dsDatas) {
            syncDicDEMapper.deleteDE(data.get("GUID").toString());
            syncDicDEMapper.insertDE(data);
        }
    }

    private Boolean saveBatchDicde(Boolean isdelete, List<Map<String, Object>> dsDatas) {
        /**
         * 首次同步清表批量写入
         */
        if (isdelete) {
            syncDicDEMapper.deleteAllData(FASP_T_DICDE);
            isdelete = false;
        }
        Map<String, Object> param = new HashMap<>(1);
        param.put("list", dsDatas);
        syncDicDEMapper.batchInsertDicDE(param);
        return isdelete;
    }

    private String getDicdeVersion(String target) throws Exception {
        /**
         * 切换到目标库
         */
        changeService.changeDb(target);
        checkDicde();
        String version = syncDicDEMapper.queryDEMaxVersion();
        version = StringUtils.isEmpty(version) ? SyncDataUtils.DEFAULT_DBVERSION : version;
        return version;
    }

    /**
     * 过滤FASP_T_DICDE分类(如项目库、基础库、预算库所注册的表)
     */
    private List<Map<String, Object>> getFilterDicDe(List<Map<String, Object>> dsDatas) {
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
            Method method = clz.getMethod("timestampValue", new Class[0]);
            return (Timestamp) method.invoke(value, new Class[0]);
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        }
    }
}
