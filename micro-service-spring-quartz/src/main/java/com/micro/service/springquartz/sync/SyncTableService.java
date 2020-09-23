package com.micro.service.springquartz.sync;

import com.micro.service.springquartz.config.TableContextHolder;
import com.micro.service.springquartz.mapper.origin.OriginMapper;
import com.micro.service.springquartz.mapper.target.TargetMapper;
import com.micro.service.springquartz.service.DBChangeService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

    @Override
    public void syncTable(String origin, String tablename, String target) {
        checkTable(tablename);



    }


    public void createTableDynamic(String tablename, List<Map<String, Object>> list) {
        StringBuffer sqlData = new StringBuffer();
        for (int i = 0; i < list.size(); i++) {
            String dbcolumncode = list.get(i).get("DBCOLUMNCODE").toString();
            String datatype = list.get(i).get("DATATYPE").toString();
            String datalength = list.get(i).get("DATALENGTH").toString();
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
        targetMapper.createTableDynamic(tablename, sqlData.toString());
    }

    private void checkTable(String tablename) {
        if (exitsTable(tablename)) {
            return;
        }
        List<Map<String, Object>> sqlData = targetMapper.selectTableColumn(tablename);
        createTableDynamic(tablename, sqlData);
    }

    private Boolean exitsTable(String tablename) {
        List<String> tableList = TableContextHolder.getTableData().get("tableList");
        return CollectionUtils.isEmpty(tableList) ? false : tableList.contains(tablename.toUpperCase());
    }
}
