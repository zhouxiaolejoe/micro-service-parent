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

    List<Map<String,Object>> selectTableColumn(@Param("tablename")String tablename);

}
