package com.micro.service.springquartz;

import com.google.common.base.Charsets;
import com.google.common.collect.Maps;
import com.google.common.io.Files;
import com.micro.service.springquartz.mapper.DataSourceMapper;
import com.micro.service.springquartz.mapper.FaspTPubmenuMapper;
import com.micro.service.springquartz.mapper.origin.OriginMapper;
import com.micro.service.springquartz.mapper.target.SyncDicDSMapper;
import com.micro.service.springquartz.mapper.target.SyncMenuMapper;
import com.micro.service.springquartz.model.ClientApiRoleMenuRestDTO;
import com.micro.service.springquartz.model.ClientApiRoleUserRestDTO;
import com.micro.service.springquartz.model.DataSourceInfo;
import com.micro.service.springquartz.model.FaspTPubmenu;
import com.micro.service.springquartz.service.DBChangeService;
import com.sun.javafx.binding.StringFormatter;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import freemarker.template.TemplateExceptionHandler;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.io.FileUtils;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.DefaultResourceLoader;
import org.springframework.core.io.Resource;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.util.ClassUtils;
import org.springframework.util.FileCopyUtils;
import org.springframework.util.ResourceUtils;
import sun.misc.BASE64Encoder;

import javax.tools.JavaCompiler;
import javax.tools.ToolProvider;
import java.io.*;
import java.lang.reflect.Method;
import java.net.URL;
import java.nio.charset.Charset;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.HashMap;
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

    @Autowired
    SyncMenuMapper syncMenuMapper;

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
        lists = lists.stream().filter(x -> {
            String dbversion = getStringValue(x.get("DBVERSION"));
            x.put("DBVERSION", dbversion);
            return true;
        }).collect(Collectors.toList());
        dbChangeService.changeDb("bgt");
        Map<String, Object> map = Maps.newHashMap();
        map.put("list", lists);
        syncDicDSMapper.batchInsertDicds(map);
        log.info(lists.toString());
//        while (true) {
//        }
    }


    private String getStringValue(Object obj) {
        if (null == obj) {
            return "";
        } else if (obj instanceof byte[]) {
            return new BASE64Encoder().encode((byte[]) obj);
        } else if (obj instanceof oracle.sql.TIMESTAMP) {
            Timestamp timestamp = getOracleTimestamp(obj);
            String time = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(timestamp);
            return time;
        }
        return obj.toString();
    }

    private Timestamp getOracleTimestamp(Object value) {
        try {
            Class clz = value.getClass();
            Method method = clz.getMethod("timestampValue", null);
            return (Timestamp) method.invoke(value, null);
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        }
    }


    @SneakyThrows
    @Test
    public void contextLoads3() {
        dbChangeService.changeDb("bas");
        List<Map<String, Object>> maps = syncMenuMapper.selectAllByGuid("6ACFE90E112125AFD103F863EA90298C");
        dbChangeService.changeDb("pm");
        for (Map<String, Object> map : maps) {
            Integer integer = syncMenuMapper.insertMenuData(map);
        }


    }


    @SneakyThrows
    @Test
    public void contextLoads5() {
        dbChangeService.changeDb("bas");
        List<Map<String, Object>> maps = originMapper.selectTableColumn("FASP_T_PUPVD03001");
        for (Map<String, Object> map : maps) {
            log.info(map.toString());
        }
    }


    @SneakyThrows
    @Test
    public void contextLoads6() {
//        dbChangeService.changeDb("bas");
//        List<ClientApiRoleMenuRestDTO> clientApiRoleMenuRestDTOS = originMapper.queryRoleMenuMapping("077986F17DAB5E21E050007F010012CA");
//        List<ClientApiRoleUserRestDTO> clientApiRoleUserRestDTOS = originMapper.queryUserRolemapping("ADEC3390885DAB60E05308031323BD9E");
//        System.err.println(clientApiRoleMenuRestDTOS);
//        System.err.println(clientApiRoleUserRestDTOS);
        dbChangeService.changeDb("quartz");
//        DataSourceInfo dataSourceInfo = new DataSourceInfo();
//        dataSourceInfo.setBusinesname("测试1");
//        dataSourceInfo.setUrl("1");
//        dataSourceInfo.setDatasourceId("2");
//        dataSourceInfo.setUserName("1");
//        dataSourceInfo.setPassWord("1");
//        dataSourceMapper.insertDatasourceInfo(dataSourceInfo);
        List<DataSourceInfo> dataSourceInfos = dataSourceMapper.get();
//        dataSourceMapper.deleteDataSourceByDatasourceId("2");
        System.err.println(dataSourceInfos);
    }

    @Test
    public void test10() {
        String path = this.getClass().getResource("").getPath().substring(1);
        System.out.println(path);

        System.err.println(System.getProperty("user.dir"));

    }

    @Test
    public void test11() throws Exception {
        String locationPath = ClassUtils.getDefaultClassLoader().getResource("").getPath().substring(1);
        System.err.println(locationPath);
        File file = ResourceUtils.getFile("classpath:templates/test.ftl");
        List<String> list = Files.readLines(file, Charsets.UTF_8);
        list.stream().forEach(x -> System.err.println(x));
    }

    @Test
    public void gen() throws IOException, TemplateException {
        String jobClassName = "Myjob";
        Configuration cfg = new Configuration(Configuration.VERSION_2_3_22);
        /**
         * 获取classpath下的模板
         */
        cfg.setClassForTemplateLoading(this.getClass(),"/templates");
        cfg.setDefaultEncoding("UTF-8");
        cfg.setTemplateExceptionHandler(TemplateExceptionHandler.RETHROW_HANDLER);
        Template temp = cfg.getTemplate("test.ftl");
        Map<String, Object> root = new HashMap<String, Object>(5);
        root.put("className", jobClassName);
        File writePath = ResourceUtils.getFile("D:/var/logs/pushdata/");
        String javaName = "\\" + jobClassName + ".java";
        String path = writePath + javaName;
        new File(path);
        OutputStream fos = new FileOutputStream(path);
        Writer out = new OutputStreamWriter(fos);
        temp.process(root, out);
        fos.flush();
        fos.close();
        JavaCompiler compiler = ToolProvider.getSystemJavaCompiler();
        int compilationResult = compiler.run(null, null, null, path);
        try {
            Class clz = Class.forName("com.micro.service.springquartz.job."+jobClassName);
            Object o = clz.newInstance();
            Method method = clz.getDeclaredMethod("sayHello");
            String result = (String) method.invoke(o);
            System.out.println(result);
        } catch (Exception e) {

        }
    }

    @Test
    public void gen2() throws IOException, TemplateException {
        ClassPathResource classPathResource = new ClassPathResource("lib");
        InputStream inputStream = classPathResource.getInputStream();
        File somethingFile = File.createTempFile("tools", ".jar");
        FileUtils.copyInputStreamToFile(inputStream, somethingFile);
        System.err.println(somethingFile);
//
//
//
//        File fileDir = new File("src/main/resources/templates/test.ftl");
//        List<String> strings = Files.readLines(fileDir, Charsets.UTF_8);
//        System.err.println(strings);


    }
}
