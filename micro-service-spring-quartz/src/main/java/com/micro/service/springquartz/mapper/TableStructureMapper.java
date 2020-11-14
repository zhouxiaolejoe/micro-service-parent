package com.micro.service.springquartz.mapper;

import com.micro.service.springquartz.model.ColumnInfo;
import com.micro.service.springquartz.model.IndexesInfo;
import io.swagger.models.auth.In;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @Description
 * @Project micro-service-parent
 * @Package com.micro.service.springquartz.mapper
 * @Author zxl
 * @Date 2020-11-14 10:11
 */
public interface TableStructureMapper {
    /**
    * @Description  表添加字段
    * @Method addTableColumn
    * @Param columnInfo
    * @return void
    * @throws
    * @Author zxl
    * @Date  2020-11-14  14:22:38
    **/
    void addTableColumn(ColumnInfo columnInfo);
    /**
    * @Description  表表修改字段
    * @Method modifyTableColumn
    * @Param columnInfo
    * @return void
    * @throws
    * @Author zxl
    * @Date  2020-11-14  14:23:03
    **/
    void modifyTableColumn(ColumnInfo columnInfo);
    /**
    * @Description  删除表字段
    * @Method dropTableColumn
    * @Param columnInfo
    * @return void
    * @throws
    * @Author zxl
    * @Date  2020-11-14  14:23:25
    **/
    void dropTableColumn(ColumnInfo columnInfo);
    /**
    * @Description  重命名字段
    * @Method renameTableColumn
    * @Param columnInfo
    * @return void
    * @throws
    * @Author zxl
    * @Date  2020-11-14  14:23:41
    **/
    void renameTableColumn(ColumnInfo columnInfo);
    /**
    * @Description  添加符合索引
    * @Method addIndexes
    * @Param indexesInfo
    * @return void
    * @throws
    * @Author zxl
    * @Date  2020-11-14  15:11:12
    **/
    void addIndexes(IndexesInfo indexesInfo);
    /**
    * @Description  删除索引
    * @Method deleteIndexes
    * @Param indexesInfo
    * @return void
    * @throws
    * @Author zxl
    * @Date  2020-11-14  15:33:35
    **/
    void deleteIndexes(IndexesInfo indexesInfo);
    /**
    * @Description  查询索引包含的字段
    * @Method seleteIndexesColumn
    * @Param indexesInfo
    * @return void
    * @throws
    * @Author zxl
    * @Date  2020-11-14  15:34:34
    **/
    List<Map<String,Object>> seleteIndexesColumn(@Param("indexName") String indexName);
    /**
    * @Description 判断索引是否存在
    * @Method isExistIndexes
    * @Param indexName
    * @return java.lang.Integer
    * @throws
    * @Author zxl
    * @Date  2020-11-14  16:54:16
    **/
    Boolean isExistIndexes(@Param("indexName") String indexName);
    /**
    * @Description  查询表里的索引
    * @Method seleteTableIndexes
    * @Param tableName
    * @return java.util.List<java.util.Map<java.lang.String,java.lang.Object>>
    * @throws
    * @Author zxl
    * @Date  2020-11-14  15:42:46
    **/
    List<Map<String,Object>> seleteTableIndexes(@Param("tableName") String tableName);
    /**
    * @Description  修改索引名称
    * @Method renameIndexesName
    * @Param indexesInfo
    * @return void
    * @throws
    * @Author zxl
    * @Date  2020-11-14  15:50:04
    **/
    void renameIndexesName(IndexesInfo indexesInfo);
    /**
    * @Description  创建物理表
    * @Method createTableDynamic
    * @Param tablename
    * @Param sqlData
    * @return java.lang.Integer
    * @throws
    * @Author zxl
    * @Date  2020-11-14  15:56:00
    **/
    Integer createTableDynamic(@Param("tablename") String tablename, @Param("sqlData") String sqlData);

}
