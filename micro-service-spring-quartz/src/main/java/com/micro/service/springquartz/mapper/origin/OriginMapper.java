package com.micro.service.springquartz.mapper.origin;

import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @ClassName OriginMapper
 * @Description TODO
 * @Author Administrator
 * @Date 2020/9/21 17:06
 * @Version 1.0.0
 */
public interface OriginMapper {
    List<Map<String, Object>> queryTableDataByDBVersion(@Param("tablename") String tablename,@Param("dbversion") String dbversion);
}
