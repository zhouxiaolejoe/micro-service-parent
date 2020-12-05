package com.micro.service.springredis.service;

import java.util.List;

import com.micro.service.springredis.model.DataBaseinfo;
import com.micro.service.tool.until.api.ResultPageBuilder;

/**
 * @Description
 * @Project micro-service-parent
 * @Package com.micro.service.springredis.service
 * @Author zhouxiaole
 * @Date 2020-09-13 12:05
 */
public interface DataBaseinfoService {


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

    int batchInsert(List<DataBaseinfo> list);

    DataBaseinfo testRedisHashStore(Integer id);

    DataBaseinfo testRedisJsonStore(Integer id);

    DataBaseinfo testRedisBeanStore(Integer id);

    ResultPageBuilder testPage(Integer page,Integer pageSize);
}
