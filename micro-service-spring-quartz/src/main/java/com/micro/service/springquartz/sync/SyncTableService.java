package com.micro.service.springquartz.sync;

import com.github.benmanes.caffeine.cache.Cache;
import com.github.pagehelper.PageHelper;
import com.google.common.base.Joiner;
import com.google.common.collect.Maps;
import com.micro.service.springquartz.mapper.origin.OriginMapper;
import com.micro.service.springquartz.mapper.target.SyncDicDSMapper;
import com.micro.service.springquartz.mapper.target.TargetMapper;
import com.micro.service.springquartz.service.DBChangeService;
import com.micro.service.springquartz.utils.SyncDataUtils;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.jdbc.BadSqlGrammarException;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;

import java.util.*;
import java.util.stream.Collectors;

/**
 * @ClassName SyncTableService
 * @Description TODO
 * @Author Administrator
 * @Date 2020/9/23 14:41
 * @Version 1.0.0
 */
@Service
@Slf4j
@AllArgsConstructor
public class SyncTableService implements SyncTableScheduler {

    OriginMapper originMapper;
    TargetMapper targetMapper;
    DBChangeService changeService;
    SyncDicDSMapper syncDicDSMapper;
    Cache<String, List<String>> caffeineCache;
    private static int count = 0;

    @Override
    public void syncTable(String origin, String tablename, String target) {
        try {
            tablename = tablename.trim().toUpperCase();
            saveUserTableView(origin, tablename, target);

            /**
             * 切换到目标库
             */
            changeService.changeDb(target);
            checkTable(origin, tablename, target);
            String version = targetMapper.queryTableMaxVersion(tablename);
            version = StringUtils.isEmpty(version) ? SyncDataUtils.DEFAULT_DBVERSION : version;
            int page = 1;
            Integer syncCount;
            Boolean isdelete = true;
            do {
                /**
                 * 切换到源库
                 */
                changeService.changeDb(origin);
                PageHelper.startPage(page++, 1000);
                List<Map<String, Object>> dsDatas = originMapper.queryTableDataByDBVersion(tablename, version);
                if (CollectionUtils.isEmpty(dsDatas)) {
                    return;
                }
                if (version.equals(SyncDataUtils.DEFAULT_DBVERSION)) {
                    isdelete = saveBatchTableTable(tablename, dsDatas, target, isdelete);
                } else {
                    syncElementData(tablename, dsDatas, target);
                }
                syncCount = dsDatas.size();
                log.info("TABLENAME :[ " + tablename + " ] DBVERSION :[" + version + "  data size=" + (syncCount + 1000 * (page - 2)) + " ]");
            } while (syncCount == 1000);
        } catch (Exception e) {
            if (e instanceof BadSqlGrammarException) {
                if (!e.getCause().toString().contains("ORA-00942")) {
                    return;
                }
                try {
                    saveUserTableViewAlways(origin, tablename, target);
                    return;
                } catch (Exception exception) {
                    exception.printStackTrace();
                }
            }
            log.error("TABLENAME :[ " + tablename + " ] 数据同步失败 [ " + e + " ]");
        }
    }

    public void createTableDynamic(String tablename, List<Map<String, Object>> list, String target) throws Exception {
        StringBuffer sqlData = new StringBuffer();
        for (int i = 0; i < list.size(); i++) {
            String dbcolumncode = list.get(i).get("NAME").toString();
            String datatype = list.get(i).get("TYPE").toString();
            String datalength = list.get(i).get("LENGTH").toString();
            sqlData.append(dbcolumncode);
            sqlData.append(" ");
            sqlData.append(datatype);
            if (!datatype.toLowerCase().contains("timestamp")) {
                sqlData.append("(");
                sqlData.append(datalength);
                sqlData.append(")");
            }
            if (i < list.size() - 1) {
                sqlData.append(",");
            }
        }
        changeService.changeDb(target);
        targetMapper.createTableDynamic(tablename, sqlData.toString());
    }

    private void checkTable(String origin, String tablename, String target) throws Exception {
        if (exitsTable(origin, tablename, target)) {
            return;
        }
        changeService.changeDb(origin);
        List<Map<String, Object>> sqlData = originMapper.selectTableColumn(tablename);
        createTableDynamic(tablename, sqlData, target);
    }

    private Boolean exitsTable(String origin, String tablename, String target) {
        List<String> tableList = caffeineCache.asMap().get(origin + "_" + target + "_tableList_" + tablename + "_");
        if (!CollectionUtils.isEmpty(tableList) && tableList.contains(tablename)) {
            return true;
        }
        tableList = new ArrayList<>();
        tableList.add(tablename);
        caffeineCache.asMap().put(origin + "_" + target + "_tableList_" + tablename + "_", tableList);
        return false;
    }

