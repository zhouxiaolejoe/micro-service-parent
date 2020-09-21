package com.micro.service.springquartz;

import com.micro.service.springquartz.mapper.DataSourceMapper;
import com.micro.service.springquartz.mapper.FaspTPubmenuMapper;
import com.micro.service.springquartz.mapper.origin.OriginMapper;
import com.micro.service.springquartz.model.FaspTPubmenu;
import com.micro.service.springquartz.service.DBChangeService;
import lombok.extern.slf4j.Slf4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.List;
import java.util.Map;


@SpringBootTest
@RunWith(SpringRunner.class)
@Slf4j
public class MicroServiceSpringQuartzApplicationTests {
    @Autowired
    DataSourceMapper dataSourceMapper;
    @Autowired
    FaspTPubmenuMapper faspTPubmenuMapper;
    @Autowired
    DBChangeService dbChangeService;

    @Autowired
    OriginMapper originMapper;
    @Test
    public void contextLoads() {
        System.err.println(dataSourceMapper.get());
    }
    @Test
    public void contextLoads1() {
        try {
            dbChangeService.changeDb("bas");
        } catch (Exception e) {
            e.printStackTrace();
        }
        FaspTPubmenu bdm099004 = faspTPubmenuMapper.selectOneByGuid("bdm099004");
        System.err.println(bdm099004);
        try {
            dbChangeService.changeDb("bgt");
        } catch (Exception e) {
            e.printStackTrace();
        }
        FaspTPubmenu bdm08E4267A420 = faspTPubmenuMapper.selectOneByGuid("08E4267A420B464DB88CE192828232C0");
        System.err.println(bdm08E4267A420);

        System.err.println(bdm099004);
        try {
            dbChangeService.changeDb("pm");
        } catch (Exception e) {
            e.printStackTrace();
        }
        FaspTPubmenu bdm099013 = faspTPubmenuMapper.selectOneByGuid("bdm099013");
        System.err.println(bdm099013);


    }
    public static final String DEFAULT_DBVERSION = "20000101000000";

    @Test
    public void contextLoads2() {
        try {
            dbChangeService.changeDb("bas");
        } catch (Exception e) {
            e.printStackTrace();
        }
        List<Map<String, Object>> maps = originMapper.queryTableDataByDBVersion("FASP_T_DICDS", DEFAULT_DBVERSION);
        log.info(maps.toString());
        while (true){}
    }
}
