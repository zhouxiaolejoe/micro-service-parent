package com.micro.service.springredis.mapper;

import com.micro.service.springredis.model.DataBaseOne;
import com.micro.service.springredis.model.DataBaseTwo;
import com.micro.service.tool.untils.beans.BeanCopierUtil;
import com.micro.service.tool.untils.beans.BladeBeanCopier;
import org.junit.jupiter.api.Test;

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
        System.err.println(dataBaseTwo);

    }
}
