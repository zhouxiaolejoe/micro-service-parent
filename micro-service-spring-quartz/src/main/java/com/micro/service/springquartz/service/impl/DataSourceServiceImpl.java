package com.micro.service.springquartz.service.impl;/**
 * @Description
 * @Project micro-service-parent
 * @Package com.micro.service.springquartz.service.impl
 * @Author Administrator
 * @Date 2020-10-13 15:29
 */

import com.github.benmanes.caffeine.cache.Cache;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
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
import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.io.*;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @ClassName DataSourceServiceImpl
 * @Description TODO
 * @Author Administrator
 * @Date 2020/10/13 15:29
 * @Version 1.0.0
 */
@Service
public class DataSourceServiceImpl implements DataSourceService {
    @Autowired
    DataSourceMapper dataSourceMapper;
    @Autowired
    DynamicDataSource dynamicDataSource;
    @Autowired
    DBChangeService changeService;
    @Autowired
    Cache<String, List<DataSourceInfo>> dataCaffeineCache;

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
        result.put("code", "1");
        result.put("msg", "sucess");
        result.put("count", pageInfo.getTotal());
        result.put("pageNO", pageNo);
        result.put("pageSize", pageSize);
        result.put("total", pageInfo.getTotal());
        result.put("data", pageInfo.getList());
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
    public void testFreemarker() {
        try {
            gen();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (TemplateException e) {
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
            int line = 500;
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

    public void gen() throws IOException, TemplateException {
        String jobClassName = "Myjob";
        Configuration cfg = new Configuration(Configuration.VERSION_2_3_22);
        cfg.setDirectoryForTemplateLoading(new File("D:\\zxl\\project\\micro-service-parent\\micro-service-spring-quartz\\src\\main\\resources\\templates"));
        cfg.setDefaultEncoding("UTF-8");
        cfg.setTemplateExceptionHandler(TemplateExceptionHandler.RETHROW_HANDLER);
        Template temp = cfg.getTemplate("job.ftl");
        Map<String, Object> root = new HashMap<String, Object>(5);
        root.put("className", jobClassName);
        File dir = new File("D:\\zxl\\project\\micro-service-parent\\micro-service-spring-quartz\\src\\main\\java\\com\\micro\\service\\springquartz\\job");
        if (!dir.exists()) {
            dir.mkdirs();
        }
        OutputStream fos = new FileOutputStream(new File(dir, jobClassName + ".java"));
        Writer out = new OutputStreamWriter(fos);
        temp.process(root, out);
        fos.flush();
        fos.close();
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
