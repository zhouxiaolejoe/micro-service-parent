package com.micro.service.springredis.service.impl;

import com.micro.service.tool.untils.FastJsonUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

import com.micro.service.springredis.mapper.DataBaseinfoMapper;
import com.micro.service.springredis.model.DataBaseinfo;
import com.micro.service.springredis.service.DataBaseinfoService;

/**
 * @Description
 * @Project micro-service-parent
 * @Package com.micro.service.springredis.service.impl
 * @Author zhouxiaole
 * @Date 2020-09-13 12:05
 */
@Service
public class DataBaseinfoServiceImpl implements DataBaseinfoService {
    @Autowired
    RedisTemplate redisTemplate;

    @Resource
    private DataBaseinfoMapper dataBaseinfoMapper;

    @Override
    public int deleteByPrimaryKey(Integer guid) {
        return dataBaseinfoMapper.deleteByPrimaryKey(guid);
    }

    @Override
    public int insert(DataBaseinfo record) {
        return dataBaseinfoMapper.insert(record);
    }

    @Override
    public int insertOrUpdate(DataBaseinfo record) {
        return dataBaseinfoMapper.insertOrUpdate(record);
    }

    @Override
    public int insertOrUpdateSelective(DataBaseinfo record) {
        return dataBaseinfoMapper.insertOrUpdateSelective(record);
    }

    @Override
    public int insertSelective(DataBaseinfo record) {
        return dataBaseinfoMapper.insertSelective(record);
    }

    @Override
    public DataBaseinfo selectByPrimaryKey(Integer guid) {
        return dataBaseinfoMapper.selectByPrimaryKey(guid);
    }

    @Override
    public int updateByPrimaryKeySelective(DataBaseinfo record) {
        return dataBaseinfoMapper.updateByPrimaryKeySelective(record);
    }

    @Override
    public int updateByPrimaryKey(DataBaseinfo record) {
        return dataBaseinfoMapper.updateByPrimaryKey(record);
    }

    @Override
    public int updateBatch(List<DataBaseinfo> list) {
        return dataBaseinfoMapper.updateBatch(list);
    }

    @Override
    public int updateBatchSelective(List<DataBaseinfo> list) {
        return dataBaseinfoMapper.updateBatchSelective(list);
    }

    @Override
    public DataBaseinfo testRedisHashStore(Integer id) {
        if (!redisTemplate.hasKey("dataBaseinfo_Hash")) {
            DataBaseinfo dataBaseinfo = dataBaseinfoMapper.selectByPrimaryKey(id);
            Map<Object, Object> beanToMap = FastJsonUtils.getBeanToMap(dataBaseinfo);
            redisTemplate.opsForHash().putAll("dataBaseinfo_Hash", beanToMap);
            return dataBaseinfo;
        }
        Map<String, String> dataBaseinfoHash = redisTemplate.opsForHash().entries("dataBaseinfo_Hash");
        return FastJsonUtils.getMapToBean(dataBaseinfoHash, DataBaseinfo.class);
    }

    @Override
    public DataBaseinfo testRedisJsonStore(Integer id) {
        DataBaseinfo dataBaseinfo;
        if (!redisTemplate.hasKey("dataBaseinfo_Bean")) {
            dataBaseinfo = dataBaseinfoMapper.selectByPrimaryKey(id);
            redisTemplate.opsForValue().set("dataBaseinfo_Bean", dataBaseinfo);
        }
        Object result = redisTemplate.opsForValue().get("dataBaseinfo_Bean");
        dataBaseinfo = FastJsonUtils.getJsonToBean(FastJsonUtils.getBeanToJson(result), DataBaseinfo.class);
        return dataBaseinfo;
    }

    @Override
    public DataBaseinfo testRedisBeanStore(Integer id) {
        DataBaseinfo dataBaseinfo;
        if (!redisTemplate.hasKey("dataBaseinfo_Json")) {
            dataBaseinfo = dataBaseinfoMapper.selectByPrimaryKey(id);
            String beanToJson = FastJsonUtils.getBeanToJson(dataBaseinfo);
            redisTemplate.opsForValue().set("dataBaseinfo_Json", beanToJson);
        }
        Object result = redisTemplate.opsForValue().get("dataBaseinfo_Json");
        dataBaseinfo = FastJsonUtils.getJsonToBean(result.toString(), DataBaseinfo.class);
        return dataBaseinfo;
    }

    @Override
    public int batchInsert(List<DataBaseinfo> list) {
        return dataBaseinfoMapper.batchInsert(list);
    }

}
