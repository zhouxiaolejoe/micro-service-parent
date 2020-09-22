package com.micro.service.springquartz.sync;


import com.github.benmanes.caffeine.cache.Cache;
import com.github.pagehelper.PageHelper;
import com.micro.service.springquartz.config.DBContextHolder;
import com.micro.service.springquartz.config.TableContextHolder;
import com.micro.service.springquartz.mapper.origin.OriginMapper;
import com.micro.service.springquartz.mapper.target.SyncDicDSMapper;
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
 * Created by wengy on 2019/11/20.
 */
@Slf4j
@Service("aSyncDicDSService")
@AllArgsConstructor
public class SyncDicDSService implements IFaspClientScheduler {

    Cache<String, List<String>> caffeineCache;
    SyncDicDSMapper syncDicDSMapper;
    DBChangeService changeService;
    OriginMapper originMapper;
    private static int count = 0;

    @Override
    public void start(String origin, String target) {
        saveUserTableView(target);
        syncDicds(origin, target);
    }
    /**
     * 同步FASP_T_DICDS数据
     */
    private void syncDicds(String origin, String target) {
        try {

            /**
             * 切换到目标库
             */
            String version = getDicdsVersion(target);

            int page = 1;
            Integer syncCount;
            Boolean isdelete = true;
            do {
                /**
                 * 切换到源库
                 */
                changeService.changeDb(origin);
                PageHelper.startPage(page++, 1000);
                List<Map<String, Object>> dsDatas = originMapper.queryTableDataByDBVersion("FASP_T_DICDS", version);
                if (CollectionUtils.isEmpty(dsDatas)) {
                    return;
                }
                String businessType = DBContextHolder.getDataSource().getBusinesstype();
                dsDatas = getFilterDicds(dsDatas, businessType);

                /**
                 * 切换到目标库 写入数据
                 */
                changeService.changeDb(target);
                if (version.equals(SyncDataUtils.DEFAULT_DBVERSION)) {
                    isdelete = saveBatchDicds(isdelete, dsDatas);
                } else {
                    saveOneDicds(dsDatas);
                }
                syncCount = dsDatas.size();
                log.info("TABLENAME :[ FASP_T_DICDS ] DBVERSION :[" + version + "  data size=" + (syncCount + 1000 * (page - 2)) + " ]");
            } while (1000 == syncCount);
        } catch (Exception e) {
            log.error("TABLENAME :[ FASP_T_DICDS ] 数据同步失败 [ " + e + " ]");
        }
    }
    private void syncDicColumns() {
        checkDicColumn();

    }



    private String getDicdsVersion(String target) throws Exception {
        changeService.changeDb(target);
        checkDicds();
        String version = syncDicDSMapper.queryDSMaxVersion();
        version = StringUtils.isEmpty(version) ? SyncDataUtils.DEFAULT_DBVERSION : version;
        return version;
    }

    private void saveOneDicds(List<Map<String, Object>> dsDatas) {
        for (Map<String, Object> data : dsDatas) {
            syncDicDSMapper.deleteDS(data.get("GUID").toString());
            syncDicDSMapper.insertDS(data);
        }
    }

    private Boolean saveBatchDicds(Boolean isdelete, List<Map<String, Object>> dsDatas) {
        /**
         * 首次同步清表批量写入
         */
        if (isdelete) {
            syncDicDSMapper.deleteAllData("FASP_T_DICDS");
            Map<String, Object> param = new HashMap<>(1);
            param.put("list", dsDatas);
            syncDicDSMapper.batchInsertDicds(param);
            return false;
        }
        return true;
    }

    /**
     * 过滤FASP_T_DICDS分类(如项目库、基础库、预算库所注册的表)
     */
    private List<Map<String, Object>> getFilterDicds(List<Map<String, Object>> dsDatas, String businessType) {
        if (!StringUtils.isEmpty(businessType)) {
            dsDatas = dsDatas.stream().filter(
                    x -> {
                        if ("MOFDIV".equals(x.get("ELEMENTCODE"))) {
                            return false;
                        }
                        if (!StringUtils.isEmpty(x.get("TYPEGUID"))) {
                            return x.get("TYPEGUID").equals(businessType);
                        }
                        return false;
                    }
            ).map(y -> {
                        if ("ADMDIV".equals(y.get("ELEMENTCODE"))) {
                            y.put("ELEMENTCODE", "MOFDIV");
                        }
                        /**
                         * 转换 ORACLE TIMESTAMP
                         */
                        String dbversion = getStringValue(y.get("DBVERSION"));
                        y.put("DBVERSION",dbversion);
                        return y;
                    }
            ).collect(Collectors.toList());
        }
        return dsDatas;
    }
    /**
     * 检查FASP_T_DICDS是否存在 否则创建
     */
    private void checkDicds() {
        if (exitsDicds()) {
            return;
        }
        syncDicDSMapper.createDs();
    }
    /**
     * 检查FASP_T_MGDICCOLUMN是否存在 否则创建
     */
    public void checkDicColumn(){
        if (exitsDicColumn()) {
           return;
        }
        syncDicDSMapper.createDicColumn();
    }
    /**
     * 判断FASP_T_DICDS是否存在
     */
    private Boolean exitsDicds() {
        List<String> tableList = TableContextHolder.getTableData().get("tableList");
        return CollectionUtils.isEmpty(tableList) ? false : tableList.contains("FASP_T_DICDS");
    }
    /**
     * 判断FASP_T_MGDICCOLUMN是否存在
     */
    private Boolean exitsDicColumn() {
        List<String> tableList = TableContextHolder.getTableData().get("tableList");
        return CollectionUtils.isEmpty(tableList) ? false : tableList.contains("FASP_T_MGDICCOLUMN");
    }
    /**
     * 保存用户拥有的表 视图
     */
    private void saveUserTableView(String target) {
        int max = 10;
        if (count >= max) {
            return;
        }
        try {
            changeService.changeDb(target);
        } catch (Exception e) {
            e.printStackTrace();
        }
        TableContextHolder.clearTableData();
        List<String> tableList = syncDicDSMapper.queryTableList();
        List<String> viewList = syncDicDSMapper.queryViewList();
        Map<String, List<String>> map = new HashMap<>(2);
        map.put("tableList", tableList);
        map.put("viewList", viewList);
        TableContextHolder.setTableData(map);
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
