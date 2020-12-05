package com.micro.service.springredis.mapper;

import com.micro.service.springredis.model.DataBaseinfo;
import java.util.List;
import org.apache.ibatis.annotations.Param;

/**
 * @Description
 * @Project micro-service-parent
 * @Package com.micro.service.springredis.mapper
 * @Author zhouxiaole
 * @Date 2020-09-13 12:05
 */
public interface DataBaseinfoMapper {
    int deleteByPrimaryKey(Integer guid);

    int insert(DataBaseinfo record);

    int insertOrUpdate(DataBaseinfo record);

    int insertOrUpdateSelective(DataBaseinfo record);

    int insertSelective(DataBaseinfo record);

    DataBaseinfo selectByPrimaryKey(Integer guid);

    int updateByPrimaryKeySelective(DataBaseinfo record);

    int updateByPrimaryKey(DataBaseinfo record);

    int updateBatch(List<DataBaseinfo> list);

    int updateBatchSelective(List<DataBaseinfo> list);

    int batchInsert(@Param("list") List<DataBaseinfo> list);

    List<DataBaseinfo> selectAll();


}