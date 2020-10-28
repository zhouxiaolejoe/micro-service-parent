package com.micro.service.springquartz.sync;


import com.github.benmanes.caffeine.cache.Cache;
import com.github.pagehelper.PageHelper;
import com.micro.service.springquartz.config.DBContextHolder;
import com.micro.service.springquartz.mapper.origin.OriginMapper;
import com.micro.service.springquartz.mapper.target.SyncDicDSMapper;
import com.micro.service.springquartz.mapper.target.SyncRangeMapper;
import com.micro.service.springquartz.model.Dic3SyncDSPO;
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
 * @Description
 * @Author zxl
 * @Date 2020-10-28  16:26:50
 **/
@Slf4j
@Service("aSyncDicDSService")
@AllArgsConstructor
public class SyncDicDSService implements SyncScheduler {

    Cache<String, List<String>> caffeineCache;
    SyncDicDSMapper syncDicDSMapper;
    DBChangeService changeService;
    OriginMapper originMapper;
    SyncRangeMapper syncRangeMapper;
    private static int count = 0;
    public static final String FASP_T_DICDS = "FASP_T_DICDS";
    public static final String FASP_T_DICCOLUMN = "FASP_T_DICCOLUMN";
    public static final String FASP_T_MGDICCOLUMN = "FASP_T_MGDICCOLUMN";
    public static final String FASP_T_DICTABLE = "FASP_T_DICTABLE";
    public static final String FASP_T_MGDICTABLE = "FASP_T_MGDICTABLE";
    public static final String FASP_T_DIC3SYNCDS = "FASP_T_DIC3SYNCDS";

    @Override
    public void start(String origin, String target) {
        saveUserTableView(target);
        syncDicTable(origin, target);
        syncDicColumns(origin, target);
        syncDicds(origin, target);
        syncDic3Syncds(origin, target);
    }

    private void syncDic3Syncds(String origin, String target) {
        checkDic3syncdsTable(origin, target);
        List<Dic3SyncDSPO> pos = syncRangeMapper.querySyncElementsFromDS();
        for (Dic3SyncDSPO po : pos) {
            po.setTablename("fasp_t_pup" + po.getTablename().toLowerCase().trim());
            syncRangeMapper.insertSyncElements(po);
        }
        syncRangeMapper.deleteSyncElements();
    }

    Boolean existDic3syncdsTable() {
        if (syncRangeMapper.exitsTable("FASP_T_DIC3SYNCDS") > 0) {
            return true;
        }
        return false;
//        List<String> tableList = caffeineCache.asMap().get("tableList");
//        return CollectionUtils.isEmpty(tableList)?false:tableList.contains("FASP_T_DIC3SYNCDS");
    }

    private boolean checkDic3syncdsTable(String origin, String target) {
        try {
            if (!existDic3syncdsTable()) {
                changeService.changeDb(target);
                syncRangeMapper.createDic3syncdsTable();
            }
        } catch (Exception e) {
            log.error("", e);
            return false;
        }
        return true;
    }

