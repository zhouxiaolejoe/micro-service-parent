package com.micro.service.springquartz;

import com.micro.service.springquartz.mapper.DataSourceMapper;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;


@SpringBootTest
@RunWith(SpringRunner.class)
public class MicroServiceSpringQuartzApplicationTests {
    @Autowired
    DataSourceMapper dataSourceMapper;
    @Test
    public void contextLoads() {
        System.err.println(dataSourceMapper.get());
    }

}
