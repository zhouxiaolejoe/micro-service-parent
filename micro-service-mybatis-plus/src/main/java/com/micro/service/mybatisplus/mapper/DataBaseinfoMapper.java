package com.micro.service.mybatisplus.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.micro.service.mybatisplus.model.DataBaseinfo;
import java.util.List;
import org.apache.ibatis.annotations.Param;

/**
 * @Description
 * @Project micro-service-parent
 * @Package com.micro.service.mybatisplus.mapper
 * @Author zhouxiaole
 * @Date 2020-09-13 20:46
 */
public interface DataBaseinfoMapper extends BaseMapper<DataBaseinfo> {
    int updateBatch(List<DataBaseinfo> list);

    int batchInsert(@Param("list") List<DataBaseinfo> list);

    int insertOrUpdate(DataBaseinfo record);

    int insertOrUpdateSelective(DataBaseinfo record);
}