    /**
     * 同步FASP_T_DICDS数据
     */
    private void syncDicds(String origin, String target) {
        try {

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
                List<Map<String, Object>> dsDatas = originMapper.queryTableDataByDBVersion(FASP_T_DICDS, version);

                if (CollectionUtils.isEmpty(dsDatas)) {
                    return;
                }
                String businessType = DBContextHolder.getDataSource().getBusinesstype();
//                dsDatas = getFilterDicds(dsDatas, businessType);

                /**
                 * 切换到目标库 写入数据
                 */
                changeService.changeDb(target);
                if (version.equals(SyncDataUtils.DEFAULT_DBVERSION)) {
                    isdelete = saveBatchDicds(isdelete, dsDatas);
                } else {
                    saveOneDicds(dsDatas);
                }
//                checkDic3syncdsTable();
//                syncFaspDic3();
//                for (Map<String, Object> dsData : dsDatas) {
//                    String elementcode = dsData.get("ELEMENTCODE").toString().toUpperCase();
//                    if (!StringUtils.isEmpty(elementcode) && !("AGENCY").equals(elementcode)) {
//                        Dic3SyncDSPO po = new Dic3SyncDSPO();
//                        po.setElementcode(elementcode);
//                        po.setTablecode(dsData.get("TABLECODE").toString());
//                        po.setTablename("FASP_T_PUP" + dsData.get("CODE").toString());
//                        po.setVersion(dsData.get("VERSION").toString());
//                        checkTable(po);
//                        checkTableVeiws(po);
//                        syncElement(po);
//                    }
//                }
                syncCount = dsDatas.size();
                log.info("TABLENAME :[ FASP_T_DICDS ] DBVERSION :[" + version + "  data size=" + (syncCount + 1000 * (page - 2)) + " ]");
            } while (1000 == syncCount);
        } catch (Exception e) {
            log.error("TABLENAME :[ FASP_T_DICDS ] 数据同步失败 [ " + e + " ]");
        }
    }

    private void syncElement(Dic3SyncDSPO po) {


    }

    private void checkTable(Dic3SyncDSPO po) {
        String tablename = po.getTablename().trim().toUpperCase();
        if (tablename.length() > 30) {
            tablename = tablename.substring(0, 30);
        }
        if (!exitsTable(tablename)) {
            if (!exitsView(tablename)) {
                List<Map<String, Object>> maps = syncDicDSMapper.selectDicColumnData(po.getTablecode());
                createTableDynamic(tablename, maps);
            }
        }
    }

    public void createTableDynamic(String tablename, List<Map<String, Object>> list) {
        StringBuffer sql = new StringBuffer();
        for (int i = 0; i < list.size(); i++) {
            String dbcolumncode = list.get(i).get("DBCOLUMNCODE").toString();
            String datatype = list.get(i).get("DATATYPE").toString();
            String datalength = list.get(i).get("DATALENGTH").toString();
            sql.append(dbcolumncode);
            sql.append(" ");
            sql.append(datatype);
            if (!datatype.toLowerCase().contains("timestamp")) {
                sql.append("(");
                sql.append(datalength);
                sql.append(")");
            }
            if (i < list.size() - 1) {
                sql.append(",");
            }
        }
        syncDicDSMapper.createTableDynamic(tablename, sql.toString());
    }

    private void checkTableVeiws(Dic3SyncDSPO po) {
        String tablename = po.getTablename().trim().toUpperCase();
        tablename = tablename.replace("P#", "");
        if (tablename.length() > 30) {
            tablename = tablename.substring(0, 30);
        }
        String view = tablename.replace("P#", "").replace("_T_", "_V_");
        if (view.length() > 30) {
            view = view.substring(0, 30);
        }
        if (!exitsView(view)) {
            syncDicDSMapper.createElementcodeView(tablename, view);
            syncDicDSMapper.updateElementcodeView(po.getElementcode(), view);
        }
    }

    public void syncFaspDic3() {
        List<Dic3SyncDSPO> pos = syncDicDSMapper.querySyncElementsFromDS();
        for (Dic3SyncDSPO po : pos) {
            syncDicDSMapper.insertSyncElements(po);
        }
        syncDicDSMapper.deleteSyncElements();
    }

    /**
     * 同步FASP_T_DICCOLUMN数据
     */
    private void syncDicColumns(String origin, String target) {

        try {
            String version = getDicColumnsVersion(target);
            int page = 1;
            Integer syncCount;
            Boolean isdelete = true;
            do {

                changeService.changeDb(origin);
                PageHelper.startPage(page++, 1000);
                List<Map<String, Object>> dsDatas = originMapper.queryTableDataByDBVersion(FASP_T_MGDICCOLUMN, version);
                if (CollectionUtils.isEmpty(dsDatas)) {
                    return;
                }

                /**
                 * 切换到目标库 写入数据
                 */
                changeService.changeDb(target);
                //使用typeHandler替换
//                dsDatas = getFilterDicColumnsAndDicTable(dsDatas);
                if (version.equals(SyncDataUtils.DEFAULT_DBVERSION)) {
                    isdelete = saveBatchDicColumns(isdelete, dsDatas);
                } else {
                    saveOneDicColumns(dsDatas);
                }
                syncCount = dsDatas.size();
                log.info("TABLENAME :[ FASP_T_MGDICCOLUMN ] DBVERSION :[" + version + "  data size=" + (syncCount + 1000 * (page - 2)) + " ]");
            } while (syncCount == 1000);
        } catch (Exception e) {
            log.error("TABLENAME :[ FASP_T_DICCOLUMN ] 数据同步失败 [ " + e + " ]");
        }

    }

    /**
     * 同步FASP_T_DICTABLE
     */
    private void syncDicTable(String origin, String target) {
        try {
            String version = getDicTableVersion(target);
            int page = 1;
            Integer syncCount;
            Boolean isdelete = true;
            do {
                changeService.changeDb(origin);
                PageHelper.startPage(page++, 1000);
                List<Map<String, Object>> dsDatas = originMapper.queryTableDataByDBVersion(FASP_T_MGDICTABLE, version);
                if (CollectionUtils.isEmpty(dsDatas)) {
                    return;
                }

                /**
                 * 切换到目标库 写入数据
                 */
                changeService.changeDb(target);
                //使用typeHandler替换
//                dsDatas = getFilterDicColumnsAndDicTable(dsDatas);
                if (version.equals(SyncDataUtils.DEFAULT_DBVERSION)) {
                    isdelete = saveBatchDicTable(isdelete, dsDatas);
                } else {
                    saveOneDicTable(dsDatas);
                }
                syncCount = dsDatas.size();
                log.info("TABLENAME :[ FASP_T_DICTABLE ] DBVERSION :[" + version + "  data size=" + (syncCount + 1000 * (page - 2)) + " ]");
            } while (syncCount == 1000);


        } catch (Exception e) {
            log.error("TABLENAME :[ FASP_T_DICTABLE ] 数据同步失败 [ " + e + " ]");
        }
    }

    /**
     * 单条保存FASP_T_DICDS
     */
    private void saveOneDicds(List<Map<String, Object>> dsDatas) {
        for (Map<String, Object> data : dsDatas) {
            syncDicDSMapper.deleteDS(data.get("GUID").toString());
            syncDicDSMapper.insertDS(data);
        }
    }

    /**
     * 单条保存FASP_T_DICTABLE
     */
    private void saveOneDicTable(List<Map<String, Object>> dsDatas) {
        for (Map<String, Object> data : dsDatas) {
            syncDicDSMapper.deleteTable(data.get("TABLECODE").toString());
            syncDicDSMapper.insertTable(data);
        }
    }

    /**
     * 单条保存FASP_T_DICCOLUMN
     */
    private void saveOneDicColumns(List<Map<String, Object>> dsDatas) {
        for (Map<String, Object> data : dsDatas) {
            syncDicDSMapper.deleteColumn(data.get("TABLECODE").toString(), data.get("COLUMNCODE").toString());
            syncDicDSMapper.insertColumn(data);
        }
    }

    /**
     * 批量保存FASP_T_DICDS
     */
    private Boolean saveBatchDicds(Boolean isdelete, List<Map<String, Object>> dsDatas) {
        /**
         * 首次同步清表批量写入
         */
        if (isdelete) {
            syncDicDSMapper.deleteAllData("FASP_T_DICDS");
            isdelete = false;
        }
        Map<String, Object> param = new HashMap<>(1);
        param.put("list", dsDatas);
        syncDicDSMapper.batchInsertDicds(param);
        return isdelete;
    }

    private Boolean saveBatchDicTable(Boolean isdelete, List<Map<String, Object>> dsDatas) {
        /**
         * 首次同步清表批量写入
         */
        if (isdelete) {
            syncDicDSMapper.deleteAllData("FASP_T_MGDICTABLE");
            isdelete = false;
        }
        Map<String, Object> param = new HashMap<>(1);
        param.put("list", dsDatas);
        syncDicDSMapper.batchInsertDicTable(param);
        return isdelete;
    }

    /**
     * 批量保存FASP_T_DICCOLUMN
     */
    private Boolean saveBatchDicColumns(Boolean isdelete, List<Map<String, Object>> dsDatas) {
        /**
         * 首次同步清表批量写入
         */
        if (isdelete) {
            syncDicDSMapper.deleteAllData("FASP_T_MGDICCOLUMN");
            isdelete = false;
        }
        Map<String, Object> param = new HashMap<>(1);
        param.put("list", dsDatas);
        syncDicDSMapper.batchInsertDicColumn(param);
        return isdelete;
    }

    /**
     * 获取FASP_T_DICDS version
     */
    private String getDicdsVersion(String target) throws Exception {
        /**
         * 切换到目标库
         */
        changeService.changeDb(target);
        checkDicds();
        String version = syncDicDSMapper.queryDSMaxVersion();
        version = StringUtils.isEmpty(version) ? SyncDataUtils.DEFAULT_DBVERSION : version;
        return version;
    }

    /**
     * 获取FASP_T_DICTable version
     */
    private String getDicTableVersion(String target) throws Exception {
        changeService.changeDb(target);
        checkDicTable();
        String version = syncDicDSMapper.queryTableMaxVersion();
        version = StringUtils.isEmpty(version) ? SyncDataUtils.DEFAULT_DBVERSION : version;
        return version;
    }

    /**
     * 获取FASP_T_DICCOLUMN version
     */
    private String getDicColumnsVersion(String target) throws Exception {
        changeService.changeDb(target);
        checkDicColumn();
        String version = syncDicDSMapper.queryColumnMaxVersion();
        version = StringUtils.isEmpty(version) ? SyncDataUtils.DEFAULT_DBVERSION : version;
        return version;
    }


    /**
     * 检查FASP_T_DICDS是否存在 否则创建
     */
    private void checkDicds() {
        if (exitsTable(FASP_T_DICDS)) {
            return;
        }
        syncDicDSMapper.createDs();
    }

    /**
     * 检查FASP_T_DICTABLE是否存在 否则创建
     */
    private void checkDicTable() {
        if (exitsTable(FASP_T_MGDICTABLE)) {
            return;
        }
        syncDicDSMapper.createDicTable();
    }

    /**
     * 检查FASP_T_MGDICCOLUMN是否存在 否则创建
     */
    private void checkDicColumn() {
        if (exitsTable(FASP_T_MGDICCOLUMN)) {
            return;
        }
        syncDicDSMapper.createDicColumn();
    }

    /**
     * 判断表是否存在
     */
    private Boolean exitsTable(String tablename) {
//        Map<String, List<String>> tableData = TableContextHolder.getTableData();
//        Map<String, List<String>> map = new HashMap<>(1);
//        List<String> tableList = null;
//        if (!CollectionUtils.isEmpty(tableData)) {
//            tableList = tableData.get("tableList");
//            if (!CollectionUtils.isEmpty(tableList) && tableList.contains(tablename)) {
//                return true;
//            }
//            tableList.add(tablename);
//            map.put("tableList", tableList);
//            TableContextHolder.setTableData(map);
//            return false;
//        }
//        tableList = new ArrayList<>();
//        tableList.add(tablename);
//        map.put("tableList", tableList);
//        TableContextHolder.setTableData(map);
//        return false;
        if (syncRangeMapper.exitsTable(tablename) > 0) {
            return true;
        }
        return false;
    }

    Boolean exitsView(String viewName) {
//        Map<String, List<String>> viewData = TableContextHolder.getTableData();
//        Map<String, List<String>> map = new HashMap<>(1);
//        List<String> viewList = null;
//        if (!CollectionUtils.isEmpty(viewList)) {
//            viewList = viewData.get("viewList");
//            if (!CollectionUtils.isEmpty(viewList) && viewList.contains(viewName)) {
//                return true;
//            }
//            viewList.add(viewName);
//            map.put("viewList", viewList);
//            TableContextHolder.setTableData(map);
//            return false;
//        }
//        viewList = new ArrayList<>();
//        viewList.add(viewName);
//        map.put("viewList", viewList);
//        TableContextHolder.setTableData(map);
//        return false;
        if (syncRangeMapper.exitsView(viewName) > 0) {
            return true;
        }
        return false;
    }


