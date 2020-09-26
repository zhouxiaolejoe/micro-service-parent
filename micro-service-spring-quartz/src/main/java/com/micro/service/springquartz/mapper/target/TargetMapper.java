package com.micro.service.springquartz.mapper.target;

import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @Description
 * @Project micro-service-parent
 * @Package com.micro.service.springquartz.mapper.target
 * @Author zxl
 * @Date 2020-09-23 14:46
 */
public interface TargetMapper {

    Integer createTableDynamic(@Param("tablename") String tablename, @Param("sqlData") String sqlData);

    Integer deleteData(Map<String,Object> map);

    Integer insertDataD(@Param("tablename") String tablename, @Param("sql") String sql,
                        @Param("values") String values,@Param("data")Map<String,Object> map);

    String queryTableMaxVersion(@Param("tablename") String tablename);
}
