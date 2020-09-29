package com.micro.service.springquartz;

import com.micro.service.springquartz.config.fasp3client.FaspClientSetting;
import com.micro.service.springquartz.config.fasp3client.FaspDic3ClientSetting;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.quartz.QuartzDataSource;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Primary;

import javax.sql.DataSource;

/**
 * @author Administrator
 */
@SpringBootApplication
@MapperScan(basePackages = {"com.micro.service.springquartz.mapper"})
@EnableFeignClients(basePackages = "com.micro.service.springquartz.clientapi")
@EnableConfigurationProperties(value = {FaspDic3ClientSetting.class, FaspClientSetting.class})
public class MicroServiceSpringQuartzApplication {
    public static void main(String[] args) {
        SpringApplication.run(MicroServiceSpringQuartzApplication.class, args);
    }
    /**
     * @Description 配置quartz单独数据源
     * @Method dataSource
     * @return javax.sql.DataSource
     * @Author ZhouXiaoLe
     * @Date  2019-07-30  14:20:24
     **/
    @QuartzDataSource
    @ConfigurationProperties("spring.quartz.properties.org.quartz.datasource")
    @Bean
    public DataSource myQuartzDataSource(){
        return DataSourceBuilder.create().build();
    }
}
