package com.micro.service.springredis.mapper;

import com.micro.service.springredis.model.DataBaseOne;
import com.micro.service.springredis.model.DataBaseTwo;
import com.micro.service.tool.untils.FastJsonUtils;
import com.micro.service.tool.untils.JsonLogUtils;
import com.micro.service.tool.untils.beancopy.BeanCopierUtil;
import org.junit.jupiter.api.Test;

import java.util.Arrays;

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
        JsonLogUtils.print(FastJsonUtils.getBeanToJson(dataBaseOne1));

    }
}