    /**
     * 保存用户拥有的表 视图
     */
    private void saveUserTableView(String origin, String tablename, String target) throws Exception {
        List<String> result = caffeineCache.asMap().get(origin + "_" + target + "_tableList_" + tablename + "_");
        if (!CollectionUtils.isEmpty(result)) {
            return;
        }
        changeService.changeDb(target);
        List<String> tableList = syncDicDSMapper.queryTableList();
        List<String> viewList = syncDicDSMapper.queryViewList();
        caffeineCache.asMap().put(origin + "_" + target + "_tableList_" + tablename + "_", tableList);
        caffeineCache.asMap().put(origin + "_" + target + "_viewList_" + tablename + "_", viewList);
    }

    private void saveUserTableViewAlways(String origin, String tablename, String target) throws Exception {
        changeService.changeDb(target);
        List<String> tableList = syncDicDSMapper.queryTableList();
        List<String> viewList = syncDicDSMapper.queryViewList();
        caffeineCache.asMap().put(origin + "_" + target + "_tableList_" + tablename + "_", tableList);
        caffeineCache.asMap().put(origin + "_" + target + "_viewList_" + tablename + "_", viewList);
    }

    public void syncElementData(String tablename, List<Map<String, Object>> datas, String target) throws Exception {

        if (CollectionUtils.isEmpty(datas)) {
            return;
        }
        for (Map<String, Object> data : datas) {
            data.remove("ROW_ID");
            Map<String, Object> treeMap = new TreeMap<>(String::compareTo);
            treeMap.putAll(data);
            String sql = Joiner.on(",").join(treeMap.keySet());
            String values = creatValues(treeMap, sql);
            changeService.changeDb(target);
            targetMapper.deleteData(tablename, data);
            targetMapper.insertDataDynamic(tablename, sql, values, data);
        }
    }

    private Boolean saveBatchTableTable(String tablename, List<Map<String, Object>> datas, String target, Boolean isdelete) throws Exception {
        changeService.changeDb(target);
        if (isdelete) {
            targetMapper.deleteAllData(tablename);
            isdelete = false;
        }
        datas.stream().forEach(x -> {
            x.remove("ROW_ID");
        });
        Map<String, Object> treeMap = new TreeMap<>(String::compareTo);
        treeMap.putAll(datas.get(0));
        String sql = Joiner.on(",").join(treeMap.keySet());
        String values = batchCreatValues(treeMap, sql);
        Map<String, Object> param = Maps.newHashMap();
        param.put("tablename", tablename);
        param.put("sql", sql);
        param.put("values", values);
        param.put("datas", datas);
        targetMapper.batchInsertDataDynamic(param);
        return isdelete;
    }

    private String batchCreatValues(Map<String, Object> data, String sql) {
        String[] columns = sql.split(",");
        StringBuilder sb = new StringBuilder("");
        for (int i = 0; i < columns.length; i++) {
            String col = findKey(columns[i], data.keySet());
            boolean flag = "DBVERSION".equalsIgnoreCase(col) || "CREATETIME".equalsIgnoreCase(col) || "UPDATETIME".equalsIgnoreCase(col);
            if (flag) {
                sb.append("#{item." + col + ",jdbcType=TIMESTAMP,typeHandler=com.micro.service.springquartz.mybatis.typehandler.TimestampTypeHandler},");
                continue;
            }
            if ("LEVELNO".equalsIgnoreCase(col) || "ISLEAF".equalsIgnoreCase(col)) {
                sb.append("#{item." + col + "   ,jdbcType=INTEGER},");
            } else {
                sb.append("#{item." + col + "   ,jdbcType=VARCHAR},");
            }
        }
        String s = sb.toString();
        return s.substring(0, s.length() - 1);

    }

    private String creatValues(Map<String, Object> data, String sql) {
        String[] columns = sql.split(",");
        StringBuilder sb = new StringBuilder("");
        for (int i = 0; i < columns.length; i++) {
            String col = findKey(columns[i], data.keySet());
            if ("DBVERSION".equalsIgnoreCase(col)) {
                sb.append("#{data." + col + ",jdbcType=TIMESTAMP,typeHandler=com.micro.service.springquartz.mybatis.typehandler.TimestampTypeHandler},");
                continue;
            }
            if ("LEVELNO".equalsIgnoreCase(col) || "ISLEAF".equalsIgnoreCase(col)) {
                sb.append("#{data." + col + "   ,jdbcType=INTEGER},");
            } else {
                sb.append("#{data." + col + "   ,jdbcType=VARCHAR},");
            }
        }
        String s = sb.toString();
        return s.substring(0, s.length() - 1);

    }

    private String findKey(String column, Set<String> keys) {
        for (String key : keys) {
            if (column.equalsIgnoreCase(key)) {
                return key;
            }
        }
        return column;
    }
}
