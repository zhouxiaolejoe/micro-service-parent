package com.micro.service.springredis.mapper;

import com.micro.service.springredis.model.DataBaseOne;
import com.micro.service.springredis.model.DataBaseTwo;
import com.micro.service.tool.until.*;
import com.micro.service.tool.until.api.ResultBuilder;
import com.micro.service.tool.until.beancopy.BeanCopierUtil;
import org.junit.jupiter.api.Test;

import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * @ClassName BeanCopyTest
 * @Description TODO
 * @Author zhouxiaole
 * @Date 2020/11/28 18:00
 * @Version 1.0.0
 */
public class BeanCopyTest {
    @Test
    public void insertOrUpdate() {
        DataBaseOne dataBaseOne = DataBaseOne.builder().username("joe").password("123").build();
        DataBaseTwo dataBaseTwo = DataBaseTwo.builder().build();
        BeanCopierUtil.copy(dataBaseOne,dataBaseTwo);
        JsonLogUtils.print(FastJsonUtils.getBeanToJson(dataBaseTwo));

        DataBaseTwo dataBaseTwo1 = DataBaseTwo.builder().name("joe").pwd("123").build();
        DataBaseOne dataBaseOne1 = DataBaseOne.builder()
                .username("joe")
                .password("123")
                .list(Arrays.asList("1","3","5"))
                .dataBaseTwos(Arrays.asList(dataBaseTwo1))
                .build();
        JsonLogUtils.print(FastJsonUtils.getBeanToJson(ResultBuilder.success(dataBaseOne1)));

    }


    @Test
    public void test1() {
        String s = "http://localhost:19017/micro-service-spring-redis/micro-service-spring-redis/testPage";
        String encode = Base64Util.encodeUrlSafe(s);
        System.err.println(encode);
        String decode = Base64Util.decodeUrlSafe(encode);
        System.err.println(decode);
    }

    @Test
    public void test2() {
        String url = "http://localhost:19017/micro-service-spring-redis/testRedisHashStore/1";
        String s = OkHttpUtil.get(url, null);
        JsonLogUtils.print(s);
    }
    @Test
    public void test3() {
        String url = "http://localhost:19017/micro-service-spring-redis/testRedisBeanStore";
        Map<String,String> map = new HashMap<>();
        map.put("id", "1");
        String s = OkHttpUtil.get(url, map);
        JsonLogUtils.print(s);
    }
}
