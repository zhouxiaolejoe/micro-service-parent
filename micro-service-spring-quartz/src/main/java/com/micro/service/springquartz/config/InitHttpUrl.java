package com.micro.service.springquartz.config;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.ApplicationListener;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.event.ContextRefreshedEvent;

import java.io.*;

/**
 * @ClassName InitHttpUrl
 * @Description TODO
 * @Author zxl
 * @Date 2020/10/30 16:31
 * @Version 1.0.0
 */
@Configuration
public class InitHttpUrl implements ApplicationListener<ContextRefreshedEvent> {
    private static final Logger log = LoggerFactory.getLogger(InitHttpUrl.class);
    @Value("${log.fileName}")
    private String fileName;
    @Value("${request.url}")
    private String requestUrl;

    public InitHttpUrl() {
    }
    @Override
    public void onApplicationEvent(ContextRefreshedEvent contextRefreshedEvent) {
        String[] sz = this.fileName.split("/");
        String local = this.fileName.replace(sz[sz.length - 1], "");
        String path = local + "url.txt";
        File file = new File(path);
        PrintStream ps = null;
        FileOutputStream os = null;

        try {
            os = new FileOutputStream(file);
            ps = new PrintStream(os);
            ps.println(this.requestUrl);
        } catch (FileNotFoundException var17) {
            log.error("写入url文件失败" + var17.getMessage());
        } finally {
            if (os != null) {
                try {
                    os.close();
                } catch (IOException var16) {
                    var16.printStackTrace();
                }
            }

            if (ps != null) {
                ps.close();
            }

        }

    }
}

