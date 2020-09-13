package com.micro.service.springredis.mapper;

import com.micro.service.springredis.MicroServiceSpringRedisApplicationTests;
import com.micro.service.springredis.model.DataBaseinfo;
import com.micro.service.tool.untils.FastJsonUtils;
import lombok.extern.slf4j.Slf4j;
import org.junit.Assert;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;

import java.text.ParseException;
import java.util.Date;
import java.util.Map;

/**
 * @Description
 * @Project micro-service-parent
 * @Package com.micro.service.springredis.mapper
 * @Author zhouxiaole
 * @Date 2020-09-13 12:07
 */

@Slf4j
public class DataBaseinfoMapperTest extends MicroServiceSpringRedisApplicationTests {
    @Autowired
    DataBaseinfoMapper dataBaseinfoMapper;
    @Autowired
    RedisTemplate redisTemplate;

    @Test
    public void deleteByPrimaryKey() {
    }

    @Test
    public void insert() {
        DataBaseinfo dataBaseinfo = DataBaseinfo.builder()
                .createtime(new Date())
                .createuser("joe")
                .databasetype(1)
                .datasourceid("oracle")
                .dbversion(new Date())
                .driverclassname("com.mysql.jdbc.Driver")
                .isdelete(1)
                .password("123456")
                .updatetime(new Date())
                .updateuser("joe")
                .url("jdbc:mysql://192.168.3.10:3306/test")
                .username("joe")
                .guid(1)
                .build();
        int result = dataBaseinfoMapper.insert(dataBaseinfo);
        Assert.assertEquals("插入失败", result, 1);
    }

    @Test
    public void insertOrUpdate() {

    }

    /**
     * redis 存 Json
     */
    @Test
    public void testRedisJsonStore() {
        DataBaseinfo dataBaseinfo;
        if (!redisTemplate.hasKey("dataBaseinfo_Json")) {
            dataBaseinfo = dataBaseinfoMapper.selectByPrimaryKey(1);
            String beanToJson = FastJsonUtils.getBeanToJson(dataBaseinfo);
            redisTemplate.opsForValue().set("dataBaseinfo_Json", beanToJson);
        }
        Object result = redisTemplate.opsForValue().get("dataBaseinfo_Json");
        dataBaseinfo = FastJsonUtils.getJsonToBean(result.toString(), DataBaseinfo.class);
        log.warn(dataBaseinfo.toString());
    }

    /**
     * redis 存 Bean
     */
    @Test
    public void testRedisBeanStore() {
        DataBaseinfo dataBaseinfo;
        if (!redisTemplate.hasKey("dataBaseinfo_Bean")) {
            dataBaseinfo = dataBaseinfoMapper.selectByPrimaryKey(1);
            redisTemplate.opsForValue().set("dataBaseinfo_Bean", dataBaseinfo);
        }
        Object result = redisTemplate.opsForValue().get("dataBaseinfo_Bean");
        dataBaseinfo = FastJsonUtils.getJsonToBean(FastJsonUtils.getBeanToJson(result), DataBaseinfo.class);
        log.warn(dataBaseinfo.toString());
    }

    /**
     * redis 存 Hash
     */
    @Test
    public void testRedisHashStore() throws Exception {
        DataBaseinfo dataBaseinfo;
        if (!redisTemplate.hasKey("dataBaseinfo_Hash")) {
            dataBaseinfo = dataBaseinfoMapper.selectByPrimaryKey(1);
            Map<Object, Object> beanToMap = FastJsonUtils.getBeanToMap(dataBaseinfo);
            redisTemplate.opsForHash().putAll("dataBaseinfo_Hash", beanToMap);
        }
        Map<String, String> dataBaseinfoHash = redisTemplate.opsForHash().entries("dataBaseinfo_Hash");
        dataBaseinfo = FastJsonUtils.getMapToBean(dataBaseinfoHash, DataBaseinfo.class);
        log.warn(dataBaseinfo.toString());
    }

    @Test
    public void insertOrUpdateSelective() throws ParseException {


    }

    @Test
    public void insertSelective() {
    }

    @Test
    public void selectByPrimaryKey() {
    }

    @Test
    public void updateByPrimaryKeySelective() {
    }

    @Test
    public void updateByPrimaryKey() {
    }

    @Test
    public void updateBatch() {
    }

    @Test
    public void updateBatchSelective() {
    }

    @Test
    public void batchInsert() {
    }
}