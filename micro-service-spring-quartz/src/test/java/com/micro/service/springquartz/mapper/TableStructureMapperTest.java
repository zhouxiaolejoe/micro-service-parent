package com.micro.service.springquartz.mapper;

import com.micro.service.springquartz.model.ColumnInfo;
import com.micro.service.springquartz.model.IndexesInfo;
import com.micro.service.springquartz.utils.FastJsonUtils;
import com.micro.service.springquartz.utils.JsonLogUtils;
import lombok.extern.slf4j.Slf4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import static org.junit.Assert.*;

/**
 * @Description
 * @Project micro-service-parent
 * @Package com.micro.service.springquartz.mapper
 * @Author zxl
 * @Date 2020-11-14 10:39
 */

@SpringBootTest
@RunWith(SpringRunner.class)
public class TableStructureMapperTest {
    @Autowired
    TableStructureMapper tableStructureMapper;

    @Test
    public void addTableColumn() {
        ColumnInfo columnInfo = ColumnInfo
                .builder()
                .columnLength("(20)")
                .columnName("test")
                .columnType("VARCHAR2")
                .defaulValue("\'1\'")
                .empty("null")
                .tableName("FASP_T_CAROLE")
                .build();
        tableStructureMapper.addTableColumn(columnInfo);
    }

    @Test
    public void modifyTableColumn() {
        ColumnInfo columnInfo = ColumnInfo
                .builder()
                .columnLength("(10)")
                .columnName("test")
                .columnType("VARCHAR2")
                .defaulValue("\'1\'")
                .empty("not null")
                .tableName("FASP_T_CAROLE")
                .build();
        tableStructureMapper.modifyTableColumn(columnInfo);
    }

    @Test
    public void dropTableColumn() {
        ColumnInfo columnInfo = ColumnInfo
                .builder()
                .columnName("test")
                .tableName("FASP_T_CAROLE")
                .build();
        tableStructureMapper.dropTableColumn(columnInfo);
    }

    @Test
    public void renameTableColumn() {
        ColumnInfo columnInfo = ColumnInfo
                .builder()
                .columnName("test")
                .newColumnName("sss")
                .tableName("FASP_T_CAROLE")
                .build();
        tableStructureMapper.renameTableColumn(columnInfo);
    }

    @Test
    public void addIndexes() {
        List<String> indexs = Arrays.asList("GUID", "ADMDIV");
        IndexesInfo indexesInfo = IndexesInfo
                .builder()
                .index(indexs)
                .indexName("GUID_ADMDIV")
                .tableName("FASP_T_CAROLE")
                .build();
        tableStructureMapper.addIndexes(indexesInfo);
    }

    @Test
    public void deleteIndexes() {
        IndexesInfo indexesInfo = IndexesInfo
                .builder()
                .indexName("GUID_ADMDIV")
                .build();
        tableStructureMapper.deleteIndexes(indexesInfo);
    }

    @Test
    public void seleteIndexesColumn() {
        List<Map<String, Object>> guidAdmdiv = tableStructureMapper.seleteIndexesColumn("GUID_ADMDIV");
        JsonLogUtils.println(FastJsonUtils.getBeanToJson(guidAdmdiv));
    }

    @Test
    public void seleteTableIndexes() {
        List<Map<String, Object>> faspTCarole = tableStructureMapper.seleteTableIndexes("FASP_T_CAROLE");
        JsonLogUtils.println(FastJsonUtils.getBeanToJson(faspTCarole));
    }

    @Test
    public void renameIndexesName() {
        IndexesInfo indexesInfo = IndexesInfo
                .builder()
                .indexName("GUID_ADMDIV")
                .newIndexName("NEW_GUID_ADMDIV")
                .build();
        tableStructureMapper.renameIndexesName(indexesInfo);
    }

    @Test
    public void isExistIndexes() {
        Boolean existIndexes = tableStructureMapper.isExistIndexes("GUID_ADMDIV");
        System.err.println(existIndexes);

        Boolean existIndexes2 = tableStructureMapper.isExistIndexes("NEW_GUID_ADMDIV");
        System.err.println(existIndexes2);
    }
}