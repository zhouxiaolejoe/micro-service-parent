package com.micro.service.springquartz.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * @ClassName FileWebConfig
 * @Description TODO
 * @Author zxl
 * @Date 2020/10/30 16:32
 * @Version 1.0.0
 */
@Configuration
public class FileWebConfig implements WebMvcConfigurer {
    @Value("${log.fileName}")
    private String fileName;

    public FileWebConfig() {
    }
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        String[] sz = this.fileName.split("/");
        String local = this.fileName.replace(sz[sz.length - 1], "");
        registry.addResourceHandler(new String[]{"/file/**"}).addResourceLocations(new String[]{"file:" + local});
    }
}
