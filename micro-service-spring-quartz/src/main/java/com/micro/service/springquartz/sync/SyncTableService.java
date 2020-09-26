package com.micro.service.springquartz.sync;

import com.github.pagehelper.PageHelper;
import com.google.common.base.Joiner;
import com.micro.service.springquartz.config.TableContextHolder;
import com.micro.service.springquartz.mapper.origin.OriginMapper;
import com.micro.service.springquartz.mapper.target.SyncDicDSMapper;
import com.micro.service.springquartz.mapper.target.TargetMapper;
import com.micro.service.springquartz.service.DBChangeService;
import com.micro.service.springquartz.utils.SyncDataUtils;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;

import java.util.*;

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
    SqlSessionTemplate sqlSessionTemplate;
    private static int count = 0;

    @Override
    public void syncTable(String origin, String tablename, String target) {
        try {
            tablename = tablename.toUpperCase();
            saveUserTableView(target);

            /**
             * 切换到目标库
             */
            changeService.changeDb(target);
            checkTable(origin, tablename, target);
            String version = targetMapper.queryTableMaxVersion(tablename);
            version = StringUtils.isEmpty(version) ? SyncDataUtils.DEFAULT_DBVERSION : version;
            int page = 1;
            Integer syncCount;
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
                syncElementData(tablename, dsDatas, target);
                syncCount = dsDatas.size();
                log.info("TABLENAME :[ " + tablename + " ] DBVERSION :[" + version + "  data size=" + (syncCount + 1000 * (page - 2)) + " ]");
            } while (syncCount == 1000);
        } catch (Exception e) {
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
        if (exitsTable(tablename)) {
            return;
        }
        changeService.changeDb(origin);
        List<Map<String, Object>> sqlData = originMapper.selectTableColumn(tablename);
        createTableDynamic(tablename, sqlData, target);
    }

    private Boolean exitsTable(String tablename) {
        Map<String, List<String>> tableData = TableContextHolder.getTableData();
        Map<String, List<String>> map = new HashMap<>(1);
        List<String> tableList = null;
        if (!CollectionUtils.isEmpty(tableData)) {
            tableList = tableData.get("tableList");
            if (!CollectionUtils.isEmpty(tableList) && tableList.contains(tablename)) {
                return true;
            }
            tableList.add(tablename);
            map.put("tableList", tableList);
            TableContextHolder.setTableData(map);
            return false;
        }
        tableList = new ArrayList<>();
        tableList.add(tablename);
        map.put("tableList", tableList);
        TableContextHolder.setTableData(map);
        return false;
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
            targetMapper.insertDataD(tablename, sql, values,data);
        }
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
