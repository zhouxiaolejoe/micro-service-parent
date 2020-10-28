package com.micro.service.springquartz.service.impl;


import com.github.benmanes.caffeine.cache.Cache;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.micro.service.springquartz.classload.MyClassLoader;
import com.micro.service.springquartz.config.DynamicDataSource;
import com.micro.service.springquartz.mapper.DataSourceMapper;
import com.micro.service.springquartz.model.DataSourceInfo;
import com.micro.service.springquartz.service.DBChangeService;
import com.micro.service.springquartz.service.DataSourceService;
import com.micro.service.springquartz.utils.ResultBuilder;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import freemarker.template.TemplateExceptionHandler;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.io.FileUtils;
import org.quartz.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.beans.factory.support.BeanDefinitionRegistry;
import org.springframework.beans.factory.support.DefaultListableBeanFactory;
import org.springframework.beans.factory.support.RootBeanDefinition;
import org.springframework.context.ApplicationContext;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Service;
import org.springframework.util.ClassUtils;
import org.springframework.util.CollectionUtils;

import javax.tools.JavaCompiler;
import java.io.*;
import java.net.URL;
import java.net.URLClassLoader;
import java.nio.file.FileSystems;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * @ClassName DataSourceServiceImpl
 * @Description TODO
 * @Author zxl
 * @Date 2020/10/13 15:29
 * @Version 1.0.0
 */
@Service
@Slf4j
public class DataSourceServiceImpl implements DataSourceService {
    @Autowired
    DataSourceMapper dataSourceMapper;
    @Autowired
    DynamicDataSource dynamicDataSource;
    @Autowired
    DBChangeService changeService;
    @Autowired
    Cache<String, List<DataSourceInfo>> dataCaffeineCache;
    @Autowired
    Scheduler scheduler;

    @Autowired
    ApplicationContext applicationContext;

    /**
     * 获取日志文件生成位置
     */
    @Value("${log.fileName}")
    private String fileName;

    @Override
    public Map<String, Object> get(Integer pageNo, Integer pageSize) {
        try {
            changeService.changeDb("mainDataSource");
        } catch (Exception e) {
            e.printStackTrace();
        }
        PageHelper.startPage(pageNo, pageSize);
        List<DataSourceInfo> dataSourceInfos = dataSourceMapper.get();
        PageInfo<DataSourceInfo> pageInfo = PageInfo.of(dataSourceInfos);
        Map<String, Object> result = new HashMap<>();
        List<DataSourceInfo> list = pageInfo.getList().stream().map(x -> {
            x.setPassword(null);
            return x;
        }).collect(Collectors.toList());
        result.put("code", "1");
        result.put("msg", "sucess");
        result.put("count", pageInfo.getTotal());
        result.put("pageNO", pageNo);
        result.put("pageSize", pageSize);
        result.put("total", pageInfo.getTotal());
        result.put("data", list);
        return result;
    }

    @Override
    public int insertDatasourceInfo(DataSourceInfo dataSourceInfo) {
        int flag = 0;
        try {

            changeService.changeDb("mainDataSource");
            flag = dataSourceMapper.insertDatasourceInfo(dataSourceInfo);
            List<DataSourceInfo> dataSourcesList = dataCaffeineCache.asMap().get("dataSourceInfos");
            if (!CollectionUtils.isEmpty(dataSourcesList)) {
                dataSourcesList = dataSourceMapper.get();
                dataSourcesList.add(dataSourceInfo);
                dataCaffeineCache.asMap().put("dataSourceInfos", dataSourcesList);
            }
            changeService.changeDb(dataSourceInfo.getDatasourceid());
        } catch (Exception e) {
            e.printStackTrace();
        }

        return flag;
    }

    @Override
    public void testFreemarker(String jobClassName) throws IOException, TemplateException {
        Class<?> jobClazz = gen(jobClassName);
        boolean b = applicationContext.containsBean("com.micro.service.springquartz.job.MyJob");
        System.err.println(b);
        JobDetail job = JobBuilder
                .newJob((Class<? extends Job>) jobClazz)
                .withIdentity(jobClassName, jobClassName)
                .withDescription(jobClassName)
                .build();


        String cronExpression = "0/5 * * * * ? ";
        Trigger trigger = TriggerBuilder
                .newTrigger()
                .withDescription(jobClassName)
                .startAt(DateBuilder.futureDate(2, DateBuilder.IntervalUnit.SECOND))
                .withIdentity(jobClassName, jobClassName)
                .withSchedule(CronScheduleBuilder
                        .cronSchedule(cronExpression)
                        .withMisfireHandlingInstructionDoNothing())
                .build();
        try {
            this.scheduler.scheduleJob(job, trigger);
        } catch (SchedulerException e) {
            e.printStackTrace();
        }
    }