//    /**
//     * 判断FASP_T_DICTABLE是否存在
//     */
//    private Boolean exitsDicTable() {
//        List<String> tableList = caffeineCache.asMap().get("tableList");
//        if (!CollectionUtils.isEmpty(tableList) && tableList.contains("FASP_T_MGDICTABLE")) {
//            return true;
//        }
//        tableList = new ArrayList<>();
//        tableList.add("FASP_T_MGDICTABLE");
//        caffeineCache.asMap().put("tableList", tableList);
//        return false;
//    }
//
//    /**
//     * 判断FASP_T_MGDICCOLUMN是否存在
//     */
//    private Boolean exitsDicColumn() {
//        List<String> tableList = caffeineCache.asMap().get("tableList");
//        if (!CollectionUtils.isEmpty(tableList) && tableList.contains("FASP_T_MGDICCOLUMN")) {
//            return true;
//        }
//        tableList = new ArrayList<>();
//        tableList.add("FASP_T_MGDICCOLUMN");
//        caffeineCache.asMap().put("tableList", tableList);
//        return false;
//    }

    /**
     * 过滤FASP_T_DICCOLUMN分类(如项目库、基础库、预算库所注册的表)
     */
    private List<Map<String, Object>> getFilterDicColumnsAndDicTable(List<Map<String, Object>> dsDatas) {
        return dsDatas.stream().map(x -> {
            String dbversion = getStringValue(x.get("DBVERSION"));
            x.put("DBVERSION", dbversion);
            return x;
        }).collect(Collectors.toList());
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
//                        if (!StringUtils.isEmpty(x.get("TYPEGUID"))) {
//                            return x.get("TYPEGUID").equals(businessType);
//                        }
                        return true;
                    }
            ).map(y -> {
                        if ("ADMDIV".equals(y.get("ELEMENTCODE"))) {
                            y.put("ELEMENTCODE", "MOFDIV");
                        }
                        /**
                         * 转换 ORACLE TIMESTAMP
                         */
                        //使用typeHandler替换
//                        String dbversion = getStringValue(y.get("DBVERSION"));
//                        y.put("DBVERSION", dbversion);
                        return y;
                    }
            ).collect(Collectors.toList());
        }
        return dsDatas;
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
        List<String> tableList = syncDicDSMapper.queryTableList();
        List<String> viewList = syncDicDSMapper.queryViewList();
        caffeineCache.asMap().put("tableList_" + target, tableList);
        caffeineCache.asMap().put("viewList_" + target, viewList);
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
            Method method = clz.getMethod("timestampValue", new Class[0]);
            return (Timestamp) method.invoke(value, new Class[0]);
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        }
    }
}
