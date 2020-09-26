package com.micro.service.springquartz.sync;

import com.github.benmanes.caffeine.cache.Cache;
import com.github.pagehelper.PageHelper;
import com.micro.service.springquartz.config.TableContextHolder;
import com.micro.service.springquartz.mapper.origin.OriginMapper;
import com.micro.service.springquartz.mapper.target.SyncMenuMapper;
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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

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
public class SyncMenuService implements IFaspClientScheduler {

    SyncMenuMapper syncMenuMapper;
    Cache<String, List<String>> caffeineCache;
    DBChangeService changeService;
    OriginMapper originMapper;
    public static final String FASP_T_PUBMENU = "FASP_T_PUBMENU";

    @Override
    public void start(String origin, String target) {
        try {
            String version = getMenuVersion(target);
            int page = 1;
            Integer syncCount;
            Boolean isdelete = true;
            do {

                /**
                 * 切换到源库
                 */
                changeService.changeDb(origin);
                PageHelper.startPage(page++, 1000);
                List<Map<String, Object>> dsDatas = originMapper.queryTableDataByDBVersion(FASP_T_PUBMENU, version);
                if (CollectionUtils.isEmpty(dsDatas)) {
                    return;
                }

                /**
                 * 切换到目标库 写入数据
                 */
                changeService.changeDb(target);
                //使用typeHandler替换
//                dsDatas = getFilterMenu(dsDatas);
                if (version.equals(SyncDataUtils.DEFAULT_DBVERSION)) {
                    /**
                     * 首次同步清表批量写入
                     */
                    if (isdelete) {
                        syncMenuMapper.deleteAllData(FASP_T_PUBMENU);
                        isdelete = false;
                    }
                    Map<String, Object> param = new HashMap<>(1);
                    param.put("list", dsDatas);
                    syncMenuMapper.batchInsertMenu(param);
                } else {
                    for (Map<String, Object> menu : dsDatas) {
                        syncMenuMapper.deleteMenuData(menu);
                        syncMenuMapper.insertMenuData(menu);
                    }
                }
                syncCount = dsDatas.size();
                log.info("TABLENAME :[ FASP_T_PUBMENU ] DBVERSION :[" + version + "  data size=" + (syncCount + 1000 * (page - 2)) + " ]");
            } while (syncCount == 1000);
        } catch (Exception e) {
            log.error("TABLENAME :[ FASP_T_PUBMENU ] 数据同步失败 [ " + e + " ]");
        }
    }

    private String getMenuVersion(String target) throws Exception {
        /**
         * 切换到目标库
         */
        changeService.changeDb(target);
        checkMenu();
        String version = syncMenuMapper.queryMenuVersion();
        version = StringUtils.isEmpty(version) ? SyncDataUtils.DEFAULT_DBVERSION : version;
        return version;
    }

    /**
     * 检查FASP_T_PUBMENU是否存在 否则创建
     */
    private void checkMenu() {
        if (exitsMenu()) {
            return;
        }
        syncMenuMapper.createMenuTable();
    }

    /**
     * 判断FASP_T_PUBMENU是否存在
     */
    private Boolean exitsMenu() {
        Map<String, List<String>> tableData = TableContextHolder.getTableData();
        Map<String, List<String>> map = new HashMap<>(1);
        List<String> tableList =null;
        if(!CollectionUtils.isEmpty(tableData)){
            tableList = tableData.get("tableList");
            if (!CollectionUtils.isEmpty(tableList) && tableList.contains(FASP_T_PUBMENU)) {
                return true;
            }
            tableList.add(FASP_T_PUBMENU);
            map.put("tableList", tableList);
            TableContextHolder.setTableData(map);
            return false;
        }
        tableList = new ArrayList<>();
        tableList.add(FASP_T_PUBMENU);
        map.put("tableList", tableList);
        TableContextHolder.setTableData(map);
        return false;
    }

    /**
     * 转换日期
     */
    private List<Map<String, Object>> getFilterMenu(List<Map<String, Object>> dsDatas) {
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