    @Override
    public ResultBuilder readLogFile() {
        File file = new File(fileName);
        BufferedReader reader = null;
        StringBuffer sbf = new StringBuffer();
        try {

            LineNumberReader lnr = new LineNumberReader(new FileReader(file));
            lnr.skip(Long.MAX_VALUE);
            int lineNumber = lnr.getLineNumber();


            reader = new BufferedReader(new FileReader(file));
            String tempStr;
            int line = 1000;
            if (lineNumber < line) {
                while ((tempStr = reader.readLine()) != null) {
                    sbf.append(tempStr);
                    sbf.append("</br>");
                }
            } else {
                int count = 1;
                while ((tempStr = reader.readLine()) != null) {
                    if (count > (lineNumber - line)) {
                        sbf.append(tempStr);
                        sbf.append("</br>");
                    }
                    count++;
                }
            }
            reader.close();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (reader != null) {
                try {
                    reader.close();
                } catch (IOException e1) {
                    e1.printStackTrace();
                }
            }
        }
        return ResultBuilder.success(sbf);
    }

    public Class<?> gen(String jobClassName) {
        Configuration cfg = new Configuration(Configuration.VERSION_2_3_22);
        String[] sz = fileName.split("/");
        String soundcode = fileName.replace(sz[sz.length - 1], "soundcode/");
        /**
         * 获取classpath下的模板
         */
        cfg.setClassForTemplateLoading(this.getClass(), "/templates");
        cfg.setDefaultEncoding("UTF-8");
        cfg.setTemplateExceptionHandler(TemplateExceptionHandler.RETHROW_HANDLER);
        JavaCompiler compiler = null;
        OutputStream fos = null;
        Writer out = null;
        Map<String, Object> root = new HashMap<String, Object>(1);
        root.put("className", jobClassName);
        String fileName = jobClassName + ".java";
        String createFilePath = soundcode + fileName;
        File file = null;
        try {
            Template temp = cfg.getTemplate("job.ftl");
            file = existsFile(soundcode, fileName);
            fos = new FileOutputStream(file);
            out = new OutputStreamWriter(fos);
            temp.process(root, out);
            fos.flush();
            compiler = getJavaCompiler();
            compiler.run(null, null, null, createFilePath);

            MyClassLoader myClassLoader = new MyClassLoader();
            myClassLoader.setClassPath(soundcode + jobClassName + ".class");
            String fullPathName = "com.micro.service.springquartz.job." + jobClassName;
            Class<?> clazz = ClassUtils.forName(fullPathName, myClassLoader);
            BeanDefinitionRegistry beanDefinitionRegistry = (DefaultListableBeanFactory) applicationContext.getAutowireCapableBeanFactory();
            boolean beanDef = applicationContext.containsBean(fullPathName);
            if (!beanDef) {
                RootBeanDefinition beanDefinition = new RootBeanDefinition(clazz);
                beanDefinitionRegistry.registerBeanDefinition(fullPathName, beanDefinition);
            }
            return clazz;
        } catch (Exception e) {
            log.error(e.getMessage());
        } finally {
            if (out != null) {
                try {
                    out.close();
                } catch (IOException ioException) {
                    ioException.printStackTrace();
                }
            }
            if (fos != null) {
                try {
                    fos.close();
                } catch (IOException ioException) {
                    ioException.printStackTrace();
                }
            }
//            file.delete();
        }
        return null;
    }

    public JavaCompiler getJavaCompiler() throws Exception {
        String[] sz = fileName.split("/");
        String basPath = fileName.replace(sz[sz.length - 1], "tool/");
        ClassPathResource classPathResource = new ClassPathResource("lib/tools.jar");
        InputStream inputStream = classPathResource.getInputStream();
        Path filePath = FileSystems.getDefault().getPath(basPath + "tools.jar");
        File file = filePath.toFile();
        if (!file.exists()) {
            String parent = file.getParent();
            new File(parent).mkdir();
            Files.createFile(filePath);
        }
        if (file.length() <= 0) {
            FileUtils.copyInputStreamToFile(inputStream, file);
        }
        String p = file.getAbsolutePath();
        URL[] urls = new URL[]{new URL("file:/" + p)};
        URLClassLoader urlClassLoader = new URLClassLoader(urls, Thread.currentThread().getContextClassLoader());
        Class<?> javacToolClass = urlClassLoader.loadClass("com.sun.tools.javac.api.JavacTool");
        JavaCompiler compiler = javacToolClass.asSubclass(JavaCompiler.class).asSubclass(JavaCompiler.class).newInstance();
        return compiler;
    }

    private File existsFile(String path, String fileName) throws IOException {
        File path1 = new File(path);
        File fileName1 = new File(path + fileName);
        if (!path1.exists()) {
            path1.mkdirs();
        }

        if (!fileName1.exists()) {
            fileName1.createNewFile();
        }
        return fileName1;
    }


    @Override
    public int deleteDataSourceByDatasourceId(String datasourceId) {
        int flag = 0;
        try {
            changeService.changeDb("mainDataSource");
            flag = dataSourceMapper.deleteDataSourceByDatasourceId(datasourceId);
            List<DataSourceInfo> dataSourcesList = dataCaffeineCache.asMap().get("dataSourceInfos");
            if (!CollectionUtils.isEmpty(dataSourcesList)) {
                dataSourcesList = dataSourceMapper.get();
                dataSourcesList.remove(datasourceId);
                dataCaffeineCache.asMap().put("dataSourceInfos", dataSourcesList);
            }
            changeService.deleteDb(datasourceId);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return flag;
    }
}
