package com.micro.service.springredis.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.micro.service.tool.until.FastJsonUtils;
import com.micro.service.tool.until.ResultPageBuilder;
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
        if (!redisTemplate.hasKey("dataBaseinfo_Hash_"+id)) {
            DataBaseinfo dataBaseinfo = dataBaseinfoMapper.selectByPrimaryKey(id);
            Map<Object, Object> beanToMap = FastJsonUtils.getBeanToMap(dataBaseinfo);
            redisTemplate.opsForHash().putAll("dataBaseinfo_Hash_"+id, beanToMap);
            return dataBaseinfo;
        }
        Map<String, String> dataBaseinfoHash = redisTemplate.opsForHash().entries("dataBaseinfo_Hash_"+id);
        return FastJsonUtils.getMapToBean(dataBaseinfoHash, DataBaseinfo.class);
    }

    @Override
    public DataBaseinfo testRedisJsonStore(Integer id) {
        DataBaseinfo dataBaseinfo;
        if (!redisTemplate.hasKey("dataBaseinfo_Bean_"+id)) {
            dataBaseinfo = dataBaseinfoMapper.selectByPrimaryKey(id);
            redisTemplate.opsForValue().set("dataBaseinfo_Bean_"+id, dataBaseinfo);
        }
        Object result = redisTemplate.opsForValue().get("dataBaseinfo_Bean_"+id);
        dataBaseinfo = FastJsonUtils.getJsonToBean(FastJsonUtils.getBeanToJson(result), DataBaseinfo.class);
        return dataBaseinfo;
    }

    @Override
    public DataBaseinfo testRedisBeanStore(Integer id) {
        DataBaseinfo dataBaseinfo;
        if (!redisTemplate.hasKey("dataBaseinfo_Json_"+id)) {
            dataBaseinfo = dataBaseinfoMapper.selectByPrimaryKey(id);
            String beanToJson = FastJsonUtils.getBeanToJson(dataBaseinfo);
            redisTemplate.opsForValue().set("dataBaseinfo_Json_"+id, beanToJson);
        }
        Object result = redisTemplate.opsForValue().get("dataBaseinfo_Json_"+id);
        dataBaseinfo = FastJsonUtils.getJsonToBean(result.toString(), DataBaseinfo.class);
        return dataBaseinfo;
    }

    @Override
    public ResultPageBuilder testPage(Integer page,Integer pageSize) {
        PageHelper.startPage(page,pageSize);
        List<DataBaseinfo> dataBaseinfos = dataBaseinfoMapper.selectAll();
        return ResultPageBuilder.success(PageInfo.of(dataBaseinfos));
    }

    @Override
    public int batchInsert(List<DataBaseinfo> list) {
        return dataBaseinfoMapper.batchInsert(list);
    }

}
