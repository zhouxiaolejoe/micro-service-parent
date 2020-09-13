package com.micro.service.mybatisplus.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.micro.service.mybatisplus.model.User100w;
import java.util.List;
import org.apache.ibatis.annotations.Param;

/**
 * @Description
 * @Project micro-service-parent
 * @Package com.micro.service.mybatisplus.mapper
 * @Author zhouxiaole
 * @Date 2020-09-13 21:16
 */
public interface User100wMapper extends BaseMapper<User100w> {
    int updateBatch(List<User100w> list);

    int batchInsert(@Param("list") List<User100w> list);

    int insertOrUpdate(User100w record);

    int insertOrUpdateSelective(User100w record);
}