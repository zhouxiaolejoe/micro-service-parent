package com.micro.service.springsecurity;

import com.micro.service.springsecurity.test111.entity.EleCatalogPO;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import com.micro.service.springsecurity.test111.mapper.EleCatalogMapper;
import test111.entity.BaTrBgtRec;
import test111.mapper.BaTrBgtRecMapper;

import java.util.List;

/**
 * @Description
 * @Project micro-service-parent
 * @Package com.micro.service.springsecurity
 * @Author zxl
 * @Date 2021-09-03 10:23
 */
@SpringBootTest
@RunWith(SpringRunner.class)
public class Test1 {

    @Autowired
    BaTrBgtRecMapper baTrBgtRecMapper;

    @Test
    public void test1(){
        List<BaTrBgtRec> baTrBgtRecs = baTrBgtRecMapper.selectByPrimaryKeyList();


        System.err.println(baTrBgtRecs);
    }
}
