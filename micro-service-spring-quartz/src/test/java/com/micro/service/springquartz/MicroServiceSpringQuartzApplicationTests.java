package com.micro.service.springquartz;

import com.google.common.collect.Maps;
import com.micro.service.springquartz.mapper.DataSourceMapper;
import com.micro.service.springquartz.mapper.FaspTPubmenuMapper;
import com.micro.service.springquartz.mapper.origin.OriginMapper;
import com.micro.service.springquartz.mapper.target.SyncDicDSMapper;
import com.micro.service.springquartz.model.FaspTPubmenu;
import com.micro.service.springquartz.service.DBChangeService;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import sun.misc.BASE64Encoder;

import java.lang.reflect.Method;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;


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
    @Autowired
    SyncDicDSMapper syncDicDSMapper;

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

    @SneakyThrows
    @Test
    public void contextLoads2() {
        dbChangeService.changeDb("bas");
        List<Map<String, Object>> lists = originMapper.queryTableDataByDBVersion("FASP_T_DICDS", DEFAULT_DBVERSION);
        lists=lists.stream().filter(x->{
            String dbversion = getStringValue(x.get("DBVERSION"));
            x.put("DBVERSION",dbversion);
            return true;
        }).collect(Collectors.toList());
        dbChangeService.changeDb("bgt");
        Map<String, Object> map = Maps.newHashMap();
        map.put("list",lists);
        syncDicDSMapper.batchInsertDicds(map);
        log.info(lists.toString());
//        while (true) {
//        }
    }


    private String getStringValue(Object obj) {
        if(null == obj){
            return "";
        }else if(obj instanceof  byte[]){
            return new BASE64Encoder().encode((byte[])obj);
        }else if(obj instanceof oracle.sql.TIMESTAMP){
            Timestamp timestamp = getOracleTimestamp(obj);
            String time = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(timestamp);
            return time;
        }
        return obj.toString();
    }
    private Timestamp getOracleTimestamp(Object value){
        try{
            Class clz = value.getClass();
            Method method = clz.getMethod("timestampValue",null);
            return (Timestamp)method.invoke(value,null);
        }catch(Exception ex){
            ex.printStackTrace();
            return null;
        }
    }

}
